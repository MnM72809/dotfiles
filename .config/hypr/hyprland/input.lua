---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Variables/#input


hl.config({
    input = {
        kb_layout = "be",
        kb_variant = "",
        kb_model = "",
        kb_options = "numpad:mac,caps:digits_row",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },

        numlock_by_default = true,
    },

	binds = {
		scroll_event_delay = 1,
	},
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
