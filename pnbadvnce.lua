--MUFFINN STORE--
tabel_uid = {
	134611, 675313, 101404, 102856, 662258, 
	719262, 447487, 597946, 674224, 706611, 
	714689, 120729, 248228, 675396, 475429, 
	377549, 329132, 705698, 730592, 758520, 
	180077, 177766, 348639, 625273, 291920, 
	104455, 356083, 750484, 268314, 737747, 
	156249, 158796, 719929, 727608, 774715, 
	774603, 740989, 638621, 264097, 357736,
	169254, 360694, 364650, 346465, 305824,
	775453, 774228, 777469, 776168, 773701,
	771625, 765856, 354723, 499054, 588529,
	780969, 598089, 613488, 612099, 612239,
	616605, 637880, 238967, 779428, 784764,
	780639, 786533, 719812, 261125, 782866, 
	789167, 24615, 114394, 784299, 787800,
	784741, 403039, 140249, 250873, 382092,
	273059, 169778, 782878, 530878, 281238,
	569241, 788943, 795045, 185884, 146424,
	1032, 708029, 258743, 193494, 786937,
	593363, 486126, 798666, 503290, 790851,
	504862, 799789, 377841, 801299, 802329,
	781105, 797167, 774226
}

--BACOT KONTOL--
Posisi_Bfg = Kanan
Kanan = 32
Kiri = 48
myLink = Webhook_Url
local HADAP_BFG = Kiri or Kanan
local STAR_SMT = true
local start = os.time()
local NAME = GetLocal().name
local WORLD_NAME = GetWorld().name
local gems = GetPlayerInfo().gems
local MAG_STOCK = 0
local MODE_BDL = "Fiture : Nonaktif"
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

local function cek(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then
            return item.amount
        end    
    end
    return 0
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

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

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
            if object.id == 14728 then
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
      "username": "𝐌𝐔𝐅𝐅𝐈𝐍𝐍 𝐂𝐎𝐌𝐌𝐔𝐍𝐈𝐓𝐘",
      "avatar_url": "https://media.discordapp.net/attachments/1136847163905818636/1196094627372073041/MUFFINN_STORE_ICON.png?ex=65f6fa6d&is=65e4856d&hm=51bb58f88d7c0fac188ffe8d5181d63767f060e53a90d97d9f3bee0c9fea0286&format=webp&quality=lossless&",
      "embeds": [
        {
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
             "name": "<:GrowScan:1183848929247371274> EARNING ITEMS",
              "value": "<:bgems:1192743794572001280> BGEMS : ]].. BGEMS .. [[\n<:pinkgems:1213941887786815620> PGEMS : ]].. PGEMS .. [[\n<:UWS:1111357396414103602> UWS : ]] .. UWS .. [[\n===============================",
              "inline": false
            },
               {
                "name": "<a:shinydl:1152622664159068171> Auto Convert",
                 "value": "]].. MODE_BDL .. [[\nTotal Convert : ]].. FormatNumber(DLPS) .. [[ <a:shinydl:1152622664159068171>!",
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
                 "value": "]].. MODE_SUCK .. [[",
                 "inline": false
               },
            {
             "name": "===============================\n:timer: SCRIPT UP TIME",
              "value": "]] .. format_time(get_uptime()) .. [[\n===============================",
              "inline": false
            },
            {
             "name": "<a:info1:1130833174327463956> MUFFINN COMMUNITY",
              "value": "",
              "inline": false
            }
            ]
        }
        ]
    }]])
end
function cvtd(id)
pkt = {}
pkt.value = id
pkt.type = 10
SendPacketRaw(false, pkt)
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
  return string.format("%d Day / %02d Hours / %02d Minute", days, hours, minutes)
end

nono = true -- DONT TOUCH
local function main()
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

local function posbreak(x, y)
    local pkt = {}
    pkt.type = 3
    pkt.value = 32
    pkt.state = 8
    pkt.px = x
    pkt.py = y
    pkt.x = GetLocal().pos.x
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
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
            ontext("`cMagplant Count : `1".. count)
            count = count + 1
            Mag[count] = {x = tile.x, y = tile.y}
        end
    end
end
    GetMagN()

