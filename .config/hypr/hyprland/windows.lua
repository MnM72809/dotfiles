--------------------------------
---- WINDOW- AND LAYERRULES ----
--------------------------------

-- https://wiki.hypr.land/Configuring/Window-Rules/

-- Default rules

-- Ignore maximize requests from apps. You'll probably like this.
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})



-- Custom rules

hl.window_rule({
    name = "spotify",
    match = {
        class = "Spotify",
    },
    workspace = "special:spotify",
})

hl.window_rule({
    name = "maximized",
    match = {
        --class = ".*",
        fullscreen = 1,
    },
	border_color = "rgb(FF0000)"
})

hl.window_rule({
    name = "opacity",
    match = {
        class = ".*",
    },
    opacity = "0.88 0.78",
})

hl.window_rule({
    name = "filepicker",
    match = {
        class = "xdg-desktop-portal-gtk",
    },
    --match:title = ^(Open File|Open|Save|Save As|Export|Import|Choose File|Rename)
    float = true,
    --center = on
})

hl.window_rule({
	name = "render_halo_infinite",
	match = {
		class = "steam_app_1240440",
	},
	immediate = true,
})

hl.layer_rule({
    name = "rofi",
    match = {
        namespace = "rofi",
    },
	dim_around = true,
    animation = "popin",
})

hl.layer_rule({
    name = "osd-effects",
    match = {
        namespace = "swayosd",
    },
    blur = true,
	ignore_alpha = 0,
    animation = "slidevert",
})

hl.layer_rule({
    name = "waybar",
    match = {
        namespace = "waybar",
    },
    blur = true,
	ignore_alpha = 0,
})

