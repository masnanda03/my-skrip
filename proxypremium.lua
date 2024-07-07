--PROXY BY MUFFINN COMMUNITY--
tabel_uid = {
    134611, 475429, 788943, 37962
}

local wl = 242
local dl = 1796
local bgl = 7188
local bbgl = 11550
local Name = GetLocal().name
local collectedSent = false
local kick = false
local ban = false
local pull = false
local reme = 0
local qeme = 0
local normal = 0
local telepX = 0
local telepY = 0
local time_now = os.date("`1%H:%M`0, `1%d-%m-%Y")

local options = {
    check_antibounce = false,
    check_modfly = false,
    check_speed = false,
    check_gravity = false,
    check_aimbot = false,
    check_lonely = false,
    check_ignoreo = false,
    check_gems = false,
    check_ignoref = false,
    check_autospam = false
}

function qq_function(number)
    str_number = tostring(number)
    last_digit = str_number:sub(-1)
    result = tonumber(last_digit)
    return result
end

function remove_color_codes(str)
    pattern = "`."
    result = string.gsub(str, pattern, "")
    return result
end

function reme_function(number)
    str_number = tostring(number)
    sum = 0
    
    for i = 1, #str_number do
        sum = sum + tonumber(str_number:sub(i, i))
    end
    
    str_sum = tostring(sum)
    last_digit = str_sum:sub(-1)
    result = tonumber(last_digit)
    
    return result
end

function scanObject(id)
    count = 0
    for _, object in pairs(GetObjectList()) do
        if object.id == id then
            count = count + object.amount
        end
    end
    return count
end

function removeColorAndSymbols(str)
    cleanedStr = string.gsub(str, "`(%S)", '')
    cleanedStr = string.gsub(cleanedStr, "Dr%.%s*", '')
    cleanedStr = string.gsub(cleanedStr, "%s*%[BOOST%]", '')
    cleanedStr = string.gsub(cleanedStr, "%(%d+%)", '')
    cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
    return cleanedStr
end

function wear(id)
    pkt = {}
    pkt.type = 10
    pkt.value = id
    SendPacketRaw(false, pkt)
end

function findItem(id)
    for _, itm in pairs(GetInventory()) do
      if itm.id == id then
        return itm.amount
        end
    end
return 0
end

function log(str)
    LogToConsole("`0[`#Muffinn Helper`0]`o "..str)
end

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

function FChat(txt)
    p = {}
    p[0] = "OnTextOverlay"
    p[1] = txt
    SendVariantList(p)
  end

function overlayText(text)
    var = {}
    var[0] = "OnTextOverlay"
    var[1] = "`0[`#Muffinn Helper`0]`o ".. text
    SendVariantList(var)
end

function OnTextOverlay(str)
    local o = {}
    o[0] = "OnTextOverlay"
    o[1] = str
    return o
end

function CHECKBOX(B)
    return B and "1" or "0"
end

function TimeNow()
     current = time_now
    return true
end

-- [C] Bothax Menu
if _G.ModflyStatus == nil then
    _G.ModflyStatus = false
end
if _G.AntibounceStatus == nil then
    _G.AntibounceStatus = false
end

