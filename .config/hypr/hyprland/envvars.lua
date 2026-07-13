-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Environment-variables/

-- Set nvim as default editor
hl.env("EDITOR", "nvim")

-- NVIDIA REQUIRED ENV VARS FROM WIKI
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Gemini said to use with AOC monitor
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")

-- Cursor theme
hl.env("XCURSOR_THEME", "Win11OS")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- QT apps styling (like dolphin)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- XDG dir
hl.env("XDG_SCREENSHOTS_DIR", "/home/moriaan/Pictures/Screenshots")
