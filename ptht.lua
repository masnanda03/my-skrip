--MUFFINN STORE--
tabel_uid = { 134611, 731670, 612468, 475429, 601763, 185650, 714689, 447487, 248228, 675313, 597946, 156990, 294780, 750484
}

EMPTY_MAGPLANT  = false
CHANGE_MAGPLANT = false
LEFT_MAG_X = CONFIG.World_setting.coordinate_magplant[1]

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

function IsReady(tile)
    if GetWorld() == nil then return false end
    
    if tile and tile.extra and tile.extra.progress and tile.extra.progress == 1.0 then
        return true
    end
    
    return false
end

function checkseed()
    if GetWorld() == nil then return 0 end
    
    local Ready = 0
    for y = CONFIG.World_setting.vertical_size[1] or 0, CONFIG.World_setting.vertical_size[2] do
        for x = CONFIG.World_setting.horizontal_size[1] or 0, CONFIG.World_setting.horizontal_size[2] do
            if IsReady(GetTile(x, y)) then
                Ready = Ready + 1
            end
        end
    end
    
    return Ready
end

function CheckEmptyTile()
    if GetWorld() == nil then return 0 end
    
    local m = 0
    for y = CONFIG.World_setting.vertical_size[1] or 0, CONFIG.World_setting.vertical_size[2] do
        for x = CONFIG.World_setting.horizontal_size[1] or 0, CONFIG.World_setting.horizontal_size[2] do
            local tile = GetTile(x, y)
            local tileBelow = GetTile(x, y + 1)
            
            if tile and tileBelow and tile.fg == 0 and tileBelow.collidable then
                m = m + 1
            end
        end
    end
    
    return m
end

function gscan(Id)
    if GetWorld() == nil then return 0 end
    
    local count = 0
    for y = CONFIG.World_setting.vertical_size[1] or 0, CONFIG.World_setting.vertical_size[2] do
        for x = CONFIG.World_setting.horizontal_size[1] or 0, CONFIG.World_setting.horizontal_size[2] do
            local tile = GetTile(x, y)
            if tile and tile.fg == Id and IsReady(tile) then
                count = count + 1
            end
        end
    end
    
    return count
end


function punch(x, y)
    if GetWorld() == nil then return end
    
    local pkt = {}
    pkt.type = 3
    pkt.value = 18
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    pkt.px = math.floor(GetLocal().pos.x / 32 + x)
    pkt.py = math.floor(GetLocal().pos.y / 32 + y)
    SendPacketRaw(false, pkt)
end

function place(id, x, y)
    if GetWorld() == nil then return end
    
    local pkt = {}
    pkt.type = 3
    pkt.value = id
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    pkt.px = math.floor(GetLocal().pos.x / 32 + x)
    pkt.py = math.floor(GetLocal().pos.y / 32 + y)
    SendPacketRaw(false, pkt)
end

function wrench(x, y)
    if GetWorld() == nil then return end
    
    local pkt = {}
    pkt.type = 3
    pkt.value = 32
    pkt.px = math.floor(GetLocal().pos.x / 32 + x)
    pkt.py = math.floor(GetLocal().pos.y / 32 + y)
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

function wear(id)
    if GetWorld() == nil then return end
    
    local pkt = {}
    pkt.type = 10
    pkt.value = id
    SendPacketRaw(false, pkt)
end

function checkWear(id)
    if GetWorld() == nil then return 0 end
    
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.flags
        end    
    end
    return 0
end

function findItem(id)
    if GetWorld() == nil then return 0 end
    
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

function getObject(id)
    if GetWorld() == nil then return end
    
    for _, obj in pairs(GetObjectList()) do
        if obj.id == CONFIG.World_setting.seed_id then
            x = math.floor(obj.pos.x / 32)
            y = math.floor(obj.pos.y / 32)
            FindPath(x, y, CONFIG.World_setting.delay_path or 100)
            Sleep(200)
            break
        end
    end
end

