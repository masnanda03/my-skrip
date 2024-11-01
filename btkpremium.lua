-- [ BTK HELPER - MUFFINN COMMUNITY ] --
tabel_uid = {"134611", "588529", "122460", "847877", "160154", "37962", "606623", "173288", "853110", "852522", "182857", "239848", "309381"}

data = {}
datalock = {}
local pull = false
local kick = false
local ban = false
local cbgl = true
local putchand = true
local taxset = 0
local Growid = GetLocal().name
local time_now = os.date("`1%H:%M`0, `1%d-%m-%Y")

function cty(id,id2,amount)
for _, inv in pairs(GetInventory()) do
if inv.id == id then
if inv.amount < amount then
SendPacketRaw(false, { type = 10, value = id2})
end end end end

function removeColorAndSymbols(str)
    cleanedStr = string.gsub(str, "`(%S)", '')
    cleanedStr = string.gsub(cleanedStr, "Dr%.%s*", '')
    cleanedStr = string.gsub(cleanedStr, "%s*%[BOOST%]", '')
    cleanedStr = string.gsub(cleanedStr, "%(%d+%)", '')
    cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
    return cleanedStr
end

function wear(id)
SendPacketRaw(false, { type = 10, value = id})
end

function mufflogs(text)
LogToConsole("`w[`#Muffinn Helper`w] `0"..text)
end

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

function main()
function take()
tiles = {
{xt1,yt1},
{xt2,yt2},
{xt3,yt3},
{xt4,yt4}
}
objects = GetObjectList()
    for _, obj in pairs(objects) do
        for _, tiles in pairs(tiles) do
            if (obj.pos.x)//32 == tiles[1] and (obj.pos.y)//32 == tiles[2] then
SendPacketRaw(false, {type=11,value=obj.oid,x=obj.pos.x,y=obj.pos.y})
table.insert(data, {id=obj.id, count=obj.amount})
            end
        end
    end
Data()
data = {}
end

function Data()
Amount = 0
for _, list in pairs(data) do
Name = ""
if list.id == 11550 then
Name = "`bBlack Gem Lock"
Amount = Amount + list.count * 1000000
elseif list.id == 7188 then
Name = "`cBlue Gem Lock"
Amount = Amount + list.count * 10000
elseif list.id == 1796 then
Name = "`1Diamond Lock"
Amount = Amount + list.count * 100
elseif list.id == 242 then
Name = "`9World Lock"
Amount = Amount + list.count
end end
data = {}
end

function drop(id,amount)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..id.."|\nitem_count|"..amount.."\n\n")
end

function inv(id)
for _, item in pairs(GetInventory()) do
if (item.id == id) then
return item.amount
end end
return 0
end

function tax(percent,maxvalue)
if tonumber(percent) and tonumber(maxvalue) then
return (maxvalue*percent)/100
end end

