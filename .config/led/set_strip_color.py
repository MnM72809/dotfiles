#!/usr/bin/env python3
"""Standalone set-strip-color script.

Inlines a minimal .env loader and a tiny `tinytuya`-based device creator so
this file does not depend on other repository modules. Requires the
`tinytuya` package to actually send commands to a Tuya device.
"""

from __future__ import annotations

import argparse
import colorsys
import json
import os
from dataclasses import dataclass
from pathlib import Path

try:
    import tinytuya
except Exception:  # pragma: no cover - helpful runtime message
    tinytuya = None


ENV_FILENAME = ".env"


def load_env_file(env_path: Path | None = None) -> None:
    path = env_path or Path(__file__).resolve().with_name(ENV_FILENAME)
    if not path.exists():
        return

    with path.open("r", encoding="utf-8") as handle:
        for raw_line in handle:
            line = raw_line.strip()
            if not line or line.startswith("#"):
                continue
            if line.startswith("export "):
                line = line[len("export ") :].strip()
            if "=" not in line:
                continue

            key, value = line.split("=", 1)
            key = key.strip()
            value = value.strip()

            if len(value) >= 2 and value[0] == value[-1] and value[0] in {'"', "'"}:
                value = value[1:-1]

            if key:
                os.environ.setdefault(key, value)


def get_env_value(name: str, default: str | None = None) -> str | None:
    load_env_file()
    return os.environ.get(name, default)


@dataclass(frozen=True)
class TuyaConfig:
    device_id: str
    device_ip: str
    local_key: str
    version: float


def create_device(config: TuyaConfig | None = None):
    if tinytuya is None:
        raise SystemExit(
            "tinytuya is required to talk to Tuya devices. Install with: pip install tinytuya"
        )

    resolved = config or TuyaConfig(
        device_id=get_env_value("TUYA_DEVICE_ID", "") or "",
        device_ip=get_env_value("TUYA_DEVICE_IP", "") or "",
        local_key=get_env_value("TUYA_LOCAL_KEY", "") or "",
        version=float(get_env_value("TUYA_VERSION", "3.3") or "3.3"),
    )
    device = tinytuya.OutletDevice(resolved.device_id, resolved.device_ip, resolved.local_key)
    device.set_version(resolved.version)
    return device


DEFAULT_ID = get_env_value("TUYA_DEVICE_ID", "bfab7d5c33314c9796c9p6")
DEFAULT_IP = get_env_value("TUYA_DEVICE_IP", "192.168.1.46")
DEFAULT_KEY = get_env_value("TUYA_LOCAL_KEY", "Z}qPPDG9BBsG|6NS")
DEFAULT_VERSION = get_env_value("TUYA_VERSION", "3.3")


def _clamp(value: float, minimum: float, maximum: float) -> float:
    return max(minimum, min(maximum, value))


def _to_dps24_hex_from_hsv(hue_deg: float, saturation_pct: float, value_pct: float) -> str:
    h = int(round(_clamp(hue_deg, 0.0, 360.0)))
    s = int(round(_clamp(saturation_pct, 0.0, 100.0) * 10.0))
    v = int(round(_clamp(value_pct, 0.0, 100.0) * 10.0))
    return f"{h:04x}{s:04x}{v:04x}"


def _to_dps24_hex_from_rgb(r: int, g: int, b: int) -> str:
    for name, value in (("r", r), ("g", g), ("b", b)):
        if value < 0 or value > 255:
            raise ValueError(f"{name} must be in [0, 255], got {value}")

    h, s, v = colorsys.rgb_to_hsv(r / 255.0, g / 255.0, b / 255.0)
    return _to_dps24_hex_from_hsv(h * 360.0, s * 100.0, v * 100.0)


