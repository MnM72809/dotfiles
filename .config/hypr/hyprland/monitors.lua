------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Monitors/

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@180",
    position = "auto",
    scale = "1",
	vrr = 1,
})

hl.monitor({
	output = "DP-2",
	mode = "2560x1440@180",
	position = "auto",
	scale = 1.0,
	bitdepth = 10,
	-- cm = "hdredid",
	cm = "auto",
	sdrbrightness = 1.9,
	sdrsaturation = 0.9,
	sdr_min_luminance = 0.001,
	sdr_max_luminance = 300,
	max_luminance = 1000,
	vrr = 3, -- Only video or game content type in fullscreen
	icc = "/usr/share/color/icc/colord/Q27G3XMN.icm",
	-- icc = "/usr/share/color/icc/colord/WideGamutRGB.icc",
	-- icc = "/usr/share/color/icc/colord/AOC_Q27G3XMN.icm",
	-- icc = "/usr/share/color/icc/colord/Bluish.icc",
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

--monitor=HDMI-A-1,disabled
--monitor=HEADLESS-1,1920x1200@60,auto,1
