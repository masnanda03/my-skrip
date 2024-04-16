--MUFFINN STORE--
tabel_uid = { 134611, 601763, 345229, 459962, 758520
}

local HADAP_BFG = 32
local SUCKBGEMS = false
local DELAY_SUCK = 10
local MYTHICAL = 14746

-- DONT TOUCH
ChangeValue("[C] Modfly", true)
local myLink = Webhook_Url
local WEBHOOK_DELAY = Webhook_Send
local posbfgx,posbfgy = GetLocal().pos.x + 31 , GetLocal().pos.y - 15
local STAR_SMT = false
local start = os.time()
local NAME = GetLocal().name
local WORLD_NAME = GetWorld().name
local gems = GetPlayerInfo().gems

function removeColorAndSymbols(str)
    local cleanedStr = string.gsub(str, "`(%S)", '')
    cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
    return cleanedStr
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

local function cek(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end    
    end
    return 0
end

if SUCKBGEMS then
    MODE = "Auto Suck Bgems Every ".. DELAY_SUCK .. " Minutes !"
elseif not SUCKBGEMS then
    MODE = "Nonaktif"
end

function wh()
    PGEMS = 0
    BGEMS = 0
    UWS = 0
    for _,object in pairs(GetObjectList()) do
            if object.id == 14420 then
    PGEMS = PGEMS + object.amount
    elseif object.id == 14668 then
    BGEMS = BGEMS + object.amount
    elseif object.id == 12600 then
    UWS = UWS + object.amount
    end
    end
    local ingfokan = GetPlayerInfo().gems - gems
    gems = GetPlayerInfo().gems
    MakeRequest(myLink,"POST",{["Content-Type"] = "application/json"}, [[
{
  "username": "𝐌𝐔𝐅𝐅𝐈𝐍𝐍 𝐂𝐎𝐌𝐌𝐔𝐍𝐈𝐓𝐘",
  "avatar_url": "https://media.discordapp.net/attachments/1136847163905818636/1196094627372073041/MUFFINN_STORE_ICON.png?ex=65f6fa6d&is=65e4856d&hm=51bb58f88d7c0fac188ffe8d5181d63767f060e53a90d97d9f3bee0c9fea0286&format=webp&quality=lossless&",
  "embeds": [
    {
      "author": {
        "name": "AUTO PNB MNECK ADVANCE"
      },
      "color": 15258703,
      "fields": [
        {
          "name": "<a:crown:1146478446768291932> ACCOUNT INFO",
          "value": "<:player:1203057110208876656> Name : ]]..  removeColorAndSymbols(NAME) .. [[\n<:world:1203057112595562628> World : ]] .. WORLD_NAME .. [[\n===============================",
          "inline": false
        },
        {
          "name": "<a:loading:1138845537194483803> GEMS INFO",
          "value": "<:GemSprites2:1116878075964166154> Gems Owned : ]] .. FormatNumber(gems) ..[[\n<:gems:1083907540242407547> Gems Earn : ]] .. FormatNumber(ingfokan) .. [[ ( In ]] .. WEBHOOK_DELAY .. [[ Sec)\n===============================",
          "inline": false
        },
        {
          "name": "<:BS_Stock:1154233366888075324> STOCK PLAYER",
          "value": "<:arroz:1147165858171457557> Arroz Can Pollo : ]].. cek(4604) .. [[\n<:clover:1147165841037742120> Lucky Clover : ]].. cek(528) .. [[\n===============================",
          "inline": false
        },
        {
          "name": "<:GrowScan:1183848929247371274> EARNING ITEMS",
          "value": "<:bgems:1192743794572001280> BGEMS : ]].. BGEMS .. [[\n<:pinkgems:1213941887786815620> PGEMS : ]].. PGEMS .. [[\n<:UWS:1111357396414103602> UWS : ]] .. UWS .. [[\n===============================",
          "inline": false
        },
        {
          "name": "<:gtmag:1135828479598940222> MAGPLANT INFO",
          "value": "Magplant : ]].. count .. [[\nMagplant In Use : [ ]] .. Mag[count].x ..[[ , ]] .. Mag[count].y .. [[ ]\n===============================",
          "inline": false
        }
      ],
      "footer": {
        "text": "TIME : ]] .. os.date("%Y-%m-%d %H:%M:%S", wibTime) .. [[ "
          }
        }
      ]
    }]])
    end

function getWIBTime()
    local currentTimeUTC = os.time()
    local offsetToWIB = 7 * 60 * 60
    local currentTimeWIB = currentTimeUTC + offsetToWIB
    return currentTimeWIB
end
local wibTime = getWIBTime()

nono = true -- DONT TOUCH
local function main()
local function consume(id, x, y)
    pkt = {}
    pkt.type = 3
    pkt.value = id
    pkt.px = math.floor(GetLocal().pos.x / 32 +x)
    pkt.py = math.floor(GetLocal().pos.y / 32 +y)
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

local function ontext(str)
    SendVariantList({[0] = "OnTextOverlay", [1]  = str })
end

function MNECK(x,y,state)
    SendPacketRaw(false,{state = state ,px = GetLocal().pos.x, py = GetLocal().pos.y, x = x ,y = y})
end

function WEAR(id)
    SendPacketRaw(false,{type = 10, value = id})
    
end
local function wrench()
    pkt = {}
    pkt.type = 3
    pkt.value = 32
    pkt.state = 8
    pkt.px = Mag[count].x
    pkt.py = Mag[count].y
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

local function GetMagN()
    Mag = {}
    count = 0
    for _, tile in pairs(GetTiles()) do
        if (tile.fg == 5638) and (tile.bg == BACKGROUND_MAGPLANT) then
            count = count + 1
            Mag[count] = {x = tile.x, y = tile.y}
        end
    end
end
    GetMagN()

local function scheat()
    if (cheats == true) and (GetLocal().pos.x//32 == xawal) and (GetLocal().pos.y//32 == yawal) then
        Sleep(2000)
        MNECK(posbfgx,posbfgy,HADAP_BFG)
        Sleep(700)
        WEAR(MYTHICAL)
Sleep(2000)
        SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_lonely|0\ncheck_antibounce|1\ncheck_gems|"..TAKE_GEMS.."\n")
        Sleep(300)

        cheats = false
    end
end

local function fmag()
    if (findmag == true) then
        Sleep(200)
        FindPath(Mag[count].x , Mag[count].y - 1)
        ontext("Wait Check Magplant")
        Sleep(300)
        findmag = false
        takeremote = true
end
end

local function tremote()
    Sleep(500)
    if (takeremote  == true) then
        if GetLocal().pos.x//32 == Mag[count].x and GetLocal().pos.y//32 == Mag[count].y - 1 then
            Sleep(300)
            wrench()
            Sleep(100)
        if nono == false then
            ontext("`cSuccess Take Remote Mag")
            SendPacket(2,"action|dialog_return\ndialog_name|magplant_edit\nx|"..Mag[count].x.."|\ny|"..Mag[count].y.."|\nbuttonClicked|getRemote\n\n")
            takeremote = false
        elseif nono == true then
            nono = false
            takeremote = false
            findmag = true
        end
        else
            SendVariantList({[0] = "OnTalkBubble", [1] = GetLocal().netid, [2] = "`4Run Ulang script gunain /ghost"})
            takeremote = false
        end
    end
end

AddHook("onvariant", "Kaede", function(var)
    if var[0] == "OnConsoleMessage" and var[1]:find("World Locked") then
        lepasneck = true
        return true
    end
    if var[0] == "OnConsoleMessage" and var[1]:find("Where would you like to go?") then
        getworld = true
        return true
    end
    if var[0] == "OnTalkBubble" and var[2]:find("You received a MAGPLANT 5000 Remote.") then
        FindPath(xawal,yawal)
        cheats = true
        return true
    end
    if var[0] == "OnTalkBubble" and var[2]:find("The MAGPLANT 5000 is empty.") then
        empty = true
        return true
    end
    if var[0] == "OnDialogRequest" and var[1]:find("The machine is currently empty!") then
        nothing = true
        nono = true
        return true
    end
    if var[0] == "OnDialogRequest" and var[1]:find("The machine contains") then
        return true
    end
    if var[0]:find("OnSDBroadcast") then
        return true
    end
    if var[0] == "OnConsoleMessage" then
        if var[1]:find("`oYour luck has worn off.") then
           AUTO_CONSUME = true
        elseif var[1]:find("`oYour stomach's rumbling.") then
           AUTO_CONSUME = true
        end
        if var[0]:find("OnConsoleMessage") and var[1]:find("Cheat Active") then
           return true
        end
        if var[0]:find("OnConsoleMessage") and var[1]:find("Whoa, calm down toggling cheats on/off... Try again in a second!") then
           return true
        end
        if var[0]:find("OnConsoleMessage") and var[1]:find("Applying cheats...") then
           return true
        end
        if var[0]:find("OnConsoleMessage") and var[1]:find("Spam detected") then
           return true
        end
     end
     if var[0]:find("OnDialogRequest") and var[1]:find("Item Finder") then
        return true
     end
if var[0]:find("OnConsoleMessage") and var[1]:find("entered") then
return true
end
if var[0]:find("OnTalkBubble") and var[2]:find("entered") then
return true
end
if var[0]:find("OnConsoleMessage") and var[1]:find("left") then
return true
end
if var[0]:find("OnTalkBubble") and var[2]:find("left") then
return true
end
if var[0]:find("OnTalkBubble") and var[2]:find("Collected") then
    return true
   end
   if var[0]:find("OnTalkBubble") and var[2]:find("`wXenonite has changed everyone's powers!") then
    return true
   end
  if var[0]:find("OnConsoleMessage") and var[1]:find("`wXenonite has changed everyone's powers!") then
    return true
   end
  if var[0]:find("OnTalkBubble") and var[2]:find("`1O`2h`3, `4l`5o`6o`7k `8w`9h`ba`!t `$y`3o`2u`4'`ev`pe `#f`6o`8u`1n`7d`w!") then
    return true
   end
  if var[0]:find("OnConsoleMessage") and var[1]:find("`1O`2h`3, `4l`5o`6o`7k `8w`9h`ba`!t `$y`3o`2u`4'`ev`pe `#f`6o`8u`1n`7d`w!") then
    return true
   end
if var[0]:find("OnDialogRequest") and var[1]:find("MAGPLANT 5000") then
return true
end
end)

while true do
    Sleep(2000)
    if count > 0 then
        if (getworld == true) then
            ontext("`2World : "..WORLD_NAME)
            SendPacket(3, "action|join_request\nname|"..WORLD_NAME.."\ninvitedWORLD_NAME|0")
            Sleep(2300)
            getworld = false
        end
        if (lepasneck == true) then
            WEAR(MYTHICAL)
Sleep(2000)
lepasneck = false
            findmag = true
        end
        if (findmag == true) then
            Sleep(100)
            fmag()
        end
        if (cheats == true) then
            Sleep(100)
            scheat()
        end
        if (takeremote == true) then
            tremote()
            Sleep(500)
        end
        if (empty == true) then
            WEAR(MYTHICAL)
            SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\ncheck_bfg|0")
            Sleep(200)
            count = count - 1
            empty = false
            findmag = true
        end
        if (nothing == true) then
            Sleep(400)
            count = count - 1
            nothing = false
            findmag = true
        end
    else
        ontext("`4Magplant Empty")
    end
    if (AUTO_CONSUME == true) then
        WEAR(MYTHICAL)
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\ncheck_bfg|0")
Sleep(1000)
        FindPath(xawal,yawal)
        Sleep(2000)
        consume(528,0,0)
        ontext("`0Eat `2Clover")
    Sleep(2000)
    consume(4604,0,0)
    ontext("`0Eat `9Arroz")
	Sleep(2000)
    findmag = true
    AUTO_CONSUME = false
    end
if os.time() - start >= WEBHOOK_DELAY then
STAR_SMT = true
start = os.time()
wh()
Sleep(1000)
STAR_SMT = false
end
if SUCKBGEMS then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nbuttonClicked|bgem_suckall")
Sleep(DELAY_SUCK * 60000)
end
end
end

local function onsay(str)
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

if match_found == true then
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^UID TERDAFTAR")
    Sleep(1000)
    onsay("`2SC PNB MNECK ADVANCE RECONNECT BY `^MUFFINN STORE")
    Sleep(2000)

xawal = GetLocal().pos.x//32
yawal = GetLocal().pos.y//32
main()

else
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    onsay("`4UID Not Found")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `4UID TIDAK TERDAFTAR KONTAK DISCORD MUFFINN_S")
end