function main()
local function ShowMainDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
text_scaling_string|commandOne
add_label_with_icon|big|`0CreativePS.eu `0- `2Helper |left|7074|
add_textbox|`0--------------------------------------------------------```|
add_smalltext|`0This Helper Was made by `5Muffinn`0, Thanks for using this script !|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Hi ]]..GetLocal().name..[[|right|14964|
add_label_with_icon|small|`0You're Currently at `9]]..GetWorld().name..[[|left|3802|
add_label_with_icon|small|`0You're Standing at X : `1]]..math.floor(GetLocal().pos.x / 32)..[[, `0Y : `1]]..math.floor(GetLocal().pos.y / 32)..[[|left|12854|
add_label_with_icon|small|`0Current Time : ]].. time_now..[[|left|7864|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Fiture Proxy :|left|11304|
add_spacer|small|
add_button_with_icon|social_portal|`0Social Portal|staticBlueFrame|1366||
add_button_with_icon|profile_menu|`0Your Profile|staticBlueFrame|14968||
add_button_with_icon|command_list|`0Command List|staticBlueFrame|1752||
add_button_with_icon|command_abilities|`0Abilities Menu|staticBlueFrame|14404||
add_button_with_icon|wrenchmenu|`0Wrench Menu|staticBlueFrame|32||
add_button_with_icon|others_menu|`0Others Abilities|staticBlueFrame|528||
add_custom_break|
end_list|
add_button_with_icon|command_proxyinfo|`0Founder|staticBlueFrame|1628||
add_button_with_icon|update_info|`0Support|staticBlueFrame|656||
add_custom_break|
end_dialog|commandOne|Close||
]]
    SendVariantList(varlist_command)
end

local function ShowListDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`0Command List|left|3524|
add_custom_break|
add_textbox|`0------------------------------------------------------|
add_label_with_icon|small|`0Custom Drop|left|242|
add_label_with_icon|small|`8/dw <amount> `0: Drop `9World Lock|left|482|
add_label_with_icon|small|`8/dd <amount> `0: Drop `cDiamond Lock|left|482|
add_label_with_icon|small|`8/db <amount> `0: Drop `1Blue Gem Lock|left|482|
add_label_with_icon|small|`8/di <amount> `0: Drop `bBlack Gem Lock|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Convert|left|3898|
add_label_with_icon|small|`8/cdl `0: convert bgl to dl|left|482|
add_label_with_icon|small|`8/blue `0: convert dl to bgl|left|482|
add_label_with_icon|small|`8/black `0: convert bgl to black|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Bank|left|1008|
add_label_with_icon|small|`8/dp <amount> `0: deposit your bgl to bank|left|482|
add_label_with_icon|small|`8/wd <amount> `0: withdraw your bgl from bank|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Menu|left|2918|
add_label_with_icon|small|`8/warp <world name> `0 : warp to other world|left|482|
add_label_with_icon|small|`8/rc `0: reconnect|left|482|
add_label_with_icon|small|`8/re `0: rejoin world|left|482|
add_label_with_icon|small|`8/b `0: back to world before|left|482|
add_label_with_icon|small|`8/gs `0: show growscan|left|482|
add_spacer|small|
add_label_with_icon|small|`0Command Reme/Qeme|left|758|
add_label_with_icon|small|`8/reme `0: turn on reme number|left|482|
add_label_with_icon|small|`8/qeme `0: turn on qeme number|left|482|
add_label_with_icon|small|`8/normal `0: turn back normal roullete mode|left|482|
add_spacer|small|
add_label_with_icon|small|`0Command Btk Helper|left|340|
add_label_with_icon|small|`8/btk `0: turn on btk helper|left|482|
add_label_with_icon|small|`8/p1 `0: set position 1 (left)|left|482|
add_label_with_icon|small|`8/p2 `0: set position 2 (right)|left|482|
add_label_with_icon|small|`8/c `0: check gems drop [Win/Lose]|left|482|
add_textbox|`0------------------------------------------------------|
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
    SendVariantList(varlist_command)
end

local function ShowAbilitiesDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
text_scaling_string|commandList
add_label_with_icon|big|`0Abilities Menu````|left|1662|
add_smalltext|------------------------------------------------------|
add_textbox|`0Auto : |left|
add_checkbox|check_autospam|`0Auto Spam Mode|]] .. CHECKBOX(options.check_autospam) .. [[|
add_checkbox|check_gems|`0Auto Take Gems Mode|]] .. CHECKBOX(options.check_gems) .. [[|
add_textbox|`0Abilities : |left|
add_checkbox|check_speed|`0Speed Mode|]] .. CHECKBOX(options.check_speed) .. [[|
add_checkbox|check_gravity|`0Gravity Mode|]] .. CHECKBOX(options.check_gravity) .. [[|
add_checkbox|check_aimbot|`0Aim Bot Mode|]] .. CHECKBOX(options.check_aimbot) .. [[|
add_textbox|`0Less Lag Improve Fps : |left|
add_checkbox|check_lonely|`0Lonely Mode|]] .. CHECKBOX(options.check_lonely) .. [[|
add_checkbox|check_ignoreo|`0Ignore Others Drop Mode|]] .. CHECKBOX(options.check_ignoreo) .. [[|
add_checkbox|check_ignoref|`0Ignore Others Completely Mode|]] .. CHECKBOX(options.check_ignoref) .. [[|
add_custom_break|
add_spacer|small|
add_button|command_back|`9Back|noflags|0|0|
end_dialog|cheats||Apply Cheats!|
]]
    SendVariantList(varlist_command)
end

local function ShowProxyDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`0Founder|left|9222|
add_custom_break|
add_textbox|`0------------------------------------------------------|
add_smalltext|`0Owner This Script|left|
add_spacer|small|
add_label_with_icon|small|`5@muffinncps|left|5956|
add_textbox|`0------------------------------------------------------|
add_smalltext|`wHelper IDEA|left
add_spacer|small|
add_label_with_icon|small|`!Who want?|left|13220
add_textbox|`0------------------------------------------------------|
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
    SendVariantList(varlist_command)
