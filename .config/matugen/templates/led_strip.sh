#~/.local/bin/tuya-strip.sh --hsl { colors.primary.default.hue }} { colors.primary.default.saturation }} { colors.primary.default.lightness }}
#~/.config/led/tuya-strip.sh --hsl { base16.base00.default.hue }} { base16.base00.default.saturation }} 50
~/.config/led/tuya-strip.sh --hsl {{ colors.source_color.default.hue }} {{ colors.source_color.default.saturation }} 50 &



HEX_1={{ colors.source_color.default.hex | to_color | set_saturation: 100.0 }}
HEX_2={{ colors.primary.default.hex }}

DEC_1=$(( 16#${HEX_1#\#} ))
DEC_2=$(( 16#${HEX_2#\#} ))

solaar config g915 rgb_zone_2 "!LEDEffectSetting {ID: 1, color: $DEC_1, intensity: 100, period: 1, ramp: 0, speed: 0}"
solaar config g915 rgb_zone_1 "!LEDEffectSetting {ID: 1, color: $DEC_2, intensity: 100, period: 1, ramp: 0, speed: 0}"

solaar config g502 led_zone_2 "!LEDEffectSetting {ID: 10, color: $DEC_1, intensity: 100, period: 5000, ramp: 0, speed: 0}"
solaar config g502 led_zone_1 "!LEDEffectSetting {ID: 1, color: $DEC_2, intensity: 100, period: 1, ramp: 0, speed: 0}"
