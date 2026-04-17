local ffi = require("ffi")
local pui = require("gamesense/pui")
local base64 = require("gamesense/base64")
local images = require("gamesense/images")
local clipboard = require("gamesense/clipboard")
local c_entity = require('gamesense/entity')
local json = require("json")
local weapons = require 'gamesense/csgo_weapons'
local vector = require("vector")
local http = require("gamesense/http")


if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = function(...) return ... end
    LPH_JIT_MAX = function(...) return ... end
    LPH_JIT = function(...) return ... end
end

local relentless_data = {} do
    relentless_data.name = "Funeral"
    relentless_data.update = "владивосток_россия_2026"
end



local db = {
	key = "relentless_side_level_228",
	version = 2,
} do
	local data = database.read(db.key)

	if not data then
		data = {
			stats = {
				killed = 0
			},
		}

		database.write(db.key, data)
	end


	if not data.stats.killed then data.stats.killed = 0 end

	--
	do
		local function automemo ()
			client.fire_event("relentlessblyat|database_write")
			database.write(db.key, data)
			client.delay_call(300, automemo)
		end client.delay_call(300, automemo)
	end

	defer(function ()
		database.write(db.key, data)
		database.flush()
	end)

	setmetatable(db, {
		__index = data,
		__call = function (self, flush)
			database.write(db.key, data)
			if flush == true then database.flush() end
		end
 	})
end

lerp = function(start,vend, time)
    return start + (vend - start) * globals.frametime() * time
end

clamp = function(x, min, max)
    return x < min and min or x > max and max or x
end

rec = function(x, y, w, h, radius, color)
    radius = math.min(x/2, y/2, radius)
    local r, g, b, a = unpack(color)
    renderer.rectangle(x, y + radius, w, h - radius*2, r, g, b, a)
    renderer.rectangle(x + radius, y, w - radius*2, radius, r, g, b, a)
    renderer.rectangle(x + radius, y + h - radius, w - radius*2, radius, r, g, b, a)
    renderer.circle(x + radius, y + radius, r, g, b, a, radius, 180, 0.25)
    renderer.circle(x - radius + w, y + radius, r, g, b, a, radius, 90, 0.25)
    renderer.circle(x - radius + w, y - radius + h, r, g, b, a, radius, 0, 0.25)
    renderer.circle(x + radius, y - radius + h, r, g, b, a, radius, -90, 0.25)
end

rec_outline = function(x, y, w, h, radius, thickness, color)
    radius = math.min(w/2, h/2, radius)
    local r, g, b, a = unpack(color)
    if radius == 1 then
        renderer.rectangle(x, y, w, thickness, r, g, b, a)
        renderer.rectangle(x, y + h - thickness, w , thickness, r, g, b, a)
    else
        renderer.rectangle(x + radius, y, w - radius*2, thickness, r, g, b, a)
        renderer.rectangle(x + radius, y + h - thickness, w - radius*2, thickness, r, g, b, a)
        renderer.rectangle(x, y + radius, thickness, h - radius*2, r, g, b, a)
        renderer.rectangle(x + w - thickness, y + radius, thickness, h - radius*2, r, g, b, a)
        renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, 0.25, thickness)
        renderer.circle_outline(x + radius, y + h - radius, r, g, b, a, radius, 90, 0.25, thickness)
        renderer.circle_outline(x + w - radius, y + radius, r, g, b, a, radius, -90, 0.25, thickness)
        renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 0.25, thickness)
    end
end

easeInOut = function(t)
    return (t > 0.5) and 4*((t-1)^3)+1 or 4*t^3;
end

glow_module = function(x, y, w, h, width, rounding, accent, accent_inner)
    local thickness = 1
    local offset = 1
    local r, g, b, a = unpack(accent)
    if accent_inner then
        rec(x , y, w, h + 1, rounding, accent_inner)
    end
    for k = 0, width do
        if a * (k/width)^(1) > 5 then
            local accent = {r, g, b, a * (k/width)^(2)}
            rec_outline(x + (k - width - offset)*thickness, y + (k - width - offset) * thickness, w - (k - width - offset)*thickness*2, h + 1 - (k - width - offset)*thickness*2, rounding + thickness * (width - k + offset), thickness, accent)
        end
    end
end

RGBAtoHEX = function(redArg, greenArg, blueArg, alphaArg)
    return string.format('%.2x%.2x%.2x%.2x', redArg, greenArg, blueArg, alphaArg)
end

split = function( inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

local color_text = function(string, r, g, b, a)
    local accent = "\a" .. RGBAtoHEX(100, 100, 100, a) 
    local white = "\a" .. RGBAtoHEX(255, 255, 255, a)

    local str = ""
    for i, s in ipairs(split(string, "$")) do
        str = str .. (i % 2 ==( string:sub(1, 1) == "$" and 0 or 1) and white or accent) .. s
    end

    return str
end

-- @region NOTIFICATION_ANIM start
local anim_time = 0.5
local max_notifs = 6
local data = {}
local notifications = {

        new = function(string, r, g, b)
            table.insert(data, {
                time = globals.curtime(),
                string = string,
                color = {r, g, b, 255},
                fraction = 0
            })
            local time = 5
            for i = #data, 1, -1 do
                local notif = data[i]
                if #data - i + 1 > max_notifs and notif.time + time - globals.curtime() > 0 then
                    notif.time = globals.curtime() - time
                end
            end
        end,

      render = function()
        local x, y = client.screen_size()
        local to_remove = {}
        local Offset = 0
        for i = 1, #data do
            local notif = data[i]

                local data = {rounding = 6, size = 4, glow = 10, time = 1.9}

            if notif.time + data.time - globals.curtime() > 0 then
                notif.fraction = clamp(notif.fraction + globals.frametime() / anim_time, 0, 1)
            else
                notif.fraction = clamp(notif.fraction - globals.frametime() / anim_time, 0, 1)
            end

            if notif.fraction <= 0 and notif.time + data.time - globals.curtime() <= 0 then
                table.insert(to_remove, i)
            end
            local fraction = easeInOut(notif.fraction)

            local r, g, b, a = unpack(notif.color)
            local string = color_text(notif.string, r, g, b, a * fraction)

            local strw, strh = renderer.measure_text("", string)
            local strw2 = renderer.measure_text("b", "")

            local paddingx, paddingy = 7, data.size
            local offsetY = 220

            Offset = Offset + (strh + paddingy*2 + math.sqrt(data.glow/10)*10 + 5) * fraction
            glow_module(x/2 - (strw + strw2)/2 - paddingx, y - offsetY - strh/2 - paddingy - Offset, strw + strw2 + paddingx*2, strh + paddingy*2, data.glow, data.rounding, {r, g, b, 45 * fraction * 0.0}, {25, 25, 25, 180 * fraction * 1}) 
            renderer.text(x/2 + strw2/2, y - offsetY - Offset, 255, 255, 255, 255 * fraction, "c", 0, string)
        end

        for i = #to_remove, 1, -1 do
            table.remove(data, to_remove[i])
        end
    end,

    clear = function()
        data = {}
    end
}





local main_group = pui.group("AA", "anti-aimbot angles")
local fakelag_group = pui.group("AA", "fake lag")
local other_group = pui.group("AA", "other")
local alive_players = {}

local aa_config = { '\vGlobal\r','\vStand\r', '\vSlow~Walk\r', '\vMoving\r' , '\vAir\r', '\vAir~Crouch\r', '\vCrouch\r', "\vCrouch~Move\r", "\vFake~Lag\r", "\vFreestanding\r"}


local ref = {
    aimbot = ui.reference('RAGE', 'Aimbot', 'Enabled'),
    enabled = ui.reference('AA', 'Anti-aimbot angles', 'Enabled'),
    yawbase = ui.reference('AA', 'Anti-aimbot angles', 'Yaw base'),
    forcebaim = ui.reference('RAGE', 'Aimbot', 'Force body aim'),
    fsbodyyaw = { ui.reference('AA', 'anti-aimbot angles', 'Freestanding body yaw') },
    edgeyaw = ui.reference('AA', 'Anti-aimbot angles', 'Edge yaw'),
    fakeduck = ui.reference('RAGE', 'Other', 'Duck peek assist'),
    roll = { ui.reference('AA', 'Anti-aimbot angles', 'Roll') },
    hs = { ui.reference('AA',"other","on shot anti-aim")},
    dt = { ui.reference("RAGE","aimbot","Double tap")},
    pitch = { ui.reference('AA', 'Anti-aimbot angles', 'pitch'), },
    yaw = { ui.reference('AA', 'Anti-aimbot angles', 'Yaw') }, 
    yawjitter = { ui.reference('AA', 'Anti-aimbot angles', 'Yaw jitter') },
    body_yaw = { ui.reference('AA', 'Anti-aimbot angles', 'Body yaw') },
    freestanding = { ui.reference('AA', 'Anti-aimbot angles', 'Freestanding') },
    slow = { ui.reference('AA', 'Other', 'Slow motion') },
    os = { ui.reference('AA', 'Other', 'On shot anti-aim') },
    fakelaglimit = {ui.reference("AA","Fake lag", "Limit")},
    fakelagvariance = {ui.reference("AA","Fake lag", "Variance")},
    fakelagamount = {ui.reference("AA","Fake lag", "Amount")},
    fakelagenabled = {ui.reference("AA","Fake lag", "Enabled")},
    legmovement = {ui.reference("AA","Other", "Leg movement")},
    fakepeek = {ui.reference("AA","Other", "Fake peek")},
    mindamage = ui.reference("Rage", "Aimbot", "Minimum damage"),
    minimum_damage_override = { ui.reference("RAGE", "Aimbot", "Minimum damage override") },
    fov = ui.reference("Misc", "Miscellaneous", "Override FOV"),
    purchases = ui.reference("Misc", "Miscellaneous", "Log weapon purchases"),
    clantag1 = ui.reference("Misc", "Miscellaneous", "Clan Tag Spammer"),
    scope_overlay = ui.reference('VISUALS', 'Effects', 'Remove scope overlay'),
    menu_color = {ui.reference("Misc", "Settings", "Menu color")},
    sv_maxusrcmdprocessticks = ui.reference("Misc", "Settings", "sv_maxusrcmdprocessticks2"),
    prefer_safe_point = ui.reference('RAGE', 'Aimbot', 'Prefer safe point'),
    force_safe_point = ui.reference('RAGE', 'Aimbot', 'Force safe point'),
    prefer_body_aim = ui.reference('RAGE', 'Aimbot', 'Prefer body aim'),
    ping_spike = { ui.reference('MISC', 'Miscellaneous', 'Ping spike') },
}

local sv_cmdticks_cvar = cvar.sv_maxusrcmdprocessticks


local menu = {
    main = {
    user_wt = fakelag_group:label("{ } • Relentless"),
    current_tab = fakelag_group:listbox('Tab Selector', '\a848ff0d9Home', " > Information", " > Social Links", " > Configs", "\a848ff0d9Ragebot", " > Aimtools", " > Predict", "\a848ff0d9Anti~Aims", " > Builder", " > Defensive", " > Other", " > Hotkeys", "\a848ff0d9Miscellaneus", " > Visuals", " > Misc", false),
    },

    information = {

    information_user = main_group:label("\v•\r Information"),
    information_user_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
    user = main_group:label("\v\rUser • \v" .. relentless_data.name),
    last_update = main_group:label("\v\rLast Update • \v" .. relentless_data.update),
    killed = main_group:label("\v\rEnemies Fucked • \v" .. db.stats.killed),
    session = main_group:label("\v\rSession • \v")
   },
  
    social_links = {
        
    social_text = main_group:label("\v•\r Social Links"),
    social_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
    links = main_group:slider("Our team \vSocial\r", 1, 3, 0, true, "%", 1, {[1] = "Youtube", [2] = "Discord", [3] = "Neverlose"}),
    discord = main_group:button("\a008EFFFFDiscord\r server", function ()
        panorama.loadstring(panorama.open("CSGOHud").SteamOverlayAPI.OpenExternalBrowserURL("https://dsc.gg/relentlesslua"))
        end),
        youtube = main_group:button("\aD97B7FFFYou\rTube", function ()
        panorama.loadstring(panorama.open("CSGOHud").SteamOverlayAPI.OpenExternalBrowserURL("https://www.youtube.com/@funeralhvh"))
        end),
        neverlose = main_group:button("\a97C8E0FFNever\rLose", function ()
        panorama.loadstring(panorama.open("CSGOHud").SteamOverlayAPI.OpenExternalBrowserURL("https://ru.neverlose.cc/market/item?id=I32Izh"))
        end)
    },   

    ragebot = {
        ragebot_text = main_group:label("\v•\r Ragebot"),
        ragebot_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
    },
    
    aimtools = {
        aimtools_text = main_group:label("\v•\r Aimtools"),
        aimtools_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
        
        aim_punch_fix = main_group:checkbox('Aim Punch Miss Fix'),
        
        spacing_1 = main_group:label('\n'),
        aimbot_helper_text = main_group:label('\v•\r Aimbot Helper'),
        aimbot_helper_poloska = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        aimbot_helper = main_group:checkbox('Enable Aimbot Helper'),
        weapon_select = main_group:combobox('Weapon', 'SSG-08', 'AWP', 'Auto Snipers'),
        
        -- SSG-08 Settings
        ssg_select = main_group:multiselect('SSG-08 Options', 'Force Safe Point', 'Prefer Body Aim', 'Force Body Aim', 'Ping Spike'),
        
        ssg_safe_triggers = main_group:multiselect('Safe Point Triggers', 'Enemy HP < X', 'X Missed Shots', 'Lethal', 'Height Advantage'),
        ssg_safe_hp = main_group:slider('Safe Point HP', 1, 100, 50, true, 'hp'),
        ssg_safe_miss = main_group:slider('Safe Point Misses', 1, 10, 2, true, 'shots'),
        
        ssg_prefer_triggers = main_group:multiselect('Prefer Body Triggers', 'Enemy HP < X', 'X Missed Shots', 'Lethal', 'Height Advantage'),
        ssg_prefer_hp = main_group:slider('Prefer Body HP', 1, 100, 50, true, 'hp'),
        ssg_prefer_miss = main_group:slider('Prefer Body Misses', 1, 10, 2, true, 'shots'),
        
        ssg_force_triggers = main_group:multiselect('Force Body Triggers', 'Enemy HP < X', 'X Missed Shots', 'Lethal', 'Height Advantage'),
        ssg_force_hp = main_group:slider('Force Body HP', 1, 100, 50, true, 'hp'),
        ssg_force_miss = main_group:slider('Force Body Misses', 1, 10, 2, true, 'shots'),
        
        ssg_ping_spike = main_group:slider('Ping Spike Value', 1, 200, 80, true, 'ms'),
        
        -- AWP Settings
        awp_select = main_group:multiselect('AWP Options', 'Force Safe Point', 'Prefer Body Aim', 'Force Body Aim', 'Ping Spike'),
        
        awp_safe_triggers = main_group:multiselect('Safe Point Triggers', 'Enemy HP < X', 'X Missed Shots', 'Lethal', 'Height Advantage'),
        awp_safe_hp = main_group:slider('Safe Point HP', 1, 100, 50, true, 'hp'),
        awp_safe_miss = main_group:slider('Safe Point Misses', 1, 10, 2, true, 'shots'),
        
        awp_prefer_triggers = main_group:multiselect('Prefer Body Triggers', 'Enemy HP < X', 'X Missed Shots', 'Lethal', 'Height Advantage'),
        awp_prefer_hp = main_group:slider('Prefer Body HP', 1, 100, 50, true, 'hp'),
        awp_prefer_miss = main_group:slider('Prefer Body Misses', 1, 10, 2, true, 'shots'),
        
        awp_force_triggers = main_group:multiselect('Force Body Triggers', 'Enemy HP < X', 'X Missed Shots', 'Lethal', 'Height Advantage'),
        awp_force_hp = main_group:slider('Force Body HP', 1, 100, 50, true, 'hp'),
        awp_force_miss = main_group:slider('Force Body Misses', 1, 10, 2, true, 'shots'),
        
        awp_ping_spike = main_group:slider('Ping Spike Value', 1, 200, 80, true, 'ms'),
    },
    
    predict = {
        predict_text = main_group:label("\v•\r Predict"),
        predict_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
        
        spacing_1 = main_group:label('\n'),
        predict_enemies = main_group:checkbox('Predict Enemies'),
        predict_mode = main_group:slider('Predict Mode', 0, 2, 1, true, '', 1, {[0] = 'Wingman', [1] = 'Competitive', [2] = 'Funeral'}),
        predict_mode_type = main_group:multiselect('Predict Type', 'Travel Through BT', "Menu's Point"),
        menus_on_point = main_group:checkbox("Menu's On Point"),
        
        travel_bt_memories = main_group:checkbox('Travel Through BT Memories'),
        backtrack_hitboxes = main_group:multiselect('Reverse Hitboxes In Time', 'Head', 'Chest', 'Stomach'),
        backtrack_attach = main_group:slider('Attach BackTrack At', 0, 2, 0, true, '', 1, {[0] = 'Head', [1] = 'Chest', [2] = 'Stomach'}),
    },

    antiaim = {

        builder_text = main_group:label("\v•\r Anti~Aim Builder"),
        builder_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
        antiaim_select = main_group:combobox('\v{ }\r Condition', aa_config),
    },

    defensive = {
        defensive_text = main_group:label("\v•\r Defensive Builder"),
        defensive_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
        defensive_select = main_group:combobox('\v{ }\r Condition', aa_config),
    },

    hotkeys = {

        hotkeys_text = main_group:label("\v•\r Anti~Aim Hotkeys"),
        xyi2 = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        freestanding_yaw = main_group:hotkey('Freestanding'),
        manual_forward = main_group:hotkey('Manual Yaw Forward'),
        manual_left = main_group:hotkey('Manual Yaw Left'),
        manual_right = main_group:hotkey('Manual Yaw Right'),
        poloska1 = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
    },

    other = {

        features_text = main_group:label("\v•\r Anti~Aim Features"),
        xyi4 = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        safe_head = main_group:checkbox("Safe Head"),
        safe_head_select = main_group:multiselect("\n", {"Zeus", "Knife"}),
        avoid_backstab = main_group:checkbox("Avoid Backstab"),
        avoid_backstab_amount = main_group:slider('Distance', 50, 350, 250, true, '°', 1, {[250] = "Default"}),
        anti_bruteforce = main_group:checkbox("Anti Bruteforce"),
        anim_breaker = main_group:checkbox('Anim Breakers'),
        anim_breaker_ground = main_group:combobox('Ground', 'Off', 'Static', 'Jitter', 'Random'),
        anim_breaker_random_amount = main_group:slider('Amount', 1, 13, 1, true, '', 1),
        anim_breaker_jitter_first = main_group:slider('First Jitter', 1, 13, 1, true, '', 1),
        anim_breaker_jitter_second= main_group:slider('Second Jitter', 1, 13, 1, true, '', 1),
        anim_breaker_air = main_group:combobox("Air", "Off", "Static", "Jitter"),
        anim_breaker_air_amount = main_group:slider("Amount", 1, 10, 1, true, '', 1),
        anim_breaker_other = main_group:multiselect("Other", "Move Lean", "EarthQuake"),
        aa_disablers = main_group:checkbox("Disablers"),
        aa_disabler_mode = main_group:multiselect('Disabler Type', 'On Warmup', "No Enemies"),
        aa_disabler_speed = main_group:slider('Speed', -180, 180, 5, true, '°'),
    },


    visuals = {

        visuals_text = main_group:label("\v•\r Visuals"),
        xyi3 = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        aimbot_logger = main_group:checkbox("Aimbot Logger"),
        aimbot_logger_type = main_group:multiselect("Logs Type", "Console", "Screen", "Purchases"),
        aimbot_logger_prefix = main_group:combobox("Prefix", "Default", "Custom"),
        aimbot_logger_prefix1 = main_group:textbox("snapshot"),
        ragebot_label1 = main_group:label(' Main Color'),
        main_colors = main_group:color_picker('main', 116, 189, 96, 255),
        ragebot_label2 = main_group:label(' Miss Color'),
        ragebot_miss = main_group:color_picker('miss', 189, 99, 96, 255),
        console_filter = main_group:checkbox("Console Filter"),
        animated_zoom = main_group:checkbox("Animated Zoom"),
        animated_fov = main_group:slider('\n', 1, 10, 3, true),
        aspectratio = main_group:checkbox("Aspect Ratio"),
        aspectratio_value = main_group:slider("Value", 00, 200, 133),
        velocity_indicator = main_group:checkbox("Velocity Indicator"),
        velocity_color = main_group:color_picker("color", 189, 99, 96, 255),
        custom_scope = main_group:checkbox("Custom Scope Overlay"),
        custom_scope_color_picker = main_group:color_picker("Scope Overlay Color", 255, 255, 255, 255),
        custom_scope_overlay_position = main_group:slider("Position", 0, 50, 5),
        custom_scope_overlay_offset = main_group:slider("Offset", 15, 300, 100),
        cross_indicator = main_group:checkbox("Crosshair Indicators"),
        cross_indicator_color = main_group:color_picker("\n", 255, 255, 255, 255),
        bullet_line = main_group:checkbox('Bullet Tracer'),
        bullet_line_color = main_group:color_picker('\n', 255, 255, 255, 175),
        damage_indicator = main_group:checkbox("Damage Indicator"),
        damage_indicator_select = main_group:multiselect("\n", "Show Always"),
        watermark_mode = main_group:combobox("Watermark Type", "Default", "Modern", "Custom"),
        watermark_color = main_group:color_picker('Color', 116, 189, 96, 255),
        watermark_text = main_group:textbox('Watermark Text'),
        watermark_prefix = main_group:textbox("Watermark Prefix"),
        watermark_position = main_group:slider('Position', 1, 3, 1, true, '', 1, {[1] = "Left", [2] = "Right", [3] = "Down"}),
        watermark_font = main_group:slider('Font', 1, 3, 1, true, '', 1, {[1] = "Default", [2] = "Bold", [3] = "Pixel"}),
        watermark_gradient = main_group:slider('Gradient', 1, 2, 1, true, '', 1, {[1] = "Off", [2] = "Enabled"}),
        manual_arrows = main_group:checkbox("Manual Arrows"),
        manual_arrows_color = main_group:color_picker("Arrows Color", 116, 189, 96, 255),
        manual_arrows_style = main_group:combobox("Arrows Style", "Classic", "Modern", "Modern v2"),
        manual_arrows_tweaks = main_group:multiselect("Arrows Tweaks", "Scope transparency", "Adjust height position"),
    },

    misc = {

        misc_text = main_group:label("\v•\r Miscellaneus"),
        xyi5 = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        ideal_tick = main_group:checkbox('Ideal Tick'),
        unsafe_recharge = main_group:checkbox("Unsafe Recharge"),
        fast_ladder = main_group:checkbox("Fast Ladder"),
        killsay = main_group:checkbox('TrashTalk'),
        killsay_mode = main_group:combobox("Mode\nkillsay_mode", "Bait", "Relentless"),
        killsay_select = main_group:multiselect("\nkillsay_select", "On kill", "On death", "Revenge"),
        hideshots_fix = main_group:checkbox("OSAA FIX"),
        clantag = main_group:checkbox("Clantag"),
        fakelag_exploit = main_group:checkbox("\aFD0540FF⚠️\rCustom Choke\aFD0540FF⚠️\r"),
        fakelag_exploit1 = main_group:label("Open Cheat tab misc -> settings -> sv_maxusrcmdprocessticks2"),
        fakelag_exploit2 = main_group:label("enable only in spectators")
    },

    configs = {
        
    config_poloska1 = main_group:label("\v•\r Configurations"),
    config_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
    listtt = main_group:listbox('Configs list', '', false),
    name = main_group:textbox('Config Name', '', false),
    create = main_group:button('Create', function() end),
    load = main_group:button('Load', function() end),
    save = main_group:button('Save', function() end),
    delete = main_group:button('Delete', function() end),
    import = main_group:button('Import from clipboard', function() end),
    export = main_group:button('Export to clipboard', function() end),
}
}

local info_tab = {menu.main.current_tab, 1}
local social_tab = {menu.main.current_tab, 2}
local cfg_tab = {menu.main.current_tab, 3}
local ragebot_tab = {menu.main.current_tab, 4}
local aimtools_tab = {menu.main.current_tab, 5}
local predict_tab = {menu.main.current_tab, 6}
local aa_tab = {menu.main.current_tab, 7}
local builder_tab = {menu.main.current_tab, 8}
local defensive_tab = {menu.main.current_tab, 9}
local other_tab = {menu.main.current_tab, 10}
local hotkeys_tab = {menu.main.current_tab, 11}
local vis_tab = {menu.main.current_tab, 13}
local misc_tab = {menu.main.current_tab, 14}

menu.information.user:depend(info_tab)
menu.information.last_update:depend(info_tab)
menu.information.information_user:depend(info_tab)
menu.information.information_user_poloska:depend(info_tab)
menu.information.session:depend(info_tab)
menu.information.killed:depend(info_tab)
menu.social_links.social_text:depend(social_tab)
menu.social_links.social_poloska:depend(social_tab)
menu.social_links.links:depend(social_tab)
menu.social_links.youtube:depend({menu.social_links.links, 1}, social_tab)
menu.social_links.discord:depend({menu.social_links.links, 2}, social_tab)
menu.social_links.neverlose:depend({menu.social_links.links, 3}, social_tab)
menu.configs.config_poloska1:depend(cfg_tab)
menu.configs.config_poloska:depend(cfg_tab)
menu.configs.listtt:depend(cfg_tab)
menu.configs.name:depend(cfg_tab)
menu.configs.create:depend(cfg_tab)
menu.configs.save:depend(cfg_tab)
menu.configs.load:depend(cfg_tab)
menu.configs.delete:depend(cfg_tab)
menu.configs.import:depend(cfg_tab)
menu.configs.export:depend(cfg_tab)

menu.ragebot.ragebot_text:depend(ragebot_tab)
menu.ragebot.ragebot_poloska:depend(ragebot_tab)

menu.aimtools.aimtools_text:depend(aimtools_tab)
menu.aimtools.aimtools_poloska:depend(aimtools_tab)
menu.aimtools.aim_punch_fix:depend(aimtools_tab)
menu.aimtools.spacing_1:depend(aimtools_tab)
menu.aimtools.aimbot_helper_text:depend(aimtools_tab)
menu.aimtools.aimbot_helper_poloska:depend(aimtools_tab)
menu.aimtools.aimbot_helper:depend(aimtools_tab)
menu.aimtools.weapon_select:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true})

