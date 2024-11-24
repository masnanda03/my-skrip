-- [ PTHT V2 - MUFFINN STORE ]--
tabel_uid = {"134611", "731670", "612468", "475429", "601763", 
	"185650", "120729", "447487", "248228", "675313", 
	"597946", "156990", "294780", "750484", "174767", 
	"364650", "730592", "180077", "387386", "622614", 
	"104455", "268314", "737747", "156249", "719929",
	"737248", "7755", "774715", "169254", "774567", 
	"343274", "775453", "499054", "346465", "305824",
	"771625", "357736", "780969", "774228", "101404",
	"612239", "616605", "354723", "37962", "719812",
	"588529", "403039", "782866", "24615", "245045",
	"759662", "782878", "377187", "787384", "793470",
	"385041", "146424", "784299", "795043", "708029", 
	"788943", "284119", "1032", "185884", "250873",
	"593363", "798666", "797167", "535822", "801299",
	"781105", "95989", "132373", "217349", "624810",
	"807254", "809007", "806630", "806349", "783179",
	"430731", "45847", "111269", "712306", "548750",
	"816143", "268865", "110580", "49201", "803088",
	"450271", "828022", "829424", "273047", "323102", 
    "323293", "712785", "159635", "498031", "145359", 
    "804042", "598089", "705698", "179581", "171529", 
    "470042", "261125", "850415", "716051", "239848", 
    "776168", "373798", "853110", "851554", "783918", 
    "329132", "58046", "776278", "12345", "230442", "850620", "24801", "640936", "859839", "862158", "864501", "377841", "703809", "356083", "282511", "717848", "873487", "333899", "875298", "345229"}

-- [DONT TOUCH BICISS] --
local WAIT_TIME = 1 -- do not touch
local IGNORE_UNHARVESTED_AFTER_PUNCH = false -- do not touch

local REMOTE_X = MAG_X -- do not touch
local REMOTE_Y = MAG_Y -- do not touch
local WORLD_SIZE_X = 199 -- do not touch
local WORLD_SIZE_Y = 199 -- do not touch
local MAG_STOCK = 0 -- do not touch       
local CHECK_STOCK = true -- do not touch
local START_PLANT = 0 -- do not touch
local PTHT_COUNT = 0 -- do not touch

local RAW_SLEEP = -1 -- do not touch
local MAG_EMPTY = false -- do not touch
local CHANGE_REMOTE = false -- do not touch
local START_MAG_X = MAG_X -- do not touch
local START_MAG_Y = MAG_Y -- do not touch
local ROTATION_COUNT = 0 -- do not touch

local DISABLED = false -- do not touch

local function WARN(text)
	local packet = {}
	packet[0] = "OnAddNotification"
	packet[1] = "interface/atomic_button.rttex"
	packet[2] = text
	packet[3] = 'audio/hub_open.wav'
	packet[4] = 0
	SendVariantList(packet)
end

local function overlayText(text)
    var = {}
    var[0] = "OnTextOverlay"
    var[1] = "`0[`cPTHT INFO`0]`o ".. text
    SendVariantList(var)
end

