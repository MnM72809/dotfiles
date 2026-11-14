-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	-- 1. Core compositor & lock screen
	hl.exec_cmd("hyprlock -c /home/moriaan/.config/hypr/hyprlock.conf --grace 0")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprsunset")

	-- 2. Essential Daemons & UI Bars
	hl.exec_cmd("waybar")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("solaar --window=hide")
	hl.exec_cmd("kdeconnectd")

	-- 3. Clipboard Manager
	hl.exec_cmd("cliphist wipe")
	hl.exec_cmd("wl-paste --type text --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")

	-- 4. Clean Wallpaper & Matugen Initialization
	-- Choose a wallpaper with no delay
	hl.exec_cmd("/home/moriaan/.local/bin/theme_handler.sh --wallpaper --no-transition")
	-- Initialize matugen with small delay
	hl.exec_cmd("sleep 0.5 && /home/moriaan/.local/bin/theme_handler.sh --matugen")

	-- 5. Heavy Apps (Deferred by 3 seconds so boot is instant and lag-free)
	hl.exec_cmd("sleep 3 && systemctl --user start app-dev.lizardbyte.app.Sunshine.service")
	hl.exec_cmd("sleep 3 && steam -silent -minimized")
	hl.exec_cmd("sleep 3 && spicetify auto")
	hl.exec_cmd("sleep 3 && spicetify watch -s")

	-- 6. Final Focus
	hl.dsp.focus({ workspace = 1 })

	-- hl.exec_cmd("sleep 1; hyprctl dispatch 'hl.dsp.focus({ workspace = 1 })'")
	-- hl.exec_cmd("/home/moriaan/.config/hypr/toggle_hypr-cava-visualizer.sh")
end)
