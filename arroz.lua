--[MUFFINN STORE]--
tabel_uid = {
    134611, 44216, 
    101394, 775453,
    788943, 146424,
    377187, 781415,
    779220, 795045
}

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

function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

function IsReady(tile)
if tile and tile.extra and tile.extra.progress and tile.extra.progress == 1.0 then
return true
end
return false
end

function SChat(txt)
  s = {}
  s[0] = "OnTalkBubble"
  s[1] = GetLocal().netid
  s[2] = txt
  SendVariantList(s)
end

function taketomato()
    for _, obj in pairs(GetObjectList()) do
        if obj.id == 962 then
            local x = math.floor(obj.pos.x / 32)
            local y = math.floor(obj.pos.y / 32)
            FindPath(x, y, 100)
            return true  -- Return true jika tomat ditemukan
        end
    end
    return false -- Return false jika tomat tidak ditemukan
end

function tomatotake()
    local tomatoID = 962 -- ID item untuk tomat
    local tomatoCount = 0 -- Variabel untuk menghitung jumlah tomat

    for _, v in pairs(GetInventory()) do
        if v.id == tomatoID then
            tomatoCount = tomatoCount + v.amount
        end
    end

    if tomatoCount >= 80 then
        SChat("`^NO NEED TO TAKE TOMATO")
        Sleep(2000)
        return true -- Kembalikan true jika jumlah tomat lebih besar atau sama dengan 80
    else
        return false -- Kembalikan false jika jumlah tomat kurang dari 80
    end
end

AddHook("onvariant", "hook", function(var)
if var[0] == "OnDialogRequest" and var[1]:find("end_dialog|item_finder") then
return true
end
return false
end)

AddHook("onvariant", "mommy", function(var)
    if var[0] == "OnSDBroadcast" then
        return true
    end
end)

