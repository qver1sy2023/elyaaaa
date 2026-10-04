-- by uwksc ~ monstry ~ drmslord
local L_0_0 = ui.new_combobox("LUA", "A", " Navigation", "Rage options", "Misc", "Tweaks", "Helpers")

ffi = require("ffi")
vector = require("vector")
pui = require("gamesense/pui")
weapons = require("gamesense/csgo_weapons")
surface = require("gamesense/surface")
base64 = require("gamesense/base64")
clipboard = require("gamesense/clipboard")
http = require("gamesense/http")

local L_0_1 = "admin"



local L_0_2 = {}
local L_0_3 = {
	rad = 11,
	o = 20,
	n = 45,
	rounding = 9,
	OutlineGlow = function(L_ARG_5_0, L_ARG_5_1, L_ARG_5_2, L_ARG_5_3, L_ARG_5_4, L_ARG_5_5, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9, L_ARG_5_10)
		renderer.rectangle(L_ARG_5_1 + 2, L_ARG_5_2 + L_ARG_5_5 + L_ARG_5_0.rad, 1, L_ARG_5_4 - L_ARG_5_0.rad * 2 - L_ARG_5_5 * 2, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9)
		renderer.rectangle(L_ARG_5_1 + L_ARG_5_3 - 3, L_ARG_5_2 + L_ARG_5_5 + L_ARG_5_0.rad, 1, L_ARG_5_4 - L_ARG_5_0.rad * 2 - L_ARG_5_5 * 2, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9)
		renderer.rectangle(L_ARG_5_1 + L_ARG_5_5 + L_ARG_5_0.rad, L_ARG_5_2 + 2, L_ARG_5_3 - L_ARG_5_0.rad * 2 - L_ARG_5_5 * 2, 1, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9)
		renderer.rectangle(L_ARG_5_1 + L_ARG_5_5 + L_ARG_5_0.rad, L_ARG_5_2 + L_ARG_5_4 - 3, L_ARG_5_3 - L_ARG_5_0.rad * 2 - L_ARG_5_5 * 2, 1, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9)
		renderer.circle_outline(L_ARG_5_1 + L_ARG_5_5 + L_ARG_5_0.rad, L_ARG_5_2 + L_ARG_5_5 + L_ARG_5_0.rad, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9, L_ARG_5_5 + L_ARG_5_0.rounding, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_5_1 + L_ARG_5_3 - L_ARG_5_5 - L_ARG_5_0.rad, L_ARG_5_2 + L_ARG_5_5 + L_ARG_5_0.rad, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9, L_ARG_5_5 + L_ARG_5_0.rounding, 270, 0.25, 1)
		renderer.circle_outline(L_ARG_5_1 + L_ARG_5_5 + L_ARG_5_0.rad, L_ARG_5_2 + L_ARG_5_4 - L_ARG_5_5 - L_ARG_5_0.rad, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9, L_ARG_5_5 + L_ARG_5_0.rounding, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_5_1 + L_ARG_5_3 - L_ARG_5_5 - L_ARG_5_0.rad, L_ARG_5_2 + L_ARG_5_4 - L_ARG_5_5 - L_ARG_5_0.rad, L_ARG_5_6, L_ARG_5_7, L_ARG_5_8, L_ARG_5_9, L_ARG_5_5 + L_ARG_5_0.rounding, 0, 0.25, 1)
	end,
	rounded_box = function(L_ARG_6_0, L_ARG_6_1, L_ARG_6_2, L_ARG_6_3, L_ARG_6_4, L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9, L_ARG_6_10, L_ARG_6_11, L_ARG_6_12, L_ARG_6_13)
		renderer.rectangle(L_ARG_6_1 + L_ARG_6_5, L_ARG_6_2, L_ARG_6_3 - L_ARG_6_5 * 2, L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9)
		renderer.rectangle(L_ARG_6_1, L_ARG_6_2 + L_ARG_6_5, L_ARG_6_5, L_ARG_6_4 - L_ARG_6_5 * 2, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9)
		renderer.rectangle(L_ARG_6_1 + L_ARG_6_5, L_ARG_6_2 + L_ARG_6_4 - L_ARG_6_5, L_ARG_6_3 - L_ARG_6_5 * 2, L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9)
		renderer.rectangle(L_ARG_6_1 + L_ARG_6_3 - L_ARG_6_5, L_ARG_6_2 + L_ARG_6_5, L_ARG_6_5, L_ARG_6_4 - L_ARG_6_5 * 2, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9)
		renderer.rectangle(L_ARG_6_1 + L_ARG_6_5, L_ARG_6_2 + L_ARG_6_5, L_ARG_6_3 - L_ARG_6_5 * 2, L_ARG_6_4 - L_ARG_6_5 * 2, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9)
		renderer.circle(L_ARG_6_1 + L_ARG_6_5, L_ARG_6_2 + L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9, L_ARG_6_5, 180, 0.25)
		renderer.circle(L_ARG_6_1 + L_ARG_6_3 - L_ARG_6_5, L_ARG_6_2 + L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9, L_ARG_6_5, 90, 0.25)
		renderer.circle(L_ARG_6_1 + L_ARG_6_5, L_ARG_6_2 + L_ARG_6_4 - L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9, L_ARG_6_5, 270, 0.25)
		renderer.circle(L_ARG_6_1 + L_ARG_6_3 - L_ARG_6_5, L_ARG_6_2 + L_ARG_6_4 - L_ARG_6_5, L_ARG_6_6, L_ARG_6_7, L_ARG_6_8, L_ARG_6_9, L_ARG_6_5, 0, 0.25)
	end,
	rounded_box3 = function(L_ARG_7_0, L_ARG_7_1, L_ARG_7_2, L_ARG_7_3, L_ARG_7_4, L_ARG_7_5, L_ARG_7_6, L_ARG_7_7, L_ARG_7_8, L_ARG_7_9, L_ARG_7_10, L_ARG_7_11, L_ARG_7_12, L_ARG_7_13)
		renderer.circle(L_ARG_7_1 + L_ARG_7_5, L_ARG_7_2 + L_ARG_7_5, L_ARG_7_6, L_ARG_7_7, L_ARG_7_8, L_ARG_7_9, L_ARG_7_5, 180, 0.25)
		renderer.circle(L_ARG_7_1 - L_ARG_7_5 + 24, L_ARG_7_2 + L_ARG_7_5, L_ARG_7_6, L_ARG_7_7, L_ARG_7_8, L_ARG_7_9, L_ARG_7_5, 90, 0.25)
		renderer.circle(L_ARG_7_1 + L_ARG_7_5, L_ARG_7_2 + L_ARG_7_4 - L_ARG_7_5, L_ARG_7_6, L_ARG_7_7, L_ARG_7_8, L_ARG_7_9, L_ARG_7_5, 270, 0.25)
		renderer.circle(L_ARG_7_1 - L_ARG_7_5 + 24, L_ARG_7_2 + L_ARG_7_4 - L_ARG_7_5, L_ARG_7_6, L_ARG_7_7, L_ARG_7_8, L_ARG_7_9, L_ARG_7_5, 0, 0.25)
	end,
	rounded_box2 = function(L_ARG_8_0, L_ARG_8_1, L_ARG_8_2, L_ARG_8_3, L_ARG_8_4, L_ARG_8_5, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_ARG_8_9, L_ARG_8_10, L_ARG_8_11, L_ARG_8_12, L_ARG_8_13)
		local L_8_0 = L_ARG_8_9 / 255 * L_ARG_8_0.n

		renderer.rectangle(L_ARG_8_1 + L_ARG_8_5, L_ARG_8_2, L_ARG_8_3 - L_ARG_8_5 * 2, 1, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0)
		renderer.circle_outline(L_ARG_8_1 + L_ARG_8_5, L_ARG_8_2 + L_ARG_8_5, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0, L_ARG_8_5, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_8_1 + L_ARG_8_3 - L_ARG_8_5, L_ARG_8_2 + L_ARG_8_5, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0, L_ARG_8_5, 270, 0.25, 1)
		renderer.rectangle(L_ARG_8_1, L_ARG_8_2 + L_ARG_8_5, 1, L_ARG_8_4 - L_ARG_8_5 * 2, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0)
		renderer.rectangle(L_ARG_8_1 + L_ARG_8_3 - 1, L_ARG_8_2 + L_ARG_8_5, 1, L_ARG_8_4 - L_ARG_8_5 * 2, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0)
		renderer.circle_outline(L_ARG_8_1 + L_ARG_8_5, L_ARG_8_2 + L_ARG_8_4 - L_ARG_8_5, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0, L_ARG_8_5, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_8_1 + L_ARG_8_3 - L_ARG_8_5, L_ARG_8_2 + L_ARG_8_4 - L_ARG_8_5, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0, L_ARG_8_5, 0, 0.25, 1)
		renderer.rectangle(L_ARG_8_1 + L_ARG_8_5, L_ARG_8_2 + L_ARG_8_4 - 1, L_ARG_8_3 - L_ARG_8_5 * 2, 1, L_ARG_8_6, L_ARG_8_7, L_ARG_8_8, L_8_0)

		for L_IT_8_0 = 4, L_ARG_8_10 do
			local L_8_1 = L_IT_8_0 / 2

			L_ARG_8_0:OutlineGlow(L_ARG_8_1 - L_8_1, L_ARG_8_2 - L_8_1, L_ARG_8_3 + L_8_1 * 2, L_ARG_8_4 + L_8_1 * 2, L_8_1, L_ARG_8_11, L_ARG_8_12, L_ARG_8_13, L_ARG_8_10 - L_8_1 * 2)
		end
	end,
	OutlineGlow = function(L_ARG_9_0, L_ARG_9_1, L_ARG_9_2, L_ARG_9_3, L_ARG_9_4, L_ARG_9_5, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9)
		renderer.rectangle(L_ARG_9_1 + 2, L_ARG_9_2 + L_ARG_9_5 + L_ARG_9_0.rad, 1, L_ARG_9_4 - L_ARG_9_0.rad * 2 - L_ARG_9_5 * 2, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9)
		renderer.rectangle(L_ARG_9_1 + L_ARG_9_3 - 3, L_ARG_9_2 + L_ARG_9_5 + L_ARG_9_0.rad, 1, L_ARG_9_4 - L_ARG_9_0.rad * 2 - L_ARG_9_5 * 2, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9)
		renderer.rectangle(L_ARG_9_1 + L_ARG_9_5 + L_ARG_9_0.rad, L_ARG_9_2 + 2, L_ARG_9_3 - L_ARG_9_0.rad * 2 - L_ARG_9_5 * 2, 1, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9)
		renderer.rectangle(L_ARG_9_1 + L_ARG_9_5 + L_ARG_9_0.rad, L_ARG_9_2 + L_ARG_9_4 - 3, L_ARG_9_3 - L_ARG_9_0.rad * 2 - L_ARG_9_5 * 2, 1, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9)
		renderer.circle_outline(L_ARG_9_1 + L_ARG_9_5 + L_ARG_9_0.rad, L_ARG_9_2 + L_ARG_9_5 + L_ARG_9_0.rad, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9, L_ARG_9_5 + L_ARG_9_0.rounding, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_9_1 + L_ARG_9_3 - L_ARG_9_5 - L_ARG_9_0.rad, L_ARG_9_2 + L_ARG_9_5 + L_ARG_9_0.rad, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9, L_ARG_9_5 + L_ARG_9_0.rounding, 270, 0.25, 1)
		renderer.circle_outline(L_ARG_9_1 + L_ARG_9_5 + L_ARG_9_0.rad, L_ARG_9_2 + L_ARG_9_4 - L_ARG_9_5 - L_ARG_9_0.rad, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9, L_ARG_9_5 + L_ARG_9_0.rounding, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_9_1 + L_ARG_9_3 - L_ARG_9_5 - L_ARG_9_0.rad, L_ARG_9_2 + L_ARG_9_4 - L_ARG_9_5 - L_ARG_9_0.rad, L_ARG_9_6, L_ARG_9_7, L_ARG_9_8, L_ARG_9_9, L_ARG_9_5 + L_ARG_9_0.rounding, 0, 0.25, 1)
	end,
	FadedRoundedGlow = function(L_ARG_10_0, L_ARG_10_1, L_ARG_10_2, L_ARG_10_3, L_ARG_10_4, L_ARG_10_5, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_ARG_10_9, L_ARG_10_10, L_ARG_10_11, L_ARG_10_12, L_ARG_10_13)
		local L_10_0 = L_ARG_10_9 / 255 * L_ARG_10_0.n

		renderer.rectangle(L_ARG_10_1 + L_ARG_10_5, L_ARG_10_2, L_ARG_10_3 - L_ARG_10_5 * 2, 1, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0)
		renderer.circle_outline(L_ARG_10_1 + L_ARG_10_5, L_ARG_10_2 + L_ARG_10_5, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0, L_ARG_10_5, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_10_1 + L_ARG_10_3 - L_ARG_10_5, L_ARG_10_2 + L_ARG_10_5, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0, L_ARG_10_5, 270, 0.25, 1)
		renderer.rectangle(L_ARG_10_1, L_ARG_10_2 + L_ARG_10_5, 1, L_ARG_10_4 - L_ARG_10_5 * 2, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0)
		renderer.rectangle(L_ARG_10_1 + L_ARG_10_3 - 1, L_ARG_10_2 + L_ARG_10_5, 1, L_ARG_10_4 - L_ARG_10_5 * 2, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0)
		renderer.circle_outline(L_ARG_10_1 + L_ARG_10_5, L_ARG_10_2 + L_ARG_10_4 - L_ARG_10_5, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0, L_ARG_10_5, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_10_1 + L_ARG_10_3 - L_ARG_10_5, L_ARG_10_2 + L_ARG_10_4 - L_ARG_10_5, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0, L_ARG_10_5, 0, 0.25, 1)
		renderer.rectangle(L_ARG_10_1 + L_ARG_10_5, L_ARG_10_2 + L_ARG_10_4 - 1, L_ARG_10_3 - L_ARG_10_5 * 2, 1, L_ARG_10_6, L_ARG_10_7, L_ARG_10_8, L_10_0)

		for L_IT_10_0 = 4, L_ARG_10_10 do
			local L_10_1 = L_IT_10_0 / 2

			L_ARG_10_0:OutlineGlow(L_ARG_10_1 - L_10_1, L_ARG_10_2 - L_10_1, L_ARG_10_3 + L_10_1 * 2, L_ARG_10_4 + L_10_1 * 2, L_10_1, L_ARG_10_11, L_ARG_10_12, L_ARG_10_13, L_ARG_10_10 - L_10_1 * 2)
		end
	end
}
local L_0_4 = renderer.load_svg("<?xml version=\"1.0\" encoding=\"utf-8\"?><!-- Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools -->\n<svg width=\"800px\" height=\"800px\" viewBox=\"0 0 16 16\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path fill-rule=\"nonzero\" clip-rule=\"nonzero\" d=\"M4.84989 2.37195C4.59895 2.51683 4.33488 2.91636 4.30424 3.78785C4.28968 4.20181 3.9423 4.52559 3.52835 4.51103C3.11439 4.49647 2.79061 4.1491 2.80516 3.73514C2.84273 2.66673 3.1806 1.60366 4.09989 1.07291C5.02179 0.540653 6.11484 0.782356 7.06128 1.28727C7.42674 1.48224 7.56495 1.93656 7.36998 2.30201C7.17501 2.66747 6.72069 2.80568 6.35524 2.61072C5.5818 2.1981 5.10158 2.22663 4.84989 2.37195ZM8.87139 3.67284C9.19036 3.40858 9.66315 3.45293 9.92741 3.7719C10.4818 4.44103 11.0136 5.20405 11.4963 6.04018C12.5366 7.84191 13.178 9.68785 13.3509 11.2362C13.4372 12.0091 13.4108 12.7446 13.2303 13.3754C13.0484 14.011 12.6941 14.5863 12.0999 14.9293C11.381 15.3444 10.5509 15.2855 9.79114 15.0089C9.02868 14.7313 8.24395 14.2056 7.49586 13.5228C7.18993 13.2435 7.16831 12.7691 7.44756 12.4632C7.72681 12.1573 8.20119 12.1356 8.50712 12.4149C9.16624 13.0165 9.78567 13.4105 10.3043 13.5994C10.8257 13.7892 11.1537 13.7436 11.3499 13.6303C11.5143 13.5354 11.6797 13.342 11.7882 12.9627C11.8981 12.5787 11.9328 12.0529 11.8602 11.4026C11.7152 10.1045 11.1591 8.45607 10.1973 6.79018C9.75492 6.02396 9.27081 5.33055 8.77232 4.72886C8.50807 4.40989 8.55242 3.93709 8.87139 3.67284Z\" fill=\"#A36990FF\"/>\n<path fill-rule=\"nonzero\" clip-rule=\"nonzero\" d=\"M14.5 8.20557C14.5 7.91581 14.286 7.48735 13.5466 7.02507C13.1954 6.80549 13.0887 6.34276 13.3083 5.99154C13.5279 5.64032 13.9906 5.53361 14.3418 5.75319C15.2483 6.31993 16 7.14407 16 8.20557C16 9.27009 15.2442 10.0958 14.3337 10.663C13.9821 10.882 13.5195 10.7746 13.3005 10.423C13.0815 10.0714 13.189 9.60887 13.5405 9.38985C14.2846 8.92635 14.5 8.4962 14.5 8.20557ZM11.3626 11.0378C11.432 11.4462 11.1572 11.8335 10.7488 11.9029C9.89219 12.0484 8.96547 12.1274 8 12.1274C5.91954 12.1274 4.00018 11.76 2.57286 11.1355C1.86032 10.8238 1.23659 10.4332 0.780529 9.9615C0.320977 9.48616 0 8.89166 0 8.20557C0 7.37549 0.466082 6.68599 1.08548 6.16636C1.70712 5.64485 2.55471 5.22808 3.52013 4.92164C3.91494 4.79633 4.33657 5.01479 4.46189 5.40959C4.5872 5.80439 4.36874 6.22603 3.97394 6.35135C3.12334 6.62134 2.4724 6.96078 2.04954 7.31553C1.62442 7.67217 1.5 7.97899 1.5 8.20557C1.5 8.39536 1.58476 8.6353 1.85895 8.91891C2.13663 9.20613 2.57464 9.49905 3.17409 9.76131C4.37076 10.2848 6.07639 10.6274 8 10.6274C8.88475 10.6274 9.72732 10.5549 10.4976 10.424C10.906 10.3547 11.2933 10.6295 11.3626 11.0378Z\" fill=\"#8C7494\"/>\n<path fill-rule=\"nonzero\" clip-rule=\"nonzero\" d=\"M4.87192 13.6303C5.12286 13.7752 5.6009 13.8041 6.37095 13.3949C6.73673 13.2005 7.19082 13.3395 7.38519 13.7052C7.57957 14.071 7.44062 14.5251 7.07484 14.7195C6.13079 15.2211 5.04121 15.4601 4.12192 14.9293C3.20003 14.3971 2.86282 13.3296 2.82687 12.2575C2.81299 11.8435 3.13733 11.4967 3.55131 11.4828C3.96529 11.4689 4.31215 11.7932 4.32603 12.2072C4.35541 13.0834 4.62023 13.485 4.87192 13.6303ZM3.98778 9.49712C3.59944 9.35301 3.40145 8.92138 3.54556 8.53304C3.84786 7.71839 4.24274 6.8763 4.72548 6.04018C5.76571 4.23845 7.04361 2.75996 8.29806 1.83609C8.92431 1.37487 9.57441 1.02999 10.211 0.870901C10.8524 0.71059 11.5278 0.729863 12.1219 1.07291C12.8408 1.48795 13.2049 2.23634 13.3452 3.03257C13.486 3.83168 13.4232 4.77409 13.2058 5.7634C13.1169 6.16796 12.7169 6.42388 12.3124 6.33501C11.9078 6.24613 11.6519 5.84612 11.7408 5.44155C11.9322 4.56992 11.9637 3.83647 11.868 3.29288C11.7717 2.7464 11.5681 2.48524 11.3719 2.37195C11.2076 2.27705 10.9574 2.23049 10.5747 2.32614C10.1871 2.42301 9.71442 2.65588 9.18757 3.04388C8.13584 3.81846 6.98632 5.12428 6.02452 6.79018C5.58214 7.55639 5.22369 8.32235 4.95185 9.0549C4.80774 9.44323 4.37611 9.64122 3.98778 9.49712Z\" fill=\"#A36990FF\"/>\n<path d=\"M9.45925 8.06618C9.45925 8.81694 8.85063 9.42556 8.09987 9.42556C7.34911 9.42556 6.7405 8.81694 6.7405 8.06618C6.7405 7.31542 7.34911 6.70681 8.09987 6.70681C8.85063 6.70681 9.45925 7.31542 9.45925 8.06618Z\" fill=\"#8C7494\"/>\n</svg>", 14, 14)
local L_0_5 = {}
local L_0_6 = {
	lerp = function(L_ARG_11_0, L_ARG_11_1, L_ARG_11_2, L_ARG_11_3)
		return L_ARG_11_1 + (L_ARG_11_2 - L_ARG_11_1) * L_ARG_11_3
	end,
	clamp = function(L_ARG_12_0, L_ARG_12_1, L_ARG_12_2, L_ARG_12_3)
		if L_ARG_12_3 < L_ARG_12_1 then
			return L_ARG_12_3
		end

		if L_ARG_12_1 < L_ARG_12_2 then
			return L_ARG_12_2
		end

		return L_ARG_12_1
	end,
	ease_in_out_quart = function(L_ARG_13_0, L_ARG_13_1)
		local L_13_0 = L_ARG_13_1^2

		return L_13_0 / (2 * (L_13_0 - L_ARG_13_1) + 1)
	end
}

function L_0_2.add_to_log(L_ARG_14_0, L_ARG_14_1, L_ARG_14_2)
	local L_14_0 = {
		client.screen_size()
	}
	local L_14_1 = {
		L_14_0[1] / 2,
		L_14_0[2] / 2
	}

	while #L_0_5 >= 6 do
		table.remove(L_0_5, 1)
	end

	table.insert(L_0_5, {
		alpha3 = 0,
		ypos = 0,
		alpha = 0,
		alpha2 = 0,
		text = L_ARG_14_1,
		player = L_ARG_14_2,
		timer = globals.realtime(),
		ypos2 = L_14_0[2]
	})
end

function L_0_2.logs(L_ARG_15_0)
	local screen = {
		client.screen_size()
	}
	local center = {
		screen[1] / 2,
		screen[2] / 2
	}
	local x = center[1]
	local y = screen[2]
	local now = globals.realtime()

	for index = #L_0_5, 1, -1 do
		if L_0_5[index].timer + 4 <= now then
			table.remove(L_0_5, index)
		end
	end

	for L_IT_15_0, L_IT_15_1 in ipairs(L_0_5) do
		local L_15_0 = 255
		local L_15_1 = 255
		local L_15_2 = 255
		local L_15_3 = 255
		local L_15_4 = 255
		local L_15_5 = 255
		local L_15_6 = 255
		local L_15_7 = 255
		local L_15_8 = 25
		local L_15_9 = 25
		local L_15_10 = 25
		local L_15_11 = 255
		local L_15_12 = 0

		if L_IT_15_1.timer + 3.8 < now then
			if L_IT_15_1.timer + 3.95 < now then
				L_IT_15_1.text = ""
			end

			L_IT_15_1.ypos = L_0_6:lerp(L_IT_15_1.ypos, 215, globals.frametime() * 2)
			L_IT_15_1.alpha = L_0_6:lerp(L_IT_15_1.alpha, 0, globals.frametime() * 15)
			L_IT_15_1.alpha2 = L_0_6:lerp(L_IT_15_1.alpha2, 0, globals.frametime() * 50)
			L_IT_15_1.alpha3 = L_0_6:lerp(L_IT_15_1.alpha3, 0, globals.frametime() * 15)
			L_15_12 = globals.frametime() * 5
		else
			L_IT_15_1.ypos = L_0_6:lerp(L_IT_15_1.ypos, 175, globals.frametime() * 4)
			L_IT_15_1.alpha = L_0_6:lerp(L_IT_15_1.alpha, 255, globals.frametime() * 5)
			L_IT_15_1.alpha2 = L_0_6:lerp(L_IT_15_1.alpha2, L_15_11, globals.frametime() * 10)
			L_IT_15_1.alpha3 = L_0_6:lerp(L_IT_15_1.alpha3, 18, globals.frametime() * 15)
			L_15_12 = globals.frametime() * 15
		end

		local L_15_13, L_15_14 = renderer.measure_text("", L_IT_15_1.text)

		L_IT_15_1.ypos2 = L_0_6:lerp(L_IT_15_1.ypos2, y, L_15_12)

		local L_15_15 = L_IT_15_1.ypos2 - L_IT_15_1.ypos
		local L_15_16 = L_IT_15_1.alpha
		local L_15_17 = L_IT_15_1.alpha2
		local L_15_18 = 0
		local L_15_19 = L_15_13 * 2 / 2
		local L_15_20 = L_15_13 / 2

		L_0_3:FadedRoundedGlow(x - L_15_20 - 19, L_15_15 - 1, L_15_13 + 33, 22, 5, L_15_8, L_15_9, L_15_10, L_15_17, L_IT_15_1.alpha3, L_15_4, L_15_5, L_15_6)
		L_0_3:rounded_box(x - L_15_20 - 18, L_15_15, L_15_13 + 31, 20, 3, L_15_8, L_15_9, L_15_10, L_15_16, 255, 255, 255, L_15_16)

		if L_IT_15_1.player ~= nil then
			renderer.texture(L_0_4, x - L_15_20 - 12, L_15_15 + 3, 14, 14, 255, 255, 255, L_15_16, "")
			renderer.text(x - L_15_20 + 8, L_15_15 + 3, 225, 225, 225, L_15_17, "", 0, L_IT_15_1.text)
		else
			renderer.text(x - L_15_20 + 8, L_15_15 + 3, 225, 225, 225, L_15_17, "", 0, L_IT_15_1.text)
			renderer.texture(L_0_4, x - L_15_20 - 12, L_15_15 + 3, 14, 14, 255, 255, 255, L_15_16, "")
		end

		y = y + 25

	end