-- SSG-08 depends
menu.aimtools.ssg_select:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'})
menu.aimtools.ssg_safe_triggers:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Force Safe Point'})
menu.aimtools.ssg_safe_hp:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Force Safe Point'}, {menu.aimtools.ssg_safe_triggers, 'Enemy HP < X'})
menu.aimtools.ssg_safe_miss:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Force Safe Point'}, {menu.aimtools.ssg_safe_triggers, 'X Missed Shots'})
menu.aimtools.ssg_prefer_triggers:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Prefer Body Aim'})
menu.aimtools.ssg_prefer_hp:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Prefer Body Aim'}, {menu.aimtools.ssg_prefer_triggers, 'Enemy HP < X'})
menu.aimtools.ssg_prefer_miss:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Prefer Body Aim'}, {menu.aimtools.ssg_prefer_triggers, 'X Missed Shots'})
menu.aimtools.ssg_force_triggers:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Force Body Aim'})
menu.aimtools.ssg_force_hp:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Force Body Aim'}, {menu.aimtools.ssg_force_triggers, 'Enemy HP < X'})
menu.aimtools.ssg_force_miss:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Force Body Aim'}, {menu.aimtools.ssg_force_triggers, 'X Missed Shots'})
menu.aimtools.ssg_ping_spike:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'SSG-08'}, {menu.aimtools.ssg_select, 'Ping Spike'})

-- AWP depends
menu.aimtools.awp_select:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'})
menu.aimtools.awp_safe_triggers:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Force Safe Point'})
menu.aimtools.awp_safe_hp:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Force Safe Point'}, {menu.aimtools.awp_safe_triggers, 'Enemy HP < X'})
menu.aimtools.awp_safe_miss:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Force Safe Point'}, {menu.aimtools.awp_safe_triggers, 'X Missed Shots'})
menu.aimtools.awp_prefer_triggers:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Prefer Body Aim'})
menu.aimtools.awp_prefer_hp:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Prefer Body Aim'}, {menu.aimtools.awp_prefer_triggers, 'Enemy HP < X'})
menu.aimtools.awp_prefer_miss:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Prefer Body Aim'}, {menu.aimtools.awp_prefer_triggers, 'X Missed Shots'})
menu.aimtools.awp_force_triggers:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Force Body Aim'})
menu.aimtools.awp_force_hp:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Force Body Aim'}, {menu.aimtools.awp_force_triggers, 'Enemy HP < X'})
menu.aimtools.awp_force_miss:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Force Body Aim'}, {menu.aimtools.awp_force_triggers, 'X Missed Shots'})
menu.aimtools.awp_ping_spike:depend(aimtools_tab, {menu.aimtools.aimbot_helper, true}, {menu.aimtools.weapon_select, 'AWP'}, {menu.aimtools.awp_select, 'Ping Spike'})

menu.predict.predict_text:depend(predict_tab)
menu.predict.predict_poloska:depend(predict_tab)
menu.predict.spacing_1:depend(predict_tab)
menu.predict.predict_enemies:depend(predict_tab)
menu.predict.predict_mode:depend(predict_tab, {menu.predict.predict_enemies, true})
menu.predict.predict_mode_type:depend(predict_tab, {menu.predict.predict_enemies, true})
menu.predict.menus_on_point:depend(predict_tab, {menu.predict.predict_enemies, true}, {menu.predict.predict_mode_type, "Menu's Point"})
menu.predict.travel_bt_memories:depend(predict_tab, {menu.predict.predict_enemies, true}, {menu.predict.predict_mode_type, 'Travel Through BT'})
menu.predict.backtrack_hitboxes:depend(predict_tab, {menu.predict.predict_enemies, true}, {menu.predict.predict_mode_type, 'Travel Through BT'}, {menu.predict.travel_bt_memories, true})
menu.predict.backtrack_attach:depend(predict_tab, {menu.predict.predict_enemies, true}, {menu.predict.predict_mode_type, 'Travel Through BT'}, {menu.predict.travel_bt_memories, true})

menu.antiaim.builder_text:depend(builder_tab)
menu.antiaim.builder_poloska:depend(builder_tab)
menu.antiaim.antiaim_select:depend(builder_tab)
menu.defensive.defensive_text:depend(defensive_tab)
menu.defensive.defensive_poloska:depend(defensive_tab)
menu.defensive.defensive_select:depend(defensive_tab)
menu.hotkeys.hotkeys_text:depend(hotkeys_tab)
menu.hotkeys.xyi2:depend(hotkeys_tab)
menu.hotkeys.freestanding_yaw:depend(hotkeys_tab)
menu.hotkeys.manual_forward:depend(hotkeys_tab)
menu.hotkeys.manual_left:depend(hotkeys_tab)
menu.hotkeys.manual_right:depend(hotkeys_tab)
menu.hotkeys.poloska1:depend(hotkeys_tab)
menu.visuals.aimbot_logger:depend(vis_tab)
menu.visuals.visuals_text:depend(vis_tab)
menu.visuals.xyi3:depend(vis_tab)
menu.visuals.console_filter:depend(vis_tab)
menu.visuals.watermark_color:depend(vis_tab)
menu.visuals.aimbot_logger:depend(vis_tab)
menu.visuals.main_colors:depend(vis_tab, {menu.visuals.aimbot_logger, true}, {menu.visuals.aimbot_logger_type, "Console"})
menu.visuals.ragebot_miss:depend(vis_tab, {menu.visuals.aimbot_logger, true}, {menu.visuals.aimbot_logger_type, "Console"})
menu.visuals.ragebot_label1:depend(vis_tab, {menu.visuals.aimbot_logger, true}, {menu.visuals.aimbot_logger_type, "Console"})
menu.visuals.ragebot_label2:depend(vis_tab, {menu.visuals.aimbot_logger, true}, {menu.visuals.aimbot_logger_type, "Console"})
menu.visuals.aimbot_logger_type:depend(vis_tab, {menu.visuals.aimbot_logger, true})
menu.visuals.aimbot_logger_prefix:depend(vis_tab, {menu.visuals.aimbot_logger, true})
menu.visuals.aimbot_logger_prefix1:depend(vis_tab, {menu.visuals.aimbot_logger, true}, {menu.visuals.aimbot_logger_prefix, "Custom"})
menu.visuals.bullet_line:depend(vis_tab)
menu.visuals.bullet_line_color:depend(vis_tab, {menu.visuals.bullet_line, true})
menu.visuals.watermark_mode:depend(vis_tab)
menu.visuals.watermark_text:depend(vis_tab, {menu.visuals.watermark_mode, "Custom"})
menu.visuals.watermark_prefix:depend(vis_tab, {menu.visuals.watermark_mode, "Custom"})
menu.visuals.watermark_font:depend(vis_tab, {menu.visuals.watermark_mode, "Custom"})
menu.visuals.watermark_gradient:depend(vis_tab, {menu.visuals.watermark_mode, "Custom"})
menu.visuals.watermark_position:depend(vis_tab, {menu.visuals.watermark_mode, "Custom"})
menu.visuals.animated_zoom:depend(vis_tab)
menu.visuals.animated_fov:depend(vis_tab, {menu.visuals.animated_zoom, true})
menu.visuals.aspectratio:depend(vis_tab)
menu.visuals.aspectratio_value:depend({menu.visuals.aspectratio, true}, vis_tab)
menu.visuals.velocity_indicator:depend(vis_tab)
menu.visuals.velocity_color:depend({menu.visuals.velocity_indicator, true}, vis_tab)
menu.visuals.custom_scope:depend(vis_tab)
menu.visuals.custom_scope_color_picker:depend({menu.visuals.custom_scope, true}, vis_tab)
menu.visuals.custom_scope_overlay_offset:depend({menu.visuals.custom_scope, true}, vis_tab)
menu.visuals.custom_scope_overlay_position:depend({menu.visuals.custom_scope, true},  vis_tab)
menu.visuals.damage_indicator:depend(vis_tab)
menu.visuals.damage_indicator_select:depend({menu.visuals.damage_indicator, true}, vis_tab)
menu.visuals.cross_indicator:depend(vis_tab)
menu.visuals.cross_indicator_color:depend(vis_tab, {menu.visuals.cross_indicator, true})
menu.visuals.manual_arrows:depend(vis_tab)
menu.visuals.manual_arrows_color:depend(vis_tab, {menu.visuals.manual_arrows, true})
menu.visuals.manual_arrows_style:depend(vis_tab, {menu.visuals.manual_arrows, true})
menu.visuals.manual_arrows_tweaks:depend(vis_tab, {menu.visuals.manual_arrows, true})
menu.other.anim_breaker:depend(other_tab)
menu.other.anim_breaker_ground:depend({menu.other.anim_breaker, true}, other_tab)
menu.other.anim_breaker_air:depend({menu.other.anim_breaker, true}, other_tab)
menu.other.anim_breaker_other:depend({menu.other.anim_breaker, true}, other_tab)
menu.other.anim_breaker_air_amount:depend({menu.other.anim_breaker, true},{menu.other.anim_breaker_air, 'Static'}, other_tab)
menu.other.anim_breaker_jitter_first:depend({menu.other.anim_breaker, true},{menu.other.anim_breaker_ground, 'Jitter'}, other_tab)
menu.other.anim_breaker_jitter_second:depend({menu.other.anim_breaker, true},{menu.other.anim_breaker_ground, 'Jitter'}, other_tab)
menu.other.anim_breaker_random_amount:depend({menu.other.anim_breaker, true},{menu.other.anim_breaker_ground, 'Random'}, other_tab)
menu.other.aa_disablers:depend(other_tab)
menu.other.aa_disabler_mode:depend(other_tab, {menu.other.aa_disablers, true})
menu.other.aa_disabler_speed:depend(other_tab, {menu.other.aa_disabler_mode, "On Warmup", "No Enemies"}, {menu.other.aa_disablers, true})
menu.other.features_text:depend(other_tab)
menu.other.xyi4:depend(other_tab)
menu.other.safe_head:depend(other_tab)
menu.other.safe_head_select:depend(other_tab, {menu.other.safe_head, true})
menu.other.avoid_backstab:depend(other_tab)
menu.other.avoid_backstab_amount:depend(other_tab, {menu.other.avoid_backstab, true})
menu.other.anti_bruteforce:depend(other_tab)
menu.misc.misc_text:depend(misc_tab)
menu.misc.xyi5:depend(misc_tab)
menu.misc.ideal_tick:depend(misc_tab)
menu.misc.unsafe_recharge:depend(misc_tab)
menu.misc.fast_ladder:depend(misc_tab)
menu.misc.killsay:depend(misc_tab)
menu.misc.killsay_mode:depend({menu.misc.killsay, true}, misc_tab)
menu.misc.killsay_select:depend({menu.misc.killsay, true}, misc_tab)
menu.misc.hideshots_fix:depend(misc_tab)
menu.misc.clantag:depend(misc_tab)
menu.misc.fakelag_exploit:depend(misc_tab)
menu.misc.fakelag_exploit1:depend(misc_tab, {menu.misc.fakelag_exploit, true})
menu.misc.fakelag_exploit2:depend(misc_tab, {menu.misc.fakelag_exploit, true})


helpers = {
    rgba_to_hex = function(redArg, greenArg, blueArg, alphaArg)
        return string.format('%.2x%.2x%.2x%.2x', redArg, greenArg, blueArg, alphaArg)
    end,

    create_color_array = function(r, g, b, str)
        local colors = {}
        for i = 0, #str do
            local alpha = 255 * math.abs(math.cos(1.6 * math.pi * globals.curtime() / 2.5 + i * 4 / 30))
            table.insert(colors, {r, g, b, alpha})
        end
        return colors
    end,

    math = {
        clamp = function(x, a, b)
            if a > x then return a
            elseif b < x then return b
            else return x end
        end,

        lerping = function(a, b, w)
            return a + (b - a) * w
        end,

        lerp = function(start, enp, time)
            time = time or 0.005
            time = helpers.math.clamp(globals.absoluteframetime() * time * 175.0, 0.01, 1.0)
            local a = helpers.math.lerping(start, enp, time)
            if enp == 0.0 and a < 0.02 and a > -0.02 then
                a = 0.0
            elseif enp == 1.0 and a < 1.01 and a > 0.99 then
                a = 1.0
            end
            return a
        end,

       speed = function(name, value, speed)
        return name + (value - name) * globals.absoluteframetime() * speed
    end,
    },

    update_session = function(self)
        local seconds_ses = math.floor(globals.realtime())
        local hours_ses = math.floor(globals.realtime() / 3600)
        local minutes_ses = math.floor(globals.realtime() / 60)
        local text = ""

        if seconds_ses == 1 and hours_ses < 1 and minutes_ses < 1 then
            text = seconds_ses.." Second"
        elseif seconds_ses >= 2 and hours_ses < 1 and minutes_ses < 1 then
            text = seconds_ses.." Seconds"
        elseif minutes_ses == 1 and hours_ses < 1 then
            text = minutes_ses.." Minute"
        elseif minutes_ses >= 2 and hours_ses < 1 then
            text = minutes_ses.." Minutes"
        elseif hours_ses == 1 then
            text = hours_ses.." Hour"
        elseif hours_ses >= 2 then
            text = hours_ses.." Hours"
        end

        menu.information.session:set('\v\rSession • \v'..text)
    end,
}


local builder = {}
for i=1, #aa_config do
    builder[i] = {
   state = main_group:checkbox('Override ' .. aa_config[i]),
   yaw_label = main_group:label("\n"),
   yaw_text = main_group:label("\v•\r Yaw"),
   yaw_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
   yaw_type = main_group:slider('Yaw \v~\r Type [' .. aa_config[i] .. ']', 1, 3, 1, true, "", 1, {[1] = "L&R", [2] = "L&R Delay", [3] = "L&R Phase"}),
   delay_type = main_group:slider("Delay \v~\r Type [" .. aa_config[i] .. "]", 1, 5, 1, true, '',1, {[1] = "Disabled", [2] = "Default", [3] = "Min/Max", [4] = "New", [5] = "Chance"}),
   yaw_left = main_group:slider('Yaw \v~\r Left [' .. aa_config[i] .. ']', -180, 180, 0, true, '°', 1),
   yaw_right = main_group:slider('Yaw \v~\r Right [' .. aa_config[i] .. ']', -180, 180, 0, true, '°', 1),
   yaw_random = main_group:slider('Randomize \v~\r Yaw [' .. aa_config[i] .. ']', 0, 100, 0, true, '%', 1),
   yaw_delay_tickrate = main_group:label("Soon.."),
   yaw_delay_default = main_group:slider("Delay \v~\r Ticks [" .. aa_config[i] .. "]", 1, 10, 4, true, 't', 1),
   yaw_delay_min = main_group:slider("Min \v~\r Ticks [" .. aa_config[i] .. "]", 1, 50, 1, true, "t", 1),
   yaw_delay_max = main_group:slider("Max \v~\r Ticks [" .. aa_config[i] .. "]", 1, 50, 1, true, "t", 1),
   yaw_delay_new_1 = main_group:slider("New \v~\r 1 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_2 = main_group:slider("New \v~\r 2 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_3 = main_group:slider("New \v~\r 3 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_4 = main_group:slider("New \v~\r 4 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_5 = main_group:slider("New \v~\r 5 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_6 = main_group:slider("New \v~\r 6 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_7 = main_group:slider("New \v~\r 7 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_8 = main_group:slider("New \v~\r 8 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_9 = main_group:slider("New \v~\r 9 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   yaw_delay_new_10 = main_group:slider("New \v~\r 10 [" .. aa_config[i] .. "]", 1, 32, 1, true, "t", 1),
   switch_chance = main_group:slider("Switch \v~\r Chance [" .. aa_config[i] .. "}", 1, 100, 1, true, "%", 1),
   jitter_label = main_group:label("\n"),
   jitter_text = main_group:label("\v•\r Jitter"),
   jitter_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
   modifier_type = main_group:combobox('Modifier \v~\r Type [' .. aa_config[i] .. ']', 'Off', 'Center', 'Offset', 'Random', 'Skitter', "5-Way", "UKRAINA", "Relentless", "Maksim"),
   modifier_type_method = main_group:slider('Modifier \v~\r Method [' .. aa_config[i] .. ']', 1, 2, 1, true, '',1, {[1] = "Default", [2] = "Switch"}),
   modifier_type_method_left = main_group:slider('Modifier \v~\r Left [' .. aa_config[i] .. ']', -180, 180, 0, true, '°', 1),
   modifier_type_method_right = main_group:slider('Modifier \v~\r Right [' .. aa_config[i] .. ']', -180, 180, 0, true, '°', 1),
   modifier_type_offset = main_group:slider('Modifier \v~\r Offset [' .. aa_config[i] .. ']', -180, 180, 0, true, '°'),
   modifier_type_randomize = main_group:slider('Modifier \v~\r Randomize [' .. aa_config[i] .. ']', -180, 180, 0, true, '°'),
   flicker = main_group:slider("Hidden \v~\r Flick [" .. aa_config[i] .. "]", 1, 2, 1, true, '',1, {[1] = "Disabled", [2] = "Enabled"}),
   flick1 = main_group:slider("First \v~\r Flick [" .. aa_config[i] .. "]", -60, 60, 0),
   flick2 = main_group:slider("Second \v~\r Flick [" .. aa_config[i] .. "]", -60, 60, 0),
   flick3 = main_group:slider("Third \v~\r Flick [" .. aa_config[i] .. "]", -60, 60, 0),
   maksim_amount = main_group:slider("Makson \v~\r Amount [" .. aa_config[i] .. "]", -90, 90, 45, true, "", 1, {[45] = "Default"}),
   maksim_random = main_group:slider("Makson \v~\r Randomize [" .. aa_config[i] .. "]", -50, 50, 35, true, "", 1, {[35] = "Default"}),
   maksim_wave = main_group:slider("Makson \v~\r Wave&Amount [" .. aa_config[i] .. "]", -50, 50, 15, true, "", 1, {[15] = "Default"}),
   relentless_random = main_group:slider("Relentless \v~\r Randomize [" .. aa_config[i] .. "]", -50, 50, 35, true, "", 1, {[35] = "Default"}),
   relentless_wave = main_group:slider("Relentless \v~\r Wave&Amount [" .. aa_config[i] .. "]", -50, 50, 15, true, "", 1, {[15] = "Default"}),
   ukraina_amount = main_group:slider("Ukraina \v~\r Amount [" .. aa_config[i] .. "]", -90, 90, 45, true, "", 1, {[45] = "Default"}),
   ways5_method = main_group:combobox('5-Way \v~\r Method [' .. aa_config[i] .. ']', 'Center', 'Offset', 'Random', 'Skitter', "Randomize"),
   way1 = main_group:slider("1-Way", -180, 180, 1, true, '°', 1),
   way2 = main_group:slider("2-Way", -180, 180, 1, true, '°', 1),
   way3 = main_group:slider("3-Way", -180, 180, 1, true, '°', 1),
   way4 = main_group:slider("4-Way", -180, 180, 1, true, '°', 1),
   way5 = main_group:slider("5-Way", -180, 180, 1, true, '°', 1),
   desync_label = main_group:label("\n"),
   desync_text = main_group:label("\v•\r Desync"),
   desync_poloska = main_group:label("\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"),
   body_yaw = main_group:combobox('Body Yaw \v~\r Yaw [' .. aa_config[i] .. ']', 'Off', 'Static', 'Jitter', "Min/Max"),
   body_amount = main_group:slider('Body Yaw \v~\r Amount [' .. aa_config[i] .. ']', -60, 60, 0, true, '°'),
   body_amount_first = main_group:slider('Body Yaw \v~\r First [' .. aa_config[i] .. ']', -180, 180, 0, true, '°'),
   body_amount_second = main_group:slider('Body Yaw \v~\r Second [' .. aa_config[i] .. ']', -180, 180, 0, true, '°'),
   force_lc = main_group:checkbox("Force \v~\r LC [" .. aa_config[i] .. "]"),


    }
end

for i = 1, #aa_config do
    local active = {menu.antiaim.antiaim_select, aa_config[i]}
    local enabled = {builder[i].state, true}
    builder[i].state:depend(active, builder_tab)
    builder[i].yaw_type:depend(enabled, active, builder_tab)
    builder[i].yaw_text:depend(enabled, active, builder_tab)
    builder[i].yaw_poloska:depend(enabled, active, builder_tab)
    builder[i].jitter_text:depend(enabled, active, builder_tab)
    builder[i].jitter_poloska:depend(enabled, active, builder_tab)
    builder[i].desync_text:depend(enabled, active, builder_tab)
    builder[i].desync_poloska:depend(enabled, active, builder_tab)  
    builder[i].yaw_label:depend(enabled, active, builder_tab)  
    builder[i].jitter_label:depend(enabled, active, builder_tab)  
    builder[i].desync_label:depend(enabled, active, builder_tab)  
    builder[i].delay_type:depend(enabled, active, builder_tab, {builder[i].yaw_type, 2})
    --builder[i].yaw_delay_random1:depend({builder[i].body_yaw_delay, 'Min/Max'}, {builder[i].body_yaw, 'Tick'}, enabled, active, builder_tab, aa_tab)
    --builder[i].yaw_delay_random2:depend({builder[i].body_yaw_delay, 'Min/Max'}, {builder[i].body_yaw, 'Tick'}, enabled, active, builder_tab, aa_tab)
    builder[i].yaw_left:depend({builder[i].yaw_type, 1, 2}, enabled, active, builder_tab)
    builder[i].yaw_right:depend({builder[i].yaw_type, 1, 2},  enabled, active, builder_tab)
    builder[i].yaw_random:depend(enabled, active, builder_tab, {builder[i].yaw_type, 1, 2})
    --делеи

    builder[i].yaw_delay_tickrate:depend({builder[i].yaw_type, 3}, enabled, active, builder_tab)
    builder[i].yaw_delay_default:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 2}, enabled, active, builder_tab)
    builder[i].yaw_delay_min:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 3}, enabled, active, builder_tab)
    builder[i].yaw_delay_max:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 3}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_1:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_2:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_3:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_4:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_5:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_6:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_7:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_8:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_9:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].yaw_delay_new_10:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 4}, enabled, active, builder_tab)
    builder[i].switch_chance:depend({builder[i].yaw_type, 2}, {builder[i].delay_type, 5}, enabled, active, builder_tab)

    -- конец делеев

    builder[i].modifier_type:depend(enabled, active, builder_tab)
    builder[i].modifier_type_offset:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].flicker, 1}, {builder[i].modifier_type_method, 1}, active, enabled, builder_tab)
    builder[i].modifier_type_randomize:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].flicker, 1}, {builder[i].modifier_type_method, 1}, active, enabled, builder_tab)
    builder[i].modifier_type_method:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].flicker, 1}, active, enabled, builder_tab)
    builder[i].modifier_type_method_left:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].modifier_type_method, 2}, {builder[i].flicker, 1}, active, enabled, builder_tab)
    builder[i].modifier_type_method_right:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].modifier_type_method, 2}, {builder[i].flicker, 1}, active, enabled, builder_tab)
    builder[i].flicker:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].modifier_type_method, 1}, active, enabled, builder_tab)
    builder[i].flick1:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].flicker, 2}, active, enabled, builder_tab)
    builder[i].flick2:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].flicker, 2}, active, enabled, builder_tab)
    builder[i].flick3:depend({builder[i].modifier_type, 'Center', 'Offset', 'Skitter', 'Random'}, {builder[i].flicker, 2}, active, enabled, builder_tab)
    builder[i].maksim_amount:depend({builder[i].modifier_type, 'Maksim'}, active, enabled, builder_tab)
    builder[i].maksim_wave:depend({builder[i].modifier_type, 'Maksim'}, active, enabled, builder_tab)
    builder[i].maksim_random:depend({builder[i].modifier_type, 'Maksim'}, active, enabled, builder_tab)
    builder[i].relentless_wave:depend({builder[i].modifier_type, 'Relentless'}, active, enabled, builder_tab)
    builder[i].relentless_random:depend({builder[i].modifier_type, 'Relentless'}, active, enabled, builder_tab)
    builder[i].ukraina_amount:depend({builder[i].modifier_type, 'UKRAINA'}, active, enabled, builder_tab)
    builder[i].ways5_method:depend({builder[i].modifier_type, '5-Way'}, active, enabled, builder_tab)
    builder[i].way1:depend({builder[i].modifier_type, '5-Way'}, active, enabled, builder_tab)
    builder[i].way2:depend({builder[i].modifier_type, '5-Way'}, active, enabled, builder_tab)
    builder[i].way3:depend({builder[i].modifier_type, '5-Way'}, active, enabled, builder_tab)
    builder[i].way4:depend({builder[i].modifier_type, '5-Way'}, active, enabled, builder_tab)
    builder[i].way5:depend({builder[i].modifier_type, '5-Way'}, active, enabled, builder_tab)
    builder[i].body_yaw:depend(enabled, active, builder_tab)
    builder[i].force_lc:depend(enabled, active, builder_tab)
    builder[i].body_amount:depend({builder[i].body_yaw, 'Jitter', 'Opposite', 'Static'}, enabled, active, builder_tab)
    builder[i].body_amount_first:depend({builder[i].body_yaw, 'Min/Max'}, enabled, active, builder_tab)
    builder[i].body_amount_second:depend({builder[i].body_yaw, 'Min/Max'}, enabled, active, builder_tab)