function rice()
            FindPath(x,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+1,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+2,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+3,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+4,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+5,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+6,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+7,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+8,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+9,y,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)

            FindPath(x+9,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+8,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+7,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+6,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+5,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+4,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+3,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+2,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+1,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x,y+1,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)

            FindPath(x,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+1,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+2,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+3,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+4,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+5,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+6,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+7,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+8,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
            FindPath(x+9,y+2,50)
            Sleep(200)
            SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" .. math.floor(GetLocal().pos.x / 32) .. "|\ny|" .. math.floor(GetLocal().pos.y /32) .. "|\ncookthis|3472|\nbuttonClicked|low")
            Sleep(100)
end

function additional1()
            FindPath(x,y,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+1,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+2,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+3,y,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+4,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+5,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+6,y,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+7,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+8,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+9,y,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)

            FindPath(x+9,y+1,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+8,y+1,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+7,y+1,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+6,y+1,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+5,y+1,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+4,y+1,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+3,y+1,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+2,y+1,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+1,y+1,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x,y+1,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(8200)
end

function onionchicken()
            FindPath(x,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+1,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+2,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+3,y,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+4,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+5,y,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+6,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+7,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+8,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+9,y,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)

            FindPath(x+9,y+1,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+8,y+1,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+7,y+1,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+6,y+1,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+5,y+1,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+4,y+1,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+3,y+1,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+2,y+1,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+1,y+1,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x,y+1,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)

            FindPath(x,y+2,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+1,y+2,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+2,y+2,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+3,y+2,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+4,y+2,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+5,y+2,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+6,y+2,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0)
            Sleep(100)
            FindPath(x+7,y+2,50)
            Sleep(200)
            place(4602,0,0) 
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+8,y+2,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(100)
            FindPath(x+9,y+2,50)
            Sleep(200)
            place(4602,0,0)
            Sleep(200)
            place(4588,0,0) 
            Sleep(19500)
end

function tomato()
            FindPath(x,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+1,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+2,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+3,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+4,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+5,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+6,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+7,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+8,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+9,y,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)

            FindPath(x+9,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+8,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+7,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+6,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+5,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+4,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+3,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+2,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+1,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x,y+1,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)

            FindPath(x,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+1,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+2,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+3,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+4,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+5,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+6,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+7,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+8,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
            FindPath(x+9,y+2,50)
            Sleep(200)
            place(962,0,0) 
            Sleep(100)
end

function additional2()
            FindPath(x,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+1,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+2,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+3,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+4,y+2,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+5,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+6,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+7,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0)
            Sleep(100)
            FindPath(x+8,y+2,50)
            Sleep(200)
            place(4568,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(200)
            place(4570,0,0) 
            Sleep(100)
            FindPath(x+9,y+2,50)
            Sleep(200)
            place(4568,0,0)
            Sleep(200)
            place(4570,0,0)
            Sleep(200)
            place(4570,0,0) 
            Sleep(12000)

end

function Take()
            FindPath(x,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+1,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+2,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+3,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+4,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+5,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+6,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+7,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+8,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+9,y,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)

            FindPath(x+9,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+8,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+7,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+6,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+5,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+4,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+3,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+2,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x+1,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)
            FindPath(x,y+1,50)
            Sleep(200)
            punch(0,0)
            Sleep(200)

            FindPath(x,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+1,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+2,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+3,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+4,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+5,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+6,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+7,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+8,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
            FindPath(x+9,y+2,50)
            Sleep(250)
            punch(0,0)
            Sleep(250)
end

--splice onion
function plantfoliage()
    while findItem(4602) < 40 do
        while findItem(1778) < 25 do
            SendPacket(2,"action|buy\nitem|buy_deluxegspray")
            Sleep(100)
        end
        while findItem(455) < 1 do
            SendPacket(2, "action|dialog_return\ndialog_name|item_search\n454|0\n455|1")
            Sleep(1000)
        end
        while findItem(1105) < 1 do
            SendPacket(2,"action|dialog_return\ndialog_name|item_search\n1104|0\n1105|1\n7226|0\n7227|0\n7448|0\n7449|0\n8932|0\n8933|0")
            Sleep(1000)
        end
        for x= 60,60 do
            FindPath(x,24)
            Sleep(100)
            while GetTile(x,24).fg == 0 and findItem(1105) > 0 do
                place(1105,0,0)
                Sleep(50)
            end
            while GetTile(x,24).fg == 1105 and findItem(455) > 0 do
                place(455,0,0)
                Sleep(50)
            end
            while GetTile(x,24).fg == 4603 and not IsReady(GetTile(x,24)) do
            place(1778,0,0)
            Sleep(10)
            end
            while GetTile(x,24).fg == 4603 and IsReady(GetTile(x,24)) do
                punch(0, 0)
                Sleep(100)
                collect(0,0,0)
            end
        end
    end
end

-- chicken --
xAyam = 0
yAyam = 0
itemId = 872
chickenID = 4588

local collectX, collectY -- Variabel untuk menyimpan koordinat tile collect

function findCutting()
    for _, tile in pairs(GetTiles()) do
        if tile.fg == 3470 then
            FindPath(tile.x - 1, tile.y, 50) -- Menyesuaikan dengan koordinat yang diberikan
            collectX = tile.x -- Mendapatkan koordinat x untuk tile collect
            collectY = tile.y -- Mendapatkan koordinat y untuk tile collect
            return true
        end
    end
    return false
end

function punch(x, y) 
    local pkt = {} 
    pkt.px = math.floor(GetLocal().pos.x / 32 + x)
    pkt.py = math.floor(GetLocal().pos.y / 32 + y)
    pkt.type = 3 
    pkt.value = 18 
    pkt.x = GetLocal().pos.x 
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

function collect(x, y)
    FindPath(x, y, 60) -- Menggunakan koordinat yang diberikan
end

function punchCuttingBoard(x, y)
    punch(1, 0)
    Sleep(1000)
    collect(collectX, collectY) -- Memperoleh koordinat untuk collect
end

-- Fungsi untuk menjatuhkan chicken ke tile cutting board
function dropChicken(x, y)
    for i = 1, 1 do
        SendPacket(2, "action|dialog_return\ndialog_name|item_search\n"..itemId.."|1")
        Sleep(1000)
        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..itemId.."|\nitem_count|250")
        Sleep(200)
    end
    punchCuttingBoard(x, y) -- Lakukan punch ke tile cutting board setelah menjatuhkan chicken
end

function chicken()
    local chickenCount = 0
    for _, v in pairs(GetInventory()) do
        if v.id == chickenID then
            chickenCount = chickenCount + v.amount
        end
    end

    if chickenCount < 50 then
        if findCutting() then
            SChat("`^GRIND CHICKEN MEAT")
            dropChicken(xAyam - 1, yAyam) -- Jatuhkan chicken ke tile cutting board
            Sleep(1000)
            collect(x, y)
        else
            print("Tile cutting board tidak ditemukan!") -- Handle jika tile cutting board tidak ditemukan
        end
    else
        Sleep(1200)
        SChat("`^NO NEED GRIND MEAT") -- Handle jika jumlah chicken kurang dari 50
    end
end


-- rice --
function findRice()
    local rice = 3472 -- ID item untuk penggilingan
    local riceCount = 0

    for _, v in pairs(GetInventory()) do
        if v.id == rice then
            riceCount = riceCount + v.amount
        end
    end

    if riceCount >= 50 then
        SChat("`^NO NEED FIND RICE")
        return true
    else
        SChat("`^FIND RICE")
        Sleep(2000)
        SendPacket(2, "action|dialog_return\ndialog_name|item_search\n"..rice.."|1")
        return false
    end
end

-- grinder --
-- Deklarasi biji pepper dan biji salt
local pepper = 4584
local salt = 4566
local bijipepper = 4570
local bijisalt = 4568

-- Fungsi untuk menggiling biji pepper atau biji salt
function grindItem(x, y, pepper)
    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n"..pepper.."|1")
    Sleep(100)
    SendPacket(2, "action|dialog_return\ndialog_name|grinder\nx|"..x.."|\ny|"..y.."|\nitemID|"..pepper.."|\namount|2")
    Sleep(200)
end

function grindItem(x, y, salt)
    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n"..salt.."|1")
    Sleep(100)
    SendPacket(2, "action|dialog_return\ndialog_name|grinder\nx|"..x.."|\ny|"..y.."|\nitemID|"..salt.."|\namount|2")
    Sleep(200)
end

-- Fungsi untuk menjalankan proses penggilingan
function runGrind()
    -- Melakukan pencarian grinder
    local grinderFound = false
    local grinderTile = nil
    for _, tile in pairs(GetTiles()) do
        if tile.fg == 4582 then
            grinderTile = tile
            grinderFound = true
            break
        end
    end

    if grinderFound then
        -- Dapatkan koordinat tile grinder
        local xGrind = grinderTile.x
        local yGrind = grinderTile.y

        -- Bergerak ke posisi grinder
        FindPath(xGrind, yGrind, 50) -- 50 adalah kecepatan berjalan karakter
        -- Menunggu karakter sampai mencapai posisi grinder
        Sleep(1000)

        local pepperCount = 0
        local saltCount = 0

        -- Lakukan penggilingan hingga jumlah biji mencapai 80
        while pepperCount < 80 or saltCount < 80 do
            -- Periksa jumlah biji pepper
            pepperCount = 0
            for _, v in pairs(GetInventory()) do
                if v.id == bijipepper then
                    pepperCount = pepperCount + v.amount
                end
            end

            -- Lakukan penggilingan biji pepper jika belum mencapai 80
            if pepperCount < 80 then
                grindItem(xGrind, yGrind, pepper)
                Sleep(500)  -- Tambahkan jeda setelah penggilingan
            end

            -- Periksa jumlah biji salt
            saltCount = 0
            for _, v in pairs(GetInventory()) do
                if v.id == bijisalt then
                    saltCount = saltCount + v.amount
                end
            end

            -- Lakukan penggilingan biji salt jika belum mencapai 80
            if saltCount < 80 then
                grindItem(xGrind, yGrind, salt)
                Sleep(500)  -- Tambahkan jeda setelah penggilingan
            end
        end
    end
end

--onion--
function plantfoliage()
    while findItem(4602) < 40 do
        while findItem(1778) < 5 do
            SendPacket(2,"action|buy\nitem|buy_deluxegspray")
            Sleep(100)
        end
        while findItem(455) < 1 do
            SendPacket(2, "action|dialog_return\ndialog_name|item_search\n454|0\n455|1")
            Sleep(1000)
        end
        while findItem(1105) < 1 do
            SendPacket(2,"action|dialog_return\ndialog_name|item_search\n1104|0\n1105|1\n7226|0\n7227|0\n7448|0\n7449|0\n8932|0\n8933|0")
            Sleep(1000)
        end
        for xOnion = x + 12,x + 12 do
            FindPath(xOnion,y + 2)
            Sleep(100)
            while GetTile(xOnion,y + 2).fg == 0 and findItem(1105) > 0 do
                place(1105,0,0)
                Sleep(50)
            end
            while GetTile(xOnion,y + 2).fg == 1105 and findItem(455) > 0 do
                place(455,0,0)
                Sleep(50)
            end
            while GetTile(xOnion,y + 2).fg == 4603 and not IsReady(GetTile(xOnion,y + 2)) do
            place(1778,0,0)
            Sleep(10)
            end
            while GetTile(xOnion,y + 2).fg == 4603 and IsReady(GetTile(xOnion,y + 2)) do
                punch(0, 0)
                Sleep(100)
                collectOnion(0,0,0)
            end
        end
    end
end

function collectOnion(x,y,delay)
    for _, obj in pairs(GetObjectList()) do
        if math.floor(obj.pos.x / 32) == math.floor(GetLocal().pos.x / 32) + x and math.floor(obj.pos.y / 32) == math.floor(GetLocal().pos.y / 32) + y then
            SendPacketRaw(false, {type=11,value=obj.oid,x=obj.pos.x,y=obj.pos.y})
            Sleep(delay)
        end
    end
end

-- drop arroz --
function dropArroz()
    local arroz = 4604 -- ID item untuk penggilingan
    local arrozCount = 0
    local dropX = drop_x_arroz -- Ambil nilai x dari tabel dropArroz dan konversi ke angka
    local dropY = drop_y_arroz -- Ambil nilai y dari tabel dropArroz dan konversi ke angka

    for _, v in pairs(GetInventory()) do
        if v.id == arroz then
            arrozCount = arrozCount + v.amount
        end
    end

if arrozCount >= 249 then
    for _, tile in pairs(GetTiles()) do
        if tile.x == dropX and tile.y == dropY then
            FindPath(tile.x - 1, tile.y, 60)
            SChat("`^DROPING ARROZ")
            Sleep(1000)
            SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..arroz.."|\nitem_count|250")
            return true
        end
    end
    return false
else
      SChat("`^ARROZ IS UNDER 250")
      Sleep(1000)
      SChat("`^CONTINUE COOKING")
      Sleep(2000)
      return true
   end
end

-- Fungsi untuk memeriksa apakah ID pengguna terdaftar
local function is_registered_id(id)
    for _, registered_id in ipairs(tabel_uid) do
        if id == registered_id then
            return true
        end
    end
    return false
end

-- Mendapatkan ID pengguna lokal
local user_id = GetLocal().userid

function crd()
SendPacket(2, "action|input\ntext|`^ AUTO COOK ARROZ PREMIUM `0[`^MUFFINN`0-`^STORE`0]")
Sleep(2000)
end

-- Memeriksa apakah ID pengguna terdaftar
if is_registered_id(user_id) then
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `2WAIT.. `^CHECKING UID")
    Sleep(3000)
    SChat("`2UID FOUND!")
    Sleep(2000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^STARTING SC COOK ARROZ PREMIUM")
    Sleep(1000)
crd()

while true do
            if GetWorld().name ~= string.upper(world_cook) then
                SendPacket(2, "action|input\ntext|`2WORLD COOK INVALID")
                Sleep(2000)
                RequestJoinWorld(world_cook) 
                SendPacket(2, "action|input\ntext|`2RECONNECT TO WORLD COOK!")
                Sleep(5000)
            end
dropArroz()
Sleep(2000)
findRice()
Sleep(2000)

--take tomat--
if not tomatotake() then
        SChat("`^TAKE TOMATO")
        Sleep(2000)
       taketomato()
end

SChat("`^SPLICE ONION")
plantfoliage()
Sleep(2000)
chicken()
Sleep(2000)
SChat("`^GRIND SALT & PEPPER")
runGrind()
Sleep(2000)
SChat("`^START COOKING")
Sleep(3000)
rice()
Sleep(100)
additional1()
Sleep(100)
onionchicken()
Sleep(100)
tomato()
Sleep(100)
additional2()
Sleep(100)
Take()
Sleep(1000)
SChat("`2You Now Have "..findItem(4604).." Arron On Backpack!")
Sleep(1000)
end

else
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `^IDENTIFY PLAYER : " .. GetLocal().name)
    Sleep(1000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `2WAIT.. `^CHECKING UID")
    Sleep(3000)
    SChat("`4UID NOT FOUND!")
    Sleep(2000)
    LogToConsole("`0[`^MUFFINN`0-`^STORE`0] `4UID TIDAK TERDAFTAR KONTAK DISCORD MUFFINN_S")
end
