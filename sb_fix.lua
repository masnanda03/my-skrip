-- [ SB PROXY - MUFFINN STORE ] --
tabel_uid = {"852522", "134611", "120824",
    "475429", "753490", 
    "774228", "506287", "305824",
    "343274", "156249", "420724",
    "774603", "553469", "788943", 
    "588529", "239848", "120729", "195478", "911", "836498", "134486", "539803", "572990"}

-- [[ DONT TOUCH HERE ]] --
counting = 0 -- Don't Touch
hours = 0 -- Don't Touch
sb = 0 -- Don't Touch
Sponsor = false -- Don't Touch
Running = false -- Don't Touch
Paused = false -- Don't Touch
local text = "" -- Don't Touch
local pause_time -- Don't Touch
local elapsed_time = 0 -- Don't Touch
local initial_time -- Don't Touch   
local prefixs = {
    "`1", "`2", "`3", "`4", "`5", "`9", "`c", "`o", "`b", "`8", "`e", "`^", "`0"
} -- Don't Touch

posX = GetLocal().pos.x // 32
posY = GetLocal().pos.y // 32

function log(str)
    LogToConsole("`0[`#Muffinn Sb`0]`o " .. str)
end

function Texting(teks)
    SendPacket(2, "action|input\n|text|"..teks)
end

function overlayText(text)
    var = {}
    var[0] = "OnTextOverlay"
    var[1] = "`0[`#Muffinn Sb`0]`o ".. text
    SendVariantList(var)
end

function removeColor(text)
    return text:gsub("`.", "")
end

function format_number(n)
    local str = tostring(n)
    local formatted = str:reverse():gsub("(%d%d%d)", "%1,")
    return formatted:reverse():gsub("^,", "")
end

function State(x, y)
    SendPacketRaw(false, {
        type = 0,
        x = x * 32 or GetLocal().pos.x,
        y = y * 32 or GetLocal().pos.y,
        state = 0,
        xspeed = 300
    })
end

local count = 0
local total_gems = 0
local gems_used = 0
local last_gems_used = 0
local sb_sent = false
local sb_pending = false
start_time_str = ""
end_time_str = ""

AddHook("onvariant", "hook", function(var)
    if var[0] == "OnConsoleMessage" then
        if var[1]:find("sent.") then
            local gems_used_str = var[1]:match("(%d+) Gems")
            last_gems_used = tonumber(gems_used_str) or 0
            gems_used = last_gems_used
            total_gems = total_gems + last_gems_used
            sb_sent = true
            sb_pending = false
        elseif var[1]:find("pending one.") then
            sb_sent = true
            sb_pending = true
            last_gems_used = 0
            gems_used = 0
        end
    end
end)

function formatGems(gems)
    if gems >= 1000000 then
        return string.format("%.1fM", gems/1000000)
    elseif gems >= 1000 then
        return string.format("%.0fK", gems/1000)
    else
        return tostring(gems)
    end
end

function formatTime(timestamp)
    return os.date("%H:%M", timestamp)
end

function initializeTime()
    local current_time = os.time()
    start_time_str = formatTime(current_time)
    
    if hours > 0 then
        -- 1 hour = 40 sb, so we calculate total minutes needed
        local total_minutes = (hours * 40 * 1.5) -- 1.5 minutes per sb
        local end_time = current_time + (total_minutes * 60) -- Convert minutes to seconds
        end_time_str = formatTime(end_time)
    elseif counting > 0 then
        -- Each sb takes 1.5 minutes
        local total_minutes = counting * 1.5
        local end_time = current_time + (total_minutes * 60) -- Convert minutes to seconds
        end_time_str = formatTime(end_time)
    end
end

function displayStatus()
    -- Display status time
    if hours > 0 or counting > 0 then
        Texting("`wSuperbroadcast Proxy by `#@Muffinn(megaphone) `0[`2Start Time`0: `b" .. start_time_str .. " `0] [`4End Time`0: `b" .. end_time_str .. " `0]")
    end
    Sleep(1000)
    
    -- Display status count
    local appearance_time = count * 1.5
    local total_time_sb = (hours > 0) and (hours * 60) or (counting * 1.5)
    local appearance_count = count
    local total_count = (hours > 0) and (hours * 40) or counting
    
    if hours > 0 then
        Texting("(megaphone)`^Superbroadcast `2Appears `0[`2" .. string.format("%.2f", appearance_time) .. " `0Min] `bof `0[`4" .. string.format("%.2f", total_time_sb).." `0Min]")
    elseif counting > 0 then
        Texting("(megaphone)`^Superbroadcast `2Appears `0[`2" .. appearance_count .. "`w] `bof `0[`4" .. total_count .."`w]")
    end
    Sleep(1000)
    
    -- Display status total gems used
    Texting("`9Total Gems Used: `2" .. format_number(total_gems) .. " (gems)")
    Sleep(1300)

    -- Display status webhook
    if WH_USE then
        local myData = GenerateEmbedData("Superbroadcast sent")
        if myData then
            local webhookSuccess = SendWebhook(URL, myData)
            if webhookSuccess then
                Texting("(megaphone)`^Superbroadcast`0[`2Successfully `0sent webhook. (cool)]")
            else
                Texting("(megaphone)`^Superbroadcast `0[`2Failed `0sent webhook. (cry)]")
            end
        end
        Sleep(1000)
    end
