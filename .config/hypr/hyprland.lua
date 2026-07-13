-- WIKI:
-- https://wiki.hypr.land/Configuring/
-- See https://wiki.hypr.land/Configuring/Keywords/

--$fileManager = thunar
--$fileManager = dolphin
--$menu = rofi -show drun
--$menu = wofi --show drun
--$menu = anyrun
--$menu = ~/.config/rofi/launchers/type-1/launcher.sh
terminal = "kitty"
fileManager = "nautilus"
menu = "rofi -show drun"
runmenu = "rofi -show run"
browser = "zen-browser"
hyprlock = "hyprlock -c /home/moriaan/.config/hypr/hyprlock.conf --grace 1"
-- reload waybar; reload kitty configuration
reload = "~/.config/waybar/scripts/launch.sh; killall -SIGUSR1 kitty; killall swayosd-server; hyprctl dispatch 'hl.dsp.exec_cmd(\"swayosd-server\")'; makoctl reload"

-- Link other conf files
require("colors")
require("hyprland.monitors")
require("hyprland.autostart")
require("hyprland.envvars")
require("hyprland.looknfeel")
require("hyprland.input")
require("hyprland.keybinds")
require("hyprland.windows")
require("hyprland.workspaces")


---------------------
---- PERMISSIONS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "ask" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprctl", type = "plugin", mode = "ask" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprlock", type = "screencopy", mode = "allow" })

hl.config({
    ecosystem = {
        enforce_permissions = 1,
    },
    -- Only enable when needed, causes performance hit
	misc = {
        disable_hyprland_logo = true,
        --disable_splash_rendering = true
        --animate_mouse_windowdragging = true
        render_unfocused_fps = 30,
        enable_swallow = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		allow_session_lock_restore = true,
    },
	debug = {
		disable_logs = false,
		--enable_stdout_logs = true,
	},
	render = {
		non_shader_cm_interop = 2,
		use_shader_blur_blend = true,
		cm_sdr_eotf = srgb,
		-- direct_scanout = 2,
		cm_auto_hdr = true,
	}
})