def _to_dps24_hex_from_hsl(
    hue_deg: float,
    saturation_pct: float,
    lightness_pct: float,
    min_v_pct: float = 90.0,
) -> str:
    h_deg = _clamp(hue_deg, 0.0, 360.0)
    s_l = _clamp(saturation_pct, 0.0, 100.0) / 100.0
    l = _clamp(lightness_pct, 0.0, 100.0) / 100.0

    v = l + s_l * min(l, 1.0 - l)
    if v <= 0.0:
        s_v = 0.0
    else:
        s_v = 2.0 * (1.0 - (l / v))

    min_v_pct = _clamp(min_v_pct, 0.0, 100.0)
    bright_v_pct = _clamp(max(v * 100.0, min_v_pct), min_v_pct, 100.0)
    return _to_dps24_hex_from_hsv(h_deg, s_v * 100.0, bright_v_pct)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Set whole-strip color using DPS 24 (Tuya colour string) and optionally set DPS 22 brightness."
        )
    )

    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument(
        "--rgb",
        nargs=3,
        type=int,
        metavar=("R", "G", "B"),
        help="RGB values in [0,255], converted to DPS 24.",
    )
    mode.add_argument(
        "--hsv",
        nargs=3,
        type=float,
        metavar=("H", "S", "V"),
        help="HSV values as degrees/percent: H[0..360] S[0..100] V[0..100].",
    )
    mode.add_argument(
        "--hsl",
        nargs=3,
        type=float,
        metavar=("H", "S", "L"),
        help=(
            "HSL values as degrees/percent: H[0..360] S[0..100] L[0..100]. Converted to HSV"
            " with V forced to >= 90."
        ),
    )
    mode.add_argument(
        "--dps24",
        help="Raw DPS 24 value as 12 hex chars (HHHHSSSSVVVV), e.g. 000f02c603e0.",
    )

    parser.add_argument(
        "--brightness22",
        type=int,
        help="Optional DPS 22 integer brightness (typically 10..1000).",
    )
    parser.add_argument(
        "--set-colour-mode",
        action="store_true",
        help="Also set DPS 21 to 'colour' before applying DPS 24.",
    )
    parser.add_argument(
        "--hsl-min-v",
        type=float,
        default=90.0,
        help="Minimum HSV V %% used for --hsl conversion (default: 90, range: 0..100).",
    )

    parser.add_argument("--id", default=DEFAULT_ID, help=f"Device ID (default: {DEFAULT_ID})")
    parser.add_argument("--ip", default=DEFAULT_IP, help=f"Device IP (default: {DEFAULT_IP})")
    parser.add_argument("--key", default=DEFAULT_KEY, help=f"Device Local Key (default: {DEFAULT_KEY})")
    parser.add_argument(
        "--version",
        default=DEFAULT_VERSION,
        help=f"Device protocol version (default: {DEFAULT_VERSION})",
    )

    return parser.parse_args()


def resolve_dps24(args: argparse.Namespace) -> str:
    if args.rgb is not None:
        r, g, b = args.rgb
        return _to_dps24_hex_from_rgb(r, g, b)

    if args.hsv is not None:
        h, s, v = args.hsv
        return _to_dps24_hex_from_hsv(h, s, v)

    if args.hsl is not None:
        h, s, l = args.hsl
        return _to_dps24_hex_from_hsl(h, s, l, args.hsl_min_v)

    raw = (args.dps24 or "").strip().lower()
    if len(raw) != 12:
        raise ValueError(f"--dps24 must be exactly 12 hex chars, got '{args.dps24}'")
    int(raw, 16)
    return raw


def main() -> None:
    args = parse_args()
    dps24_value = resolve_dps24(args)

    if args.brightness22 is not None and not (0 <= args.brightness22 <= 1000):
        raise SystemExit("--brightness22 must be in [0, 1000]")

    cfg = TuyaConfig(
        device_id=args.id or "",
        device_ip=args.ip or "",
        local_key=args.key or "",
        version=float(args.version),
    )
    device = create_device(cfg)

    before = device.status()

    if args.set_colour_mode:
        device.set_value(21, "colour")

    device.set_value(24, dps24_value)

    if args.brightness22 is not None:
        device.set_value(22, args.brightness22)

    after = device.status()

    print(
        json.dumps(
            {
                "ok": True,
                "applied": {
                    "dps24": dps24_value,
                    "dps22": args.brightness22,
                    "set_colour_mode": args.set_colour_mode,
                },
                "status_before": before,
                "status_after": after,
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
