--NovaMeter by Nova_Plays my discord is Nova_Plays#9126
--this script is pretty bad coded well for me its more ez like that and i didnt want to get into the blur draw shit so yeah feel free to change what u dont like to the code ur own
--but if u do it ask me if you can post it as a script please :d
--the background and topborder are made with gimp bc i dont have photoshop well they look okay so yeah
--if you have any ideas for this script it has an auto updater so feel free to dm me on discord and share ur idea if its good then ill try to add it :d
--the functions are made by me even tho when i looked at glance they seem to be a bit the same but well yeah some things are skidded tho bc it was not worth to need to look for new things on how to do it. 
--hope u like this
util.keep_running()
util.require_natives(1663599433)

-----------------
--update system--
-----------------
local status, auto_updater = pcall(require, "auto-updater")
if not status then
    local auto_update_complete = nil util.toast("Installing auto-updater...", TOAST_ALL)
    async_http.init("raw.githubusercontent.com", "/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
        function(result, headers, status_code)
            local function parse_auto_update_result(result, headers, status_code)
                local error_prefix = "Error downloading auto-updater: "
                if status_code ~= 200 then util.toast(error_prefix..status_code, TOAST_ALL) return false end
                if not result or result == "" then util.toast(error_prefix.."Found empty file.", TOAST_ALL) return false end
                filesystem.mkdir(filesystem.scripts_dir() .. "lib")
                local file = io.open(filesystem.scripts_dir() .. "lib\\auto-updater.lua", "wb")
                if file == nil then util.toast(error_prefix.."Could not open file for writing.", TOAST_ALL) return false end
                file:write(result) file:close() util.toast("Successfully installed auto-updater lib", TOAST_ALL) return true
            end
            auto_update_complete = parse_auto_update_result(result, headers, status_code)
        end, function() util.toast("Error downloading auto-updater lib. Update failed to download.", TOAST_ALL) end)
    async_http.dispatch() local i = 1 while (auto_update_complete == nil and i < 40) do util.yield(250) i = i + 1 end
    if auto_update_complete == nil then error("Error downloading auto-updater lib. HTTP Request timeout") end
    auto_updater = require("auto-updater")
end
if auto_updater == true then error("Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again") end

local default_check_interval = 604800
local auto_update_config = {
    source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/NovaLay.lua",
    script_relpath=SCRIPT_RELPATH,
    switch_to_branch=selected_branch,
    verify_file_begins_with="--",
    check_interval=86400,
    silent_updates=true,
    dependencies={
        {
            name="blip",
            source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/resources/NovaLay/Blip.png",
            script_relpath="resources/NovaLay/Blip.png",
            check_interval=default_check_interval,
        },

        {
            name="map",
            source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/resources/NovaLay/GTA_Map.png",
            script_relpath="resources/NovaLay/GTA_Map.png",
            check_interval=default_check_interval,
        },

        {
            name="background",
            source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/resources/NovaLay/mainbackground.png",
            script_relpath="resources/NovaLay/mainbackground.png",
            check_interval=default_check_interval,
        },

        {
            name="mapbackground",
            source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/resources/NovaLay/mapbackground.png",
            script_relpath="resources/NovaLay/mapbackground.png",
            check_interval=default_check_interval,
        },

		{
            name="topborder",
            source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/resources/NovaLay/topborder.png",
            script_relpath="resources/NovaLay/topborder.png",
            check_interval=default_check_interval,
        },

        {
            name="mapborder",
            source_url="https://raw.githubusercontent.com/NovaPlays134/NovaLay/main/resources/NovaLay/topbordermap.png",
            script_relpath="resources/NovaLay/topbordermap.png",
            check_interval=default_check_interval,
        },

    }
}
auto_updater.run_auto_update(auto_update_config)
-----------------
--GETTING FILES--
-----------------
resources_dir = filesystem.resources_dir() .. '\\NovaLay\\'
local topborder = directx.create_texture(resources_dir .. "topborder.png")
local mainback = directx.create_texture(resources_dir .. "mainbackground.png")
local mapborder = directx.create_texture(resources_dir .. "topbordermap.png")
local mapback = directx.create_texture(resources_dir .. "mapbackground.png")
local map = directx.create_texture(resources_dir .. "GTA_Map.png")
local blip = directx.create_texture(resources_dir .. "Blip.png")