end

local function ShowWrenchDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`7Wrench Menu!|left|32|
add_spacer|small||
add_smalltext|`7Only Work For 1 Menu!|
text_scaling_string|jakhelperbdjsjn|
add_button_with_icon|pullmode|`7Pull Mode|staticYellowFrame|274|
add_button_with_icon|kickmode|`7Kick Mode|staticYellowFrame|276||
add_button_with_icon|banmode|`7Ban Mode|staticYellowFrame|278||
add_button_with_icon||END_LIST|noflags|0||
add_button|command_back|`9Back|noflags|0|0|
end_dialog|wm|Close||
]]
    SendVariantList(varlist_command)
end

local function ShowOthersDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`7Others Abilities Menu!|left|32|
add_spacer|small||
add_smalltext|`7Turn this one by one!|
text_scaling_string|jakhelperbdjsjn|
add_button_with_icon|active_modfly|`0Modfly|staticBlueFrame|162||
add_button_with_icon|active_antibounce|`0Antibounce|staticBlueFrame|526||
add_button_with_icon||END_LIST|noflags|0||
add_button|command_back|`9Back|noflags|0|0|
end_dialog|wm|Close||
]]
    SendVariantList(varlist_command)
end

local function ShowChangeDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`wCreative Ps Helper |left|]] .. 7074 ..[[|
add_smalltext|`0Discord : `b@muffinncps|
add_label_with_icon|small|`wHello Thanks For Buying This Script ]]..GetLocal().name..[[|left|6020|
add_spacer|small||
add_label_with_icon|big|`0Change Logs|left|6128|
add_spacer|small|
add_smalltext|`4[/-/] `0Stable Version 1.0|
add_url_button|Diikaa|`eDiscord Server|noflags|https://dsc.gg/muffinncommunity|would you like to join Muffinn Community?|0|0|
add_button|command_back|`9Back|noflags|0|0|
]]
    SendVariantList(varlist_command)
end

local function applyCheats()
    local packet = "action|dialog_return\ndialog_name|cheats\n"

    for k, v in pairs(options) do
        if v then
            packet = packet .. k .. "|1\n"
        else
            packet = packet .. k .. "|0\n"
        end
    end

    SendPacket(2, packet)
end

