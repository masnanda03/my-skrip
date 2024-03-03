--MUFFINN STORE--
tabel_uid = {134611}

EMPTY_MAGPLANT  = false
CHANGE_MAGPLANT = false
LEFT_MAG_X = CONFIG.World_setting.coordinate_magplant[1]

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

function IsReady(tile)
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
        for x = CONFIG..horizontal_size[1] or 0,CONFIG..horizontal_size[2] do
            if GetTile(x,y).fg == 0 and GetTile(x,y+1).collidable then
            m = m + 1
            end
        end
    end
return m
end

function gscan(Id)
    count = 0
    for y = CONFIG..vertical_size[1] or 0,CONFIG..vertical_size[2] do
        for x = CONFIG..horizontal_size[1] or 0,CONFIG..horizontal_size[2] do
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
        if obj.id == CONFIG..seed_id then
            x = math.floor(obj.pos.x /32)
            y = math.floor(obj.pos.y /32)
            FindPath(x,y,CONFIG..delay_path or 100)
            Sleep(1000)
            break
        end
    end
end

function cektree()
    if CheckEmptyTile() == 0 and gscan(CONFIG..seed_id) == 0 then
        Sleep(100)
        if CONFIG..disable_uws == true then
            while CONFIG..disable_uws == true do
              Sleep(10)  
            end
        else
            SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray")
            Sleep(100)
        end
    elseif gscan(CONFIG..seed_id) > 0 then
        Sleep(1000)
        htmray()
    elseif CheckEmptyTile() ~= 0 then
        if CHANGE_MAGPLANT then
            if GetTile(CONFIG..coordinate_magplant[1] + 1, CONFIG..coordinate_magplant[2]).fg == 5638 then
                CONFIG..coordinate_magplant[1] = CONFIG..coordinate_magplant[1] + 1
                CheckRemote()
                Sleep(800)
            elseif GetTile(CONFIG..coordinate_magplant[1] + 1, CONFIG..coordinate_magplant[2]).fg ~= 5638 then
                CONFIG..coordinate_magplant = LEFT_MAG_X
                CheckRemote()
                Sleep(800)
            end
            CHANGE_MAGPLANT = false
        end
        if GetLocal().pos.y //32 >= CONFIG..vertical_size[1] and GetLocal().pos.y //32 <= CONFIG..vertical_size[2] then
            if  GetLocal().pos.x //32 >= CONFIG..horizontal_size[1] or GetLocal().pos.x //32 <= CONFIG..horizontal_size[2] then
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
            FindPath(CONFIG..horizontal_size[1],CONFIG.World_setting.vertical_size[2],100)
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
    if GetWorld() == nil then return end
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
if GetWorld() == nil then return end
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
if GetWorld() == nil then return end
        LogToConsole("`1[GSC] `2There is "..CheckEmptyTile().." Empty Tile Left")
    if CONFIG.World_setting.ptht_type == "vertical" then
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
if GetWorld() == nil then return end
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

function hook(varlist)
    if varlist[0]:find("OnTalkBubble") and (varlist[2]:find("The MAGPLANT 5000 is empty")) then
        CHANGE_MAGPLANT = true
        EMPTY_MAGPLANT = true
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat dialog magplant_edit
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("magplant_edit") then
        local x = varlist[1]:match('embed_data|x|(%d+)')
        local y = varlist[1]:match('embed_data|y|(%d+)')
        CONFIG.World_setting.coordinate_magplant = {tonumber(x), tonumber(y)}
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat dialog "Item Finder" atau "The MAGPLANT 5000 is disabled."
    if varlist[0]:find("OnDialogRequest") and (varlist[1]:find("Item Finder") or varlist[1]:find("The MAGPLANT 5000 is disabled.")) then
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat pesan konsol "Cheat Active"
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Cheat Active") then
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat pesan konsol "Whoa, calm down toggling cheats on/off... Try again in a second!"
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Whoa, calm down toggling cheats on/off... Try again in a second!") then
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat pesan konsol "Applying cheats..."
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Applying cheats...") then
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat pesan konsol "You're now"
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("You're now") then
        return true
    end
    -- Menambahkan kondisi baru untuk hook saat pesan konsol "Cheat Disable:"
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Cheat Disable:") then
        return true
    end
end
AddHook("onvariant", "Main Hook", hook)

local user = GetLocal().userid

local match_found = false

for _, id in pairs(tabel_uid) do
    if GetLocal().userid == tonumber(id) then
        match_found = true
        break
    end
end

if match_found == true then
    ChangeValue("[C] Modfly", true)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^UID TERDAFTAR")
    Sleep(1000)
    say("`2UID TERDAFTAR")
    Sleep(1000)
    say("`2SC PTHT UWS AUTO RECONNECT v2.0 BY `^MUFFINN STORE")
    Sleep(2000)
    CheckRemote()
    cektree()
    if CONFIG.World_setting.repeat_world == true and CONFIG.Webhook_setting.disable_webhook == true then
        while true do
            if CheckEmptyTile() == 0 then
                say("`^Nambal")
                Sleep(1000)
                cektree()
                Sleep(2000)
            end
            while checkseed() > 0 do 
                say("`^Harvest")
                Sleep(1000)
                htmray()
                Sleep(2000)
            end
            while CheckEmptyTile() ~= 0 do
                if CHANGE_MAGPLANT then
                    if GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg == 5638 then
                        CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                        CheckRemote()
                        Sleep(2000)
                    elseif GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg ~= 5638 then
                        CONFIG.World_setting.coordinate_magplant = LEFT_MAG_X
                        CheckRemote()
                        Sleep(2000)
                    end
                    CHANGE_MAGPLANT = false
                end
                say("`^Planting")
                Sleep(1000)
                plantfast()
                Sleep(2000)
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