end

L_0_2:add_to_log("welcome back, " .. L_0_1)
client.set_event_callback("paint_ui", function()
	L_0_2:logs()
end)

local L_0_7 = client.camera_angles
local L_0_8 = client.create_interface
local L_0_9 = client.eye_position
local L_0_10 = client.set_event_callback
local L_0_11 = client.userid_to_entindex
local L_0_12 = entity.get_local_player
local L_0_13 = entity.get_player_name
local L_0_14 = entity.get_prop
local L_0_15 = entity.is_alive
local L_0_16 = globals.chokedcommands
local L_0_17 = globals.realtime
local L_0_18 = globals.tickcount
local L_0_19 = globals.tickinterval
local L_0_20 = math.abs
local L_0_21 = math.ceil
local L_0_22 = math.floor
local L_0_23 = string.format
local L_0_24 = string.lower
local L_0_25 = table.concat
local L_0_26 = table.insert
local L_0_27 = ui.new_checkbox
local L_0_28 = ui.reference
local L_0_29 = error
local L_0_30 = pairs
local L_0_31 = plist.get
local L_0_32 = ui.get
local L_0_33 = print
local L_0_34 = ui.set_callback
local L_0_35 = require("ffi")
local L_0_36 = require("vector")
local L_0_37 = require("gamesense/inspect")
local L_0_38 = require("gamesense/antiaim_funcs")
local L_0_39 = L_0_35.typeof
local L_0_40 = L_0_35.cast

local function L_0_41(L_ARG_17_0)
	local L_17_0 = L_ARG_17_0 % 10

	if L_17_0 == 1 and L_ARG_17_0 ~= 11 then
		return L_ARG_17_0 .. "st"
	elseif L_17_0 == 2 and L_ARG_17_0 ~= 12 then
		return L_ARG_17_0 .. "nd"
	elseif L_17_0 == 3 and L_ARG_17_0 ~= 13 then
		return L_ARG_17_0 .. "rd"
	else
		return L_ARG_17_0 .. "th"
	end
end

local L_0_42 = require("ffi")
local L_0_43 = require("gamesense/clipboard")
local L_0_44 = {}
local L_0_45 = {}
local L_0_46 = {}
local L_0_47 = globals.tickinterval
local L_0_48 = entity.is_enemy
local L_0_49 = entity.get_prop
local L_0_50 = entity.is_dormant
local L_0_51 = entity.is_alive
local L_0_52 = entity.get_origin
local L_0_53 = entity.get_local_player
local L_0_54 = entity.get_player_resource
local L_0_55 = entity.get_bounding_box
local L_0_56 = entity.get_player_name
local L_0_57 = renderer.text
local L_0_58 = renderer.world_to_screen
local L_0_59 = renderer.line
local L_0_60 = table.insert
local L_0_61 = client.trace_line
local L_0_62 = math.floor
local L_0_63 = globals.frametime
local L_0_64 = cvar.sv_gravity
local L_0_65 = cvar.sv_jump_impulse

local function L_0_66(L_ARG_18_0)
	return L_0_62(0.5 + L_ARG_18_0 / L_0_47())
end

local function L_0_67(L_ARG_19_0, L_ARG_19_1)
	return {
		L_ARG_19_0[1] - L_ARG_19_1[1],
		L_ARG_19_0[2] - L_ARG_19_1[2],
		L_ARG_19_0[3] - L_ARG_19_1[3]
	}
end

local function L_0_68(L_ARG_20_0, L_ARG_20_1)
	return {
		L_ARG_20_0[1] + L_ARG_20_1[1],
		L_ARG_20_0[2] + L_ARG_20_1[2],
		L_ARG_20_0[3] + L_ARG_20_1[3]
	}
end

local function L_0_69(L_ARG_21_0, L_ARG_21_1)
	return L_ARG_21_0 * L_ARG_21_0 + L_ARG_21_1 * L_ARG_21_1
end

local function L_0_70(L_ARG_22_0, L_ARG_22_1)
	local L_22_0 = L_ARG_22_0 ~= nil and L_ARG_22_0 or false
	local L_22_1 = L_ARG_22_1 ~= nil and L_ARG_22_1 or true
	local L_22_2 = {}
	local L_22_3 = L_0_53()
	local L_22_4 = L_0_54()

	for L_IT_22_0 = 1, globals.maxplayers() do
		local L_22_5 = true
		local L_22_6 = true

		if L_22_0 and not L_0_48(L_IT_22_0) then
			L_22_5 = false
		end

		if L_22_5 then
			if L_22_1 and L_0_49(L_22_4, "m_bAlive", L_IT_22_0) ~= 1 then
				L_22_6 = false
			end

			if L_22_6 then
				L_0_60(L_22_2, L_IT_22_0)
			end
		end
	end

	return L_22_2
end

local function L_0_71(L_ARG_23_0, L_ARG_23_1, L_ARG_23_2, L_ARG_23_3)
	local L_23_0 = L_0_47()
	local L_23_1 = L_0_64:get_float() * L_23_0
	local L_23_2 = L_0_65:get_float() * L_23_0
	local L_23_3 = L_ARG_23_1
	local L_23_4 = L_ARG_23_1
	local L_23_5 = {
		L_0_49(L_ARG_23_0, "m_vecVelocity")
	}
	local L_23_6 = L_23_5[3] > 0 and -L_23_1 or L_23_2

	for L_IT_23_0 = 1, L_ARG_23_3 do
		local L_23_7 = L_23_3

		L_23_3 = {
			L_23_3[1] + L_23_5[1] * L_23_0,
			L_23_3[2] + L_23_5[2] * L_23_0,
			L_23_3[3] + (L_23_5[3] + L_23_6) * L_23_0
		}

		if L_0_61(-1, L_23_7[1], L_23_7[2], L_23_7[3], L_23_3[1], L_23_3[2], L_23_3[3]) <= 0.99 then
			return L_23_7
		end
	end

	return L_23_3
end

function g_net_update()
	local L_24_0 = L_0_53()
	local L_24_1 = L_0_70(true, true)

	for L_IT_24_0 = 1, #L_24_1 do
		local L_24_2 = L_24_1[L_IT_24_0]
		local L_24_3 = L_0_45[L_24_2]

		if L_0_50(L_24_2) or not L_0_51(L_24_2) then
			L_0_45[L_24_2] = nil
			L_0_46[L_24_2] = nil
			L_0_44[L_24_2] = nil
		else
			local L_24_4 = {
				L_0_52(L_24_2)
			}
			local L_24_5 = L_0_66(L_0_49(L_24_2, "m_flSimulationTime"))

			if L_24_3 ~= nil then
				local L_24_6 = L_24_5 - L_24_3.tick

				if L_24_6 < 0 or L_24_6 > 0 and L_24_6 <= 64 then
					local L_24_7 = L_0_49(L_24_2, "m_fFlags")
					local L_24_8 = L_0_67(L_24_4, L_24_3.origin)
					local L_24_9 = L_0_69(L_24_8[1], L_24_8[2])
					local L_24_10 = L_0_71(L_24_2, L_24_4, L_24_7, L_24_6 - 1)

					if L_24_6 < 0 then
						L_0_44[L_24_2] = 1
					end

					L_0_46[L_24_2] = {
						tick = L_24_6 - 1,
						origin = L_24_4,
						predicted_origin = L_24_10,
						tickbase = L_24_6 < 0,
						lagcomp = L_24_9 > 4096
					}
				end
			end

			if L_0_44[L_24_2] == nil then
				L_0_44[L_24_2] = 0
			end

			L_0_45[L_24_2] = {
				tick = L_24_5,
				origin = L_24_4
			}
		end
	end
end

function g_paint_handler()
	local L_25_0 = L_0_53()
	local L_25_1 = L_0_54()

	if not L_25_0 or not L_0_51(L_25_0) then
		return
	end

	local L_25_2 = L_0_49(L_25_0, "m_iObserverMode")
	local L_25_3 = {}

	if L_25_2 == 0 or L_25_2 == 1 or L_25_2 == 2 or L_25_2 == 6 then
		L_25_3 = L_0_70(true, true)
	elseif L_25_2 == 4 or L_25_2 == 5 then
		local L_25_4 = L_0_70(false, true)
		local L_25_5 = L_0_49(L_25_0, "m_hObserverTarget")
		local L_25_6 = L_0_49(L_25_5, "m_iTeamNum")

		for L_IT_25_0 = 1, #L_25_4 do
			if L_25_6 ~= L_0_49(L_25_4[L_IT_25_0], "m_iTeamNum") and L_25_4[L_IT_25_0] ~= L_25_0 then
				L_0_60(L_25_3, L_25_4[L_IT_25_0])
			end
		end
	end

	if #L_25_3 == 0 then
		return
	end

	for L_IT_25_1, L_IT_25_2 in L_0_30(L_0_46) do
		if L_0_51(L_IT_25_1) and L_0_48(L_IT_25_1) and L_IT_25_2 ~= nil then
			if L_IT_25_2.lagcomp then
				local L_25_7 = L_IT_25_2.predicted_origin
				local L_25_8 = L_0_68({
					L_0_49(L_IT_25_1, "m_vecMins")
				}, L_25_7)
				local L_25_9 = L_0_68({
					L_0_49(L_IT_25_1, "m_vecMaxs")
				}, L_25_7)
				local L_25_10 = {
					{
						L_25_8[1],
						L_25_8[2],
						L_25_8[3]
					},
					{
						L_25_8[1],
						L_25_9[2],
						L_25_8[3]
					},
					{
						L_25_9[1],
						L_25_9[2],
						L_25_8[3]
					},
					{
						L_25_9[1],
						L_25_8[2],
						L_25_8[3]
					},
					{
						L_25_8[1],
						L_25_8[2],
						L_25_9[3]
					},
					{
						L_25_8[1],
						L_25_9[2],
						L_25_9[3]
					},
					{
						L_25_9[1],
						L_25_9[2],
						L_25_9[3]
					},
					{
						L_25_9[1],
						L_25_8[2],
						L_25_9[3]
					}
				}
				local L_25_11 = {
					{
						0,
						1
					},
					{
						1,
						2
					},
					{
						2,
						3
					},
					{
						3,
						0
					},
					{
						5,
						6
					},
					{
						6,
						7
					},
					{
						1,
						4
					},
					{
						4,
						8
					},
					{
						0,
						4
					},
					{
						1,
						5
					},
					{
						2,
						6
					},
					{
						3,
						7
					},
					{
						5,
						8
					},
					{
						7,
						8
					},
					{
						3,
						4
					}
				}

				for L_IT_25_3 = 1, #L_25_11 do
					if L_IT_25_3 == 1 then
						local L_25_12 = {
							L_0_52(L_IT_25_1)
						}
						local L_25_13 = {
							L_0_58(L_25_12[1], L_25_12[2], L_25_12[3])
						}
						local L_25_14 = {
							L_0_58(L_25_8[1], L_25_8[2], L_25_8[3])
						}

						if L_25_13[1] ~= nil and L_25_14[1] ~= nil then
							L_0_59(L_25_13[1], L_25_13[2], L_25_14[1], L_25_14[2], 255, 255, 255, 255)
						end
					end

					if L_25_10[L_25_11[L_IT_25_3][1]] ~= nil and L_25_10[L_25_11[L_IT_25_3][2]] ~= nil then
						local L_25_15 = {
							L_0_58(L_25_10[L_25_11[L_IT_25_3][1]][1], L_25_10[L_25_11[L_IT_25_3][1]][2], L_25_10[L_25_11[L_IT_25_3][1]][3])
						}
						local L_25_16 = {
							L_0_58(L_25_10[L_25_11[L_IT_25_3][2]][1], L_25_10[L_25_11[L_IT_25_3][2]][2], L_25_10[L_25_11[L_IT_25_3][2]][3])
						}

						L_0_59(L_25_15[1], L_25_15[2], L_25_16[1], L_25_16[2], 255, 255, 255, 255)
					end
				end
			end

			local L_25_17 = {
				[0] = "",
				"DELAY MANIPULATOR",
				"TICKBASE ADJUSTMENT"
			}
			local L_25_18, L_25_19, L_25_20, L_25_21, L_25_22 = L_0_55(L_IT_25_1)
			local L_25_23 = 0

			if L_0_44[L_IT_25_1] > 0 then
				L_0_44[L_IT_25_1] = L_0_44[L_IT_25_1] - L_0_63() * 2
				L_0_44[L_IT_25_1] = L_0_44[L_IT_25_1] < 0 and 0 or L_0_44[L_IT_25_1]
				L_25_23 = L_0_44[L_IT_25_1]
			end

			local L_25_24 = L_IT_25_2.tickbase or L_0_44[L_IT_25_1] > 0
			local L_25_25 = L_IT_25_2.lagcomp

			if not L_25_24 or L_IT_25_2.lagcomp then
				L_25_23 = L_25_22
			end

			if L_25_18 ~= nil and L_25_22 > 0 then
				local L_25_26 = L_0_56(L_IT_25_1) == "" and -8 or 0

				L_0_57(L_25_18 + (L_25_20 - L_25_18) / 2, L_25_19 - 18 + L_25_26, 255, 45, 45, L_25_23 * 255, "c", 0, L_25_17[L_25_24 and 2 or L_25_25 and 1 or 0])
			end
		end
	end
end

client.set_event_callback("paint", g_paint_handler)
client.set_event_callback("net_update_end", g_net_update)

function Clamp(L_ARG_26_0, L_ARG_26_1, L_ARG_26_2)
	return math.min(math.max(L_ARG_26_0, L_ARG_26_1), L_ARG_26_2)
end

function NormalizeAngle(L_ARG_27_0)
	if L_ARG_27_0 == nil then
		return 0
	end

	while L_ARG_27_0 > 180 do
		L_ARG_27_0 = L_ARG_27_0 - 360
	end

	while L_ARG_27_0 < -180 do
		L_ARG_27_0 = L_ARG_27_0 + 360
	end

	return L_ARG_27_0
end

function AngleDifference(L_ARG_28_0, L_ARG_28_1)
	local L_28_0 = math.fmod(L_ARG_28_0 - L_ARG_28_1, 360)

	if L_ARG_28_1 < L_ARG_28_0 then
		if L_28_0 >= 180 then
			L_28_0 = L_28_0 - 360
		end
	elseif L_28_0 <= -180 then
		L_28_0 = L_28_0 + 360
	end

	return L_28_0
end

function DegToRad(L_ARG_29_0)
	return L_ARG_29_0 * (math.pi / 180)
end

function RadToDeg(L_ARG_30_0)
	return L_ARG_30_0 * (180 / math.pi)
end

local L_0_72 = {
	Entry = function(L_ARG_31_0, L_ARG_31_1, L_ARG_31_2)
		return L_0_42.cast(L_ARG_31_2, L_0_42.cast("void***", L_ARG_31_0)[0][L_ARG_31_1])
	end,
	Bind = function(L_ARG_32_0, L_ARG_32_1, L_ARG_32_2, L_ARG_32_3, L_ARG_32_4)
		local L_32_0 = client.create_interface(L_ARG_32_1, L_ARG_32_2)
		local L_32_1 = L_ARG_32_0.Entry(L_32_0, L_ARG_32_3, L_0_42.typeof(L_ARG_32_4))

		return function(...)
			return L_32_1(L_32_0, ...)
		end
	end
}
local L_0_73 = ui.reference("MISC", "Settings", "Menu color")

client.set_event_callback("paint", function()
	local L_34_0, L_34_1, L_34_2, L_34_3 = ui.get(L_0_73)
end)

local L_0_74 = L_0_42.typeof("struct { char pad0[0x18]; float anim_update_timer; char pad1[0xC]; float started_moving_time; float last_move_time; char pad2[0x10]; float last_lby_time; char pad3[0x8]; float run_amount; char pad4[0x10]; void* entity; void* active_weapon; void* last_active_weapon; float last_client_side_animation_update_time; int  last_client_side_animation_update_framecount; float eye_timer; float eye_angles_y; float eye_angles_x; float goal_feet_yaw; float current_feet_yaw; float torso_yaw; float last_move_yaw; float lean_amount; char pad5[0x4]; float feet_cycle; float feet_yaw_rate; char pad6[0x4]; float duck_amount; float landing_duck_amount; char pad7[0x4]; float current_origin[3]; float last_origin[3]; float velocity_x; float velocity_y; char pad8[0x4]; float unknown_float1; char pad9[0x8]; float unknown_float2; float unknown_float3; float unknown; float m_velocity; float jump_fall_velocity; float clamped_velocity; float feet_speed_forwards_or_sideways; float feet_speed_unknown_forwards_or_sideways; float last_time_started_moving; float last_time_stopped_moving; bool on_ground; bool hit_in_ground_animation; char pad10[0x4]; float time_since_in_air; float last_origin_z; float head_from_ground_distance_standing; float stop_to_full_running_fraction; char pad11[0x4]; float magic_fraction; char pad12[0x3C]; float world_force; char pad13[0x1CA]; float min_yaw; float max_yaw; } **")
local L_0_75 = L_0_72:Bind("client.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*, int)")
local L_0_76 = ui.new_checkbox("LUA", "A", string.format(" Enable \a%02X%02X%02XFF~ Reflex Logic Resolver", ui.get(L_0_73)))
local L_0_77 = ui.new_multiselect("LUA", "A", " Auto force body aim if", {
	"hp lower than x value"
})
local L_0_78 = ui.new_slider("LUA", "A", "hp", 0, 100, 0, true)
local L_0_79 = ui.new_multiselect("LUA", "A", " Auto force safepoint if", {
	"hp lower than x value",
	"after x misses"
})
local L_0_80 = ui.new_slider("LUA", "A", "hp 1", 0, 100, 0, true)
local L_0_81 = ui.new_slider("LUA", "A", "missed", 0, 10, 0, true)
local L_0_82 = L_0_27("LUA", "A", string.format("Enable \a%02X%02X%02XFF~ Aim-logs", ui.get(L_0_73)))
local L_0_83 = L_0_28("RAGE", "Aimbot", "Prefer safe point")
local L_0_84 = L_0_28("RAGE", "Aimbot", "Force safe point")
local L_0_85 = ui.new_checkbox("LUA", "A", string.format("Enable \a%02X%02X%02XFF~ Feature indicator", ui.get(L_0_73)))
local L_0_86 = ui.new_color_picker("LUA", "A", "debug color", 255, 255, 255)
local L_0_87 = ui.new_checkbox("LUA", "A", string.format("Enable \a%02X%02X%02XFF~ Debug", ui.get(L_0_73)))
local L_0_88 = ui.new_hotkey("LUA", "A", string.format("Enable \a%02X%02X%02XFF~ Delay shot", ui.get(L_0_73)))
local L_0_89 = ui.new_button("LUA", "A", "Default Data", function()
	return
end)
local L_0_90 = ui.new_button("LUA", "A", "Repair rage precision", function()
	return
end)
local L_0_91 = ui.new_button("LUA", "A", "Full \vreset", function()
	return
end)

local function rgba_to_hex(L_ARG_38_0, L_ARG_38_1, L_ARG_38_2, L_ARG_38_3)
	return string.format("%02x%02x%02x%02x", L_ARG_38_0, L_ARG_38_1, L_ARG_38_2, L_ARG_38_3)
end

ui.set_visible(L_0_81, false)
ui.set_visible(L_0_78, false)
ui.set_visible(L_0_80, false)

function updateMultiboxVisibility()
	if ui.get(L_0_76) == true then
		ui.set_visible(L_0_77, true)
		ui.set_visible(L_0_91, true)
		ui.set_visible(L_0_79, true)
		ui.set_visible(L_0_82, true)
		ui.set_visible(L_0_86, true)
		ui.set_visible(L_0_87, true)
		ui.set_visible(L_0_85, true)
		ui.set_visible(L_0_88, true)
		ui.set_visible(L_0_89, true)
		ui.set_visible(L_0_90, true)
	else
		ui.set_visible(L_0_77, false)
		ui.set_visible(L_0_91, false)
		ui.set_visible(L_0_79, false)
		ui.set_visible(L_0_82, false)
		ui.set_visible(L_0_86, false)
		ui.set_visible(L_0_87, false)
		ui.set_visible(L_0_85, false)
		ui.set_visible(L_0_88, false)
		ui.set_visible(L_0_89, false)
		ui.set_visible(L_0_90, false)
	end
end

ui.set_callback(L_0_89, function()
	ui.set(L_0_87, true)
	ui.set(L_0_86, 152, 150, 251, 255)
	ui.set(L_0_77, {
		"hp lower than x value"
	})
	ui.set(L_0_79, {
		"hp lower than x value",
		"after x misses"
	})
	ui.set(L_0_78, 35)
	ui.set(L_0_80, 52)
	ui.set(L_0_81, 1)
	client.color_log(152, 150, 251, "[reflex] default settings have been loaded !")
	L_0_2:add_to_log("\affe2f3ff[reflex] \affffffffyou have loaded the default settings")
end)
ui.set_callback(L_0_91, function()
	ui.set(L_0_78, 0)
	ui.set(L_0_80, 0)
	ui.set(L_0_81, 0)
	client.color_log(152, 150, 251, "[reflex] reset successfully !")
	L_0_2:add_to_log("\affe2f3ff[reflex] \affffffffreset successfully")
end)

function updateSliderVisibility()
	local L_42_0 = ui.get(L_0_77)
	local L_42_1 = false
	local L_42_2 = ui.get(L_0_76) == true

	if L_42_0 then
		for L_IT_42_0, L_IT_42_1 in ipairs(L_42_0) do
			if L_IT_42_1 == "hp lower than x value" and L_42_2 then
				L_42_1 = true

				break
			end
		end
	end

	ui.set_visible(L_0_78, L_42_1)
end

function updateSliderVisibility2()
	local L_43_0 = ui.get(L_0_79)
	local L_43_1 = false
	local L_43_2 = ui.get(L_0_76) == true

	if L_43_0 then
		for L_IT_43_0, L_IT_43_1 in ipairs(L_43_0) do
			if L_IT_43_1 == "after x misses" and L_43_2 then
				L_43_1 = true

				break
			end
		end
	end

	ui.set_visible(L_0_81, L_43_1)
end

function updateSliderVisibility3()
	local L_44_0 = ui.get(L_0_79)
	local L_44_1 = ui.get(L_0_76) == true
	local L_44_2 = false

	if L_44_0 then
		for L_IT_44_0, L_IT_44_1 in ipairs(L_44_0) do
			if L_IT_44_1 == "hp lower than x value" and L_44_1 then
				L_44_2 = true

				break
			end
		end
	end

	ui.set_visible(L_0_80, L_44_2)
end

local function L_0_92(L_ARG_45_0)
	if not L_ARG_45_0 or not entity.is_alive(L_ARG_45_0) or entity.is_dormant(L_ARG_45_0) then
		return false
	end

	local ok, L_45_0 = pcall(function()
		return type(L_ARG_45_0) == "cdata" and L_ARG_45_0 or L_0_75(L_ARG_45_0)
	end)

	if not ok or not L_45_0 or L_45_0 == L_0_42.NULL then
		return false
	end

	local read_ok, state = pcall(function()
		local L_45_1 = L_0_42.cast("void***", L_45_0)
		local animstate = L_0_42.cast(L_0_74, L_0_42.cast("char*", L_45_1) + 39264)[0]
		return {
			eye_angles_y = tonumber(animstate.eye_angles_y),
			goal_feet_yaw = tonumber(animstate.goal_feet_yaw),
			feet_speed_forwards_or_sideways = tonumber(animstate.feet_speed_forwards_or_sideways),
			stop_to_full_running_fraction = tonumber(animstate.stop_to_full_running_fraction),
			duck_amount = tonumber(animstate.duck_amount),
			torso_yaw = tonumber(animstate.torso_yaw),
			last_move_yaw = tonumber(animstate.last_move_yaw)
		}
	end)
	if not read_ok or state == nil then
		return false
	end

	for _, field in ipairs({
		"eye_angles_y",
		"goal_feet_yaw",
		"feet_speed_forwards_or_sideways",
		"stop_to_full_running_fraction",
		"duck_amount",
		"torso_yaw",
		"last_move_yaw"
	}) do
		local value = state[field]
		if type(value) ~= "number" or value ~= value or math.abs(value) > 10000 then
			return false
		end
	end

	return state
end

local function L_0_93(L_ARG_46_0)
	if not L_ARG_46_0 or not entity.is_alive(L_ARG_46_0) or entity.is_dormant(L_ARG_46_0) then
		return nil, nil
	end

	local sim_time = entity.get_prop(L_ARG_46_0, "m_flSimulationTime")
	if sim_time == nil then
		return nil, nil
	end

	local ok, update_time = pcall(function()
		local entity_pointer = L_0_75(L_ARG_46_0)
		if entity_pointer == nil or entity_pointer == L_0_42.NULL then
			return nil
		end
		return L_0_42.cast("float*", L_0_42.cast("uintptr_t", entity_pointer) + 620)[0]
	end)
	if not ok or update_time == nil or update_time ~= update_time or math.abs(update_time) > 1000000 then
		return nil, nil
	end
	return sim_time, update_time
