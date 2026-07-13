#!/usr/bin/env python3
import sys

h_in = int(sys.argv[1])
s    = int(sys.argv[2])
l    = int(sys.argv[3])

# Calibration: (intended_hue → actual_input_hue_for_your_strip)
# Edit these based on your strip's behavior
table = [
    (0,   0),
    (4,   1),
    (6,   2),
    (10,  3),
    (13,  4),
    (24,  8),
    (30,  10),
    (32,  12),
    (36,  14),
    (38,  16),
    (42,  18),
    (44,  20),
    (52,  21),
    (55,  22),
    (65,  24),
    (66,  25),
    (70,  28),
    (76,  30),
    (78,  35),
    (83,  40),
    (87,  45),
    (89,  50),
    (92,  55),
    (125, 110),
    (128, 120),
    (137, 125),
    (150, 130),
    (157, 135),
    (164, 140),
    (197, 170),
    (203, 180),
    (205, 190),
    (210, 200),
    (217, 220),
    (240, 240),
    (254, 250),
    (260, 260),
    (263, 270),
    (266, 280),
    (270, 290),
    (271, 300),
    (273, 310),
    (275, 320),
    (279, 330),
    (294, 340),
    (333, 350),
    (360, 360)
]

h_out = h_in
for i in range(len(table) - 1):
    h0, c0 = table[i]
    h1, c1 = table[i + 1]
    if h0 <= h_in <= h1:
        t = (h_in - h0) / (h1 - h0)
        h_out = round(c0 + t * (c1 - c0))
        break

print(h_out, s, l)