----------
--TABLES--
----------
--colors--
local colors = {
        topbar = {["r"] = 50/255, ["g"] = 50/255, ["b"] = 50/255, ["a"] = 1.0}, --grayish
        background = {["r"] = 5/255, ["g"] = 5/255, ["b"] = 5/255, ["a"] = 1.0}, --blackish
        subhead = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1.0}, --white
        label = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1.0}, --white
        highlight = {["r"] = 160/255, ["g"] = 160/255, ["b"] = 160/255, ["a"] = 1.0}, -- also grayish
        yes_color = {["r"] = 0, ["g"] = 1, ["b"] = 0, ["a"] = 1.0}, --green
        no_color = {["r"] = 1, ["g"] = 0, ["b"] = 0, ["a"] = 1.0}, --red
        orange = {["r"] = 1, ["g"] = 138/255, ["b"] = 31/255, ["a"] = 1.0},
        map = {r = 1, g = 1, b = 1, a = 0.75}, --white
        blip = {["r"] = 1, ["g"] = 1, ["b"] = 1, ["a"] = 1.0} --white
}

--languages--
local languages = {
    [0] = "English",
    [1] = "French",
    [2] = "German",
    [3] = "Italian",
    [4] = "Spanish",
    [5] = "Brazilian",
    [6] = "Polish",
    [7] = "Russian",
    [8] = "Korean",
    [9] = "Chinese",
    [10] = "Japanese",
    [11] = "Mexican",
    [12] = "Chinese"
    }
-----------
--OPTIONS--
-----------

--show map--
local map_show = true
local show_map = menu.toggle(menu.my_root(), "Show map on screen", {}, "", function(on)
    map_show = on
end, true)

show_map_show = false
menu.on_focus(show_map, function()
    show_map_show = true
end)

menu.on_blur(show_map, function()
    show_map_show = false
end)

--lists--
local color_list = menu.list(menu.my_root(), "Change color's")

color_show_list = false
menu.on_focus(color_list, function()
    color_show_list = true
end)

menu.on_blur(color_list, function()
    color_show_list = false
end)

local value_color_list = menu.list(menu.my_root(), "Value colors")

value_show_list = false
menu.on_focus(value_color_list, function()
    value_show_list = true
end)

menu.on_blur(value_color_list, function()
    value_show_list = false
end)

--CHANGE COLORS--
--topbar--
local color_change_topbar = menu.colour(color_list, "Change topbar color", {}, "", colors.topbar, true, function(color)
    colors.topbar = color
end)

color_show_topbar = false
menu.on_focus(color_change_topbar, function()
    color_show_topbar = true
end)

menu.on_blur(color_change_topbar, function()
    color_show_topbar = false
end)

--background--
local color_change_back = menu.colour(color_list, "Change background color", {}, "", colors.background, true, function(color)
    colors.background = color
end)

color_show_back = false
menu.on_focus(color_change_back, function()
    color_show_back = true
end)

menu.on_blur(color_change_back, function()
    color_show_back = false
end)

--subhead--
local color_change_sub = menu.colour(color_list, "Change subhead color", {}, "Name, Player Info, Character Info", colors.subhead, true, function(color)
    colors.subhead = color
end)

color_show_sub = false
menu.on_focus(color_change_sub, function()
    color_show_sub = true
end)

menu.on_blur(color_change_sub, function()
    color_show_sub = false
end)

--label--
local color_change_label = menu.colour(color_list, "Change label color", {}, "", colors.label, true, function(color)
    colors.label = color
end)

color_show_label = false
menu.on_focus(color_change_label, function()
    color_show_label = true
end)

menu.on_blur(color_change_label, function()
    color_show_label = false
end)

--highlight--
local color_change_high = menu.colour(color_list, "Change highlight color", {}, "", colors.highlight, true, function(color)
    colors.highlight = color
end)

color_show_high = false
menu.on_focus(color_change_high, function()
    color_show_high = true
end)