end

local function L_0_94(L_ARG_47_0)
	local L_47_0 = L_0_92(L_ARG_47_0)

	if not L_47_0 then
		return 0
	end

	local L_47_1 = Clamp(L_47_0.feet_speed_forwards_or_sideways, 0, 1)
	local L_47_2 = (L_47_0.stop_to_full_running_fraction * -0.3 - 0.2) * L_47_1 + 1
	local L_47_3 = L_47_0.duck_amount

	if L_47_3 > 0 then
		L_47_2 = L_47_2 + L_47_3 * L_47_1 * (0.5 - L_47_2)
	end

	return Clamp(L_47_2, 0.5, 1)
end

local function L_0_95(L_ARG_48_0)
	local sim_time, update_time = L_0_93(L_ARG_48_0)
	local tick_interval = globals.tickinterval()

	return type(sim_time) == "number"
		and type(update_time) == "number"
		and type(tick_interval) == "number"
		and tick_interval > 0
		and sim_time == sim_time
		and update_time == update_time
end

local function L_0_96(L_ARG_49_0)
	if not L_0_95(L_ARG_49_0) then
		return 0
	end

	local sim_time = L_0_93(L_ARG_49_0)
	local tick_interval = globals.tickinterval()
	local max_ticks = tonumber(cvar.sv_maxusrcmdprocessticks:get_string())

	if sim_time == nil or max_ticks == nil then
		return 0
	end

	local elapsed = math.max(0, globals.curtime() - sim_time - client.latency())
	local ticks = math.floor(elapsed / tick_interval + 0.5)
	return Clamp(ticks, 0, math.max(0, max_ticks - 2))
end

function RebuildServerYaw(L_ARG_50_0)
	local L_50_0 = L_0_92(L_ARG_50_0)

	if L_50_0 == false then
		return 0
	end

	local L_50_1 = L_50_0.goal_feet_yaw
	local L_50_2 = AngleDifference(L_50_0.eye_angles_y, L_50_0.goal_feet_yaw)
	local L_50_3 = Clamp(L_50_0.feet_speed_forwards_or_sideways, 0, 1)
	local L_50_4 = (L_50_0.stop_to_full_running_fraction * -0.3 - 0.2) * L_50_3 + 1

	if L_50_0.duck_amount > 0 then
		local L_50_5 = Clamp(L_50_0.feet_speed_forwards_or_sideways, 0, 1)

		L_50_4 = L_50_4 + L_50_0.duck_amount * L_50_5 * (0.5 - L_50_4)
	end

	local L_50_6 = L_50_4 * L_50_0.max_yaw
	local L_50_7 = L_50_4 * L_50_0.min_yaw

	if L_50_2 <= L_50_6 then
		if L_50_2 < L_50_7 then
			L_50_1 = math.abs(L_50_7) + L_50_0.eye_angles_y
		end
	else
		L_50_1 = L_50_0.eye_angles_y - math.abs(L_50_6)
	end

	return NormalizeAngle(L_50_1)
end

local L_0_97 = ui.reference("RAGE", "Other", "Delay shot")

function handle_force_delay_shot()
	if ui.get(L_0_88) then
		ui.set(L_0_97, true)
		renderer.indicator(255, 255, 255, 200, "", "MAGIC KEY: ON")
	else
		ui.set(L_0_97, false)
	end
end

ui.set_callback(L_0_88, function()
	handle_force_delay_shot()
end)
client.set_event_callback("paint_ui", function()
	handle_force_delay_shot()
end)

local L_0_98 = ui.reference("RAGE", "Other", "Accuracy boost")

ui.set_callback(L_0_90, function()
	local L_54_0 = ui.get(L_0_98)

	if type(L_54_0) == "string" then
		ui.set(L_0_98, "Maximum")
	elseif type(L_54_0) == "number" then
		ui.set(L_0_98, 4)
	end
end)

local L_0_99 = 6
local L_0_100 = {
	Jitter = {
		JitterCache = 0,
		Difference = 0,
		Jittering = false,
		JitterTicks = 0,
		StaticTicks = 0,
		YawCache = {}
	},
	Main = {
		Side = 0,
		Mode = 0,
		Angles = 0
	}
}
local L_0_101 = {}

local function L_0_102(L_ARG_55_0)
	local L_55_0 = L_0_100.Jitter
	local L_55_1 = entity.get_prop(L_ARG_55_0, "m_angEyeAngles")

	L_55_0.YawCache[L_55_0.JitterCache % L_0_99] = L_55_1

	if L_55_0.JitterCache >= L_0_99 + 1 then
		L_55_0.JitterCache = 0
	else
		L_55_0.JitterCache = L_55_0.JitterCache + 1
	end

	for L_IT_55_0 = 0, L_0_99 do
		if L_IT_55_0 < L_0_99 then
			local L_55_2 = L_55_0.YawCache[L_IT_55_0 - L_55_0.JitterCache % L_0_99] ~= nil and L_55_0.YawCache[L_55_0.JitterCache % L_0_99] ~= nil and math.abs(L_55_0.YawCache[L_IT_55_0 - L_55_0.JitterCache % L_0_99] - L_55_0.YawCache[L_55_0.JitterCache % L_0_99]) or 0

			if L_55_2 ~= nil and L_55_2 ~= 0 then
				NormalizeAngle(L_55_2)

				L_55_0.Jittering = L_55_2 >= 45 * L_0_94(L_ARG_55_0) and true or false
				L_55_0.Difference = L_55_2
			end
		end
	end
end

local function L_0_103(L_ARG_56_0)
	return L_0_100.Jitter.Jittering and 1 or 0
end

local function L_0_104(L_ARG_57_0)
	local L_57_0 = L_0_92(L_ARG_57_0)

	if not L_57_0 then
		return 0
	end

	if L_0_100.Jitter.Jittering and L_0_96(L_ARG_57_0) < 3 then
		L_0_101.FirstNormalizedAngle = NormalizeAngle(L_0_100.Jitter.YawCache[L_0_99 - 1])
		L_0_101.SecondNormalizedAngle = NormalizeAngle(L_0_100.Jitter.YawCache[L_0_99 - 2])
		L_0_101.FirstSinAngle = math.sin(DegToRad(L_0_101.FirstNormalizedAngle))
		L_0_101.SecondSinAngle = math.sin(DegToRad(L_0_101.SecondNormalizedAngle))
		L_0_101.FirstCosAngle = math.cos(DegToRad(L_0_101.FirstNormalizedAngle))
		L_0_101.SecondCosAngle = math.cos(DegToRad(L_0_101.SecondNormalizedAngle))
		L_0_101.AVGYaw = NormalizeAngle(RadToDeg(math.atan2((L_0_101.FirstSinAngle + L_0_101.SecondSinAngle) / 2, (L_0_101.FirstCosAngle + L_0_101.SecondCosAngle) / 2)))
		L_0_101.Difference = NormalizeAngle(L_57_0.eye_angles_y - L_0_101.AVGYaw)

		if L_0_101.Difference ~= 0 then
			L_0_100.Main.Side = L_0_101.Difference > 0 and 1 or -1
		else
			L_0_100.Main.Side = 0
		end
	end

	return L_0_100.Main.Side
end

local L_0_105 = 0

function resetResolverData()
	L_0_100.Jitter.Jittering = false
	L_0_100.Jitter.JitterTicks = 0
	L_0_100.Jitter.StaticTicks = 0
	L_0_100.Jitter.YawCache = {}
	L_0_100.Jitter.JitterCache = 0
	L_0_100.Jitter.Difference = 0
	L_0_100.Main.Mode = 0
	L_0_100.Main.Angles = 0
	L_0_105 = 0
end

function aim_miss(L_ARG_59_0)
	L_0_105 = L_0_105 + 1
end

client.set_event_callback("aim_miss", aim_miss)

function is_baimable(L_ARG_60_0)
	local L_60_0 = entity.get_prop(L_ARG_60_0, "m_iHealth")
	local L_60_1 = ui.get(L_0_78)
	local L_60_2 = ui.get(L_0_77)
	local L_60_3 = ui.get(L_0_79)

	if L_60_2 then
		for L_IT_60_0, L_IT_60_1 in ipairs(L_60_2) do
			if L_IT_60_1 == "hp lower than x value" and L_60_0 > 0 then
				if L_60_0 <= L_60_1 then
					plist.set(L_ARG_60_0, "Override prefer body aim", "Force")
				else
					plist.set(L_ARG_60_0, "Override prefer body aim", "-")
				end
			end
		end
	end

	local L_60_4 = ui.get(L_0_81)
	local L_60_5 = ui.get(L_0_80)

	if L_60_3 then
		for L_IT_60_2, L_IT_60_3 in ipairs(L_60_3) do
			if L_IT_60_3 == "hp lower than x value" and L_60_0 > 0 then
				if L_60_0 <= L_60_5 then
					plist.set(L_ARG_60_0, "Override safe point", "On")
				else
					plist.set(L_ARG_60_0, "Override safe point", "-")
				end
			end
		end
	end

	if L_60_3 then
		for L_IT_60_4, L_IT_60_5 in ipairs(L_60_3) do
			if L_IT_60_5 == "after x misses" then
				if L_60_4 <= L_0_105 and L_60_0 > 0 then
					plist.set(L_ARG_60_0, "Override safe point", "On")
				else
					plist.set(L_ARG_60_0, "Override safe point", "-")
				end
			end
		end
	end
end

client.set_event_callback("player_death", function(L_ARG_61_0)
	L_0_105 = 0
end)

local function L_0_106(L_ARG_62_0)
	local L_62_0 = L_0_92(L_ARG_62_0)

	if not L_62_0 then
		return
	end

	L_0_103(L_ARG_62_0)
	L_0_102(L_ARG_62_0)
	L_0_104(L_ARG_62_0)

	local L_62_1 = L_0_96(L_ARG_62_0)
	local L_62_2 = math.abs(NormalizeAngle(L_62_0.eye_angles_y - L_62_0.torso_yaw))
	local L_62_3 = entity.get_prop(L_ARG_62_0, "m_vecVelocity[0]")
	local L_62_4 = L_62_0.duck_amount > 0.1
	local L_62_5 = math.abs(AngleDifference(L_62_0.eye_angles_y, L_62_0.last_move_yaw)) < 5 and L_62_3 > 10

	if L_62_1 > 2 then
		L_0_100.Main.Angles = 0
		L_0_100.Main.Mode = 0
	elseif L_62_2 >= 40 and L_62_3 > 150 then
		L_0_100.Main.Angles = NormalizeAngle(L_62_0.torso_yaw - L_62_0.eye_angles_y)
		L_0_100.Main.Mode = 1
	elseif L_62_2 > 20 and L_62_4 then
		L_0_100.Main.Angles = NormalizeAngle(L_62_0.torso_yaw - L_62_0.eye_angles_y)
		L_0_100.Main.Mode = 1
	elseif L_62_5 then
		L_0_100.Main.Angles = 0
		L_0_100.Main.Mode = 1
	elseif L_0_100.Jitter.Jittering then
		L_0_100.Main.Angles = L_0_101.Difference ~= nil and L_0_101.Difference * L_0_94(L_ARG_62_0) * L_0_100.Main.Side or 45 * L_0_94(L_ARG_62_0) * L_0_100.Main.Side
		L_0_100.Main.Mode = 1
	else
		L_0_100.Main.Angles = 0
		L_0_100.Main.Mode = 0
	end
end

client.set_event_callback("net_update_end", function()
	local L_63_0 = entity.get_local_player()

	if not L_63_0 or not entity.is_alive(L_63_0) then
		L_0_100.Main.Mode = 0

		return
	end

	local L_63_1 = entity.get_players()

	client.update_player_list()

	for L_IT_63_0, L_IT_63_1 in ipairs(L_63_1) do
		if entity.is_enemy(L_IT_63_1) and L_0_95(L_IT_63_1) and ui.get(L_0_76) then
			L_0_106(L_IT_63_1)
			plist.set(L_IT_63_1, "Force body yaw value", L_0_100.Main.Mode ~= 0 and L_0_100.Main.Angles or 0)
			plist.set(L_IT_63_1, "Force body yaw", L_0_100.Main.Mode ~= 0)
		else
			plist.set(L_IT_63_1, "Force body yaw", false)
		end

		is_baimable(L_IT_63_1)
		plist.set(L_IT_63_1, "Correction active", true)
	end
end)
client.set_event_callback("round_start", function()
	resetResolverData()
end)
client.register_esp_flag("BD", 200, 200, 200, function(L_ARG_65_0)
	return entity.is_enemy(L_ARG_65_0) and ui.get(L_0_76) and L_0_100.Main.Mode == 1 and true or false
end)
client.register_esp_flag("BAIM", 161, 73, 47, function(L_ARG_66_0)
	return plist.get(L_ARG_66_0, "Override prefer body aim") == "Force"
end)
client.register_esp_flag("SAFE", 131, 153, 50, function(L_ARG_67_0)
	return plist.get(L_ARG_67_0, "Override safe point") == "On"
end)
updateMultiboxVisibility()
ui.set_callback(L_0_76, function()
	updateMultiboxVisibility()
	updateSliderVisibility3()
	updateSliderVisibility2()
	updateSliderVisibility()
end)
ui.set_callback(L_0_77, function()
	updateSliderVisibility()
end)
ui.set_callback(L_0_79, function()
	updateSliderVisibility2()
	updateSliderVisibility3()
end)
client.set_event_callback("paint", function()
	if ui.get(L_0_85) == true then
		local L_71_0, L_71_1, L_71_2, L_71_3 = ui.get(L_0_86)

		renderer.indicator(143, 194, 21, 200, "\a" .. rgba_to_hex(L_71_0, L_71_1, L_71_2, L_71_3 * math.abs(math.cos(globals.curtime() * 1))) .. "REFLEX")
	end

	if ui.get(L_0_87) then
		local L_71_4 = entity.get_prop
		local L_71_5 = entity.get_local_player
		local L_71_6 = entity.is_alive
		local L_71_7 = entity.get_player_weapon
		local L_71_8 = entity.get_classname
		local L_71_9 = entity.get_origin
		local L_71_10 = globals.frametime
		local L_71_11 = client.screen_size
		local L_71_12 = globals.framecount
		local L_71_13 = ui.is_menu_open
		local L_71_14 = ui.mouse_position
		local L_71_15 = client.key_state
		local L_71_16 = table.insert
		local L_71_17 = entity.get_steam64
		local L_71_18 = renderer.circle_outline
		local L_71_19 = entity.get_all
		local L_71_20 = globals.tickinterval
		local L_71_21 = client.set_clan_tag

		local threat = client.current_threat()
		local target_name = threat and entity.get_player_name(threat) or "?"

		local L_71_25 = entity.get_local_player()
		local L_71_26, L_71_27, L_71_28, L_71_29 = ui.get(L_0_86)

		if L_71_25 == nil then
			return
		end

		local L_71_30 = math.floor(entity.get_prop(L_71_25, "m_flPoseParameter", 11) * 120 - 60)

		renderer.indicator(255, 255, 255, 200, "", "Target: " .. target_name)
		renderer.indicator(255, 255, 255, 200, "", "Shifting Tickbase: " .. L_0_38.get_tickbase_shifting())
		renderer.indicator(255, 255, 255, 200, "", "Self Desync: " .. math.abs(L_71_30))
	end
end)

