---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Normal binds
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + KP_Enter", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.window.kill(), { long_press = true })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(reload))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(hyprlock))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("grimblast copy area -n"))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("grimblast save screen -n"), { locked = true })

-- Rofi binds
local kill_rofi = "pkill rofi || "
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(kill_rofi .. menu))
hl.bind("XF86Tools", hl.dsp.exec_cmd(kill_rofi .. menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(kill_rofi .. "/home/moriaan/.config/waybar/scripts/rofi-web.sh"))
hl.bind("XF86Launch5", hl.dsp.exec_cmd(kill_rofi .. "/home/moriaan/.config/waybar/scripts/rofi-web.sh"))
hl.bind("XF86Launch5", hl.dsp.exec_cmd("pkill rofi; zen-browser"), { long_press = true })
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(kill_rofi .. "rofi -show window"))
hl.bind("XF86Launch6", hl.dsp.exec_cmd(kill_rofi .. "rofi -show window"))
hl.bind(mainMod .. " + CTRL + V", hl.dsp.exec_cmd(kill_rofi .. "/home/moriaan/.config/waybar/scripts/clipboard.sh"))
hl.bind("XF86Launch7", hl.dsp.exec_cmd(kill_rofi .. "/home/moriaan/.config/waybar/scripts/clipboard.sh"))
hl.bind(mainMod .. " + CTRL + SPACE", hl.dsp.exec_cmd(kill_rofi .. runmenu))

-- Theme binds
-- picker
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(kill_rofi .. "~/.local/bin/rotate_wallpaper.sh --picker > /tmp/rotate_wallpaper.log"))
hl.bind(mainMod .. " + XF86Tools", hl.dsp.exec_cmd(kill_rofi .. "~/.local/bin/rotate_wallpaper.sh --picker > /tmp/rotate_wallpaper.log"))
-- keep wallpaper
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.local/bin/rotate_wallpaper.sh --keep-wallpaper > /tmp/rotate_wallpaper.log"))
hl.bind(mainMod .. " + XF86Launch6", hl.dsp.exec_cmd("~/.local/bin/rotate_wallpaper.sh --keep-wallpaper > /tmp/rotate_wallpaper.log"))
-- auto rotate
hl.bind(mainMod .. " + XF86Launch5", hl.dsp.exec_cmd("~/.local/bin/rotate_wallpaper.sh > /tmp/rotate_wallpaper.log"))
hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd("~/.local/bin/rotate_wallpaper.sh > /tmp/rotate_wallpaper.log"))

-- audio visualizer
hl.bind(mainMod .. " + XF86Launch8", hl.dsp.exec_cmd("~/.config/hypr/toggle_hypr-cava-visualizer.sh"))
--hl.bind(mainMod .. " + XF86Launch8", hl.dsp.exec_cmd("notify-send test"))


hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("pidof wlogout || wlogout"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + ampersand", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + eacute", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + quotedbl", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + apostrophe", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + parenleft", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + section", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + egrave", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + exclam", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + ccedilla", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + agrave", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + ampersand", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + eacute", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + quotedbl", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + apostrophe", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + parenleft", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + section", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + egrave", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + exclam", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + ccedilla", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + agrave", hl.dsp.window.move({ workspace = 10 }))

-- G6 through G9 keys
hl.bind("XF86Launch9", hl.dsp.focus({ workspace = 1 }))
hl.bind("F19", hl.dsp.focus({ workspace = 2 }))
hl.bind("XF86AudioMicMute", hl.dsp.focus({ workspace = 3 }))
hl.bind("XF86TouchpadToggle", hl.dsp.focus({ workspace = 4 }))

hl.bind("SHIFT + XF86Launch9", hl.dsp.window.move({ workspace = 1 }), { release = true })
hl.bind("SHIFT + F19", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SHIFT + XF86AudioMicMute", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SHIFT + XF86TouchpadToggle", hl.dsp.window.move({ workspace = 4 }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.window.move({ workspace = "e+1" }))

-- Spotify workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("spotify"))
hl.bind("XF86Launch8", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:spotify" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())


-- Zoom in
hl.bind(mainMod .. " + CTRL + mouse_down", function()
    local zoom = hl.get_config("cursor.zoom_factor")
    hl.config({ cursor = { zoom_factor = zoom * math.sqrt(2) } })
end)
-- Zoom out (min 1.0)
hl.bind(mainMod .. " + CTRL + mouse_up", function()
    local zoom = hl.get_config("cursor.zoom_factor")
    hl.config({ cursor = { zoom_factor = math.max(zoom / math.sqrt(2), 1) } })
end)

--# Laptop multimedia keys for volume and LCD brightness
--bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+
--bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
--bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
--bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
--bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
--bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

-- Multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume=+1"), { locked = true, repeating = true, ignore_mods = false })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume=-1"), { locked = true, repeating = true, ignore_mods = false })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume=mute-toggle"), { locked = true, repeating = true })
--bindel = ,XF86AudioMicMute, exec, swayosd-client --input-volume=mute-toggle
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +1; swayosd-client --brightness $(hyprctl hyprsunset gamma)"), { locked = true, repeating = true, ignore_mods = false })
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -1; swayosd-client --brightness $(hyprctl hyprsunset gamma)"), { locked = true, repeating = true, ignore_mods = false })

hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute -p $(hyprctl activewindow -j | jq '.pid') toggle"))

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl=next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl=play-pause"), { locked = true })
hl.bind("SHIFT + XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl=play-pause --player=spotify"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl=play-pause"), { locked = true })
hl.bind("SHIFT + XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl=play-pause --player=spotify"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl=prev"), { locked = true })


hl.bind("CAPS_LOCK", hl.dsp.exec_cmd("sleep 0.11; swayosd-client --caps-lock"), { non_consuming = true })

-- Plugins
--bind = SUPER, g, hyprexpo:expo, toggle