local function GetItemCount(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end    
    end
    return 0
end

if MAG_X == -1 or MAG_Y == -1 then
	WARN("You must set MAG_X / MAG_Y at the top of the script! The script is now disabled.")
	CALL_NILL_FUNCTION()
end

if USE_MRAY then
RAW_SLEEP = 60
elseif not USE_MRAY then
RAW_SLEEP = 115
end

for _, TILE in pairs(GetTiles()) do
	if TILE.flags.water then
		DISABLED = false
	end
end

function removeColorAndSymbols(str)
	local cleanedStr = string.gsub(str, "`(%S)", '')
	cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
	return cleanedStr
end

function log(str)
    LogToConsole("`0[`cPTHT INFO`0]`o "..str)
end

function say(txt)
    SendPacket(2,"action|input\ntext|"..txt)
end

local function FormatNumber(num)
	num = math.floor(num + 0.5)

	local formatted = tostring(num)
	local k = 3
	while k < #formatted do
		formatted = formatted:sub(1, #formatted - k) .. "," .. formatted:sub(#formatted - k + 1)
		k = k + 4
	end

	return formatted
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

local function Place(x, y, id)
	if GetWorld() == nil then return end
	pkt = {}
	pkt.type = 3
	pkt.value = id
	pkt.px = x
	pkt.py = y
	pkt.x = GetLocal().pos.x
	pkt.y = GetLocal().pos.y
	SendPacketRaw(false, pkt)
end

local function PATH(x, y, state)
    if GetWorld() == nil then return end
    SendPacketRaw(false, {
        state = state,
        px = x,
        py = y,
        x = x * 32,
        y = y * 32
    })
end

local function P2(x, y, id)
    if GetWorld() == nil then return end
    SendPacketRaw(false, {
        type = 3,
        value = id,
        px = x,
        py = y,
        x = x * 32,
        y = y * 32
    })
end

local function hook(varlist)
	if varlist[0]:find("OnTalkBubble") and (varlist[2]:find("The MAGPLANT 5000 is empty")) then
		CHANGE_REMOTE = true
		MAG_EMPTY = true
		return true
	end

	if varlist[0]:find("OnDialogRequest") and varlist[1]:find("magplant_edit") then
		local x = varlist[1]:match('embed_data|x|(%d+)')
		local y = varlist[1]:match('embed_data|y|(%d+)')
		local amount = varlist[1]:match("The machine contains (%d+)")
		if amount == nil then amount = 0 end

		if x == ""..REMOTE_X.."" and y == ""..REMOTE_Y.."" then
			MAG_STOCK = amount
		end
		return true
	end

	if varlist[0]:find("OnDialogRequest") and (varlist[1]:find("Item Finder") or varlist[1]:find("The MAGPLANT 5000 is disabled.")) then
		return true
	end

	if varlist[0]:find("OnDialogRequest") and varlist[1]:find("add_player_info") then
		return true
	end
    if varlist[0] == "OnTalkBubble" and varlist[2]:match("Collected") then
        if COLLECTED_BLOCK then
            return true
        end
    end
    if varlist[0] == "OnSDBroadcast" then
        if SDB_BLOCK then
            overlayText("`2SDB `4BLOCKED")
            return true
        end
    end
	if varlist[0] == "OnTalkBubble" then
        if TALK_BLOCK then
            return true
        end
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
    if varlist[0]:find("OnTalkBubble") and varlist[2]:find("`wXenonite has changed everyone's powers!") then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("`wXenonite has changed everyone's powers!") then
        return true
    end
    if varlist[0]:find("OnTalkBubble") and varlist[2]:find("`wHmm, it looks like `$Pot O' Gems Seed`` and `$Pot O' Gems Seed`` can't be spliced.``") then
        return true
    end
    if varlist[0]:find("OnTalkBubble") and varlist[1] == varlist[1] and varlist[2]:find("A Pot O' Gems Seed falls out!") then
        return true
    end
end
AddHook("onvariant", "Main Hook", hook)

time = os.time()

local function playerHook(info)
    if WEBHOOK_USE then
	if GetWorld() == nil then return end
local name_acc = removeColorAndSymbols(GetLocal().name)
local c_world = GetWorld().name
local c_gems = FormatNumber(GetPlayerInfo().gems)
local s_uws = math.floor(GetItemCount(12600))
        oras = os.time() - time
        local script = [[
            $webHookUrl = "]].. WEBHOOK_URL ..[["
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
                name = "<a:aOnline:1089435878583173200> Player Information"
                value = "<:player:1203057110208876656> Name : ]].. name_acc ..[[ 
                <:GemSprites:1116878069752414288> Gems : ]].. c_gems ..[[ 
                =============================== "
                inline = "false"
            }
  
            @{
                name = "<:3232info:1104368339284938762> General Information"
                value = "<:world:1203057112595562628> Current World: ]].. c_world ..[[ 
				<:uws:1263163810475282645> UWS Stock: ]].. s_uws ..[[ 
                =============================== "
                inline = "false"
            }

            @{
                name = "<:2118settings:1104368318820925492> PTHT Information"
                value = "<:ItemSprites2:1116878248723365938> PTHT Completed : ]].. PTHT_COUNT ..[[ 
				<:ItemSprites2:1116878248723365938> PTHT Desired : ]].. TOTAL_PTHT ..[[ 
                =============================== "
                inline = "false"
            }
			
			@{
                name = "<:mp:1185986539033989120> Magplant Information"
                value = "Current Remote : X **]].. MAG_X ..[[**, Y **]].. MAG_Y ..[[**
                =============================== "
                inline = "false"
            }
  
            @{
                name = "<:mphone:1203057106450649108> PTHT Status"
                value = "<:ItemSprites2:1116878248723365938> ]].. info ..[[ 
                =============================== "
                inline = "false"
            }

            @{
                name = "<:timer:1114449308595540009> PTHT Uptime"
                value = "]].. math.floor(oras/86400) ..[[ Days ]].. math.floor(oras%86400/3600) ..[[ Hours ]].. math.floor(oras%86400%3600/60) ..[[ Minutes ]].. math.floor(oras%3600%60) ..[[ Seconds"
                inline = "false"
            }

      
          )
          $embedObject = @{
          title = $title
          description = $desc
          footer = $footerObject
          thumbnail = $thumbnailObject
          color = "]] ..math.random(1000000,9999999).. [["
      
          fields = $fieldArray
      }
      $embedArray = @($embedObject)
      $payload = @{
      avatar_url = "https://images-ext-1.discordapp.net/external/SW1Rhz7_V3k-5305AtZ7T_QUvTjqKV87TYThaB1JX6c/%3Fsize%3D256/https/cdn.discordapp.com/avatars/1153982782373122069/c35799a209178a9928dccefb512ef8b4.gif"
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

local function CHECK_FOR_AIR()
	if GetWorld() == nil then return end
	for y = 0, WORLD_SIZE_Y do
		local startX = 0
		local endX = WORLD_SIZE_X
		local incrementX = 1
		if not USE_MRAY then
			if y % 4 == 2 then
				startX = WORLD_SIZE_X
				endX = 0
				incrementX = -1
			end
		end

		for x = startX, endX, incrementX do
			if GetWorld() == nil then return end

			if GetTile(x, y).fg == PLATFORM_ID then

				if x > 1 and x < WORLD_SIZE_X and y-1 >= 0 and y-1 < WORLD_SIZE_Y and GetTile(x, y-1).fg == 0 then
					return true
				end
			end
		end
	end

	return false
end

local function CHECK_FOR_TREE()
	if MAG_EMPTY then return end
	for y = WORLD_SIZE_Y, 0, -1 do
		for x = 0, WORLD_SIZE_X do
			if GetWorld() == nil then return end

			if x >= 0 and x < WORLD_SIZE_X and y >= 0 and y < WORLD_SIZE_Y then
				local tile = GetTile(x, y)

				if tile.fg == SEED_ID and GetTile(x, y+1).fg == PLATFORM_ID then
					if tile.extra.progress == 1.0 then
						return true
					end
				end
			end
		end
	end

	return false
end

local function WalkTo(x, y)
	if GetWorld() == nil then return end
	pkt = {}
	pkt.type = 0
	pkt.x = x * 32
	pkt.y = y * 32
	SendPacketRaw(false, pkt)
	Sleep(180)
end

local function AUTOPLANT_SETTINGS()
	if GetWorld() == nil then return end
	for y = 0, WORLD_SIZE_Y do
		for x = 0, WORLD_SIZE_X do
			if GetTile(x, y).fg == SEED_ID and GetTile(x, y+1).fg ~= PLATFORM_ID then
				ChangeValue("[C] Modfly", false)
				ChangeValue("[C] Antibounce", false)

				SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|".. COLLECT_GEMS)

				WalkTo(x, y)
				Sleep(250)

				SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|1\ncheck_gems|".. COLLECT_GEMS)
				return
			end
		end
	end
end

local function CheckRemote()
	if GetWorld() == nil then return end

	if GetItemCount(5640) < 1 or MAG_EMPTY  then
		FindPath(REMOTE_X, REMOTE_Y - 1, 60)
		Place(REMOTE_X,REMOTE_Y,32)
		Sleep(200)
		SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|".. REMOTE_X .."|\ny|" .. REMOTE_Y .. "|\nbuttonClicked|getRemote")
		Sleep(250)
		Place(REMOTE_X, REMOTE_Y-1, 5640)
	end

	if GetItemCount(5640) >= 1 and MAG_EMPTY then
		MAG_EMPTY = false
	end
	
	return GetItemCount(5640) >= 1
end

local function PLANT_LOOP()
    if GetWorld() == nil then return end
    if MAG_EMPTY then return end
    ChangeValue("[C] Modfly", true)

    local WORLD_SIZE_X = 199
    local WORLD_SIZE_Y = 199
    local last_progress = 0

    local function update_progress(current_x)
        local progress = math.floor(current_x / 20) * 10
        if progress > last_progress then
            log("`wPROGRESS `8PLANTING `w>>> `2" .. progress .. "`w%")
            last_progress = progress
        end
    end

    if USE_MRAY then
        local x = 0
        local direction = (PT_TYPE == "UP") and 1 or (PT_TYPE == "DOWN") and -1

        while x < WORLD_SIZE_X do
            local y_start, y_end

            if direction == 1 then
                y_start = 0
                y_end = WORLD_SIZE_Y - 1
            elseif direction == -1 then
                y_start = WORLD_SIZE_Y - 1
                y_end = 0
            end

            for y = y_start, y_end, direction do
                if MAG_EMPTY then return end
                if GetWorld() == nil then return end

                if GetTile(x, y).fg == PLATFORM_ID then
                    local PLACE_X = x
                    local PLACE_Y = y - 1

                    if PLACE_X >= 0 and PLACE_X < WORLD_SIZE_X and PLACE_Y >= 0 and PLACE_Y < WORLD_SIZE_Y and GetTile(PLACE_X, PLACE_Y).fg == 0 then
                        PATH(PLACE_X, PLACE_Y)
                        P2(PLACE_X, PLACE_Y, 5640)
                        Sleep(DELAY_PT)
                    end
                end
            end

            update_progress(x)
            x = x + 10
            if x >= WORLD_SIZE_X then break end

            direction = -direction
        end
    else
        for y = 199, 0, -1 do
            local startX = 0
            local endX = WORLD_SIZE_X - 1
            local incrementX = 1
            if y % 4 == 2 then
                startX = WORLD_SIZE_X - 1
                endX = 0
                incrementX = -1
            end

            for x = startX, endX, incrementX do
                local PLACE_X = x
                local PLACE_Y = y - 1
                if MAG_EMPTY then return end
                if GetWorld() == nil then return end

                if GetTile(x, y).fg == PLATFORM_ID then
                    if x >= 0 and x < WORLD_SIZE_X and y-1 >= 0 and y-1 < WORLD_SIZE_Y and GetTile(x, y-1).fg == 0 then
                        if ROTATION_COUNT ~= 0 then
                            PATH(x, y-1)
                            Sleep(DELAY_PT)
                            P2(x, y-1, 5640)
                            Sleep(DELAY_PT)
                        else
                            PATH(PLACE_X, PLACE_Y)
                        end
                    end
                end

                update_progress(x)
            end
        end
    end

    log("`wPROGRESS `8PLANTING `w>>> `2100`w%")
end

local function Hold()
	local pkt = {}
	pkt.type = 0
	pkt.state = 16779296
	SendPacketRaw(pkt)
	Sleep(180)
end

local function HARVEST()
    local startY, endY, stepY
    local startX, endX, stepX

    if HT_TYPE == "UP" then
        startY, endY, stepY = 0, WORLD_SIZE_Y - 1, 1
    elseif HT_TYPE == "DOWN" then
        startY, endY, stepY = WORLD_SIZE_Y - 1, 0, -1
    end

    local totalRows = math.abs(endY - startY) + 1
    local rowsProcessed = 0
    local lastPercentage = 0

    for y = startY, endY, stepY do
        startX, endX, stepX = 0, WORLD_SIZE_X - 1, 1

        for x = startX, endX, stepX do
            if GetWorld() == nil then return end

            if x >= 0 and x < WORLD_SIZE_X and y >= 0 and y < WORLD_SIZE_Y then
                local tile = GetTile(x, y)

                if tile.fg == SEED_ID and GetTile(x, y+1).fg == PLATFORM_ID then
                    PATH(x, y)
                    Sleep(DELAY_HT)
                    P2(x, y, 18)
                    Hold()
                    if not IGNORE_UNHARVESTED_AFTER_PUNCH then
                        if not USE_MRAY then
                            Sleep(DELAY_HT)
                        elseif USE_MRAY then
                            Sleep(DELAY_HT)
                        end
                    else
                        Sleep(DELAY_HT)
                        break
                    end
                end
            end
        end

        rowsProcessed = rowsProcessed + 1
        local currentPercentage = math.floor((rowsProcessed / totalRows) * 100)

        if currentPercentage % 10 == 0 and currentPercentage > lastPercentage then
            lastPercentage = currentPercentage
            log("`wPROGRESS `9HARVEST `w>>> `2" .. currentPercentage .. "`w%")
        end
    end

    if lastPercentage < 100 then
        log("`wPROGRESS `9HARVEST `w>>> `2100`w%")
    end
end

local function fillEmptyTilesOneByOne()
    for y = 0, WORLD_SIZE_Y do
        for x = 0, WORLD_SIZE_X do
            if GetWorld() == nil then return end
            
            if GetTile(x, y).fg == PLATFORM_ID and GetTile(x, y-1).fg == 0 then
                PATH(x, y-1)
                Sleep(DELAY_PT)
                P2(x, y-1, 5640)
                Sleep(DELAY_PT)
            end
        end
    end
end

local function checkUID(user_id)
    for _, id in ipairs(tabel_uid) do
        local trimmed_id = id:match("^%s*(.-)%s*$")
        if tonumber(user_id) == tonumber(trimmed_id) then
            return true
        end
    end
    return false
end

local user = GetLocal().userid
local match_found = checkUID(user)

function mainLoop()
    ChangeValue("[C] Modfly", true)
    log("`0IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1500)
    log("`0CHECKING UID")
    Sleep(2500)
    log("`0UID TERDAFTAR")
    Sleep(1500)
    say("`0SC PTHT UWS AUTO RECONNECT by `#@muffinn")
    Sleep(1500)
    say("`0STARTING PTHT WITH TOTAL : " .. tostring(TOTAL_PTHT))
    Sleep(1500)

    log("`0Wait...")

    if not DISABLED then
        PTHT_COUNT = 0
        while TOTAL_PTHT == "UNLI" or PTHT_COUNT < tonumber(TOTAL_PTHT) do
            if GetWorld() == nil then
                SendPacket(2, "action|join_request\nname|" .. WORLD .. "")
                SendPacket(3, "action|join_request\nname|" .. WORLD .. "\ninvitedWorld|0")
                Sleep(10000)
                playerHook("RECONNECTED! BACK TO WORLD")
                log("`2RECONNECTED! `0BACK TO WORLD")
            elseif GetWorld().name ~= WORLD then
                SendPacket(2, "action|join_request\nname|" .. WORLD .. "")
                SendPacket(3, "action|join_request\nname|" .. WORLD .. "\ninvitedWorld|0")
                Sleep(10000)
                playerHook("RECONNECTED! START PTHT")
                log("`2RECONNECTED! `0START PTHT")
            end

            if CHANGE_REMOTE then
                Sleep(2000)
                if GetTile(REMOTE_X + 1, REMOTE_Y).fg == 5638 then
                    REMOTE_X = REMOTE_X + 1
                    log("`0CHANGE REMOTE")
                    CheckRemote()
                else
                    REMOTE_X = START_MAG_X
                    log("`0REMOTE RESET TO FIRST POSITION")
                    CheckRemote()
                end
                CHANGE_REMOTE = false
                Sleep(2000)
            end

            if CheckRemote() then
                if CHECK_FOR_TREE() then
                    Sleep(2000)

                    SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_lonely|".. PEOPLEHIDE .."\ncheck_ignoreo|".. DROPHIDDEN .."\ncheck_gems|1")
                    Sleep(1500)

                    log("`0START HARVESTING TREE")

                    while CHECK_FOR_TREE() do
                        ChangeValue("[C] Modfly", true)
                        HARVEST()
                        Sleep(1500)
                    end

                    PTHT_COUNT = PTHT_COUNT + 1
                    playerHook("DONE ["..PTHT_COUNT.."] TIME : ["..string.format("%.1f", (os.time()-START_PLANT)/60).." minutes]")
                    say("`0DONE [`2"..PTHT_COUNT.."`0] TIME : [`2"..string.format("%.1f", (os.time()-START_PLANT)/60).." `0minutes]")
                    Sleep(2000)
                else
                    ROTATION_COUNT = 0

                    if CHECK_FOR_AIR() then
                        Sleep(2000)
                        log("`0START PLANTING SEED")
                        START_PLANT = os.time()

                        if not USE_MRAY then
                            while CHECK_FOR_AIR() do
                                if ROTATION_COUNT == 0 then
                                    AUTOPLANT_SETTINGS()
                                else
                                    SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autoplace|0\ncheck_gems|"..COLLECT_GEMS)
                                end

                                Sleep(1500)
                                PLANT_LOOP()
                                ROTATION_COUNT = ROTATION_COUNT + 1
                            end
                        else
                            Sleep(1500)
                            PLANT_LOOP()
                            ROTATION_COUNT = ROTATION_COUNT + 1
                        end
                    end

                    Sleep(2000)
                    ROTATION_COUNT = 0

                    if not MAG_EMPTY then
                        Sleep(2000)
                        log("`0FILLING EMPTY TILES")
                        fillEmptyTilesOneByOne()
                        Sleep(1500)
                        log("`0USING ULTRA WORLD SPRAY")
                        SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray")
                        Sleep(2000)
                    end
                end
            end
        end
        if TOTAL_PTHT ~= "UNLI" then
            playerHook("DONE PTHT, COUNT ALL : "..PTHT_COUNT)
            say("`0DONE PTHT, COUNT ALL : `2"..PTHT_COUNT)
        end
    else
        WARN("`4YOU MUST CLEAR ALL WATER IN THIS WORLD FIRST!")
    end
end

if match_found then
    mainLoop()
else
    log("`0IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    log("`0CHECKING UID")
    Sleep(3000)
    say("`4UID Not Found")
    Sleep(1000)
    log("`4UID TIDAK TERDAFTAR KONTAK DISCORD `#@muffinncps")
  return
end