local L_0_107 = {
	"generic",
	"head",
	"chest",
	"stomach",
	"left arm",
	"right arm",
	"left leg",
	"right leg",
	"neck",
	"?",
	"gear"
}
local L_0_108 = {
	hegrenade = "Naded",
	knife = "Knifed",
	inferno = "Burned"
}
local L_0_109 = {
	net_channel = function()
		local L_74_0 = {}
		local L_74_1 = L_0_39("void***")
		local L_74_2 = L_0_40(L_74_1, L_0_8("engine.dll", "VEngineClient014"))
		local L_74_3 = L_0_40("void*(__thiscall*)(void*)", L_74_2[0][78])
		local L_74_4 = L_0_39("bool(__thiscall*)(void*)")
		local L_74_5 = L_0_39("bool(__thiscall*)(void*, int, int)")
		local L_74_6 = L_0_39("float(__thiscall*)(void*, int)")
		local L_74_7 = L_0_39("int(__thiscall*)(void*, int)")
		local L_74_8 = L_0_39("void(__thiscall*)(void*, float*, float*, float*)")

		L_0_10("net_update_start", function()
			local L_75_0 = L_0_40(L_74_1, L_74_3(L_74_2)) or L_0_29("net_channel:update:info is nil")
			local L_75_1 = L_0_40(L_74_7, L_75_0[0][17])(L_75_0, 1)

			for L_IT_75_0, L_IT_75_1 in L_0_30({
				seqNr_out = L_75_1,
				is_loopback = L_0_40(L_74_4, L_75_0[0][6])(L_75_0),
				is_timing_out = L_0_40(L_74_4, L_75_0[0][7])(L_75_0),
				latency = {
					crn = function(L_ARG_76_0)
						return L_0_40(L_74_6, L_75_0[0][9])(L_75_0, L_ARG_76_0)
					end,
					average = function(L_ARG_77_0)
						return L_0_40(L_74_6, L_75_0[0][10])(L_75_0, L_ARG_77_0)
					end
				},
				loss = L_0_40(L_74_6, L_75_0[0][11])(L_75_0, 1),
				choke = L_0_40(L_74_6, L_75_0[0][12])(L_75_0, 1),
				got_bytes = L_0_40(L_74_6, L_75_0[0][13])(L_75_0, 1),
				sent_bytes = L_0_40(L_74_6, L_75_0[0][13])(L_75_0, 0),
				is_valid_packet = L_0_40(L_74_5, L_75_0[0][18])(L_75_0, 1, L_75_1 - 1)
			}) do
				L_74_0[L_IT_75_0] = L_IT_75_1
			end
		end)

		function L_74_0.get(L_ARG_78_0)
			return L_74_0.seqNr_out ~= nil and L_74_0 or nil
		end

		return L_74_0
	end,
	aimbot = function(L_ARG_79_0)
		local L_79_0 = {}
		local L_79_1 = {}
		local L_79_2 = {}

		local function L_79_3(L_ARG_80_0)
			return {
				L_ARG_80_0.self_choke > 1 and 1 or 0,
				L_ARG_80_0.velocity_modifier < 1 and 1 or 0,
				L_ARG_80_0.flags.boosted and 1 or 0
			}
		end

		local function L_79_4(L_ARG_81_0, L_ARG_81_1)
			local L_81_0 = L_ARG_81_0.boosted
			local L_81_1 = L_0_31(L_ARG_81_1, "Override safe point")
			local L_81_2 = {
				L_0_32(L_0_83),
				L_0_32(L_0_84) or L_81_1 == "On"
			}

			if not L_81_0 then
				return -1
			end

			if L_81_1 == "Off" or not L_81_2[1] and not L_81_2[2] then
				return 0
			end

			return L_81_2[2] and 2 or L_81_2[1] and 1 or 0
		end

		local function L_79_5(L_ARG_82_0, L_ARG_82_1)
			local L_82_0 = -1

			for L_IT_82_0, L_IT_82_1 in L_0_30(L_79_2) do
				if L_IT_82_1.tick == L_ARG_82_1 then
					local L_82_1 = (L_ARG_82_0.eye - L_ARG_82_0.shot_pos):angles()
					local L_82_2 = (L_ARG_82_0.eye - L_IT_82_1.shot):angles()

					L_82_0 = L_0_36(L_82_1 - L_82_2):length2d()

					break
				end
			end

			return L_82_0
		end

		function L_79_0.fired(L_ARG_83_0)
			local L_83_0 = {}
			local L_83_1 = L_ARG_83_0.target
			local L_83_2 = L_0_53()

			L_79_1[L_ARG_83_0.id] = {
				original = L_ARG_83_0,
				dropped_packets = {},
				handle_time = L_0_17(),
				self_choke = L_0_16(),
				flags = {
					boosted = L_ARG_83_0.boosted
				},
				safety = L_79_4(L_ARG_83_0, L_83_1),
				correction = L_0_31(L_83_1, "Correction active"),
				shot_pos = L_0_36(L_ARG_83_0.x, L_ARG_83_0.y, L_ARG_83_0.z),
				eye = L_0_36(L_0_9()),
				view = L_0_36(L_0_7()),
				velocity_modifier = L_0_49(L_83_2, "m_flVelocityModifier"),
				total_hits = L_0_49(L_83_2, "m_totalHitsOnServer"),
				history = globals.tickcount() - L_ARG_83_0.tick
			}
		end

		function L_79_0.missed(L_ARG_84_0)
			if L_79_1[L_ARG_84_0.id] == nil then
				return
			end

			local L_84_0 = L_79_1[L_ARG_84_0.id]
			local L_84_1 = L_0_41(L_ARG_84_0.id % 15 + 1)
			local L_84_2 = L_ARG_79_0:get()
			local L_84_3 = L_84_2.latency.crn(0) * 1000
			local L_84_4 = L_84_2.latency.average(0) * 1000
			local L_84_5 = L_0_23("delay: %d:%.2f | dropped: %d", L_84_4, L_0_20(L_84_4 - L_84_3), #L_84_0.dropped_packets)
			local L_84_6 = {
				L_0_20(L_84_4 - L_84_3) < 1 and 0 or 1,
				cvar.cl_clock_correction:get_int() == 1 and 0 or 1,
				cvar.cl_clock_correction_force_server_tick:get_int() == 999 and 0 or 1
			}
			local L_84_7 = L_79_5(L_84_0, L_0_18())
			local L_84_8 = L_0_53()
			local L_84_9 = L_0_107[L_ARG_84_0.hitgroup + 1] or "?"
			local L_84_10 = L_0_24(L_0_56(L_ARG_84_0.target))
			local L_84_11 = L_0_62(L_84_0.original.hit_chance + 0.5)
			local L_84_12 = L_79_3(L_84_0)
			local L_84_13 = {
				event_timeout = function()
					L_0_2:add_to_log("Missed " .. L_84_1 .. " shot due to event timeout (target: " .. L_84_10 .. ")", L_84_5)
					L_0_33(L_0_23("Missed %s shot due to event timeout [%s] [%s]", L_84_1, L_84_10, L_84_5))
				end,
				death = function()
					L_0_2:add_to_log("Missed " .. L_84_1 .. " shot at " .. L_84_10 .. "'s " .. L_84_9 .. "(" .. L_84_11 .. "%) due to death [dropped: " .. #L_84_0.dropped_packets .. " | flags: " .. L_0_25(L_84_12) .. " | error: " .. L_0_25(L_84_6) .. "]")
					L_0_33(L_0_23("Missed %s shot at %s's %s(%s%%) due to death [dropped: %d | flags: %s | error: %s]", L_84_1, L_84_10, L_84_9, L_84_11, #L_84_0.dropped_packets, L_0_25(L_84_12), L_0_25(L_84_6)))
				end,
				prediction_error = function(L_ARG_87_0)
					local L_87_0 = L_ARG_87_0 == "unregistered shot" and " [" .. L_ARG_87_0 .. "]" or ""

					L_0_33(L_0_23("Missed %s shot at %s's %s(%s%%) due to prediction error%s [%s] [vel_modifier: %.1f | history(Δ): %d | error: %s]", L_84_1, L_84_10, L_84_9, L_84_11, L_87_0, L_84_5, L_0_49(L_84_8, "m_flVelocityModifier"), L_84_0.history, L_0_25(L_84_6)))
				end,
				spread = function()
					L_0_2:add_to_log("Missed " .. L_84_1 .. " shot at " .. L_84_10 .. "'s " .. L_84_9 .. "(" .. L_84_11 .. "%) due to spread ( dmg: " .. L_84_0.original.damage .. " | safety: " .. L_84_0.safety .. " | history(Δ): " .. L_84_0.history .. " | flags: " .. L_0_25(L_84_12) .. " )")
					L_0_33(L_0_23("Missed %s shot at %s's %s(%s%%) due to spread ( dmg: %d | safety: %d | history(Δ): %d | flags: %s )", L_84_1, L_84_10, L_84_9, L_84_11, L_84_7, L_84_0.original.damage, L_84_0.safety, L_84_0.history, L_0_25(L_84_12)))
				end,
				unknown = function(L_ARG_89_0)
					local L_89_0 = {
						damage_rejected = "damage rejection",
						unknown = L_0_23("unknown [angle: ?° | ?°]")
					}

					L_0_2:add_to_log("Missed " .. L_84_1 .. " shot at " .. L_84_10 .. "'s " .. L_84_9 .. "(" .. L_84_11 .. "%) due to " .. L_89_0[L_ARG_89_0 or "unknown"] .. " ( dmg: " .. L_84_0.original.damage .. " | safety: " .. L_84_0.safety .. " | history(Δ): " .. L_84_0.history .. " | flags: " .. L_0_25(L_84_12) .. " )")
					L_0_33(L_0_23("Missed %s shot at %s's %s(%s%%) due to %s ( dmg: %d | safety: %d | history(Δ): %d | flags: %s )", L_84_1, L_84_10, L_84_9, L_84_11, L_89_0[L_ARG_89_0 or "unknown"], L_84_0.original.damage, L_84_0.safety, L_84_0.history, L_0_25(L_84_12)))
				end
			}
			local L_84_14 = {
				event_timeout = L_0_17() - L_84_0.handle_time >= 0.5,
				damage_rejected = L_ARG_84_0.reason == "?" and L_84_0.total_hits ~= L_0_49(L_84_8, "m_totalHitsOnServer"),
				prediction_error = L_ARG_84_0.reason == "prediction error" or L_ARG_84_0.reason == "unregistered shot"
			}

			if L_84_14.event_timeout then
				L_84_13.event_timeout()
			elseif L_84_14.prediction_error then
				L_84_13.prediction_error(L_ARG_84_0.reason)
			elseif L_ARG_84_0.reason == "spread" then
				L_84_13.spread()
			elseif L_ARG_84_0.reason == "?" then
				L_84_13.unknown(L_84_14.damage_rejected and "damage_rejected" or "unknown")
			elseif L_ARG_84_0.reason == "death" then
				L_84_13.death()
			end

			L_79_1[L_ARG_84_0.id] = nil
		end

		function L_79_0.hit(L_ARG_90_0)
			if L_79_1[L_ARG_90_0.id] == nil then
				return
			end

			local L_90_0 = L_ARG_90_0.target
			local L_90_1 = L_79_1[L_ARG_90_0.id]
			local L_90_2 = L_0_41(L_ARG_90_0.id % 15 + 1)
			local L_90_3 = L_0_53()
			local L_90_4 = L_0_107[L_ARG_90_0.hitgroup + 1] or "?"
			local L_90_5 = L_0_107[L_90_1.original.hitgroup + 1] or "?"
			local L_90_6 = L_0_24(L_0_56(L_ARG_90_0.target))
			local L_90_7 = L_0_62(L_90_1.original.hit_chance + 0.5)
			local L_90_8 = L_79_3(L_90_1)
			local L_90_9 = L_79_5(L_90_1, L_0_18())

			local function L_90_10()
				local L_91_0 = ""
				local L_91_1 = L_90_4 ~= L_90_5
				local L_91_2 = L_ARG_90_0.damage ~= L_90_1.original.damage

				if L_91_1 or L_91_2 then
					L_91_0 = L_0_23(" | mismatch: [ %s ]", (function()
						local L_92_0 = ""

						if L_91_2 then
							L_92_0 = "dmg: " .. L_90_1.original.damage .. (L_91_1 and " | " or "")
						end

						if L_91_1 then
							L_92_0 = L_92_0 .. (L_91_1 and "hitgroup: " .. L_90_5 or "")
						end

						return L_92_0
					end)())
				end

				return L_91_0
			end

			L_0_2:add_to_log("\affe2f3ff[reflex] registered " .. L_90_2 .. " shot in " .. L_90_6 .. "'s " .. L_90_4 .. " for " .. L_ARG_90_0.damage .. " (hitchance: " .. L_90_7 .. " | safety: " .. L_90_1.safety .. " | history(Δ): " .. L_90_1.history .. " | flags: " .. L_0_25(L_90_8) .. ")", L_90_10())
			client.color_log(152, 61, 52, L_0_23("[reflex] Registered %s shot in %s's %s for %d damage \v( hitchance: %d%% | safety: %s | history(Δ): %d | flags: %s%s )", L_90_2, L_90_6, L_90_4, L_ARG_90_0.damage, L_90_7, L_90_1.safety, L_90_1.history, L_0_25(L_90_8), L_90_10()))
		end

		function L_79_0.bullet_impact(L_ARG_93_0)
			local L_93_0 = L_0_18()
			local L_93_1 = L_0_53()

			if L_0_11(L_ARG_93_0.userid) ~= L_93_1 then
				return
			end

			if #L_79_2 > 150 then
				L_79_2 = {}
			end

			L_79_2[#L_79_2 + 1] = {
				tick = L_93_0,
				eye = L_0_36(L_0_9()),
				shot = L_0_36(L_ARG_93_0.x, L_ARG_93_0.y, L_ARG_93_0.z)
			}
		end

		function L_79_0.net_listener()
			if L_ARG_79_0:get() == nil then
				return
			end

			if not L_ARG_79_0.is_valid_packet then
				for L_IT_94_0 in L_0_30(L_79_1) do
					L_0_60(L_79_1[L_IT_94_0].dropped_packets, L_ARG_79_0.seqNr_out)
				end
			end
		end

		return L_79_0
	end
}
local L_0_110 = L_0_109.net_channel()
local L_0_111 = L_0_109.aimbot(L_0_110)

local function L_0_112(L_ARG_95_0)
	local L_95_0 = L_0_11(L_ARG_95_0.attacker)

	if L_95_0 == nil or L_95_0 ~= L_0_53() then
		return
	end

	if (L_0_107[L_ARG_95_0.hitgroup + 1] or "?") == "generic" and L_0_108[L_ARG_95_0.weapon] ~= nil then
		local L_95_1 = L_0_56()

		L_0_33(L_0_23("%s %s for %i damage (%i remaining)", L_0_108[L_ARG_95_0.weapon], L_0_24(L_95_1), L_ARG_95_0.dmg_health, L_ARG_95_0.health))
	end
end

local function L_0_113(L_ARG_96_0)
	local L_96_0 = not L_0_32(L_ARG_96_0) and "un" or ""
	local L_96_1 = client[L_96_0 .. "set_event_callback"]

	L_96_1("aim_fire", L_0_111.fired)
	L_96_1("aim_miss", L_0_111.missed)
	L_96_1("aim_hit", L_0_111.hit)
	L_96_1("bullet_impact", L_0_111.bullet_impact)
	L_96_1("net_update_start", L_0_111.net_listener)
	L_96_1("player_hurt", L_0_112)
end

L_0_34(L_0_82, L_0_113)
L_0_113(L_0_82)

local gradient_alpha = ui.new_slider("LUA", "A", "Gradient alpha", 0, 255, 200)

client.set_event_callback("paint", function()
	local width, height = client.screen_size()
	local local_player = entity.get_local_player()
	if local_player == nil or not entity.is_alive(local_player) then
		return
	end

	local fps = globals.frametime() > 0 and math.floor(1 / globals.frametime()) or 0
	local ping = math.floor(client.latency() * 1000)
	local best_target
	local best_dist = math.huge
	local lx, ly, lz = entity.get_prop(local_player, "m_vecOrigin")
	if lx == nil or ly == nil or lz == nil then
		return
	end

	for _, enemy in ipairs(entity.get_players(true)) do
		if entity.is_alive(enemy) and not entity.is_dormant(enemy) then
			local ex, ey, ez = entity.get_prop(enemy, "m_vecOrigin")
			if ex ~= nil and ey ~= nil and ez ~= nil then
				local dist = (lx - ex)^2 + (ly - ey)^2 + (lz - ez)^2
				if dist < best_dist then
					best_dist = dist
					best_target = enemy
				end
			end
		end
	end

	local target_name = "none"
	local desync_delta = 0
	if best_target then
		target_name = entity.get_player_name(best_target) or "unknown"
		local eye_yaw = entity.get_prop(best_target, "m_angEyeAngles[1]") or 0
		local lby = entity.get_prop(best_target, "m_flLowerBodyYawTarget") or 0
		desync_delta = math.floor(math.abs((eye_yaw - lby + 180) % 360 - 180) + 0.5)
	end

	local icon = ""
	local text = string.format("Reflex Resolver [DEBUG-AI] | Ping: %dms | FPS: %d | Target: %s [Desync ~ %d°]", ping, fps, target_name, desync_delta)
	local icon_width = renderer.measure_text("b", icon)
	local text_width, text_height = renderer.measure_text("b", text)
	local total_width = icon_width + 4 + text_width
	local x, y = width / 2 - total_width / 2, height - 40
	local pulse = math.sin(globals.realtime() * 5.5) * 0.5 + 0.5
	local function lerp(L_ARG_99_0, L_ARG_99_1, L_ARG_99_2)
		return L_ARG_99_0 + (L_ARG_99_1 - L_ARG_99_0) * L_ARG_99_2
	end

	local r1, g1, b1 = lerp(40, 60, pulse), lerp(40, 60, pulse), lerp(40, 100, pulse)
	local r2, g2, b2 = lerp(20, 30, pulse), lerp(20, 30, pulse), lerp(20, 50, pulse)
	local alpha = ui.get(gradient_alpha)
	local text_alpha = math.floor(lerp(200, 255, pulse))
	local bg_x, bg_y = x - 5, y - 3
	local bg_w, bg_h = total_width + 10, text_height + 6

	renderer.rectangle(bg_x - 2, bg_y - 2, bg_w + 4, bg_h + 4, 10, 10, 10, alpha)
	renderer.gradient(bg_x, bg_y, bg_w, bg_h, r1, g1, b1, alpha, r2, g2, b2, alpha, true)
	renderer.text(x + 2, y + 2, 0, 0, 0, 100, "b", 0, icon)
	renderer.text(x + icon_width + 6, y + 2, 0, 0, 0, 100, "b", 0, text)
	renderer.text(x, y, 255, 85, 85, text_alpha, "b", 0, icon)
	renderer.text(x + icon_width + 6, y, 255, 255, 255, text_alpha, "b", 0, text)
end)

local L_0_114 = require("vector")
local L_0_115 = ui.reference("MISC", "Settings", "Menu color")

client.set_event_callback("paint", function()
	local L_100_0, L_100_1, L_100_2, L_100_3 = ui.get(L_0_115)
end)

local L_0_116 = ui.new_checkbox("LUA", "A", string.format("⚙️ Enable \a%02X%02X%02XFF~ Foresight Engine \aFF0000FF[v3]", ui.get(L_0_115)))
local L_0_117 = ui.new_combobox("LUA", "A", "Dependings", {
	"Low Ping < 45",
	"Medium Ping (45-60)",
	"High Ping > 60",
	"Very High Ping > 100"
})

if ui.get(L_0_116) then
	L_0_33("Please, retry to the server after choosing any 'Dependings' in order to apply the predict type.")
end

function predict()
	if not entity.get_local_player() then
		return
	end

	if ui.get(L_0_116) then
		local L_101_0 = ui.get(L_0_117)

		if L_101_0 == "Low Ping < 45" then
			L_0_33("Please, retry to the server in order to apply the predict type.")
			cvar.cl_interp:set_float(0.015)
			cvar.cl_interp_ratio:set_int(1)
			cvar.cl_interpolate:set_int(1)
		elseif L_101_0 == "Medium Ping (45-60)" then
			L_0_33("Please, retry to the server in order to apply the predict type.")
			cvar.cl_interp:set_float(0.02)
			cvar.cl_interp_ratio:set_int(1)
			cvar.cl_interpolate:set_int(1)
		elseif L_101_0 == "High Ping > 60" then
			L_0_33("Please, retry to the server in order to apply the predict type.")
			cvar.cl_interp:set_float(0.025)
			cvar.cl_interp_ratio:set_int(2)
			cvar.cl_interpolate:set_int(1)
		elseif L_101_0 == "Very High Ping > 100" then
			L_0_33("Please, retry to the server in order to apply the predict type.")
			cvar.cl_interp:set_float(0.035)
			cvar.cl_interp_ratio:set_int(2)
			cvar.cl_interpolate:set_int(0)
		else
			L_0_33("Please, retry to the server in order to apply the predict type.")
			cvar.cl_interp:set_float(0.016)
			cvar.cl_interp_ratio:set_int(1)
			cvar.cl_interpolate:set_int(0)
		end
	end
end

local L_0_118 = ui.new_checkbox("LUA", "A", "\aD1CE8BFF Defensive Fix")

function vec_3(L_ARG_102_0, L_ARG_102_1, L_ARG_102_2)
	return {
		x = L_ARG_102_0 or 0,
		y = L_ARG_102_1 or 0,
		z = L_ARG_102_2 or 0
	}
end

function ticks_to_time()
	return globals.tickinterval() * 16
end

local L_0_119 = {
	dt = {
		ui.reference("RAGE", "Aimbot", "Double tap")
	}
}

function player_will_peek()
	local L_104_0 = entity.get_players(true)

	if not L_104_0 then
		return false
	end

	local L_104_1 = vec_3(client.eye_position())
	local L_104_2 = vec_3(entity.get_prop(entity.get_local_player(), "m_vecVelocity"))
	local L_104_3 = vec_3(L_104_1.x + L_104_2.x * ticks_to_time(predicted), L_104_1.y + L_104_2.y * ticks_to_time(predicted), L_104_1.z + L_104_2.z * ticks_to_time(predicted))

	for L_IT_104_0 = 1, #L_104_0 do
		local L_104_4 = L_104_0[L_IT_104_0]
		local L_104_5 = vec_3(entity.get_prop(L_104_4, "m_vecVelocity"))
		local L_104_6 = vec_3(entity.get_prop(L_104_4, "m_vecOrigin"))
		local L_104_7 = vec_3(L_104_6.x + L_104_5.x * ticks_to_time(), L_104_6.y + L_104_5.y * ticks_to_time(), L_104_6.z + L_104_5.z * ticks_to_time())

		entity.get_prop(L_104_4, "m_vecOrigin", L_104_7)

		local L_104_8 = vec_3(entity.hitbox_position(L_104_4, 0))
		local L_104_9 = vec_3(L_104_8.x + L_104_5.x * ticks_to_time(), L_104_8.y + L_104_5.y * ticks_to_time(), L_104_8.z + L_104_5.z * ticks_to_time())
		local L_104_10, L_104_11 = client.trace_bullet(entity.get_local_player(), L_104_3.x, L_104_3.y, L_104_3.z, L_104_9.x, L_104_9.y, L_104_9.z)

		entity.get_prop(L_104_4, "m_vecOrigin", L_104_6)

		if L_104_11 > 0 then
			return true
		end
	end

	return false
end

client.set_event_callback("setup_command", function(L_ARG_105_0)
	if not ui.get(L_0_118) then
		return
	end

	if not (ui.get(L_0_119.dt[1]) and ui.get(L_0_119.dt[2])) then
		return
	end

	if player_will_peek() then
		L_ARG_105_0.force_defensive = true
	end
end)

local L_0_120 = ui.new_checkbox("LUA", "A", string.format(" Enable \a%02X%02X%02XFF~ 100$ desync fix \aFF0000FF[beta]", ui.get(L_0_115)))
local L_0_121 = ui.new_label("LUA", "A", "\aFFFFFF44it's a test version.")
local L_0_122 = {}

function table_contains_v(L_ARG_106_0, L_ARG_106_1)
	for L_IT_106_0, L_IT_106_1 in L_0_30(L_ARG_106_0) do
		if L_IT_106_1 == L_ARG_106_1 then
			return true
		end
	end

	return false
end

function get_random_angle(L_ARG_107_0)
	local L_107_0

	repeat
		L_107_0 = math.random(-60, 60)
	until not table_contains_v(L_ARG_107_0, L_107_0)

	return L_107_0
end

function angles_to_string(L_ARG_108_0)
	if #L_ARG_108_0 == 0 then
		return "none"
	end

	return table.concat(L_ARG_108_0, ", ")
end

function on_miss_resolver(L_ARG_109_0)
	if L_ARG_109_0.reason == "spread" or L_ARG_109_0.reason == "prediction error" or L_ARG_109_0.reason == "death" then
		
	else
		local L_109_0 = L_ARG_109_0.target

		if not entity.is_alive(L_109_0) then
			return
		end

		if not L_0_122[L_109_0] then
			L_0_122[L_109_0] = {}
		end

		local L_109_1 = plist.get(L_109_0, "Force body yaw value") or 0
		local L_109_2 = get_random_angle(L_0_122[L_109_0])

		plist.set(L_109_0, "Correction active", true)
		plist.set(L_109_0, "Force body yaw", true)
		plist.set(L_109_0, "Force body yaw value", L_109_2)
		table.insert(L_0_122[L_109_0], L_109_2)

		local L_109_3 = entity.get_player_name(L_109_0) or "Unknown"
		local L_109_4 = angles_to_string(L_0_122[L_109_0])

		if ui.get(L_0_120) then
			L_0_2:add_to_log("Missed " .. L_109_3 .. ": missed angle " .. L_109_1 .. ", new angle " .. L_109_2 .. ", excluded angles: " .. L_109_4)
		end
	end
end

client.set_event_callback("aim_miss", on_miss_resolver)

local L_0_123 = "debug"

if L_0_1 == "admin" then
	L_0_123 = "source"
end

local L_0_124 = 0

local function L_0_125(L_ARG_110_0, L_ARG_110_1, L_ARG_110_2)
	return L_ARG_110_0 + (L_ARG_110_1 - L_ARG_110_0) * L_ARG_110_2
end

local L_0_126 = "Analyzing"
local L_0_127 = "Thinking"
local L_0_128 = 0
local L_0_129 = 0
local L_0_130 = {
	"Advanced",
	"Alternative"
}
local L_0_131 = ui.new_combobox("LUA", "A", "Resolver modes", L_0_130)
local L_0_132 = 0
local L_0_133 = 0

client.set_event_callback("player_hurt", function(L_ARG_111_0)
	local L_111_0 = entity.get_local_player()

	if client.userid_to_entindex(L_ARG_111_0.attacker) == L_111_0 then
		L_0_132 = L_0_132 + 1
	end
end)
client.set_event_callback("aim_miss", function(L_ARG_112_0)
	L_0_133 = L_0_133 + 1
end)
client.set_event_callback("player_death", function(L_ARG_113_0)
	if client.userid_to_entindex(L_ARG_113_0.attacker) == entity.get_local_player() then
		L_0_126 = "\aAD1010FFResetting data!"
		L_0_128 = globals.realtime() + 1.2
	end
end)
client.set_event_callback("player_death", function(L_ARG_114_0)
	if client.userid_to_entindex(L_ARG_114_0.attacker) == entity.get_local_player() then
		L_0_127 = "\aAD1010FFRestoring"
		L_0_129 = globals.realtime() + 1.7
	end
end)

function get_hitrate()
	local L_115_0 = L_0_132 + L_0_133

	if L_115_0 > 0 then
		return L_0_132 / L_115_0 * 100
	else
		return 0
	end
end

client.set_event_callback("paint", function()
	local L_116_0 = ui.is_menu_open()
	local L_116_1 = L_116_0 and 200 or 0
	local L_116_2 = L_116_0 and 0.2 or 0.6

	L_0_124 = L_0_125(L_0_124, L_116_1, L_116_2)

	if L_0_124 < 1 then
		return
	end

	if globals.realtime() > L_0_128 then
		L_0_126 = "\a63B721FFAnalyzing"
	end

	if globals.realtime() > L_0_129 then
		L_0_127 = "\a63B721FFThinking"
	end

	local L_116_3, L_116_4 = ui.menu_position()
	local L_116_5, L_116_6 = ui.menu_size()
	local L_116_7 = L_116_3 + L_116_5 + 10
	local L_116_8 = L_116_4
	local L_116_9 = 260
	local L_116_10 = 200
	local L_116_11 = ui.get(L_0_131)
	local L_116_12 = get_hitrate()
	local L_116_13 = string.format("Hitrate: %.1f%%", L_116_12)

	renderer.rectangle(L_116_7, L_116_8, L_116_9, L_116_10, 30, 30, 30, L_0_124)
	renderer.text(L_116_7 + 70, L_116_8 + 10, 255, 255, 255, L_0_124, "b", 0, "Reflex Logic Resolver")
	renderer.text(L_116_7 + 10, L_116_8 + 30, 200, 200, 200, L_0_124, "b", 0, "User: " .. L_0_1)
	renderer.text(L_116_7 + 10, L_116_8 + 50, 200, 200, 200, L_0_124, "b", 0, "The current build of script: " .. L_0_123)
	renderer.text(L_116_7 + 10, L_116_8 + 70, 200, 200, 200, L_0_124, "b", 0, "Resolver status: " .. L_0_126)
	renderer.text(L_116_7 + 10, L_116_8 + 90, 200, 200, 200, L_0_124, "b", 0, "Hits: \a63B721FF" .. L_0_132)
	renderer.text(L_116_7 + 10, L_116_8 + 110, 200, 200, 200, L_0_124, "b", 0, "Misses: \aAD1010FF" .. L_0_133)
	renderer.text(L_116_7 + 10, L_116_8 + 130, 200, 200, 200, L_0_124, "b", 0, "Resolver mode: " .. L_116_11)
	renderer.text(L_116_7 + 10, L_116_8 + 150, 200, 200, 200, L_0_124, "b", 0, "" .. L_116_13)
	renderer.text(L_116_7 + 10, L_116_8 + 170, 200, 200, 200, L_0_124, "b", 0, "Neural Debug: \a63B721FF" .. L_0_127)
end)

local L_0_134 = ui.new_checkbox("lua", "a", " Experimental AI-BruteForce \aFF0000FF[reflex + neural]")
local L_0_135 = ui.new_checkbox("lua", "a", "~ debug data")
local L_0_136 = entity.get_prop
local L_0_137 = entity.get_local_player
local L_0_138 = entity.is_alive
local L_0_139 = entity.get_player_weapon
local L_0_140 = entity.get_classname
local L_0_141 = entity.get_origin
local L_0_142 = globals.frametime
local L_0_143 = client.screen_size
local L_0_144 = globals.framecount
local L_0_145 = ui.is_menu_open
local L_0_146 = ui.mouse_position
local L_0_147 = client.key_state
local L_0_148 = table.insert
local L_0_149 = entity.get_steam64
local L_0_150 = renderer.circle_outline
local L_0_151 = entity.get_all
local L_0_152 = globals.tickinterval
local L_0_153 = client.set_clan_tag

local function shitupd()
	if ui.get(L_0_134) then
		ui.set_visible(L_0_135, true)
		local threat = client.current_threat()
		local target_name = threat and entity.get_player_name(threat) or "?"
		L_0_2:add_to_log("bruteforce started working | current state: scanning " .. target_name)
	else
		ui.set_visible(L_0_135, false)
	end
end

local function get_lagcomp_ticks(L_ARG_118_0)
	if not L_ARG_118_0 or entity.is_dormant(L_ARG_118_0) or not entity.is_alive(L_ARG_118_0) then
		return 0
	end

	local L_118_0 = entity.get_prop(L_ARG_118_0, "m_flSimulationTime")

	if not L_118_0 then
		return 0
	end

	local L_118_1 = globals.curtime()
	local L_118_2 = globals.tickinterval()

	return (math.floor((L_118_1 - L_118_0) / L_118_2 + 0.5))
end

local function log_enemy_data()
	if not ui.get(L_0_135) then
		return
	end

	local L_119_0 = entity.get_players(true)
	local lines = {}

	for L_IT_119_0 = 1, #L_119_0 do
		local L_119_1 = L_119_0[L_IT_119_0]
		local L_119_2 = entity.get_prop(L_119_1, "m_angEyeAngles[1]") or 0
		local L_119_3 = get_lagcomp_ticks(L_119_1)
		local enemy_name = entity.get_player_name(L_119_1) or "?"
		lines[#lines + 1] = string.format("Enemy %s | Yaw: %.1f | LagComp: %d ticks", enemy_name, L_119_2, L_119_3)
	end

	writefile("reflex//debug_log.txt", table.concat(lines, "\n"))

	if ui.get(L_0_135) then
		client.delay_call(3, log_enemy_data)
	end
end

ui.set_callback(L_0_135, function()
	if ui.get(L_0_135) then
		log_enemy_data()
	end
end)
shitupd()
ui.set_callback(L_0_134, function()
	shitupd()
end)

local L_0_157 = require("vector")
local L_0_158 = {
	ind = {
		1,
		2,
		3,
		4,
		5,
		6,
		7
	},
	name = {
		"head",
		"chest",
		"stomach",
		"left_arm",
		"right_arm",
		"left_leg",
		"right_leg"
	}
}
local L_0_159 = {
	dt = {
		ui.reference("RAGE", "Aimbot", "Double tap")
	},
	quickPeek = {
		ui.reference("RAGE", "Other", "Quick peek assist")
	}
}
local L_0_160 = ui.new_hotkey("lua", "A", " AI PEEK")

function doubletap_charged()
	if not ui.get(L_0_159.dt[1]) or not ui.get(L_0_159.dt[2]) then
		return false
	end

	if not entity.is_alive(entity.get_local_player()) or entity.get_local_player() == nil then
		return
	end

	local L_122_0 = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")

	if L_122_0 == nil then
		return false
	end

	local L_122_1 = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.25
	local L_122_2 = entity.get_prop(L_122_0, "m_flNextPrimaryAttack")

	if L_122_2 == nil then
		return
	end

	local L_122_3 = L_122_2 + 0.5

	if L_122_1 == nil or L_122_3 == nil then
		return false
	end

	return L_122_1 - globals.curtime() < 0 and L_122_3 - globals.curtime() < 0
end

local L_0_161 = {
	start_position = L_0_157(0, 0, 0),
	cache_eye_left = L_0_157(0, 0, 0),
	cache_eye_right = L_0_157(0, 0, 0),
	left_trace_active,
	right_trace_active,
	peekbot_active,
	tracer_position,
	lerp_distance = 0,
	calculate_wall_dist_left = 0,
	shot_fired = false,
	calculate_wall_dist_right = 0,
	reload_timer = 0,
	reached_max_distance = false,
	set_location = true,
	should_return = false
}

function d_lerp(L_ARG_123_0, L_ARG_123_1, L_ARG_123_2)
	return L_ARG_123_0 + (L_ARG_123_1 - L_ARG_123_0) * L_ARG_123_2
end

function degree_to_radian(L_ARG_124_0)
	return math.pi / 180 * L_ARG_124_0
end

function angle_to_vector(L_ARG_125_0, L_ARG_125_1)
	local L_125_0 = degree_to_radian(L_ARG_125_0)
	local L_125_1 = degree_to_radian(L_ARG_125_1)

	return math.cos(L_125_0) * math.cos(L_125_1), math.cos(L_125_0) * math.sin(L_125_1), -math.sin(L_125_0)
end

function set_movement(L_ARG_126_0, L_ARG_126_1)
	local L_126_0 = entity.get_local_player()
	local L_126_1 = {
		L_0_157(entity.get_origin(L_126_0)):to(L_ARG_126_1):angles()
	}
	local L_126_2 = L_126_1[1]
	local L_126_3 = L_126_1[2]

	L_ARG_126_0.in_forward = 1
	L_ARG_126_0.in_back = 0
	L_ARG_126_0.in_moveleft = 0
	L_ARG_126_0.in_moveright = 0
	L_ARG_126_0.in_speed = 0
	L_ARG_126_0.forwardmove = 800
	L_ARG_126_0.sidemove = 0
	L_ARG_126_0.move_yaw = L_126_3
end

function do_return(L_ARG_127_0)
	if L_0_161.start_position and L_0_161.should_return then
		local L_127_0 = L_0_157(entity.get_origin(entity.get_local_player()))

		if L_0_161.start_position:dist2d(L_127_0) > 5 then
			if not client.key_state(87) and not client.key_state(65) and not client.key_state(83) and not client.key_state(68) and not ui.get(L_0_159.quickPeek[2]) then
				set_movement(L_ARG_127_0, L_0_161.start_position)
			end
		else
			L_0_161.should_return = false
			L_0_161.shot_fired = false
			L_0_161.reached_max_distance = false
		end
	end
end

function peek_bot(L_ARG_128_0)
	local L_128_0 = globals.frametime() * 15

	L_0_161.lerp_distance = d_lerp(L_0_161.lerp_distance, ui.get(L_0_160) and 50 or 0, L_128_0)

	if not ui.get(L_0_160) then
		return
	end

	if not ui.get(L_0_159.quickPeek[2]) then
		L_0_161.set_location = true
		L_0_161.lerp_distance = 0

		return
	end

	local L_128_1 = L_0_157(client.eye_position())
	local L_128_2 = L_0_157(entity.get_origin(entity.get_local_player()))

	if L_0_161.set_location then
		L_0_161.start_position = L_128_2
		L_0_161.set_location = false
	end

	do_return(L_ARG_128_0)

	local L_128_3 = client.current_threat()

	if not L_128_3 or entity.is_dormant(L_128_3) then
		return
	end

	if L_0_161[L_128_3] == nil then
		L_0_161[L_128_3] = {
			stomach = false,
			chest = false,
			right_arm = false,
			head = false,
			left_leg = false,
			right_leg = false,
			left_arm = false
		}
	end

	local L_128_4 = L_0_157(entity.get_origin(L_128_3))
	local L_128_5 = L_128_1.x - L_128_4.x
	local L_128_6 = L_128_1.y - L_128_4.y
	local L_128_7 = math.atan2(L_128_6, L_128_5) * (180 / math.pi)
	local L_128_8, L_128_9, L_128_10 = angle_to_vector(0, L_128_7 - 90)
	local L_128_11, L_128_12, L_128_13 = angle_to_vector(0, L_128_7 + 90)
	local L_128_14 = L_0_157(L_128_8 * math.max(0, L_0_161.lerp_distance - L_0_161.calculate_wall_dist_left) + L_128_1.x, L_128_9 * math.max(0, L_0_161.lerp_distance - L_0_161.calculate_wall_dist_left) + L_128_1.y, L_128_1.z)
	local L_128_15 = L_0_157(L_128_11 * math.max(0, L_0_161.lerp_distance - L_0_161.calculate_wall_dist_right) + L_128_1.x, L_128_12 * math.max(0, L_0_161.lerp_distance - L_0_161.calculate_wall_dist_right) + L_128_1.y, L_128_1.z)
	local L_128_16 = L_0_157(L_128_8 * L_0_161.lerp_distance * 1.2 + L_128_1.x, L_128_9 * L_0_161.lerp_distance * 1.2 + L_128_1.y, L_128_1.z)
	local L_128_17 = L_0_157(L_128_11 * L_0_161.lerp_distance * 1.2 + L_128_1.x, L_128_12 * L_0_161.lerp_distance * 1.2 + L_128_1.y, L_128_1.z)

	L_0_161.cache_eye_left = L_128_14
	L_0_161.cache_eye_right = L_128_15

	for L_IT_128_0, L_IT_128_1 in L_0_30(L_0_158.ind) do
		local L_128_18 = L_0_157(entity.hitbox_position(L_128_3, L_IT_128_1))
		local L_128_19, L_128_20 = client.trace_bullet(entity.get_local_player(), L_128_14.x, L_128_14.y, L_128_14.z, L_128_18.x, L_128_18.y, L_128_18.z, false)
		local L_128_21, L_128_22 = client.trace_bullet(entity.get_local_player(), L_128_15.x, L_128_15.y, L_128_15.z, L_128_18.x, L_128_18.y, L_128_18.z, false)
		local L_128_23 = client.trace_line(0, L_128_14.x, L_128_14.y, L_128_14.z, L_128_16.x, L_128_16.y, L_128_16.z)
		local L_128_24 = client.trace_line(0, L_128_15.x, L_128_15.y, L_128_15.z, L_128_17.x, L_128_17.y, L_128_17.z)

		if L_128_23 ~= 1 then
			L_0_161.calculate_wall_dist_left = (1 - L_128_23) * 100
		else
			L_0_161.calculate_wall_dist_left = 0
		end

		if L_128_24 ~= 1 then
			L_0_161.calculate_wall_dist_right = (1 - L_128_24) * 100
		else
			L_0_161.calculate_wall_dist_right = 0
		end

		if L_128_19 or L_128_21 then
			L_0_161[L_128_3][L_0_158.name[L_IT_128_1]] = true

			if L_128_19 and not L_0_161.right_trace_active then
				L_0_161.tracer_position = L_128_14
				L_0_161.left_trace_active = true
			else
				L_0_161.left_trace_active = false
			end

			if L_128_21 and not L_0_161.left_trace_active then
				L_0_161.tracer_position = L_128_15
				L_0_161.right_trace_active = true
			else
				L_0_161.right_trace_active = false
			end
		else
			L_0_161[L_128_3][L_0_158.name[L_IT_128_1]] = false
		end
	end

	if L_0_161[L_128_3].head or L_0_161[L_128_3].chest or L_0_161[L_128_3].stomach or L_0_161[L_128_3].left_arm or L_0_161[L_128_3].right_arm or L_0_161[L_128_3].left_leg or L_0_161[L_128_3].right_leg then
		L_0_161.peekbot_active = true
	else
		L_0_161.peekbot_active = false
	end

	if L_0_161.start_position:dist2d(L_128_2) > 70 then
		L_0_161.reached_max_distance = true
	end

	if L_0_161.peekbot_active and not L_0_161.shot_fired and L_0_161.reload_timer < globals.realtime() and not L_0_161.reached_max_distance then
		if L_0_161.peekbot_active and L_0_161.left_trace_active and doubletap_charged() then
			set_movement(L_ARG_128_0, L_128_14)
		elseif L_0_161.peekbot_active and L_0_161.right_trace_active and doubletap_charged() then
			set_movement(L_ARG_128_0, L_128_15)
		end
	else
		L_0_161.should_return = true
	end
end

local L_0_162 = ui.reference("RAGE", "Other", "Quick peek assist mode")
local L_0_163 = false

client.set_event_callback("run_command", function()
	local L_129_0 = ui.get(L_0_160)

	if L_129_0 and not L_0_163 then
		ui.set(L_0_162, "Retreat on key release")
	elseif not L_129_0 and L_0_163 then
		ui.set(L_0_162, "Retreat on shot")
	end

	L_0_163 = L_129_0
end)

function renderer_trace_positions()
	if ui.get(L_0_160) and ui.get(L_0_159.quickPeek[2]) then
		renderer.indicator(255, 255, 255, 255, "AI PEEK ENABLED")

		local L_130_0 = entity.get_local_player()

		if not L_130_0 or not entity.is_alive(L_130_0) then
			return
		end

		local L_130_1 = {
			entity.get_origin(L_130_0)
		}
		local L_130_2 = client.current_threat()

		if not L_130_2 or entity.is_dormant(L_130_2) then
			return
		end

		local L_130_3 = {
			entity.get_origin(L_130_2)
		}
		local L_130_4 = L_130_3[1] - L_130_1[1]
		local L_130_5 = L_130_3[2] - L_130_1[2]
		local L_130_6 = math.atan2(L_130_5, L_130_4) * (180 / math.pi)
		local L_130_7 = {
			255,
			255,
			255
		}
		local L_130_8 = {
			255,
			255,
			255
		}

		if L_0_161.peekbot_active then
			if L_0_161.left_trace_active then
				L_130_7 = {
					100,
					100,
					255
				}
			elseif L_0_161.right_trace_active then
				L_130_8 = {
					100,
					100,
					255
				}
			end
		end

		draw_3d_box(L_130_1, L_130_6 - 90, L_130_8)
		draw_3d_box(L_130_1, L_130_6 + 90, L_130_7)
	end
end

function draw_3d_box(L_ARG_131_0, L_ARG_131_1, L_ARG_131_2)
	local L_131_0 = 20
	local L_131_1 = math.rad(L_ARG_131_1)
	local L_131_2 = {
		L_ARG_131_0[1] + math.cos(L_131_1) * L_131_0,
		L_ARG_131_0[2] + math.sin(L_131_1) * L_131_0,
		L_ARG_131_0[3]
	}
	local L_131_3 = 20
	local L_131_4 = 60
	local L_131_5 = 20
	local L_131_6 = {
		L_131_2[1] - L_131_3 / 2,
		L_131_2[2] - L_131_5 / 2,
		L_131_2[3]
	}
	local L_131_7 = {
		L_131_2[1] + L_131_3 / 2,
		L_131_2[2] + L_131_5 / 2,
		L_131_2[3] + L_131_4
	}
	local L_131_8 = {
		{
			L_131_6[1],
			L_131_6[2],
			L_131_6[3]
		},
		{
			L_131_6[1],
			L_131_7[2],
			L_131_6[3]
		},
		{
			L_131_7[1],
			L_131_7[2],
			L_131_6[3]
		},
		{
			L_131_7[1],
			L_131_6[2],
			L_131_6[3]
		},
		{
			L_131_6[1],
			L_131_6[2],
			L_131_7[3]
		},
		{
			L_131_6[1],
			L_131_7[2],
			L_131_7[3]
		},
		{
			L_131_7[1],
			L_131_7[2],
			L_131_7[3]
		},
		{
			L_131_7[1],
			L_131_6[2],
			L_131_7[3]
		}
	}
	local L_131_9 = {
		{
			1,
			2
		},
		{
			2,
			3
		},
		{
			3,
			4
		},
		{
			4,
			1
		},
		{
			5,
			6
		},
		{
			6,
			7
		},
		{
			7,
			8
		},
		{
			8,
			5
		},
		{
			1,
			5
		},
		{
			2,
			6
		},
		{
			3,
			7
		},
		{
			4,
			8
		}
	}

	for L_IT_131_0, L_IT_131_1 in L_0_30(L_131_9) do
		local L_131_10 = {
			renderer.world_to_screen(L_131_8[L_IT_131_1[1]][1], L_131_8[L_IT_131_1[1]][2], L_131_8[L_IT_131_1[1]][3])
		}
		local L_131_11 = {
			renderer.world_to_screen(L_131_8[L_IT_131_1[2]][1], L_131_8[L_IT_131_1[2]][2], L_131_8[L_IT_131_1[2]][3])
		}

		if L_131_10[1] and L_131_11[1] then
			renderer.line(L_131_10[1], L_131_10[2], L_131_11[1], L_131_11[2], L_ARG_131_2[1], L_ARG_131_2[2], L_ARG_131_2[3], 255)
		end
	end
end

client.set_event_callback("setup_command", peek_bot)
client.set_event_callback("paint_ui", renderer_trace_positions)

if L_0_1 == "admin" then
	local L_0_164 = ui.new_hotkey("LUA", "A", "Resolvation", true)
	local L_0_165 = false

	client.set_event_callback("run_command", function()
		local L_132_0 = ui.get(L_0_164)

		if L_132_0 and not L_0_165 then
			client.exec("sm_sanchezgg")
		end

		if not L_132_0 and L_0_165 then
			client.exec("sm_sanchezgg")
		end

		L_0_165 = L_132_0
	end)
end

local L_0_166 = {
	http = require("gamesense/http"),
	json = require("json"),
	vector = require("vector"),
	pui = require("gamesense/pui"),
	bit = require("bit"),
	ffi = require("ffi"),
	csgo_weapons = require("gamesense/csgo_weapons"),
	msgpack = require("gamesense/msgpack"),
	clipboard = require("gamesense/clipboard"),
	base64 = require("gamesense/base64")
}
local L_0_167 = {
	dpi = ui.reference("MISC", "Settings", "DPI scale"),
	delay_shot = ui.reference("Rage", "Other", "Delay shot"),
	peek = {
		ui.reference("Rage", "Other", "Quick peek assist")
	},
	slow = {
		ui.reference("AA", "Other", "Slow motion")
	}
}

;({}).mp = {
	L_0_166.pui.reference("Rage", "Aimbot", "Multi-point")
}

local L_0_168 = false
local L_0_169 = {}
local L_0_170 = L_0_166.pui.group("Rage", "Other")
local L_0_171 = {
	"G3SG1 / SCAR-20",
	"SSG 08",
	"AWP",
	"R8 Revolver",
	"Desert Eagle",
	"Pistol",
	"Zeus"
}

ui.new_label("Rage", "Other", " ")

local L_0_172 = {
	tabs = L_0_170:combobox("Aimtools \v[RELEASE]", {
		" Aimtools",
		" Ragebot",
		" Visuals",
		" Config"
	}),
	enable = L_0_170:checkbox("Aimtools"),
	weapon_select = L_0_170:combobox("Weapon", L_0_171),
	aimtool = {}
}
local L_0_173 = {
	peek_helper = L_0_170:checkbox("\v\r Peek helper"),
	helper_visual = L_0_170:combobox("\n", {
		"Crosshair",
		"World lines"
	}),
	y_offset = L_0_170:slider("Y offset", -300, 300, 40, true, "px", 1),
	auto_lc = L_0_170:checkbox("\v\r Automatic teleport"),
	auto_lc_k = L_0_170:hotkey("\v\r Automatic teleport", true),
	dormant = L_0_170:checkbox("\v\r Dormant aimbot"),
	dormant_k = L_0_170:hotkey("\v\r Dormant aimbot", true),
	delay_shot = L_0_170:checkbox("\v\r Delay shot on key"),
	delay_key = L_0_170:hotkey("\v\r Delay shot on key", true),
	air_stop_enable = L_0_170:checkbox("\v\r Air stop"),
	air_stop_mode = L_0_170:combobox("\n", {
		"On hotkey",
		"Cycle",
		"High priority"
	}),
	air_stop_k = L_0_170:hotkey("Air stop hotkey")
}
local L_0_174 = {
	flag_indicators = L_0_170:checkbox("\v\r Flags Indicators"),
	flag_indicators_v = L_0_170:multiselect("\n", {
		"Body aim",
		"Safe point",
		"Multi-point",
		"Dormant aimbot"
	}),
	dormant_indicator = L_0_170:checkbox("\v\r Dormant indicator"),
	dormant_color = L_0_170:color_picker("\v\r Dormant indicator", 0, 255, 0, 255),
	hit_logs = L_0_170:checkbox("\v\r Screen Logger")
}
local L_0_175 = {
	export = L_0_170:button("\v\r Export", function()
		return
	end),
	import = L_0_170:button("\v\r Import", function()
		return
	end),
	slider_v = L_0_170:slider("\n", 1, 2, 1, true, nil, 1, {
		[1] = "Default",
		[2] = "$SvnHvH"
	}),
	cfg_marolower = L_0_170:button("Load \vDefault \rcfg", function()
		return
	end),
	cfg_hakkai = L_0_170:button("Load \vSvnHvH \rcfg", function()
		return
	end)
}
local L_0_176 = {
	["G3SG1 / SCAR-20"] = {
		11,
		38
	},
	["SSG 08"] = {
		40
	},
	AWP = {
		9
	},
	["R8 Revolver"] = {
		64
	},
	["Desert Eagle"] = {
		1
	},
	Pistol = {
		2,
		3,
		4,
		30,
		32,
		36,
		61,
		63
	},
	Zeus = {
		31
	}
}

for L_IT_0_0 = 1, #L_0_171 do
	L_0_172.aimtool[L_IT_0_0] = {
		force_baim = L_0_170:checkbox("\v\r Override prefer body aim"),
		baim_select = L_0_170:multiselect("Enable on:", {
			"Enemy health < X",
			"Enemy higher than you"
		}),
		baim_x_hp = L_0_170:slider("X hp:", 20, 100, 92),
		force_sp = L_0_170:checkbox("\v\r Override prefer safe points"),
		sp_select = L_0_170:multiselect("Enable on:", {
			"Enemy health < X",
			"Enemy higher than you"
		}),
		sp_x_hp = L_0_170:slider("X hp:", 20, 100, 92),
		multipoints = L_0_170:checkbox("\v\r Override multipoints"),
		m_1 = L_0_170:slider("[" .. L_0_171[L_IT_0_0] .. "] Standing", 25, 100, 50),
		m_2 = L_0_170:slider("[" .. L_0_171[L_IT_0_0] .. "] Moving", 25, 100, 50),
		m_3 = L_0_170:slider("[" .. L_0_171[L_IT_0_0] .. "] Slow", 25, 100, 50),
		m_4 = L_0_170:slider("[" .. L_0_171[L_IT_0_0] .. "] Duck", 25, 100, 50),
		m_5 = L_0_170:slider("[" .. L_0_171[L_IT_0_0] .. "] Duck move", 25, 100, 50),
		accuracy = L_0_170:checkbox("\v\r Override accuracy boost"),
		ab = L_0_170:combobox("Accuracy mode", {
			"Low",
			"Medium",
			"High",
			"Maximum"
		})
	}
end

for L_IT_0_1, L_IT_0_2 in L_0_30(L_0_173) do
	L_IT_0_2:depend({
		L_0_172.tabs,
		" Ragebot"
	})
end

for L_IT_0_3, L_IT_0_4 in L_0_30(L_0_174) do
	L_IT_0_4:depend({
		L_0_172.tabs,
		" Visuals"
	})
end

for L_IT_0_5, L_IT_0_6 in L_0_30(L_0_175) do
	L_IT_0_6:depend({
		L_0_172.tabs,
		" Config"
	})
end

L_0_175.cfg_marolower:depend({
	L_0_172.tabs,
	" Config"
}, {
	L_0_175.slider_v,
	1
})
L_0_175.cfg_hakkai:depend({
	L_0_172.tabs,
	" Config"
}, {
	L_0_175.slider_v,
	2
})
L_0_174.flag_indicators_v:depend({
	L_0_174.flag_indicators,
	true
}, {
	L_0_172.tabs,
	" Visuals"
})
L_0_173.helper_visual:depend({
	L_0_173.peek_helper,
	true
}, {
	L_0_172.tabs,
	" Ragebot"
})
L_0_173.y_offset:depend({
	L_0_173.peek_helper,
	true
}, {
	L_0_172.tabs,
	" Ragebot"
}, {
	L_0_173.helper_visual,
	"Crosshair"
})
L_0_173.air_stop_k:depend({
	L_0_173.air_stop_enable,
	true
}, {
	L_0_173.air_stop_mode,
	"On hotkey"
}, {
	L_0_172.tabs,
	" Ragebot"
})
L_0_173.air_stop_mode:depend({
	L_0_173.air_stop_enable,
	true
}, {
	L_0_172.tabs,
	" Ragebot"
})
L_0_172.weapon_select:depend({
	L_0_172.enable,
	true
}, {
	L_0_172.tabs,
	" Aimtools"
})
L_0_172.enable:depend({
	L_0_172.tabs,
	" Aimtools"
})

for L_IT_0_7 = 1, #L_0_171 do
	L_0_172.aimtool[L_IT_0_7].force_baim:depend({
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].baim_select:depend({
		L_0_172.aimtool[L_IT_0_7].force_baim,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].baim_x_hp:depend({
		L_0_172.aimtool[L_IT_0_7].force_baim,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.aimtool[L_IT_0_7].baim_select,
		"Enemy health < X"
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].force_sp:depend({
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].sp_select:depend({
		L_0_172.aimtool[L_IT_0_7].force_sp,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].sp_x_hp:depend({
		L_0_172.aimtool[L_IT_0_7].force_sp,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.aimtool[L_IT_0_7].sp_select,
		"Enemy health < X"
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].multipoints:depend({
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].m_1:depend({
		L_0_172.aimtool[L_IT_0_7].multipoints,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].m_2:depend({
		L_0_172.aimtool[L_IT_0_7].multipoints,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].m_3:depend({
		L_0_172.aimtool[L_IT_0_7].multipoints,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].m_4:depend({
		L_0_172.aimtool[L_IT_0_7].multipoints,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].m_5:depend({
		L_0_172.aimtool[L_IT_0_7].multipoints,
		true
	}, {
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].accuracy:depend({
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
	L_0_172.aimtool[L_IT_0_7].ab:depend({
		L_0_172.weapon_select,
		L_0_171[L_IT_0_7]
	}, {
		L_0_172.aimtool[L_IT_0_7].accuracy,
		true
	}, {
		L_0_172.enable,
		true
	}, {
		L_0_172.tabs,
		" Aimtools"
	})
end

client.set_event_callback("setup_command", function(L_ARG_137_0)
	if not L_0_173.air_stop_enable:get() then
		return
	end

	local function distance_3d(x1, y1, z1, x2, y2, z2)
		return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
	end

	local L_137_0 = entity.get_local_player()
	local L_137_1 = client.current_threat()

	if L_137_0 == nil or L_137_1 == nil then
		return
	end

	local L_137_2, L_137_3, L_137_4 = entity.get_origin(L_137_0)
	local L_137_5, L_137_6, L_137_7 = entity.get_origin(L_137_1)
	if L_137_2 == nil or L_137_3 == nil or L_137_4 == nil
		or L_137_5 == nil or L_137_6 == nil or L_137_7 == nil then
		return
	end
	local L_137_8 = distance_3d(L_137_2, L_137_3, L_137_4, L_137_5, L_137_6, L_137_7)

	if L_0_173.air_stop_mode:get() == "On hotkey" and L_0_173.air_stop_k:get() or L_0_173.air_stop_mode:get() == "Cycle" and L_137_8 < 700 or L_0_173.air_stop_mode:get() == "High priority" and (L_137_8 < 1000 and entity.get_prop(L_137_1, "m_iHealth") <= 91 or L_137_8 < 500) then
		if L_ARG_137_0.quick_stop then
			if globals.tickcount() - ticks > 3 then
				L_ARG_137_0.in_speed = 1
			end
		else
			ticks = globals.tickcount()
		end
	end
end)

local L_0_177 = {
	flags = 0,
	is_slow = false,
	duck_amount = 0,
	on_ground = false,
	velocity = {
		x = 0,
		y = 0
	}
}

local function get_distance(L_ARG_140_0)
	local L_140_0 = entity.get_local_player()

	if not L_140_0 or not L_ARG_140_0 or not entity.is_alive(L_140_0) or not entity.is_alive(L_ARG_140_0) then
		return 0, 0
	end

	local L_140_1, L_140_2, L_140_3 = entity.get_prop(L_140_0, "m_vecOrigin")
	local L_140_4, L_140_5, L_140_6 = entity.get_prop(L_ARG_140_0, "m_vecOrigin")
	if L_140_1 == nil or L_140_2 == nil or L_140_3 == nil
		or L_140_4 == nil or L_140_5 == nil or L_140_6 == nil then
		return 0, 0
	end
	local L_140_7 = math.sqrt((L_140_4 - L_140_1)^2 + (L_140_5 - L_140_2)^2)
	local L_140_8 = L_140_6 - L_140_3

	return L_140_7, L_140_8
end

function aimtools(L_ARG_141_0)
	if not L_0_172.enable:get() then
		return
	end

	local L_141_0 = entity.get_local_player()

	if not L_141_0 or not entity.is_alive(L_141_0) then
		return
	end

	local L_141_1 = entity.get_player_weapon(L_141_0)

	if not L_141_1 then
		return
	end

	local L_141_2 = bit.band(65535, entity.get_prop(L_141_1, "m_iItemDefinitionIndex")) or 0
	local L_141_3 = L_0_172.weapon_select:get()
	local L_141_4

	for L_IT_141_0, L_IT_141_1 in ipairs(L_0_171) do
		if L_0_176[L_IT_141_1] then
			for L_IT_141_2, L_IT_141_3 in ipairs(L_0_176[L_IT_141_1]) do
				if L_IT_141_3 == L_141_2 then
					L_141_4 = L_0_172.aimtool[L_IT_141_0]

					break
				end
			end

			if L_141_4 then
				break
			end
		end
	end

	L_141_4 = L_141_4 or L_0_172.aimtool[1]

	if L_141_1 == L_0_177.last_weapon and not L_141_4.multipoints:get() then
		return
	end

	L_0_177.last_weapon = L_141_1

	local L_141_5 = client.current_threat()

	if not L_141_5 or not entity.is_alive(L_141_5) then
		return
	end

	local L_141_6 = entity.get_prop(L_141_5, "m_iHealth") or 100
	local L_141_7, L_141_8 = get_distance(L_141_5)
	local L_141_9 = L_141_8 > 50
	local L_141_10

	L_141_10 = L_141_8 < -50

	if L_141_4.force_baim:get() then
		local L_141_11 = L_141_4.baim_select:get("Enemy health < X") and L_141_6 < L_141_4.baim_x_hp:get() or L_141_4.baim_select:get("Enemy higher than you") and L_141_9

		plist.set(L_141_5, "Override prefer body aim", L_141_11 and "On" or "-")
	end

	if L_141_4.force_sp:get() then
		local L_141_12 = L_141_4.sp_select:get("Enemy health < X") and L_141_6 < L_141_4.sp_x_hp:get() or L_141_4.sp_select:get("Enemy higher than you") and L_141_9

		plist.set(L_141_5, "Override safe point", L_141_12 and "On" or "-")
	end

	if L_141_4.multipoints:get() then
		local L_141_13 = L_0_166.vector(entity.get_prop(L_141_0, "m_vecVelocity"))

		L_0_177.is_slow = ui.get(L_0_167.slow[1]) and ui.get(L_0_167.slow[2])
		L_0_177.flags = entity.get_prop(L_141_0, "m_fFlags")
		L_0_177.duck_amount = entity.get_prop(L_141_0, "m_flDuckAmount")
		L_0_177.on_ground = bit.band(L_0_177.flags, 1) ~= 0 and L_ARG_141_0.in_jump == 0

		local L_141_14 = math.sqrt(L_141_13.x^2 + L_141_13.y^2) < 5
		local L_141_15

		if L_141_14 and L_0_177.on_ground and not (L_0_177.duck_amount > 0.1) then
			L_141_15 = "stan"
		elseif not L_141_14 and L_0_177.on_ground and not L_0_177.is_slow and not (L_0_177.duck_amount > 0.1) then
			L_141_15 = "run"
		elseif L_0_177.is_slow and L_0_177.on_ground then
			L_141_15 = "slow"
		elseif L_0_177.duck_amount > 0.1 and L_0_177.on_ground and L_141_14 then
			L_141_15 = "duck"
		elseif L_0_177.duck_amount > 0.1 and L_0_177.on_ground and not L_141_14 then
			L_141_15 = "duck move"
		end

		if L_141_15 and L_141_15 ~= L_0_177.last_state_cond then
			L_0_177.last_state_cond = L_141_15
			L_0_177.last_mp_value = L_141_4[L_141_15 == "stan" and "m_1" or L_141_15 == "run" and "m_2" or L_141_15 == "slow" and "m_3" or L_141_15 == "duck" and "m_4" or L_141_15 == "duck move" and "m_5"]:get()

			L_0_166.pui.reference("Rage", "Aimbot", "Multi-point scale"):override(L_0_177.last_mp_value)
		end
	elseif L_0_177.last_mp_value then
		L_0_166.pui.reference("Rage", "Aimbot", "Multi-point scale"):override(nil)

		L_0_177.last_mp_value = nil
		L_0_177.last_state_cond = nil
	end

	if L_141_4.accuracy:get() then
		local L_141_16 = L_141_4.ab:get()

		if L_0_177.last_ab_value ~= L_141_16 then
			L_0_166.pui.reference("Rage", "Other", "Accuracy boost"):override(L_141_16)

			L_0_177.last_ab_value = L_141_16
		end
	elseif L_0_177.last_ab_value then
		L_0_166.pui.reference("Rage", "Other", "Accuracy boost"):override(nil)

		L_0_177.last_ab_value = nil
	end
end

local L_0_178 = 0

function is_vulnerable()
	for L_IT_142_0, L_IT_142_1 in ipairs(entity.get_players(true)) do
		local L_142_0 = entity.get_esp_data(L_IT_142_1).flags

		if L_0_166.bit.band(L_142_0, L_0_166.bit.lshift(1, 11)) ~= 0 then
			return true
		end
	end

	return false
end

function auto_teleport(L_ARG_143_0)
	local L_143_0 = entity.get_prop(entity.get_local_player(), "m_iHealth")

	if L_143_0 >= 90 then
		L_0_178 = 4
	elseif L_143_0 < 90 then
		L_0_178 = 2
	end

	vel_2 = math.floor(entity.get_prop(entity.get_local_player(), "m_vecVelocity[2]"))

	if is_vulnerable() and vel_2 > 20 then
		if globals.tickcount() % L_0_178 then
			L_ARG_143_0.discharge_pending = true
		end

		L_ARG_143_0.force_defensive = true
	end
end

function delay_shot(L_ARG_144_0)
	if ui.is_menu_open() then
		return
	end

	if L_0_173.delay_key:get() and L_0_173.delay_shot:get() then
		ui.set(L_0_167.delay_shot, true)
	else
		ui.set(L_0_167.delay_shot, false)
	end
end

local L_0_179 = vtable_bind("client_panorama.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*,int)")
local L_0_180 = vtable_thunk(165, "bool(__thiscall*)(void*)")
local L_0_181 = vtable_thunk(482, "float(__thiscall*)(void*)")
local L_0_182 = ui.reference("Visuals", "Player ESP", "Dormant")
local L_0_183 = 0

function can_shoot(L_ARG_145_0, L_ARG_145_1, L_ARG_145_2, L_ARG_145_3)
	if not L_ARG_145_2 or L_ARG_145_2.is_melee_weapon then
		return false
	end

	if L_ARG_145_2.is_revolver then
		return L_ARG_145_3 > entity.get_prop(L_ARG_145_1, "m_flNextPrimaryAttack")
	end

	return L_ARG_145_3 > math.max(entity.get_prop(L_ARG_145_0, "m_flNextAttack"), entity.get_prop(L_ARG_145_1, "m_flNextPrimaryAttack"), entity.get_prop(L_ARG_145_1, "m_flNextSecondaryAttack"))
end

function adjust_velocity(L_ARG_146_0, L_ARG_146_1)
	local L_146_0 = math.sqrt(L_ARG_146_0.forwardmove^2 + L_ARG_146_0.sidemove^2)

	if L_146_0 <= 0 or L_ARG_146_1 <= 0 then
		return
	end

	if L_ARG_146_0.in_duck == 1 then
		L_ARG_146_1 = L_ARG_146_1 * 2.94117647
	end

	if L_146_0 <= L_ARG_146_1 then
		return
	end

	local L_146_1 = L_ARG_146_1 / L_146_0

	L_ARG_146_0.forwardmove = L_ARG_146_0.forwardmove * L_146_1
	L_ARG_146_0.sidemove = L_ARG_146_0.sidemove * L_146_1
end

function on_setup_command(L_ARG_147_0)
	if not L_0_173.dormant:get() and L_0_173.dormant_k:get() then
		return
	end

	local L_147_0 = entity.get_local_player()

	if not entity.is_alive(L_147_0) then
		return
	end

	local L_147_1 = entity.get_player_weapon(L_147_0)
	local L_147_2 = L_147_1 and L_0_166.csgo_weapons(L_147_1)

	if not L_147_2 then
		return
	end

	local L_147_3 = L_0_179(L_147_1)

	if not L_147_3 or not L_0_180(L_147_3) then
		return
	end

	local L_147_4 = L_0_181(L_147_3)

	if not L_147_4 or L_147_4 > 0.008 then
		return
	end

	if globals.tickcount() < L_0_183 then
		return
	end

	local L_147_5 = L_0_166.vector(client.eye_position())
	local L_147_6 = entity.get_prop(L_147_0, "m_flSimulationTime")
	local L_147_7 = entity.get_prop(L_147_0, "m_bIsScoped") == 1
	local L_147_8 = L_0_166.bit.band(entity.get_prop(L_147_0, "m_fFlags"), 1) == 1

	if not can_shoot(L_147_0, L_147_1, L_147_2, L_147_6) then
		return
	end

	local L_147_9 = entity.get_player_resource()
	local L_147_10
	local L_147_11 = 0
	local L_147_12 = 0
	local L_147_13 = 0

	for L_IT_147_0 = 1, globals.maxplayers() do
		if entity.get_prop(L_147_9, "m_bConnected", L_IT_147_0) == 0 then
			
		elseif plist.get(L_IT_147_0, "Add to whitelist") then
			
		elseif not entity.is_dormant(L_IT_147_0) or not entity.is_enemy(L_IT_147_0) then
			
		else
			local L_147_14 = L_0_166.vector(entity.get_origin(L_IT_147_0))
			local L_147_15, L_147_16, L_147_17, L_147_18, L_147_19 = entity.get_bounding_box(L_IT_147_0)

			if L_147_19 < 0.8 or L_147_14.x == 0 then
				
			else
				local L_147_20 = L_147_14 + L_0_166.vector(0, 0, 50)
				local L_147_21, L_147_22 = client.trace_bullet(L_147_0, L_147_5.x, L_147_5.y, L_147_5.z, L_147_20.x, L_147_20.y, L_147_20.z, true)
				local L_147_23 = client.visible(L_147_20.x, L_147_20.y, L_147_20.z)

				if L_147_22 >= 15 and not L_147_23 and L_147_11 < L_147_22 then
					L_147_10 = L_IT_147_0
					L_147_11 = L_147_22

					local L_147_24, L_147_25 = L_147_5:to(L_147_20):angles()

					L_147_12, L_147_13 = L_147_24, L_147_25
				end
			end
		end
	end

	if L_147_10 and L_ARG_147_0.chokedcommands == 0 then
		local L_147_26 = L_147_7 and L_147_2.max_player_speed_alt or L_147_2.max_player_speed

		adjust_velocity(L_ARG_147_0, L_147_26 * 0.35)

		if not L_147_7 and L_147_2.type == "sniperrifle" and L_ARG_147_0.in_jump == 0 and L_147_8 then
			L_ARG_147_0.in_attack2 = 1
		end

		L_ARG_147_0.pitch = L_147_12
		L_ARG_147_0.yaw = L_147_13
		L_ARG_147_0.in_attack = 1
	end
end

function on_paint()
	if not L_0_173.dormant:get() or not L_0_173.dormant_k:get() or not L_0_174.dormant_indicator:get() or not entity.is_alive(entity.get_local_player()) then
		return
	end

	local L_148_0, L_148_1, L_148_2, L_148_3 = L_0_174.dormant_color:get()

	renderer.indicator(L_148_0, L_148_1, L_148_2, L_148_3, "REFLEX DORMANT")
end

function on_round_prestart()
	local L_149_0 = (cvar.mp_freezetime:get_float() + 1) / globals.tickinterval()

	L_0_183 = globals.tickcount() + L_149_0
end

L_0_175.export:set_callback(function()
	local L_150_0 = L_0_169.cfg:save()
	local L_150_1 = L_0_166.msgpack.pack(L_150_0)
	local L_150_2 = L_0_166.base64.encode(L_150_1)

	L_0_166.clipboard.set(L_150_2)
end)
L_0_175.import:set_callback(function()
	local L_151_0 = L_0_166.clipboard.get()
	local L_151_1 = L_0_166.base64.decode(L_151_0)
	local L_151_2 = L_0_166.msgpack.unpack(L_151_1)

	L_0_169.cfg:load(L_151_2)
end)
L_0_175.cfg_marolower:set_callback(function()
	local L_152_0 = "k4SmZW5hYmxlw6R0YWJzqu6GiCBDb25maWenYWltdG9vbJeOqmZvcmNlX2JhaW3DqGZvcmNlX3Nww6liYWltX3hfaHBTq2JhaW1fc2VsZWN0krBFbmVteSBoZWFsdGggPCBYoX6rbXVsdGlwb2ludHPDomFio0xvd6NtXzRRo21fNWGjbV8xW6NtXzNQqGFjY3VyYWN5wqNtXzJHp3NwX3hfaHA0qXNwX3NlbGVjdJKwRW5lbXkgaGVhbHRoIDwgWKF+jqpmb3JjZV9iYWltw6hmb3JjZV9zcMKpYmFpbV94X2hwV6tiYWltX3NlbGVjdJKwRW5lbXkgaGVhbHRoIDwgWKF+q211bHRpcG9pbnRzw6JhYqNMb3ejbV80WaNtXzVLo21fMUyjbV8zTqhhY2N1cmFjecKjbV8yU6dzcF94X2hwXKlzcF9zZWxlY3SRoX6OqmZvcmNlX2JhaW3DqGZvcmNlX3Nww6liYWltX3hfaHBZq2JhaW1fc2VsZWN0krBFbmVteSBoZWFsdGggPCBYoX6rbXVsdGlwb2ludHPDomFipEhpZ2ijbV80U6NtXzVgo21fMVyjbV8zWahhY2N1cmFjecOjbV8yUKdzcF94X2hwN6lzcF9zZWxlY3STsEVuZW15IGhlYWx0aCA8IFi1RW5lbXkgaGlnaGVyIHRoYW4geW91oX6OqmZvcmNlX2JhaW3CqGZvcmNlX3NwwqliYWltX3hfaHBcq2JhaW1fc2VsZWN0kaF+q211bHRpcG9pbnRzwqJhYqNMb3ejbV80MqNtXzUyo21fMTKjbV8zMqhhY2N1cmFjecKjbV8yMqdzcF94X2hwXKlzcF9zZWxlY3SRoX6OqmZvcmNlX2JhaW3CqGZvcmNlX3NwwqliYWltX3hfaHBcq2JhaW1fc2VsZWN0kaF+q211bHRpcG9pbnRzwqJhYqNMb3ejbV80MqNtXzUyo21fMTKjbV8zMqhhY2N1cmFjecKjbV8yMqdzcF94X2hwXKlzcF9zZWxlY3SRoX6OqmZvcmNlX2JhaW3DqGZvcmNlX3Nww6liYWltX3hfaHA8q2JhaW1fc2VsZWN0krBFbmVteSBoZWFsdGggPCBYoX6rbXVsdGlwb2ludHPComFio0xvd6NtXzQyo21fNTKjbV8xMqNtXzMyqGFjY3VyYWN5wqNtXzIyp3NwX3hfaHBMqXNwX3NlbGVjdJOwRW5lbXkgaGVhbHRoIDwgWLVFbmVteSBoaWdoZXIgdGhhbiB5b3Whfo6qZm9yY2VfYmFpbcKoZm9yY2Vfc3DCqWJhaW1feF9ocFyrYmFpbV9zZWxlY3SRoX6rbXVsdGlwb2ludHPComFio0xvd6NtXzQyo21fNTKjbV8xMqNtXzMyqGFjY3VyYWN5wqNtXzIyp3NwX3hfaHBcqXNwX3NlbGVjdJGhfq13ZWFwb25fc2VsZWN0plNTRyAwOIyoeV9vZmZzZXQoq3BlZWtfaGVscGVywq1haXJfc3RvcF9tb2RlqU9uIGhvdGtlea1oZWxwZXJfdmlzdWFsqUNyb3NzaGFpcqlkb3JtYW50X2uTAkOhfqdhdXRvX2xjw6dkb3JtYW50w6phaXJfc3RvcF9rkwEAoX6qZGVsYXlfc2hvdMKpZGVsYXlfa2V5kwEAoX6vYWlyX3N0b3BfZW5hYmxlwqlhdXRvX2xjX2uTAVahfoWvZmxhZ19pbmRpY2F0b3Jzw7FmbGFnX2luZGljYXRvcnNfdpWoQm9keSBhaW2qU2FmZSBwb2ludKtNdWx0aS1wb2ludK5Eb3JtYW50IGFpbWJvdKF+sWRvcm1hbnRfaW5kaWNhdG9yw6hoaXRfbG9nc8OtZG9ybWFudF9jb2xvcqkjMDBGRjAwRkY="
	local L_152_1 = L_0_166.base64.decode(L_152_0)
	local L_152_2 = L_0_166.msgpack.unpack(L_152_1)

	L_0_169.cfg:load(L_152_2)
end)
L_0_175.cfg_hakkai:set_callback(function()
	local L_153_0 = "k4SmZW5hYmxlw6R0YWJzqu6GiCBDb25maWenYWltdG9vbJeOqmZvcmNlX2JhaW3CqGZvcmNlX3NwwqliYWltX3hfaHBcq2JhaW1fc2VsZWN0kaF+q211bHRpcG9pbnRzw6JhYqRIaWdoo21fNEWjbV81UqNtXzFeo21fM2SoYWNjdXJhY3nDo21fMlmnc3BfeF9ocFypc3Bfc2VsZWN0kaF+jqpmb3JjZV9iYWltwqhmb3JjZV9zcMOpYmFpbV94X2hwXKtiYWltX3NlbGVjdJGhfqttdWx0aXBvaW50c8OiYWKnTWF4aW11baNtXzRNo21fNVqjbV8xVaNtXzNTqGFjY3VyYWN5w6NtXzJap3NwX3hfaHBcqXNwX3NlbGVjdJK1RW5lbXkgaGlnaGVyIHRoYW4geW91oX6OqmZvcmNlX2JhaW3DqGZvcmNlX3Nww6liYWltX3hfaHBcq2JhaW1fc2VsZWN0krVFbmVteSBoaWdoZXIgdGhhbiB5b3WhfqttdWx0aXBvaW50c8OiYWKkSGlnaKNtXzRMo21fNU+jbV8xV6NtXzNRqGFjY3VyYWN5w6NtXzJKp3NwX3hfaHBaqXNwX3NlbGVjdJKwRW5lbXkgaGVhbHRoIDwgWKF+jqpmb3JjZV9iYWltw6hmb3JjZV9zcMKpYmFpbV94X2hwXKtiYWltX3NlbGVjdJKwRW5lbXkgaGVhbHRoIDwgWKF+q211bHRpcG9pbnRzw6JhYqdNYXhpbXVto21fNF6jbV81RaNtXzFco21fM1yoYWNjdXJhY3nDo21fMlanc3BfeF9ocFypc3Bfc2VsZWN0kaF+jqpmb3JjZV9iYWltw6hmb3JjZV9zcMOpYmFpbV94X2hwOqtiYWltX3NlbGVjdJKwRW5lbXkgaGVhbHRoIDwgWKF+q211bHRpcG9pbnRzwqJhYqdNYXhpbXVto21fNDKjbV81MqNtXzEyo21fMzKoYWNjdXJhY3nDo21fMjKnc3BfeF9ocFypc3Bfc2VsZWN0krVFbmVteSBoaWdoZXIgdGhhbiB5b3Whfo6qZm9yY2VfYmFpbcKoZm9yY2Vfc3DCqWJhaW1feF9ocFyrYmFpbV9zZWxlY3SRoX6rbXVsdGlwb2ludHPDomFipEhpZ2ijbV80ZKNtXzVVo21fMVWjbV8zZKhhY2N1cmFjecOjbV8yZKdzcF94X2hwXKlzcF9zZWxlY3SRoX6OqmZvcmNlX2JhaW3CqGZvcmNlX3NwwqliYWltX3hfaHBcq2JhaW1fc2VsZWN0kaF+q211bHRpcG9pbnRzwqJhYqNMb3ejbV80MqNtXzUyo21fMTKjbV8zMqhhY2N1cmFjecKjbV8yMqdzcF94X2hwXKlzcF9zZWxlY3SRoX6td2VhcG9uX3NlbGVjdKRaZXVzjKh5X29mZnNldCircGVla19oZWxwZXLDrWFpcl9zdG9wX21vZGWpT24gaG90a2V5rWhlbHBlcl92aXN1YWypQ3Jvc3NoYWlyqWRvcm1hbnRfa5MAAKF+p2F1dG9fbGPCp2Rvcm1hbnTDqmFpcl9zdG9wX2uTAQChfqpkZWxheV9zaG90wqlkZWxheV9rZXmTAQChfq9haXJfc3RvcF9lbmFibGXCqWF1dG9fbGNfa5MBAKF+ha9mbGFnX2luZGljYXRvcnPDsWZsYWdfaW5kaWNhdG9yc192lahCb2R5IGFpbapTYWZlIHBvaW50q011bHRpLXBvaW50rkRvcm1hbnQgYWltYm90oX6xZG9ybWFudF9pbmRpY2F0b3LDqGhpdF9sb2dzwq1kb3JtYW50X2NvbG9yqSMwMEZGMDBGRg=="
	local L_153_1 = L_0_166.base64.decode(L_153_0)
	local L_153_2 = L_0_166.msgpack.unpack(L_153_1)

	L_0_169.cfg:load(L_153_2)
end)

local L_0_184 = {
	left = {
		active = false,
		damage = 0
	},
	right = {
		active = false,
		damage = 0
	}
}

function weapon_ready()
	local L_154_0 = entity.get_local_player()

	if not entity.is_alive(L_154_0) or not L_0_173.peek_helper:get() then
		return false
	end

	local L_154_1 = entity.get_prop(L_154_0, "m_hActiveWeapon")

	if not L_154_1 then
		return false
	end

	local L_154_2 = entity.get_prop(L_154_0, "m_flNextAttack")
	local L_154_3 = entity.get_prop(L_154_1, "m_flNextPrimaryAttack")

	if not L_154_2 or not L_154_3 then
		return false
	end

	return L_154_2 + 0.25 < globals.curtime() and L_154_3 + 0.5 < globals.curtime()
end

function check_peek()
	L_0_184.left.active = false
	L_0_184.right.active = false
	L_0_184.left.damage = 0
	L_0_184.right.damage = 0

	if not L_0_173.peek_helper:get() and ui.get(L_0_167.peek[2]) then
		return
	end

	local L_155_0 = entity.get_local_player()

	if not entity.is_alive(L_155_0) then
		return
	end

	local L_155_1 = L_0_166.vector(client.eye_position())
	local L_155_2 = client.current_threat()

	if not L_155_2 or entity.is_dormant(L_155_2) then
		return
	end

	if not weapon_ready() then
		return
	end

	local L_155_3 = L_0_166.vector(entity.get_origin(L_155_2))
	local L_155_4 = L_155_1.x - L_155_3.x
	local L_155_5 = L_155_1.y - L_155_3.y
	local L_155_6 = math.atan2(L_155_5, L_155_4) * (180 / math.pi)
	local L_155_7 = math.cos(math.rad(L_155_6 - 90))
	local L_155_8 = math.sin(math.rad(L_155_6 - 90))
	local L_155_9 = math.cos(math.rad(L_155_6 + 90))
	local L_155_10 = math.sin(math.rad(L_155_6 + 90))
	local L_155_11 = 50
	local L_155_12 = L_0_166.vector(L_155_1.x + L_155_7 * L_155_11, L_155_1.y + L_155_8 * L_155_11, L_155_1.z)
	local L_155_13 = L_0_166.vector(L_155_1.x + L_155_9 * L_155_11, L_155_1.y + L_155_10 * L_155_11, L_155_1.z)
	local L_155_14 = L_0_166.vector(entity.hitbox_position(L_155_2, 2))
	local L_155_15, L_155_16 = client.trace_bullet(L_155_0, L_155_12.x, L_155_12.y, L_155_12.z, L_155_14.x, L_155_14.y, L_155_14.z, false)
	local L_155_17, L_155_18 = client.trace_bullet(L_155_0, L_155_13.x, L_155_13.y, L_155_13.z, L_155_14.x, L_155_14.y, L_155_14.z, false)

	if L_155_15 and L_155_16 and L_155_16 > 0 then
		L_0_184.left.active = true
		L_0_184.left.damage = L_155_16
	end

	if L_155_17 and L_155_18 and L_155_18 > 0 then
		L_0_184.right.active = true
		L_0_184.right.damage = L_155_18
	end
end

function render_hud()
	if not L_0_173.peek_helper:get() and L_0_173.helper_visual:get() == "World lines" and ui.get(L_0_167.peek[2]) then
		return
	end

	local L_156_0 = entity.get_local_player()

	if not entity.is_alive(L_156_0) then
		return
	end

	local L_156_1 = L_0_166.vector(entity.get_origin(L_156_0))
	local L_156_2 = client.current_threat()

	if not L_156_2 or entity.is_dormant(L_156_2) then
		return
	end

	local L_156_3 = L_0_166.vector(entity.get_origin(L_156_2))
	local L_156_4 = L_156_3.x - L_156_1.x
	local L_156_5 = L_156_3.y - L_156_1.y
	local L_156_6 = math.atan2(L_156_5, L_156_4) * (180 / math.pi)
	local L_156_7 = math.sin(globals.realtime() * 3) * 0.3 + 0.7
	local L_156_8, L_156_9 = renderer.measure_text(nil, " ")
	local L_156_10 = L_156_8 * 0.5
	local L_156_11 = L_156_9 * 0.5
	local L_156_12 = L_0_184.left.active or L_0_184.right.active

	renderer.circle_outline(L_156_10, L_156_11, L_156_12 and 50 or 150, L_156_12 and 200 or 50, L_156_12 and 200 or 50, 200, 6, globals.realtime() * 60, 0.2)

	for L_IT_156_0, L_IT_156_1 in ipairs({
		"left",
		"right"
	}) do
		local L_156_13 = L_IT_156_1 == "left"
		local L_156_14 = L_0_184[L_IT_156_1].active
		local L_156_15 = L_0_184[L_IT_156_1].damage
		local L_156_16 = L_156_6 + (L_156_13 and 90 or -90)
		local L_156_17 = math.rad(L_156_16)
		local L_156_18 = L_0_166.vector(L_156_1.x + math.cos(L_156_17) * 20, L_156_1.y + math.sin(L_156_17) * 20, L_156_1.z + 30)
		local L_156_19 = math.floor(L_156_1:dist(L_156_18))
		local L_156_20 = math.min(100, math.floor(L_156_15 * 1.5))
		local L_156_21 = (L_156_13 and "LEFT" or "RIGHT") .. " PEEK (" .. L_156_19 .. "u, " .. L_156_20 .. "%)"
		local L_156_22, L_156_23 = renderer.measure_text("small", L_156_21)
		local L_156_24 = {
			renderer.world_to_screen(L_156_18.x, L_156_18.y, L_156_18.z)
		}

		if L_156_24[1] then
			local L_156_25 = L_156_14 and 180 + L_156_7 * 60 or 140

			renderer.text(L_156_24[1] - L_156_22 * 0.5, L_156_24[2] - L_156_23, L_156_14 and 50 or 80, L_156_14 and 200 or 120, L_156_14 and 200 or 160, L_156_25, "small", 0, L_156_21)
		end

		local L_156_26 = 20 + L_156_7 * 10
		local L_156_27 = L_156_18.x + math.cos(L_156_17) * L_156_26
		local L_156_28 = L_156_18.y + math.sin(L_156_17) * L_156_26
		local L_156_29 = {
			renderer.world_to_screen(L_156_18.x, L_156_18.y, L_156_18.z - 10)
		}
		local L_156_30 = {
			renderer.world_to_screen(L_156_27, L_156_28, L_156_18.z - 10)
		}

		if L_156_29[1] and L_156_30[1] then
			renderer.line(L_156_29[1], L_156_29[2], L_156_30[1], L_156_30[2], L_156_14 and 200 or 120, L_156_14 and 100 or 80, L_156_14 and 50 or 120, L_156_14 and 180 + L_156_7 * 60 or 140)
			renderer.line(L_156_29[1] + 1, L_156_29[2] + 1, L_156_30[1] + 1, L_156_30[2] + 1, L_156_14 and 200 or 120, L_156_14 and 100 or 80, L_156_14 and 50 or 120, L_156_14 and 90 + L_156_7 * 30 or 70)
		end
	end
end

local L_0_185 = {}
local L_0_186 = {
	rad = 11,
	o = 20,
	n = 45,
	rounding = 9,
	OutlineGlow = function(L_ARG_157_0, L_ARG_157_1, L_ARG_157_2, L_ARG_157_3, L_ARG_157_4, L_ARG_157_5, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9, L_ARG_157_10)
		renderer.rectangle(L_ARG_157_1 + 2, L_ARG_157_2 + L_ARG_157_5 + L_ARG_157_0.rad, 1, L_ARG_157_4 - L_ARG_157_0.rad * 2 - L_ARG_157_5 * 2, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9)
		renderer.rectangle(L_ARG_157_1 + L_ARG_157_3 - 3, L_ARG_157_2 + L_ARG_157_5 + L_ARG_157_0.rad, 1, L_ARG_157_4 - L_ARG_157_0.rad * 2 - L_ARG_157_5 * 2, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9)
		renderer.rectangle(L_ARG_157_1 + L_ARG_157_5 + L_ARG_157_0.rad, L_ARG_157_2 + 2, L_ARG_157_3 - L_ARG_157_0.rad * 2 - L_ARG_157_5 * 2, 1, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9)
		renderer.rectangle(L_ARG_157_1 + L_ARG_157_5 + L_ARG_157_0.rad, L_ARG_157_2 + L_ARG_157_4 - 3, L_ARG_157_3 - L_ARG_157_0.rad * 2 - L_ARG_157_5 * 2, 1, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9)
		renderer.circle_outline(L_ARG_157_1 + L_ARG_157_5 + L_ARG_157_0.rad, L_ARG_157_2 + L_ARG_157_5 + L_ARG_157_0.rad, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9, L_ARG_157_5 + L_ARG_157_0.rounding, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_157_1 + L_ARG_157_3 - L_ARG_157_5 - L_ARG_157_0.rad, L_ARG_157_2 + L_ARG_157_5 + L_ARG_157_0.rad, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9, L_ARG_157_5 + L_ARG_157_0.rounding, 270, 0.25, 1)
		renderer.circle_outline(L_ARG_157_1 + L_ARG_157_5 + L_ARG_157_0.rad, L_ARG_157_2 + L_ARG_157_4 - L_ARG_157_5 - L_ARG_157_0.rad, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9, L_ARG_157_5 + L_ARG_157_0.rounding, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_157_1 + L_ARG_157_3 - L_ARG_157_5 - L_ARG_157_0.rad, L_ARG_157_2 + L_ARG_157_4 - L_ARG_157_5 - L_ARG_157_0.rad, L_ARG_157_6, L_ARG_157_7, L_ARG_157_8, L_ARG_157_9, L_ARG_157_5 + L_ARG_157_0.rounding, 0, 0.25, 1)
	end,
	rounded_box = function(L_ARG_158_0, L_ARG_158_1, L_ARG_158_2, L_ARG_158_3, L_ARG_158_4, L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9, L_ARG_158_10, L_ARG_158_11, L_ARG_158_12, L_ARG_158_13)
		renderer.rectangle(L_ARG_158_1 + L_ARG_158_5, L_ARG_158_2, L_ARG_158_3 - L_ARG_158_5 * 2, L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9)
		renderer.rectangle(L_ARG_158_1, L_ARG_158_2 + L_ARG_158_5, L_ARG_158_5, L_ARG_158_4 - L_ARG_158_5 * 2, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9)
		renderer.rectangle(L_ARG_158_1 + L_ARG_158_5, L_ARG_158_2 + L_ARG_158_4 - L_ARG_158_5, L_ARG_158_3 - L_ARG_158_5 * 2, L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9)
		renderer.rectangle(L_ARG_158_1 + L_ARG_158_3 - L_ARG_158_5, L_ARG_158_2 + L_ARG_158_5, L_ARG_158_5, L_ARG_158_4 - L_ARG_158_5 * 2, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9)
		renderer.rectangle(L_ARG_158_1 + L_ARG_158_5, L_ARG_158_2 + L_ARG_158_5, L_ARG_158_3 - L_ARG_158_5 * 2, L_ARG_158_4 - L_ARG_158_5 * 2, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9)
		renderer.circle(L_ARG_158_1 + L_ARG_158_5, L_ARG_158_2 + L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9, L_ARG_158_5, 180, 0.25)
		renderer.circle(L_ARG_158_1 + L_ARG_158_3 - L_ARG_158_5, L_ARG_158_2 + L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9, L_ARG_158_5, 90, 0.25)
		renderer.circle(L_ARG_158_1 + L_ARG_158_5, L_ARG_158_2 + L_ARG_158_4 - L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9, L_ARG_158_5, 270, 0.25)
		renderer.circle(L_ARG_158_1 + L_ARG_158_3 - L_ARG_158_5, L_ARG_158_2 + L_ARG_158_4 - L_ARG_158_5, L_ARG_158_6, L_ARG_158_7, L_ARG_158_8, L_ARG_158_9, L_ARG_158_5, 0, 0.25)
	end,
	rounded_box3 = function(L_ARG_159_0, L_ARG_159_1, L_ARG_159_2, L_ARG_159_3, L_ARG_159_4, L_ARG_159_5, L_ARG_159_6, L_ARG_159_7, L_ARG_159_8, L_ARG_159_9, L_ARG_159_10, L_ARG_159_11, L_ARG_159_12, L_ARG_159_13)
		renderer.circle(L_ARG_159_1 + L_ARG_159_5, L_ARG_159_2 + L_ARG_159_5, L_ARG_159_6, L_ARG_159_7, L_ARG_159_8, L_ARG_159_9, L_ARG_159_5, 180, 0.25)
		renderer.circle(L_ARG_159_1 - L_ARG_159_5 + 24, L_ARG_159_2 + L_ARG_159_5, L_ARG_159_6, L_ARG_159_7, L_ARG_159_8, L_ARG_159_9, L_ARG_159_5, 90, 0.25)
		renderer.circle(L_ARG_159_1 + L_ARG_159_5, L_ARG_159_2 + L_ARG_159_4 - L_ARG_159_5, L_ARG_159_6, L_ARG_159_7, L_ARG_159_8, L_ARG_159_9, L_ARG_159_5, 270, 0.25)
		renderer.circle(L_ARG_159_1 - L_ARG_159_5 + 24, L_ARG_159_2 + L_ARG_159_4 - L_ARG_159_5, L_ARG_159_6, L_ARG_159_7, L_ARG_159_8, L_ARG_159_9, L_ARG_159_5, 0, 0.25)
	end,
	rounded_box2 = function(L_ARG_160_0, L_ARG_160_1, L_ARG_160_2, L_ARG_160_3, L_ARG_160_4, L_ARG_160_5, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_ARG_160_9, L_ARG_160_10, L_ARG_160_11, L_ARG_160_12, L_ARG_160_13)
		local L_160_0 = L_ARG_160_9 / 255 * L_ARG_160_0.n

		renderer.rectangle(L_ARG_160_1 + L_ARG_160_5, L_ARG_160_2, L_ARG_160_3 - L_ARG_160_5 * 2, 1, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0)
		renderer.circle_outline(L_ARG_160_1 + L_ARG_160_5, L_ARG_160_2 + L_ARG_160_5, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0, L_ARG_160_5, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_160_1 + L_ARG_160_3 - L_ARG_160_5, L_ARG_160_2 + L_ARG_160_5, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0, L_ARG_160_5, 270, 0.25, 1)
		renderer.rectangle(L_ARG_160_1, L_ARG_160_2 + L_ARG_160_5, 1, L_ARG_160_4 - L_ARG_160_5 * 2, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0)
		renderer.rectangle(L_ARG_160_1 + L_ARG_160_3 - 1, L_ARG_160_2 + L_ARG_160_5, 1, L_ARG_160_4 - L_ARG_160_5 * 2, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0)
		renderer.circle_outline(L_ARG_160_1 + L_ARG_160_5, L_ARG_160_2 + L_ARG_160_4 - L_ARG_160_5, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0, L_ARG_160_5, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_160_1 + L_ARG_160_3 - L_ARG_160_5, L_ARG_160_2 + L_ARG_160_4 - L_ARG_160_5, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0, L_ARG_160_5, 0, 0.25, 1)
		renderer.rectangle(L_ARG_160_1 + L_ARG_160_5, L_ARG_160_2 + L_ARG_160_4 - 1, L_ARG_160_3 - L_ARG_160_5 * 2, 1, L_ARG_160_6, L_ARG_160_7, L_ARG_160_8, L_160_0)

		for L_IT_160_0 = 4, L_ARG_160_10 do
			local L_160_1 = L_IT_160_0 / 2

			L_ARG_160_0:OutlineGlow(L_ARG_160_1 - L_160_1, L_ARG_160_2 - L_160_1, L_ARG_160_3 + L_160_1 * 2, L_ARG_160_4 + L_160_1 * 2, L_160_1, L_ARG_160_11, L_ARG_160_12, L_ARG_160_13, L_ARG_160_10 - L_160_1 * 2)
		end
	end,
	OutlineGlow = function(L_ARG_161_0, L_ARG_161_1, L_ARG_161_2, L_ARG_161_3, L_ARG_161_4, L_ARG_161_5, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9)
		renderer.rectangle(L_ARG_161_1 + 2, L_ARG_161_2 + L_ARG_161_5 + L_ARG_161_0.rad, 1, L_ARG_161_4 - L_ARG_161_0.rad * 2 - L_ARG_161_5 * 2, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9)
		renderer.rectangle(L_ARG_161_1 + L_ARG_161_3 - 3, L_ARG_161_2 + L_ARG_161_5 + L_ARG_161_0.rad, 1, L_ARG_161_4 - L_ARG_161_0.rad * 2 - L_ARG_161_5 * 2, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9)
		renderer.rectangle(L_ARG_161_1 + L_ARG_161_5 + L_ARG_161_0.rad, L_ARG_161_2 + 2, L_ARG_161_3 - L_ARG_161_0.rad * 2 - L_ARG_161_5 * 2, 1, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9)
		renderer.rectangle(L_ARG_161_1 + L_ARG_161_5 + L_ARG_161_0.rad, L_ARG_161_2 + L_ARG_161_4 - 3, L_ARG_161_3 - L_ARG_161_0.rad * 2 - L_ARG_161_5 * 2, 1, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9)
		renderer.circle_outline(L_ARG_161_1 + L_ARG_161_5 + L_ARG_161_0.rad, L_ARG_161_2 + L_ARG_161_5 + L_ARG_161_0.rad, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9, L_ARG_161_5 + L_ARG_161_0.rounding, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_161_1 + L_ARG_161_3 - L_ARG_161_5 - L_ARG_161_0.rad, L_ARG_161_2 + L_ARG_161_5 + L_ARG_161_0.rad, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9, L_ARG_161_5 + L_ARG_161_0.rounding, 270, 0.25, 1)
		renderer.circle_outline(L_ARG_161_1 + L_ARG_161_5 + L_ARG_161_0.rad, L_ARG_161_2 + L_ARG_161_4 - L_ARG_161_5 - L_ARG_161_0.rad, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9, L_ARG_161_5 + L_ARG_161_0.rounding, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_161_1 + L_ARG_161_3 - L_ARG_161_5 - L_ARG_161_0.rad, L_ARG_161_2 + L_ARG_161_4 - L_ARG_161_5 - L_ARG_161_0.rad, L_ARG_161_6, L_ARG_161_7, L_ARG_161_8, L_ARG_161_9, L_ARG_161_5 + L_ARG_161_0.rounding, 0, 0.25, 1)
	end,
	FadedRoundedGlow = function(L_ARG_162_0, L_ARG_162_1, L_ARG_162_2, L_ARG_162_3, L_ARG_162_4, L_ARG_162_5, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_ARG_162_9, L_ARG_162_10, L_ARG_162_11, L_ARG_162_12, L_ARG_162_13)
		local L_162_0 = L_ARG_162_9 / 255 * L_ARG_162_0.n

		renderer.rectangle(L_ARG_162_1 + L_ARG_162_5, L_ARG_162_2, L_ARG_162_3 - L_ARG_162_5 * 2, 1, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0)
		renderer.circle_outline(L_ARG_162_1 + L_ARG_162_5, L_ARG_162_2 + L_ARG_162_5, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0, L_ARG_162_5, 180, 0.25, 1)
		renderer.circle_outline(L_ARG_162_1 + L_ARG_162_3 - L_ARG_162_5, L_ARG_162_2 + L_ARG_162_5, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0, L_ARG_162_5, 270, 0.25, 1)
		renderer.rectangle(L_ARG_162_1, L_ARG_162_2 + L_ARG_162_5, 1, L_ARG_162_4 - L_ARG_162_5 * 2, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0)
		renderer.rectangle(L_ARG_162_1 + L_ARG_162_3 - 1, L_ARG_162_2 + L_ARG_162_5, 1, L_ARG_162_4 - L_ARG_162_5 * 2, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0)
		renderer.circle_outline(L_ARG_162_1 + L_ARG_162_5, L_ARG_162_2 + L_ARG_162_4 - L_ARG_162_5, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0, L_ARG_162_5, 90, 0.25, 1)
		renderer.circle_outline(L_ARG_162_1 + L_ARG_162_3 - L_ARG_162_5, L_ARG_162_2 + L_ARG_162_4 - L_ARG_162_5, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0, L_ARG_162_5, 0, 0.25, 1)
		renderer.rectangle(L_ARG_162_1 + L_ARG_162_5, L_ARG_162_2 + L_ARG_162_4 - 1, L_ARG_162_3 - L_ARG_162_5 * 2, 1, L_ARG_162_6, L_ARG_162_7, L_ARG_162_8, L_162_0)

		for L_IT_162_0 = 4, L_ARG_162_10 do
			local L_162_1 = L_IT_162_0 / 2

			L_ARG_162_0:OutlineGlow(L_ARG_162_1 - L_162_1, L_ARG_162_2 - L_162_1, L_ARG_162_3 + L_162_1 * 2, L_ARG_162_4 + L_162_1 * 2, L_162_1, L_ARG_162_11, L_ARG_162_12, L_ARG_162_13, L_ARG_162_10 - L_162_1 * 2)
		end
	end
}
local L_0_187 = renderer.load_svg("<?xml version=\"1.0\" encoding=\"utf-8\"?><!-- Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools -->\n<svg width=\"800px\" height=\"800px\" viewBox=\"0 0 16 16\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\">\n<path fill-rule=\"nonzero\" clip-rule=\"nonzero\" d=\"M4.84989 2.37195C4.59895 2.51683 4.33488 2.91636 4.30424 3.78785C4.28968 4.20181 3.9423 4.52559 3.52835 4.51103C3.11439 4.49647 2.79061 4.1491 2.80516 3.73514C2.84273 2.66673 3.1806 1.60366 4.09989 1.07291C5.02179 0.540653 6.11484 0.782356 7.06128 1.28727C7.42674 1.48224 7.56495 1.93656 7.36998 2.30201C7.17501 2.66747 6.72069 2.80568 6.35524 2.61072C5.5818 2.1981 5.10158 2.22663 4.84989 2.37195ZM8.87139 3.67284C9.19036 3.40858 9.66315 3.45293 9.92741 3.7719C10.4818 4.44103 11.0136 5.20405 11.4963 6.04018C12.5366 7.84191 13.178 9.68785 13.3509 11.2362C13.4372 12.0091 13.4108 12.7446 13.2303 13.3754C13.0484 14.011 12.6941 14.5863 12.0999 14.9293C11.381 15.3444 10.5509 15.2855 9.79114 15.0089C9.02868 14.7313 8.24395 14.2056 7.49586 13.5228C7.18993 13.2435 7.16831 12.7691 7.44756 12.4632C7.72681 12.1573 8.20119 12.1356 8.50712 12.4149C9.16624 13.0165 9.78567 13.4105 10.3043 13.5994C10.8257 13.7892 11.1537 13.7436 11.3499 13.6303C11.5143 13.5354 11.6797 13.342 11.7882 12.9627C11.8981 12.5787 11.9328 12.0529 11.8602 11.4026C11.7152 10.1045 11.1591 8.45607 10.1973 6.79018C9.75492 6.02396 9.27081 5.33055 8.77232 4.72886C8.50807 4.40989 8.55242 3.93709 8.87139 3.67284Z\" fill=\"#A36990FF\"/>\n<path fill-rule=\"nonzero\" clip-rule=\"nonzero\" d=\"M14.5 8.20557C14.5 7.91581 14.286 7.48735 13.5466 7.02507C13.1954 6.80549 13.0887 6.34276 13.3083 5.99154C13.5279 5.64032 13.9906 5.53361 14.3418 5.75319C15.2483 6.31993 16 7.14407 16 8.20557C16 9.27009 15.2442 10.0958 14.3337 10.663C13.9821 10.882 13.5195 10.7746 13.3005 10.423C13.0815 10.0714 13.189 9.60887 13.5405 9.38985C14.2846 8.92635 14.5 8.4962 14.5 8.20557ZM11.3626 11.0378C11.432 11.4462 11.1572 11.8335 10.7488 11.9029C9.89219 12.0484 8.96547 12.1274 8 12.1274C5.91954 12.1274 4.00018 11.76 2.57286 11.1355C1.86032 10.8238 1.23659 10.4332 0.780529 9.9615C0.320977 9.48616 0 8.89166 0 8.20557C0 7.37549 0.466082 6.68599 1.08548 6.16636C1.70712 5.64485 2.55471 5.22808 3.52013 4.92164C3.91494 4.79633 4.33657 5.01479 4.46189 5.40959C4.5872 5.80439 4.36874 6.22603 3.97394 6.35135C3.12334 6.62134 2.4724 6.96078 2.04954 7.31553C1.62442 7.67217 1.5 7.97899 1.5 8.20557C1.5 8.39536 1.58476 8.6353 1.85895 8.91891C2.13663 9.20613 2.57464 9.49905 3.17409 9.76131C4.37076 10.2848 6.07639 10.6274 8 10.6274C8.88475 10.6274 9.72732 10.5549 10.4976 10.424C10.906 10.3547 11.2933 10.6295 11.3626 11.0378Z\" fill=\"#8C7494\"/>\n<path fill-rule=\"nonzero\" clip-rule=\"nonzero\" d=\"M4.87192 13.6303C5.12286 13.7752 5.6009 13.8041 6.37095 13.3949C6.73673 13.2005 7.19082 13.3395 7.38519 13.7052C7.57957 14.071 7.44062 14.5251 7.07484 14.7195C6.13079 15.2211 5.04121 15.4601 4.12192 14.9293C3.20003 14.3971 2.86282 13.3296 2.82687 12.2575C2.81299 11.8435 3.13733 11.4967 3.55131 11.4828C3.96529 11.4689 4.31215 11.7932 4.32603 12.2072C4.35541 13.0834 4.62023 13.485 4.87192 13.6303ZM3.98778 9.49712C3.59944 9.35301 3.40145 8.92138 3.54556 8.53304C3.84786 7.71839 4.24274 6.8763 4.72548 6.04018C5.76571 4.23845 7.04361 2.75996 8.29806 1.83609C8.92431 1.37487 9.57441 1.02999 10.211 0.870901C10.8524 0.71059 11.5278 0.729863 12.1219 1.07291C12.8408 1.48795 13.2049 2.23634 13.3452 3.03257C13.486 3.83168 13.4232 4.77409 13.2058 5.7634C13.1169 6.16796 12.7169 6.42388 12.3124 6.33501C11.9078 6.24613 11.6519 5.84612 11.7408 5.44155C11.9322 4.56992 11.9637 3.83647 11.868 3.29288C11.7717 2.7464 11.5681 2.48524 11.3719 2.37195C11.2076 2.27705 10.9574 2.23049 10.5747 2.32614C10.1871 2.42301 9.71442 2.65588 9.18757 3.04388C8.13584 3.81846 6.98632 5.12428 6.02452 6.79018C5.58214 7.55639 5.22369 8.32235 4.95185 9.0549C4.80774 9.44323 4.37611 9.64122 3.98778 9.49712Z\" fill=\"#A36990FF\"/>\n<path d=\"M9.45925 8.06618C9.45925 8.81694 8.85063 9.42556 8.09987 9.42556C7.34911 9.42556 6.7405 8.81694 6.7405 8.06618C6.7405 7.31542 7.34911 6.70681 8.09987 6.70681C8.85063 6.70681 9.45925 7.31542 9.45925 8.06618Z\" fill=\"#8C7494\"/>\n</svg>", 14, 14)
local L_0_188 = {}
local L_0_189 = {
	lerp = function(L_ARG_163_0, L_ARG_163_1, L_ARG_163_2, L_ARG_163_3)
		return L_ARG_163_1 + (L_ARG_163_2 - L_ARG_163_1) * L_ARG_163_3
	end,
	clamp = function(L_ARG_164_0, L_ARG_164_1, L_ARG_164_2, L_ARG_164_3)
		if L_ARG_164_3 < L_ARG_164_1 then
			return L_ARG_164_3
		end

		if L_ARG_164_1 < L_ARG_164_2 then
			return L_ARG_164_2
		end

		return L_ARG_164_1
	end,
	ease_in_out_quart = function(L_ARG_165_0, L_ARG_165_1)
		local L_165_0 = L_ARG_165_1^2

		return L_165_0 / (2 * (L_165_0 - L_ARG_165_1) + 1)
	end
}

function L_0_185.add_to_log(L_ARG_166_0, L_ARG_166_1, L_ARG_166_2)
	local L_166_0 = {
		client.screen_size()
	}
	local L_166_1 = {
		L_166_0[1] / 2,
		L_166_0[2] / 2
	}

	while #L_0_188 >= 6 do
		table.remove(L_0_188, 1)
	end

	table.insert(L_0_188, {
		alpha3 = 0,
		ypos = 0,
		alpha = 0,
		alpha2 = 0,
		text = L_ARG_166_1,
		player = L_ARG_166_2,
		timer = globals.realtime(),
		ypos2 = L_166_0[2]
	})
end

function L_0_185.logs(L_ARG_167_0)
	local screen = {
		client.screen_size()
	}
	local center = {
		screen[1] / 2,
		screen[2] / 2
	}
	local x = center[1]
	local y = screen[2]
	local now = globals.realtime()

	for index = #L_0_188, 1, -1 do
		if L_0_188[index].timer + 4 <= now then
			table.remove(L_0_188, index)
		end
	end

	for L_IT_167_0, L_IT_167_1 in ipairs(L_0_188) do
		local L_167_0 = 255
		local L_167_1 = 255
		local L_167_2 = 255
		local L_167_3 = 255
		local L_167_4 = 255
		local L_167_5 = 255
		local L_167_6 = 255
		local L_167_7 = 255
		local L_167_8 = 25
		local L_167_9 = 25
		local L_167_10 = 25
		local L_167_11 = 255
		local L_167_12 = 0

		if L_IT_167_1.timer + 3.8 < now then
			if L_IT_167_1.timer + 3.95 < now then
				L_IT_167_1.text = ""
			end

			L_IT_167_1.ypos = L_0_189:lerp(L_IT_167_1.ypos, 215, globals.frametime() * 2)
			L_IT_167_1.alpha = L_0_189:lerp(L_IT_167_1.alpha, 0, globals.frametime() * 15)
			L_IT_167_1.alpha2 = L_0_189:lerp(L_IT_167_1.alpha2, 0, globals.frametime() * 50)
			L_IT_167_1.alpha3 = L_0_189:lerp(L_IT_167_1.alpha3, 0, globals.frametime() * 15)
			L_167_12 = globals.frametime() * 5
		else
			L_IT_167_1.ypos = L_0_189:lerp(L_IT_167_1.ypos, 175, globals.frametime() * 4)
			L_IT_167_1.alpha = L_0_189:lerp(L_IT_167_1.alpha, 255, globals.frametime() * 5)
			L_IT_167_1.alpha2 = L_0_189:lerp(L_IT_167_1.alpha2, L_167_11, globals.frametime() * 10)
			L_IT_167_1.alpha3 = L_0_189:lerp(L_IT_167_1.alpha3, 18, globals.frametime() * 15)
			L_167_12 = globals.frametime() * 15
		end

		local L_167_13, L_167_14 = renderer.measure_text("", L_IT_167_1.text)

		L_IT_167_1.ypos2 = L_0_189:lerp(L_IT_167_1.ypos2, y, L_167_12)

		local L_167_15 = L_IT_167_1.ypos2 - L_IT_167_1.ypos
		local L_167_16 = L_IT_167_1.alpha
		local L_167_17 = L_IT_167_1.alpha2
		local L_167_18 = 0
		local L_167_19 = L_167_13 * 2 / 2
		local L_167_20 = L_167_13 / 2

		L_0_186:FadedRoundedGlow(x - L_167_20 - 19, L_167_15 - 1, L_167_13 + 33, 22, 5, L_167_8, L_167_9, L_167_10, L_167_17, L_IT_167_1.alpha3, L_167_4, L_167_5, L_167_6)
		L_0_186:rounded_box(x - L_167_20 - 18, L_167_15, L_167_13 + 31, 20, 3, L_167_8, L_167_9, L_167_10, L_167_16, 255, 255, 255, L_167_16)

		if L_IT_167_1.player ~= nil then
			renderer.texture(L_0_187, x - L_167_20 - 12, L_167_15 + 3, 14, 14, 255, 255, 255, L_167_16, "")
			renderer.text(x - L_167_20 + 8, L_167_15 + 3, 225, 225, 225, L_167_17, "", 0, L_IT_167_1.text)
		else
			renderer.text(x - L_167_20 + 8, L_167_15 + 3, 225, 225, 225, L_167_17, "", 0, L_IT_167_1.text)
			renderer.texture(L_0_187, x - L_167_20 - 12, L_167_15 + 3, 14, 14, 255, 255, 255, L_167_16, "")
		end

		y = y + 25

	end
end

local L_0_190 = {
	"generic",
	"head",
	"chest",
	"stomach",
	"left arm",
	"right arm",
	"left leg",
	"right leg",
	"neck",
	"?",
	"gear"
}

function hit_logs(L_ARG_168_0)
	local L_168_0 = L_0_190[L_ARG_168_0.hitgroup + 1] or "?"

	if not L_0_174.hit_logs:get() then
		return
	end

	L_0_185:add_to_log(string.format("Hit \a75DB67FF%s \aFFFFFFFFin \a75DB67Ff%s \aFFFFFFFFfor \a75DB67FF%d \aFFFFFFFFdamage", entity.get_player_name(L_ARG_168_0.target), L_168_0, L_ARG_168_0.damage))
end

function miss_logs(L_ARG_169_0)
	local L_169_0 = L_0_190[L_ARG_169_0.hitgroup + 1] or "?"

	if not L_0_174.hit_logs:get() then
		return
	end

	L_0_185:add_to_log(string.format("Miss \aE05C5CFF%s \aFFFFFFFFin \aE05C5CFF%s \aFFFFFFFFdue to \aE05C5CFF%s", entity.get_player_name(L_ARG_169_0.target), L_169_0, L_ARG_169_0.reason))
end

local L_0_191, L_0_192 = client.screen_size()

function render_text()
	local L_170_0 = entity.get_local_player()

	if not entity.is_alive(L_170_0) then
		return
	end

	local L_170_1 = client.current_threat()

	if not L_170_1 or entity.is_dormant(L_170_1) then
		return
	end

	local L_170_2 = math.sin(globals.realtime() * 3) * 0.3 + 0.7
	local L_170_3 = L_0_184.left.active and math.min(100, math.floor(L_0_184.left.damage * 1.5)) or 0
	local L_170_4 = L_0_184.right.active and math.min(100, math.floor(L_0_184.right.damage * 1.5)) or 0
	local L_170_5 = string.format("Left: %d%% | Right: %d%%", L_170_3, L_170_4)
	local L_170_6, L_170_7 = renderer.measure_text("small", L_170_5)
	local L_170_8 = L_0_191 * 0.5 - 100
	local L_170_9 = L_0_192 * 0.5 + 20
	local L_170_10 = L_0_184.left.active and 180 + L_170_2 * 60 or 140
	local L_170_11 = L_0_184.right.active and 180 + L_170_2 * 60 or 140
	local L_170_12 = string.format("Left: %d%%", L_170_3)
	local L_170_13 = string.format(" | Right: %d%%", L_170_4)
	local L_170_14 = renderer.measure_text("small", L_170_12)

	renderer.text(L_170_8 + 55, L_170_9 + L_0_173.y_offset:get(), 50, 200, 200, L_170_10, "small", 0, L_170_12)
	renderer.text(L_170_8 + L_170_14 + 55, L_170_9 + L_0_173.y_offset:get(), 50, 200, 200, L_170_11, "small", 0, L_170_13)
end

client.register_esp_flag("DA", 255, 255, 255, function(L_ARG_171_0)
	return L_0_173.dormant:get() and L_0_173.dormant_k:get() and L_0_174.flag_indicators_v:get("Dormant aimbot") and entity.is_enemy(L_ARG_171_0) and entity.is_dormant(L_ARG_171_0) and entity.is_alive(entity.get_local_player())
end)
client.register_esp_flag("BAIM", 255, 255, 255, function(L_ARG_172_0)
	return plist.get(L_ARG_172_0, "Override prefer body aim") == "On" and L_0_174.flag_indicators_v:get("Body aim") and not entity.is_dormant(L_ARG_172_0)
end)
client.register_esp_flag("SAFE", 255, 255, 255, function(L_ARG_173_0)
	return plist.get(L_ARG_173_0, "Override safe point") == "On" and L_0_174.flag_indicators_v:get("Safe point") and not entity.is_dormant(L_ARG_173_0)
end)
client.register_esp_flag(tostring(L_0_166.pui.reference("Rage", "Aimbot", "Multi-point scale"):get()), 255, 255, 255, function(L_ARG_174_0)
	return L_0_174.flag_indicators_v:get("Multi-point") and not entity.is_dormant(L_ARG_174_0)
end)
client.set_event_callback("aim_hit", hit_logs)
client.set_event_callback("aim_miss", miss_logs)
client.set_event_callback("round_prestart", on_round_prestart)
client.set_event_callback("paint_ui", function()
	if L_0_173.peek_helper:get() and ui.get(L_0_167.peek[2]) then
		if L_0_173.helper_visual:get() == "World lines" then
			render_hud()
		else
			render_text()
		end
	end

	on_paint()
	L_0_185:logs()
end)
ui.set(L_0_182, true)
client.set_event_callback("setup_command", function(L_ARG_176_0)
	if L_0_173.auto_lc:get() and L_0_173.auto_lc_k:get() then
		auto_teleport(L_ARG_176_0)
	end

	on_setup_command(L_ARG_176_0)
	delay_shot(L_ARG_176_0)
	check_peek()
end)

if not LPH_OBFUSCATED then
	function LPH_JIT_MAX(...)
		return ...
	end

	function LPH_JIT(...)
		return ...
	end
end

client.set_event_callback("setup_command", LPH_JIT_MAX(function(L_ARG_179_0)
	aimtools(L_ARG_179_0)
end))
client.set_event_callback("level_init", LPH_JIT(function()
	collectgarbage("collect")
end))
client.set_event_callback("round_prestart", LPH_JIT(function()
	collectgarbage("collect")
end))
client.set_event_callback("aim_hit", LPH_JIT(function()
	collectgarbage("collect")
end))
client.set_event_callback("aim_miss", LPH_JIT(function()
	collectgarbage("collect")
end))

items = {
	L_0_172,
	L_0_173,
	L_0_174
}
L_0_169.cfg = L_0_166.pui.setup(items)
userid_to_entindex = client.userid_to_entindex
get_player_name = entity.get_player_name
get_local_player = entity.get_local_player
is_enemy = entity.is_enemy
console_cmd = client.exec
L_0_32 = ui.get
trashtalk = ui.new_checkbox("LUA", "A", "Killsay")
baimtable = {
	"ｅｌｉｍｉｎａｔｅｄ ｂｙ ｒｅｆｌｅｘ",
	"𝙩𝙝𝙖𝙩 𝙬𝙖𝙨 𝙥𝙚𝙧𝙛𝙚𝙘𝙩 𝙟𝙤𝙗 [𝙙𝙨𝙘.𝙜𝙜/𝙨𝙚𝙡𝙚𝙣𝙚𝙬𝙨]",
	"how you think what am I using? 𝐫𝐞𝐟𝐥𝐞𝐱",
	"1",
	"чувствуешь что не попадаешь ? так прикупи reflex resolver",
	"MODE : HARAM SQUAD ACTIVATED [AUTHORIZED with REFLEX & AIMTOOLS]",
	"1tapgang ft. dsc.gg/selenews [reflex & aimtools]",
	"V.I.P RESOLVER",
	"would you like to hit like that? 𝕛𝕠𝕚𝕟 𝕙𝕖𝕣𝕖 𝕒𝕟𝕕 𝕓𝕦𝕪 𝕣𝕖𝕗𝕝𝕖𝕩. 𝕕𝕤𝕔.𝕘𝕘/𝕤𝕖𝕝𝕖𝕟𝕖𝕨𝕤",
	"𝓈𝒶𝒹𝓁𝓎 𝓎𝑜𝓊 𝒹𝒾𝒹𝓃'𝓉 𝓀𝒾𝓁𝓁 𝓂𝑒, 𝒷𝓊𝓉 𝐼 𝒹𝒾𝒹. 𝒲𝒶𝓃𝓉 𝓉𝑜 𝓀𝒾𝓁𝓁 𝓁𝒾𝓀𝑒 𝓉𝒽𝒾𝓈? 𝒥𝓊𝓈𝓉 𝒷𝓊𝓎 𝓇𝑒𝒻𝓁𝑒𝓍 𝓇𝑒𝓈𝑜𝓁𝓋𝑒𝓇.",
	"выебан в жопу by reflex [dsc.gg/selenews]",
	"да ты фто? прям так легко? нихуя себе)",
	"omfg destroyed :joy:",
	"XDD free kill ty."
}
hstable = {
	"ｅｌｉｍｉｎａｔｅｄ ｂｙ ｒｅｆｌｅｘ",
	"𝙩𝙝𝙖𝙩 𝙬𝙖𝙨 𝙥𝙚𝙧𝙛𝙚𝙘𝙩 𝙟𝙤𝙗 [𝙙𝙨𝙘.𝙜𝙜/𝙨𝙚𝙡𝙚𝙣𝙚𝙬𝙨]",
	"how you think what am I using? 𝐫𝐞𝐟𝐥𝐞𝐱",
	"1",
	"чувствуешь что не попадаешь ? так прикупи reflex resolver",
	"MODE : HARAM SQUAD ACTIVATED [AUTHORIZED with REFLEX & AIMTOOLS]",
	"1tapgang ft. dsc.gg/selenews [reflex & aimtools]",
	"V.I.P RESOLVER",
	"would you like to hit like that? 𝕛𝕠𝕚𝕟 𝕙𝕖𝕣𝕖 𝕒𝕟𝕕 𝕓𝕦𝕪 𝕣𝕖𝕗𝕝𝕖𝕩. 𝕕𝕤𝕔.𝕘𝕘/𝕤𝕖𝕝𝕖𝕟𝕖𝕨𝕤",
	"𝓈𝒶𝒹𝓁𝓎 𝓎𝑜𝓊 𝒹𝒾𝒹𝓃'𝓉 𝓀𝒾𝓁𝓁 𝓂𝑒, 𝒷𝓊𝓉 𝐼 𝒹𝒾𝒹. 𝒲𝒶𝓃𝓉 𝓉𝑜 𝓀𝒾𝓁𝓁 𝓁𝒾𝓀𝑒 𝓉𝒽𝒾𝓈? 𝒥𝓊𝓈𝓉 𝒷𝓊𝓎 𝓇𝑒𝒻𝓁𝑒𝓍 𝓇𝑒𝓈𝑜𝓁𝓋𝑒𝓇.",
	"выебан в жопу by reflex [dsc.gg/selenews]",
	"да ты фто? прям так легко? нихуя себе)",
	"omfg destroyed :joy:",
	"XDD free kill ty."
}
deathtable = {
	"пиздец не повезло, ну ниче сын шлюхи некст раунд я тебя выебу",
	"а вот сука рефлекс не затащил...",
	"ДА ТЫ ШТО НАХУЙ ТЫ БЛЯ ДЕЛАЕШЬ?",
	"omfg how can you be that trash",
	"rubbersband... gg."
}

function get_table_length(L_ARG_184_0)
	if type(L_ARG_184_0) ~= "table" then
		return 0
	end

	local L_184_0 = 0

	for L_IT_184_0 in L_0_30(L_ARG_184_0) do
		L_184_0 = L_184_0 + 1
	end

	return L_184_0
end

local L_0_193 = get_table_length(baimtable)
local L_0_194 = get_table_length(hstable)
local L_0_195 = get_table_length(deathtable)

function on_player_death(L_ARG_185_0)
	if not L_0_32(trashtalk) then
		return
	end

	local L_185_0 = L_ARG_185_0.userid
	local L_185_1 = L_ARG_185_0.attacker

	if L_185_0 == nil or L_185_1 == nil then
		return
	end

	local L_185_2 = userid_to_entindex(L_185_0)

	if userid_to_entindex(L_185_1) == get_local_player() and is_enemy(L_185_2) then
		if L_ARG_185_0.headshot then
			client.delay_call(1, function()
				local L_186_0 = "say " .. hstable[math.random(L_0_194)]

				console_cmd(L_186_0)
			end)
		else
			client.delay_call(1, function()
				local L_187_0 = "say " .. baimtable[math.random(L_0_193)]

				console_cmd(L_187_0)
			end)
		end
	end
end

client.set_event_callback("player_death", on_player_death)

local resolver = {
	mode = ui.new_combobox("LUA", "B", "\aFF0000FF \aFFFFFFFFDefensive Resolver", {
		"Off",
		"Auto",
		"Miss-based",
		"Wait until shot",
		"Delta check",
		"Peek only"
	}),
	yaw_step = ui.new_slider("LUA", "B", "\aFF0000FF \aFFFFFFFFResolver yaw step", -180, 180, 60),
	enable_logs = ui.new_checkbox("LUA", "B", "\aFF0000FF \aFFFFFFFFEnable Resolver Logs"),
	show_status = ui.new_checkbox("LUA", "B", "\aFF0000FF \aFFFFFFFFShow Resolver Status"),
	normal_enabled = ui.new_checkbox("LUA", "B", "\aFF0000FF \aFFFFFFFFResolver"),
	missed_shots = {},
	last_shot_time = {},
	override_targets = {},
	normal_overrides = {},
	hit_info = {},
	rows = {}
}

client.set_event_callback("script_load", function()
	resolver.missed_shots = {}
	resolver.last_shot_time = {}
	resolver.override_targets = {}
	resolver.normal_overrides = {}
	resolver.hit_info = {}
	resolver.rows = {}
end)

resolver.get_delta = function(L_ARG_189_0)
	local eye_yaw = entity.get_prop(L_ARG_189_0, "m_angEyeAngles[1]") or 0
	local lby = entity.get_prop(L_ARG_189_0, "m_flLowerBodyYawTarget") or 0

	return math.abs((eye_yaw - lby + 180) % 360 - 180)
end

resolver.is_peeking = function(L_ARG_190_0, L_ARG_190_1)
	local lx, ly = entity.get_origin(L_ARG_190_0)
	local ex, ey = entity.get_origin(L_ARG_190_1)

	if not lx or not ex then
		return false
	end

	local dx, dy = lx - ex, ly - ey
	local enemy_yaw = entity.get_prop(L_ARG_190_1, "m_angEyeAngles[1]") or 0
	local angle_to_us = math.deg(math.atan2(dy, dx))
	local yaw_diff = math.abs((angle_to_us - enemy_yaw + 180) % 360 - 180)

	return yaw_diff < 60
end

client.set_event_callback("aim_miss", function(L_ARG_191_0)
	local entindex = client.userid_to_entindex(L_ARG_191_0.target)

	if entindex then
		resolver.missed_shots[entindex] = (resolver.missed_shots[entindex] or 0) + 1

		if ui.get(resolver.enable_logs) then
			local name = entity.get_player_name(entindex) or "?"

			client.log(string.format("[Defensive Resolver] %s | reason: %s", name, L_ARG_191_0.reason or "unknown"))
		end
	end
end)
client.set_event_callback("aim_hit", function(L_ARG_192_0)
	local target = L_ARG_192_0.target

	if target then
		resolver.hit_info[target] = globals.realtime()

		if ui.get(resolver.enable_logs) then
			local name = entity.get_player_name(target) or "?"
			local hitgroup = L_ARG_192_0.hitgroup or "?"

			client.log(string.format("[Defensive Resolver] %s | Hitgroup: %s | Damage: %d", name, tostring(hitgroup), L_ARG_192_0.damage or 0))
		end
	end
end)
client.set_event_callback("aim_fire", function(L_ARG_193_0)
	if L_ARG_193_0.target then
		resolver.last_shot_time[L_ARG_193_0.target] = globals.realtime()
	end
end)
client.set_event_callback("player_death", function(L_ARG_194_0)
	local victim = client.userid_to_entindex(L_ARG_194_0.userid)

	if victim then
		resolver.missed_shots[victim] = 0
		resolver.last_shot_time[victim] = 0
		if resolver.override_targets[victim] ~= nil or resolver.normal_overrides[victim] ~= nil then
			plist.set(victim, "Force body yaw", false)
		end
		resolver.override_targets[victim] = nil
		resolver.normal_overrides[victim] = nil
		resolver.hit_info[victim] = nil
	end
end)
client.set_event_callback("run_command", function()
	local mode = ui.get(resolver.mode)
	local primary_resolver_enabled = ui.get(L_0_76)
	local normal_enabled = ui.get(resolver.normal_enabled) and not primary_resolver_enabled
	local local_player = entity.get_local_player()
	if local_player == nil or not entity.is_alive(local_player) then
		for target in pairs(resolver.override_targets) do
			plist.set(target, "Force body yaw", false)
		end
		for target in pairs(resolver.normal_overrides) do
			plist.set(target, "Force body yaw", false)
		end
		resolver.override_targets = {}
		resolver.normal_overrides = {}
		resolver.rows = {}
		return
	end

	local step = ui.get(resolver.yaw_step)
	local logs = ui.get(resolver.enable_logs)
	local now = globals.realtime()
	local rows = {}

	for _, target in ipairs(entity.get_players(true)) do
		local target_valid = entity.is_alive(target) and not entity.is_dormant(target)

		if normal_enabled and target_valid then
			local eye_yaw = entity.get_prop(target, "m_angEyeAngles[1]") or 0
			local lower_body_yaw = entity.get_prop(target, "m_flLowerBodyYawTarget") or 0
			local yaw_offset = (lower_body_yaw - eye_yaw + 180) % 360 - 180

			if math.abs(yaw_offset) > 35 then
				resolver.normal_overrides[target] = yaw_offset
				plist.set(target, "Force body yaw value", yaw_offset)
				plist.set(target, "Force body yaw", true)
			else
				if resolver.normal_overrides[target] ~= nil then
					plist.set(target, "Force body yaw", false)
				end
				resolver.normal_overrides[target] = nil
			end
		else
			if resolver.normal_overrides[target] ~= nil and not primary_resolver_enabled then
				plist.set(target, "Force body yaw", false)
			end
			resolver.normal_overrides[target] = nil
		end

		if not target_valid or mode == "Off" or primary_resolver_enabled or normal_enabled then
			if resolver.override_targets[target] ~= nil and not primary_resolver_enabled and not (normal_enabled and target_valid) then
				plist.set(target, "Force body yaw", false)
			end
			resolver.override_targets[target] = nil
		else
			local apply, reason = false, "no condition"
			local eye_yaw = entity.get_prop(target, "m_angEyeAngles[1]") or 0
			local delta = resolver.get_delta(target)

			if mode == "Auto" then
				local misses = resolver.missed_shots[target] or 0
				local last = resolver.last_shot_time[target]
				local delay = last ~= nil and now - last or math.huge

				if misses >= 1 then
					apply = true
					reason = string.format("auto: misses %d", misses)
				elseif delay < 1.5 then
					apply = true
					reason = string.format("auto: shot %.2fs ago", delay)
				elseif delta > 35 then
					apply = true
					reason = string.format("auto: delta %.1f", delta)
				elseif resolver.is_peeking(local_player, target) then
					apply = true
					reason = "auto: peeking"
				end
			elseif mode == "Miss-based" then
				local misses = resolver.missed_shots[target] or 0
				apply = misses >= 1
				reason = string.format("misses %d", misses)
			elseif mode == "Wait until shot" then
				local last = resolver.last_shot_time[target]
				local delay = last ~= nil and now - last or math.huge
				apply = delay < 1.5
				reason = last ~= nil and string.format("shot %.2fs ago", delay) or "no recent shot"
			elseif mode == "Delta check" then
				apply = delta > 35
				reason = string.format("delta %.1f", delta)
			elseif mode == "Peek only" then
				apply = resolver.is_peeking(local_player, target)
				reason = apply and "peeking" or "not peeking"
			end

			local override_yaw
			if apply then
				override_yaw = (eye_yaw + step + 180) % 360 - 180
				resolver.override_targets[target] = override_yaw
				plist.set(target, "Force body yaw value", override_yaw)
				plist.set(target, "Force body yaw", true)

				if logs then
					local name = entity.get_player_name(target) or "?"
					client.log(string.format("[Defensive Resolver] %s | Mode: %s | eye_yaw: %.1f | delta: %.1f | → set yaw: %.1f | %s", name, mode, eye_yaw, delta, override_yaw, reason))
				end
			else
				if resolver.override_targets[target] ~= nil then
					plist.set(target, "Force body yaw", false)
				end
				resolver.override_targets[target] = nil
			end
			rows[#rows + 1] = {
				name = entity.get_player_name(target) or "?",
				delta = delta,
				active = apply,
				reason = reason,
				yaw = override_yaw
			}
		end
	end
	resolver.rows = rows
end)
client.set_event_callback("paint", function()
	if not ui.get(resolver.show_status) then
		return
	end

	local _, screen_height = client.screen_size()
	local padding = 6
	local lines = {
		"» Defensive Resolver Status",
		"Mode: " .. ui.get(resolver.mode)
	}
	for index = 1, math.min(#resolver.rows, 5) do
		local row = resolver.rows[index]
		local state = row.active and string.format("active %.1f°", row.yaw) or "idle"
		lines[#lines + 1] = string.format("%s | Δ %.1f° | %s (%s)", row.name, row.delta, state, row.reason)
	end
	if ui.get(L_0_76) then
		lines[#lines + 1] = "Primary resolver enabled; custom override paused"
	elseif #resolver.rows == 0 then
		lines[#lines + 1] = "No active opponents"
	end

	local widest = 0
	for _, line in ipairs(lines) do
		local text_width = renderer.measure_text("", line)
		widest = math.max(widest, text_width)
	end

	local box_x, box_y = 20, screen_height / 2 - (#lines * 15 + padding * 2) / 2
	local box_width = widest + padding * 2
	local box_height = #lines * 15 + padding * 2
	renderer.rectangle(box_x - 2, box_y - 2, box_width + 4, box_height + 4, 10, 10, 10, 200)
	renderer.gradient(box_x, box_y, box_width, box_height, 40, 40, 40, 180, 20, 20, 20, 180, true)
	for index, line in ipairs(lines) do
		renderer.text(box_x + padding, box_y + padding + (index - 1) * 15, 255, 255, 255, 255, "", 0, line)
	end
end)

local L_0_196 = {
	L_0_76,
	L_0_77,
	L_0_78,
	L_0_79,
	L_0_80,
	L_0_81,
	L_0_82,
	L_0_85,
	L_0_86,
	L_0_87,
	L_0_89,
	L_0_90,
	L_0_91,
	L_0_88
}

local function L_0_197()
	local L_197_0 = ui.get(L_0_0)
	local L_197_1 = ui.get(L_0_76)
	local L_197_2 = {
		L_0_76,
		L_0_77,
		L_0_78,
		L_0_79,
		L_0_80,
		L_0_81,
		L_0_82,
		L_0_85,
		L_0_86,
		L_0_87,
		L_0_89,
		L_0_90,
		L_0_91,
		L_0_88,
		L_0_118,
		L_0_120,
		L_0_121,
		L_0_117,
		L_0_116,
		gradient_alpha,
		L_0_160,
		L_0_134,
		L_0_135,
		L_0_131,
		trashtalk,
		L_0_120,
		table.unpack(L_0_196)
	}

	for L_IT_197_0, L_IT_197_1 in L_0_30(L_197_2) do
		ui.set_visible(L_IT_197_1, false)
	end

	local L_197_3 = {
		Rage = {
			L_0_76
		},
		Misc = {
			L_0_160,
			trashtalk,
			gradient_alpha
		},
		Tweaks = {
			L_0_116,
			L_0_117,
			L_0_118
		},
		Helpers = {
			L_0_134,
			L_0_135,
			L_0_120
		}
	}

	if L_197_1 then
		L_197_3.Rage = L_0_196
	end

	for L_IT_197_2, L_IT_197_3 in L_0_30(L_197_3[L_197_0:gsub(" .*", "")]) do
		ui.set_visible(L_IT_197_3, true)
	end
end

ui.set_callback(L_0_0, L_0_197)
ui.set_callback(L_0_76, L_0_197)
L_0_197()