menu.on_blur(color_change_high, function()
    color_show_high = false
end)

--map--
local color_change_map = menu.colour(color_list, "Change map color", {}, "", colors.map, true, function(color)
    colors.map = color
end)

color_show_map = false
menu.on_focus(color_change_map, function()
    color_show_map = true
end)

menu.on_blur(color_change_map, function()
    color_show_map = false
end)

--blip--
local color_change_blip = menu.colour(color_list, "Change Blip color", {}, "", colors.blip, true, function(color)
    colors.blip = color
end)

color_show_blip = false
menu.on_focus(color_change_blip, function()
    color_show_blip = true
end)

menu.on_blur(color_change_blip, function()
    color_show_blip = false
end)
--CHANGE VALUE COLORS ON/OFF--
--bool--
local bool_change = false
local bool_change_color = menu.toggle(value_color_list, "Disable value bool color", {}, "this makes the red/green yes/no options gray", function(on)
    bool_change = on
end)

change_bool_show = false
menu.on_focus(bool_change_color, function()
    change_bool_show = true
end)

menu.on_blur(bool_change_color, function()
    change_bool_show = false
end)

--money--
local money_change = false
local money_change_color = menu.toggle(value_color_list, "Disable value money color", {}, "this makes the red/orange/green money options gray", function(on)
    money_change = on
end)

change_money_show = false
menu.on_focus(money_change_color, function()
    change_money_show = true
end)

menu.on_blur(money_change_color, function()
    change_money_show = false
end)

--position-- this is messy asf but ig its the only way by how i coded the script
local defposX, defposY = 0.215, 0.125
local backgroundposX, backgroundposY = defposX, defposY
local topbarposX, topbarposY = defposX, defposY+0.0005
local mapborderposX, mapborderposY = defposX+0.1911, defposY+0.0005
local mapbackgroundposX, mapbackgroundposY = defposX+0.1911, defposY
local nameposX, nameposY = defposX-0.092, defposY-0.028
local PLAYERposX, PLAYERposY = defposX-0.050, defposY-0.020
local PLAYERS_textposX, PLAYERS_textposY = defposX-0.050, defposY+0.010
local CHARACTERposX, CHARACTERposY = defposX-0.190, defposY-0.020
local CHARACTER_textposX, CHARACTER_textposY = defposX-0.195, defposY+0.010
local GENERALposX, GENERALposY = defposX-0.117, defposY+0.200
local GENERAL_textposX, GENERAL_textposY = defposX-0.195, defposY+0.220
local tagsposX, tagsposY = defposX-0.195, defposY+0.375
local mapposX, mapposY = defposX+0.096159587, defposY+0.18583594
local blipposX, blipposY = defposX+0.0079167, defposY-0.00740741

--x--
local posXslider = menu.slider(menu.my_root(), "Speedometer pos X", {}, "Default value is 215", 1, 1000, defposX*1000, 1, function(x)
    backgroundposX = x/1000
    topbarposX = x/1000
    mapborderposX = x/1000 + 0.1911
    mapbackgroundposX = x/1000 + 0.1911
    nameposX = x/1000 - 0.092
    PLAYERposX = x/1000 - 0.050
    PLAYERS_textposX = x/1000 - 0.050
    CHARACTERposX = x/1000 - 0.190
    CHARACTER_textposX = x/1000 - 0.195
    GENERALposX = x/1000 - 0.117
    GENERAL_textposX = x/1000 - 0.195
    tagsposX = x/1000 - 0.195
    mapposX = x/1000 + 0.096159587
    blipposX = x/1000 + 0.0079167
end)

posXslider_show = false
menu.on_focus(posXslider, function()
    posXslider_show = true
end)

menu.on_blur(posXslider, function()
    posXslider_show = false
end)

