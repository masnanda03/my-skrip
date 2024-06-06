--MUFFINN STORE--
tabel_uid = { 
    134611, 601763, 345229, 459962, 
    353718, 140350
}

ChangeValue("[C] Modfly", true)
local myLink = Webhook_Url
local MYTHICAL = -562
local AUTO_CONSUME = true
local STAR_SMT = false
local start = os.time()
local NAME = GetLocal().name
local WORLD_NAME = GetWorld().name
local gems = GetPlayerInfo().gems
time = os.time()
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

function per(id)
for _, inv in pairs(GetInventory()) do
if inv.id == id then
return inv.amount
end
end
return 0
end

BGLSS = per(7188)
GGLSS = per(11550)
DLS = per(1796)
BGLS = per(7188) * 100
GGLS = per(11550) * 10000
HARTAS = DLS+BGLS+GGLS
BGEMSS = 0
local MAG_STOCK = 0
local TOTAL_BGEMS = 0
function cekbank()
SendPacket(2,"action|dialog_return\ndialog_name|popup\nbuttonClicked|bgems")
end


 function getWIBTime()
    local currentTimeUTC = os.time()
    local offsetToWIB = 7 * 60 * 60
    local currentTimeWIB = currentTimeUTC + offsetToWIB
    return currentTimeWIB
end
local wibTime = getWIBTime()
function wh()
BGLS = per(7188)
GGLS = per(11550)
DL = per(1796)
BGL = per(7188) * 100
GGL = per(11550) * 10000
HARTA = DL+BGL+GGL
DLPS = HARTA - HARTAS
    PGEMS = 0
    BGEMS = 0
    UWS = 0
    for _,object in pairs(GetObjectList()) do
            if object.id == 14420 then
    PGEMS = PGEMS + object.amount
    elseif object.id == 14976 then
    BGEMS = BGEMS + object.amount
    elseif object.id == 12600 then
    UWS = UWS + object.amount
    end
    end
    local ingfokan = GetPlayerInfo().gems - gems
    gems = GetPlayerInfo().gems
    MakeRequest(myLink,"POST",{["Content-Type"] = "application/json"}, [[
    {
      "username": "MUFFINN COMMUNITY",
      "avatar_url": "https://cdn.discordapp.com/attachments/1136847163905818636/1242127856813740083/standard.gif?ex=664eaf76&is=664d5df6&hm=1774f98c458b7575cecb983aed4d7a8241825918da377b18f0abd896773cc202&",
      "embeds": [
        {
          "author": {
            "name": "AUTO PNB MNECK AUTO RECONNECT"
          },
          "title": "<a:petir:1203232590832734209> AUTO PNB ADVANCE <a:petir:1203232590832734209>",
          "color": 15258703,
          "fields": [
            {
              "name": "<a:BS_panda_wave:1152635707408519310> ACCOUNT INFO",
              "value": "<:player:1203057110208876656> Name : ]]..  removeColorAndSymbols(NAME) .. [[\n<:world:1203057112595562628> World : ]] .. WORLD_NAME .. [[\n<:gtmag:1135828479598940222> Magplant : ]] .. count .. [[\n===============================",
              "inline": false
            },
            {
              "name": "<a:loading:1138845537194483803> GEMS INFO",
              "value": "<:gems:1111617537629757501> Gems Owned : ]] .. FormatNumber(gems) ..[[\n<:gems:1093032105774162021> Gems Earn : ]] .. FormatNumber(ingfokan) .. [[ ]].. math.floor(WEBHOOK_DELAY/60)..[[ Minutes!\n===============================",
              "inline": false
            },
            {
                "name": "<:bgems:1192743794572001280> BGEMS",
                "value": "TOTAL : ]] .. FormatNumber(TOTAL_BGEMS) ..[[<:bgems:1192743794572001280>\n( Bgems in Bank )\n===============================",
                "inline": false
              },
    {
      "name": "<:BS_Stock:1154233366888075324> STOCK PLAYER",
      "value": "<:arroz:1147165858171457557> Arroz Can Pollo : ]].. cek(4604) .. [[\n<:clover:1147165841037742120> Lucky Clover : ]].. cek(528) .. [[\n===============================",
      "inline": false
    },
            {
             "name": "<:GrowScan:1183848929247371274> ITEM DROPED",
              "value": "<:bgems:1192743794572001280> BGEMS : ]].. BGEMS .. [[\n<:pinkgems:1213941887786815620> PGEMS : ]].. PGEMS .. [[\n<:UWS:1111357396414103602> UWS : ]] .. UWS .. [[\n===============================",
              "inline": false
            },
               {
                "name": "<a:shinydl:1152622664159068171> Auto Convert",
                 "value": "Fitur : ]].. MODEDL .. [[\nBuying  Total : ]].. FormatNumber(DLPS) .. [[ <a:shinydl:1152622664159068171>!",
                 "inline": false
               },
               {
                "name": "BEFORE ",
                 "value": "]].. GGLSS.. [[ <a:irengcps:1195773860105162863> ]].. BGLSS ..[[ <a:shinybgl:1101039551142703224> ]].. DLS ..[[ <a:shinydl:1152622664159068171>",
                 "inline": false
               },
               {
                "name": "AFTER",
                 "value": "]].. GGLS.. [[ <a:irengcps:1195773860105162863> ]].. BGLS ..[[ <a:shinybgl:1101039551142703224> ]].. DL ..[[ <a:shinydl:1152622664159068171>",
                 "inline": false
               },
               {
                "name": "===============================\n<:bgems:1192743794572001280> Bgems Mode",
                 "value": "Fitur : ]].. MODE .. [[",
                 "inline": false
               },
               {
                "name": "===============================\n:timer: SCRIPT UP TIME",
                 "value" : "]].. math.floor(waktunya%86400/3600) ..[[ Hours ]].. math.floor(waktunya%86400%3600/60) ..[[ Minutes ]].. math.floor(waktunya%3600%60) ..[[ Seconds !",
                 "inline": false
               }
          ],
        "footer": {
        "text": "TIME : ]] .. os.date("%Y-%m-%d %H:%M:%S") .. [[ "
       }}
      ]
    }]])
    end