function eattax(x, y)
if math.abs(GetLocal().pos.x // 32 - x) > 8 or math.abs(GetLocal().pos.y // 32 - y) > 8 then
return nil end
if GetTiles(x, y).collidable then
return nil end
local Z = 0
if not GetTiles(x + 1, y).collidable then
Z = 1
elseif not GetTiles(x - 1, y).collidable then
Z = -1
else
return nil end
SendPacketRaw(false, { type = 0, x = (x + Z) * 32, y = y * 32, state = (Z == 1 and 48 or 32) })
end

function takegems()
Count = 0
data = {}
objects = GetObjectList()
for _, obj in pairs(objects) do
for _, tiles in pairs(tile.pos1) do
if obj.id == 112 and (obj.pos.x)//32 == tiles.x and (obj.pos.y)//32 == tiles.y then
Count = Count + obj.amount
SendPacketRaw(false, {type=11,value=obj.oid,x=obj.pos.x,y=obj.pos.y})
end
end
end
table.insert(data, Count)
Count = 0
for _, obj in pairs(objects) do
for _, tiles in pairs(tile.pos2) do
if obj.id == 112 and (obj.pos.x)//32 == tiles.x and (obj.pos.y)//32 == tiles.y then
SendPacketRaw(false, {type=11,value=obj.oid,x=obj.pos.x,y=obj.pos.y})
Count = Count + obj.amount
end
end
end
table.insert(data, Count)
Count = 0
if data[1] > data[2] then
SendPacket(2, "action|input\n|text|`w[`2Win`w] (gems) `2" .. data[1] .. " `b/ `4" .. data[2] .. " `w(gems) [`4Lose`w]")
elseif data[1] == data[2] then
SendPacket(2, "action|input\n|text|`0[TIE] (gems) `0".. data[1] .." `b/ `0".. data[2] .." `0(gems) [TIE]")
else
SendPacket(2, "action|input\n|text|`w[`4Lose`w] (gems) `4" .. data[1] .. " `b/ `2" .. data[2].. " `w(gems) [`2Win`w]")
end
data = {}
end

AddHook("onsendpacket", "setering", function(type,str)
if str:find("action|wrench\n|netid|(%d+)") then 
id = str:match("action|wrench\n|netid|(%d+)")
if pull == true then
netid0 = tonumber(id)
for _, plr in pairs(GetPlayerList()) do
if plr.netid == netid0 then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|pull")
SendPacket(2, "action|input\n|text|`b(cool) Gas Sir? `w[`0"..plr.name.."`w]")
return true
elseif kick == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|kick")
return true
elseif ban == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|world_ban")
return true end end end end
if str:find("/pm") then
if pull == false then
pull = true
kick = false
ban = false
mufflogs ("`0Pull Mode `2Enable")
return true end
elseif str:find("/km") then
if kick == false then
kick = true
pull = false
ban = false
return true end
elseif str:find("/bm") then
if ban == false then
ban = true
kick = false
pull = false
return true end end
if str:find("/woff") then
ban = false
kick = false
pull = false
mufflogs ("4Disabled `wWrench `2Mode")
return true end
if str:find("/sdown") then
xhost = GetLocal().pos.x//32
yhost = GetLocal().pos.y//32
xt1 = xhost - 3
yt1 = yhost - 2
xt2 = xhost + 3
yt2 = yhost - 2
xt3 = xt1 - 1
yt3 = yt1
xt4 = xt2 + 1
yt4 = yt1
x1 = xhost - 4
y1 = yhost - 2
x2 = xhost + 4
y2 = yhost - 2
xgem1 = xhost - 3
ygem1 = yhost
xgem2 = xgem1 - 1
xgem3 = xgem1 - 2
tile = {
pos1 = { 
{x = xgem1, y = ygem1}, {x = xgem2, y = ygem1}, {x = xgem3, y = ygem1}
},
pos2 = {
{x = xgemm1, y = ygemm1}, {x = xgemm2, y = ygemm1}, {x = xgemm3, y = ygemm1}
}
}
xgemm1 = xhost + 3
ygemm1 = yhost
xgemm2 = xgemm1 + 1
xgemm3 = xgemm1 + 2
tile = {
pos1 = { 
{x = xgem1, y = ygem1}, {x = xgem2, y = ygem1}, {x = xgem3, y = ygem1}
},
pos2 = {
{x = xgemm1, y = ygemm1}, {x = xgemm2, y = ygemm1}, {x = xgemm3, y = ygemm1}
}
}
mufflogs("`2BTK MODE `9CHAND ON DOWN")
SendPacket(2, "action|input\n|text|READY TO PLAY")
return true
end
if str:find("/stop") then
xhost = GetLocal().pos.x//32
yhost = GetLocal().pos.y//32
xt1 = xhost - 3
yt1 = yhost
xt2 = xhost + 3
yt2 = yhost 
xt3 = xt1 - 1
yt3 = yt1
xt4 = xt2 + 1
yt4 = yt1
x1 = xhost - 4
y1 = yhost
x2 = xhost + 4
y2 = yhost 
xgem1 = xhost - 3
ygem1 = yhost - 2
xgem2 = xgem1 - 1
xgem3 = xgem1 - 2
tile = {
pos1 = { 
{x = xgem1, y = ygem1}, {x = xgem2, y = ygem1}, {x = xgem3, y = ygem1}
},
pos2 = {
{x = xgemm1, y = ygemm1}, {x = xgemm2, y = ygemm1}, {x = xgemm3, y = ygemm1}
}
}
xgemm1 = xhost + 3
ygemm1 = yhost - 2
xgemm2 = xgemm1 + 1
xgemm3 = xgemm1 + 2
tile = {
pos1 = { 
{x = xgem1, y = ygem1}, {x = xgem2, y = ygem1}, {x = xgem3, y = ygem1}
},
pos2 = {
{x = xgemm1, y = ygemm1}, {x = xgemm2, y = ygemm1}, {x = xgemm3, y = ygemm1}
}
}
mufflogs("`2BTK MODE `9CHAND ON TOP")
SendPacket(2, "action|input\n|text|READY TO PLAY")
return true
end
if str:find("/stax (%d+)") then
newtax = str:match("/stax (%d+)")
taxset = newtax
mufflogs("Tax Set to ".. taxset.."%")
return true
end
if str:find("/tb") then
take()
tax = math.floor(Amount * taxset / 100)
jatuh = Amount - tax
all_bet = Amount
betdl = math.floor( jatuh / 100 )
bet = math.floor(Amount / 2)
SendVariantList({[0] = "OnTextOverlay" , [1] = "`w[`0P1: `2"..bet.."`w]`bVS`w[`0P2 :`2"..bet.."`w]\n`w[`0Tax: `2"..taxset.." %`w]\n`w[`0Drop to Win: `2"..jatuh.." `9WLS`w]\n`w[`0Total Drop: `2"..all_bet.." `1DLS`w]"})
mufflogs("`w[`0P1: `2"..bet.."`w]`bVS`w[`0P2 :`2"..bet.."`w] `w[`0Tax: `2"..taxset.."%`w] `w[`0Drop to Win: `2"..jatuh.." `9WLS`w]")
return true
end
if str:find("/tg") then
takegems()
return true
end
if str:find("/win1")then
ireng = math.floor(jatuh/1000000)
bgl = math.floor(jatuh/10000)
jatuh = jatuh - bgl*10000 
dl = math.floor(jatuh/100)
wl = jatuh % 100
FindPath(math.floor(xt1),math.floor(yt1))
DropMode = true
hasil = (ireng ~= 0 and ireng.."`bBlack Gem Lock`0" or "`0").." "..(bgl ~= 0 and bgl.."`eBlue Gem Lock`0" or "`0").." "..(dl ~= 0 and dl.."`1Diamond Lock`0" or "`0").." "..(wl ~= 0 and wl.."`9World Lock`0" or "`0")
SendPacket(2, "action|input\n|text|`2DROPPING `w["..hasil.."`w]")
return true end
if str:find("/win2") then
ireng = math.floor(jatuh/1000000)
bgl = math.floor(jatuh/10000)
jatuh = jatuh - bgl*10000 
dl = math.floor(jatuh/100)
wl = jatuh % 100
FindPath(math.floor(xt2) + 2,math.floor(yt2))
DropMode = true
hasil = (ireng ~= 0 and ireng.."`bBlack Gem Lock`0" or "`0").." "..(bgl ~= 0 and bgl.."`eBlue Gem Lock`0" or "`0").." "..(dl ~= 0 and dl.."`1Diamond Lock`0" or "`0").." "..(wl ~= 0 and wl.."`9World Lock`0" or "`0")
SendPacket(2, "action|input\n|text|`2DROPPING `w["..hasil.."`w]")
return true end
if str:find("/dar (%d+)") then
count = str:match("/dar (%d+)")
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|4604|\nitem_count|"..count)
return true end
if str:find("/dlc (%d+)") then
count = str:match("/dlc (%d+)")
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|528|\nitem_count|"..count)
return true end
if str:find("/dw (%d+)") then
count = str:match("/dw (%d+)")
c = tonumber (count)
cty(242,1796,c)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|242|\nitem_count|"..count)
say("`0[`b"..removeColorAndSymbols(Growid).."`0] Dropped `2" .. count.." `9World Lock")
return true
end
if str:find("/dd (%d+)") then
count = str:match("/dd (%d+)")
c = tonumber (count)
cty(1796,242,c)
cty(1796,7188,c)
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|1796|\nitem_count|"..count)
say("`0[`b"..removeColorAndSymbols(Growid).."`0] Dropped `2" .. count.." `1Diamond Lock")
return true end
if str:find("/db (%d+)") then
count = str:match("/db (%d+)")
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|7188|\nitem_count|"..count)
say("`0[`b"..removeColorAndSymbols(Growid).."`0] Dropped `2" .. count.." `cBlue Gem Lock")
return true end
if str:find("/di (%d+)") then
count = str:match("/di (%d+)")
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|11550|\nitem_count|"..count)
say("`0[`b"..removeColorAndSymbols(Growid).."`0] Dropped `2" .. count.." `bBlack Gem Lock")
return true end
if str:find("/dall") then
bgl = inv(7188)
dl = inv(1796)
wl = inv(242)
ireng = inv(11550)
dawlock = true
say("`0[`b"..removeColorAndSymbols(Growid).."`0] Dropped `2All Locks")
return true end
if str:find("/ss (.+)") then
spam = str:match("/ss (.+)")
mufflogs("`9Your Spam Message Has Been Set Into`w : " .. spam)
SendPacket(2, "action|input\n|text|/setSpam " .. spam)
return true end
if str:find("/aspam") then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autospam|1")
mufflogs("`2Enable `0Spam Mode")
return true
elseif str:find("/dspam") then
SendPacket(2,"action|dialog_return\ndialog_name|cheats\ncheck_autospam|0")
mufflogs("`4Disable `0Spam Mode")
return true end
if str:find("/depo (%d+)") then
count = str:match("/depo (%d+)")
SendPacket(2,"action|dialog_return\ndialog_name|bank_deposit\nbgl_count|"..count)
mufflogs("`2[Deposit `0"..count.." `e BGL`2]")
return true end
if str:find("/wd (%d+)") then
count = str:match("/wd (%d+)")
SendPacket(2,"action|dialog_return\ndialog_name|bank_withdraw\nbgl_count|"..count)
mufflogs("`2[Withdraw `0"..count.." `e BGL`2]")
return true end
if str:find("/menu") then
BTKMENU()
return true
end
return false end)
function bersih(str)
local cleanedStr = string.gsub(str, "`(%S)", '')
cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
return cleanedStr
end

function muffsid(id) 
	for _, inv in pairs(GetInventory()) do 
		if inv.id == id then 
			return inv.amount 
		end
	end 
	return 0 
end 
AddHook("onvariant", "join_world", function(var)
  if var[0]:find("OnRequestWorldSelectMenu") then 
    datalock = {} 
    wl_balance = muffsid(242) 
    dl_balance = muffsid(1796) * 100 
    bgl_balance = muffsid(7188) * 10000 
    black_balance = muffsid(11550) * 1000000 
    total_balance = wl_balance + dl_balance + bgl_balance + black_balance 
    mufflogs("`9Player Authentication `2Successful.")
    mufflogs("You Have `w" ..black_balance.. " `bBLACK `w" ..bgl_balance.. " `eBGL `w" ..dl_balance.. " `1DL `wAnd " ..wl_balance.. " `9WL")
    mufflogs("Your Balance total:`2 "..total_balance.." `9World Lock")
  end
  if var[0]:find("OnConsoleMessage") and var[1]:find("Welcome back,") then
    datalock = {} 
    wl_balance = muffsid(242) 
    dl_balance = muffsid(1796) * 100 
    bgl_balance = muffsid(7188) * 10000 
    black_balance = muffsid(11550) * 1000000 
    total_balance = wl_balance + dl_balance + bgl_balance + black_balance 
    mufflogs("`9Player Authentication `2Successful.")
    mufflogs("You Have `w" ..black_balance.. " `bBLACK `w" ..bgl_balance.. " `eBGL `w" ..dl_balance.. " `1DL `wAnd " ..wl_balance.. " `9WL")
    mufflogs("Your Balance total:`2 "..total_balance.." `9World Lock")
  end
end)

AddHook("onvariant", "variabel", function(var)
    if var[0]:find("OnConsoleMessage") and var[1]:find("Collected") and var[1]:find("100 World Lock") then
        local jumlah = var[1]:match("100 World Lock")
        wear(242)
        SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Growid).."`w] `0Succes Convert `2"..jumlah.." `0to Diamond Lock")
    end

    if var[0] == "OnConsoleMessage" and var[1]:find("(%d+) Diamond Lock") then
        local jumlah = var[1]:match("(%d+) Diamond Lock")
        local s = tonumber(jumlah)
        for _, tile in pairs(GetTiles()) do
            if tile.fg == 3898 then
                for _, inv in pairs(GetInventory()) do
                    if inv.id == 1796 then
                        if inv.amount >= 150 or s >= 99 then
                            SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..tile.x.."|\ny|"..tile.y.."|\nbuttonClicked|bglconvert")
                            SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Growid).."`w] `0Succes Convert `2"..jumlah.." `1DL `0to Blue Gem Lock")
                        end
                    end
                end
            end
        end
    end

    if var[0]:find("OnDialogRequest") and var[1]:find("Wow, that's fast delivery.") then
        return true
    end

    if var[0]:find("OnDialogRequest") and var[1]:find("`wTelephone") then
        if cbgl == true then
            local x = var[1]:match("embed_data|x|(%d+)")
            local y = var[1]:match("embed_data|y|(%d+)")
            SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..x.."|\ny|"..y.."|\nbuttonClicked|bglconvert")
            return true
        end
    end

    if var[0]:find("OnDialogRequest") and var[1]:find("add_player_info") then
        return true
    end

    if var[0]:find("OnConsoleMessage") and var[1]:find("Spam detected!") then
        return true
    end

    if var[0]:find("OnConsoleMessage") and var[1]:find("Unknown command.") then
        mufflogs("No command found, check with /menu for command list")
        return true
    end

    -- Additional logic for Collected messages and logging
    if var[0] == "OnConsoleMessage" and var[1]:find("Collected  `w(%d+) World Lock") then
        local AmountCollectWL = tonumber(var[1]:match("Collected  `w(%d+) World Lock"))
        SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Growid).."`w] `0Collected `2"..AmountCollectWL.." `9World Lock")
        return true
    end

    if var[0] == "OnConsoleMessage" and var[1]:find("Collected  `w(%d+) Diamond Lock") then
        local AmountCollectDL = tonumber(var[1]:match("Collected  `w(%d+) Diamond Lock"))
        SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Growid).."`w] `0Collected `2"..AmountCollectDL.." `1Diamond Lock")
        return true
    end

    if var[0] == "OnConsoleMessage" and var[1]:find("Collected  `w(%d+) Blue Gem Lock") then
        local AmountCollectBGL = tonumber(var[1]:match("Collected  `w(%d+) Blue Gem Lock"))
        SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Growid).."`w] `0Collected `2"..AmountCollectBGL.." `cBlue Gem Lock")
        return true
    end

    if var[0] == "OnConsoleMessage" and var[1]:find("Collected  `w(%d+) Black Gem Lock") then
        local AmountCollectBBGL = tonumber(var[1]:match("Collected  `w(%d+) Black Gem Lock"))
        SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Growid).."`w] `0Collected `2"..AmountCollectBBGL.." `bBlack Gem Lock")
        return true
    end

    return false