--y--
local posYslider = menu.slider(menu.my_root(), "Speedometer pos Y", {}, "Default value is 125", 1, 1000, defposY*1000, 1, function(y)
    backgroundposY = y/1000
    topbarposY = y/1000 + 0.0005
    mapborderposY = y/1000 +0.0005
    mapbackgroundposY = y/1000
    nameposY = y/1000 - 0.028
    PLAYERposY = y/1000 - 0.020
    PLAYERS_textposY = y/1000 + 0.010
    CHARACTERposY = y/1000 - 0.020
    CHARACTER_textposY = y/1000 + 0.010
    GENERALposY = y/1000 + 0.200
    GENERAL_textposY = y/1000 + 0.220
    tagsposY = y/1000 + 0.375
    mapposY = y/1000 + 0.18583594
    blipposY = y/1000 - 0.00740741
end)

posYslider_show = false
menu.on_focus(posYslider, function()
    posYslider_show = true
end)

menu.on_blur(posYslider, function()
    posYslider_show = false
end)

local blipsize = 0.0035
local blipsizeslider = menu.slider(menu.my_root(), "Change blip size", {}, "Default value is 35", 1, 100, blipsize*10000, 1, function(size)
    blipsize = size/10000
end)

blipsizeslider_show = false
menu.on_focus(blipsizeslider, function()
    blipsizeslider_show = true
end)

menu.on_blur(blipsizeslider, function()
    blipsizeslider_show = false
end)

--change measurement--
local mesh = 1
local change_unit = menu.list_select(menu.my_root(), "Change speed measurement", {}, "This changes the speed info to the unit u select", {"MPH", "KPH"}, 1, function(index)
    mesh = index 
end)

change_unit_show = false
menu.on_focus(change_unit, function()
    change_unit_show = true
end)

menu.on_blur(change_unit, function()
    change_unit_show = false
end)

local info_list = menu.list(menu.my_root(), "Info")

menu.action(info_list, "Credits to lev for the map thingy", {}, "", function()
end)

menu.action(info_list, "Check for Update", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
    auto_update_config.check_interval = 0
    if auto_updater.run_auto_update(auto_update_config) then
        util.toast("No updates found")
    end
end)
menu.action(info_list, "Clean Reinstall", {}, "Force an update to the latest version, regardless of current version.", function()
    auto_update_config.clean_reinstall = true
    auto_updater.run_auto_update(auto_update_config)
end)
-------------
--FUNCTIONS--
-------------
--shamelessly stolen from lance that stole it from keks--
function dec_to_ipv4(ip)
	return string.format(
		"%i.%i.%i.%i", 
		ip >> 24 & 0xFF, 
		ip >> 16 & 0xFF, 
		ip >> 8  & 0xFF, 
		ip 		 & 0xFF
	)
end

--weapon function--
all_weapons = {}
temp_weapons = util.get_weapons()
-- create a table with just weapon hashes, labels
for a,b in pairs(temp_weapons) do
    all_weapons[#all_weapons + 1] = {hash = b['hash'], label_key = b['label_key']}
end
function get_weapon_name_from_hash(hash) 
    for k,v in pairs(all_weapons) do 
        if v.hash == hash then 
            return util.get_label_text(v.label_key)
        end
    end
    return 'Unarmed'
end

function bool(bool)
    if bool then
        return "Yes"
    else
        return "No"
    end
end

function check(info)
    if info == nil or info == "NULL" or info == 0 or info == " " then
        return "None"
    else
        return info
    end
end

function queuecheck(info)
    if info == nil or info == "NULL" or info == " " then
        return 0
    else
        return "#" .. info
    end
end

function org(org_type)
    if org_type == -1 then
        return "Isn't in any"
    elseif org_type == 0 then
        return "CEO"
    else
        return "MC"
    end
end

function distance(mypos, playerpos)
    local distance = math.floor(MISC.GET_DISTANCE_BETWEEN_COORDS(playerpos.x, playerpos.y, playerpos.z, mypos.x, mypos.y, mypos.z))
        if distance == nil or distance == "NULL" or distance == 0 or distance == " " then
            return "This is you"
        else
            return distance .. "m"
        end
end

function round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5) / mult
end

--dont ask please--
function formatMoney(money)
    if money >= 1000 and money < 999950 then
        return round(money / 1000, 1) .. "K"
    elseif money >= 999950 and money < 999999950 then
        return round(money / 1000000, 1) .. "M"
    elseif money >= 999999950 then
        return round(money / 1000000000, 1) .. "B"
    else return money
    end
