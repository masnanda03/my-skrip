--MUFFINN STORE--
tabel_uid = { 
	134611, 731670, 612468, 475429, 601763, 
	185650, 714689, 447487, 248228, 675313, 
	597946, 156990, 294780, 750484, 174767, 
	364650, 730592, 180077, 387386, 622614, 
	104455, 268314, 737747, 156249, 719929,
	737248, 7755, 774715, 169254, 774567, 
	798124, 775453, 499054, 346465, 305824,
	771625, 357736, 780969, 774228, 101404,
	612239, 616605, 354723, 37962, 719812,
	588529, 403039, 782866, 24615, 245045,
	759662, 782878, 377187, 787384, 793470,
	385041, 146424, 784299, 795043,708029, 
	788943, 284119, 1032, 185884, 250873,
	593363, 798666, 797167, 535822, 801299,
	781105, 95989, 132373, 217349, 624810,
	807254, 809007, 806630, 806349, 783179,
	430731, 45847, 111269, 712306
}

local NAME = GetLocal().name
local PTHT_COUNT = 0
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

local function cektree()
    if GetWorld() == nil then return end
    
    -- Pengecekan ketersediaan Ultra World Spray
    if findItem(12600) == 0 then
        LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `4Ultra World Spray is not available!")
        return
    end
    
    if CheckEmptyTile() == 0 and gscan(CONFIG.World_setting.seed_id) == 0 then
        Sleep(100)
        if CONFIG.World_setting.disable_uws == true then
            while CONFIG.World_setting.disable_uws == true do
                if GetWorld() == nil then return end
                Sleep(10)  
            end
        else
            -- Tambahkan pengecekan jumlah gems di sini
            local gemsCount = GetPlayerInfo().gems
            if gemsCount < 100000 then
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Not enough gems to use UWS")
                return
            end
            
            LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Using UWS")
            Sleep(300)
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

local function CheckRemote()
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
                        Sleep(100)
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
                        Sleep(100)
                        FindPath(x, y, CONFIG.World_setting.delay_path or 100)
                        Sleep(CONFIG.World_setting.delay_harvest)
                        punch(0, 0)
                        Sleep(CONFIG.World_setting.delay_harvest)
                    end
                end
            end
        end
    end
end

local function plantfast()
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `2There is "..CheckEmptyTile().." Empty Tile Left")
    Sleep(100)

    local xStart, xEnd, xIncrement, yStart, yEnd, yIncrement

    if CONFIG.World_setting.ptht_type == "horizontal" then
        xStart = CONFIG.World_setting.horizontal_size[1]
        xEnd = CONFIG.World_setting.horizontal_size[2]
        xIncrement = 10
        if CONFIG.World_setting.plant_type == "down" then
            yStart = CONFIG.World_setting.vertical_size[2]
            yEnd = CONFIG.World_setting.vertical_size[1]
            yIncrement = -2
        elseif CONFIG.World_setting.plant_type == "up" then
            yStart = CONFIG.World_setting.vertical_size[1]
            yEnd = CONFIG.World_setting.vertical_size[2]
            yIncrement = 2
        end

        local shouldMoveRight = true
        local count = 0
        for y = yStart, yEnd, yIncrement do
            for x = xStart, xEnd, xIncrement do
                if GetWorld() == nil then return end
                if EMPTY_MAGPLANT then return end
                if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                    FindPath(x, y, CONFIG.World_setting.delay_path)
                    Sleep(CONFIG.World_setting.delay_plant)
                    place(5640, 0, 0)
                    Sleep(CONFIG.World_setting.delay_plant)
                    count = count + 1
                end
            end

            -- Perubahan arah saat mencapai batas kiri atau kanan
            shouldMoveRight = not shouldMoveRight
            if shouldMoveRight then
                xStart, xEnd, xIncrement = CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.horizontal_size[2], 10
            else
                xStart, xEnd, xIncrement = CONFIG.World_setting.horizontal_size[2], CONFIG.World_setting.horizontal_size[1], -10
            end
        end
   elseif CONFIG.World_setting.ptht_type == "vertical" then
        xStart = CONFIG.World_setting.horizontal_size[1]
        xEnd = CONFIG.World_setting.horizontal_size[2]
        xIncrement = 10
        if CONFIG.World_setting.plant_type == "down" then
            yStart = CONFIG.World_setting.vertical_size[2]
            yEnd = CONFIG.World_setting.vertical_size[1]
            yIncrement = -2
            y = yStart
        elseif CONFIG.World_setting.plant_type == "up" then
            yStart = CONFIG.World_setting.vertical_size[1]
            yEnd = CONFIG.World_setting.vertical_size[2]
            yIncrement = 2
            y = yStart
        end

        local shouldMoveRight = false
        local count = 0
        for x = xStart, xEnd, xIncrement do
            for y = yStart, yEnd, yIncrement do
                if GetWorld() == nil then return end
                if EMPTY_MAGPLANT then return end
                if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                    FindPath(x, y, CONFIG.World_setting.delay_path)
                    Sleep(CONFIG.World_setting.delay_plant)
                    place(5640, 0, 0)
                    Sleep(CONFIG.World_setting.delay_plant)
                    count = count + 1
                end
            end

            -- Perubahan arah saat mencapai batas atas atau bawah
            if (yIncrement < 0 and (yEnd - y) <= math.abs(yIncrement)) or (yIncrement > 0 and (y - yStart) <= math.abs(yIncrement)) then
                shouldMoveRight = not shouldMoveRight
                if shouldMoveRight then
                    yStart = CONFIG.World_setting.vertical_size[1]
                    yEnd = CONFIG.World_setting.vertical_size[2]
                    yIncrement = 2
                    y = yStart
                else
                    yStart = CONFIG.World_setting.vertical_size[2]
                    yEnd = CONFIG.World_setting.vertical_size[1]
                    yIncrement = -2
                    y = yStart
                end
            end
        end
    else
        say("`2Not Added")
        return
    end

    -- Fungsi nambal di sini
    local count = 0
    Sleep(200)
    for y = CONFIG.World_setting.vertical_size[2], CONFIG.World_setting.vertical_size[1], -2 do
        if count % 2 == 0 then
            for x = CONFIG.World_setting.horizontal_size[2], CONFIG.World_setting.horizontal_size[1], -1 do
                if GetWorld() == nil then return end
                if EMPTY_MAGPLANT then return end
                if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                    FindPath(x, y, CONFIG.World_setting.delay_path)
                    Sleep(CONFIG.World_setting.delay_plant)
                    place(5640, 0, 0)
                    Sleep(30)
                end
            end
        else
            for x = CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.horizontal_size[2], 1 do
                if GetWorld() == nil then return end
                if EMPTY_MAGPLANT then return end
                if GetTile(x, y).fg == 0 and GetTile(x, y + 1).collidable and GetTile(x, y + 1).fg ~= CONFIG.World_setting.seed_id then
                    FindPath(x, y, CONFIG.World_setting.delay_path)
                    Sleep(CONFIG.World_setting.delay_plant)
                    place(5640, 0, 0)
                    Sleep(30)
                end
            end
        end
        count = count + 1
    end