function cektree()
    if GetWorld() == nil then return end
    
    if CheckEmptyTile() == 0 and gscan(CONFIG.World_setting.seed_id) == 0 then
        Sleep(100)
        if CONFIG.World_setting.disable_uws == true then
            while CONFIG.World_setting.disable_uws == true do
                if GetWorld() == nil then return end
                Sleep(10)  
            end
        else
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Using UWS")
            Sleep(100)
            SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray")
            Sleep(4000)
        end
    elseif gscan(CONFIG.World_setting.seed_id) > 0 then
        LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvest Tree")
        Sleep(100)
        htmray()
    elseif CheckEmptyTile() ~= 0 then
        if GetWorld() == nil then return end
        
        if CHANGE_MAGPLANT then
            local tile = GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2])
            if tile and tile.fg == 5638 then
                CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                CheckRemote()
                Sleep(500)
            else
                CONFIG.World_setting.coordinate_magplant = LEFT_MAG_X
                CheckRemote()
                Sleep(200)
            end
            CHANGE_MAGPLANT = false
        end
    end
end

function CheckRemote()
    if GetWorld() == nil then return end
    
    if findItem(5640) < 1 or EMPTY_MAGPLANT then
        Sleep(200)
        FindPath(CONFIG.World_setting.coordinate_magplant[1], CONFIG.World_setting.coordinate_magplant[2] - 1, 100)
        wrench(0, 1)
        Sleep(100)
        SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|".. CONFIG.World_setting.coordinate_magplant[1] .."|\ny|" .. CONFIG.World_setting.coordinate_magplant[2] .. "|\nbuttonClicked|getRemote")
        Sleep(100)
    end

    if findItem(5640) >= 1 and EMPTY_MAGPLANT then
        EMPTY_MAGPLANT = false
    end
    Sleep(100)
    return findItem(5640) >= 1
end

function htmray()
    if checkseed() > 0 then
        if CONFIG.World_setting.harvest_type == "up" then
            for y = 0, 199 do
                for x = 0, 199 do
                    if GetWorld() == nil then 
                        return 
                    end
                    if GetTile(x, y).fg == CONFIG.World_setting.seed_id and IsReady(GetTile(x, y)) then
                        SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|1")
                        FindPath(x, y, CONFIG.World_setting.delay_path or 100)
                        Sleep(CONFIG.World_setting.delay_harvest)
                        punch(0, 0)
                        Sleep(CONFIG.World_setting.delay_harvest)
                    end
                end
            end
        elseif CONFIG.World_setting.harvest_type == "down" then
            for y = 199, 0, -1 do
                for x = 0, 199 do
                    if GetWorld() == nil then 
                        return 
                    end
                    if GetTile(x, y).fg == CONFIG.World_setting.seed_id and IsReady(GetTile(x, y)) then
                        SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|1")
                        FindPath(x, y, CONFIG.World_setting.delay_path or 100)
                        Sleep(CONFIG.World_setting.delay_harvest)
                        punch(0, 0)
                        Sleep(CONFIG.World_setting.delay_harvest)
                    end
                end
            end
        end
        Sleep(100)
    end
end