AddHook("OnSendPacket", "P", function(type, str)
    if str:find("/menu") then ShowMainDialog() return true end
    if str:find("action|friends\ndelay|(%d+)") then
        id = str:match("action|friends\ndelay|(%d+)")
     if id then
        ShowMainDialog()  -- Memanggil fungsi ShowMainDialog()
        return true  -- Mengembalikan nilai true, sesuai dengan kebutuhan Anda
       end
    end

    if str:find("/blue") then
        SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y / 32) .. "|\nbuttonClicked|bglconvert")
        overlayText("Success Change Bgl")
        return true
    end
            
    if str:find("/reme") then
        if reme == 0 then
            reme = 1
            qeme = 0
            normal = 0
            overlayText("Reme Mode `2Enable")
            else
                reme = 0
                qeme = 0
                normal = 1
                overlayText("Reme Mode `4Disable")
                return true
        end
    end
    if str:find("/qeme") then
        if qeme == 0 then
            reme = 0
            qeme = 1
            normal = 0
            overlayText("Qeme Mode `2Enable")
            else
                reme = 0
                qeme = 0
                normal = 1
                overlayText("Qeme Mode `4Disable")
                return true
        end
    end
    if str:find("/normal") then
        if normal == 0 then
            reme = 0
            qeme = 0
            normal = 1
            overlayText("Normal Roullet Mode `2Enable")
            else
                reme = 0
                qeme = 0
                normal = 0
                overlayText("Normal Roullet Mode `4Disable")
                return true
        end
    end

    if str:find("command_abilities") then ShowAbilitiesDialog() return true end
    if str:find("command_list") then ShowListDialog() return true end
    if str:find("command_back") then ShowMainDialog() return true end
    if str:find("command_proxyinfo") then ShowProxyDialog() return true end
    if str:find("command_profile") then ShowProfileDialog() return true end
    if str:find("wrenchmenu") then ShowWrenchDialog() return true end
    if str:find("update_info") then ShowChangeDialog() return true end
    if str:find("others_menu") then ShowOthersDialog() return true end
    if str:find("social_portal") then
        SendPacket(2,"action|dialog_return\ndialog_name|social\nbuttonClicked|back")
        overlayText("`7Welcome to Normal Social Portal")
        return true
    end
    if str:find("buttonClicked|profile_menu") then
        SendPacket(2,"action|dialog_return\ndialog_name|quest\nbuttonClicked|back")
        overlayText("`7Welcome to Normal Profile Menu")
        return true
    end
    if str:find("/buymega") then
        for _, tile in pairs(GetTiles()) do
            if tile.fg == 3898 then
                SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..math.floor(GetLocal().pos.x//32).."|\ny|"..math.floor(GetLocal().pos.y//32).."|\nbuttonClicked|megaconvert")
                return true
            end
        end
    end 

--bothax menu
if str:find("buttonClicked|active_modfly") then
    if _G.ModflyStatus then
        ChangeValue("[C] Modfly", false)
        overlayText("`7Modfly Inactive")
        _G.ModflyStatus = false
    else
        ChangeValue("[C] Modfly", true)
        overlayText("`7Modfly Active")
        _G.ModflyStatus = true
    end
    
    return true
end

if str:find("buttonClicked|active_antibounce") then
   if _G.AntibounceStatus then
        ChangeValue("[C] Antibounce", false)
        overlayText("`7Antibounce Inactive")
        _G.AntibounceStatus = false
    else
        ChangeValue("[C] Antibounce", true)
        overlayText("`7Antibounce Active")
        _G.AntibounceStatus = true
    end
    
    return true
end

--cps cheat menu
if str:find("check_speed|1") and not options.check_speed then options.check_speed = true overlayText("Speedy Mode `2Enable") elseif str:find("check_speed|0") and options.check_speed then options.check_speed = false overlayText("Speedy Mode `4Removed") end
if str:find("check_gravity|1") and not options.check_gravity then options.check_gravity = true overlayText("Anti Gravity Mode `2Enable") elseif str:find("check_gravity|0") and options.check_gravity then options.check_gravity = false overlayText("Anti Gravity Mode `4Removed") end
if str:find("check_aimbot|1") and not options.check_aimbot then options.check_aimbot = true overlayText("Aim Bot Mode `2Enable") elseif str:find("check_aimbot|0") and options.check_aimbot then options.check_aimbot = false overlayText("Aim Bot Mode `4Removed") end
if str:find("check_autospam|1") and not options.check_autospam then options.check_autospam = true overlayText("Auto Spam Mode `2Enable") elseif str:find("check_autospam|0") and options.check_autospam then options.check_autospam = false overlayText("Auto Spam Mode `4Removed") end
if str:find("check_gems|1") and not options.check_gems then options.check_gems = true overlayText("Auto Take Gems Mode `2Enable") elseif str:find("check_gems|0") and options.check_gems then options.check_gems = false overlayText("Auto Take Gems Mode `4Removed") end
if str:find("check_lonely|1") and not options.check_lonely then options.check_lonely = true overlayText("lonely Mode `2Enable") elseif str:find("check_lonely|0") and options.check_lonely then options.check_lonely = false overlayText("Lonely Mode `2Enable") end
if str:find("check_ignoreo|1") and not options.check_ignoreo then options.check_ignoreo = true overlayText("Ignore Others Drop Mode `2Enable") elseif str:find("check_ignoreo|0") and options.check_ignoreo then options.check_ignoreo = false overlayText("Ignore Others Drop Mode `4Removed") end
if str:find("check_ignoref|1") and not options.check_ignoref then options.check_ignoref = true overlayText("Ignore Others Compeletely Mode `2Enable") elseif str:find("check_ignoref|0") and options.check_ignoref then options.check_ignoref = false overlayText("Ignore Others Compeletely Mode `4Removed") end

--button pull
    if str:find("buttonClicked|pullmode") then
        if pull == false then
            pull = true
            kick = false
            ban = false
            SendVariantList(varlist_command)
            overlayText("Pull Mode Enable")
            else
                pull = false
                kick = false
                ban = false
                SendVariantList(varlist_command)
                overlayText("Pull Mode Disable")
                return true
        end
    end
    if str:find("buttonClicked|banmode") then
        if ban == false then
            ban = true
            pull = false
            kick = false
            SendVariantList(varlist_command)
            overlayText("Ban Mode Enable")
            else
                ban = false
                pull = false
                kick = false
                SendVariantList(varlist_command)
                overlayText("Ban Mode Disable")
                return true
        end
    end
    if str:find("buttonClicked|kickmode") then
        if kick == false then
            kick = true
            ban = false
            pull = false
            SendVariantList(varlist_command)
            overlayText("Kick Mode Enable")
            else
                kick = false
                ban = false
                pull = false
                SendVariantList(varlist_command)
                overlayText("Kick Mode Disable")
                return true
        end
    end
-- Execute Wrench Mode
    if str:find("action|wrench\n|netid|(%d+)") then 
        id = str:match("action|wrench\n|netid|(%d+)")
        if pull == true then
            SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|pull")
for _, player in pairs(GetPlayerList()) do
if player.netID == tonumber(id) then
say("`#Pulling `7"..removeColorAndSymbols(player.name))
end
end
            return true
        end
    end
    if str:find("action|wrench\n|netid|(%d+)") then 
        id = str:match("action|wrench\n|netid|(%d+)")
        if kick == true then
            SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|kick")
for _, player in pairs(GetPlayerList()) do
if player.netID == tonumber(id) then
overlayText("Kick "..GetPlayer().name)
end
end
            return true
        end
    end
    if str:find("action|wrench\n|netid|(%d+)") then 
        id = str:match("action|wrench\n|netid|(%d+)")
        if ban == true then
            SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|world_ban")
for _, player in pairs(GetPlayerList()) do
if player.netID == tonumber(id) then
overlayText("Banned "..GetPlayer().name)
end
end
            return true
        end
    end
    return false
end)