end

function draw_info_text(text, infotext, posX, posY, distance, hight, size1, size2, extracolor) -- this is my way of doing it the hight is normaly 20 but i have no idea why but sometimes the infotext goes lower then others eh just some numbers dont copy this bc its kinda trash
    local posY_2 = (posY*1000) + distance / hight
    local posX_2 = (posX*1000) + distance
    local draw_text = directx.draw_text(posX, posY, text, ALIGN_TOP_LEFT, size1, colors.label, true)
    local draw_info_text = directx.draw_text(posX_2/1000, posY_2/1000, infotext, ALIGN_TOP_LEFT, size2, extracolor or colors.highlight, true)
    if text == nil or infotext == nil then
        return 0
    else 
        return draw_text, draw_info_text
    end
end

function get_prostitutes_solicited(pid)
    return memory.read_int(memory.script_global(1853910 + 1 + (pid * 862) + 205 + 54))
end

function green_or_red(yes_no)
    if bool_change then
        return colors.highlight
    else
        if yes_no == "Yes" then
            return colors.yes_color
        else
            return colors.no_color
        end
    end
end

function money_color(money)
    if money_change then
        return colors.highlight
    else
        if money >= 0 and money < 10000 then
            return colors.no_color
        elseif money >= 10000 and money < 100000 then
            return colors.orange
        elseif money >= 100000 and money < 100000000 then
            return colors.yes_color
        end
    end
end

