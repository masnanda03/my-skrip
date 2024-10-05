--PTHT BY MUFFINN COMMUNITY--
tabel_uid = {
    "134611", "731670", "612468", "475429", "601763", 
	"185650", "714689", "447487", "248228", "675313", 
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
	"450271", "828439", "829424", "273047", "323102", 
    "323293", "712785", "159635", "498031", "145359", 
    "804042", "598089", "705698", "179581", "171529", 
    "470042", "261125", "850415", "716051", "239848", 
    "776168", "373798", "853110", "851554", "783918", 
    "329132", "58046"}

-- [DON'T TOUCH BICHISS] --
local isDisconnected = false
local MODE = "PTHT"
local WORLD_SIZE_X = 199
local WORLD_SIZE_Y = 199
local MAG_EMPTY = false
local MAG_STOCK = 0
local REMOTE_X = MAG_X
local REMOTE_Y = MAG_Y
local LAST_PLANT_X = 0
local LAST_PLANT_Y = 0

function log(str)
    LogToConsole("`0[`cPTHT INFO`0]`o "..str)
end

function overlayText(text)
    var = {}
    var[0] = "OnTextOverlay"
    var[1] = "`0[`cPTHT INFO`0]`o ".. text
    SendVariantList(var)
end

function hook(varlist)
    if varlist[0] == "OnTalkBubble" and varlist[1] == GetLocal().netID and varlist[2]:find("The MAGPLANT 5000 is empty") then
        MAG_EMPTY = true
        return true
    end
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("magplant_edit") then
        local x = varlist[1]:match('embed_data|x|(%d+)')
        local y = varlist[1]:match('embed_data|y|(%d+)')
        local amount = varlist[1]:match("Stock: `%$(%d+)`` items") or 
                       varlist[1]:match("The machine contains (%d+)") or 
                       varlist[1]:match("Stock (%d+)")
        
        if varlist[1]:find("Stock: `4EMPTY!``") then
            amount = "0"
        end
        
        if amount == nil then amount = "0" end
        if x == tostring(REMOTE_X) and y == tostring(REMOTE_Y) then
            MAG_STOCK = tonumber(amount)
            MAG_EMPTY = (MAG_STOCK == 0)
        end
        return true
    end
    if varlist[0]:find("OnDialogRequest") and (varlist[1]:find("Item Finder") or varlist[1]:find("The MAGPLANT 5000 is disabled.")) then
        return true
    end
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("add_player_info") then
        return true
    end
    if varlist[0] == "OnConsoleMessage" and varlist[1]:find("World Locked") then
        isDisconnected = false
        return true
    end
    if varlist[0] == "OnConsoleMessage" and varlist[1]:find("Where would you like to go?") then
        isDisconnected = true
        return true
    end
    if varlist[0]:find("OnRequestWorldSelectMenu") then
        isDisconnected = true
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
    if varlist[0]:find("OnTalkBubble") and varlist[2]:find("`wXenonite has changed everyone's powers!") then
        return true
    end
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("`wXenonite has changed everyone's powers!") then
        return true
    end
    if varlist[0] == "OnTalkBubble" and varlist[2]:match("Collected") then
        if REMOVE_COLLECTED then
            return true
        end
    end
    if varlist[0] == "OnSDBroadcast" then
        if REMOVE_SDB then
            overlayText("`2SDB `4BLOCKED")
            return true
        end
    end
	if varlist[0] == "OnTalkBubble" then
        if REMOVE_BUBBLE then
            return true
        end
    end
    return false
end
AddHook("onvariant", "Main Hook", hook)

function IsReady(tile)
    return tile.extra and tile.extra.progress == 1
end

local ey = GetLocal().pos.y // 32

function findItem(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end
    end
    return 0
end

function path(x, y, state)
    if GetWorld() == nil then return end
    SendPacketRaw(false, {
        state = state,
        px = x,
        py = y,
        x = x * 32,
        y = y * 32
    })
end

function h2(x, y, id)
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

function getTree()
    if GetWorld() == nil then return end
    local count = 0
    for y = ey, 0, -1 do
        for x = 0, WORLD_SIZE_X do
            local tile = GetTile(x, y)
            if tile and tile.fg == 0 and GetTile(x, y + 1) and GetTile(x, y + 1).fg == PLATFORM_ID then
                count = count + 1
            end
        end
    end
    return count
end

function getReady()
    if GetWorld() == nil then return end
    local ready = 0
    for y = ey, 0, -1 do
        for x = 0, WORLD_SIZE_X do
            local tile = GetTile(x, y)
            if tile and tile.fg == SEED_ID and IsReady(tile) then
                ready = ready + 1
            end
        end
    end
    return ready
end

function CHECK_FOR_AIR()
    if GetWorld() == nil then return end
    for y = 0, WORLD_SIZE_Y do
        for x = 0, WORLD_SIZE_X do
            local tile = GetTile(x, y)
            if tile and tile.fg == PLATFORM_ID then
                local aboveTile = GetTile(x, y - 1)
                if aboveTile and aboveTile.fg == 0 then
                    return true
                end
            end
        end
    end
    return false
end

function getMagplant()
    if GetWorld() == nil then return end
    if GetTile(MAG_X, MAG_Y).fg == 5638 then
        return {{MAG_X, MAG_Y}}
    end
    return {}
end

function getRemote()
    if GetWorld() == nil then return end
    local initialX, initialY = REMOTE_X, REMOTE_Y
    
    repeat
        path(REMOTE_X, REMOTE_Y, 32)
        Sleep(500)
        h2(REMOTE_X, REMOTE_Y, 32)
        Sleep(500)
        SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. REMOTE_X .. "|\ny|" .. REMOTE_Y .. "|\nbuttonClicked|getRemote")
        Sleep(5000)
        if findItem(5640) > 0 then
            checkMagplantStock()
            return not MAG_EMPTY
        end
        REMOTE_X = REMOTE_X + 1
        if GetTile(REMOTE_X, REMOTE_Y).fg ~= 5638 then
            REMOTE_X, REMOTE_Y = MAG_X, MAG_Y
        end
    until REMOTE_X == initialX and REMOTE_Y == initialY

    MAG_EMPTY = true
    log("`4All magplants are empty. `wPlease refill them.")
    return false
end

function checkMagplantStock()
    if GetWorld() == nil then return end
    if REMOTE_X == 0 or REMOTE_Y == 0 then
        log("`4MAGPLANT coordinates not set. `wPlease set MAG_X and MAG_Y.")
        return
    end
    
    path(REMOTE_X, REMOTE_Y, 32)
    Sleep(500)
    h2(REMOTE_X, REMOTE_Y, 32)
    Sleep(500)
    SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|" .. REMOTE_X .. "|\ny|" .. REMOTE_Y .. "|\nbuttonClicked|showContents")
    Sleep(1000)
    
    log(string.format("`9MAGPLANT stock: `2%d", MAG_STOCK))
    
    if MAG_STOCK == 0 then
        MAG_EMPTY = true
        log("`4MAGPLANT is empty. `wSwitching to next MAGPLANT.")
    else
        MAG_EMPTY = false
    end
end

function uws()
    if GetWorld() == nil then return end
    local treeCount = getTree()
    if treeCount == 0 then
        log("`2Done planting")
        Sleep(1000)
        log("`9Using UWS")
        Sleep(500)
        SendPacket(2, "action|dialog_return\ndialog_name|ultraworldspray")
        Sleep(2000)
        harvest()
    elseif treeCount > 0 then
        plant()
        Sleep(1000)
    end
end

function plantTile(x, y)
    if GetWorld() == nil then return end
    if isDisconnected then return false end
    
    local tile = GetTile(x, y)
    if tile and tile.fg == 0 and GetTile(x, y + 1) and GetTile(x, y + 1).fg == PLATFORM_ID then
        path(x, y, 32)
        Sleep(1)
        h2(x, y, 5640)
        if MAG_EMPTY then
            LAST_PLANT_X, LAST_PLANT_Y = x, y
            if not getRemote() then
                log("`4Unable to get a new remote. `wStopping planting.")
                return false
            end
            log("`2New remote acquired. `wResuming from last position.")
        end
        Sleep(DELAY_PT)
    end
    return true
end

function fillEmptyTilesOneByOne()
    if GetWorld() == nil then return end
    local totalEmptyTiles = getTree()
    local filledTiles = 0
    local lastLoggedProgress = 100

    while CHECK_FOR_AIR() do
        for y = 0, WORLD_SIZE_Y do
            for x = 0, WORLD_SIZE_X do
                if isDisconnected then return end
                
                if GetTile(x, y) and GetTile(x, y).fg == PLATFORM_ID and GetTile(x, y-1) and GetTile(x, y-1).fg == 0 then
                    path(x, y-1, 32)
                    Sleep(DELAY_PT)
                    h2(x, y-1, 5640)
                    Sleep(DELAY_PT)
                    
                    filledTiles = filledTiles + 1
                    local progress = 100 + math.floor((filledTiles / totalEmptyTiles) * 100)
                    if progress >= lastLoggedProgress + 10 or progress >= 200 then
                        lastLoggedProgress = progress - (progress % 10)
                        if progress >= 200 then return end
                    end
                end
            end
        end
    end
end

function plant()
    if GetWorld() == nil then return end
    if MAG_EMPTY then return end

    local totalRows = math.ceil((ey + 1) / 2)
    local rowsPlanted = 0
    local lastLoggedProgress = 0

    if PT_TYPE == "HORIZONTAL" then
        for y = ey, 0, -2 do
            for x = 0, WORLD_SIZE_X do
                if CHECK_FOR_AIR() and not plantTile(x, y) then
                    return
                end
            end
            rowsPlanted = rowsPlanted + 1
            local progress = math.floor((rowsPlanted / totalRows) * 100)
            if progress >= lastLoggedProgress + 10 or progress == 100 then
                log(string.format("`8Planting Progress: `9%d%%", progress))
                lastLoggedProgress = progress - (progress % 10)
            end
        end
    elseif PT_TYPE == "VERTICAL" then
        local totalColumns = math.ceil((WORLD_SIZE_X + 1) / 10) * 2
        local columnsPlanted = 0
        
        for x = 0, WORLD_SIZE_X, 10 do
            for y = ey, 0, -1 do
                if CHECK_FOR_AIR() and not plantTile(x, y) then
                    return
                end
            end
            columnsPlanted = columnsPlanted + 1
            if x + 9 <= WORLD_SIZE_X then
                for y = 0, ey do
                    if CHECK_FOR_AIR() and not plantTile(x + 9, y) then
                        return
                    end
                end
                columnsPlanted = columnsPlanted + 1
            end
            local progress = math.floor((columnsPlanted / totalColumns) * 100)
            if progress >= lastLoggedProgress + 10 or progress == 100 then
                log(string.format("`8Planting Progress: `9%d%%", progress))
                lastLoggedProgress = progress - (progress % 10)
            end
        end
    end

    LAST_PLANT_X, LAST_PLANT_Y = 0, 0

    if CHECK_FOR_AIR() then
        log("`8Starting to fill empty tiles")
        fillEmptyTilesOneByOne()
    end

    uws()
end

function harvest()
    if GetWorld() == nil then return end
    if MAG_EMPTY then return end

    local totalTrees = getReady()
    local treesHarvested = 0
    local lastLoggedProgress = 0
    local treesPerTenPercent = math.ceil(totalTrees / 10)

    log(string.format("`0Total trees to harvest: `9%d", totalTrees))

    if totalTrees == 0 then
        log("`wNo trees ready for harvest.")
        return
    end

    for y = ey, 0, -1 do
        for x = 0, WORLD_SIZE_X do
            if isDisconnected then return end
            
            local tile = GetTile(x, y)
            if tile and tile.fg == SEED_ID and IsReady(tile) then
                path(x, y, 5640)
                Sleep(150)
                h2(x, y, 18)
                Sleep(DELAY_HT)
                treesHarvested = treesHarvested + 1
                
                if treesHarvested % treesPerTenPercent == 0 or treesHarvested == totalTrees then
                    local progress = math.floor((treesHarvested / totalTrees) * 100)
                    lastLoggedProgress = progress
                end
            end
        end
    end

    if lastLoggedProgress < 100 then
        log(string.format("`0Harvest Progress: `9100%% (`9%d`0/`9%d`0)", totalTrees, totalTrees))
    end

    log("`2Done harvesting")
end

function reconnect()
    if GetWorld() == nil then return end
    if MAG_EMPTY then
        if not getRemote() then
            log("`4Unable to get a remote. `wPlease check magplants and refill if necessary.")
            return
        end
    end
    rotation()
end

function rotation()
    if GetWorld() == nil then return end
    if MODE == "PTHT" then
        local ready = getReady()
        if ready and ready > 0 then
            harvest()
        end
        plant()
    end
end

function tryReconnect()
    log("`4Disconnected. `wAttempting to reconnect to " .. WORLD .. "...")
    local attempts = 0
    local maxAttempts = 5

    while attempts < maxAttempts do
        attempts = attempts + 1

        SendPacket(2, "action|join_request\nname|" .. WORLD)
        SendPacket(3, "action|join_request\nname|" .. WORLD .. "\ninvitedWorld|0")
        
        Sleep(7000)
        
        if GetWorld() and GetWorld().name == WORLD then
            log("`2RECONNECTED! `wBack in " .. WORLD)
            isDisconnected = false
            getRemote()
            return true
        else
            log("`4Failed to reconnect. `wRetrying in 5 seconds...")
            Sleep(5000)
        end
    end

    return false
end

function main_loop()
    if TOTAL_PTHT == "UNLI" then
        while true do
            if isDisconnected or GetWorld() == nil then
                if not tryReconnect() then
                    log("`4Reconnection failed. `wExiting script.")
                    return
                end
            else
                reconnect()
            end
            Sleep(1000)
        end
    elseif tonumber(TOTAL_PTHT) then
        local i = 0
        repeat
            if isDisconnected or GetWorld() == nil then
                if not tryReconnect() then
                    log("`4Reconnection failed. `wExiting script.")
                    return
                end
            else
                i = i + 1
                reconnect()
                if not MAG_EMPTY then
                    SendPacket(2, "action|input\n|text|`w[`bPTHT COUNT ROTATION: `2" .. i .. "`w]")
                end
            end
            Sleep(1000)
        until i == tonumber(TOTAL_PTHT)
        SendPacket(2, "action|input\n|text|`w[`bPTHT DONE ROTATION: `2" .. i .. " `b/`2 " .. TOTAL_PTHT .."`w]")
    end
end

function start()
    SendPacket(2, "action|input\n|text|`w[`9Starting PTHT Script by `#Muffinn`w]")
    
    if not getRemote() then
        log("`4Unable to get a remote. `wPlease check magplants and refill if necessary.")
        return
    end
    
    main_loop()
end

local user = GetLocal().userid

local match_found = false

for _, id in pairs(tabel_uid) do
    tabel_uid = tonumber(tabel_uid)
    if GetLocal().userid == tonumber(id) then
        match_found = true
        break
    end
end

if match_found then
    log("`wIDENTIFY PLAYER: " .. GetLocal().name)
    Sleep(1000)
    log("`wCHECKING UID")
    Sleep(2000)
    log("`w[`9PTHT TYPE: `b".. PT_TYPE .."`w][`9PTHT DESIDERED: `2"..TOTAL_PTHT.."`w]")
    Sleep(600)
    log("`wWait...")
    SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_lonely|"..LONELY.."\ncheck_gems|"..GEMS.."\ncheck_ignoreo|"..IGNORE_DROP.."\ncheck_antibounce|1")
    start()
else
    log("`wIDENTIFY PLAYER: " .. GetLocal().name)
    Sleep(1000)
    log("`wCHECKING UID")
    Sleep(2000)
    log("`4UID TIDAK TERDAFTAR KONTAK DISCORD `#@muffinncps")
  return
end
