return {
    image = "{{image}}",
    source_color_darkened = "0xff{{colors.source_color.default.hex | to_color | lighten: 5.0 | replace: "#", "" }}",
    ----------------------------
    ---- RGBA (0xff prefix) ----
    ----------------------------
<* for name, value in colors *>
    {{name}} = "0xff{{value.default.hex_stripped}}",<* endfor *>
    -------------------
    ---- Saturated ----
    -------------------
<* for name, value in colors *>
    {{name}}_saturated = "0xff{{ value.default.hex | to_color | set_saturation: 100.0 | replace: "#", "" }}",<* endfor *>
    ---------------------
    ---- Desaturated ----
    ---------------------
<* for name, value in colors *>
    {{name}}_desaturated = "0xff{{ value.default.hex | to_color | saturate: -50.0, "hsl" | replace: "#", "" }}",<* endfor *>
    -----------------------------
    ---- Raw hex (no prefix) ----
    -----------------------------
<* for name, value in colors *>
    {{name}}_raw = "{{value.default.hex_stripped}}",<* endfor *>
}