end



local defensive = {}
for i=1, #aa_config do
    defensive[i] = {
        state = main_group:checkbox('Override ' .. aa_config[i]),
        
        defensive_on = main_group:multiselect('Defensive \v~\r Work on [' .. aa_config[i] .. ']', 'Double tap', 'Hide shots'),
        defensive_mode = main_group:combobox('Defensive \v~\r Mode [' .. aa_config[i] .. ']', 'On peek', 'Always on'),
        
        spacing_1 = main_group:label('\n'),
        yaw_label = main_group:label('\v•\r Defensive Yaw'),
        yaw_poloska = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        yaw_mode = main_group:combobox('Yaw \v~\r Mode [' .. aa_config[i] .. ']', 'Off', '180', 'Spin', 'Sway', 'Distortion', 'Sideways', 'Random', 'Jitter', '3-Way', '5-Way'),
        yaw_speed = main_group:slider('Yaw \v~\r Speed [' .. aa_config[i] .. ']', 1, 20, 4, true, 't'),
        yaw_offset = main_group:slider('Yaw \v~\r Offset [' .. aa_config[i] .. ']', -180, 180, 0, true, '°'),
        yaw_left = main_group:slider('Yaw \v~\r Left [' .. aa_config[i] .. ']', -180, 180, -45, true, '°'),
        yaw_right = main_group:slider('Yaw \v~\r Right [' .. aa_config[i] .. ']', -180, 180, 45, true, '°'),
        
        spacing_2 = main_group:label('\n'),
        pitch_label = main_group:label('\v•\r Defensive Pitch'),
        pitch_poloska = main_group:label('\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'),
        pitch_mode = main_group:combobox('Pitch \v~\r Mode [' .. aa_config[i] .. ']', 'Off', 'Up', 'Down', 'Zero', 'Random', 'Spin', 'Sway', 'Jitter', 'Custom'),
        pitch_speed = main_group:slider('Pitch \v~\r Speed [' .. aa_config[i] .. ']', 1, 20, 2, true, 't'),
        pitch_value = main_group:slider('Pitch \v~\r Value [' .. aa_config[i] .. ']', -89, 89, 0, true, '°'),
        pitch_min = main_group:slider('Pitch \v~\r Min [' .. aa_config[i] .. ']', -89, 89, -45, true, '°'),
        pitch_max = main_group:slider('Pitch \v~\r Max [' .. aa_config[i] .. ']', -89, 89, 45, true, '°'),
    }
end

for i = 1, #aa_config do
    local active = {menu.defensive.defensive_select, aa_config[i]}
    local enabled = {defensive[i].state, true}
    
    defensive[i].state:depend(active, defensive_tab)
    defensive[i].defensive_on:depend(enabled, active, defensive_tab)
    defensive[i].defensive_mode:depend(enabled, active, defensive_tab)
    
    defensive[i].spacing_1:depend(enabled, active, defensive_tab)
    defensive[i].yaw_label:depend(enabled, active, defensive_tab)
    defensive[i].yaw_poloska:depend(enabled, active, defensive_tab)
    defensive[i].yaw_mode:depend(enabled, active, defensive_tab)
    defensive[i].yaw_speed:depend(enabled, active, defensive_tab, {defensive[i].yaw_mode, 'Off', true}, {defensive[i].yaw_mode, '180', true}, {defensive[i].yaw_mode, 'Random', true})
    defensive[i].yaw_offset:depend(enabled, active, defensive_tab, {defensive[i].yaw_mode, 'Off', true}, {defensive[i].yaw_mode, 'Jitter', true}, {defensive[i].yaw_mode, '3-Way', true}, {defensive[i].yaw_mode, '5-Way', true})
    defensive[i].yaw_left:depend(enabled, active, defensive_tab, {defensive[i].yaw_mode, 'Jitter'})
    defensive[i].yaw_right:depend(enabled, active, defensive_tab, {defensive[i].yaw_mode, 'Jitter'})
    
    defensive[i].spacing_2:depend(enabled, active, defensive_tab)
    defensive[i].pitch_label:depend(enabled, active, defensive_tab)
    defensive[i].pitch_poloska:depend(enabled, active, defensive_tab)
    defensive[i].pitch_mode:depend(enabled, active, defensive_tab)
    defensive[i].pitch_speed:depend(enabled, active, defensive_tab, {defensive[i].pitch_mode, 'Off', true}, {defensive[i].pitch_mode, 'Up', true}, {defensive[i].pitch_mode, 'Down', true}, {defensive[i].pitch_mode, 'Zero', true}, {defensive[i].pitch_mode, 'Random', true}, {defensive[i].pitch_mode, 'Custom', true})
    defensive[i].pitch_value:depend(enabled, active, defensive_tab, {defensive[i].pitch_mode, 'Custom'})
    defensive[i].pitch_min:depend(enabled, active, defensive_tab, {defensive[i].pitch_mode, 'Jitter'})
    defensive[i].pitch_max:depend(enabled, active, defensive_tab, {defensive[i].pitch_mode, 'Jitter'})
end

-- Aimtools: Aim Punch Miss Fix
local aim_punch_fix = { last_health = 100, override_active = false }
client.set_event_callback('setup_command', function()
    if not menu.aimtools.aim_punch_fix:get() then
        return
    end
    
    local me = entity.get_local_player()
    if not me or not entity.is_alive(me) then
        aim_punch_fix.last_health = 100
        if aim_punch_fix.override_active then
            ui.set(ref.mindamage, ui.get(ref.mindamage))
            aim_punch_fix.override_active = false
        end
        return
    end
    
    local current_health = entity.get_prop(me, 'm_iHealth') or 100
    
    if current_health < aim_punch_fix.last_health then
        -- Player took damage, increase hitchance to 100%
        aim_punch_fix.override_active = true
    elseif aim_punch_fix.override_active then
        aim_punch_fix.override_active = false
    end
    
    aim_punch_fix.last_health = current_health
end)

-- Aimbot Helper: Track missed shots per player
local aimbot_helper = {
    missed_shots = {}
}

-- Reset missed shots on round start
client.set_event_callback('round_start', function()
    aimbot_helper.missed_shots = {}
end)

-- Track missed shots
client.set_event_callback('aim_miss', function(e)
    if not menu.aimtools.aimbot_helper:get() then return end
    
    local target = e.target
    if not target then return end
    
    aimbot_helper.missed_shots[target] = (aimbot_helper.missed_shots[target] or 0) + 1
end)

-- Apply aimbot helper settings on aim_fire
client.set_event_callback('aim_fire', function(e)
    if not menu.aimtools.aimbot_helper:get() then return end
    
    local me = entity.get_local_player()
    if not me or not entity.is_alive(me) then return end
    
    local weapon = entity.get_player_weapon(me)
    if not weapon then return end
    
    local weapon_name = entity.get_classname(weapon)
    local target = e.target
    if not target then return end
    
    -- Determine weapon type
    local is_ssg = weapon_name == 'CWeaponSSG08'
    local is_awp = weapon_name == 'CWeaponAWP'
    local is_auto = weapon_name == 'CWeaponSCAR20' or weapon_name == 'CWeaponG3SG1'
    
    local weapon_mode = menu.aimtools.weapon_select:get()
    
    -- Only apply for selected weapon
    if (weapon_mode == 'SSG-08' and not is_ssg) or 
       (weapon_mode == 'AWP' and not is_awp) or
       (weapon_mode == 'Auto Snipers' and not is_auto) then
        return
    end
    
    -- Get settings based on weapon
    local settings = {}
    if is_ssg and weapon_mode == 'SSG-08' then
        settings = {
            options = menu.aimtools.ssg_select:get(),
            safe_triggers = menu.aimtools.ssg_safe_triggers:get(),
            safe_hp = menu.aimtools.ssg_safe_hp:get(),
            safe_miss = menu.aimtools.ssg_safe_miss:get(),
            prefer_triggers = menu.aimtools.ssg_prefer_triggers:get(),
            prefer_hp = menu.aimtools.ssg_prefer_hp:get(),
            prefer_miss = menu.aimtools.ssg_prefer_miss:get(),
            force_triggers = menu.aimtools.ssg_force_triggers:get(),
            force_hp = menu.aimtools.ssg_force_hp:get(),
            force_miss = menu.aimtools.ssg_force_miss:get(),
            ping_spike = menu.aimtools.ssg_ping_spike:get()
        }
    elseif is_awp and weapon_mode == 'AWP' then
        settings = {
            options = menu.aimtools.awp_select:get(),
            safe_triggers = menu.aimtools.awp_safe_triggers:get(),
            safe_hp = menu.aimtools.awp_safe_hp:get(),
            safe_miss = menu.aimtools.awp_safe_miss:get(),
            prefer_triggers = menu.aimtools.awp_prefer_triggers:get(),
            prefer_hp = menu.aimtools.awp_prefer_hp:get(),
            prefer_miss = menu.aimtools.awp_prefer_miss:get(),
            force_triggers = menu.aimtools.awp_force_triggers:get(),
            force_hp = menu.aimtools.awp_force_hp:get(),
            force_miss = menu.aimtools.awp_force_miss:get(),
            ping_spike = menu.aimtools.awp_ping_spike:get()
        }
    else
        return
    end
    
    -- Get target info
    local target_hp = entity.get_prop(target, 'm_iHealth') or 100
    local missed_count = aimbot_helper.missed_shots[target] or 0
    
    -- Get player positions for height advantage check
    local me_origin = vector(entity.get_origin(me))
    local target_origin = vector(entity.get_origin(target))
    local height_advantage = me_origin.z > target_origin.z + 50
    
    -- Check if shot is lethal (can kill with one shot)
    local is_lethal = target_hp <= e.damage
    
    -- Helper function to check if trigger conditions are met
    local function check_triggers(triggers, hp_threshold, miss_threshold)
        local hp_check = triggers['Enemy HP < X'] and target_hp < hp_threshold
        local miss_check = triggers['X Missed Shots'] and missed_count >= miss_threshold
        local lethal_check = triggers['Lethal'] and is_lethal
        local height_check = triggers['Height Advantage'] and height_advantage
        
        return hp_check or miss_check or lethal_check or height_check
    end
    
    -- Apply Force Safe Point
    if settings.options['Force Safe Point'] then
        if check_triggers(settings.safe_triggers, settings.safe_hp, settings.safe_miss) then
            ui.set(ref.force_safe_point, true)
        end
    end
    
    -- Apply Prefer Body Aim
    if settings.options['Prefer Body Aim'] then
        if check_triggers(settings.prefer_triggers, settings.prefer_hp, settings.prefer_miss) then
            ui.set(ref.prefer_body_aim, true)
        end
    end
    
    -- Apply Force Body Aim
    if settings.options['Force Body Aim'] then
        if check_triggers(settings.force_triggers, settings.force_hp, settings.force_miss) then
            ui.set(ref.forcebaim, true)
        end
    end
    
    -- Apply Ping Spike
    if settings.options['Ping Spike'] then
        ui.set(ref.ping_spike[3], settings.ping_spike)
    end
end)

-- Predict System
local predict_system = {
    player_data = {}
}

-- Predict enemy position
local function predict_enemy_position(player, ticks)
    if not menu.predict.predict_enemies:get() then return nil end
    if not player or not entity.is_alive(player) then return nil end
    
    -- Get current position
    local x, y, z = entity.get_origin(player)
    if not x then return nil end
    
    -- Get velocity
    local vx = entity.get_prop(player, "m_vecVelocity[0]") or 0
    local vy = entity.get_prop(player, "m_vecVelocity[1]") or 0
    local vz = entity.get_prop(player, "m_vecVelocity[2]") or 0
    
    -- Prediction multiplier based on mode
    local mode = menu.predict.predict_mode:get()
    local multiplier = 1.0
    if mode == 0 then -- Wingman
        multiplier = 0.8
    elseif mode == 1 then -- Competitive
        multiplier = 1.0
    elseif mode == 2 then -- Funeral
        multiplier = 1.3
    end
    
    local tick_interval = globals.tickinterval()
    local time = ticks * tick_interval * multiplier
    
    -- Calculate predicted position
    local pred_x = x + (vx * time)
    local pred_y = y + (vy * time)
    local pred_z = z + (vz * time)
    
    return pred_x, pred_y, pred_z
end

-- Travel Through BT (Backtrack) System
client.set_event_callback('setup_command', function(cmd)
    if not menu.predict.predict_enemies:get() then return end
    
    local predict_types = menu.predict.predict_mode_type:get()
    if #predict_types == 0 then return end
    
    local has_travel_bt = false
    for i = 1, #predict_types do
        if predict_types[i] == 'Travel Through BT' then
            has_travel_bt = true
            break
        end
    end
    
    if not has_travel_bt or not menu.predict.travel_bt_memories:get() then return end
    
    local me = entity.get_local_player()
    if not me or not entity.is_alive(me) then return end
    
    local enemies = entity.get_players(true)
    if not enemies then return end
    
    local hitboxes = menu.predict.backtrack_hitboxes:get()
    if #hitboxes == 0 then return end
    
    local attach_mode = menu.predict.backtrack_attach:get()
    local attach_hitbox = 'head'
    if attach_mode == 0 then
        attach_hitbox = 'head'
    elseif attach_mode == 1 then
        attach_hitbox = 'chest'
    elseif attach_mode == 2 then
        attach_hitbox = 'stomach'
    end
    
    -- Apply backtrack prediction for each enemy
    for _, enemy in ipairs(enemies) do
        if entity.is_alive(enemy) then
            -- Store backtrack data
            if not predict_system.player_data[enemy] then
                predict_system.player_data[enemy] = {}
            end
            
            -- Predict position with backtrack
            local pred_x, pred_y, pred_z = predict_enemy_position(enemy, 8)
            if pred_x then
                predict_system.player_data[enemy].predicted_pos = {x = pred_x, y = pred_y, z = pred_z}
                predict_system.player_data[enemy].attach_hitbox = attach_hitbox
            end
        end
    end
end)

-- Menu's Point System
client.set_event_callback('aim_fire', function(e)
    if not menu.predict.predict_enemies:get() then return end
    
    local predict_types = menu.predict.predict_mode_type:get()
    if #predict_types == 0 then return end
    
    local has_menus_point = false
    for i = 1, #predict_types do
        if predict_types[i] == "Menu's Point" then
            has_menus_point = true
            break
        end
    end
    
    if not has_menus_point or not menu.predict.menus_on_point:get() then return end
    
    local target = e.target
    if not target or not entity.is_alive(target) then return end
    
    -- Apply menu's point prediction
    local pred_x, pred_y, pred_z = predict_enemy_position(target, 4)
    if pred_x then
        predict_system.player_data[target] = predict_system.player_data[target] or {}
        predict_system.player_data[target].menus_point = {x = pred_x, y = pred_y, z = pred_z}
    end
end)


local isOs, isFd, isDt = ui.get(ref.hs[1]) and ui.get(ref.hs[2]), ui.get(ref.fakeduck), ui.get(ref.dt[1]) and ui.get(ref.dt[2])
local hsSaved, hsValue = false, 0

if menu.misc.hideshots_fix:get() then
    if isOs and not isDt and not isFd then
        if not hsSaved then hsValue, hsSaved = ui.get(reference.fakeLag[1]), true end
        ui.set(ref.fakelaglimit[1], 1)
    elseif hsSaved then
        ui.set(ref.fakelaglimit[1], hsValue)
        hsSaved = false
    end
end



local logger = {}

prefer_safe_point = ui.reference('RAGE', 'Aimbot', 'Prefer safe point')
force_safe_point = ui.reference('RAGE', 'Aimbot', 'Force safe point')

logger.add = function(...)
    local args = { ... }
    local len = #args
    for i = 1, len do
        local arg = args[i]
        local r, g, b = unpack(arg)

        local msg = {}

        if #arg == 3 then
            table.insert(msg, " ")
        else
            for j = 4, #arg do
                table.insert(msg, arg[j])
            end
        end
        msg = table.concat(msg)

        if len > i then
            msg = msg .. "\0"
        end

        client.color_log(r, g, b, msg)
    end
end