function plantfast()
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `2There is "..CheckEmptyTile().." Empty Tile Left")
    Sleep(100)

    if CONFIG.World_setting.ptht_type == "horizontal" then
        if CONFIG.World_setting.plant_type == "down" then
            count = 0
            for y = CONFIG.World_setting.vertical_size[2], CONFIG.World_setting.vertical_size[1], -2 do
                if count % 2 == 0 then
                    for x = CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.horizontal_size[2], 10 do
                        if GetWorld() == nil then return end
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x, y, CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640, 0, 0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                else
                    for x = CONFIG.World_setting.horizontal_size[2], CONFIG.World_setting.horizontal_size[1], -10 do
                        if GetWorld() == nil then return end
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x, y, CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640, 0, 0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                end
                count = count + 1
            end
        elseif CONFIG.World_setting.plant_type == "up" then
            count = 0
            for y = CONFIG.World_setting.vertical_size[1], CONFIG.World_setting.vertical_size[2], 2 do
                if count % 2 == 0 then
                    for x = CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.horizontal_size[2], 10 do
                        if GetWorld() == nil then return end
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x, y, CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640, 0, 0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                else
                    for x = CONFIG.World_setting.horizontal_size[2], CONFIG.World_setting.horizontal_size[1], -10 do
                        if GetWorld() == nil then return end
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x, y, CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640, 0, 0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                end
                count = count + 1
            end
        end
    elseif CONFIG.World_setting.ptht_type == "vertical" then
        if CONFIG.World_setting.plant_type == "down" then
            for x = CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.horizontal_size[2], 10 do
                if GetWorld() == nil then return end
                local yStart, yEnd, yIncrement
                if x % 20 == 0 then -- Saat iterasi x adalah kelipatan 20, kita mulai dari bawah
                    yStart = CONFIG.World_setting.vertical_size[2]
                    yEnd = CONFIG.World_setting.vertical_size[1]
                    yIncrement = -1
                else -- Iterasi x biasa, kita mulai dari atas
                    yStart = CONFIG.World_setting.vertical_size[1]
                    yEnd = CONFIG.World_setting.vertical_size[2]
                    yIncrement = 1
                end

                for y = yStart, yEnd, yIncrement do
                    if GetWorld() == nil then return end
                    if EMPTY_MAGPLANT then return end
                    if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                        FindPath(x, y, CONFIG.World_setting.delay_path)
                        Sleep(CONFIG.World_setting.delay_plant)
                        place(5640, 0, 0)
                        Sleep(CONFIG.World_setting.delay_plant)
                    end
                end
            end
        elseif CONFIG.World_setting.plant_type == "up" then
            for x = CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.horizontal_size[2], 10 do
                if GetWorld() == nil then return end
                local yStart, yEnd, yIncrement
                if x % 20 == 0 then -- Saat iterasi x adalah kelipatan 20, kita mulai dari atas
                    yStart = CONFIG.World_setting.vertical_size[1]
                    yEnd = CONFIG.World_setting.vertical_size[2]
                    yIncrement = 1
                else -- Iterasi x biasa, kita mulai dari bawah
                    yStart = CONFIG.World_setting.vertical_size[2]
                    yEnd = CONFIG.World_setting.vertical_size[1]
                    yIncrement = -1
                end

                for y = yStart, yEnd, yIncrement do
                    if GetWorld() == nil then return end
                    if EMPTY_MAGPLANT then return end
                    if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                        FindPath(x, y, CONFIG.World_setting.delay_path)
                        Sleep(CONFIG.World_setting.delay_plant)
                        place(5640, 0, 0)
                        Sleep(CONFIG.World_setting.delay_plant)
                    end
                end
            end
        end
    else
        say("`2Not Added")
    end
end

function nambal()
    count = 0
    for y= CONFIG.World_setting.vertical_size[2],CONFIG.World_setting.vertical_size[1],-2 do
        if count%2 == 0 then
            for x= CONFIG.World_setting.horizontal_size[2],CONFIG.World_setting.horizontal_size[1],-1 do
if GetWorld() == nil then return end
                if EMPTY_MAGPLANT then return end
                if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable and GetTile(x,y+1).fg ~= CONFIG.World_setting.seed_id then
                    FindPath(x,y,CONFIG.World_setting.delay_path)
                    Sleep(CONFIG.World_setting.delay_plant)
                    place(5640,0,0)
                    Sleep(30)
                end
            end
        else
            for x= CONFIG.World_setting.horizontal_size[1],CONFIG.World_setting.horizontal_size[2],1 do
if GetWorld() == nil then return end
                if EMPTY_MAGPLANT then return end
                if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable and GetTile(x,y+1).fg ~= CONFIG.World_setting.seed_id then
                    FindPath(x,y,CONFIG.World_setting.delay_path)
                    Sleep(CONFIG.World_setting.delay_plant)
                    place(5640,0,0)
                    Sleep(30)
                end
            end
        end
        count = count+1
    end
end

function powershell(message)
if GetWorld() == nil then return end

local username = "MUFFINN COMMUNITY"
local avatarUrl = "https://media.discordapp.net/attachments/1136847163905818636/1196094627372073041/MUFFINN_STORE_ICON.png?ex=65edbfed&is=65db4aed&hm=405bfb4e8ff9ecc2eb3493d5ae6bd7e9ec2c0ef0f9ea87e536a90b2219bf8edd&format=webp&quality=lossless&" --Thumbnail url
local warna = "3333333"
local script = [[
$webHookUrl = ']]..CONFIG.Webhook_setting.webhook_url..[['

$host.ui.RawUI.WindowTitle = ""
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Collections.ArrayList]$embedArray = @()
$title       = 'AUTO PTHT ADVANCE'
$description = ']] .. message .. [['
$color       = ']] .. warna .. [['
$cpu = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average).Average
$ram = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue
 
        $embedObject = [PSCustomObject]@{
            title       = $title
            description = "$description`r`n<a:api:1213888009942859788> | Cpu : $cpu%`n<a:api:1213888009942859788> | Ram : $ram MB"
            color       = $color
            thumbnail   = $thumbnailObject
        }
 