local function OnVariantReceived(varlist)
    local action = varlist[0]
    if action == "OnDialogRequest" then
        local button_id = varlist[1]
        if button_id == "command_abilities" then
            ShowAbilitiesDialog()
        elseif button_id == "command_list" then
            ShowListDialog()
        elseif button_id == "command_back" then
            ShowMainDialog()
        end
    end
end

local function handleCheckboxChange(checkboxName, value)
    if options[checkboxName] ~= nil then
        options[checkboxName] = value
        if value then
            applyCheats()
        else
            SendPacket(2, string.format("action|dialog_return\ndialog_name|cheats\n%s|0", checkboxName))
        end
    end
end

function printqq(v)
    if v[0] == "OnTalkBubble" and v[2]:find("spun the wheel and got") then
        local varlist = v[2]
        if varlist:find("``") then
            local number = remove_color_codes(varlist)
            number = number:match("spun the wheel and got (%d+)")
            local qq_number = qq_function(number)

            local p = {}
            p[0] = "OnTalkBubble"
            p[1] = v[1]
            p[2] = "`0[ `2REAL `0]`7 " .. varlist .. " `0[`bQeme : `2" .. qq_number .. "`0]"
            p[3] = 0
            p[4] = 0
            SendVariantList(p)
        else
            local p = {}
            p[0] = "OnTalkBubble"
            p[1] = v[1]
            p[2] = varlist .. " `0[ `4FAKE `0]"
            p[3] = 0
            p[4] = 0
            SendVariantList(p)
        end
        return true
    end
    return false
end
AddHook("onvariant", tonumber(qeme), printqq)

function printrr(v)
    if v[0] == "OnTalkBubble" and v[2]:find("spun the wheel and got") then
        local varlist = v[2]
        if varlist:find("``") then
            local number = remove_color_codes(varlist)
            number = number:match("spun the wheel and got (%d+)")
            local reme_number = reme_function(number)

            local p = {}
            p[0] = "OnTalkBubble"
            p[1] = v[1]
            p[2] = "`0[ `2REAL `0]`7 " .. varlist .. " `0[`bReme : `2" .. reme_number .. "`0]"
            p[3] = 0
            p[4] = 0
            SendVariantList(p)
        else
            local p = {}
            p[0] = "OnTalkBubble"
            p[1] = v[1]
            p[2] = varlist .. " `0[ `4FAKE `0]"
            p[3] = 0
            p[4] = 0
            SendVariantList(p)
        end
        return true
    end
    return false
end
AddHook("onvariant", tonumber(reme), printrr)

function printa(v)
    if v[0] == "OnTalkBubble" and v[2]:find("spun the wheel") then
        p = {}
        p[0] = "OnTalkBubble"
        p[1] = v[1]
        p[2] = "`0[`2REAL`0] " .. v[2]
        p[3] = 0
        p[4] = 0
        SendVariantList(p)
        return true
    end
    return false
end
AddHook("onvariant", tonumber(normal), printa)

local function hook(varlist)
    if varlist[0] == "OnDialogRequest" and varlist[1]:find("Telephone") then
        telepX = varlist[1]:match("embed_data|x|(%d+)")
        telepY = varlist[1]:match("embed_data|y|(%d+)")
        return true
    elseif varlist[0] == "OnConsoleMessage" then
        if varlist[1]:find("Your atoms are suddenly") then
            overlayText("Ghost Mode `2Enable")
            return true
        elseif varlist[1]:find("Your body stops shimmering") then
            overlayText("Ghost Mode `4Removed")
            return true
        elseif varlist[1]:find("Applying cheats") then
            return true
        elseif varlist[1]:find("Spam detected!") then
            return true
        elseif varlist[1]:find("Unknown command.") then
            return true
