--MUFFINN STORE--
tabel_uid = { 134611
}

EMPTY_MAGPLANT  = false
CHANGE_MAGPLANT = false
LEFT_MAG_X = CONFIG.World_setting.coordinate_magplant[1]

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

function IsReady(tile)
if GetWorld() == nil then return end
    if tile and tile.extra and tile.extra.progress and tile.extra.progress == 1.0 then
        return true
    end
    return false
end

function checkseed()
    local Ready = 0
    for y = CONFIG.World_setting.vertical_size[1] or 0,CONFIG.World_setting.vertical_size[2] do
        for x = CONFIG.World_setting.horizontal_size[1] or 0,CONFIG.World_setting.horizontal_size[2] do
            if IsReady(GetTile(x,y)) then
                Ready = Ready + 1
            end
        end
    end
    return Ready
end

function CheckEmptyTile()
    local m=0
    for y = CONFIG.World_setting.vertical_size[1] or 0,CONFIG.World_setting.vertical_size[2] do
        for x = CONFIG.World_setting.horizontal_size[1] or 0,CONFIG.World_setting.horizontal_size[2] do
            if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable then
            m = m + 1
            end
        end
    end
return m
end

function gscan(Id)
    count = 0
    for y = CONFIG.World_setting.vertical_size[1] or 0,CONFIG.World_setting.vertical_size[2] do
        for x = CONFIG.World_setting.horizontal_size[1] or 0,CONFIG.World_setting.horizontal_size[2] do
            if GetTile(x,y).fg == Id and IsReady(GetTile(x,y)) then
            count = count + 1
            end
        end
    end
    return count
end

function punch(x,y)
    local pkt = {}
    pkt.type = 3
    pkt.value = 18
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y 
    pkt.px = math.floor(GetLocal().pos.x / 32 + x)
    pkt.py = math.floor(GetLocal().pos.y / 32 + y)
    SendPacketRaw(false,pkt)
end

function place(id,x,y)
    pkt = {}
    pkt.type = 3
    pkt.value = id
    pkt.px = math.floor(GetLocal().pos.x / 32 +x)
    pkt.py = math.floor(GetLocal().pos.y / 32 +y)
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

function wrench(x,y)
    pkt = {}
    pkt.type = 3
    pkt.value = 32
    pkt.px = math.floor(GetLocal().pos.x / 32 +x)
    pkt.py = math.floor(GetLocal().pos.y / 32 +y)
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

function wear(id)
    pkt = {}
    pkt.type = 10
    pkt.value = id
    SendPacketRaw(false, pkt)
end