$embedArray.Add($embedObject) | Out-Null
$payload = [PSCustomObject]@{
    embeds = $embedArray
    username = ']] .. username .. [['
    avatar_url = ']] .. avatarUrl .. [['
}
 
Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
]]
 
local pipe = io.popen("powershell -command -", "w")
  pipe:write(script)
  pipe:close()
end

function formatNumber(n)
    n = tostring(n)
    return n:reverse():gsub("...","%0,",math.floor((#n-1)/3)):reverse()
end

local start_time = os.time()

function get_uptime()
  local current_time = os.time()
  local uptime = os.difftime(current_time, start_time)
  return uptime
end

function format_time(seconds)
  local days = math.floor(seconds / 86400)
  local hours = math.floor(seconds / 3600) % 24
  local minutes = math.floor(seconds / 60) % 60
  return string.format("%d DAY : %02d HOURS : %02d MINUTE", days, hours, minutes)
end

function pshell(txt)
if GetWorld() == nil then return end
powershell([[
===============================
**<a:crown:1146478446768291932> ACCOUNT INFO** 
<:player:1203057110208876656> Name :  ]]..GetLocal().name:gsub("`[%d%p%c%s]*", ""):gsub("`[%p%c%s]", "")..[[

<:GemSprites2:1116878075964166154> Gems Owned :   ]]..formatNumber(GetPlayerInfo().gems)..[[

<a:BINTANG:1200831937900724224> Task : ]]..txt..[[

===============================
**<a:info3:1134720052126564382> BACKPACK INFO**
<:uws:1194831699859746867> Ultra World Spray : ]]..findItem(12600)..[[

===============================
**<a:info3:1134720052126564382> WORLD INFO**
<:world:1203057112595562628> World Name :    ]]..string.upper(GetWorld().name)..[[

===============================
**<a:time:1203650182164512769> UPTIME**
<a:loading:1138845537194483803> ]].. format_time(get_uptime())..[[

===============================
**<a:info1:1130833174327463956> PC INFO**]])
end

function hook(varlist)
    if varlist[0]:find("OnSDBroadcast") then
        return true
    end
    if varlist[0]:find("OnTalkBubble") and (varlist[2]:find("The MAGPLANT 5000 is empty")) then
        CHANGE_MAGPLANT = true
        EMPTY_MAGPLANT = true
        return true
    end
    if varlist[0] == "OnTalkBubble" and varlist[2]:find("You received a MAGPLANT 5000 Remote.") then
        return true
    end
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("magplant_edit") then
        local x = varlist[1]:match('embed_data|x|(%d+)')
        local y = varlist[1]:match('embed_data|y|(%d+)')
        return true
    end
    if varlist[0]:find("OnDialogRequest") and (varlist[1]:find("Item Finder") or varlist[1]:find("The MAGPLANT 5000 is disabled.")) then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Cheat Active") then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Whoa, calm down toggling cheats on/off... Try again in a second!") then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Applying cheats...") then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("You're now") then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Cheat Disable:") then
        return true
    end
end
AddHook("onvariant", "Main Hook", hook)

local function ontext(str)
    SendVariantList({[0] = "OnTextOverlay", [1]  = str })
end

local user = GetLocal().userid

local match_found = false

for _, id in pairs(tabel_uid) do
    if GetLocal().userid == tonumber(id) then
        match_found = true
        break
    end
end

if match_found then
    ChangeValue("[C] Modfly", true)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^UID TERDAFTAR")
    Sleep(1000)
    say("`2SC PTHT UWS AUTO RECONNECT v2.0 BY `^MUFFINN STORE")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^MODE PLANT : " ..CONFIG.World_setting.ptht_type)
    Sleep(2000)

LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Wait...")
CheckRemote()
while true do
if CONFIG.Webhook_setting.disable_webhook == true then
  while true do
    if GetWorld() == nil or GetWorld().name ~= CONFIG.World_setting.WORLD_NAME then
        ontext("`2REJOIN CURRENT WORLD : `0" .. CONFIG.World_setting.WORLD_NAME)
        SendPacket(3, "action|join_request\nname|"..CONFIG.World_setting.WORLD_NAME.."\ninvitedWORLD_NAME|0")
        Sleep(7000)
        ontext("`2You Are Reconnected!")

        -- Check if reconnected and try CheckRemote()
        if GetWorld() ~= nil and GetWorld().name == CONFIG.World_setting.WORLD_NAME then
            CheckRemote()
        end
    else
        if CheckEmptyTile() == 0 then
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Check Tree")
            if findItem(12600) == 0 then
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `4Ultra World Spray is not available!")
                return
            else
                cektree()  -- Panggil cektree() jika UWS tersedia
            end
        end

        while checkseed() > 0 do
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvest Tree")
            SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|1")
            htmray()
        end

        while CheckEmptyTile() ~= 0 and CHANGE_MAGPLANT do
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Change Remote")
            if GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg == 5638 then
                CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                CheckRemote()
                Sleep(500)
            elseif GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg ~= 5638 then
                CONFIG.World_setting.coordinate_magplant = LEFT_MAG_X
                CheckRemote()
                Sleep(500)
            end
            CHANGE_MAGPLANT = false
        end

            if GetWorld() and GetLocal().pos.y //32 >= CONFIG.World_setting.vertical_size[1] and GetLocal().pos.y //32 <= CONFIG.World_setting.vertical_size[2] then
                if GetWorld() and GetLocal().pos.x //32 >= CONFIG.World_setting.horizontal_size[1] or GetLocal().pos.x //32 <= CONFIG.World_setting.horizontal_size[2] then
                    Sleep(500)
                    place(5640,0,0)
                    Sleep(100)
                    SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|1\ncheck_gems|1")
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                    plantfast()
                    Sleep(100)
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Nambal")
                    nambal()
                end
            else
                FindPath(CONFIG.World_setting.horizontal_size[1],CONFIG.World_setting.vertical_size[2],100)
                Sleep(1000)
                place(5640,0,0)
                Sleep(100)
                SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|1\ncheck_gems|1")
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                plantfast()
                Sleep(100)
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Nambal")
                nambal()
            end
        end
    end
end

if CONFIG.Webhook_setting.disable_webhook == false then
    while true do
        if GetWorld() == nil or GetWorld().name ~= CONFIG.World_setting.WORLD_NAME then
            ontext("`2REJOIN CURRENT WORLD : `0" .. CONFIG.World_setting.WORLD_NAME)
            SendPacket(3, "action|join_request\nname|"..CONFIG.World_setting.WORLD_NAME.."\ninvitedWORLD_NAME|0")
            Sleep(7000)
            ontext("`2You Are Reconnected!")
            pshell("Reconnected!")
            -- Check if reconnected and try CheckRemote()
            if GetWorld() ~= nil and GetWorld().name == CONFIG.World_setting.WORLD_NAME then
                CheckRemote()
            end
        else
        if CheckEmptyTile() == 0 then
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Check Tree")
            if findItem(12600) == 0 then
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `4Ultra World Spray is not available!")
                pshell("Uws Not Available")
                return
            else
                cektree()  -- Panggil cektree() jika UWS tersedia
            end
        end

            while checkseed() > 0 do
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvest Tree")
                pshell("Harvest Tree")
                SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|1")
                htmray()
            end

            while CheckEmptyTile() ~= 0 and CHANGE_MAGPLANT do
                if GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg == 5638 then
                    CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                    CheckRemote()
                    Sleep(100)
                elseif GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg ~= 5638 then
                    ontext("Magplant empty")
                    CONFIG.World_setting.coordinate_magplant = LEFT_MAG_X
                    CheckRemote()
                    Sleep(100)
                end
                CHANGE_MAGPLANT = false
            end

            if GetWorld() and GetLocal().pos.y // 32 >= CONFIG.World_setting.vertical_size[1] and GetLocal().pos.y // 32 <= CONFIG.World_setting.vertical_size[2] then
                if GetWorld() and GetLocal().pos.x // 32 >= CONFIG.World_setting.horizontal_size[1] and GetLocal().pos.x // 32 <= CONFIG.World_setting.horizontal_size[2] then
                    Sleep(500)
                    place(5640, 0, 0)
                    Sleep(100)
                    SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|1\ncheck_gems|1")
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                    pshell("Plant Tree")
                    plantfast()
                    Sleep(100)
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Nambal")
                    pshell("Nambal")
                    nambal()
                end
            else
                FindPath(CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.vertical_size[2], 100)
                Sleep(500)
                place(5640, 0, 0)
                Sleep(100)
                SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|1\ncheck_gems|1")
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                pshell("Plant Tree")
                plantfast()
                Sleep(100)
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Nambal")
                pshell("Nambal")
                nambal()
              end
           end
        end
    end
end

else
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    say("`4UID Not Found")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `4UID TIDAK TERDAFTAR KONTAK DISCORD MUFFINN_S")
end