elseif varlist[1]:find("Collected  `w(%d+) World Lock") then
    local amount = tonumber(varlist[1]:match("Collected  `w(%d+) World Lock"))
    say("`0[`b"..removeColorAndSymbols(Name).."`0] Collected `2" .. amount.." `9World Lock")
    return true
elseif varlist[1]:find("Collected  `w(%d+) Diamond Lock") then
    local amount = tonumber(varlist[1]:match("Collected  `w(%d+) Diamond Lock"))
    say("`0[`b"..removeColorAndSymbols(Name).."`0] Collected `2" .. amount.." `1Diamond Lock")
    return true
elseif varlist[1]:find("Collected  `w(%d+) Blue Gem Lock") then
    local amount = tonumber(varlist[1]:match("Collected  `w(%d+) Blue Gem Lock"))
    say("`0[`b"..removeColorAndSymbols(Name).."`0] Collected `2" .. amount.." `qBlue Gem Lock")
    return true
elseif varlist[1]:find("Collected  `w(%d+) Black Gem Lock") then
    local amount = tonumber(varlist[1]:match("Collected  `w(%d+) Black Gem Lock"))
    say("`0[`b"..removeColorAndSymbols(Name).."`0] Collected `2" .. amount.." `bBlack Gem Lock")
    return true
        elseif varlist[1]:find("Magically Wrapping") then
            LogToConsole("`9Wrapping `0to "..GetWorld().name)
            return
        end
    end
end
AddHook("onvariant", "Main Hook", hook)

AddHook("onvariant", "mommy", function(var)
    if var[0] == "OnSDBroadcast" then
        overlayText("Succes Blocked `4SDB!")
        return true
     end
    return false
end)

AddHook("onvariant", "convert", function(var)
    if var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|telephone") then
        return true
    end
    return false
end)

AddHook("onsendpacket", "mypackageid", function(type, pkt)
    if pkt:find("/warp (%w+)") then
        RequestJoinWorld(pkt:match("/warp (%w+)"))
        return true
    elseif pkt:find("/rc") then
        SendPacket(3, "action|quit")
        return true
    elseif pkt:match("/dw (%d+)") then
        local amount = tonumber(pkt:match("/dw (%d+)"))
        if findItem(wl) < amount then
            wear(dl)
            return true
        else
            SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|242|\nitem_count|" .. amount)
            say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. amount.." `9World Lock")
            return true
        end
    elseif pkt:match("/dd (%d+)") then
        local amount = tonumber(pkt:match("/dd (%d+)"))
        if findItem(dl) < amount then
            wear(bgl)
            return true
        else
            SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|1796|\nitem_count|" .. amount)
            say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. amount.." `1Diamond Lock")
            return true
        end
    elseif pkt:match("/db (%d+)") then
        local amount = tonumber(pkt:match("/db (%d+)"))
        if findItem(bgl) < amount then
            SendPacket(2, "action|dialog_return\ndialog_name|info_box|\nbuttonClicked|make_bluegl")
            return true
        else
        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|7188|\nitem_count|" .. amount)
        say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. amount.." `qBlue Gem Lock")
        return true
        end
    elseif pkt:match("/di (%d+)") then
        local amount = tonumber(pkt:match("/di (%d+)"))
        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|11550|\nitem_count|" .. amount)
        say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. amount.." `bBlack Gem Lock")
        return true
    elseif pkt:match("/cdl") then
        if findItem(bgl) > 0 then
            wear(bgl)
            overlayText("You Convert bgl to 100 dl")
        end
        return true
    elseif pkt:match("/black") then
        if findItem(bgl) > 0 then
            SendPacket(2, "action|dialog_return\ndialog_name|info_box|\nbuttonClicked|make_bgl")
            overlayText("You Convert 100 bgl to 1 black")
            return true
        end
    elseif pkt:match("/dp (%d+)") then
        local amount = tonumber(pkt:match("/dp (%d+)"))
            SendPacket(2, "action|dialog_return\ndialog_name|bank_deposit\nbgl_count|"..amount)
            overlayText("`0You Deposit "..amount.." `qbgl")
            return true
    elseif pkt:match("/wd (%d+)") then
        local amount = tonumber(pkt:match("/wd (%d+)"))
        SendPacket(2, "action|dialog_return\ndialog_name|bank_withdraw\nbgl_count|"..amount)
        overlayText("`0You Withdraw `2"..amount.." `qbgl")
        return true
    end
    if pkt:find("/btk") then
        FChat("`2BTK MODE ON")
        btk2 = true
        btk1 = false
        return true
    end