------------------------
--DRAWING/GETTING INFO--
------------------------
util.create_tick_handler(function()
    if not util.is_session_transition_active() then
        local focusedplayer = players.get_focused()
        if focusedplayer[1] ~= nil and menu.is_open() or (color_show_list or value_show_list or color_show_topbar or color_show_back or color_show_sub or color_show_label or color_show_high or color_show_map or color_show_blip or change_bool_show or change_money_show or change_unit_show or posXslider_show or posYslider_show or blipsizeslider_show or show_map_show) then

            if (color_show_list or value_show_list or color_show_topbar or color_show_back or color_show_sub or color_show_label or color_show_high or color_show_map or color_show_blip or change_bool_show or change_money_show or change_unit_show or posXslider_show or posYslider_show or blipsizeslider_show or show_map_show) then
                focusedplayer = players.user()
            else
                focusedplayer = focusedplayer[1]
            end

                local focusedped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(focusedplayer)
                local mypos, playerpos = players.get_position(players.user()), players.get_position(focusedplayer)
                local weapon_hash = WEAPON.GET_SELECTED_PED_WEAPON(focusedped)

                local speed = ENTITY.GET_ENTITY_SPEED(focusedped) --this hole speed thing is taken from my speedometer script
                local mph = speed * 2.236936
		        local kph = speed * 3.6
		        local value = " mph"

		    if mesh == 1 then 
			    measured_speed = mph 
			else
			    measured_speed = kph
			    value = " kmh"
			end

                local name = players.get_name(focusedplayer)
                local RID = players.get_rockstar_id(focusedplayer)
                local IP = dec_to_ipv4(players.get_connect_ip(focusedplayer))
                local rank = check(players.get_rank(focusedplayer))
                local totalmoney = formatMoney(players.get_money(focusedplayer))
                local walletmoney = formatMoney(players.get_wallet(focusedplayer))
                local bankmoney = formatMoney(players.get_bank(focusedplayer))
                local kd = round(players.get_kd(focusedplayer), 2)
                local lang = languages[players.get_language(focusedplayer)]
                local controller = bool(players.is_using_controller(focusedplayer))
                local tags =  check(players.get_tags_string(focusedplayer))
                local godmode = bool(players.is_godmode(focusedplayer))
                local mod_or_ad = bool(players.is_marked_as_modder_or_admin(focusedplayer))
                local atk_you = bool(players.is_marked_as_attacker(focusedplayer))
                local otr = bool(players.is_otr(focusedplayer)) 
                local host_queue = queuecheck(players.get_host_queue_position(focusedplayer))
                local org_type = org(players.get_org_type(focusedplayer))
                local distance = distance(mypos, playerpos)
                local vehicle_name = check(util.get_label_text(players.get_vehicle_model(focusedplayer)))
                local cal_speed = math.ceil(measured_speed)
                local wanted_lvl, max_wanted_lvl = PLAYER.GET_PLAYER_WANTED_LEVEL(focusedplayer), PLAYER.GET_MAX_WANTED_LEVEL(focusedplayer)
                local health, maxhealth = ENTITY.GET_ENTITY_HEALTH(focusedped), ENTITY.GET_ENTITY_MAX_HEALTH(focusedped)
                local armor, maxarmor = PED.GET_PED_ARMOUR(focusedped), PLAYER.GET_PLAYER_MAX_ARMOUR(focusedplayer)
                local weapon =  get_weapon_name_from_hash(weapon_hash)
                local host = bool(focusedplayer == players.get_host())
                local script_host = bool(focusedplayer == players.get_script_host())
                local hookers = get_prostitutes_solicited(focusedplayer)
            --topbar--
		    directx.draw_texture(topborder, 0.12, 0.12, 0.88, 0.125, topbarposX, topbarposY, 0.0, colors.topbar)
            --background--
            directx.draw_texture(mainback, 0.12, 0.12, 0.88, 0.125, backgroundposX, backgroundposY, 0.0, colors.background)

        -------
        --MAP--
        -------
        if map_show then
            --mapborder--
            directx.draw_texture(mapborder, 0.12, 0.12, 0.88, 0.125, mapborderposX, mapborderposY, 0.0, colors.topbar)
            --mapbackground--
            directx.draw_texture(mapback, 0.12, 0.12, 0.88, 0.125, mapbackgroundposX, mapbackgroundposY, 0.0, colors.background)

            --im not happy about this code tbh to many fucked up numbers for me and i just copied this shit from InfOverlay from lev maybe if u read this i havnt changed it since its been added but if u dont then its better :D
            --map--
            local mapsizeX, mapsizeY = 0.14416506, 0.3864867
            directx.draw_texture(map, mapsizeX/2, mapsizeY, 0.5, 0.5, mapposX, mapposY, 0.0, colors.map)

            --blip--
            local blip_posX = blipposX + 0.0161603566 + ((playerpos.x + 3745)/8316) * mapsizeX
            local blip_posY = blipposY + (1 - (playerpos.y + 4427)/12689) * mapsizeY
            local heading = ENTITY.GET_ENTITY_HEADING(focusedped)
            if blip_posX <= mapposX+0.07948270113 and blip_posX >= mapposX-0.072813007 and blip_posY >= mapposY-0.20722706 and blip_posY <= mapposY+0.21976627 then
                directx.draw_texture(blip, blipsize, blipsize, 0.5, 0.5, blip_posX, blip_posY, (360 - heading)/360, colors.blip)
            end
        end
            --name--
            directx.draw_text(nameposX, nameposY, name, ALIGN_CENTRE, 0.45, colors.subhead, true)

            --PLAYER--
            directx.draw_text(PLAYERposX, PLAYERposY, "Player Info", ALIGN_TOP_LEFT, 0.5, colors.subhead, true)
            --RID--
            draw_info_text("RID:", RID, PLAYERS_textposX, PLAYERS_textposY, 18, 20, 0.45, 0.44)
            --IP--
            draw_info_text("IP:", IP, PLAYERS_textposX, PLAYERS_textposY + 0.02, 12, 20, 0.45, 0.44)
            --rank--
            draw_info_text("Rank:", rank, PLAYERS_textposX, PLAYERS_textposY + 0.04, 22, 20, 0.45, 0.44)
            --kd--
            draw_info_text("K/D:", kd, PLAYERS_textposX, PLAYERS_textposY + 0.06, 18, 20, 0.45, 0.44)
            --lang--
            draw_info_text("Language:", lang, PLAYERS_textposX, PLAYERS_textposY + 0.08, 39, 30, 0.45, 0.44)
            --controller--
            draw_info_text("Controller:", controller, PLAYERS_textposX, PLAYERS_textposY + 0.1, 40, 30, 0.45, 0.44, green_or_red(controller))
            --host--
            draw_info_text("Host:", host, PLAYERS_textposX, PLAYERS_textposY + 0.12, 22, 20, 0.45, 0.44, green_or_red(host))
            --script host--
            draw_info_text("Script host:", script_host, PLAYERS_textposX, PLAYERS_textposY + 0.14, 43, 35, 0.45, 0.44, green_or_red(script_host))
            --host queue--
            draw_info_text("Host queue:", host_queue, PLAYERS_textposX, PLAYERS_textposY + 0.16, 45, 30, 0.45, 0.44)

            --CHARACTER--
            directx.draw_text(CHARACTERposX, CHARACTERposY, "Character Info", ALIGN_TOP_LEFT, 0.5, colors.subhead, true)
            --org--
            draw_info_text("Org:", org_type, CHARACTER_textposX, CHARACTER_textposY, 18, 20, 0.45, 0.44)
            --distance--
            draw_info_text("Distance:", distance, CHARACTER_textposX, CHARACTER_textposY + 0.02, 34, 20, 0.45, 0.44)
            --speed--
            draw_info_text("Speed:", cal_speed .. value, CHARACTER_textposX, CHARACTER_textposY + 0.04, 27, 30, 0.45, 0.44)
            --health--
            draw_info_text("Health:", health .. "/" .. maxhealth, CHARACTER_textposX, CHARACTER_textposY + 0.06, 27, 20, 0.45, 0.44)
            --armor--
            draw_info_text("Armor:", armor .. "/" .. maxarmor, CHARACTER_textposX, CHARACTER_textposY + 0.08, 27, 20, 0.45, 0.44)
            --gm--
            draw_info_text("Godmode:", godmode, CHARACTER_textposX, CHARACTER_textposY + 0.1, 41, 30, 0.45, 0.44, green_or_red(godmode))
            --otr--
            draw_info_text("Off the radar:", otr, CHARACTER_textposX, CHARACTER_textposY + 0.12, 50, 40, 0.45, 0.44, green_or_red(otr))
            --vehicle--
            draw_info_text("Vehicle:", vehicle_name, CHARACTER_textposX, CHARACTER_textposY + 0.14, 30, 20, 0.45, 0.44)
            --weapon--
            draw_info_text("Weapon:", weapon, CHARACTER_textposX, CHARACTER_textposY + 0.16, 34, 30, 0.45, 0.44)

            --GENERAL--
            directx.draw_text(GENERALposX, GENERALposY, "General Info", ALIGN_TOP_LEFT, 0.5, colors.subhead, true)
            --wanted lvl--
            draw_info_text("Wanted level:", wanted_lvl .. "/" .. max_wanted_lvl, GENERAL_textposX, GENERAL_textposY, 192, 120, 0.45, 0.44)
            --atk you--
            draw_info_text("Atk you:", atk_you, GENERAL_textposX, GENERAL_textposY + 0.02, 192, 100, 0.45, 0.44, green_or_red(atk_you))
            --mod or admin--
            draw_info_text("Mod or Admin:", mod_or_ad, GENERAL_textposX, GENERAL_textposY + 0.04, 192, 100, 0.45, 0.44, green_or_red(mod_or_ad))
            --total money--
            draw_info_text("Total:", "$" .. totalmoney, GENERAL_textposX, GENERAL_textposY + 0.06, 192, 100, 0.45, 0.44, money_color(players.get_money(focusedplayer)))
            --walled money--
            draw_info_text("Wallet:", "$" .. walletmoney, GENERAL_textposX, GENERAL_textposY + 0.08, 192, 100, 0.45, 0.44, money_color(players.get_wallet(focusedplayer)))
            --bank money--
            draw_info_text("Bank:", "$" .. bankmoney, GENERAL_textposX, GENERAL_textposY + 0.1, 192, 100, 0.45, 0.44, money_color(players.get_bank(focusedplayer)))
            --hookers--
            draw_info_text("whore's:", hookers, GENERAL_textposX, GENERAL_textposY + 0.12, 192, 100, 0.45, 0.44)
            --tags--
            draw_info_text("Tags:", tags, tagsposX, tagsposY, 22, 20, 0.45, 0.44)
        end
    end
end)