local function scheat()
    if (cheats == true) and (GetLocal().pos.x//32 == BFG_X) and (GetLocal().pos.y//32 == BFG_Y) then
        Sleep(700)
        if DROP_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_lonely|0\ncheck_antibounce|1\ncheck_gems|0\ncheck_lonely|"..LONELY_MODE.."\ncheck_ignoreo|"..IGNORE_MODE.."\ncheck_ignoref|"..IGNOREALL_MODE)
elseif TAKE_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_lonely|0\ncheck_antibounce|1\ncheck_gems|1\ncheck_lonely|"..LONELY_MODE.."\ncheck_ignoreo|"..IGNORE_MODE.."\ncheck_ignoref|"..IGNOREALL_MODE)
elseif SUCK_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_lonely|0\ncheck_antibounce|1\ncheck_gems|0\ncheck_lonely|"..LONELY_MODE.."\ncheck_ignoreo|"..IGNORE_MODE.."\ncheck_ignoref|"..IGNOREALL_MODE)
elseif BDL_MODE then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\ncheck_bfg|1\ncheck_lonely|0\ncheck_antibounce|1\ncheck_gems|1\ncheck_lonely|"..LONELY_MODE.."\ncheck_ignoreo|"..IGNORE_MODE.."\ncheck_ignoref|"..IGNOREALL_MODE)
end
        Sleep(300)
        cheats = false
    end
end

local function fmag()
        Sleep(200)
        FindPath(Mag[count].x , Mag[count].y - 1)
        Sleep(1200)
        ontext("Wait Check Magplant")
        Sleep(300)
        findmag = false
        takeremote = true
end

local function tremote()
    Sleep(500)
    if takeremote then
        if GetLocal().pos.x//32 == Mag[count].x and GetLocal().pos.y//32 == Mag[count].y - 1 then
            Sleep(300)
            wrench()
            Sleep(100)
            if not nono then
                Sleep(200)
                ontext("`cSuccess Take Remote Mag")
                SendPacket(2,"action|dialog_return\ndialog_name|magplant_edit\nx|"..Mag[count].x.."|\ny|"..Mag[count].y.."|\nbuttonClicked|getRemote\n\n")
                takeremote = false
                return true
            else
                nono = false
                takeremote = false
                findmag = true
                return true
            end
        end
    end
end

AddHook("onvariant", "Kaede", function(var)
    if var[0] == "OnConsoleMessage" and var[1]:find("World Locked") then
        findmag = true
        return true
    end
    if var[0] == "OnConsoleMessage" and var[1]:find("Where would you like to go?") then
        getworld = true
        return true
    end
    if var[0] == "OnTalkBubble" and var[2]:find("You received a MAGPLANT 5000 Remote.") then
        FindPath(BFG_X, BFG_Y)
        cheats = true
        return true
    end
    if var[0] == "OnTalkBubble" and var[2]:find("The MAGPLANT 5000 is empty.") then
        empty = true
        return true
    end
    if var[0] == "OnDialogRequest" and var[1]:find("Stock: `4EMPTY!") then
        nothing = true
        nono = true
        return true
    end
    if var[0] == "OnConsoleMessage" then
        if var[1]:find("`oYour luck has worn off.") then
            AUTO_CONSUME = true
        elseif var[1]:find("`oYour stomach's rumbling.") then
            AUTO_CONSUME = true
        end
    end

    if var[0]:find("OnDialogRequest") then
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
    if var[0]:find("OnConsoleMessage") and var[1]:find("You earned 10000 in Tax Credits!") then
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


fmag()
while true do
    Sleep(2000)
    if count > 0 then
        if (getworld == true) then
            ontext("`2World : "..WORLD_NAME)
            SendPacket(3, "action|join_request\nname|"..WORLD_NAME.."\ninvitedWORLD_NAME|0")
            Sleep(2300)
            getworld = false
        end
        if (findmag == true) then
            MAG_STOCK = 0
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
        SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\ncheck_bfg|0")
        Sleep(1000)
        FindPath(BFG_X, BFG_Y)
        Sleep(1000)
        consume(528,0,0)
        LogToConsole("`0Eat `2Clover")
        Sleep(2000)
        consume(4604,0,0)
        LogToConsole("`0Eat `9Arroz")
        consume(-64,0,0)
        Sleep(2000)
        posbreak(BFG_X, BFG_Y)
        Sleep(500)
        cheats = true
        Sleep(1000)
        AUTO_CONSUME = false
    end
if GetPlayerInfo().gems >= 100000 then
if BDL_MODE then
    MODE_BDL = "Fiture : Auto Convert Gems : Activated ! "
SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|".. TEL_X .."|\ny|".. TEL_Y .."|\nbuttonClicked|dlconvert")
    if cek(1796) >= 100 then
    Sleep(500)
    SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|".. TEL_X .."|\ny|".. TEL_Y .."|\nbuttonClicked|bglconvert")
    Sleep(100)
    end
elseif not BDL_MODE then
    MODE_BDL = "Fiture : Nonaktif"
    end
end


if os.time() - start >= WEBHOOK_DELAY then
    STAR_SMT = true
    cekbank()
    Sleep(5000)
    start = os.time()
    waktunya = os.time() - time
    if SUCK_MODE then
        MODE_SUCK = "Fiture : Auto Suck Bgems Activated !"
        SendPacket(2,"action|dialog_return\ndialog_name|popup\nbuttonClicked|bgem_suckall")
    elseif not SUCK_MODE then
        MODE_SUCK = "Fiture : Nonaktif"
    end
    wh()
    Sleep(1000)
    TOTAL_BGEMS = 0
    STAR_SMT = false
end
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

if match_found == true then
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^UID TERDAFTAR")
    Sleep(1000)
    say("`2SC PNB ADVANCE RECONNECT BY `^MUFFINN STORE")
    Sleep(2000)

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