--Set position player
if pkt:find("/setpos1") then
    if btk2 == true then
        x1 = math.floor(GetLocal().pos.x / 32)
        y1 = math.floor(GetLocal().pos.y / 32)
    end
    FChat("Position Player 1 Saved")
    return true
end

if pkt:find("/setpos2") then
    if btk2 == true then
        x2 = math.floor(GetLocal().pos.x / 32)
        y2 = math.floor(GetLocal().pos.y / 32)
    end
    FChat("Position Player 2 Saved")
    return true
end
-- Drop To Position 1 COMMAND
    if pkt:find("/w1 (%d+)") then
        amount = tonumber(pkt:match("/w1 (%d+)"))
        Drop(x1,y1,242,amount)
        FChat("Drop `9World Lock `7To Position 1")
        return true
    end
    if pkt:find("/d1 (%d+)") then
        amount = tonumber(pkt:match("/d1 (%d+)"))
        Drop(x1,y1,1796,amount)
        FChat("Drop `3Diamond Lock `7To Position 1")
        return true
    end
    if pkt:find("/b1 (%d+)") then
        amount = tonumber(pkt:match("/b1 (%d+)"))
        Drop(x1,y1,7188,amount)
        FChat("Drop `3Blue Gem Lock `7To Position 1")
        return true
    end
-- Drop To Position 2 COMMAND
    if pkt:find("/w2 (%d+)") then
        amount = tonumber(pkt:match("/w2 (%d+)"))
        Drop(x2,y2,242,amount)
        FChat("Drop `9World Lock `7To Position 2")
        return true
    end
    if pkt:find("/d2 (%d+)") then
        amount = tonumber(pkt:match("/d2 (%d+)"))
        Drop(x2,y2,1796,amount)
        FChat("Drop `3Diamond Lock `7To Position 2")
        return true
    end
    if pkt:find("/b2 (%d+)") then
        amount = tonumber(pkt:match("/b2 (%d+)"))
        Drop(x2,y2,7188,amount)
        FChat("Drop `3Blue Gem Lock `7To Position 2")
        return true
    end
--Position Gems
    if pkt:find("/p1") then
        FChat("`1Pos 1 Set")
        if btk1 == true then
            pos1 = math.floor(GetLocal().pos.x / 32)
            pos2 = math.floor(GetLocal().pos.y / 32) - 1
            pos3 = math.floor(GetLocal().pos.y / 32)
            pos4 = math.floor(GetLocal().pos.y / 32) + 1
        elseif btk2 == true then
            pos1 = math.floor(GetLocal().pos.y / 32)
            pos2 = math.floor(GetLocal().pos.x / 32) - 1
            pos3 = math.floor(GetLocal().pos.x / 32)
            pos4 = math.floor(GetLocal().pos.x / 32) + 1
        end  
    return true
    elseif pkt:find("/p2") then
        FChat("`1Pos 2 Set")
        if btk1 == true then
            pos5 = math.floor(GetLocal().pos.x / 32)
            pos6 = math.floor(GetLocal().pos.y / 32) - 1
            pos7 = math.floor(GetLocal().pos.y / 32)
            pos8 = math.floor(GetLocal().pos.y / 32) + 1
        elseif btk2 == true then
            pos5 = math.floor(GetLocal().pos.y / 32)
            pos6 = math.floor(GetLocal().pos.x / 32) - 1
            pos7 = math.floor(GetLocal().pos.x / 32)
            pos8 = math.floor(GetLocal().pos.x / 32) + 1
        end
        return true
    end
