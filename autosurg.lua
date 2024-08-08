tabel_uid = { 
  "134611", "220889", 
  "772647", "788943",
  "786629"
}

function FChat(txt)
  p = {}
  p[0] = "OnTextOverlay"
  p[1] = txt
  SendVariantList(p)
end

function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

function main()
AddHook("onvariant", "surg", function(var)
if var[0]:find("OnDialogRequest") and var[1]:find("Status: `4Awake(.+)")then
    if findItem(1262) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_2
]])
        LogToConsole("`1[MC]`2Using AnesThetic")
    else
        FChat("`2you don't have enough AnesThetic")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|surge_edit")then
SendPacket(2,[[
action|dialog_return
dialog_name|surge_edit
x|]]..var[1]:match("embed_data|x|(%d+)")..[[|
y|]]..var[1]:match("embed_data|y|(%d+)")..[[|
]])
LogToConsole("`1[MC]`4Auto Surgery Start")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|popup")then
SendPacket(2,[[
action|dialog_return
dialog_name|popup
netID|]]..var[1]:match("embed_data|netID|(%d+)")..[[|
buttonClicked|surgery
]])
LogToConsole("`1[MC]`4Auto Surgery Start")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("`4You can't see what you are doing!(.+)")then
if findItem(1258) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_0
]])
LogToConsole("`1[MC]`2Using Sponge")
    else
        FChat("`2you don't have enough Sponge")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `3slowly rising.")then
if findItem(1266) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_4
]])
LogToConsole("`1[MC]`2Using Antibiotics")
    else
        FChat("`2you don't have enough Antibiotics")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `6climbing.")then
if findItem(1266) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_4
]])
LogToConsole("`1[MC]`2Using Antibiotics")
    else
        FChat("`2you don't have enough Antibiotics")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `4climbing rapidly!.")then
if findItem(1266) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_4
]])
LogToConsole("`1[MC]`2Using Antibiotics")
    else
        FChat("`2you don't have enough Antibiotics")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `3Not sanitized")then
if findItem(1264) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_3
]])
LogToConsole("`1[MC]`2Using Antiseptic")
    else
        FChat("`2you don't have enough Antiseptic")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `6Unclean")then
if findItem(1264) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_3
]])
LogToConsole("`1[MC]`2Using Antiseptic")
    else
        FChat("`2you don't have enough Antiseptic")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `4Unsanitary")then
if findItem(1264) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_3
]])
LogToConsole("`1[MC]`2Using Antiseptic")
    else
        FChat("`2you don't have enough Antiseptic")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("`6It is becoming hard to see your work.")then
if findItem(1258) > 1 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_0
]])
LogToConsole("`1[MC]`2Using Sponge")
    else
        FChat("`2you don't have enough Sponge")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `4very quickly!")then
if findItem(1270) > 1 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_6
]])
LogToConsole("`1[MC]`9Using Stitches")
    else
        FChat("`2you don't have enough Stitches")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is `6losing blood!")then
if findItem(1270) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_6
]])
LogToConsole("`1[MC]`9Using Stitches")
    else
        FChat("`2you don't have enough Stitches")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `3slowly")then
if findItem(1270) > 1 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_6
]])
LogToConsole("`1[MC]`9Using Stitches")
    else
        FChat("`2you don't have enough Stitches")
    end
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `30(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`1[MC]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `31(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`1[MC]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `32(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`1[MC]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `33(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`1[MC]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `44(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`1[MC]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `45(.+)")  then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_7
]])
LogToConsole("`1[MC]`2Using Fix It!")
return true
elseif var[0]:find("OnDialogRequest") and var[1]:find("1260") then
if findItem(1262) > 0 then
SendPacket(2,[[
action|dialog_return
dialog_name|surgery
buttonClicked|command_1
]])
LogToConsole("`1[MC]`6Scalple")
    else
        FChat("`2you don't have enough Scalple")
    end
return true
end
return false
end)
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

DetachConsole()
if match_found then
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    FChat("`0[`^MUFFINN`0-`^STORE`0] `^UID TERDAFTAR")
    Sleep(1000)
    FChat("`2SC AUTO SURG BY `^MUFFINN STORE")
    Sleep(1000)

while true do
main()
end

else
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^CHECKING UID")
    Sleep(3000)
    FChat("`4UID Not Found")
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `4UID TIDAK TERDAFTAR KONTAK DISCORD MUFFINN_S")
end