end

AddHook("onvariant", "Kaede", function(var)
    if var[0] == "OnConsoleMessage" then
    if var[1]:find("Spam detected!") then
        return true
    end
    elseif var[0]:find("OnSDBroadcast") then
        overlayText("`0[`eBroadcast`0] Succes Blocked `4SDB!")
        return true
    end
end)

function cleanSignText(str)
    local cleanedStr = str
    cleanedStr = string.gsub(cleanedStr, "Dr%.%s*", '')
    cleanedStr = string.gsub(cleanedStr, "%s*%[BOOST%]", '')
    cleanedStr = string.gsub(cleanedStr, "%(%d+%)", '')
    return cleanedStr
end

AddHook("onvariant", "sign_edit_hook", function(var)
    if var[0] == "OnDialogRequest" and var[1]:find("sign_edit") then
        local displayText = var[1]:match("display_text||(.-)|128|")
        if displayText then
            text = cleanSignText(displayText)
            log("`0[`eBroadcast`0] Text Set: " ..displayText)
        end
        return true
    end
    return false
end)

AddHook("onsendpacket", "packet", function(type, pkt)
    if pkt:find("/startsb") then
        if Paused then
            Running = true
            Paused = false
            initial_time = os.time() - elapsed_time
            log("`0[`eBroadcast`0] Superbroadcast `2Resumed")
        else
            Running = true
            log("`0[`eBroadcast`0] Superbroadcast `2Starting")
            initial_time = os.time()
            updateTime()
            local end_time_seconds = initial_time + (hours > 0 and hours * 3600 or counting * 90)
            end_time = os.date("%H:%M", end_time_seconds)
        end
        return true
    elseif pkt:find("/pausesb") then
        if Running then
            Running = false
            Paused = true
            pause_time = os.time()
            elapsed_time = pause_time - initial_time
            Texting("`0[`eBroadcast`0] Superbroadcast has been `9Paused")
        else
            Texting("`0[`eBroadcast`0] Superbroadcast is not running")
        end
        return true
    elseif pkt:find("/stopsb") then
        Running = false
        Paused = false
        hours = 0
        counting = 0
        count = 0
        elapsed_time = 0
        total_gems = 0
        text = ""
        start_time_str = ""
        end_time_str = ""
        Texting("`0[`eBroadcast`0] Superbroadcast has been `4Stopped and Reset")
        return true
    elseif pkt:find("/t (.+)") then
        text = pkt:match("/t (.+)")
        log("`0[`eBroadcast`0] Text Set: " ..text)
        return true
    end
    return false
end)

function updateTime()
    local current_time = os.time()
    start_time_str = os.date("%H:%M", current_time)
    
    if hours > 0 then
        local total_minutes = (hours * 40 * 1.5)
        local end_time = current_time + (total_minutes * 60)
        end_time_str = os.date("%H:%M", end_time)
    elseif counting > 0 then
        local total_minutes = counting * 1.5
        local end_time = current_time + (total_minutes * 60)
        end_time_str = os.date("%H:%M", end_time)
    end
end

AddHook("OnSendPacket", "P", function(type, str)
    if str:find("/set") then
        if str:match("/set") then
            ShowSbDialog()
            return true
        end
    end
    local newDelay = str:match("SetCount|(%d+)")
    if newDelay and tonumber(newDelay) and tonumber(newDelay) ~= hours then
        hours = tonumber(newDelay)
        counting = 0
        sb = hours * 40
        updateTime()
        log("`0[`eBroadcast`0] SB Set to:`2 " ..hours.. " `0hours")
    end
    local newcount = str:match("SetCounting|(%d+)")
    if newcount and tonumber(newcount) and tonumber(newcount) ~= counting then
        counting = tonumber(newcount)
        hours = 0
        sb = counting
        updateTime()
        log("`0[`eBroadcast`0] SB Set to:`2 " ..counting.. "`wx")
    end
    local newText = str:match("SetSbText|(.-)|")
    if newText and newText ~= text then
        text = newText
        log("`0[`eBroadcast`0] Text Set: " ..text)
    end
end)

function ShowSbDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`0Menu `9SuperBroadcast|left|2480|
add_spacer|small|
add_label_with_icon|small|`0Use /startsb to start sb `2(when u done setting)|left|482|
add_label_with_icon|small|`0Use /stopb to stop your sb |left|482|
add_label_with_icon|small|`0Use /pausesb to pause your sb |left|482|
add_smalltext|`wSet only 1 if u want count set the count hours still 0|
add_spacer|small|
add_text_input|SetCounting|`#Count Set :|]]..counting..[[|5|
add_smalltext|`9Note `0: set to count u want, if put 40 means 1 hours sb|
add_spacer|small|
add_text_input|SetCount|`#Hours Set :|]]..hours..[[|5|
add_smalltext|`9Note `0: set to hours u want, if put 1 means 1 hours sb|
add_spacer|small|
add_textbox|`#Super Broadcast `0Text :|
add_smalltext|`0(use /t [text] (Max 120 letters) or you can wrench sign to copy automaticly)|
add_label_with_icon|small|]]..text..[[|left|482|
add_spacer|small|
add_quick_exit||
end_dialog|iprogram|Close|Update|
]]
    SendVariantList(varlist_command)
end

function GenerateEmbedData(status)
    if not WH_USE then return end
    local currentTime = os.date("%H:%M:%S")
    local appearance_time = count * 1.5
    local total_time_sb
    local target_count = counting > 0 and counting or (hours * 40)
    
    if hours > 0 then
        total_time_sb = hours * 60
    else
        total_time_sb = counting * 1.5
    end
    gems = GetPlayerInfo().gems

    -- Calculate elapsed time since start with seconds precision
    local elapsed_seconds = 0
    if initial_time then
        local current = os.time()
        if Paused then
            elapsed_seconds = elapsed_time
        else
            elapsed_seconds = current - initial_time
        end
    end

    -- Format elapsed time into days, hours, minutes, and seconds
    local elapsed_days = math.floor(elapsed_seconds / (24 * 60 * 60))
    local remaining_seconds_after_days = elapsed_seconds % (24 * 60 * 60)
    local elapsed_hours = math.floor(remaining_seconds_after_days / (60 * 60))
    local remaining_seconds_after_hours = remaining_seconds_after_days % (60 * 60)
    local elapsed_minutes = math.floor(remaining_seconds_after_hours / 60)
    local remaining_seconds = remaining_seconds_after_hours % 60
    
    local elapsed_time_str = string.format("%02d:%02d:%02d", elapsed_hours, elapsed_minutes, remaining_seconds)

    local statusValue
    if status == "Superbroadcast sent" then
        if hours > 0 then
            statusValue = string.format("%s - %.2f min / %.2f min", status, appearance_time, total_time_sb)
        else
            statusValue = string.format("%s - %d / %d", status, count, target_count)
        end
    elseif status == "Superbroadcast finished" then
        statusValue = status
    else
        if hours > 0 then
            statusValue = string.format("%.2f min / %.2f min", appearance_time, total_time_sb)
        else
            statusValue = string.format("%d / %d", count, target_count)
        end
    end

    return [[
        {
            "username": "MUFFINN COMMUNITY",
            "avatar_url": "https://cdn.discordapp.com/avatars/1091651204494409839/36835dfa7cbb30a3c1bd7766f07db186.png?size=1024",
            "embeds": [
                {
                    "title": "<a:pruplecrown:1282058758633291932> PROXY SB PREMIUM <a:pruplecrown:1282058758633291932>",
                    "color": 8069327,
                    "fields": [
                        {"name": "<:player:1203057110208876656> NICKNAME", "value": "]]..removeColor(GetLocal().name)..[[", "inline": true},
                        {"name": "<a:world:1203650176447946812> WORLD", "value": "]]..GetWorld().name..[[", "inline": true},
                        {"name": "<:gt_gems:1226474791205343322> CURRENT GEMS", "value": "]]..format_number(gems)..[[", "inline":true},
                        {"name": "<:gt_gems:1226474791205343322> GEMS USED", "value": "]]..format_number(last_gems_used)..[["},
                        {"name": "<:gt_gems:1226474791205343322> TOTAL GEMS USED", "value": "]]..format_number(total_gems)..[["},
                        {"name": "<a:announce:1282060210269061221> STATUS", "value": "]]..statusValue..[["},
                        {"name": "<:timegt:1303589727592779818> CURRENT TIME", "value": "]]..currentTime..[["},
                        {"name": "<:timegt:1303589727592779818> ELAPSED TIME", "value": "]]..elapsed_time_str..[["}
                    ],
                    "footer": {"text": "auto sb by muffinn community"},
                    "thumbnail": {"url": "https://images-ext-1.discordapp.net/external/FME3u6PuTVVZ4f0Q-Ait1RF_4VokmiaBwdzE1pk5qDo/%3Fsize%3D1024/https/cdn.discordapp.com/avatars/1091651204494409839/36835dfa7cbb30a3c1bd7766f07db186.png?format=webp&quality=lossless"}
                }
            ]
        }
    ]]
end
    
function SendWebhook(url, data)
    local success = pcall(MakeRequest, url, "POST", {["Content-Type"] = "application/json"}, data)
    return success
end
    
function openning()
    local time_now = os.date("`1%H:%M`0, `1%d-%m-%Y")
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`0CreativePS.eu `0- `2Helper |left|7074|
add_textbox|`0--------------------------------------------------------```|
add_smalltext|`0This Helper Was made by `5Muffinn`0, Thanks for using this script !|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Hi ]]..GetLocal().name..[[|right|9474|
add_label_with_icon|small|`0You're Currently at `9]]..GetWorld().name..[[|left|3802|
add_label_with_icon|small|`0You're Standing at X : `1]]..math.floor(GetLocal().pos.x / 32)..[[, `0Y : `1]]..math.floor(GetLocal().pos.y / 32)..[[|left|12854|
add_label_with_icon|small|`0Current Time : ]]..time_now..[[|left|7864|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Fiture Proxy :|left|11304|
add_label_with_icon|small|`0wrench to sign for automatic copy text|left|482|
add_label_with_icon|small|`0/set `9Open setting sb menu|left|482|
add_label_with_icon|small|`0/t (your text) `9Manually setting text sb|left|482|
add_label_with_icon|small|`0/startsb `9Start your sb `2(When done setting)|left|482|
add_label_with_icon|small|`0/stopsb `9Stop your sb and reset all setting|left|482|
add_label_with_icon|small|`0/pausesb `9Pause your current sb running|left|482|
add_spacer|small|
add_quick_exit||
end_dialog|openning|Close||
]]
    SendVariantList(varlist_command)
end
    
names = GetLocal().name:match("%S+")
local st = string.upper(GetWorld().name)
    
if not os or not MakeRequest then
    log("`^Please turn on os, makerequest before run this script.")
    return
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
    
if match_found == true then
    log("`^IDENTIFIED PLAYER " .. GetLocal().name)
    Sleep(1000)
    log("`^UID TERDAFTAR")
    Sleep(1000)
    Texting("(megaphone)`wProxy Sb by `#@Muffinn")
    Sleep(1000)
    openning()
    
    initializeTime()
        
    while true do
        if Running then
            if GetWorld() == nil or GetWorld().name ~= st then
                SendPacket(3, "action|join_request\nname|"..st.."|\ninvitedWorld|0")
                Sleep(1000)
                State(posX, posY)
                Sleep(1020)
            end
                
            local randomPrefix = prefixs[math.random(1, #prefixs)]
            if Sponsor then
                Texting("/nick " .. names .. randomPrefix .. "[" .. st .. "]")
                Sleep(960)
            end
                
            -- Send Superbroadcast
            SendPacket(2, "action|input\ntext|/sb "..text.." `#@Muffinn-sb")
            Sleep(2000)
                
            if sb_sent then
                count = count + 1
                
                -- Send Status Display
                displayStatus()
                    
                -- Calculate target count based on mode
                local target_count = (hours > 0) and (hours * 40) or counting
                    
                -- Check completion
                   if count >= target_count then
                    -- Send final webhook with finished status
                    if WH_USE then
                        local finishedData = GenerateEmbedData("Superbroadcast finished")
                        if finishedData then
                            SendWebhook(URL, finishedData)
                        end
                    end
                        
                    -- Display completion message
                    Texting("(megaphone)`^Superbroadcast `4Ended, `0Thanks for using my jasa. (cool)")
                    Sleep(3000)
                        
                    if DONE then
                        SendPacket(2, "action|input\n|text|/warp " .. WORLD_DONE)
                        Sleep(2000)
                        log("`wWarped to `2" .. WORLD_DONE .. ". `4Ending script.")
                    else
                            overlayText("(megaphone)`wSuperbroadcast finished. Staying in current world.")
                    end
                        
                    Running = false
                    Paused = false
                    hours = 0
                    counting = 0
                    count = 0
                    elapsed_time = 0
                    total_gems = 0
                    text = ""
                    start_time_str = ""
                    end_time_str = ""
                    break
                end
                    
                sb_sent = false
            end
                
            Sleep(90000)
        elseif Paused then
            Sleep(2000)
        else
            Sleep(2000)
        end
    end
else
    log("`^IDENTIFIED PLAYER : " .. GetLocal().name)
    Sleep(1000)
    log("`^WAIT CHECK UID")
    Sleep(1000)
    log("`4UID TIDAK TERDAFTAR KONTAK DISCORD @muffinncps")
end