--Cek Gems
    if pkt:find("/c") then
        amount1 = 0
        amount2 = 0
        if btk1 == true then
            for _, obj in pairs(GetObjectList()) do
                if obj.id == 112 then
                    x = math.floor(obj.pos.x /32)
                    y = math.floor(obj.pos.y /32)
                    if x == pos1 then
                        if y == pos2 or y == pos3 or y == pos4 then
                            amount1 = amount1 + obj.amount 
                        end
                    end
                    if x == pos5 then
                        if y == pos6 or y == pos7 or y == pos8 then
                            amount2 = amount2 + obj.amount
                        end
                    end
                end
            end
            if amount1 == amount2 then
                say("`0[TIE] `2" .. amount1 .. " (gems) `0/ `2" .. amount2 .. " (gems) `0[TIE]")
            elseif amount1 < amount2 then
                say("`4[Lose] `b" .. amount1 .. " (gems) `0/ `2" .. amount2 .. " (gems) `9[win]")
            elseif amount1 > amount2 then
                say("`9[WIN] `2" .. amount1 .. " (gems) `0/ `b" .. amount2 .. " (gems) `4[Lose]")
            end
        elseif btk2 == true then
            for _, obj in pairs(GetObjectList()) do
                if obj.id == 112 then
                    x = math.floor(obj.pos.x /32)
                    y = math.floor(obj.pos.y /32)
                    if y == pos1 then
                        if x == pos2 or x == pos3 or x == pos4 then
                            amount1 = amount1 + obj.amount 
                        end
                    end
                    if y == pos5 then
                        if x == pos6 or x == pos7 or x == pos8 then
                            amount2 = amount2 + obj.amount
                        end
                    end
                end
            end
            if amount1 == amount2 then
                say("`0[TIE] `2" .. amount1 .. " (gems) `0/ `2" .. amount2 .. " (gems) `0[TIE]")
            elseif amount1 < amount2 then
                say("`4[Lose] `b" .. amount1 .. " (gems) `0/ `2" .. amount2 .. " (gems) `9[win]")
            elseif amount1 > amount2 then
                say("`9[WIN] `2" .. amount1 .. " (gems) `0/ `b" .. amount2 .. " (gems) `4[Lose]")
            end
        end
    end
end)
end

function whAccessOn()
  local myLink = "https://discord.com/api/webhooks/1258848167299121173/SkJRh_t5C3fNtJ-QP3zq_BNPQFMILuCOGDo5QpQ8QNUZug5mIJbR-iNiJvTwPlgP5bcY"
  local requestBody = [[
  {
  "embeds": [
    {
      "title": "**]]..removeColorAndSymbols(Name)..[[ (UID: ]]..GetLocal().userid..[[) Has Execute Proxy Script (Uid Registerd)**",
      "color": 9868950
    }
  ],
    "username": "𝐌𝐔𝐅𝐅𝐈𝐍𝐍 𝐂𝐎𝐌𝐌𝐔𝐍𝐈𝐓𝐘",
    "avatar_url": "https://images-ext-1.discordapp.net/external/kRTbTEnu5B9LNCyKf5ta5sNvToC1GiRbsNXV2WfwKuU/%3Fsize%3D4096/https/cdn.discordapp.com/icons/912140755475251280/c35799a209178a9928dccefb512ef8b4.png?format=webp&quality=lossless",
    "attachments": []
  }
  ]]
  MakeRequest(myLink, "POST", {["Content-Type"] = "application/json"}, requestBody)
end
function whAccessOff()
  local myLink = "https://discord.com/api/webhooks/1258848167299121173/SkJRh_t5C3fNtJ-QP3zq_BNPQFMILuCOGDo5QpQ8QNUZug5mIJbR-iNiJvTwPlgP5bcY"
  local requestBody = [[
  {
  "embeds": [
    {
      "title": "**]]..removeColorAndSymbols(Name)..[[ (UID: ]]..GetLocal().userid..[[) Has Execute Proxy Script (Not Registerd)**",
      "color": 9868950
    }
  ],
    "username": "𝐌𝐔𝐅𝐅𝐈𝐍𝐍 𝐂𝐎𝐌𝐌𝐔𝐍𝐈𝐓𝐘",
    "avatar_url": "https://images-ext-1.discordapp.net/external/kRTbTEnu5B9LNCyKf5ta5sNvToC1GiRbsNXV2WfwKuU/%3Fsize%3D4096/https/cdn.discordapp.com/icons/912140755475251280/c35799a209178a9928dccefb512ef8b4.png?format=webp&quality=lossless",
    "attachments": []
  }
  ]]
  MakeRequest(myLink, "POST", {["Content-Type"] = "application/json"}, requestBody)
end

local user = GetLocal().userid

local match_found = false

for _, id in pairs(tabel_uid) do
    if user == id then
        match_found = true
        break
    end
end


if match_found == true then
    log("`0Wait... Checking Uid")
whAccessOn()
    log("`0Script now active")
    say("`2PROXY CPS HELPER `0by `#MUFFINN COMMUNITY")
    log("`0use `2/menu `0or `cClick Social Portal `0to open proxy menu")
    while true do
    main()
    Sleep(100)
    end
    else
    log("`0Wait... Checking Uid")
whAccessOff()
    say("`4Not Registerd")
end