end

function removeColorAndSymbols(str)
    local cleanedStr = string.gsub(str, "`(%S)", '')
    cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
    return cleanedStr
 end

function formatNumber(n)
    n = tostring(n)
    return n:reverse():gsub("...","%0,",math.floor((#n-1)/3)):reverse()
end

function FORMAT_TIME(seconds)
	local days = math.floor(seconds / 86400)
	local hours = math.floor((seconds % 86400) / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local remaining_seconds = seconds % 60

	local parts = {}
	if days > 0 then
		table.insert(parts, tostring(days) .. " day" .. (days > 1 and "s" or ""))
	end
	if hours > 0 then
		table.insert(parts, tostring(hours) .. " hour" .. (hours > 1 and "s" or ""))
	end
	if minutes > 0 then
		table.insert(parts, tostring(minutes) .. " minute" .. (minutes > 1 and "s" or ""))
	end
	if remaining_seconds > 0 then
		table.insert(parts, tostring(remaining_seconds) .. " second" .. (remaining_seconds > 1 and "s" or ""))
	end

	if #parts == 0 then
		return "0 seconds"
	elseif #parts == 1 then
		return parts[1]
	else
		local last_part = table.remove(parts)
		return table.concat(parts, ", ") .. " and " .. last_part
	end
end

AddHook("onvariant", "Main Hook", hook)
time = os.time()

local function playerHook(txt)
    if webhook_use then
	if GetWorld() == nil then return end
oras = os.time() - time
local ptht_value = ""
local ptht_send = ""
        if unli_Ptht then
    ptht_value = "Unlimited Ptht"
    ptht_send = " <a:1830vegarightarrow:1104369639921823874> PTHT Completed Count : " .. PTHT_COUNT
        else
    ptht_value = "With Count Ptht"
    ptht_send = " <a:1830vegarightarrow:1104369639921823874> PTHT Completed Count : " .. PTHT_COUNT .. "/" .. TOTAL_PTHT
        end

        local script = [[
            $webHookUrl = "]].. webhook_url ..[["
            $title = "PTHT PREMIUM AUTO RECONNECT"
            $date = [System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date), 'Singapore Standard Time').ToString('g')
            $cpu = (Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average).Average
            $RAM = Get-WMIObject Win32_PhysicalMemory | Measure -Property capacity -Sum | %{$_.sum/1Mb} 
            $ip = Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $(Get-NetConnectionProfile | Select-Object -ExpandProperty InterfaceIndex) | Select-Object -ExpandProperty IPAddress
            $thumbnailObject = @{
                url = ""
            }
            $footerObject = @{
                text = "Date: ]]..(os.date("!%A %b %d, %Y | Time: %I:%M %p ", os.time() + 7 * 60 * 60))..[[ "
            }
            
            $fieldArray = @(
  
			@{
                name = "<a:aOnline:1089435878583173200> Player Name"
                value = "<:bot:1194989731851812944> ]]..removeColorAndSymbols(NAME)..[[ 
				==============================="
                inline = "false"
            }
   
            @{
                name = "<:info2:1185986300084490441> Informasi"
                value = " <:world:1203057112595562628> Current World : ]]..string.upper(GetWorld().name)..[[ 
				<:gems:1111617537629757501> Gems : ]]..formatNumber(GetPlayerInfo().gems)..[[ 
				<:UWS:1111357396414103602> UWS Stock : ]]..findItem(12600)..[[ 
				==============================="
                inline = "false"
            }

               @{
                    name = "<:discordstaff79:1135325246858199200> Ptht Settings"
                    value = "<a:Warning:1138852345237749813> PTHT Type : ]]..CONFIG.World_setting.ptht_type..[[ mode 
                    <a:Warning:1138852345237749813> PTHT Mode : ]].. ptht_value..[[ 
                    ]].. ptht_send ..[[ 
				    ==============================="
                    inline = "false"
                }

			@{
                name = "<a:info1:1130833174327463956> Status Ptht"
                value = "<a:1830vegarightarrow:1104369639921823874> ]].. txt ..[[ 
				==============================="
                inline = "false"
            }
		
  
            @{
                name = "<:WallClock:1185986892987121786> Script Uptime"
                value = "]].. math.floor(oras/86400) ..[[ Days ]].. math.floor(oras%86400/3600) ..[[ Hours ]].. math.floor(oras%86400%3600/60) ..[[ Minutes ]].. math.floor(oras%3600%60) ..[[ Seconds"
                inline = "false"
            }

      
          )
          $embedObject = @{
          title = $title
          description = $desc
          footer = $footerObject
          thumbnail = $thumbnailObject
          color = "3333333"
      
          fields = $fieldArray
      }
      $embedArray = @($embedObject)
      $payload = @{
      avatar_url = "https://media.discordapp.net/attachments/1136847163905818636/1196094627372073041/MUFFINN_STORE_ICON.png?ex=65edbfed&is=65db4aed&hm=405bfb4e8ff9ecc2eb3493d5ae6bd7e9ec2c0ef0f9ea87e536a90b2219bf8edd&format=webp&quality=lossless&"
      username = "MUFFINN COMMUNITY"
      embeds = $embedArray
      }
      [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
      Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
      ]]
      local pipe = io.popen("powershell -command -", "w")
      pipe:write(script)
      pipe:close()
    end
end

local removeAnimationCollected = true -- true or false (Usage; It Removes the Message when Farming)
local removeAnimationbubbletalk = true -- true or false (Usage; It Removes the Message when Farming)
local removeSDB = true -- true or false (Usage; It Removes the Message when Farming)

local function hook(varlist)
	if varlist[0]:find("OnTalkBubble") and (varlist[2]:find("The MAGPLANT 5000 is empty")) then
		CHANGE_MAGPLANT = true
		EMPTY_MAGPLANT = true
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

	if varlist[0]:find("OnDialogRequest") and varlist[1]:find("add_player_info") then
		if CHECK_GHOST then
			if varlist[1]:find("|290|") then
				IS_GHOST = true
			else
				IS_GHOST = false
			end

			CHECK_GHOST = false
		end

		return true
	end

    if varlist[0] == "OnConsoleMessage" and varlist[1]:find("Where would you like to go?") then
        getworld = true
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

if varlist[0] == "OnTalkBubble" and varlist[2]:match("Collected")  then
        if removeCollected then
            return true
        end
    end
if varlist[0] == "OnSDBroadcast"   then
        if removeSDB then
            return true
        end
    end
	if varlist[0] == "OnTalkBubble" then
        if removeAnimationbubbletalk then
            return true
        end
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

local function mainLoop()
    ChangeValue("[C] Modfly", true)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(2000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^UID TERDAFTAR")
    Sleep(1000)
    say("`2SC PTHT UWS AUTO RECONNECT v2.0 BY `^MUFFINN STORE")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^MODE PLANT : " ..CONFIG.World_setting.ptht_type)
    Sleep(1000)

playerHook("Script Executed!")
LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Wait...")

CheckRemote()
    while (unli_Ptht or PTHT_COUNT ~= TOTAL_PTHT) do
	        if (getworld == true) then
            ontext("`2World : "..CONFIG.World_setting.WORLD_NAME)
            SendPacket(3, "action|join_request\nname|"..CONFIG.World_setting.WORLD_NAME.."\ninvitedWORLD_NAME|0")
            Sleep(2300)
            getworld = false
            ontext("`2You Are Reconnected!")
            playerHook("Reconnected!")
            Sleep(1000)
            CheckRemote()
            end

            if CheckEmptyTile() == 0 then
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Check Tree")
                    cektree()  -- Panggil cektree() jika UWS tersedia
                end

            local harvested = false
            while checkseed() > 0 do
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvest Tree")
                SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|1")
                Sleep(100)
                htmray()
                harvested = true
            end

            if harvested then
                 if unli_Ptht then
                    PTHT_COUNT = PTHT_COUNT + 1
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvested Tree, `2PTHT Count: "..PTHT_COUNT)
                 else
                    PTHT_COUNT = PTHT_COUNT + 1
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Harvested Tree, `2PTHT Count: "..PTHT_COUNT.."/"..TOTAL_PTHT)
                 end
                 playerHook("PTHT Count : "..PTHT_COUNT.." Done.")
		 collectgarbage()
		 Sleep(1000)
                if PTHT_COUNT == TOTAL_PTHT then
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^PTHT Done Total : "..PTHT_COUNT)
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `4Press Terminate 1 time to make sure the script completely stopped!")
                    playerHook("PTHT Done With Total : "..PTHT_COUNT.." Happy Pnb Sir")
                    return
                end
            end

            while CheckEmptyTile() ~= 0 and CHANGE_MAGPLANT do
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Change Remote")
                if GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg == 5638 then
                    CONFIG.World_setting.coordinate_magplant[1] = CONFIG.World_setting.coordinate_magplant[1] + 1
                    CheckRemote()
                    Sleep(100)
                elseif GetTile(CONFIG.World_setting.coordinate_magplant[1] + 1, CONFIG.World_setting.coordinate_magplant[2]).fg ~= 5638 then
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
                    Sleep(100)
                    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                    plantfast()
                end
            else
                FindPath(CONFIG.World_setting.horizontal_size[1], CONFIG.World_setting.vertical_size[2], 100)
                Sleep(500)
                place(5640, 0, 0)
                Sleep(100)
                SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|1\ncheck_gems|1")
                Sleep(100)
                LogToConsole("`0[`^MUFFINN`0-`^STORE`0] : `^Plant Tree")
                plantfast()
            end
        end
     end

-- Cek apakah batas waktu skrip telah tercapai sebelum menjalankan fungsionalitas utama skrip
if match_found then
    mainLoop()
else
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    say("`4UID Not Found")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `4UID TIDAK TERDAFTAR KONTAK DISCORD MUFFINN_S")
  return
end