logger.bullet_impacts = {}
logger.bullet_impact = function(e)
    local tick, me, user = globals.tickcount(), entity.get_local_player(), client.userid_to_entindex(e.userid)
    if user ~= me then return end
    if #logger.bullet_impacts > 150 then logger.bullet_impacts = {} end
    logger.bullet_impacts[#logger.bullet_impacts+1] = {tick = tick, eye = vector(client.eye_position()), shot = vector(e.x, e.y, e.z)}
end

logger.get_inaccuracy_tick = function(pre_data, tick)
    for _, impact in pairs(logger.bullet_impacts) do
        if impact.tick == tick then
            local spread_angle = vector((pre_data.eye - pre_data.shot_pos):angles() - (pre_data.eye - impact.shot):angles()):length2d()
            return spread_angle
        end
    end
    return -1
end

logger.get_safety = function(aim_data, target)
    if not aim_data.boosted then return -1 end
    local plist_safety = plist.get(target, 'Override safe point')
    local ui_safety = {ui.get(prefer_safe_point), ui.get(force_safe_point) or plist_safety == 'On'}
    if plist_safety == 'Off' or not (ui_safety[1] or ui_safety[2]) then return 0 end
    return ui_safety[2] and 2 or (ui_safety[1] and 1 or 0)
end

logger.generate_flags = function(pre_data)
    return {pre_data.self_choke > 1 and 1 or 0, pre_data.velocity_modifier < 1.00 and 1 or 0, pre_data.flags.boosted and 1 or 0}
end

logger.hitboxes = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear"}

logger.on_aim_fire = function(e)
    local p_ent = e.target
    local me = entity.get_local_player()

    logger[e.id] = {
        original = e,
        dropped_packets = {},

        handle_time = globals.realtime(),
        self_choke = globals.chokedcommands(),

        flags = {
            boosted = e.boosted
        },

        feet_yaw = entity.get_prop(p_ent, 'm_flPoseParameter', 11) * 120 - 60,
        correction = plist.get(p_ent, 'Correction active'),

        safety = logger.get_safety(e, p_ent),
        shot_pos = vector(e.x, e.y, e.z),
        eye = vector(client.eye_position()),
        view = vector(client.camera_angles()),

        velocity_modifier = entity.get_prop(me, 'm_flVelocityModifier'),
        total_hits = entity.get_prop(me, 'm_totalHitsOnServer'),

        history = globals.tickcount() - e.tick
    }
end

logger.on_aim_hit = function(e)
    if not menu.visuals.aimbot_logger:get() then return end
    if not menu.visuals.aimbot_logger_type:get('Console') then return end

    if logger[e.id] == nil then
        return 
    end
    local prefix1 = ""
    if menu.visuals.aimbot_logger_prefix:get() == "Default" then
    prefix1 = "relentless"
elseif menu.visuals.aimbot_logger_prefix:get() == "Custom" then
    prefix1 = menu.visuals.aimbot_logger_prefix1:get()
end

    local info = {
        type = math.max(0, entity.get_prop(e.target, 'm_iHealth')) > 0,
        prefix = {menu.visuals.main_colors:get()},
        hit = {menu.visuals.main_colors:get()},
        name = entity.get_player_name(e.target),
        hitgroup = logger.hitboxes[e.hitgroup + 1] or '?',
        flags = string.format('%s', table.concat(logger.generate_flags(logger[e.id]))),
        aimed_hitgroup = logger.hitboxes[logger[e.id].original.hitgroup + 1] or '?',
        aimed_hitchance = string.format('%d%%', math.floor(logger[e.id].original.hit_chance + 0.5)),
        hp = math.max(0, entity.get_prop(e.target, 'm_iHealth')),
        spread_angle = string.format('%.2f°', logger.get_inaccuracy_tick(logger[e.id], globals.tickcount())),
        correction = string.format('%d:%d°', logger[e.id].correction and 1 or 0, (logger[e.id].feet_yaw < 10 and logger[e.id].feet_yaw > -10) and 0 or logger[e.id].feet_yaw)
    }
    
    if info.type then
        if menu.visuals.aimbot_logger_type:get("Console") then
            logger.add(
                { 198, 198, 197, "[" },
                { info.prefix[1], info.prefix[2], info.prefix[3], prefix1 },
                { 198, 198, 197, "] " },
                {info.hit[1], info.hit[2], info.hit[3], 'Registered '},
                {198, 198, 197, "Shot "},
                {info.hit[1], info.hit[2], info.hit[3], info.name},
                {200, 200, 200, ' ~ group: '}, {info.hit[1], info.hit[2], info.hit[3], info.hitgroup},
                {200, 200, 200, ' ('}, {info.hit[1], info.hit[2], info.hit[3], info.aimed_hitgroup},
                {200, 200, 200, ') ~ damage: '}, {info.hit[1], info.hit[2], info.hit[3], e.damage},
                {200, 200, 200, ' hp '},
                {200, 200, 200, '[hc: '}, {info.hit[1], info.hit[2], info.hit[3], info.aimed_hitchance},
                {200, 200, 200, ' ~  bt: '}, {info.hit[1], info.hit[2], info.hit[3], logger[e.id].history},
                {200, 200, 200, ']'}
            )
        end
    else
        if menu.visuals.aimbot_logger_type:get("Console") then
            logger.add(
                { 198, 198, 197, "[" },
                { info.prefix[1], info.prefix[2], info.prefix[3], prefix1 },
                { 198, 198, 197, "] " },
                {info.hit[1], info.hit[2], info.hit[3], 'Killed '},
                {info.hit[1], info.hit[2], info.hit[3], info.name},
                {200, 200, 200, ' ~ group: '}, {info.hit[1], info.hit[2], info.hit[3], info.hitgroup},
                {200, 200, 200, ' ~ damage: '}, {info.hit[1], info.hit[2], info.hit[3], e.damage},
                {200, 200, 200, ' hp '},
                {200, 200, 200, '[hc: '}, {info.hit[1], info.hit[2], info.hit[3], info.aimed_hitchance},
                {200, 200, 200, ' ~  bt: '}, {info.hit[1], info.hit[2], info.hit[3], logger[e.id].history},
                {200, 200, 200, ']'}
            )
        end
    end
end

logger.on_aim_miss = function(e)
    if not menu.visuals.aimbot_logger:get() then return end
    if not menu.visuals.aimbot_logger_type:get('Console') then return end
    local prefix1 = ""
    if menu.visuals.aimbot_logger_prefix:get() == "Default" then
    prefix1 = "relentless"
elseif menu.visuals.aimbot_logger_prefix:get() == "Custom" then
    prefix1 = menu.visuals.aimbot_logger_prefix1:get()
end

    local me = entity.get_local_player()
    local info = {
        prefix = {menu.visuals.ragebot_miss:get()},
        hit = {menu.visuals.ragebot_miss:get()},
        name = entity.get_player_name(e.target),
        hitgroup = logger.hitboxes[e.hitgroup + 1] or '?',
        flags = string.format('%s', _G.table.concat(logger.generate_flags(logger[e.id]))),
        aimed_hitgroup = logger.hitboxes[logger[e.id].original.hitgroup + 1] or '?',
        aimed_hitchance = string.format('%d%%', math.floor(logger[e.id].original.hit_chance + 0.5)),
        hp = math.max(0, entity.get_prop(e.target, 'm_iHealth')),
        reason = e.reason == '?' and (logger[e.id].total_hits ~= entity.get_prop(me, 'm_totalHitsOnServer') and 'damage rejection' or 'resolver') or e.reason,
        spread_angle = string.format('%.2f°', logger.get_inaccuracy_tick(logger[e.id], globals.tickcount())),
        correction = string.format('%d:%d°', logger[e.id].correction and 1 or 0, (logger[e.id].feet_yaw < 10 and logger[e.id].feet_yaw > -10) and 0 or logger[e.id].feet_yaw)
    }
     logger.add(
        { 198, 198, 197, "[" },
        { info.prefix[1], info.prefix[2], info.prefix[3], prefix1 },
        { 198, 198, 197, "] " },
        { info.hit[1], info.hit[2], info.hit[3], 'Missed ' },
        { 198, 198, 197, "Shot at " },
        { info.hit[1], info.hit[2], info.hit[3], info.name },
        { 200, 200, 200, ' ~ group: ' }, { info.hit[1], info.hit[2], info.hit[3], info.hitgroup },
        { 200, 200, 200, ' ~ reason: ' }, { info.hit[1], info.hit[2], info.hit[3], info.reason },
        { 200, 200, 200, ' [hc: ' }, { info.hit[1], info.hit[2], info.hit[3], info.aimed_hitchance },
        { 200, 200, 200, ' ~ safety: ' }, { info.hit[1], info.hit[2], info.hit[3], logger[e.id].safety },
        { 200, 200, 200, ' ~ bt: ' }, { info.hit[1], info.hit[2], info.hit[3], logger[e.id].history },
        { 200, 200, 200, ']' }
    )
end

logger.on_item_purchase = function(e)
    if not menu.visuals.aimbot_logger:get() then return end
    if not menu.visuals.aimbot_logger_type:get('Purchases') then return end

    local prefix1 = ""
    if menu.visuals.aimbot_logger_prefix:get() == "Default" then
        prefix1 = "relentless"
    elseif menu.visuals.aimbot_logger_prefix:get() == "Custom" then
        prefix1 = menu.visuals.aimbot_logger_prefix1:get()
    end

    local ent = client.userid_to_entindex(e.userid)
    if not entity.is_enemy(ent) then return end
    ui.set(ref.purchases, false)

    local name = entity.get_player_name(ent)
    local weapon = e.weapon
    if weapon == "weapon_unknown" then return end


    local info = {
        prefix = { menu.visuals.main_colors:get() },
        hit = {  menu.visuals.main_colors:get() },
        name = name,
        weapon = weapon
    }

    logger.add(
        { 198, 198, 197, "[" },
        { info.prefix[1], info.prefix[2], info.prefix[3], prefix1 },
        { 198, 198, 197, "] " },
        { info.hit[1], info.hit[2], info.hit[3], 'bought ' },
        { 198, 198, 197, info.weapon },
        { 200, 200, 200, ' ~ player: ' },
        { info.hit[1], info.hit[2], info.hit[3], info.name }
    )
end





local hitgroup_names = {'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear'}

local function aim_hit1(e)
    if not menu.visuals.aimbot_logger:get() then return end
    if not menu.visuals.aimbot_logger_type:get('Screen') then return end
    local group = hitgroup_names[e.hitgroup + 1] or '?'
    notifications.new(string.format('Hit %s in the %s for %d damage', entity.get_player_name(e.target) or "unknown", group, e.damage or 0), 255, 255, 255, 255)
end


local function aim_miss1(e)
    if not menu.visuals.aimbot_logger:get() then return end
    if not menu.visuals.aimbot_logger_type:get('Screen') then return end
    local group = hitgroup_names[e.hitgroup + 1] or '?'
    notifications.new(string.format('Missed %s in the %s due to %s', entity.get_player_name(e.target) or "unknown", group, e.reason or "?"), 255, 255, 255, 255)
end







client.set_event_callback('aim_fire', function(e)
    logger.on_aim_fire(e)
end)

client.set_event_callback('aim_miss', LPH_JIT(function(e)
    logger.on_aim_miss(e)
    aim_miss1(e)
end))

client.set_event_callback('aim_hit', LPH_JIT(function(e)
    logger.on_aim_hit(e)
    aim_hit1(e)
end))

client.set_event_callback('bullet_impact', function(e)
    logger.bullet_impact(e)
end)

local id = 1
local last_press = 0
local direction = 0
local last_press_t_dir = 0
local manuals = 0
local debug_state = "Global"


local function aspectratio(value)
    if value then
        cvar.r_aspectratio:set_float(value)
    end
end 


--creditos
local current_tickcount = 0
local to_jitter = false
local function randomize(original_value, percent)
    local min_range = original_value - (original_value * percent / 100)
    local max_range = original_value + (original_value * percent / 100)
    return math.random(min_range, max_range)
end

function normalize_yaw(yaw)
    yaw = (yaw % 360 + 360) % 360
    return yaw > 180 and yaw - 360 or yaw
end
--end creditos


anti_knife_dist = function (x1, y1, z1, x2, y2, z2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2)
end

local run_direction = function()
    menu.hotkeys.manual_left:set('On hotkey')
    menu.hotkeys.manual_right:set('On hotkey')
    menu.hotkeys.manual_forward:set('On hotkey')

    if menu.hotkeys.manual_forward:get() and last_press_t_dir + 0.2 < globals.curtime() then
        manuals = manuals == 3 and 0 or 3
        last_press_t_dir = globals.curtime()
    elseif menu.hotkeys.manual_left:get() and last_press_t_dir + 0.2 < globals.curtime() then
        manuals = manuals == 1 and 0 or 1
        last_press_t_dir = globals.curtime()
    elseif menu.hotkeys.manual_right:get() and last_press_t_dir + 0.2 < globals.curtime() then
        manuals = manuals == 2 and 0 or 2
        last_press_t_dir = globals.curtime()
    elseif last_press_t_dir > globals.curtime() then
        last_press_t_dir = globals.curtime()
    end
end


local function player_state(cmd)
    local lp = entity.get_local_player()
    if lp == nil then return end
    run_direction()

    vecvelocity = { entity.get_prop(lp, 'm_vecVelocity') }
    flags = entity.get_prop(lp, 'm_fFlags')
    velocity = math.sqrt(vecvelocity[1]^2+vecvelocity[2]^2)
    groundcheck = bit.band(flags, 1) == 1
    jumpcheck = bit.band(flags, 1) == 0 or cmd.in_jump == 1
    ducked = entity.get_prop(lp, 'm_flDuckAmount') > 0.7
    duckcheck = ducked or ui.get(ref.fakeduck)
    slowwalk_key = ui.get(ref.slow[1]) and ui.get(ref.slow[2])
    fakelag = (ui.get(ref.dt[1]) and ui.get(ref.dt[2]) or ui.get(ref.hs[1]) and ui.get(ref.hs[2]))
    fs_key = ui.get(ref.freestanding[1]) and ui.get(ref.freestanding[2])
    if jumpcheck and duckcheck then return "Air+C"
    elseif not fakelag then return "Fakelag"
    elseif fs_key then return 'Freestanding'
    elseif jumpcheck then return "Air"
    elseif duckcheck and velocity > 10 then return "Duck-Moving"
    elseif duckcheck and velocity < 10 then return "Duck"
    elseif groundcheck and slowwalk_key and velocity > 10 then return "Walking"
    elseif groundcheck and velocity > 5 then return "Moving"
    elseif groundcheck and velocity < 5 then return "Stand"
    else return "Shared" end
end
local yaw_direction = 0


 local function safe_head(cmd)
        if not menu.other.safe_head then return end
        local player = entity.get_local_player()
        if not player or not entity.is_alive(player) then return end
        local active_weapon = entity.get_prop(player, "m_hActiveWeapon")
        if not active_weapon then return end
        local classname = entity.get_classname(active_weapon)
        local weapon_name = nil
    
        if classname == "CKnife" then
            weapon_name = "Knife"
        elseif classname == "CWeaponTaser" then
            weapon_name = "Zeus"
        else
            return
        end
    
        if not menu.other.safe_head_select:get(weapon_name) then return end
        if jumpcheck and duckcheck and menu.other.safe_head:get() then
            ui.set(ref.pitch[1], "down")
            ui.set(ref.yaw[1], "180")
            ui.set(ref.yaw[2], -1)
            ui.set(ref.yawbase, "At targets")
            ui.set(ref.yawjitter[1], "Off")
            ui.set(ref.body_yaw[1], "Static")
            ui.set(ref.body_yaw[2], 0)
        end
    end
    





local anti_brute = {
    active_until = 0,
    last_print = 0,
    current_offset = 0
}

local function get_closest_point(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }

    local atb2 = a_to_b[1]^2 + a_to_b[2]^2
    if atb2 == 0 then return A end

    local atp_dot_atb = a_to_p[1] * a_to_b[1] + a_to_p[2] * a_to_b[2]
    local t = math.max(0, math.min(1, atp_dot_atb / atb2))

    return { A[1] + a_to_b[1] * t, A[2] + a_to_b[2] * t }
end

client.set_event_callback("bullet_impact", function(e)
    if not menu.other.anti_bruteforce:get() then
        anti_brute.current_offset = 0
        return
    end
    local ent = client.userid_to_entindex(e.userid)
    if entity.is_enemy(ent) then
        local ent_origin = { entity.get_prop(ent, "m_vecOrigin") }
        local local_head = { entity.hitbox_position(entity.get_local_player(), 0) }
        
        local closest = get_closest_point(
            { ent_origin[1], ent_origin[2] },
            { e.x, e.y },
            { local_head[1], local_head[2] }
        )
        
        local delta = (local_head[1] - closest[1])^2 + (local_head[2] - closest[2])^2
        if delta <= 1600 then
            anti_brute.active_until = globals.realtime() + 10
            anti_brute.current_offset = math.random(-8, -1)
            
            if globals.realtime() - anti_brute.last_print > 1 then
               notifications.new(string.format("Anti-bruteforce Switched due to enemy shot"), 0, 255, 0) 
                anti_brute.last_print = globals.realtime()
            end
        end
    end
end)


--end

local function aa_setup(cmd)
    local lp = entity.get_local_player()
    if lp == nil then return end

    local players = entity.get_players(true)
    debug_state = player_state(cmd)

    if player_state(cmd) == "Freestanding" and builder[10].state:get() then
        id = 10
    elseif player_state(cmd) == "Fakelag" and builder[9].state:get() then
        id = 9
    elseif player_state(cmd) == "Duck-Moving" and builder[8].state:get() then
        id = 8
    elseif player_state(cmd) == "Duck" and builder[7].state:get() then
        id = 7
    elseif player_state(cmd) == "Air+C" and builder[6].state:get() then
        id = 6
    elseif player_state(cmd) == "Air" and builder[5].state:get() then
        id = 5
    elseif player_state(cmd) == "Moving" and builder[4].state:get() then
        id = 4
    elseif player_state(cmd) == "Walking" and builder[3].state:get() then
        id = 3
    elseif player_state(cmd) == "Stand" and builder[2].state:get() then
        id = 2
    else
        id = 1
    end

    cmd.force_defensive = builder[id].force_lc:get()
    local delay_type = builder[id].delay_type:get()
    local yaw_type = builder[id].yaw_type:get()

    if delay_type == 2 and yaw_type == 2 then
        if globals.tickcount() > current_tickcount + builder[id].yaw_delay_default:get() then
            if cmd.chokedcommands == 0 then
                to_jitter = not to_jitter
                current_tickcount = globals.tickcount()
            end
        elseif globals.tickcount() < current_tickcount then
            current_tickcount = globals.tickcount()
        end

    elseif delay_type == 3 and yaw_type == 2 then
        local random_delay = math.random(builder[id].yaw_delay_min:get(), builder[id].yaw_delay_max:get())
        if globals.tickcount() > current_tickcount + random_delay then
            if cmd.chokedcommands == 0 then
                to_jitter = not to_jitter
                current_tickcount = globals.tickcount()
            end
        elseif globals.tickcount() < current_tickcount then
            current_tickcount = globals.tickcount()
        end

    elseif delay_type == 4 and yaw_type == 2 then
        local delay_index = math.random(1, 10)
        local delay_key = "yaw_delay_new_" .. delay_index

        if builder[id][delay_key] ~= nil then
            local delay_value = builder[id][delay_key]:get()
            if globals.tickcount() > current_tickcount + delay_value then
                if cmd.chokedcommands == 0 then
                    to_jitter = not to_jitter
                    current_tickcount = globals.tickcount()
                end
            elseif globals.tickcount() < current_tickcount then
                current_tickcount = globals.tickcount()
            end
        end

    elseif delay_type == 5 and yaw_type == 2 then
        if cmd.chokedcommands == 0 then
            local current_tick = globals.tickcount()
            local switch_chance = builder[id].switch_chance:get() or 100
            if current_tick - current_tickcount >= 2 then
                local randomiz = math.random(1, 100)
                if randomiz <= switch_chance then
                    to_jitter = not to_jitter
                    current_tickcount = current_tick
                end
            elseif current_tick < current_tickcount then
                current_tickcount = current_tick
            end
        end
    end

if (delay_type == 2 or delay_type == 3 or delay_type == 4 or delay_type == 5) and yaw_type == 2 then
    ui.set(ref.body_yaw[1], "Static")
    ui.set(ref.body_yaw[2], to_jitter and 1 or -1)

elseif builder[id].body_yaw:get() == "Min/Max" then
    local low = builder[id].body_amount_first:get()
    local high = builder[id].body_amount_second:get()
    if low > high then low, high = high, low end
    ui.set(ref.body_yaw[1], "Jitter")
    ui.set(ref.body_yaw[2], math.random(low, high))
else
    ui.set(ref.body_yaw[1], builder[id].body_yaw:get())
    ui.set(ref.body_yaw[2], builder[id].body_amount:get())
end


-- 4ч ночи а я хочу спать поэтому фаст кодинг потом фиксинг P.S SHITCODE
last_switch = last_switch or globals.realtime()
switch_state = switch_state or true
random_jitter_type = random_jitter_type or "Offset"
random_spike = random_spike or 0

ui.set(ref.yawbase, "At Targets")
ui.set(ref.pitch[1], "Down")
ui.set(ref.yaw[1], "180")

local mod_type = builder[id].modifier_type:get()

if mod_type == "UKRAINA" then
    local t = globals.tickcount() * 0.25
    local wave = math.floor(math.sin(t) * builder[id].ukraina_amount:get())

    if globals.realtime() - last_switch > 2.0 then
        switch_state = not switch_state
        last_switch = globals.realtime()
    end

  if switch_state then
    ui.set(ref.yawjitter[1], "Skitter")
else
    ui.set(ref.yawjitter[1], "Offset")
end

    ui.set(ref.yawjitter[2], wave)

elseif mod_type == "5-Way" then
    local modifiers = {
        "Center",
        "Offset",
        "Random",
        "Skitter"
    }
    local ways = {
        builder[id].way1:get(),
        builder[id].way2:get(),
        builder[id].way3:get(),
        builder[id].way4:get(),
        builder[id].way5:get(),
    }
    ui.set(ref.yawjitter[2], ways[(globals.tickcount() % #ways) + 1])
    if builder[id].ways5_method:get() == "Randomize" then
        ui.set(ref.yawjitter[1], modifiers[math.random(1, #modifiers)])
    else
        ui.set(ref.yawjitter[1], builder[id].ways5_method:get())
    end


elseif mod_type == "Relentless" then
    local allowed = { "Offset", "Random", "Skitter", "Center" }

    if globals.realtime() - last_switch > 0.15 then
        last_switch = globals.realtime()
        switch_state = not switch_state

        random_jitter_type = allowed[math.random(1, #allowed)]
        random_spike = math.random(-builder[id].relentless_random:get(), builder[id].relentless_random:get())
    end

    local t = globals.tickcount() * 0.2
    local wave = math.floor(math.sin(t) * builder[id].relentless_wave:get() + random_spike)

    ui.set(ref.yawjitter[1], random_jitter_type)
    ui.set(ref.yawjitter[2], wave)

elseif mod_type == "Maksim" then
    local t = globals.tickcount() * 0.3
    local wave = math.floor(math.sin(t) * builder[id].maksim_wave:get())

    if globals.realtime() - last_switch > 2.0 then
        switch_state = not switch_state
        last_switch = globals.realtime()
    end

    if globals.realtime() - last_switch < 0.3 then
        ui.set(ref.yawjitter[1], "Off")
    else
        if switch_state then
            ui.set(ref.yawjitter[1], "Offset")
            ui.set(ref.yawjitter[2], wave + math.random(-builder[id].maksim_amount:get(), builder[id].maksim_amount:get()))
        else
            ui.set(ref.yawjitter[1], "Random")
            ui.set(ref.yawjitter[2], math.random(-builder[id].maksim_random:get(), builder[id].maksim_random:get()))
        end
    end


elseif builder[id].flicker:get() == 2 and mod_type ~= "Off" then
    local choke = globals.chokedcommands()

    if choke > 10 then
        ui.set(ref.yawjitter[1], "Random")
        ui.set(ref.yawjitter[2], builder[id].flick1:get())
    elseif choke > 0 then
        ui.set(ref.yawjitter[1], "Offset")
        ui.set(ref.yawjitter[2], builder[id].flick2:get())
    else
        ui.set(ref.yawjitter[1], "Skitter")
        ui.set(ref.yawjitter[2], builder[id].flick3:get())
    end

elseif builder[id].modifier_type_method:get() == 2 and (mod_type == "Center" or mod_type == "Offset" or mod_type == "Random" or mod_type == "Skitter") then
    ui.set(ref.yawjitter[1], mod_type)
    ui.set(ref.yawjitter[2], builder[id].modifier_type_method_left:get() + -builder[id].modifier_type_method_right:get())
else   
    ui.set(ref.yawjitter[1], mod_type)
    ui.set(ref.yawjitter[2], builder[id].modifier_type_offset:get() + math.random(0, builder[id].modifier_type_randomize:get()))
end

--END


    local desync_type = entity.get_prop(lp, 'm_flPoseParameter', 11) * 120 - 60
    local desync_side = desync_type > 0 

    local yaw_amount = (desync_side and randomize(builder[id].yaw_left:get(), builder[id].yaw_random:get()) or 
                        randomize(builder[id].yaw_right:get(), builder[id].yaw_random:get())) or 
                        (desync_side and builder[id].yaw_left:get() or builder[id].yaw_right:get())

    ui.set(ref.yaw[2], yaw_direction == 0 and yaw_amount or yaw_direction)

        if menu.other.avoid_backstab:get() then
        local lp = entity.get_local_player()
        lp_orig_x, lp_orig_y, lp_orig_z = entity.get_prop(lp, "m_vecOrigin")
        for i=1, #players do
            if players == nil then return end
            enemy_orig_x, enemy_orig_y, enemy_orig_z = entity.get_prop(players[i], "m_vecOrigin")
            distance_to = anti_knife_dist(lp_orig_x, lp_orig_y, lp_orig_z, enemy_orig_x, enemy_orig_y, enemy_orig_z)
            weapon = entity.get_player_weapon(players[i])
            if weapon == nil then return end
            if entity.get_classname(weapon) == "CKnife" and distance_to <= menu.other.avoid_backstab_amount:get() then
                ui.set(ref.yaw[2], 180)
                ui.set(ref.yawbase, "At targets")
            end
        end
    end
      for i=1, 64 do
        if entity.is_alive(i) and entity.is_enemy(i) then
            table.insert(alive_players, i)
        end
    end

    ui.set(ref.freestanding[1], false)
    ui.set(ref.freestanding[2], 'On Hotkey')

    if menu.hotkeys.freestanding_yaw:get() then
        ui.set(ref.freestanding[1], true)
        ui.set(ref.freestanding[2], 'Always On')
    else
        ui.set(ref.freestanding[1], false)
        ui.set(ref.freestanding[2], 'On Hotkey')
    end

       if menu.other.aa_disablers:get() and menu.other.aa_disabler_mode:get('On Warmup') then
        if entity.get_prop(entity.get_game_rules(), "m_bWarmupPeriod") == 1 then
            ui.set(ref.yaw[1], "spin")
            ui.set(ref.yaw[2], menu.other.aa_disabler_speed:get())
            ui.set(ref.pitch[1], "Custom")
            ui.set(ref.body_yaw[1], "Static")
            ui.set(ref.body_yaw[2], 0)
            ui.set(ref.pitch[2], math.random(0))
        end
    end

       if menu.other.aa_disablers:get() and menu.other.aa_disabler_mode:get('No Enemies') then
        if client.current_threat() == nil and #alive_players == 0 then
            ui.set(ref.yaw[1], "spin")
            ui.set(ref.yaw[2], menu.other.aa_disabler_speed:get())
            ui.set(ref.pitch[1], "Custom")
            ui.set(ref.body_yaw[1], "Static")
            ui.set(ref.body_yaw[2], 0)
            ui.set(ref.pitch[2], math.random(0))
        end
    end

    alive_players = {}

-- Defensive AA Logic
local function get_tickbase_shift()
    local me = entity.get_local_player()
    if not me or not entity.is_alive(me) then return 0 end
    
    local tickbase = entity.get_prop(me, "m_nTickBase")
    if not tickbase then return 0 end
    
    local simtime_diff = tickbase - (globals.tickcount() + client.latency() / globals.tickinterval())
    return math.floor(simtime_diff)
end

local function is_defensive_active()
    local shift = get_tickbase_shift()
    return shift < -1 and shift >= -14
end

-- Apply defensive AA if active
if defensive[id] and defensive[id].state:get() and is_defensive_active() then
    local def_cfg = defensive[id]
    
    -- Check if defensive should work on current exploit
    local work_on = def_cfg.defensive_on:get()
    local dt_active = ui.get(ref.dt[1]) and ui.get(ref.dt[2])
    local hs_active = ui.get(ref.hs[1]) and ui.get(ref.hs[2])
    
    local should_work = false
    for i = 1, #work_on do
        if work_on[i] == "Double tap" and dt_active then should_work = true end
        if work_on[i] == "Hide shots" and hs_active then should_work = true end
    end
    
    if should_work then
        -- Apply defensive pitch
        local pitch_mode = def_cfg.pitch_mode:get()
        if pitch_mode ~= "Off" then
            if pitch_mode == "Up" then
                ui.set(ref.pitch[1], "Up")
            elseif pitch_mode == "Down" then
                ui.set(ref.pitch[1], "Down")
            elseif pitch_mode == "Zero" then
                ui.set(ref.pitch[1], "Custom")
                ui.set(ref.pitch[2], 0)
            elseif pitch_mode == "Custom" then
                ui.set(ref.pitch[1], "Custom")
                ui.set(ref.pitch[2], def_cfg.pitch_value:get())
            elseif pitch_mode == "Random" then
                ui.set(ref.pitch[1], "Custom")
                ui.set(ref.pitch[2], client.random_int(-89, 89))
            elseif pitch_mode == "Jitter" then
                local phase = globals.tickcount() % 2
                ui.set(ref.pitch[1], "Custom")
                ui.set(ref.pitch[2], phase == 0 and def_cfg.pitch_min:get() or def_cfg.pitch_max:get())
            elseif pitch_mode == "Spin" then
                local speed = def_cfg.pitch_speed:get()
                ui.set(ref.pitch[1], "Custom")
                ui.set(ref.pitch[2], math.sin(globals.realtime() * speed) * 89)
            elseif pitch_mode == "Sway" then
                local speed = def_cfg.pitch_speed:get()
                ui.set(ref.pitch[1], "Custom")
                ui.set(ref.pitch[2], math.sin(globals.realtime() * speed) * 89 * (math.cos(globals.realtime() * speed * 0.5) + 1) / 2)
            end
        end
        
        -- Apply defensive yaw
        local yaw_mode = def_cfg.yaw_mode:get()
        if yaw_mode ~= "Off" then
            if yaw_mode == "180" then
                ui.set(ref.yaw[2], 180)
                ui.set(ref.yawjitter[1], "Off")
            elseif yaw_mode == "Spin" then
                local speed = def_cfg.yaw_speed:get()
                ui.set(ref.yaw[2], (globals.realtime() * speed * 180) % 360 - 180)
                ui.set(ref.yawjitter[1], "Off")
            elseif yaw_mode == "Jitter" then
                local phase = globals.tickcount() % 2
                ui.set(ref.yaw[2], phase == 0 and def_cfg.yaw_left:get() or def_cfg.yaw_right:get())
                ui.set(ref.yawjitter[1], "Off")
            elseif yaw_mode == "Random" then
                ui.set(ref.yaw[2], client.random_int(-180, 180))
                ui.set(ref.yawjitter[1], "Off")
            elseif yaw_mode == "Sway" then
                local speed = def_cfg.yaw_speed:get()
                local offset = def_cfg.yaw_offset:get()
                ui.set(ref.yaw[2], offset + math.sin(globals.realtime() * speed) * 60)
                ui.set(ref.yawjitter[1], "Off")
            end
        end
    end
end

    if manuals == 1 then
    ui.set(ref.pitch[1], "down") 
    ui.set(ref.yaw[1], '180')
    ui.set(ref.yaw[2], -90)
    ui.set(ref.yawbase, "At targets")
    ui.set(ref.yawjitter[1], "Off")  
    ui.set(ref.body_yaw[1], "Static")
    ui.set(ref.body_yaw[2], 0)
end
if manuals == 2 then
    ui.set(ref.pitch[1], "down") 
    ui.set(ref.yaw[1], '180')
    ui.set(ref.yaw[2], 90)
    ui.set(ref.yawbase, "At targets")
    ui.set(ref.yawjitter[1], "Off")  
    ui.set(ref.body_yaw[1], "Static")
    ui.set(ref.body_yaw[2], 0)
end
if manuals == 3 then
    ui.set(ref.pitch[1], "down") 
    ui.set(ref.yaw[1], '180')
    ui.set(ref.yaw[2], 180)
    ui.set(ref.yawbase, "At targets")
    ui.set(ref.yawjitter[1], "Off")  
    ui.set(ref.body_yaw[1], "Static")
    ui.set(ref.body_yaw[2], 0)
end
end


local function set_random_watermark_text()
local watermark_texts = {
    {"[LC = 100%] [LC = 100%] [LC = 100%] [LC = 100%]"},
    {"#funeralhvhbigboy"},
    {"5$ resolver"},
    {"renetless.pink"},
    {"1000$ TOURNAMENT OWNER"},
    {"desync.max"},
    {"renesync.max"},
    {"jossysync.hvh"},
    {"keyl0w --> (｡♥‿♥｡)"},
    {"funeral --> (ㆆᴗㆆ)"},
    {"・゜✭ R E L E N T L E S S ✭ ゜・"},
    {"Keyl0w say me nigger..."},
    {"customresolver"},
    {"resolveralphacode10voshelvnee228"},
    {"The beaver sat on a chair, fell down, saw relentless and died!"},
    {"БАБРЯТИНА"},
    {"Ренентлиальность"},
    {"funeral --> (◕‿◕)"},
    {"ebatatel.lua"},
    {"neverlose.ru"},
    {"смыслигры.паблик"},
    {"keylow ~ (0_-)"},
    {"RenaYaw"},
    {"keylow --> (~0_0~)"},
    {"пот пот пот пот пот"},
    {"тот самы гей"},
    {"Russia Federation --> ukraine(govno) (>_<)"},
    {"₍̗⁽ˆ⁰ˆ⁾₎͕"},
    {"Алексей Подвальный"},
    {"▶︎ •၊၊||၊|။||||။‌‌‌‌‌၊|• 0:30"},
    {"Острые козырьки"},
    {"ОГУЗОК ЭТО ЧТО ЗА ДЕЛА???"}, 
    {"funeral --> (HVH)"},
    {"Krezori ~ |l_o|"},
    {"keyl0w Большие_СIСKI"},
    {"#semgahvhlyi"}
}
    local current_text = menu.visuals.watermark_text:get()

    local selected_data
    repeat
        local random_index = math.random(1, #watermark_texts)
        selected_data = watermark_texts[random_index][1]  
    until selected_data ~= current_text

    if menu and menu.visuals and menu.visuals.watermark_text then
        menu.visuals.watermark_text:set(selected_data)
    end
end

generate_text = main_group:button('Generate', set_random_watermark_text)
generate_text:depend(vis_tab, {menu.visuals.watermark_mode, "Custom"})

menu.visuals.console_filter:set_callback(function(self)
    if menu.visuals.console_filter:get() then
        cvar.con_filter_enable:set_int(1)
        cvar.con_filter_text:set_string("IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN")
        client.exec("con_filter_enable 1")
    else
        cvar.con_filter_enable:set_int(0)
        cvar.con_filter_text:set_string("")
        client.exec("con_filter_enable 0")
    end
end)

local function mindmg(self)
    if not (menu.visuals.damage_indicator:get()) then return end
    local screen_size_x, screen_size_y  = client.screen_size()
    local local_player = entity.get_local_player()
    if not entity.is_alive(local_player) or not local_player then return end
    local norm_dmg = ui.get(ref.mindamage)
    local dmg_key, tmp = ui.get(ref.minimum_damage_override[2])
    local dmg_value = ui.get(ref.minimum_damage_override[3])
    local value = (not menu.visuals.damage_indicator_select:get("Show Always") and dmg_key and dmg_value or dmg_key) and dmg_value or dmg_value

    if dmg_key then
        renderer.text(screen_size_x / 2 + 2, screen_size_y / 2 - 12, 255, 255, 255, 255, "-", nil , tostring(value))
    else
        if not menu.visuals.damage_indicator_select:get("Show Always") then return end
        renderer.text(screen_size_x / 2 + 2, screen_size_y / 2 - 12, 255, 255, 255, 255, "-" , nil, tostring(norm_dmg))
    end
end

local function check_charge()
    if not ui.get(ref.dt[1]) or not ui.get(ref.dt[2]) or ui.get(ref.fakeduck) then return false end
    if not entity.is_alive(entity.get_local_player()) or entity.get_local_player() == nil then return end
    local weapon = entity.get_prop(entity.get_local_player(), "m_hActiveWeapon")
    if weapon == nil then return false end
    local next_attack = entity.get_prop(entity.get_local_player(), "m_flNextAttack") + 0.01
    local checkcheck = entity.get_prop(weapon, "m_flNextPrimaryAttack")
    if checkcheck == nil then return end
    local next_primary_attack = checkcheck + 0.01
    if next_attack == nil or next_primary_attack == nil then return false end
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local scoped_space = 0
local function cross_ind()
    if menu.visuals.cross_indicator:get() then
    local lp = entity.get_local_player()
    if lp == nil then return end
    local screen = {client.screen_size()}
    local screen1 = {screen[1]/2, screen[2]/2} 
    local ind = renderer.measure_text("relentless")
    local scpd = entity.get_prop(lp, "m_bIsScoped") == 1
    scoped_space = helpers.math.speed(scoped_space, scpd and 1 or 0, 25)
    local condition = "GLOBAL"
    if id == 1 then condition = "GLOBAL"
    elseif id == 2 then condition = "STANDING"
    elseif id == 3 then condition = "SLOW"
    elseif id == 4 then condition = "MOVING"
    elseif id == 5 then condition = "AIR"
    elseif id == 6 then condition = "AIR+"
    elseif id == 7 then condition = "DUCK"
    elseif id == 8 then condition = "DUCK+"
    elseif id == 9 then condition = "FAKELAG"
    elseif id == 10 then condition = "FREESTANDING" end
    local state= renderer.measure_text('c-', condition or string.upper(condition))
    local spaceind = 10
    local dtx, dty = renderer.measure_text('doubletap')
    local bodyx, bodyy = renderer.measure_text('baim')
    local osaax, osaay = renderer.measure_text('hs')
    local fsx, fsy = renderer.measure_text('fs')
    local dmgx, dmgy = renderer.measure_text('dmg')
    local main_r, main_g, main_b, main_a = menu.visuals.cross_indicator_color:get()
    local aA = helpers.create_color_array(main_r, main_g, main_b, "relentless")
    renderer.text(screen1[1] + math.floor(scoped_space * 36), screen1[2] + 15, 255, 255, 255, 255, "c-", 0, string.format("\a%sR \a%s E\a%s N\a%s E\a%s T\a%s L\a%s E\a%s S\a%s S", 
    helpers.rgba_to_hex(unpack(aA[1])), 
    helpers.rgba_to_hex(unpack(aA[2])), 
    helpers.rgba_to_hex(unpack(aA[3])), 
    helpers.rgba_to_hex(unpack(aA[4])), 
    helpers.rgba_to_hex(unpack(aA[5])), 
    helpers.rgba_to_hex(unpack(aA[6])), 
    helpers.rgba_to_hex(unpack(aA[7])),
    helpers.rgba_to_hex(unpack(aA[8])),
    helpers.rgba_to_hex(unpack(aA[9]))))

    local r3, g3, b3, a3 = 200, 200, 200, 255,255
    renderer.text(screen1[1] + math.floor((state + 24)*0.5 * scoped_space), screen1[2] + 25, 200, 200, 200, 255, "c-", nil, string.upper(condition))
    if ui.get(ref.forcebaim)then
        renderer.text(screen1[1] + math.floor((dtx + 42)*0.5 * scoped_space), screen1[2] + 24 + (spaceind), 200, 200, 200, 255, "c-", 0, "BODY")
        spaceind = spaceind + 10
        end

        if ui.get(ref.os[1]) and ui.get(ref.os[2]) then
        renderer.text(screen1[1] + math.floor((dtx + 40)*0.5 * scoped_space), screen1[2] + 24 + (spaceind), r3, g3, b3, 255, "c-", 0, "HIDE")
        spaceind = spaceind + 10
        end

        if ui.get(ref.minimum_damage_override[1]) and ui.get(ref.minimum_damage_override[2]) then
        renderer.text(screen1[1] + math.floor((dmgx + 40)*0.5 * scoped_space), screen1[2] + 24 + (spaceind), r3, g3, b3, 255, "c-", 0, "DMG")
        spaceind = spaceind + 10
        end

        if ui.get(ref.dt[1]) and ui.get(ref.dt[2]) then
            if check_charge() then
            renderer.text(screen1[1] + math.floor((dtx + 32)*0.5 * scoped_space), screen1[2] + 24 + (spaceind), 200, 200, 200, 255, "c-", 0, "DT")
            else
            renderer.text(screen1[1] + math.floor((dtx + 32)*0.5 * scoped_space), screen1[2] + 24 + (spaceind), 255, 0, 0, 255, "c-", 0, "DT")
            end
            spaceind = spaceind + 10
            end  
       end
end






local clan_tags = {
    "",
    "#",
    "#R",
    "#RE",
    "#REL",
    "#RELE",
    "#RELEN",
    "#RELENT",
    "#RELENTL",
    "#RELENTLE",
    "#RELENTLES",
    "#RELENTLESS",
    "#RELENTLES",
    "#RELENTLE",
    "#RELENTL",
    "#RELENT",
    "#RELEN",
    "#RELE",
    "#REL",
    "#RE",
    "#R",
    "#",
    "",
    ""
}
local last_step = -1
local frame_interval = 20

local function clantag()
    local enabled = menu.misc.clantag:get()
    local server_tick = globals.tickcount()
    local current_step = math.floor(server_tick / frame_interval)
    if not enabled then
        if last_step ~= -1 then
            client.set_clan_tag("")
            last_step = -1
        end
        return
    end

    ui.set(ref.clantag1, false)
    if last_step == current_step then return end

    local new_index = (current_step % #clan_tags) + 1
    client.set_clan_tag(clan_tags[new_index])
    last_step = current_step
end


local function anim_breaker()
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then return end
    if not menu.other.anim_breaker:get() then return end

    local self_ent = c_entity.new(lp)
    local self_anim_state = self_ent:get_anim_state()
    if not self_anim_state then return end

    local self_anim_overlay = self_ent:get_anim_overlay(12)
    if not self_anim_overlay then return end

    if math.abs(entity.get_prop(lp, "m_vecVelocity[0]") or 0) >= 3 then
        self_anim_overlay.weight = 1
    end

    local ground_anim = menu.other.anim_breaker_ground:get()

    if ground_anim == "Static" then
        entity.set_prop(lp, "m_flPoseParameter", 1, 0)
        ui.set(ref.legmovement[1], "Always slide")

    elseif ground_anim == "Jitter" then
        local jitter_first = menu.other.anim_breaker_jitter_first:get()
        local jitter_second = menu.other.anim_breaker_jitter_second:get()

        ui.set(ref.legmovement[1], "Always slide")

        if globals.tickcount() % jitter_first <= 1 then
            entity.set_prop(lp, "m_flPoseParameter", jitter_second / 10, 0)
        end

    elseif ground_anim == "Random" then
        ui.set(ref.legmovement[1], "Always slide")
        ui.set(ref.legmovement[1], client.random_int(1, 2) == 1 and "Off" or "Always slide")
        entity.set_prop(
            lp,
            "m_flPoseParameter",
            client.random_float(menu.other.anim_breaker_random_amount:get() / 10, 1),
            0
        )

    else
        --спасаемся
        entity.set_prop(lp, "m_flPoseParameter", client.random_int(350, 370) / 360, 7)
        entity.set_prop(lp, "m_flPoseParameter", 1, 0)
    end

    local air_anim = menu.other.anim_breaker_air:get()
    if air_anim == "Static" and jumpcheck or jumpcheck and duckcheck then
        entity.set_prop(lp, "m_flPoseParameter", menu.other.anim_breaker_air_amount:get() / 10, 6)
    elseif air_anim == "Jitter" and jumpcheck or jumpcheck and duckcheck then
        entity.set_prop(lp, "m_flPoseParameter", math.random(0, 10) / 10, 6)
    end

    if menu.other.anim_breaker_other:get("EarthQuake") then
        self_anim_overlay.weight = math.random(1, 15) / 10
    end

    if menu.other.anim_breaker_other:get("Move Lean") then
        self_anim_overlay.weight = client.random_int(0, 10) / 3    end
end

local zoom_offset = 0

client.set_event_callback('override_view', function(e)
    local lp = entity.get_local_player()
    if not lp then return end
    if not menu.visuals.animated_zoom:get() then return end

    local scoped = entity.get_prop(lp, "m_bIsScoped") == 1
    local weapon = entity.get_player_weapon(lp)
    local zoomlevel = entity.get_prop(weapon, "m_zoomLevel")

    local value = 0

    if scoped then
        if zoomlevel == 1 then
            value = menu.visuals.animated_fov:get()
        else
            value = menu.visuals.animated_fov:get() * 2
        end
    else
        value = 0
    end

    zoom_offset = helpers.math.lerp(zoom_offset, scoped and value or 0, 0.2)

    e.fov = ui.get(ref.fov) - zoom_offset
end)

local function fastladder(e)
    if menu.misc.fast_ladder:get() then
    local local_player = entity.get_local_player()
    local pitch, yaw = client.camera_angles()
    if entity.get_prop(local_player, "m_MoveType") == 9 then
        e.yaw = math.floor(e.yaw+0.5)
        e.roll = 0
            if e.forwardmove == 0 then
                if e.sidemove ~= 0 then
                    e.pitch = 89
                    e.yaw = e.yaw + 180
                    if e.sidemove < 0 then
                        e.in_moveleft = 0
                        e.in_moveright = 1
                    end
                    if e.sidemove > 0 then
                        e.in_moveleft = 1
                        e.in_moveright = 0
                    end
                end
            end
            if e.forwardmove > 0 then
                if pitch < 45 then
                    e.pitch = 89
                    e.in_moveright = 1
                    e.in_moveleft = 0
                    e.in_forward = 0
                    e.in_back = 1
                    if e.sidemove == 0 then
                        e.yaw = e.yaw + 90
                    end
                    if e.sidemove < 0 then
                        e.yaw = e.yaw + 150
                    end
                    if e.sidemove > 0 then
                        e.yaw = e.yaw + 30
                    end
                end 
            end
            if e.forwardmove < 0 then
                e.pitch = 89
                e.in_moveleft = 1
                e.in_moveright = 0
                e.in_forward = 1
                e.in_back = 0
                if e.sidemove == 0 then
                    e.yaw = e.yaw + 90
                end
                if e.sidemove > 0 then
                    e.yaw = e.yaw + 150
                end
                if e.sidemove < 0 then
                    e.yaw = e.yaw + 30
                end
            end
    end
end
end

local trashtalk_phrases = {
    bait = {
        kill = {
    {'игрок?'}, {'паращыч ебаный'}, {'обоссан'}, {'але уебище релентлесс яв гетни потом вырыгивай что то'}, {'1', 'hs bot'},
    {'1', '*DEAD*', 'ахахахах'}, {'в сон нахуй'}, {'трахнут'}, {'поспи', 'хуйсоска ебаная'}, {'лови в харю', 'припиздюк немощный'},
    {'sleep'}, {'изи упал нищий'}, {'l2p bot'}, {'лови тапыча', 'мусор нищий'},
    {'1 мусор учись играть'}, {'че, пососал глупый даун?'}, {'улетаешь со своего ванвея', 'хуесос'}, {'0 iq'},
    {'*DEAD* пофикси додик'}, {'сука не позорься и ливни лол'}, {'ёк макарек египетская сила как я зарядил тебе'}, {'устал улетать с первой пули?', 'не переживай, все получится'},
    {'1', 'спать чюрка'}, {'норм луа у тя в следующем раудне туда же прибегай в рот брать'},
    {'?', 'чюрбек ебаный куда летим'}, {'1', 'как на этот раз оправдаешься?'}, {'забайтилось тупое'}, {'1', 'грязная хуйня', 'сиди семечки грызи дальше'}, {'спи', 'моча ебаная'},
    {'депортирован в ад к матери шлюхе'}, {'yt bot'}, {'спи вечным сном'},
    {'упал', 'хуета ебаная'}, {'1', 'мать твою ебал'}, {'1 сын шлюхи'}, {'улетаеш в копилку мертвых сочников'}, {'иди приклей подорожник к ебальнику клоп ахахах'},
    {'ну какой же ты нищий'}, {'единицей свалился'}, {'Best and cheap configurations for gamesense, otc, and neverlose waiting for your order at ---> t.me/sceneworlds'}, {'1 байтнутый', 'дальше скарься меня тварь ебаная'}, {'AHHAHAHHAHAHH', '1 ДЕРЕВО ЕБАНОЕ'},
    {'куда ты пикаешь то', 'скряга ебаная'}, {'зарядил по кипятильнику'}, {'отлетаешь', 'сын бляди'},
    {'а гс сегодня ебет знатно'}, {'поймал в шляпу?'}, {'а читик сегодня бодро раздает'}, {'лови в пизду мразота'}, {'опять забайтилось мусор'},
    {'что ты делаешь?'}, {'опять умер?'}, {'оправдайся', 'почему ты опять умер'}, {'1 мразота'}, {'ХАХАХАХ ОТСОСАЛ ДАУН'},
    {'1', 'iq?'}, {'1 сочник'}, {'1', 'yt'}, {'ты просто нулячий дядь'}, {'1', 'пора ливать', 'чмошница'},
    {'понадеялся на удачу?'}, {'1 лапша ебаная'}, {'1', 'что ты делаешь тупой'}, {'1', 'ахахах', 'спать шлюшка'},
    {'1', 'куда ты пикаешь?'}, {'ахахах', 'опять умер'}, {'1', '*DEAD*'}, {'1', 'идиот ливай уже', 'хватит позориться'}, {'1', 'тупейший игрок'},
    {'1', 'легитная пробка'}, {'1', 'наивный ботик', 'куда пикаем'}, {'лови по чепчику мудло'},
    {'куда поехала сопля'}, {'1', 'ты че там уснул', 'червячок'}, {'а куда мы бежим то'}, {'куда бежиш червяк'}, {'nt'},
    {'пора ливать чмоня'}, {'1', 'тебе на сегодня не хватит сопля?'}, {'1', 'ахахах', 'ну почему ты такой глупый'}, {'пикнул?', 'сиди и наблюдай теперь чмо'}, {'зря ты так летишь', 'у тебя ноль шансов убить меня'},
    {'dont even try to kill me next time'}, {'1', 'скули'}, {'спокойной ночи', 'в сон отправил хаъахха'},
    {'спать узкий'}, {'е1'}, {'ой'}, {'бульк'}, {'ебать кого я шлепнул'}, {'ᴨоᴄᴛᴀʙиᴧ ᴛʙою чоᴛᴋоᴄᴛь ᴨод ᴄоʍнᴇниᴇ'},
    {'шляпку поймал'}, {'1', 'отзовись в чате', 'оправдайся почему забайтился'}, {'гори в аду'}, {'рычи'}, {'куда ты пикаешь', 'славик'},
    {'1', 'скули сука'}, {'ты куда побежал голубчик'}, {'и это игрок?'}, {'1'}, {'1'}, {'иди сюда', 'к папочке'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'}, {'бедыч не имеет и копейки чтобы оплатить себе relentless'},
    {'t1'}, {'е1'}, {'t1'}, {'е1'}, {'t1'}, {'сосай мою хуяку пока я играю с relentless'}, {'THIS IS LCCCCCCC (◣_◢)'},
    {'е1'}, {'t1'}, {'e1'}, {'1'}, {'1', '?'}, {'FUNERAL достает из кейса: ★ Мать этого бомжа'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', 'желейка хуявая)'}, {'ЙОУ ЙОУ ЙОУ БИЧИ, на колени.'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'слоумо позорное', 'очень медленный'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', 'вредитель'}, {'[etdfz gbljhfcbyf', 'хуевая пидорасина'},
    {'1', 'позорник', 'норм играешь'}, {'1', 'ну почему такие убивают меня'}, {'1', 'старайся', 'сильнее'}, {'е1', 'красава', 'и ты меня убил'}, {'1', 'затупок'},
    {'1', 'наигрался'}, {'1', 'лови патрон'}, {'е1'}, {'1', 'куда ты шлюха'}, {'1', 'спи'},
    {'1', 'допрыгался'}, {'1', 'закончилась мана'}, {'1', 'ливай позор'}, {'1', 'рычи'},
        },
        death = {
    {'я стрельнул?'}, {'фу'}, {'хуесос', 'пытайся дальше'}, {'опять чмо ебаное убивает'}, {'ну фу', 'что ты делаешь'},
    {'отмена', 'сын шлюхи'}, {'не ливай'}, {'тут роллы пашут?'}, {'ну фу', 'тебе повезло выблядок'}, {'щас поиграем клоун', 'ливнешь мать шалава здохнет'},
    {'не повезло'}, {'ну', 'что ты делаешь'}, {'сыну бляди же повезёт'}, {'без пота слабо хуйня?'}, {'да сука'},
    {'мразота потеет'}, {'нет', 'хуесос тупой'}, {'тупой', 'куда ты летишь идиот'}, {'что ты сделал', 'тупой даун', 'безмозглый'}, {'фу блять'},
    {'csy', 'сын шлюхи', 'тупой'}, {'не', 'этот сочник пикнет'}, {'ну', 'долбоеб сука', 'что ты делаешь мразь'}, {'пиздец', 'что с читом'}, {'сын шлюхи', '1х1 2х2 прямо щас?'},
    {'ну уебище', 'куда я не стреляю'}, {'ну как оно меня убивает', 'ну что это такое'}, {'изи мапа'}, {'подловила мразь'}, {'потная мразота'},
    {'csy ik.[b', 'сын бляди ебаной', 'потеет сидит'}, {'2х2 пошли', 'чмо ебаное дс кидай'}, {'на подпике', 'хуесосина'}, {'не радуйся пидорас'}, {',kznm', 'тупой долбаеб', 'реально', 'уебище'},
    {'ну конечно', 'я просто похлопаю тебе'}, {'ахахах', 'что ты нахуй делаешь'}, {'блядина', 'нахуй ты сидишь потеешь', 'выйти в кд грязь'}, {'не', 'как эьа хуйня убивает', 'это пиздец'}, {'хуя', 'норм бектрек'},
    {'пошли 1х1 сын блядоты', 'дс опрокинь свой'}, {'ебаная тварь', '2х2 прямо щас кидай дс свой'}, {'красава', 'лучший просто'}, {'ишак', 'куда ты так'}, {'нихуя ты меня шлепнул'},
    {'м', 'забавно'}, {'в глазах потемнело чуть'}, {'а хуль'}, {'уебище', 'сидит потеет'}, {'фу', 'ну он же байтится', 'и както убивает меня'},
    {'фу уебище ебаное'}, {'ебанат', 'фулл опен стоит'},
        },
        revenge = {
    {'1', 'вредитель'}, {'1', 'позорник', 'норм играешь'}, {'1', 'ну почему такие убивают меня'}, {'1', 'старайся', 'сильнее'}, {'е1', 'красава', 'и ты меня убил'},
    {'1', 'затупок'}, {'1', 'наигрался'}, {'1', 'лови патрон'}, {'е1'}, {'1', 'куда ты шлюха'},
    {'1', 'спи'}, {'1', 'допрыгался'}, {'1', 'закончилась мана'}, {'1'}, {'1'},
    {'1'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1', 'ливай позор'}, {'1', 'рычи'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'е1'}, {'t1'},
    {'1'}, {'1э'}, {'1\\'}, 
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', 'вредитель'},
    {'1', 'позорник', 'норм играешь'}, {'1', 'ну почему такие убивают меня'}, {'1', 'старайся', 'сильнее'}, {'е1', 'красава', 'и ты меня убил'}, {'1', 'затупок'},
    {'1', 'наигрался'}, {'1', 'лови патрон'}, {'е1'}, {'1', 'куда ты шлюха'}, {'1', 'спи'},
    {'1', 'допрыгался'}, {'1', 'закончилась мана'}, {'1', 'ливай позор'}, {'1', 'рычи'},AW
        }
    },
    relentless = {
        kill = {
{'zero chance to kill relentless.lua user *_*'}, {'Relentless.lua will always be ahead *all dogs owned*'}, {'ты без Relentless.lua чтоли?', 'не завидую'}, 
{'whatever you do, Relentless.lua do it better ^_^'}, {'видно ты без Relentless.lua сидишь, пора бы обновляться сосик)'}, {'сразу видно кфг иссуе мб конфиг у фунерала прикупишь ?'},
    {'не будь терпилой, переходи на темную сторону *RELENTLESS.lua vs all dogs*'}, {'THIS IS RELENTLESSS (◣_◢)'}, {'Loading cfg by funeral… ███████[][][] 77% #pizdavam'}, 
    {'relentless.lua > all world'}, {'ботяра, ты про relentless.lua слыхала?'}, {'relentless > all'}, {'натренированный ротик, сразу видно без релентлесса гамаеш)'}, 
    {'слишком сочный для Relentless.technologies'}, {'впенен ботик by Relentless.lua >_<'}, {'я играю на лайфхакерском конфиге by funeral (◣_◢)'},
    {'god bless no stress ты опущен by relentless хуесос'}, {'ты без Relentless.lua чтоли?', 'не завидую'}, {'Relentless.lua will always be ahead all dogs owned'},
    {'THIS IS RELENTLEEEEEEEESSSSSSSSSSS (◣_◢)'}, {'relentless.lua > all world'}, {'owned by relentless corporation'},
    {'ceo in moscow'}, {'в следующий раз заходи с relentless чтобы не позорится'}, {'луасенс не бустит - relentless поможет сын шалавы'},
    {'relentless > all'}, {'слишком сочный для Relentless-yaw'}, {'ты че мразота ? вздумал тягатся с relentless юзером?'},
    {'𝕘𝕖𝕥 𝕠𝕨𝕟𝕖𝕕 𝕓𝕪 𝕣𝕖𝕝𝕖𝕟𝕥𝕝𝕖𝕤𝕤.𝕝𝕦𝕒', '𝕓𝕖𝕤𝕥 𝕚𝕟 𝕥𝕙𝕖 𝕘𝕒𝕞𝕖'}, {'ℝ𝔼𝕃𝔼ℕ𝕋𝕃𝔼𝕊𝕊 𝕄𝔼𝕀ℕ 𝔾𝔸ℕ𝔾 𝕍𝕊 𝕋ℍ𝔼 𝕎𝕆ℝ𝕃𝔻'},
    {'впенен ботик by Relentless.lua >_<'}, {'▄︻̷̿┻̿═━一 лови пулю в ебало'}, {'переиграна 12 летка ебучая'},
    {'𝙉𝙄𝘾𝙀 𝙍𝙀𝙎𝙊𝙇𝙑𝙀𝙍 𝙃𝘼𝙃𝘼𝙃𝘼'}, {'ботяра, ты про relentless.lua слыхала?'}, {'₽вȁл гȫρтăнь Ŧвȫей ʍа₮еᎵน'},
    {'☆꧁✬◦°˚°◦. ɮʏ ɮɛֆȶ ʟʊǟ .◦°˚°◦✬꧂☆'}, {'big boss on this server'}, {'fuck osmanhook(?) all my homies love relentless (◣_◢)'},
    {'я играю на лайфхакерском конфиге by funeral (◣_◢)'}, {'♥ 𝙍𝙀𝙇𝙀𝙉𝙏𝙇𝙀𝙎𝙎 𝘼𝙉𝙏𝙄-𝘼𝙄𝙈𝘽𝙊𝙏 𝘼𝙉𝙂𝙇𝙀𝙎 ♥'},
    {'не будь терпилой, переходи на темную сторону *RELENTLESS.lua vs all dogs*'}, {'whatever you do, Relentless do it better ^_^'},
    {'тапочек хвх это ты?'}, {'stop wasting my time and buy relentless'}, {'draining ton rn cant reply'},
    {'¸.·✩·.¸¸.·¯⍣✩ relentless ✩⍣¯·.¸¸.·✩·.¸'}, {'опять слезы? умоляй моих дьяволов выдать тебе relentless'},
    {'ＤＲＩＰ ＳＰＬＡＳＨ ＯＮ ＭＹ ＮＥＣＫ >>> ＲＥＬＥＮＴＬＥＳＳ'}, {'pure dominance by relentless'}, {'refund your lua.'},
    {'get good.get relentless'}, {'𝕘𝕖𝕥 𝕥𝕒𝕡𝕡𝕖𝕕 𝕓𝕪 𝕣𝕖𝕝𝕖𝕟𝕥𝕝𝕖𝕤𝕤 𝕦𝕤𝕖𝕣', '𝕝𝕠𝕨 𝕚𝕢 𝕕𝕠𝕘'}, {'иди на хуй бот ебанный спи нахуй'},
    {'𝘚𝘪𝘭𝘦𝘯𝘵 𝘒𝘪𝘭𝘭𝘦𝘳 by relentless'}, {'#bless_relentless #ты_бомж #лети_нахуй'}, {'RUSSIA <3 Vladivostok'},
    {'godmode with relentless'}, {'𝖘𝖚𝖐𝖆 𝖘𝖔 𝖒𝖓𝖔𝖞 6𝖎𝖝𝖆 𝖘𝖚𝖐𝖆 𝖟𝖔𝖛𝖚 𝖊𝖌𝖔 𝖘𝖑𝖎𝖒𝖊'}, {'дно маркета пробито... (luasense)'},
    {'𝕤𝕥𝕠𝕡 𝕔𝕣𝕪𝕚𝕟𝕘, 𝕛𝕦𝕤𝕥 𝕓𝕦𝕪 𝕣𝕖𝕝𝕖𝕟𝕥𝕝𝕖𝕤𝕤'}, {'Loading cfg by funeral… ███████[][][] 77% #pizdavam'},
    {'𝐀𝐑𝐄 𝐘𝐎𝐔 𝐆𝐔𝐘𝐒 𝐒𝐀𝐖 𝐓𝐇𝐈𝐒 𝐍𝐈𝐆𝐆𝐀? ｒｅｌｅｎｔｌｅｓｓ- ᴛʜɪs ᴏᴘᴘs ᴄᴀɴᴛ ʜᴇᴀᴅsʜᴏᴛ ᴍᴇ (◣_◢'}, {'мы собрали коалицию и выехали узнать правда ли луасенс юзеры одержимы бесами или просто долбоёбы'},
    {'ᴀбонᴇнᴛ ʙᴩᴇʍᴇнно нᴇдоᴄᴛуᴨᴇн. ᴨоᴋᴀ!'}, {'ＲＥＬＥＮＴＬＥＳＳ ＷＩＬＬ ＢＥ ＡＬＷＡＹＳ ＡＨＥＡＤ'}, {'★★★ 𝔾𝕖𝕋 𝔾𝕠𝕠𝔻 ★★★'},
    {'why are u sweating? its just relentless'}, {'get tapped by relentless.lua'}, {'С Н О В А В Ы Ш Е Л П О Б Е Д И Т Е Л Е М'},
    {'too easy for relentless technology'}, {'𝕣𝕖𝕝𝕖𝕟𝕥𝕝𝕖𝕤𝕤 𝕣𝕖𝕝𝕖𝕒𝕤𝕖𝕕... 𝕓𝕖 𝕤𝕔𝕒𝕣𝕖..(◣◢)'}, {'𝕓𝕪𝕖 𝕓𝕪𝕖 𝕟𝕟 𝕕𝕠𝕘 (◣◢)'},
    {'𝕞𝕪 𝕣𝕖𝕝𝕚𝕘𝕚𝕠𝕟... 𝕣𝕖𝕝𝕖𝕟𝕥𝕝𝕖𝕤𝕤', '𝔸𝕤-𝕊𝕒𝕝𝕒𝕞𝕦 𝔸𝕝𝕒𝕚𝕜𝕦𝕞 𝕨𝕒 ℝ𝕒𝕙𝕞𝕒𝕥𝕦𝕝𝕝𝕒𝕙'}, {'stop missing already, just be like me and get relentless'}, {'сосал?', 'соври', 'не ври'},
    {'𝘳𝘦𝘭𝘦𝘯𝘵𝘭𝘦𝘴𝘴 - 𝘵𝘩𝘦 𝘮𝘰𝘴𝘵 𝘦𝘭𝘪𝘵𝘦 𝘴𝘤𝘳𝘪𝘱𝘵'}, {'слишком легко для relentless traditions'}, {'♛ 𝟓𝟎𝟎$ 𝐋𝐔𝐀 𝐉𝐈𝐓𝐓𝐄𝐑 𝐅𝐈𝐗? 𝐋𝐈𝐍𝐊 𝐈𝐍 𝐃𝐄𝐒𝐑𝐈𝐏𝐓𝐈𝐎𝐍'},
    {'ты че там без relentless сидиш чтоли?', 'не завидую'}, {'натренированный ротик, сразу видно без релентлесса гамаеш)'},
    {'once this game started 𝔂𝓸𝓾 𝓵𝓸𝓼𝓮𝓭 𝓪𝓵𝓻𝓮𝓭𝔂 #relentless'}, {'rock star lifestyle #RELENTLESS'},
    {'видно ты без relentless сидишь, пора бы обновляться сосик)'}, {'ȶʏ ʄօʀ ʍ2 ƈօʍքɨӼɨօռ աɨȶɦ ȶɦɛ քօքֆ ǟռɖ ȶɦɛ ɮǟռɢֆ ʄȶ 𝔯𝔢𝔩𝔢𝔫𝔱𝔩𝔢𝔰𝔰 𝓵𝓸𝓪'},
    {'zｚＺ', 'playing with relentless is so boooring'}, {'are you lagging, or just naturally slow?'}, {'忧郁[relentless]摧毁一切!'},
    {'1', 'игрок?'}, {'1', 'hs bot'}
        },
        death = {
                        {'я стрельнул?'}, {'фу'}, {'хуесос', 'пытайся дальше'}, {'опять чмо ебаное убивает'}, {'ну фу', 'что ты делаешь'},
    {'отмена', 'сын шлюхи'}, {'не ливай'}, {'тут роллы пашут?'}, {'ну фу', 'тебе повезло выблядок'}, {'щас поиграем клоун', 'ливнешь мать шалава здохнет'},
    {'не повезло'}, {'ну', 'что ты делаешь'}, {'сыну бляди же повезёт'}, {'без пота слабо хуйня?'}, {'да сука'},
    {'мразота потеет'}, {'нету', 'хуесос тупой'}, {'тупой', 'куда ты летишь идиот'}, {'что ты сделал', 'тупой даун', 'безмозглый'}, {'фу блять'},
    {'csy', 'сын шлюхи', 'тупой'}, {'не', 'этот сочник пикнет'}, {'ну', 'долбоеб сука', 'что ты делаешь мразь'}, {'пиздец', 'что с читом'}, {'сын шлюхи', '1х1 2х2 прямо щас?'},
    {'ну уебище', 'куда я не стреляю'}, {'ну как оно меня убивает', 'ну что это такое'}, {'изи мапа'}, {'подловила мразь'}, {'потная мразота'},
    {'csy ik.[b', 'сын бляди ебаной', 'потеет сидит'}, {'2х2 пошли', 'чмо ебаное дс кидай'}, {'на подпике', 'хуесосина'}, {'не радуйся пидорас'}, {',kznm', 'тупой долбаеб', 'реально', 'уебище'},
    {'ну конечно', 'я просто похлопаю тебе'}, {'ахахах', 'что ты нахуй делаешь'}, {'блядина', 'нахуй ты сидишь потеешь', 'выйти в кд грязь'}, {'не', 'как эьа хуйня убивает', 'это пиздец'}, {'хуя', 'норм бектрек'},
    {'пошли 1х1 сын блядоты', 'дс опрокинь свой'}, {'ебаная тварь', '2х2 прямо щас кидай дс свой'}, {'красава', 'лучший просто'}, {'ишак', 'куда ты так'}, {'нихуя ты меня шлепнул'},
    {'м', 'забавно'}, {'в глазах потемнело чуть'}, {'а хуль'}, {'уебище', 'сидит потеет'}, {'фу', 'ну он же байтится', 'и както убивает меня'},
    {'фу уебище ебаное'}, {'ебанат', 'фулл опен стоит'},
        },
        revenge = {
    {'1', 'вредитель'}, {'1', 'позорник', 'норм играешь'}, {'1', 'ну почему такие убивают меня'}, {'1', 'старайся', 'сильнее'}, {'е1', 'красава', 'и ты меня убил'},
    {'1', 'затупок'}, {'1', 'наигрался'}, {'1', 'лови патрон'}, {'е1'}, {'1', 'куда ты шлюха'},
    {'1', 'спи'}, {'1', 'допрыгался'}, {'1', 'закончилась мана'}, {'1'}, {'1'},
    {'1'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1', 'ливай позор'}, {'1', 'рычи'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1', '?'}, {'1', '?'},
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'1'}, {'1'},
    {'1'}, {'1'}, {'1'}, {'е1'}, {'t1'},
    {'1'}, {'1э'}, {'1\\'}, 
    {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', '?'}, {'1', 'вредитель'},
    {'1', 'позорник', 'норм играешь'}, {'1', 'ну почему такие убивают меня'}, {'1', 'старайся', 'сильнее'}, {'е1', 'красава', 'и ты меня убил'}, {'1', 'затупок'},
    {'1', 'наигрался'}, {'1', 'лови патрон'}, {'е1'}, {'1', 'куда ты шлюха'}, {'1', 'спи'},
    {'1', 'допрыгался'}, {'1', 'закончилась мана'}, {'1', 'ливай позор'}, {'1', 'рычи'},
        }
    }
}

local trashtalk_counter = 0
local revenge_target = -1

local function contains_value(tbl, val)
    for i = 1, #tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end

client.set_event_callback('player_death', function(e)
    if not menu.misc.killsay:get() then return end
    
    local me = entity.get_local_player()
    if not me then return end
    
    local victim = client.userid_to_entindex(e.userid)
    local attacker = client.userid_to_entindex(e.attacker)
    
    if not victim or not attacker then return end
    
    local mode = menu.misc.killsay_mode:get()
    local selected = menu.misc.killsay_select:get() or {}
    local phrase_set = mode == "Relentless" and trashtalk_phrases.relentless or trashtalk_phrases.bait
    
    local is_revenge_enabled = contains_value(selected, "Revenge")
    local is_kill_enabled = contains_value(selected, "On kill")
    local is_death_enabled = contains_value(selected, "On death")
    
    local function process_phrases(list)
        if not list or #list == 0 then return end
        
        local phrases = list[math.random(1, #list)]
        trashtalk_counter = trashtalk_counter + 1
        local current_counter = trashtalk_counter
        
        local base_delay = 1.5
        
        for i = 1, #phrases do
            local phrase = phrases[i]
            local delay = base_delay + (i * 1.5)
            
            client.delay_call(delay, function()
                if trashtalk_counter == current_counter then
                    client.exec('say ' .. phrase)
                end
            end)
        end
    end
    
    -- Check if our revenge target was killed
    if is_revenge_enabled and revenge_target == victim and entity.is_enemy(victim) then
        process_phrases(phrase_set.revenge)
        revenge_target = -1
        return
    end
    
    -- We killed someone
    if attacker == me and victim ~= me and entity.is_enemy(victim) then
        if is_kill_enabled then
            process_phrases(phrase_set.kill)
        end
    end
    
    -- We died
    if victim == me and attacker ~= me and entity.is_enemy(attacker) then
        if is_death_enabled then
            process_phrases(phrase_set.death)
        end
        
        if is_revenge_enabled then
            revenge_target = attacker
        end
    end
end)

client.set_event_callback("round_start", function()
    revenge_target = -1
end)

  local function custom_scope()
        if not menu.visuals.custom_scope:get() then return end
    
        local lp = entity.get_local_player()
        if lp == nil or not entity.is_alive(lp) then return end
        local screen_x, screen_y = client.screen_size()
    
        ui.set(ref.scope_overlay, false)
    
        local scoped = entity.get_prop(lp, "m_bIsScoped") == 1
        if not scoped then return end
    
        local scope_r, scope_g, scope_b = menu.visuals.custom_scope_color_picker:get()
    
        local gap = menu.visuals.custom_scope_overlay_position:get()
        local size = menu.visuals.custom_scope_overlay_offset:get()
    
        renderer.gradient(screen_x / 2, screen_y / 2 + gap, 1, size, scope_r, scope_g, scope_b, 255, 0, 0, 0, 0, false)
        renderer.gradient(screen_x / 2, screen_y / 2 - gap, 1, -size, scope_r, scope_g, scope_b, 255, 0, 0, 0, 0, false)
    
        renderer.gradient(screen_x / 2 + gap, screen_y / 2, size, 1, scope_r, scope_g, scope_b, 255, 0, 0, 0, 0, true)
        renderer.gradient(screen_x / 2 - gap, screen_y / 2, -size, 1, scope_r, scope_g, scope_b, 255, 0, 0, 0, 0, true)
    end

local function watermark()
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then return end

    local steamid = entity.get_steam64(lp)
    local steam_avatar = images.get_steam_avatar(steamid)
    local screensize_x, screensize_y = client.screen_size()
    local center_y = screensize_y * 0.5
    local avatar_size = 32

    local watermark_type = menu.visuals.watermark_mode:get()
    local r, g, b, a = menu.visuals.watermark_color:get()

    if watermark_type == "Modern" then
        local text1 = "RELENTLESS.LUA"
        local username = string.upper(relentless_data.name)
        local build_label = "[DEV]"

        local picker1 = helpers.create_color_array(r, g, b, text1)
        local picker2 = helpers.create_color_array(r, g, b, build_label)

        local animated1, animated_build = "", ""
        for i = 1, #text1 do
            local char = text1:sub(i, i)
            local color = helpers.rgba_to_hex(unpack(picker1[i]))
            animated1 = animated1 .. string.format("\a%s%s", color, char)
        end

        for i = 1, #build_label do
            local char = build_label:sub(i, i)
            local color = helpers.rgba_to_hex(unpack(picker2[i]))
            animated_build = animated_build .. string.format("\a%s%s", color, char)
        end

        local text2 = "USER - " .. username .. "   " .. animated_build

        steam_avatar:draw(11, center_y - 16, avatar_size, avatar_size, 255, 255, 255, 255)
        renderer.text(50, center_y - 10, 255, 255, 255, 255, "-", 0, animated1)
        renderer.text(50, center_y + 1, 255, 255, 255, 255, "-", 0, text2)

    elseif watermark_type == "Default" then
        local text = "relentless.lua"
        local picker = helpers.create_color_array(r, g, b, text)

        local animated = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local color = helpers.rgba_to_hex(unpack(picker[i]))
            animated = animated .. string.format("\a%s%s", color, char)
        end

        renderer.text(screensize_x / 2, screensize_y - 10, 255, 255, 255, 255, "cb", 0, animated)
elseif watermark_type == "Custom" then
    local text = menu.visuals.watermark_text:get()
    if text == nil or text == "" then
        text = "relentless.lua"
    end

    local alpha = a or 255
    local get_font = menu.visuals.watermark_font:get()
    local font = 'c'
    if get_font == 1 then
        font = 'c'
    elseif get_font == 2 then
        font = 'cb'
    elseif get_font == 3 then
        font = "c-"   
    end

    local r, g, b = menu.visuals.watermark_color:get()
    local c_x, c_y = screensize_x / 2, screensize_y - 10
    local get_position = menu.visuals.watermark_position:get()
    if get_position == 1 then -- Left
        c_x, c_y = 69, screensize_y / 2
    elseif get_position == 2 then -- Right
        c_x, c_y = screensize_x - 69, screensize_y / 2
    elseif get_position == 3 then -- Down
        c_x, c_y = screensize_x / 2, screensize_y - 10
    elseif get_position == 4 then -- Centered
        c_x, c_y = screensize_x / 2, screensize_y / 2
    end

    local prefix = menu.visuals.watermark_prefix:get()
    local suffix = ""
    if prefix ~= nil and prefix ~= "" and prefix ~= "" then
        suffix = ' \afa5757FF' .. prefix .. ''
    end

    if menu.visuals.watermark_gradient:get() == 2 then
        local r2, g2, b2, a2 = 55, 55, 55, 255 
        local highlight_fraction = (globals.realtime() / 2 % 1.2 * 2) - 1.2
        local output = ""
        for idx = 1, #text do
            local character = text:sub(idx, idx)
            local character_fraction = idx / #text
            local r1, g1, b1, a1 = menu.visuals.watermark_color:get()
            local highlight_delta = (character_fraction - highlight_fraction)
            if highlight_delta >= 0 and highlight_delta <= 1.4 then
                if highlight_delta > 0.7 then
                    highlight_delta = 1.4 - highlight_delta
                end
                local r_fraction, g_fraction, b_fraction = r2 - r1, g2 - g1, b2 - b1
                r1 = r1 + r_fraction * highlight_delta / 0.8
                g1 = g1 + g_fraction * highlight_delta / 0.8
                b1 = b1 + b_fraction * highlight_delta / 0.8
            end
            output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, alpha, character)
        end
        renderer.text(c_x, c_y, r, g, b, alpha, font, 0, output .. suffix)
    else
        renderer.text(c_x, c_y, r, g, b, alpha, font, 0, text .. suffix)
    end
end
end


http.get('https://raw.githubusercontent.com/PhantomHunter3/papulik/main/5c239dfd24215.jpg', function(s, r)
    if s and r.status == 200 then
        logo = images.load(r.body)
    else
        print("Failed to load image. Status:", r.status)
    end
end)


client.set_event_callback("paint", function()
end)


local bullet_tracer = {}

local function bullet_line_help(e)
    if not menu.visuals.bullet_line:get() then
        return
    end
    if client.userid_to_entindex(e.userid) ~= entity.get_local_player() then
        return
    end
    local lx, ly, lz = client.eye_position()
    bullet_tracer[globals.tickcount()] = {lx, ly, lz, e.x, e.y, e.z, globals.curtime() + 2}
end

local speed = 0
local speed_1 = 0
function bullet_line()
    if not menu.visuals.bullet_line:get() then
        return
    end
    local main_r, main_g, main_b, main_a =  menu.visuals.bullet_line_color:get()
    for tick, data in pairs(bullet_tracer) do
        if globals.curtime() <= data[7] then
            speed = main_a
            local x1, y1 = renderer.world_to_screen(data[1], data[2], data[3])
            local x2, y2 = renderer.world_to_screen(data[4], data[5], data[6])
            if x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil then
                renderer.line(x1, y1, x2, y2, main_r, main_g, main_b, speed)
            end
        else
            speed = clamp(speed - globals.frametime() * 500, 0, main_a)
            local x1, y1 = renderer.world_to_screen(data[1], data[2], data[3])
            local x2, y2 = renderer.world_to_screen(data[4], data[5], data[6])
            if x1 ~= nil and x2 ~= nil and y1 ~= nil and y2 ~= nil then
                renderer.line(x1, y1, x2, y2, main_r, main_g, main_b, speed)
            end
            if speed == 0 then
                bullet_tracer = {}
            end
        end
    end
end




renderer.rounded_rectangle = function(x, y, w, h, r, g, b, a, radius)
    y = y + radius
    local data_circle = {
        {x + radius, y, 180},
        {x + w - radius, y, 90},
        {x + radius, y + h - radius * 2, 270},
        {x + w - radius, y + h - radius * 2, 0},
    }

    local data = {
        {x + radius, y, w - radius * 2, h - radius * 2},
        {x + radius, y - radius, w - radius * 2, radius},
        {x + radius, y + h - radius * 2, w - radius * 2, radius},
        {x, y, radius, h - radius * 2},
        {x + w - radius, y, radius, h - radius * 2},
    }

    for _, data in next, data_circle do
        renderer.circle(data[1], data[2], r, g, b, a, radius, data[3], 0.25)
    end

    for _, data in next, data do
        renderer.rectangle(data[1], data[2], data[3], data[4], r, g, b, a)
    end
end

math.max_lerp_low_fps = (1 / 45) * 100
math.lerp = LPH_NO_VIRTUALIZE(function(start, end_pos, time)
    if start == end_pos then return end_pos end
    local frametime = globals.frametime() * 170
    time = time * math.min(frametime, math.max_lerp_low_fps)
    local val = start + (end_pos - start) * globals.frametime() * time
    return math.abs(val - end_pos) < 0.01 and end_pos or val
end)

local motion = { base_speed = 0.095, _list = {} }
motion.new = LPH_NO_VIRTUALIZE(function(name, new_value, speed, init)
    speed = speed or motion.base_speed
    motion._list[name] = motion._list[name] or (init or 0)
    motion._list[name] = math.lerp(motion._list[name], new_value, speed)
    return motion._list[name]
end)

local vel_position = { x = 0, y = 0 }
local dragging_velocity = false
local drag_offset = { x = 0, y = 0 }

local function intersect(x, y, width, height)
    local cx, cy = ui.mouse_position()
    return cx >= x and cx <= x + width and cy >= y and cy <= y + height
end

local function velocity_ind()
    if not menu.visuals.velocity_indicator:get() then return end

    local screen_w, screen_h = client.screen_size()
    local center_x = screen_w / 2
    local base_y_text = screen_h / 4 + 50
    local base_y_bar = screen_h / 4 + 60

    local lp = entity.get_local_player()
    if not lp then return end

    local r, g, b, a = menu.visuals.velocity_color:get()
    local vel_mod = entity.get_prop(lp, 'm_flVelocityModifier')

    if not ui.is_menu_open() then
        velocity_alpha = motion.new("velocity_alpha", vel_mod < 1 and 255 or 0, 10)
        velocity_amount = motion.new("velocity_amount", vel_mod, 10)
    else
        velocity_alpha = motion.new("velocity_alpha", 255, 10)
        velocity_amount = motion.new("velocity_amount", (globals.tickcount() % 50) / 100 * 2, 10)
    end

    if velocity_alpha <= 0 then return end

    local box_w, box_h = 100, 40

    if not vel_position then
        vel_position = { x = 0, y = 0 }
        drag_offset = { x = 0, y = 0 }
        dragging_velocity = false
    end

    local mouse_x, mouse_y = ui.mouse_position()

    local drag_x = center_x - 50 + vel_position.x
    local drag_y = base_y_bar + vel_position.y

    if client.key_state(0x01) then
        if not dragging_velocity and intersect(mouse_x, mouse_y, drag_x, drag_y, box_w, box_h) then
            dragging_velocity = true
            drag_offset.x = mouse_x - drag_x
            drag_offset.y = mouse_y - drag_y
        end
    else
        dragging_velocity = false
    end

    if dragging_velocity then
        vel_position.x = mouse_x - drag_offset.x - (center_x - 50)
        vel_position.y = mouse_y - drag_offset.y - base_y_bar
    end

    local draw_x = center_x + vel_position.x
    local draw_y_text = base_y_text + vel_position.y
    local draw_y_bar = base_y_bar + vel_position.y

    renderer.text(draw_x, draw_y_text, 255, 255, 255, velocity_alpha, "c", 0, "- velocity -")
    renderer.rectangle(draw_x - 50, draw_y_bar, 100, 5, 0, 0, 0, velocity_alpha)
    renderer.rectangle(draw_x - 50, draw_y_bar + 1, (100 * velocity_amount) - 1, 3, r, g, b, velocity_alpha)
end

-- Manual Arrows
local manual_arrows_alpha = 0
local manual_arrows_add_y = 0

local function manual_arrows()
    if not menu.visuals.manual_arrows:get() then 
        manual_arrows_alpha = 0
        return 
    end
    
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then 
        manual_arrows_alpha = 0
        return 
    end
    
    local style = menu.visuals.manual_arrows_style:get()
    local tweaks = menu.visuals.manual_arrows_tweaks:get()
    local scoped = entity.get_prop(lp, "m_bIsScoped") == 1
    
    -- Arrow symbols based on style
    local arrows_left = style == "Modern" and "◄" or style == "Modern v2" and "<<" or "◀"
    local arrows_right = style == "Modern" and "►" or style == "Modern v2" and ">>" or "▶"
    
    local screen_x, screen_y = client.screen_size()
    local base_offset = style == "Modern v2" and 16 or 18
    
    -- Smooth alpha transition
    local target_alpha = manuals == 0 and 0 or 255
    manual_arrows_alpha = manual_arrows_alpha + (target_alpha - manual_arrows_alpha) * globals.frametime() * 12
    
    if manual_arrows_alpha < 2 then return end
    
    -- Height adjustment for scope
    local target_add_y = 0
    if tweaks and tweaks["Adjust height position"] then
        target_add_y = scoped and 15 or 0
    end
    manual_arrows_add_y = manual_arrows_add_y + (target_add_y - manual_arrows_add_y) * globals.frametime() * 12
    
    -- Get colors
    local r, g, b, a = menu.visuals.manual_arrows_color:get()
    
    -- Alpha scale for scope transparency
    local alpha_scale = 1
    if tweaks and tweaks["Scope transparency"] and scoped then
        alpha_scale = 0.5
    end
    
    -- Determine active arrows
    local active_left = manuals == 1
    local active_right = manuals == 2
    local active_alpha = math.floor(manual_arrows_alpha * alpha_scale + 0.5)
    local inactive_alpha = math.floor(manual_arrows_alpha * alpha_scale * 0.55 + 0.5)
    
    local center_x = screen_x / 2
    local center_y = screen_y / 2 - base_offset - manual_arrows_add_y
    local gap = style == "Modern v2" and 50 or 45
    
    -- Set colors based on active state
    local left_r, left_g, left_b, left_a = 255, 255, 255, inactive_alpha
    local right_r, right_g, right_b, right_a = 255, 255, 255, inactive_alpha
    
    if active_left then
        left_r, left_g, left_b, left_a = r, g, b, active_alpha
    end
    if active_right then
        right_r, right_g, right_b, right_a = r, g, b, active_alpha
    end
    
    -- Render arrows
    local measure_left = renderer.measure_text("+", arrows_left)
    renderer.text(center_x - measure_left - gap, center_y, left_r, left_g, left_b, left_a, "+-", 0, arrows_left)
    renderer.text(center_x + gap, center_y, right_r, right_g, right_b, right_a, "+-", 0, arrows_right)
end


local timer = globals.tickcount()
local scriptleakstop = 14

 local function unsafe_dt()
    if menu.misc.unsafe_recharge:get() then
    local lp = entity.get_local_player()
    if not entity.is_alive(lp) then return end
    local lp_weapon = entity.get_player_weapon(lp)
    if not lp_weapon then return end
    scriptleakstop = weapons(lp_weapon).is_revolver and 17 or 14
    if ui.get(ref.dt[2]) or ui.get(ref.hs[2]) then
                if globals.tickcount() >= timer + scriptleakstop then
                    ui.set(ref.aimbot, true)
                else
                    ui.set(ref.aimbot, false)
                end
            else
                timer = globals.tickcount()
                ui.set(ref.aimbot, true)
            end
        end
    end


local cfg_system = { }
do
    cfg_system.db = "kennex_mojet_ne_prosnutsa"

    local package, data, encrypted, decrypted = pui.setup({ menu, builder }), "", "", ""

    configs_db = database.read(cfg_system.db) or { }
    configs_db.cfg_list = configs_db.cfg_list or {{'Default', 'W3sic29jaWFsX2xpbmtzIjp7ImxpbmtzIjozfSwibWFpbiI6eyJjdXJyZW50X3RhYiI6M30sImhvdGtleXMiOnsiZnJlZXN0YW5kaW5nX3lhdyI6WzEsMTgsIn4iXSwibWFudWFsX2xlZnQiOlsxLDkwLCJ+Il0sIm1hbnVhbF9yaWdodCI6WzEsODgsIn4iXSwibWFudWFsX2ZvcndhcmQiOlsxLDc0LCJ+Il19LCJtaXNjIjp7ImZhc3RfbGFkZGVyIjp0cnVlLCJ1bnNhZmVfcmVjaGFyZ2UiOnRydWV9LCJhbnRpYWltIjp7ImFudGlhaW1fc2VsZWN0IjoiXHUwMDBiU3RhbmRcciJ9LCJjb25maWdzIjp7Imxpc3R0dCI6MX0sIm90aGVyIjp7ImF2b2lkX2JhY2tzdGFiX2Ftb3VudCI6MjQwLCJzYWZlX2hlYWQiOnRydWUsImF2b2lkX2JhY2tzdGFiIjp0cnVlLCJzYWZlX2hlYWRfc2VsZWN0IjpbIlpldXMiLCJ+Il19LCJ2aXN1YWxzIjp7ImNvbnNvbGVfZmlsdGVyIjp0cnVlLCJ3YXRlcm1hcmtfY29sb3IiOiIjQkQ2MEI1RkYiLCJ3YXRlcm1hcmtfbW9kZSI6IkN1c3RvbSIsInJhZ2Vib3RfaGl0IjoiIzc0QkQ2MEZGIiwid2F0ZXJtYXJrX3RleHQiOiJjaGVhdCByZXZlYWxlci5sdWEiLCJyYWdlYm90X21pc3MiOiIjQkQ2MzYwRkYiLCJhaW1ib3RfbG9nZ2VyIjp0cnVlfX0sW3sieWF3X3R5cGUiOjEsInlhd19kZWxheV9uZXdfNiI6MSwiYm9keV95YXciOiJPZmYiLCJ5YXdfZGVsYXlfbWF4IjoxLCJ5YXdfZGVsYXlfbmV3XzkiOjEsInlhd19kZWxheV9uZXdfMiI6MSwieWF3X3JhbmRvbSI6MCwibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjEsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOmZhbHNlLCJ5YXdfZGVsYXlfbWluIjoxLCJ5YXdfZGVsYXlfbmV3XzgiOjEsInlhd19kZWxheV9uZXdfNCI6MSwiYm9keV9hbW91bnQiOjAsInlhd19kZWxheV9uZXdfMSI6MSwieWF3X2RlbGF5X25ld18zIjoxLCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOmZhbHNlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOjAsInlhd19yaWdodCI6MCwieWF3X2RlbGF5X25ld18xMCI6MX0seyJ5YXdfdHlwZSI6MiwieWF3X2RlbGF5X25ld182IjoxLCJib2R5X3lhdyI6IkppdHRlciIsInlhd19kZWxheV9tYXgiOjgsInlhd19kZWxheV9uZXdfOSI6MSwieWF3X2RlbGF5X25ld18yIjoxLCJ5YXdfcmFuZG9tIjoxMSwibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjgsInlhd19kZWxheV9uZXdfOCI6MSwieWF3X2RlbGF5X25ld180IjoxLCJib2R5X2Ftb3VudCI6LTEsInlhd19kZWxheV9uZXdfMSI6MSwieWF3X2RlbGF5X25ld18zIjoxLCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOmZhbHNlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOi0xNywieWF3X3JpZ2h0IjozNywieWF3X2RlbGF5X25ld18xMCI6MX0seyJ5YXdfdHlwZSI6MiwieWF3X2RlbGF5X25ld182IjoxLCJib2R5X3lhdyI6IkppdHRlciIsInlhd19kZWxheV9tYXgiOjgsInlhd19kZWxheV9uZXdfOSI6MSwieWF3X2RlbGF5X25ld18yIjoxLCJ5YXdfcmFuZG9tIjoxNSwibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjgsInlhd19kZWxheV9uZXdfOCI6MSwieWF3X2RlbGF5X25ld180IjoxLCJib2R5X2Ftb3VudCI6LTEsInlhd19kZWxheV9uZXdfMSI6MSwieWF3X2RlbGF5X25ld18zIjoxLCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOnRydWUsInlhd19kZWxheV9kZWZhdWx0Ijo0LCJ5YXdfbGVmdCI6LTIzLCJ5YXdfcmlnaHQiOjQzLCJ5YXdfZGVsYXlfbmV3XzEwIjoxfSx7Inlhd190eXBlIjoyLCJ5YXdfZGVsYXlfbmV3XzYiOjEsImJvZHlfeWF3IjoiSml0dGVyIiwieWF3X2RlbGF5X21heCI6MTIsInlhd19kZWxheV9uZXdfOSI6MSwieWF3X2RlbGF5X25ld18yIjoxLCJ5YXdfcmFuZG9tIjoxMywibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjEyLCJ5YXdfZGVsYXlfbmV3XzgiOjEsInlhd19kZWxheV9uZXdfNCI6MSwiYm9keV9hbW91bnQiOi0xLCJ5YXdfZGVsYXlfbmV3XzEiOjEsInlhd19kZWxheV9uZXdfMyI6MSwibW9kaWZpZXJfdHlwZSI6Ik9mZiIsImZvcmNlX2xjIjpmYWxzZSwieWF3X2RlbGF5X2RlZmF1bHQiOjQsInlhd19sZWZ0IjotMjgsInlhd19yaWdodCI6MzYsInlhd19kZWxheV9uZXdfMTAiOjF9LHsieWF3X3R5cGUiOjIsInlhd19kZWxheV9uZXdfNiI6MywiYm9keV95YXciOiJKaXR0ZXIiLCJ5YXdfZGVsYXlfbWF4IjoxMiwieWF3X2RlbGF5X25ld185IjoxMywieWF3X2RlbGF5X25ld18yIjoxMCwieWF3X3JhbmRvbSI6MTEsIm1vZGlmaWVyX3R5cGVfcmFuZG9taXplIjo1LCJzd2l0Y2hfY2hhbmNlIjoxLCJtb2RpZmllcl90eXBlX29mZnNldCI6NSwieWF3X2RlbGF5X25ld181Ijo1LCJkZWxheV90eXBlIjozLCJ5YXdfZGVsYXlfbmV3XzciOjEyLCJzdGF0ZSI6dHJ1ZSwieWF3X2RlbGF5X21pbiI6MTIsInlhd19kZWxheV9uZXdfOCI6MTUsInlhd19kZWxheV9uZXdfNCI6NSwiYm9keV9hbW91bnQiOi0xLCJ5YXdfZGVsYXlfbmV3XzEiOjksInlhd19kZWxheV9uZXdfMyI6OSwibW9kaWZpZXJfdHlwZSI6Ik9mZiIsImZvcmNlX2xjIjp0cnVlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOi0xNywieWF3X3JpZ2h0IjozOCwieWF3X2RlbGF5X25ld18xMCI6MTl9LHsieWF3X3R5cGUiOjIsInlhd19kZWxheV9uZXdfNiI6MTUsImJvZHlfeWF3IjoiSml0dGVyIiwieWF3X2RlbGF5X21heCI6MTIsInlhd19kZWxheV9uZXdfOSI6MTgsInlhd19kZWxheV9uZXdfMiI6MTMsInlhd19yYW5kb20iOjExLCJtb2RpZmllcl90eXBlX3JhbmRvbWl6ZSI6MCwic3dpdGNoX2NoYW5jZSI6NywibW9kaWZpZXJfdHlwZV9vZmZzZXQiOjAsInlhd19kZWxheV9uZXdfNSI6MTAsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6NCwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjEyLCJ5YXdfZGVsYXlfbmV3XzgiOjYsInlhd19kZWxheV9uZXdfNCI6MjUsImJvZHlfYW1vdW50IjotMSwieWF3X2RlbGF5X25ld18xIjo4LCJ5YXdfZGVsYXlfbmV3XzMiOjE3LCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOnRydWUsInlhd19kZWxheV9kZWZhdWx0Ijo0LCJ5YXdfbGVmdCI6LTI1LCJ5YXdfcmlnaHQiOjM5LCJ5YXdfZGVsYXlfbmV3XzEwIjo3fSx7Inlhd190eXBlIjoyLCJ5YXdfZGVsYXlfbmV3XzYiOjEsImJvZHlfeWF3IjoiSml0dGVyIiwieWF3X2RlbGF5X21heCI6NywieWF3X2RlbGF5X25ld185IjoxLCJ5YXdfZGVsYXlfbmV3XzIiOjEsInlhd19yYW5kb20iOjEyLCJtb2RpZmllcl90eXBlX3JhbmRvbWl6ZSI6MSwic3dpdGNoX2NoYW5jZSI6MSwibW9kaWZpZXJfdHlwZV9vZmZzZXQiOjEsInlhd19kZWxheV9uZXdfNSI6MSwiZGVsYXlfdHlwZSI6MywieWF3X2RlbGF5X25ld183IjoxLCJzdGF0ZSI6dHJ1ZSwieWF3X2RlbGF5X21pbiI6NywieWF3X2RlbGF5X25ld184IjoxLCJ5YXdfZGVsYXlfbmV3XzQiOjEsImJvZHlfYW1vdW50IjotMSwieWF3X2RlbGF5X25ld18xIjoxLCJ5YXdfZGVsYXlfbmV3XzMiOjEsIm1vZGlmaWVyX3R5cGUiOiJPZmZzZXQiLCJmb3JjZV9sYyI6dHJ1ZSwieWF3X2RlbGF5X2RlZmF1bHQiOjQsInlhd19sZWZ0IjotMjIsInlhd19yaWdodCI6NDMsInlhd19kZWxheV9uZXdfMTAiOjF9LHsieWF3X3R5cGUiOjIsInlhd19kZWxheV9uZXdfNiI6MSwiYm9keV95YXciOiJKaXR0ZXIiLCJ5YXdfZGVsYXlfbWF4Ijo3LCJ5YXdfZGVsYXlfbmV3XzkiOjEsInlhd19kZWxheV9uZXdfMiI6MSwieWF3X3JhbmRvbSI6MTEsIm1vZGlmaWVyX3R5cGVfcmFuZG9taXplIjowLCJzd2l0Y2hfY2hhbmNlIjoxLCJtb2RpZmllcl90eXBlX29mZnNldCI6MCwieWF3X2RlbGF5X25ld181IjoxLCJkZWxheV90eXBlIjozLCJ5YXdfZGVsYXlfbmV3XzciOjEsInN0YXRlIjp0cnVlLCJ5YXdfZGVsYXlfbWluIjo3LCJ5YXdfZGVsYXlfbmV3XzgiOjEsInlhd19kZWxheV9uZXdfNCI6MSwiYm9keV9hbW91bnQiOi0xLCJ5YXdfZGVsYXlfbmV3XzEiOjEsInlhd19kZWxheV9uZXdfMyI6MSwibW9kaWZpZXJfdHlwZSI6Ik9mZiIsImZvcmNlX2xjIjp0cnVlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOi0xNSwieWF3X3JpZ2h0Ijo0MSwieWF3X2RlbGF5X25ld18xMCI6MX1dXQ=='}}
    configs_db.menu_list = configs_db.menu_list or {'Default'}
    configs_db.cfg_list[1][2] = "W3sic29jaWFsX2xpbmtzIjp7ImxpbmtzIjozfSwibWFpbiI6eyJjdXJyZW50X3RhYiI6M30sImhvdGtleXMiOnsiZnJlZXN0YW5kaW5nX3lhdyI6WzEsMTgsIn4iXSwibWFudWFsX2xlZnQiOlsxLDkwLCJ+Il0sIm1hbnVhbF9yaWdodCI6WzEsODgsIn4iXSwibWFudWFsX2ZvcndhcmQiOlsxLDc0LCJ+Il19LCJtaXNjIjp7ImZhc3RfbGFkZGVyIjp0cnVlLCJ1bnNhZmVfcmVjaGFyZ2UiOnRydWV9LCJhbnRpYWltIjp7ImFudGlhaW1fc2VsZWN0IjoiXHUwMDBiU3RhbmRcciJ9LCJjb25maWdzIjp7Imxpc3R0dCI6MX0sIm90aGVyIjp7ImF2b2lkX2JhY2tzdGFiX2Ftb3VudCI6MjQwLCJzYWZlX2hlYWQiOnRydWUsImF2b2lkX2JhY2tzdGFiIjp0cnVlLCJzYWZlX2hlYWRfc2VsZWN0IjpbIlpldXMiLCJ+Il19LCJ2aXN1YWxzIjp7ImNvbnNvbGVfZmlsdGVyIjp0cnVlLCJ3YXRlcm1hcmtfY29sb3IiOiIjQkQ2MEI1RkYiLCJ3YXRlcm1hcmtfbW9kZSI6IkN1c3RvbSIsInJhZ2Vib3RfaGl0IjoiIzc0QkQ2MEZGIiwid2F0ZXJtYXJrX3RleHQiOiJjaGVhdCByZXZlYWxlci5sdWEiLCJyYWdlYm90X21pc3MiOiIjQkQ2MzYwRkYiLCJhaW1ib3RfbG9nZ2VyIjp0cnVlfX0sW3sieWF3X3R5cGUiOjEsInlhd19kZWxheV9uZXdfNiI6MSwiYm9keV95YXciOiJPZmYiLCJ5YXdfZGVsYXlfbWF4IjoxLCJ5YXdfZGVsYXlfbmV3XzkiOjEsInlhd19kZWxheV9uZXdfMiI6MSwieWF3X3JhbmRvbSI6MCwibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjEsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOmZhbHNlLCJ5YXdfZGVsYXlfbWluIjoxLCJ5YXdfZGVsYXlfbmV3XzgiOjEsInlhd19kZWxheV9uZXdfNCI6MSwiYm9keV9hbW91bnQiOjAsInlhd19kZWxheV9uZXdfMSI6MSwieWF3X2RlbGF5X25ld18zIjoxLCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOmZhbHNlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOjAsInlhd19yaWdodCI6MCwieWF3X2RlbGF5X25ld18xMCI6MX0seyJ5YXdfdHlwZSI6MiwieWF3X2RlbGF5X25ld182IjoxLCJib2R5X3lhdyI6IkppdHRlciIsInlhd19kZWxheV9tYXgiOjgsInlhd19kZWxheV9uZXdfOSI6MSwieWF3X2RlbGF5X25ld18yIjoxLCJ5YXdfcmFuZG9tIjoxMSwibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjgsInlhd19kZWxheV9uZXdfOCI6MSwieWF3X2RlbGF5X25ld180IjoxLCJib2R5X2Ftb3VudCI6LTEsInlhd19kZWxheV9uZXdfMSI6MSwieWF3X2RlbGF5X25ld18zIjoxLCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOmZhbHNlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOi0xNywieWF3X3JpZ2h0IjozNywieWF3X2RlbGF5X25ld18xMCI6MX0seyJ5YXdfdHlwZSI6MiwieWF3X2RlbGF5X25ld182IjoxLCJib2R5X3lhdyI6IkppdHRlciIsInlhd19kZWxheV9tYXgiOjgsInlhd19kZWxheV9uZXdfOSI6MSwieWF3X2RlbGF5X25ld18yIjoxLCJ5YXdfcmFuZG9tIjoxNSwibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjgsInlhd19kZWxheV9uZXdfOCI6MSwieWF3X2RlbGF5X25ld180IjoxLCJib2R5X2Ftb3VudCI6LTEsInlhd19kZWxheV9uZXdfMSI6MSwieWF3X2RlbGF5X25ld18zIjoxLCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOnRydWUsInlhd19kZWxheV9kZWZhdWx0Ijo0LCJ5YXdfbGVmdCI6LTIzLCJ5YXdfcmlnaHQiOjQzLCJ5YXdfZGVsYXlfbmV3XzEwIjoxfSx7Inlhd190eXBlIjoyLCJ5YXdfZGVsYXlfbmV3XzYiOjEsImJvZHlfeWF3IjoiSml0dGVyIiwieWF3X2RlbGF5X21heCI6MTIsInlhd19kZWxheV9uZXdfOSI6MSwieWF3X2RlbGF5X25ld18yIjoxLCJ5YXdfcmFuZG9tIjoxMywibW9kaWZpZXJfdHlwZV9yYW5kb21pemUiOjAsInN3aXRjaF9jaGFuY2UiOjEsIm1vZGlmaWVyX3R5cGVfb2Zmc2V0IjowLCJ5YXdfZGVsYXlfbmV3XzUiOjEsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6MSwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjEyLCJ5YXdfZGVsYXlfbmV3XzgiOjEsInlhd19kZWxheV9uZXdfNCI6MSwiYm9keV9hbW91bnQiOi0xLCJ5YXdfZGVsYXlfbmV3XzEiOjEsInlhd19kZWxheV9uZXdfMyI6MSwibW9kaWZpZXJfdHlwZSI6Ik9mZiIsImZvcmNlX2xjIjpmYWxzZSwieWF3X2RlbGF5X2RlZmF1bHQiOjQsInlhd19sZWZ0IjotMjgsInlhd19yaWdodCI6MzYsInlhd19kZWxheV9uZXdfMTAiOjF9LHsieWF3X3R5cGUiOjIsInlhd19kZWxheV9uZXdfNiI6MywiYm9keV95YXciOiJKaXR0ZXIiLCJ5YXdfZGVsYXlfbWF4IjoxMiwieWF3X2RlbGF5X25ld185IjoxMywieWF3X2RlbGF5X25ld18yIjoxMCwieWF3X3JhbmRvbSI6MTEsIm1vZGlmaWVyX3R5cGVfcmFuZG9taXplIjo1LCJzd2l0Y2hfY2hhbmNlIjoxLCJtb2RpZmllcl90eXBlX29mZnNldCI6NSwieWF3X2RlbGF5X25ld181Ijo1LCJkZWxheV90eXBlIjozLCJ5YXdfZGVsYXlfbmV3XzciOjEyLCJzdGF0ZSI6dHJ1ZSwieWF3X2RlbGF5X21pbiI6MTIsInlhd19kZWxheV9uZXdfOCI6MTUsInlhd19kZWxheV9uZXdfNCI6NSwiYm9keV9hbW91bnQiOi0xLCJ5YXdfZGVsYXlfbmV3XzEiOjksInlhd19kZWxheV9uZXdfMyI6OSwibW9kaWZpZXJfdHlwZSI6Ik9mZiIsImZvcmNlX2xjIjp0cnVlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOi0xNywieWF3X3JpZ2h0IjozOCwieWF3X2RlbGF5X25ld18xMCI6MTl9LHsieWF3X3R5cGUiOjIsInlhd19kZWxheV9uZXdfNiI6MTUsImJvZHlfeWF3IjoiSml0dGVyIiwieWF3X2RlbGF5X21heCI6MTIsInlhd19kZWxheV9uZXdfOSI6MTgsInlhd19kZWxheV9uZXdfMiI6MTMsInlhd19yYW5kb20iOjExLCJtb2RpZmllcl90eXBlX3JhbmRvbWl6ZSI6MCwic3dpdGNoX2NoYW5jZSI6NywibW9kaWZpZXJfdHlwZV9vZmZzZXQiOjAsInlhd19kZWxheV9uZXdfNSI6MTAsImRlbGF5X3R5cGUiOjMsInlhd19kZWxheV9uZXdfNyI6NCwic3RhdGUiOnRydWUsInlhd19kZWxheV9taW4iOjEyLCJ5YXdfZGVsYXlfbmV3XzgiOjYsInlhd19kZWxheV9uZXdfNCI6MjUsImJvZHlfYW1vdW50IjotMSwieWF3X2RlbGF5X25ld18xIjo4LCJ5YXdfZGVsYXlfbmV3XzMiOjE3LCJtb2RpZmllcl90eXBlIjoiT2ZmIiwiZm9yY2VfbGMiOnRydWUsInlhd19kZWxheV9kZWZhdWx0Ijo0LCJ5YXdfbGVmdCI6LTI1LCJ5YXdfcmlnaHQiOjM5LCJ5YXdfZGVsYXlfbmV3XzEwIjo3fSx7Inlhd190eXBlIjoyLCJ5YXdfZGVsYXlfbmV3XzYiOjEsImJvZHlfeWF3IjoiSml0dGVyIiwieWF3X2RlbGF5X21heCI6NywieWF3X2RlbGF5X25ld185IjoxLCJ5YXdfZGVsYXlfbmV3XzIiOjEsInlhd19yYW5kb20iOjEyLCJtb2RpZmllcl90eXBlX3JhbmRvbWl6ZSI6MSwic3dpdGNoX2NoYW5jZSI6MSwibW9kaWZpZXJfdHlwZV9vZmZzZXQiOjEsInlhd19kZWxheV9uZXdfNSI6MSwiZGVsYXlfdHlwZSI6MywieWF3X2RlbGF5X25ld183IjoxLCJzdGF0ZSI6dHJ1ZSwieWF3X2RlbGF5X21pbiI6NywieWF3X2RlbGF5X25ld184IjoxLCJ5YXdfZGVsYXlfbmV3XzQiOjEsImJvZHlfYW1vdW50IjotMSwieWF3X2RlbGF5X25ld18xIjoxLCJ5YXdfZGVsYXlfbmV3XzMiOjEsIm1vZGlmaWVyX3R5cGUiOiJPZmZzZXQiLCJmb3JjZV9sYyI6dHJ1ZSwieWF3X2RlbGF5X2RlZmF1bHQiOjQsInlhd19sZWZ0IjotMjIsInlhd19yaWdodCI6NDMsInlhd19kZWxheV9uZXdfMTAiOjF9LHsieWF3X3R5cGUiOjIsInlhd19kZWxheV9uZXdfNiI6MSwiYm9keV95YXciOiJKaXR0ZXIiLCJ5YXdfZGVsYXlfbWF4Ijo3LCJ5YXdfZGVsYXlfbmV3XzkiOjEsInlhd19kZWxheV9uZXdfMiI6MSwieWF3X3JhbmRvbSI6MTEsIm1vZGlmaWVyX3R5cGVfcmFuZG9taXplIjowLCJzd2l0Y2hfY2hhbmNlIjoxLCJtb2RpZmllcl90eXBlX29mZnNldCI6MCwieWF3X2RlbGF5X25ld181IjoxLCJkZWxheV90eXBlIjozLCJ5YXdfZGVsYXlfbmV3XzciOjEsInN0YXRlIjp0cnVlLCJ5YXdfZGVsYXlfbWluIjo3LCJ5YXdfZGVsYXlfbmV3XzgiOjEsInlhd19kZWxheV9uZXdfNCI6MSwiYm9keV9hbW91bnQiOi0xLCJ5YXdfZGVsYXlfbmV3XzEiOjEsInlhd19kZWxheV9uZXdfMyI6MSwibW9kaWZpZXJfdHlwZSI6Ik9mZiIsImZvcmNlX2xjIjp0cnVlLCJ5YXdfZGVsYXlfZGVmYXVsdCI6NCwieWF3X2xlZnQiOi0xNSwieWF3X3JpZ2h0Ijo0MSwieWF3X2RlbGF5X25ld18xMCI6MX1dXQ=="

    cfg_system.save_config = function(id)
        if id == 1 or configs_db.cfg_list[id] == nil then 
            client.exec("play resource/warning.wav")
            return 
        end

        local raw = package:save()
        configs_db.cfg_list[id][2] = base64.encode(json.stringify(raw))
        database.write(cfg_system.db, configs_db)
        client.exec("play survival/buy_item_01.wav") 
    end

    cfg_system.create_config = function(name)
        if type(name) ~= 'string' or name == nil or name:match("^%s*$") then
            client.exec("play resource/warning.wav")
            return
        end

        for i = #configs_db.menu_list, 1, -1 do
            if configs_db.menu_list[i] == name then
                client.exec("play resource/warning.wav")
                return
            end
        end

        if #configs_db.cfg_list > 6 then
            client.exec("play resource/warning.wav")
            return
        end

        local completed = {name, ''}
        client.exec("play survival/buy_item_01.wav")
        table.insert(configs_db.cfg_list, completed)
        table.insert(configs_db.menu_list, name)
        database.write(cfg_system.db, configs_db)
    end

    cfg_system.remove_config = function(id)
        if id == 1 then
            client.exec("play resource/warning.wav")
            return    
        end
        local item = configs_db.cfg_list[id][1]
        for i = #configs_db.cfg_list, 1, -1 do
            if configs_db.cfg_list[i][1] == item then
                table.remove(configs_db.cfg_list, i)
                table.remove(configs_db.menu_list, i)
            end
        end
        client.exec("play survival/buy_item_01.wav")
        database.write(cfg_system.db, configs_db)
    end

    cfg_system.load_config = function(id)
        if id > #configs_db.cfg_list or configs_db.cfg_list[id][2] == nil or configs_db.cfg_list[id][2] == '' then
            client.exec("play resource/warning.wav")
            return
        end
        client.exec("play survival/buy_item_01.wav")
        package:load(json.parse(base64.decode(configs_db.cfg_list[id][2])))
    end

    menu.configs.create:set_callback(function() 
        cfg_system.create_config(menu.configs.name:get())
        menu.configs.listtt:update(configs_db.menu_list)
    end)

    menu.configs.load:set_callback(function() 
        cfg_system.load_config(menu.configs.listtt:get() + 1)
        menu.configs.listtt:update(configs_db.menu_list)
    end)

    menu.configs.save:set_callback(function() 
        cfg_system.save_config(menu.configs.listtt:get() + 1)
    end)

    menu.configs.delete:set_callback(function() 
        cfg_system.remove_config(menu.configs.listtt:get() + 1)
        menu.configs.listtt:update(configs_db.menu_list)
    end)

    menu.configs.import:set_callback(function() 
        package:load(json.parse(base64.decode(clipboard.get())))
        client.exec("play survival/buy_item_01.wav")
    end)

    menu.configs.export:set_callback(function() 
        clipboard.set(base64.encode(json.stringify(package:save())))
        client.exec("play survival/buy_item_01.wav")
    end)

    menu.configs.listtt:update(configs_db.menu_list)
end



local function hide_original_menu(state)
    ui.set_visible(ref.enabled, state)
    ui.set_visible(ref.pitch[1], state)
    ui.set_visible(ref.pitch[2], state)
    ui.set_visible(ref.yawbase, state)
    ui.set_visible(ref.yaw[1], state)
    ui.set_visible(ref.yaw[2], state)
    ui.set_visible(ref.yawjitter[1], state)
    ui.set_visible(ref.yawjitter[2], state)
    ui.set_visible(ref.roll[1], state)
    ui.set_visible(ref.body_yaw[1], state)
    ui.set_visible(ref.body_yaw[2], state)
    ui.set_visible(ref.fsbodyyaw[1], state)
    ui.set_visible(ref.edgeyaw, state)
    ui.set_visible(ref.freestanding[1], state)
    ui.set_visible(ref.freestanding[2], state)
    ui.set_visible(ref.fakelaglimit[1], state)
    ui.set_visible(ref.fakelagvariance[1], state)
    ui.set_visible(ref.fakelagamount[1], state)
    ui.set_visible(ref.fakelagenabled[1], state)
    ui.set_visible(ref.fakelagenabled[2], state)
end


client.set_event_callback("paint_ui", function()
    hide_original_menu()
    helpers.update_session()
    ui.set(ref.scope_overlay, true)
    local picker= helpers.create_color_array(132, 143, 240, "relentless")
    menu.main.user_wt:set(string.format("\a%s{ } • \a%sR\a%sE\a%sN\a%sE\a%sT\a%sL\a%sE\a%sS\a%sS", 
    helpers.rgba_to_hex(unpack(picker[1])), 
    helpers.rgba_to_hex(unpack(picker[2])), 
    helpers.rgba_to_hex(unpack(picker[3])), 
    helpers.rgba_to_hex(unpack(picker[4])), 
    helpers.rgba_to_hex(unpack(picker[5])), 
    helpers.rgba_to_hex(unpack(picker[6])), 
    helpers.rgba_to_hex(unpack(picker[7])),
    helpers.rgba_to_hex(unpack(picker[8])),
    helpers.rgba_to_hex(unpack(picker[9])),
    helpers.rgba_to_hex(unpack(picker[10])))
)
end)


local show_exploit_indicator = false

-- Ideal Tick System
local ideal_tick_data = {
    ideal_ticking = false,
    last_defensive_time = 0,
    defensive_cooldown = 0.5
}

local function can_defensive(player)
    if not player or not entity.is_alive(player) then return false end
    
    local sim_time = entity.get_prop(player, "m_flSimulationTime")
    local old_sim_time = entity.get_prop(player, "m_flOldSimulationTime")
    
    if not sim_time or not old_sim_time then return false end
    
    local sim_diff = sim_time - old_sim_time
    
    -- Can defensive if sim time is normal (not already in defensive)
    return sim_diff > 0 and sim_diff >= globals.tickinterval()
end

local function ideal_tick(cmd)
    if not menu.misc.ideal_tick:get() then
        ideal_tick_data.ideal_ticking = false
        return
    end
    
    ideal_tick_data.ideal_ticking = false
    
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then
        ideal_tick_data.ideal_ticking = false
        return
    end
    
    local current_time = globals.curtime()
    
    -- Don't spam defensive - respect cooldown
    if current_time - ideal_tick_data.last_defensive_time < ideal_tick_data.defensive_cooldown then
        return
    end
    
    -- Only on ground for stability
    local flags = entity.get_prop(lp, "m_fFlags")
    local on_ground = flags and bit.band(flags, 1) == 1
    if not on_ground then
        ideal_tick_data.ideal_ticking = false
        return
    end
    
    -- Get closest enemy to crosshair
    local enemies = entity.get_players(true)
    if not enemies or #enemies == 0 then return end
    
    local best_enemy = nil
    local best_fov = 180
    local view_x, view_y = client.camera_angles()
    
    for _, enemy in ipairs(enemies) do
        if entity.is_alive(enemy) and entity.is_enemy(enemy) then
            local ex, ey, ez = entity.get_origin(enemy)
            if ex then
                local lx, ly, lz = entity.get_origin(lp)
                local yaw = math.deg(math.atan2(ey - ly, ex - lx))
                local pitch = math.deg(math.atan2(ez - lz, math.sqrt((ex - lx)^2 + (ey - ly)^2)))
                
                local fov_yaw = math.abs(((yaw - view_y) + 180) % 360 - 180)
                local fov_pitch = math.abs(((pitch - view_x) + 180) % 360 - 180)
                local fov = math.sqrt(fov_yaw^2 + fov_pitch^2)
                
                if fov < best_fov then
                    best_fov = fov
                    best_enemy = enemy
                end
            end
        end
    end
    
    if not best_enemy then return end
    
    -- Check simulation time for lag compensation
    local sim_time = entity.get_prop(best_enemy, "m_flSimulationTime")
    local old_sim_time = entity.get_prop(best_enemy, "m_flOldSimulationTime")
    
    if not sim_time or not old_sim_time or sim_time <= old_sim_time then
        return
    end
    
    -- Distance check
    local ex, ey, ez = entity.get_origin(best_enemy)
    local lx, ly, lz = entity.get_origin(lp)
    local distance = math.sqrt((ex - lx)^2 + (ey - ly)^2 + (lz - ez)^2)
    
    -- Get enemy weapon
    local enemy_weapon = entity.get_player_weapon(best_enemy)
    local is_dangerous_weapon = false
    
    if enemy_weapon then
        local weapon_name = entity.get_classname(enemy_weapon)
        if weapon_name then
            if weapon_name:find("AWP") or weapon_name:find("SSG08") or 
               weapon_name:find("AK47") or weapon_name:find("M4A") then
                is_dangerous_weapon = true
            end
        end
    end
    
    -- Threat level calculation
    local threat_level = 0
    if best_fov < 15 then threat_level = threat_level + 3 end
    if best_fov < 30 then threat_level = threat_level + 2 end
    if is_dangerous_weapon then threat_level = threat_level + 2 end
    if distance < 800 then threat_level = threat_level + 1 end
    
    -- Decision logic with threat threshold
    if threat_level >= 3 then
        -- Check if we can actually defensive
        local can_def = can_defensive(lp)
        if can_def and ui.get(ref.dt[1]) and ui.get(ref.dt[2]) then
            cmd.force_defensive = 1
            ideal_tick_data.ideal_ticking = true
            ideal_tick_data.last_defensive_time = current_time
        end
    else
        ideal_tick_data.ideal_ticking = false
    end
end

client.set_event_callback("round_prestart", function()
    if menu.misc.fakelag_exploit:get() then
        show_exploit_indicator = true

        local slider_value = ui.get(ref.sv_maxusrcmdprocessticks)
        local cvar_value = sv_cmdticks_cvar:get_int()

        if slider_value > 0 then
            ui.set(ref.fakelaglimit[1], slider_value - 1)
        else
            ui.set(ref.fakelaglimit[1], math.max(cvar_value - 1, 1))
        end
    else
        show_exploit_indicator = false
    end
end)

client.set_event_callback("paint", function()
    if show_exploit_indicator then
        renderer.indicator(215, 211, 213, 255, "I FEEL LIKE DYING666")
    end
    
    if ideal_tick_data.ideal_ticking then
        local r, g, b, a = menu.visuals.main_colors:get()
        renderer.indicator(r, g, b, 255, "IDEAL")
    end
end)





client.set_event_callback('pre_render', function()
    anim_breaker()
end)

client.set_event_callback("paint", LPH_JIT(function()
    watermark()
    velocity_ind()
    custom_scope()
    mindmg()
    notifications.render()
    clantag()
    bullet_line()
    cross_ind()
    manual_arrows()
    if not menu.visuals.aspectratio:get() then 
        aspectratio(0) 
        return 
    end
    aspectratio(menu.visuals.aspectratio_value:get() / 100 or nil)
end))

client.set_event_callback("setup_command", LPH_JIT_MAX(function(cmd)
    ideal_tick(cmd)
    aa_setup(cmd)
    safe_head(cmd)
    fastladder(cmd)
    unsafe_dt()
end))

client.set_event_callback("item_purchase", logger.on_item_purchase)

client.set_event_callback("player_death", function (event)
    local target = client.userid_to_entindex(event.userid)
    local attacker = client.userid_to_entindex(event.attacker)
    if entity.get_prop(entity.get_player_resource(), "m_iPing", target) == 0 and not relentless_data.name then return end

    if target == entity.get_local_player() then return end
    
    if target ~= entity.get_local_player() and attacker == entity.get_local_player() then
        db.stats.killed = db.stats.killed + 1
        menu.information.killed:set("\v\rEnemies Fucked • \v" .. db.stats.killed)
    end
end)

client.set_event_callback('level_init', function()
    timer = globals.tickcount()
end)

client.set_event_callback("bullet_impact", function(e)
    bullet_line_help(e)
end)

client.set_event_callback('shutdown', function()
    hide_original_menu(true)
    cvar.con_filter_enable:set_int(0)
    cvar.con_filter_text:set_string("")
    aspectratio(0)
    ui.set(ref.scope_overlay, true)
end)