function cek(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end    
    end
    return 0
end

function cvtd(id)
pkt = {}
pkt.value = id
pkt.type = 10
SendPacketRaw(false, pkt)
end





nono = true
local function main()

AddHook("onvariant", "Kaede", function(var)
if var[0] == "OnConsoleMessage" and var[1]:find("World Locked") then
delayyed = true
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
pindahr = true
return true
end
if var[0] == "OnDialogRequest" and var[1]:find("Stock: `4EMPTY!") then
nothing = true
nono = true
return true
end
if var[0] == "OnConsoleMessage" then
if var[1]:find("`oYour luck has worn off.") then
findmag = false
AUTO_CONSUMES = true
elseif var[1]:find("`oYour stomach's rumbling.") then
AUTO_CONSUMES = true
findmag = false
end
end
if var[0]:find("OnConsoleMessage") and var[1]:find("`oThe mythical `bShadow Cloning`` ability is the blessing of this necklace!") then
MneckON = true
MneckOFF = false
return true
end
if var[0]:find("OnConsoleMessage") and var[1]:find("`oNo more cloning! Sad...") then
MneckOFF = true
MneckON = false
return true
end
if var[0]:find("OnConsoleMessage") and var[1]:find("`4Global System Message") then
restartt = true
return true
end
if var[0]:find("OnRequestWorldSelectMenu") then
getworld = true
return true
end
if var[0]:find("OnSDBroadcast") then
return true
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
if var[0] == "OnTalkBubble" and var[2]:find(" You got `$Diamond Lock``!") then
return true
end
if var[0] == "OnDialogRequest" and var[1]:find("Diamond Lock") then
return true
end
if var[0]:find("OnDialogRequest") and var[1]:find("`bThe Black Backpack````") and var[1]:find("You have `$(%d+)``") then
TOTAL_BGEMS = TOTAL_BGEMS + tonumber(var[1]:match("`$(%d+)`` Black Gems in the Bank"))
return true
end
if var[0]:find("OnDialogRequest") and var[1]:match("`wMAGPLANT 5000````") and var[1]:find("Stock: `$(%d+)``") then
MAG_STOCK = MAG_STOCK + tonumber(var[1]:match("`$(%d+)`` items."))
return true
end
return false
end)

AddHook("onprocesstankupdatepacket", "pussy", function(packet)
    if packet.type == 3 or packet.type == 8 or packet.type == 17 then
        return true
    end
end)
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

local function GetTel()
Tel = {}
Pos = 0
for x = 0,199 do
for y = 0,199 do
tile = GetTile(x, y)
if (tile.fg == 3898) then
Pos = Pos + 1
Tel[Pos] = {x = tile.x, y = tile.y}
end
end
end
end
GetTel()

local function scheat()
    if (cheats == true) and (GetLocal().pos.x//32 == xawal) and (GetLocal().pos.y//32 == yawal) then
if MneckON == false then
WEAR(MYTHICAL)
Sleep(2000)
elseif MneckON == false then
WEAR(MYTHICAL)
Sleep(2000)
end
MNECK(GetLocal().pos.x + 21,GetLocal().pos.y - 9,32)
Sleep(500)
        if DROP_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_gems|0\n")
elseif TAKE_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_gems|1\n")
elseif SUCK_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_gems|0\n")
elseif BDL_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_gems|1\n")
end
Sleep(300)
        cheats = false
    end
end
local function fmag()
    if (findmag == true) then
        Sleep(200)
        FindPath(Mag[count].x , Mag[count].y - 1)
        ontext("Cek MAGPLANT")
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
        if nono == false and MneckOFF == true then
            ontext("`2[ `e Success Take Remote `2]")
            SendPacket(2,"action|dialog_return\ndialog_name|magplant_edit\nx|"..Mag[count].x.."|\ny|"..Mag[count].y.."|\nbuttonClicked|getRemote\n\n")
            takeremote = false
        elseif nono == true and MneckON == false then
            ontext("Take Remote")
            nono = false
            takeremote = false
            findmag = true
        end
if MneckOFF == false then
WEAR(MYTHICAL)
Sleep(2000)
end
        else
            SendVariantList({[0] = "OnTalkBubble", [1] = GetLocal().netid, [2] = "`0Run Ulang script\n-Jangan lupa mode /ghost\n-kasih bakcground dimagplant yang bener\n-diharapkan jalan ga terhalang blok "})
            takeremote = false
        end
    end
end

WEAR(MYTHICAL)
if (AUTO_CONSUME == true) then
findmag = false
if MneckON == true then
WEAR(MYTHICAL)
Sleep(2000)
end
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\ncheck_bfg|0")
Sleep(500)
FindPath(xawal,yawal)
Sleep(500)
ontext("`2Auto `0eat `2Consumable")
consume(528,0,0)
Sleep(1000)
consume(4604,0,0)
Sleep(500)
AUTO_CONSUME = false
findmag = true
end

while true do
Sleep(1000)
if count > 0 then
if MneckON then
IMNECK = "The mythical Shadow Cloning ability is the blessing of this necklace! (Cloning! mod added)"
elseif MneckOFF then
IMNECK = "No more cloning! Sad... (Cloning! mod removed)"
end
if (AUTO_CONSUMES == true) then
findmag = false
if MneckON == true then
WEAR(MYTHICAL)
Sleep(2000)
end
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\ncheck_bfg|0")
Sleep(500)
FindPath(xawal,yawal)
Sleep(500)
ontext("`2Auto `0eat `2Consumable")
consume(528,0,0)
Sleep(1000)
consume(4604,0,0)
Sleep(500)
AUTO_CONSUMES = false
cheats = true
end
if (findmag == true) then
MAG_STOCK = 0
    Sleep(100)
    fmag()
end
if (takeremote == true) then
    tremote()
    Sleep(500)
end
if (nothing == true) then
    Sleep(400)
    count = count - 1
    nothing = false
    findmag = true
end
if (cheats == true) then
    Sleep(100)
    scheat()
end
if (pindahr == true) then
    Sleep(1000)
    WEAR(MYTHICAL)
    Sleep(1000)
pindahr = false
empty = true
end
if (empty == true) then
    SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\ncheck_bfg|0")
    Sleep(200)
    count = count - 1
    empty = false
    findmag = true
end
if (getworld == true) then
    ontext("`2[ `0Masuk ke `e "..WORLD_NAME.." `2]")
    SendPacket(3, "action|join_request\nname|"..WORLD_NAME.."\ninvitedWORLD_NAME|0")
    Sleep(7000)
    getworld = false
end
if delayyed then
    WEAR(MYTHICAL)
    Sleep(1000)
findmag = true
delayyed = false
end
if restartt then
Sleep(7000)
SendPacket(2,"action|enter_game")
Sleep(2000)
end
if GetPlayerInfo().gems >= 100000 then
if BDL_MODE then
    MODEDL = "Auto Convert Gems : Activated ! "
SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|".. xawal .."|\ny|".. yawal .."|\nbuttonClicked|dlconvert")
    if cek(1796) >= 100 then
    Sleep(500)
    SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|".. xawal .."|\ny|".. yawal .."|\nbuttonClicked|bglconvert")
    Sleep(100)
    end
elseif not BDL_MODE then
    MODEDL = "Nonaktif"
    end
end
    if SUCK_MODE then
MODE = "Auto Suck Bgems Activated !"
for _,object in pairs(GetObjectList()) do
if object.id == 14976 then
BGEMSS = BGEMSS + object.amount
if BGEMSS >= DGEMS * 100 then
    SendPacket(2,"action|dialog_return\ndialog_name|popup\nbuttonClicked|bgem_suckall")
BGEMSS = 0
end
end
end
elseif not SUCK_MODE then
        MODE = "Nonaktif"
    end
    if os.time() - start >= WEBHOOK_DELAY then
    STAR_SMT = true
    cekbank()
    Sleep(5000)
    start = os.time()
waktunya = os.time() - time
    wh()
    Sleep(1000)
TOTAL_BGEMS = 0
    STAR_SMT = false
    end
else
    ontext("`4All magplant empety")
end
end
end

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
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
    say("`2SC PNB MNECK AUTO RECONNECT BY `^MUFFINN STORE")
    Sleep(2000)

xawal = GetLocal().pos.x//32
yawal = GetLocal().pos.y//32
main()

else
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    say("`4UID Not Found")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `4UID TIDAK TERDAFTAR KONTAK DISCORD MUFFINN_S")
end