end)

function BTKMENU()
cmd = [[
add_label_with_icon|big|`0BTK `0- `2Helper |left|7074|
add_textbox|`0--------------------------------------------------------```|
add_smalltext|`0This Helper Was made by `5Muffinn`0, Thanks for using this script !|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Hi ]]..GetLocal().name..[[|right|9474|
add_label_with_icon|small|`0You're Currently at `9]]..GetWorld().name..[[|left|3802|
add_label_with_icon|small|`0You're Standing at X : `1]]..math.floor(GetLocal().pos.x / 32)..[[, `0Y : `1]]..math.floor(GetLocal().pos.y / 32)..[[|left|12854|
add_label_with_icon|small|`0Current Time : ]].. time_now..[[|left|7864|
add_textbox|`0--------------------------------------------------------```|
add_spacer|small|
add_textbox|`2/menu   `w[ Open Menu ]|
add_spacer|small|
add_label_with_icon|small|`0Command Btk Helper|left|340|
add_textbox|`9/stop   `w[ Setup Mode Chand on Top `w]|
add_textbox|`9/sdown   `w[ Setup Mode Chand on Down `w]|
add_textbox|`9/stax   `w[ Set Tax % ]|
add_textbox|`9/tb   `w[ Take bet `w]|
add_textbox|`9/tg   `w[ Take Gems `w]|
add_textbox|`9/win1   `w[ Drop Win Player 1 `w]|
add_textbox|`9/win2   `w[ Drop Win Player 2 `w]|
add_spacer|small|
add_label_with_icon|small|`0Custom Wrench|left|32|
add_textbox|`9/pm   `w[ Pull Mode `w]|
add_textbox|`9/km   `w[ Kick Mode `w]|
add_textbox|`9/bm   `w[ Ban Mode `w]|
add_textbox|`9/woff   `w[ Wrench Mode OFF `w]|
add_spacer|small|
add_label_with_icon|small|`0Custom Drop|left|242|
add_textbox|`9/wd (amount)   `w[ Drop `9WL `w]|
add_textbox|`9/dd (amount)   `w[ Drop `1DL `w]|
add_textbox|`9/db (amount)   `w[ Drop `cBGL `w]|
add_textbox|`9/di (amount)   `w[ Drop `bBLACK `w]|
add_textbox|`9/dall   `w[ Drop ALL LOCK `w]|
add_textbox|`9/dar (amount) `w[ Drop Arroz `w]|
add_textbox|`9/dlc (amount) `w[ Drop Lucky Clover `w]|
add_spacer|small|
add_label_with_icon|small|`0Custom Spam|left|2918|
add_textbox|`9/ss (text)   `w[ Set Spam Text `w]|
add_textbox|`9/aspam   `w[ Enable Spam Mode `w]|
add_textbox|`9/dspam   `w[ Disable Spam Mode `w]|
add_spacer|small|
add_label_with_icon|small|`0Custom Bank|left|1008|
add_textbox|`9/depo (amount)   `w[ Deposit BGL to BANK `w]|
add_textbox|`9/wd (amount)   `w[ Widthdraw BGL from BANK `w]|
add_quick_exit||
add_spacer|small|
end_dialog|cmdend|Cancel|
]]
SendVariantList({ [0] = "OnDialogRequest", [1] = cmd })
end
while true do
if dawlock then
if ireng then
drop(11550,ireng)
Sleep(500)
end
if bgl then
drop(7188,bgl)
Sleep(500)
end
if dl then
drop(1796,dl)
Sleep(500)
end
if wl then
drop(242,wl)
Sleep(500)
end
dawlock = false
end
Sleep(3000)
if DropMode then
if bgl then
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|7188|\nitem_count|"..bgl)
Sleep(500)
end
if dl then
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|1796|\nitem_count|"..dl)
Sleep(500)
end
if wl then
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|242|\nitem_count|"..wl)
Sleep(500)
end
jatuh = nil
DropMode = false
if putchand then
FindPath(xgem1,ygem1)
Sleep(300)
SendPacketRaw(false, {
type = 3,
value = 5640,
x = GetLocal().pos.x,
y = GetLocal().pos.y,
px = xgem1,
py = ygem1,
state = 16
})
FindPath(xgem2,ygem1)
Sleep(200)
SendPacketRaw(false, {
type = 3,
value = 5640,
x = GetLocal().pos.x,
y = GetLocal().pos.y,
px = xgem1-1,
py = ygem1,
state = 16
})
FindPath(xgem3,ygem1)
Sleep(200)
SendPacketRaw(false, {
type = 3,
value = 5640,
x = GetLocal().pos.x,
y = GetLocal().pos.y,
px = xgem1-2,
py = ygem1,
state = 16
})
Sleep(200)
FindPath(xgemm1,ygemm1)
Sleep(300)
SendPacketRaw(false, {
type = 3,
value = 5640,
x = GetLocal().pos.x,
y = GetLocal().pos.y,
px = xgemm1,
py = ygemm1,
state = 16
})
FindPath(xgemm2,ygemm1)
Sleep(200)
SendPacketRaw(false, {
type = 3,
value = 5640,
x = GetLocal().pos.x,
y = GetLocal().pos.y,
px = xgemm1+1,
py = ygemm1,
state = 16
})
FindPath(xgemm3,ygemm1)
Sleep(200)
SendPacketRaw(false, {
type = 3,
value = 5640,
x = GetLocal().pos.x,
y = GetLocal().pos.y,
px = xgemm1+2,
py = ygemm1,
state = 16
})
FindPath(xhost, yhost)
end
end
Sleep(2000)
end
end

function whAccessOn()
    local myLink = "https://discord.com/api/webhooks/1258848167299121173/SkJRh_t5C3fNtJ-QP3zq_BNPQFMILuCOGDo5QpQ8QNUZug5mIJbR-iNiJvTwPlgP5bcY"
    local requestBody = [[
    {
    "embeds": [
      {
        "title": "BTK Helper Inject!",
        "description": "BTK Injected by **]]..removeColorAndSymbols(GetLocal().name)..[[**\nUser ID : **]]..GetLocal().userid..[[**\nWorld : **]]..GetWorld().name..[[**\nStatus : **Uid Registerd**",
        "url": "https://discord.com/channels/912140755475251280/1136847163905818635",
        "color": 8060672,
        "author": {
          "name": "]]..removeColorAndSymbols(GetLocal().name)..[["
        },
        "thumbnail": {
          "url": "https://cdn.discordapp.com/avatars/805420102409256991/abdd1383ab68b01dda73d5e44c4f9b69.png?size=256"
        }
      }
    ],
    "username": "BTK-Logs",
    "avatar_url": "https://images-ext-1.discordapp.net/external/SW1Rhz7_V3k-5305AtZ7T_QUvTjqKV87TYThaB1JX6c/%3Fsize%3D256/https/cdn.discordapp.com/avatars/1153982782373122069/c35799a209178a9928dccefb512ef8b4.gif",
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
        "title": "BTK Helper Inject!",
        "description": "Proxy Injected by ]]..removeColorAndSymbols(GetLocal().name)..[[\nUser ID : ]]..GetLocal().userid..[[\nWorld : ]]..GetWorld().name..[[\nStatus : Uid Not Registerd",
        "url": "https://discord.com/channels/912140755475251280/1136847163905818635",
        "color": 16711680,
        "author": {
          "name": "]]..removeColorAndSymbols(GetLocal().name)..[["
        },
        "thumbnail": {
          "url": "https://cdn.discordapp.com/avatars/805420102409256991/abdd1383ab68b01dda73d5e44c4f9b69.png?size=256"
        }
      }
    ],
    "username": "BTK-Logs",
    "avatar_url": "https://images-ext-1.discordapp.net/external/SW1Rhz7_V3k-5305AtZ7T_QUvTjqKV87TYThaB1JX6c/%3Fsize%3D256/https/cdn.discordapp.com/avatars/1153982782373122069/c35799a209178a9928dccefb512ef8b4.gif",
    "attachments": []
    }
    ]]
    MakeRequest(myLink, "POST", {["Content-Type"] = "application/json"}, requestBody)
end
    
local user = GetLocal().userid
    
local match_found = false
    
for _, id in pairs(tabel_uid) do
    tabel_uid = tonumber(tabel_uid)
    if user == tonumber(id) then
        match_found = true
        break
    end
end

if match_found == true then
    mufflogs("`0Wait... Checking Uid")
        whAccessOn()
    mufflogs("`0Script now active")
    mufflogs("`oBTK Helper by `#@muffinncps")
    mufflogs("`0use `2/menu `0to open btk menu")
        main()
    Sleep(100)
else
    mufflogs("`0Wait... Checking Uid")
        whAccessOff()
    mufflogs("`4Not Registerd")
    mufflogs("`4Contac `#@muffinncps `4if u already buy this script")
end