function checkWear(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.flags
        end    
    end
    return 0
end

function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

function getObject(id)
    for _, obj in pairs(GetObjectList()) do
        if obj.id == CONFIG.World_setting.seed_id then
            x = math.floor(obj.pos.x /32)
            y = math.floor(obj.pos.y /32)
            FindPath(x,y,CONFIG.World_setting.delay_path or 100)
            Sleep(1000)
            break
        end
    end
end

function cektree()
    if CheckEmptyTile() == 0 and gscan(CONFIG.World_setting.seed_id) == 0 then
        Sleep(100)
        if CONFIG.World_setting.disable_uws == true then
            while CONFIG.World_setting.disable_uws == true do
              Sleep(10)  
            end
        else
            pshell("Using Ultra World Spray")
            Sleep(100)
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Using UWS")
            SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray")
            Sleep(100)
        end
    elseif gscan(CONFIG.World_setting.seed_id) > 0 then
        pshell("Using Ultra World Spray")
        Sleep(100)
        LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvest Tree")
        Sleep(1000)
        htmray()
    elseif CheckEmptyTile() ~= 0 then
        if CHANGE_MAGPLANT then
            if GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg == 5638 then
                CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                CheckRemote()
                Sleep(800)
            elseif GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg ~= 5638 then
                CONFIG.World_setting.coordinate_magplant = LEFT_MAG_X
                CheckRemote()
                Sleep(800)
            end
            CHANGE_MAGPLANT = false
        end
        if GetLocal().pos.y //32 >= CONFIG.World_setting.vertical_size[1] and GetLocal().pos.y //32 <= CONFIG.World_setting.vertical_size[2] then
            if  GetLocal().pos.x //32 >= CONFIG.World_setting.horizontal_size[1] or GetLocal().pos.x //32 <= CONFIG.World_setting.horizontal_size[2] then
                Sleep(100)
                place(5640,0,0)
                Sleep(100)
                SendPacket(2,[[action|dialog_return
                dialog_name|cheats
                check_autofarm|0
                check_bfg|0
                check_autospam|0
                check_autopull|0
                check_autoplace|1
                check_antibounce|0
                check_modfly|0
                check_speed|0
                check_gravity|0
                check_lonely|0
                check_fastdrop|0
                check_gems|1
                check_ignoreo|0]])
                Sleep(100)
                plantfast()
                Sleep(500)
                nambal()
                Sleep(500)
            end
        else
            FindPath(CONFIG.World_setting.horizontal_size[1],CONFIG.World_setting.vertical_size[2],100)
            Sleep(100)
            place(5640,0,0)
            Sleep(100)
            SendPacket(2,[[action|dialog_return
            dialog_name|cheats
            check_autofarm|0
            check_bfg|0
            check_autospam|0
            check_autopull|0
            check_autoplace|1
            check_antibounce|0
            check_modfly|0
            check_speed|0
            check_gravity|0
            check_lonely|0
            check_fastdrop|0
            check_gems|1
            check_ignoreo|0]])
            Sleep(100)
            plantfast()
            Sleep(500)
            nambal()
            Sleep(500)
        end
    end
end

function CheckRemote()
    if findItem(5640) < 1 or EMPTY_MAGPLANT then
        Sleep(800)
        FindPath(CONFIG.World_setting.coordinate_magplant[1], CONFIG.World_setting.coordinate_magplant[2] - 1, 100)
        wrench(0,1)
        Sleep(500)
        SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|".. CONFIG.World_setting.coordinate_magplant[1] .."|\ny|" .. CONFIG.World_setting.coordinate_magplant[2] .. "|\nbuttonClicked|getRemote")
        Sleep(200)
        end

    if findItem(5640) >= 1 and EMPTY_MAGPLANT then
        EMPTY_MAGPLANT = false
    end
    Sleep(800)
    return findItem(5640) >= 1
end

function htmray()
    if checkseed() > 0 then
        if CONFIG.World_setting.harvest_type == "up" then
            for y= 0, 199 do
                for x = 0, 199 do
                    if GetTile(x,y).fg == CONFIG.World_setting.seed_id and IsReady(GetTile(x,y)) then
                        FindPath(x,y,CONFIG.World_setting.delay_path or 100)
                        Sleep(CONFIG.World_setting.delay_harvest)
                        punch(0,0)
                        Sleep(CONFIG.World_setting.delay_harvest)
                    end
                end
            end
        elseif CONFIG.World_setting.harvest_type == "down" then
            for y = 199,0,-1 do
                for x = 0, 199 do
                    if GetTile(x,y).fg == CONFIG.World_setting.seed_id and IsReady(GetTile(x,y)) then
                        FindPath(x,y,CONFIG.World_setting.delay_path or 100)
                        Sleep(CONFIG.World_setting.delay_harvest)
                        punch(0,0)
                        Sleep(CONFIG.World_setting.delay_harvest)
                    end
                end
            end
        end
    Sleep(500)
    end
end

function plantfast()

        LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `2There is "..CheckEmptyTile().." Empty Tile Left")
        Sleep(1000)
    if CONFIG.World_setting.ptht_type == "horizontal" then
        if CONFIG.World_setting.plant_type == "down" then
            count = 0
            for y= CONFIG.World_setting.vertical_size[2],CONFIG.World_setting.vertical_size[1],-2 do
                if count%2 == 0 then
                    for x= CONFIG.World_setting.horizontal_size[1],CONFIG.World_setting.horizontal_size[2],10 do
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable and GetTile(x,y+1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x,y,CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640,0,0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                else
                    for x= CONFIG.World_setting.horizontal_size[2],CONFIG.World_setting.horizontal_size[1],-10 do
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable and GetTile(x,y+1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x,y,CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640,0,0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                end
                count = count+1
            end
        elseif CONFIG.World_setting.plant_type == "up" then
            count = 0
            for y= CONFIG.World_setting.vertical_size[1],CONFIG.World_setting.vertical_size[2] do
                if count%2 == 0 then
                    for x= CONFIG.World_setting.horizontal_size[1],CONFIG.World_setting.horizontal_size[2],10 do
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable and GetTile(x,y+1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x,y,CONFIG.World_setting.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640,0,0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                else
                    for x= CONFIG.World_setting.horizontal_size[2],CONFIG.World_setting.horizontal_size[1],-10 do
                        if EMPTY_MAGPLANT then return end
                        if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable and GetTile(x,y+1).fg ~= CONFIG.World_setting.seed_id then
                            FindPath(x,y,CONFIG.Fast_plant.delay_path)
                            Sleep(CONFIG.World_setting.delay_plant)
                            place(5640,0,0)
                            Sleep(CONFIG.World_setting.delay_plant)
                        end
                    end
                end
                count = count+1
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

username = "MUFFINN COMMUNITY"
avatarUrl = "https://media.discordapp.net/attachments/1136847163905818636/1196094627372073041/MUFFINN_STORE_ICON.png?ex=65edbfed&is=65db4aed&hm=405bfb4e8ff9ecc2eb3493d5ae6bd7e9ec2c0ef0f9ea87e536a90b2219bf8edd&format=webp&quality=lossless&" --Thumbnail url
warna = "3333333" --Colour embed

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
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Where would you like to go?") then
        getworld = true
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
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Disconnected?! Will attempt to reconnect...") then
        getworld = true
        return true
    end
    if varlist[0] == "OnConsoleMessage" and varlist[1]:find("World Locked") then
        CheckRemote()
        getworld = false
        return true
    end
end
AddHook("onvariant", "Main Hook", hook)

function JoinWorld()
    if getworld == true then
    LogToConsole("`2Request Join World : "..CONFIG.World_setting.WORLD_NAME)
    SendPacket(3, "action|join_request\nname|"..CONFIG.World_setting.WORLD_NAME.."\ninvitedWORLD_NAME|0")
    Sleep(2300)
    getworld = false
  end
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
    Sleep(2000)

    pshell("Check World")
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^World : `2 "..CONFIG.World_setting.WORLD_NAME)
    if GetWorld().name ~= string.upper(CONFIG.World_setting.WORLD_NAME) then
    LogToConsole("`^MUFFINN`0-`^STORE`0] : `4World Invalid!")
    pshell("World Invalid!")
    Sleep(1000)
    LogToConsole("`^MUFFINN`0-`^STORE`0] : `^Request Join World")
    pshell("Request to Join World!")
    RequestJoinWorld(CONFIG.World_setting.WORLD_NAME)
    Sleep(5000)
    end


    if CONFIG.Webhook_setting.disable_webhook == false then
            while true do
                Sleep(2300)
                if getworld == true then
                   JoinWorld()
                   getworld = false
                end

                CheckRemote()
                if CheckEmptyTile() == 0 then
                    pshell("Check Tree")
                    Sleep(100)
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Check Tree")
                    Sleep(1000)
                    cektree()
                    Sleep(2000)
                end

                while checkseed() > 0 do
                    pshell("Harvest Tree")
                    Sleep(100)
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvest Tree")
                    Sleep(1000)
                    htmray()
                    Sleep(2000)
                end

                while CheckEmptyTile() ~= 0 do
                    if CHANGE_MAGPLANT then
                        if GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg == 5638 then
                            CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                            CheckRemote()
                            Sleep(800)
                        elseif GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg ~= 5638 then
                            CONFIG.World_setting.coordinate_magplant = LEFT_MAG_X
                            CheckRemote()
                            Sleep(800)
                        end
                        CHANGE_MAGPLANT = false
                    end

                    if GetLocal().pos.y //32 >= CONFIG.World_setting.vertical_size[1] and GetLocal().pos.y //32 <= CONFIG.World_setting.vertical_size[2] then
                        if  GetLocal().pos.x //32 >= CONFIG.World_setting.horizontal_size[1] or GetLocal().pos.x //32 <= CONFIG.World_setting.horizontal_size[2] then
                            Sleep(1000)
                            place(5640,0,0)
                            Sleep(100)
                            SendPacket(2,[[action|dialog_return
                            dialog_name|cheats
                            check_autofarm|0
                            check_bfg|0
                            check_autospam|0
                            check_autopull|0
                            check_autoplace|1
                            check_antibounce|0
                            check_modfly|0
                            check_speed|0
                            check_gravity|0
                            check_lonely|0
                            check_fastdrop|0
                            check_gems|1
                            check_ignoreo|0]])
                            Sleep(1000)
                            pshell("Plant Tree")
                            Sleep(100)
                            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                            Sleep(1000)
                            plantfast()
                            Sleep(1000)
                            pshell("Nambal")
                            Sleep(100)
                            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Nambal")
                            Sleep(1000)
                            nambal()
                            Sleep(1000)
                        end
                    else
                        FindPath(CONFIG.World_setting.horizontal_size[1],CONFIG.World_setting.vertical_size[2],100)
                        Sleep(1000)
                        place(5640,0,0)
                        Sleep(100)
                        SendPacket(2,[[action|dialog_return
                        dialog_name|cheats
                        check_autofarm|0
                        check_bfg|0
                        check_autospam|0
                        check_autopull|0
                        check_autoplace|1
                        check_antibounce|0
                        check_modfly|0
                        check_speed|0
                        check_gravity|0
                        check_lonely|0
                        check_fastdrop|0
                        check_gems|1
                        check_ignoreo|0]])
                        Sleep(1000)
                        LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                        Sleep(1000)
                        plantfast()
                        Sleep(1000)
                        LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Nambal")
                        Sleep(1000)
                        nambal()
                        Sleep(1000)
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
