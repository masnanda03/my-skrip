-- [ R/Q HELPER - MUFFINN COMMUNITY ] --
tabel_uid = {"134611", "475429", "788943", "37962", "100231",
	"202", "774603", "1032", "588529", "836450", "597946", 
	"734484", "606623", "548750", "836498", "833921", "764408", 
	"101900", "653976", "775610", "852522", "853110", "18601", "546675", "776278", "855464"}

update_info = "Update : 12 Oct 2024"
local wl = 242
local dl = 1796
local bgl = 7188
local bbgl = 11550
local Name = GetLocal().name
local collectedSent = false
local kick = false
local ban = false
local pull = false
local found = false
local reme = 0
local qeme = 0
local normal = 0
local gemscount = false
local showuid = false
local time_now = os.date("`1%H:%M`0, `1%d-%m-%Y")
local data = {}
local datalock = {} 
local cbgl = false 
local activeBlinkskin = false
local reds = 120
local greens = 110
local bluess = 100
local transp = 0

local skin_colors = {
  1348237567,
  1685231359,
  2022356223,
  2190853119,
  2527912447,
  2864971775,
  3033464831,
  3370516479,
  2749215231,
  3317842431,
  726390783,
  713703935,
  3578898943,
  4042322175,
  3531226367,
  4023103999,
  194314239,
  1345519520
}

local options = {
  check_antibounce = false,
  check_modfly = false,
  check_speed = false,
  check_gravity = false,
  check_aimbot = false,
  check_lonely = false,
  check_ignoreo = false,
  check_gems = false,
  check_ignoref = false,
  check_autospam = false,
  check_emoji = false
}

function inv(id)
for _, item in pairs(GetInventory()) do
if (item.id == id) then
return item.amount
end end
return 0
end

function cty(id,id2,amount)
for _, inv in pairs(GetInventory()) do
if inv.id == id then
if inv.amount < amount then
SendPacketRaw(false, { type = 10, value = id2})
end end end end

function drops(id, amount)
   SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|" .. id .. "|\nitem_count|" .. amount .. "\n\n")
end

function qq_function(number)
  str_number = tostring(number)
  last_digit = str_number:sub(-1)
  result = tonumber(last_digit)
  return result
end

function remove_color_codes(str)
  pattern = "`."
  result = string.gsub(str, pattern, "")
  return result
end

function reme_function(number)
  str_number = tostring(number)
  sum = 0
  
  for i = 1, #str_number do
      sum = sum + tonumber(str_number:sub(i, i))
  end
  
  str_sum = tostring(sum)
  last_digit = str_sum:sub(-1)
  result = tonumber(last_digit)
  
  return result
end

function scanObject(id)
  count = 0
  for _, object in pairs(GetObjectList()) do
      if object.id == id then
          count = count + object.amount
      end
  end
  return count
end

function removeColorAndSymbols(str)
  cleanedStr = string.gsub(str, "`(%S)", '')
  cleanedStr = string.gsub(cleanedStr, "Dr%.%s*", '')
  cleanedStr = string.gsub(cleanedStr, "%s*%[BOOST%]", '')
  cleanedStr = string.gsub(cleanedStr, "%(%d+%)", '')
  cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
  return cleanedStr
end

function wear(id)
  pkt = {}
  pkt.type = 10
  pkt.value = id
  SendPacketRaw(false, pkt)
end

function findItem(id)
  for _, itm in pairs(GetInventory()) do
    if itm.id == id then
      return itm.amount
      end
  end
return 0
end

function log(str)
  LogToConsole("`0[`#Muffinn Helper`0]`o "..str)
end

function say(txt)
SendPacket(2,"action|input\ntext|"..txt)
end

function mufflogs(text)
  LogToConsole("`w[`#Muffinn Helper`w] `0"..text)
end

function FChat(txt)
  p = {}
  p[0] = "OnTextOverlay"
  p[1] = txt
  SendVariantList(p)
end

function overlayText(text)
  var = {}
  var[0] = "OnTextOverlay"
  var[1] = "`0[`#Muffinn Helper`0]`o ".. text
  SendVariantList(var)
end

function OnTextOverlay(str)
  local o = {}
  o[0] = "OnTextOverlay"
  o[1] = str
  return o
end

function CHECKBOX(B)
  return B and "1" or "0"
end

function TimeNow()
   current = time_now
  return true
end

-- [C] Bothax Menu
if _G.ModflyStatus == nil then
  _G.ModflyStatus = false
end
if _G.AntibounceStatus == nil then
  _G.AntibounceStatus = false
end

function main()
local function ShowMainDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
text_scaling_string|commandOne
add_label_with_icon|big|`0CreativePS.eu `0- `2Helper |left|7074|
add_textbox|`0--------------------------------------------------------```|
add_smalltext|`0This Helper Was made by `5Muffinn`0, Thanks for using this script !|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Hi ]]..GetLocal().name..[[|right|9474|
add_label_with_icon|small|`0You're Currently at `9]]..GetWorld().name..[[|left|3802|
add_label_with_icon|small|`0You're Standing at X : `1]]..math.floor(GetLocal().pos.x / 32)..[[, `0Y : `1]]..math.floor(GetLocal().pos.y / 32)..[[|left|12854|
add_label_with_icon|small|`0Current Time : ]].. time_now..[[|left|7864|
add_textbox|`0--------------------------------------------------------```|
add_label_with_icon|small|`0Fiture Proxy :|left|11304|
add_spacer|small|
add_button_with_icon|social_portal|`0Social Portal|staticBlueFrame|1366||
add_button_with_icon|profile_menu|`0Your Profile|staticBlueFrame|12436||
add_button_with_icon|command_list|`0Command List|staticBlueFrame|1752||
add_button_with_icon|command_abilities|`0Abilities Menu|staticBlueFrame|14404||
add_button_with_icon|wrenchmenu|`0Wrench Menu|staticBlueFrame|32||
add_button_with_icon|spam_menu|`0Spam Menu|staticBlueFrame|15286||
add_custom_break|
end_list|
add_button_with_icon|skin_menu|`0Skin menu|staticBlueFrame|13000||
add_button_with_icon|cctv_menu|`0Cctv Logs|staticBlueFrame|1436||
add_button_with_icon|command_proxyinfo|`0Founder|staticBlueFrame|1628||
add_button_with_icon|update_info|`0Support|staticBlueFrame|656||
add_custom_break|
add_quick_exit||
end_dialog|commandOne|Close||
]]
  SendVariantList(varlist_command)
end

local function ShowListDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`0Command List|left|3524|
add_custom_break|
add_textbox|`0------------------------------------------------------|
add_label_with_icon|small|`0Custom Drop|left|242|
add_label_with_icon|small|`8/dw <amount> `0: drop `9World Lock|left|482|
add_label_with_icon|small|`8/dd <amount> `0: drop `cDiamond Lock|left|482|
add_label_with_icon|small|`8/db <amount> `0: drop `1Blue Gem Lock|left|482|
add_label_with_icon|small|`8/di <amount> `0: drop `bBlack Gem Lock|left|482|
add_label_with_icon|small|`8/wall `0: drop all `9World Lock|left|482|
add_label_with_icon|small|`8/dall `0: drop all `cDiamond Lock|left|482|
add_label_with_icon|small|`8/ball `0: drop all `1Blue Gem Lock|left|482|
add_label_with_icon|small|`8/bball `0: drop all `bBlack Gem Lock|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Convert|left|3898|
add_label_with_icon|small|`8/blu `0: convert black to bgl|left|482|
add_label_with_icon|small|`8/bla `0: convert bgl to black|left|482|
add_label_with_icon|small|`8/cbgl`0: fast convert bgl (wrench Telephone)|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Bank|left|1008|
add_label_with_icon|small|`8/dp <amount> `0: deposit your bgl to bank|left|482|
add_label_with_icon|small|`8/wd <amount> `0: withdraw your bgl from bank|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Menu|left|2918|
add_label_with_icon|small|`8/warp <world name> `0 : warp to other world|left|482|
add_label_with_icon|small|`8/rc `0: reconnect|left|482|
add_label_with_icon|small|`8/re `0: rejoin world|left|482|
add_label_with_icon|small|`8/res `0: fast respawn|left|482|
add_label_with_icon|small|`8/g `0: fast ghost|left|482|
add_label_with_icon|small|`8/b `0: back to world before|left|482|
add_label_with_icon|small|`8/gs `0: show growscan|left|482|
add_spacer|small|
add_label_with_icon|small|`0Command Reme/Qeme|left|758|
add_label_with_icon|small|`8/reme `0: turn on reme number|left|482|
add_label_with_icon|small|`8/qeme `0: turn on qeme number|left|482|
add_label_with_icon|small|`8/normal `0: turn back normal roullete mode|left|482|
add_textbox|`0------------------------------------------------------|
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

local function ShowAbilitiesDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
text_scaling_string|commandList
add_label_with_icon|big|`0Abilities Menu````|left|1662|
add_smalltext|------------------------------------------------------|
add_textbox|`0Auto : |left|
add_checkbox|check_autospam|`0Auto Spam Mode|]] .. CHECKBOX(options.check_autospam) .. [[|
add_checkbox|check_gems|`0Auto Take Gems Mode|]] .. CHECKBOX(options.check_gems) .. [[|
add_textbox|`0Abilities : |left|
add_checkbox|check_speed|`0Speed Mode|]] .. CHECKBOX(options.check_speed) .. [[|
add_checkbox|check_gravity|`0Gravity Mode|]] .. CHECKBOX(options.check_gravity) .. [[|
add_checkbox|check_aimbot|`0Aim Bot Mode|]] .. CHECKBOX(options.check_aimbot) .. [[|
add_textbox|`0Less Lag Improve Fps : |left|
add_checkbox|check_lonely|`0Lonely Mode|]] .. CHECKBOX(options.check_lonely) .. [[|
add_checkbox|check_ignoreo|`0Ignore Others Drop Mode|]] .. CHECKBOX(options.check_ignoreo) .. [[|
add_checkbox|check_ignoref|`0Ignore Others Completely Mode|]] .. CHECKBOX(options.check_ignoref) .. [[|
add_custom_break|
add_spacer|small|
add_button|command_back|`9Back|noflags|0|0|
end_dialog|cheats||Apply Cheats!|
]]
  SendVariantList(varlist_command)
end

local function ShowProxyDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`0Founder|left|9222|
add_custom_break|
add_textbox|`0------------------------------------------------------|
add_smalltext|`0Owner This Script|left|
add_spacer|small|
add_label_with_icon|small|`5@muffinncps|left|5956|
add_textbox|`0------------------------------------------------------|
add_smalltext|`wHelper IDEA|left
add_spacer|small|
add_label_with_icon|small|`!Who want?|left|13220
add_textbox|`0------------------------------------------------------|
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

local function ShowWrenchDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`7Wrench Menu!|left|32|
add_spacer|small||
add_smalltext|`7Only Work For 1 Menu!|
text_scaling_string|jakhelperbdjsjn|
add_button_with_icon|pullmode|`7Pull Mode|staticYellowFrame|274|
add_button_with_icon|kickmode|`7Kick Mode|staticYellowFrame|276||
add_button_with_icon|banmode|`7Ban Mode|staticYellowFrame|278||
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
end_dialog|wm|Close||
]]
  SendVariantList(varlist_command)
end

local function ShowSkinDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`7Skin Menu!|left|1420|
add_spacer|small||
text_scaling_string|jakhelperbdjsjn|
add_button_with_icon|blinkskin|`2B`5l`8i`bn`1k `wSkin|staticBlueFrame|2590||
add_button_with_icon|redskin|`4Red Skin|staticBlueFrame|558||
add_button_with_icon|blackskin|`bBlack Skin|staticBlueFrame|1158||
add_button_with_icon|customskin|`wCustom Skin|staticBlueFrame|13000||
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
end_dialog|SKIN_MENU|Close||
]]
  SendVariantList(varlist_command)
end

local function ShowCustomSkinDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`7Custom Skin Menu!|left|13000|
add_spacer|small||
text_scaling_string|jakhelperbdjsjn|
add_text_input|red|`4Red     :|]]..reds..[[|5|
add_text_input|green|`2Green :|]]..greens..[[|5|
add_text_input|blue|`1Blue    :|]]..bluess..[[|5|
add_text_input|transparency|`wTransparency (Max 50) :|]]..transp..[[|5|
add_spacer|small||
add_quick_exit||
add_button|command_back|                 `wBack                 |noflags|0|0|
end_dialog|skinpicker|     Close     |     `wSave     |
]]
  SendVariantList(varlist_command)
end

AddHook("OnSendPacket", "cskin", function(cskin, str)
local reds = str:match("redskinset|(%d+)")
if reds and tonumber(reds) and tonumber(reds) ~= merah then
  merah = tonumber(reds)
end
local greens = str:match("greenskinset|(%d+)")
if greens and tonumber(greens) and tonumber(greens) ~= hijau then
  hijau = tonumber(greens)
end
local bluess = str:match("blueskinset|(%d+)")
if bluess and tonumber(bluess) and tonumber(bluess) ~= biru then
  biru = tonumber(bluess)
end
local transp = str:match("trasnparentskinset|(%d+)")
if transp and tonumber(transp) and tonumber(transp) ~= kasat then
  kasat = tonumber(transp)
end
if str:find("buttonClicked|`wSave") then
  if str:match("buttonClicked|`wSave") then
    SendPacket(2, "action|dialog_return\ndialog_name|skinpicker\nred|"..merah.."\ngreen|"..hijau.."\nblue|"..biru.."\ntransparency|"..kasat)
    overlayText("`wCustom Skin Set")
    return true
  end
end
end)

local function ShowOthersDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`7Others Abilities Menu!|left|32|
add_spacer|small||
text_scaling_string|jakhelperbdjsjn|
add_button_with_icon|active_modfly|`0Modfly|staticBlueFrame|162||
add_button_with_icon|active_antibounce|`0Antibounce|staticBlueFrame|526||
add_button_with_icon|spam_menu|`0Spam menu|staticBlueFrame|15286||
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
end_dialog|wm|Close||
]]
  SendVariantList(varlist_command)
end

local function ShowChangeDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|`wCreative Ps Helper |left|]] .. 7074 ..[[|
add_smalltext|`0Discord : `b@muffinncps|
add_label_with_icon|small|`wHello Thanks For Buying This Script ]]..GetLocal().name..[[|left|6020|
add_spacer|small||
add_label_with_icon|big|`0Change Logs|left|6128|
add_spacer|small|
add_smalltext|`4[/-/] `0]]..update_info..[[|
add_url_button|Muffinn|`eJoin Discord Server|noflags|https://dsc.gg/muffinncommunity|would you like to join Muffinn Community?|0|0|
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

local AutoSpam, SpamText, SpamDelay = false, "Setting your spam text here", 5000
local emoji = {
  "(wl)","(gtoken)","(gems)","(oops)","(cry)","(lol)","(sigh)","(mad)","(smile)","(tongue)", 
  "(wow)","(no)","(shy)","(wink)","(music)","(yes)","(love)","(heart)","(cool)","(kiss)",
  "(agree)","(see-no-evil)","(dance)","(sleep)","(punch)","(bheart)","(party)","(gems)","(plead)",
  "(peace)","(terror)","(troll)","(halo)","(nuke)","(evil)","(clap)","(grin)","(eyes)","(weary)","(moyai)"
}

function getRandomElement(tbl)
    return tbl[math.random(#tbl)]
end

local function ShowSpamDialog()
    local varlist_command = {}
    varlist_command[0] = "OnDialogRequest"
    varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|Setting Auto Spam|left|15286|
add_spacer|small|
add_checkbox|EnableSpam|Enabled Auto Spam (`9/aspam`w)|]]..CHECKBOX(options.check_autospam) ..[[|
add_checkbox|EnableEmoji|Enable emoji|]]..CHECKBOX(options.check_emoji) ..[[|
add_spacer|small|
add_textbox|Setting Your Spamming Text :|
add_smalltext|Maximum 120 letters|
add_text_input|SetSpamText||]]..SpamText..[[|120|
add_spacer|small|
add_quick_exit|
end_dialog|SettingSpam|Close|Update|
]]
    SendVariantList(varlist_command)
end

local function SendSpamText(text)
  SendPacket(2, "action|input\ntext|" .. text)
end

local function spamstart()
  while AutoSpam do
      local textToSend = SpamText
      if options.check_emoji then
          textToSend = getRandomElement(emoji) .. " " .. textToSend
      end
      SendSpamText(textToSend)
      Sleep(SpamDelay)
  end
end

AddHook("OnSendPacket", "SettingSpam", function(type, str)
  if str:find("EnableSpam|1") and not options.check_autospam then
      options.check_autospam = true
      AutoSpam = true
      RunThread(spamstart)
      mufflogs("Auto Spam `2Enabled")
  elseif str:find("EnableSpam|0") and options.check_autospam then
      options.check_autospam = false
      AutoSpam = false
      mufflogs("Auto Spam `4Disabled")
  end
  
  if str:find("EnableEmoji|1") and not options.check_emoji then
      options.check_emoji = true
      mufflogs("Emoji `2Enabled")
  elseif str:find("EnableEmoji|0") and options.check_emoji then
      options.check_emoji = false
      mufflogs("Emoji `4Disabled")
  end

  local newText = str:match("SetSpamText|(.-)[\n|]")
  if newText and newText ~= SpamText then
      SpamText = newText
  end

  local newDelay = str:match("SetSpamDelay|(%d+)")
  if newDelay and tonumber(newDelay) and tonumber(newDelay) ~= SpamDelay then
      SpamDelay = tonumber(newDelay)
  end
end)

local function applyCheats()
  local packet = "action|dialog_return\ndialog_name|cheats\n"

  for k, v in pairs(options) do
      if v then
          packet = packet .. k .. "|1\n"
      else
          packet = packet .. k .. "|0\n"
      end
  end

  SendPacket(2, packet)
end

local function ShowCctvDialog()
  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|Cctv Menu|left|1436|
add_spacer|small||
text_scaling_string|jakhelperbdjsjn|
add_button_with_icon|collect_menu|`0Collected Logs|staticBlueFrame|13808|
add_button_with_icon|dropped_menu|`0Dropped Logs|staticBlueFrame|13810|
add_button_with_icon|donation_menu|`0Donation Logs|staticBlueFrame|1452|
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

LogsCollect = LogsCollect or {}
Action = Action or {}
local function ActivityLogPage()
  Action = {}
  for _, log in pairs(LogsCollect) do 
      table.insert(Action, log.act) 
  end

  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|Logs Collected Locks|left|13808|
add_spacer|small|
]] .. table.concat(Action) .. [[
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|back_cctv_menu|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

LogsDropped = LogsDropped or {}
Actiondrop = Actiondrop or {}
local function ActivityLogDrop()
  Actiondrop = {}
  for _, log in pairs(LogsDropped) do 
      table.insert(Actiondrop, log.actt) 
  end

  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|Logs Dropped Locks|left|13810|
add_spacer|small|
]] .. table.concat(Actiondrop) .. [[
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|back_cctv_menu|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

LogsDonate = LogsDonate or {}
Actiondonate = Actiondonate or {}
local function ActivityLogDonate()
  Actiondonate = {}
  for _, log in pairs(LogsDonate) do 
      table.insert(Actiondonate, log.actd) 
  end

  local varlist_command = {}
  varlist_command[0] = "OnDialogRequest"
  varlist_command[1] = [[
set_default_color|`o
add_label_with_icon|big|Logs Donation Box|left|1452|
add_spacer|small|
]] .. table.concat(Actiondonate) .. [[
add_button_with_icon||END_LIST|noflags|0||
add_quick_exit||
add_button|back_cctv_menu|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
end

AddHook("OnSendPacket", "P", function(type, str)
  if str == "action|input\n|text|/menu" then
    RemoveHook("onvariant", "Main Hook")
    ShowMainDialog()
    return true
  end

  if str:find("action|friends\ndelay|(%d+)") then
      id = str:match("action|friends\ndelay|(%d+)")
   if id then
      ShowMainDialog()  -- Memanggil fungsi ShowMainDialog()
      return true  -- Mengembalikan nilai true, sesuai dengan kebutuhan Anda
     end
  end

if str:find("action|input\n|text|/tb") then
take()
tax = math.floor(Amount * taxset / 100)
jatuh = Amount - tax
all_bet = Amount
betdl = math.floor( jatuh / 100 )
bet = math.floor(Amount / 2)
SendVariantList({[0] = "OnTextOverlay" , [1] = "`w[`0P1: `2"..bet.."`w]`bVS`w[`0P2 :`2"..bet.."`w]\n`w[`0Tax: `2"..taxset.." %`w]\n`w[`0Drop to Win: `2"..jatuh.." `9WLS`w]\n`w[`0Total Drop: `2"..all_bet.." `1DLS`w]"})
say("`w[`0P1: `2"..bet.."`w]`bVS`w[`0P2 :`2"..bet.."`w] `w[`0Tax: `2"..taxset.."%`w] `w[`0Drop to Win: `2"..jatuh.." `9WLS`w]")
return true
end

  if str:find("/stax (%d+)") then
      taxset = str:match("/stax (%d+)")
      log("Tax Set To : `3"..taxset.." %")
      return true
  end

  if str:find("/daw") then
    str:match("`6/daw")
    bgl = inv(7188)
    dl = inv(1796)
    wl = inv(242)
    ireng = inv(11550)
    dawlock = true
    log("`2Drop All Lock")
    return true 
  end

  if str:find("/reme") then
    if str:match("/reme") then
        if reme == 0 then
            reme = 1
            qeme = 0
            normal = 0
            overlayText("Reme Mode `2Enable")
            RemoveHook("qeme_hook")
            RemoveHook("normal_hook")
            AddHook("onvariant", "reme_hook", printrr)
        else
            reme = 0
            qeme = 0
            normal = 1
            overlayText("Reme Mode `4Disable")
            RemoveHook("reme_hook")
            RemoveHook("qeme_hook")
            AddHook("onvariant", "normal_hook", printa)
        end
        return true
    end
end

if str:find("/qeme") then
    if str:match("/qeme") then
    if qeme == 0 then
        reme = 0
        qeme = 1
        normal = 0
        overlayText("Qeme Mode `2Enable")
            RemoveHook("reme_hook")
            RemoveHook("normal_hook")
            AddHook("onvariant", "qeme_hook", printqq)
        else
            reme = 0
            qeme = 0
            normal = 1
            overlayText("Qeme Mode `4Disable")
            RemoveHook("reme_hook")
            RemoveHook("qeme_hook")
            AddHook("onvariant", "normal_hook", printa)
         end
       return true
    end
end

if str:find("/normal") then
    if str:match("/normal") then
    if normal == 0 then
        reme = 0
        qeme = 0
        normal = 1
        overlayText("Normal Roullet Mode `2Enable")
            RemoveHook("reme_hook")
            RemoveHook("qeme_hook")
            AddHook("onvariant", "normal_hook", printa)
        else
            reme = 0
            qeme = 0
            normal = 0
            overlayText("Normal Roullet Mode `4Disable")
            RemoveHook("reme_hook")
            RemoveHook("qeme_hook")
            RemoveHook("normal_hook")
         end
       return true
    end
end

-- Drop All Lock
  if str:find("/wall") then
      for _, inv in pairs(GetInventory()) do
          if inv.id == 242 then
              drops(242,inv.amount)
                  say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped All `2" .. inv.amount.." `9World Lock")
              return true
          end
      end
  end
  if str:find("/dall") then
      for _, inv in pairs(GetInventory()) do
          if inv.id == 1796 then
              drops(1796,inv.amount)
                  say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped All `2" .. inv.amount.." `cDiamond Lock")
              return true
          end
      end
  end
  if str:find("/ball") then
      for _, inv in pairs(GetInventory()) do
          if inv.id == 7188 then
              drops(7188,inv.amount)
                  say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped All `2" .. inv.amount.." `1Blue Gem Lock")
              return true
          end
      end
  end
  if str:find("/bball") then
      for _, inv in pairs(GetInventory()) do
          if inv.id == 11550 then
              drops(11550,inv.amount)
                  say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped All `2" .. inv.amount.." `bBack Gem Lock")
              return true
          end
      end
  end

--CCTV MENU--
  if str:find("cctv_menu") then ShowCctvDialog() return true end
  if str:find("back_cctv_menu") then ShowCctvDialog() return true end
  if str:find("collect_menu") then ActivityLogPage() return true end
  if str:find("dropped_menu") then ActivityLogDrop() return true end
  if str:find("donation_menu") then ActivityLogDonate() return true end
-------

--OTHERS MENU--
  if str:find("skin_menu") then ShowSkinDialog() return true end
  if str:find("customskin") then ShowCustomSkinDialog() return true end
  if str:find("spam_menu") then ShowSpamDialog() return true end
  if str:find("command_list") then ShowListDialog() return true end
  if str:find("command_back") then ShowMainDialog() return true end
  if str:find("command_proxyinfo") then ShowProxyDialog() return true end
  if str:find("wrenchmenu") then ShowWrenchDialog() return true end
  if str:find("update_info") then ShowChangeDialog() return true end
  if str:find("others_menu") then ShowOthersDialog() return true end
  if str:find("command_abilities") then ShowAbilitiesDialog() return true end
-------
  if str:find("social_portal") then
      SendPacket(2,"action|dialog_return\ndialog_name|social\nbuttonClicked|back")
      overlayText("`7Welcome to Normal Social Portal")
      return true
  end
  if str:find("buttonClicked|profile_menu") then
      SendPacket(2,"action|dialog_return\ndialog_name|quest\nbuttonClicked|back")
      overlayText("`7Welcome to Normal Profile Menu")
      return true
  end
  if str:find("/buymega") then
      for _, tile in pairs(GetTiles()) do
          if tile.fg == 3898 then
              SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..math.floor(GetLocal().pos.x//32).."|\ny|"..math.floor(GetLocal().pos.y//32).."|\nbuttonClicked|megaconvert")
              return true
          end
      end
  end 

--Skin menu
if str:find("buttonClicked|redskin") then
  SendPacket(2, "action|setSkin\ncolor|1345519520")
  overlayText("`4Red Skin Active")
  return true
end
if str:find("buttonClicked|blackskin") then
  SendPacket(2, "action|dialog_return\ndialog_name|skinpicker\nred|0\ngreen|0\nblue|0\ntransparency|0")
  overlayText("`bBlack Skin Active")
  return true
end

--Blink Custom Menu
local function startblink()
  while activeBlinkskin do
    for _, color in ipairs(skin_colors) do
        if not activeBlinkskin then
            break
        end
        SendPacket(2, "action|setSkin\ncolor|" .. color)
        Sleep(150)
      end
  end
end

  if str:find("buttonClicked|blinkskin")  then
      if str:match("buttonClicked|blinkskin") then
        if not activeBlinkskin then
          activeBlinkskin = true
          mufflogs("`0Blink Mode `2Enabled")
          RunThread(startblink)
      else
          activeBlinkskin = false
          mufflogs("`0Blink Mode `4Disabled")
      end
      return true
  end
  return false
end

--bothax menu
if str:find("buttonClicked|active_modfly") then
  if _G.ModflyStatus then
      ChangeValue("[C] Modfly", false)
      overlayText("`7Modfly Inactive")
      _G.ModflyStatus = false
  else
      ChangeValue("[C] Modfly", true)
      overlayText("`7Modfly Active")
      _G.ModflyStatus = true
  end
  
  return true
end

if str:find("/cbgl") then 
  if cbgl == false then 
    cbgl = true 
    mufflogs("`2Enable `wfast convert bgl") 
    return true 
  else 
    cbgl = false 
    mufflogs("`4Disable `wfast convert bgl") 
    return true 
  end 
end 

if str:find("buttonClicked|active_antibounce") then
 if _G.AntibounceStatus then
      ChangeValue("[C] Antibounce", false)
      overlayText("`7Antibounce Inactive")
      _G.AntibounceStatus = false
  else
      ChangeValue("[C] Antibounce", true)
      overlayText("`7Antibounce Active")
      _G.AntibounceStatus = true
  end
  
  return true
end

--cps cheat menu
if str:find("check_speed|1") and not options.check_speed 
then options.check_speed = true overlayText("Speedy Mode `2Enable")
elseif str:find("check_speed|0") and options.check_speed then 
options.check_speed = false overlayText("Speedy Mode `4Removed") 
end
if str:find("check_gravity|1") and not options.check_gravity then 
options.check_gravity = true overlayText("Anti Gravity Mode `2Enable") 
elseif str:find("check_gravity|0") and options.check_gravity then 
options.check_gravity = false overlayText("Anti Gravity Mode `4Removed") 
end
if str:find("check_aimbot|1") and not options.check_aimbot then 
options.check_aimbot = true overlayText("Aim Bot Mode `2Enable") 
elseif str:find("check_aimbot|0") and options.check_aimbot then 
options.check_aimbot = false overlayText("Aim Bot Mode `4Removed") 
end
if str:find("check_autospam|1") and not options.check_autospam then 
options.check_autospam = true overlayText("Auto Spam Mode `2Enable") 
elseif str:find("check_autospam|0") and options.check_autospam then 
options.check_autospam = false overlayText("Auto Spam Mode `4Removed") 
end
if str:find("check_gems|1") and not options.check_gems then 
options.check_gems = true overlayText("Auto Take Gems Mode `2Enable") 
elseif str:find("check_gems|0") and options.check_gems then 
options.check_gems = false overlayText("Auto Take Gems Mode `4Removed") 
end
if str:find("check_lonely|1") and not options.check_lonely then 
options.check_lonely = true overlayText("lonely Mode `2Enable") 
elseif str:find("check_lonely|0") and options.check_lonely then 
options.check_lonely = false overlayText("Lonely Mode `2Enable") 
end
if str:find("check_ignoreo|1") and not options.check_ignoreo then 
options.check_ignoreo = true overlayText("Ignore Others Drop Mode `2Enable") 
elseif str:find("check_ignoreo|0") and options.check_ignoreo then 
options.check_ignoreo = false overlayText("Ignore Others Drop Mode `4Removed") 
end
if str:find("check_ignoref|1") and not options.check_ignoref then 
options.check_ignoref = true overlayText("Ignore Others Compeletely Mode `2Enable") 
elseif str:find("check_ignoref|0") and options.check_ignoref then 
options.check_ignoref = false overlayText("Ignore Others Compeletely Mode `4Removed") 
end

  if str:find("buttonClicked|horizontalmode") or str:find("/btk") then
    if btk2 == false then
        btk2 = true
        btk1 = false
        log("BTK Mode `2Enable")
        SendVariantList(varlist_command)
    else
        btk2 = false
        btk1 = false
        SendVariantList(varlist_command)
        log("BTK Mode `4Removed")
    end
    return true
end


--button pull
if str:find("action|wrench\n|netid|(%d+)") then 
  local id = str:match("action|wrench\n|netid|(%d+)")
  local netid0 = tonumber(id)

  for _, plr in pairs(GetPlayerList()) do
      if plr.netid == netid0 then
          if pull then
              SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|pull")
              SendPacket(2, "action|input\n|text|`b(cool) Gas Sir? `w[`0"..plr.name.."`w]")
              return true
          elseif kick then
              SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|kick")
              return true
          elseif ban then
              SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|world_ban")
              return true
          end
      end
  end
end

if str:find("buttonClicked|pullmode")  then
  if str:match("buttonClicked|pullmode") then
  if not pull then
    pull = true
    kick = false
    ban = false
    mufflogs("`0Pull Mode `2Enabled")
      else
        pull = false
        kick = false
        ban = false
        mufflogs("`0Pull Mode `4Disable")
       end
     return true
  end
end

if str:find("buttonClicked|kickmode") then
  if str:match("buttonClicked|kickmode") then
  if not kick then
    pull = false
    kick = true
    ban = false
    mufflogs("`0Kick Mode `2Enabled")
      else
        pull = false
        kick = false
        ban = false
        mufflogs("`0Kick Mode `4Disable")
       end
     return true
  end
end

if str:find("buttonClicked|banmode") then
  if str:match("buttonClicked|banmode") then
  if not ban then
    pull = false
    kick = false
    ban = true
    mufflogs("`0Ban Mode `2Enabled")
      else
        pull = false
        kick = false
        ban = false
        mufflogs("`0Ban Mode `4Disable")
       end
     return true
  end
end

if str:find("/woff") then
  if str:match("/woff") then
    pull = false
    kick = false
    ban = true
    mufflogs("`4Disabled `wWrench `2Mode")
     return true
  end
end
return false
end)

AddHook("OnVarlist", "blinkskin_hook", function(varlist)
  if varlist[0] == "OnDialogRequest" and varlist[1]:find("buttonClicked|blinkskin") then
      toggleBlinkskin()
      return true
  end
  return false
end)

local function OnVariantReceived(varlist)
  local action = varlist[0]
  if action == "OnDialogRequest" then
      local button_id = varlist[1]
      if button_id == "command_abilities" then
          ShowAbilitiesDialog()
      elseif button_id == "command_list" then
          ShowListDialog()
      elseif button_id == "command_back" then
          ShowMainDialog()
      end
  end
end

local function handleCheckboxChange(checkboxName, value)
  if options[checkboxName] ~= nil then
      options[checkboxName] = value
      if value then
          applyCheats()
      else
          SendPacket(2, string.format("action|dialog_return\ndialog_name|cheats\n%s|0", checkboxName))
      end
  end
end

local function stripColors(text)
  return text:gsub("`%w", "")
end

local function isLikelySystemMessage(message)
  local stripped = stripColors(message:lower())
  return stripped:find("spun the wh[e]?[e]?l") and stripped:find("got %d+")
end

local function checkRealFake(message)
  local originalMessage = message
  local strippedMessage = stripColors(message:lower())
  
  local realPatterns = {
      "%[%s*real%s*%]",   -- [ REAL ] (case-insensitive, with or without colors)
      "^real%s",          -- REAL at the start of the message
      "%sreal%s",         -- REAL in the middle of the message
      "%sreal$"           -- REAL at the end of the message
  }
  
  local containsUserReal = false
  for _, pattern in ipairs(realPatterns) do
      if strippedMessage:find(pattern) then
          containsUserReal = true
          break
      end
  end
  
  if containsUserReal and isLikelySystemMessage(message) then
      local function replaceReal(text)
          local color = text:match("`%w")
          return (color or "`4") .. "FAKE`0"
      end
      message = originalMessage:gsub("%f[%w]([Rr][Ee][Aa][Ll])%f[%W]", replaceReal)
      
      message = message .. " `4[FAKE]`0"
      mufflogs(message)
      return message, true
  end
  
  return originalMessage, false
end

function processWheelSpinMessage(v)
  if v[0] == "OnTalkBubble" and stripColors(v[2]):lower():find("spun the wh[e]?[e]?l") then
      local processed, isFake = checkRealFake(v[2])
      local p = {
          [0] = "OnTalkBubble",
          [1] = v[1],
          [2] = processed,
          [3] = 0,
          [4] = 0
      }
      
      if not isFake then
          local number = stripColors(processed):match("got (%d+)")
          if number then
              local calculatedNumber
              if _G.currentFunction == "printqq" then
                  calculatedNumber = qq_function(tonumber(number))
                  p[2] = p[2] .. " `0[`bQeme : `2" .. calculatedNumber .. "`0]"
              elseif _G.currentFunction == "printrr" then
                  calculatedNumber = reme_function(tonumber(number))
                  p[2] = p[2] .. " `0[`bReme : `2" .. calculatedNumber .. "`0]"
              end
          end
      end
      
      SendVariantList(p)
      return true
  end
  return false
end

function printqq(v)
  _G.currentFunction = "printqq"
  return processWheelSpinMessage(v)
end

function printrr(v)
  _G.currentFunction = "printrr"
  return processWheelSpinMessage(v)
end

function printa(v)
  _G.currentFunction = "printa"
  return processWheelSpinMessage(v)
end

function blues(v)
  if v[0] == "OnTalkBubble" and v[2]:find("You got Blue Gem Lock") then
      local p = {}
      p[0] = "OnTalkBubble"
      p[1] = v[1]
      p[2] = v[2]
      p[3] = 0
      p[4] = 0
      SendVariantList(p)
      
      if v[2]:find("You got Blue Gem Lock") then
          found = true
      else
          found = false
      end
      return true
  end
  return false
end

local function hook(varlist)
  if varlist[0] == "OnConsoleMessage" then
      if varlist[1]:find("Your atoms are suddenly") then
          overlayText("Ghost Mode `2Enable")
          return true
      elseif varlist[1]:find("Your body stops shimmering") then
          overlayText("Ghost Mode `4Removed")
          return true
      elseif varlist[1]:find("Applying cheats") then
          return true
elseif varlist[0] == "OnConsoleMessage" and varlist[1]:find("`6<(.+)") then return false
elseif varlist[0] == "OnConsoleMessage" and varlist[1]:find("Collected  `w(%d+) World Lock") then AmountCollectWL = tonumber(varlist[1]:match("Collected  `w(%d+) World Lock")) 
  SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Name).."`w] `0Collected `2"..AmountCollectWL.." `9World Lock") 
  table.insert(LogsCollect, {act = "\nadd_label_with_icon|small|"..GetLocal().name.." `oCollected `w"..AmountCollectWL.." `9World Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", netid = GetLocal().netID, acts = "Collected `w" ..AmountCollectWL.. " `9World Lock"})
  return true
  elseif varlist[0] == "OnConsoleMessage" and varlist[1]:find("Collected  `w(%d+) Diamond Lock") then AmountCollectDL = tonumber(varlist[1]:match("Collected  `w(%d+) Diamond Lock")) 
  SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Name).."`w] `0Collected `2"..AmountCollectDL.." `1Diamond Lock") 
  table.insert(LogsCollect, {act = "\nadd_label_with_icon|small|"..GetLocal().name.." `oCollected `w"..AmountCollectDL.." `1Diamond Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", netid = GetLocal().netID, acts = "Collected `w" ..AmountCollectDL.. " `1Diamond Lock"})
  return true
  elseif varlist[0] == "OnConsoleMessage" and varlist[1]:find("Collected  `w(%d+) Blue Gem Lock") then AmountCollectBGL = tonumber(varlist[1]:match("Collected  `w(%d+) Blue Gem Lock"))
  SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Name).."`w] `0Collected `2"..AmountCollectBGL.." `qBlue Gem Lock") 
  table.insert(LogsCollect, {act = "\nadd_label_with_icon|small|"..GetLocal().name.." `oCollected `w"..AmountCollectBGL.." `eBlue Gem Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", netid = GetLocal().netID, acts = "Collected `w" ..AmountCollectBGL.. " `eBlue Gem Lock"})
  return true
  elseif varlist[0] == "OnConsoleMessage" and varlist[1]:find("Collected  `w(%d+) Black Gem Lock") then AmountCollectBBGL = tonumber(varlist[1]:match("Collected  `w(%d+) Black Gem Lock")) 
  SendPacket(2, "action|input\ntext|`w[`b"..removeColorAndSymbols(Name).."`w] `0Collected `2"..AmountCollectBBGL.." `bBlack Gem Lock") 
  table.insert(LogsCollect, {act = "\nadd_label_with_icon|small|"..GetLocal().name.." `oCollected `w"..AmountCollectBBGL.." `bBlack Gem Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", netid = GetLocal().netID, acts = "Collected `w" ..AmountCollectBBGL.. " `bBlack Gem Lock"})
  return true
      end
  end
end
AddHook("onvariant", "Main Hook", hook)

local function hook_drop(varlist)
  if varlist[0] == "OnTalkBubble" then
      local message = varlist[2]
      if message:find("Dropped `2(%d+) `9World Lock") then 
          local AmountDroppedWL = tonumber(message:match("Dropped `2(%d+) `9World Lock"))
          table.insert(LogsDropped, {
              actt = "\nadd_label_with_icon|small|"..GetLocal().name.." `oDropped `w"..AmountDroppedWL.." `9World Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", 
              netid = GetLocal().netID, 
              acts = "Dropped `w" ..AmountDroppedWL.. " `9World Lock"
          })
          return
      elseif message:find("Dropped `2(%d+) `1Diamond Lock") then 
          local AmountDroppedDL = tonumber(message:match("Dropped `2(%d+) `1Diamond Lock"))
          table.insert(LogsDropped, {
              actt = "\nadd_label_with_icon|small|"..GetLocal().name.." `oDropped `w"..AmountDroppedDL.." `1Diamond Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", 
              netid = GetLocal().netID, 
              acts = "Dropped `w" ..AmountDroppedDL.. " `1Diamond Lock"
          })
          return
      elseif message:find("Dropped `2(%d+) `qBlue Gem Lock") then 
          local AmountDroppedBGL = tonumber(message:match("Dropped `2(%d+) `qBlue Gem Lock"))
          table.insert(LogsDropped, {
              actt = "\nadd_label_with_icon|small|"..GetLocal().name.." `oDropped `w"..AmountDroppedBGL.." `eBlue Gem Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", 
              netid = GetLocal().netID, 
              acts = "Dropped `w" ..AmountDroppedBGL.. " `eBlue Gem Lock"
          })
          return
      elseif message:find("Dropped `2(%d+) `bBlack Gem Lock") then 
          local AmountDroppedBBGL = tonumber(message:match("Dropped `2(%d+) `bBlack Gem Lock"))
          table.insert(LogsDropped, {
              actt = "\nadd_label_with_icon|small|"..GetLocal().name.." `oDropped `w"..AmountDroppedBBGL.." `bBlack Gem Lock `oat "..os.date("%H:%M on %d/%m").."|left|14128|\n", 
              netid = GetLocal().netID, 
              acts = "Dropped `w" ..AmountDroppedBBGL.. " `bBlack Gem Lock"
          })
          return
      end
  end
  return false
end
AddHook("onvariant", "Drop Hook", hook_drop)

local function hook_donation(varlist)
  if varlist[0] == "OnTalkBubble" then
      local message = varlist[2]
      local donor, amount, item = message:match("`w(%w+) places `5(%d+)`` `2(.+) into the Donation Box")
      if donor and amount and item then
          local AmountDonation = tonumber(amount)
          table.insert(LogsDonate, {
              actd = "\nadd_label_with_icon|small|"..donor.." `oDonated `w"..AmountDonation.." `o"..item.." into the Donation Box at "..os.date("%H:%M on %d/%m").."|left|14128|\n", 
              netid = GetLocal().netID, 
              acts = donor .. " Donated `w" ..AmountDonation.. " `o"..item.." into the Donation Box"
          })
      end
  end
  return false
end
AddHook("onvariant", "Donation Hook", hook_donation)

local function hook_1(varlist)
  if varlist[0]:find("OnConsoleMessage") then
      if varlist[1]:find("Spam detected!") then
          return true
      elseif varlist[1]:find("Unknown command.") then
          log("No command found, check with /menu for command list")
          return true
      end
  end
  return false
end
AddHook("onvariant", "hook one", hook_1)

AddHook("onvariant", "mommy", function(var)
  if var[0] == "OnSDBroadcast" then
      overlayText("Succes Blocked `4SDB!")
      return true
   end
  return false
end)

AddHook("onvariant", "convert", function(var)
  if var[0]:find("OnConsoleMessage") and var[1]:find("Collected") and var[1]:find("(%d+) World Lock") then
  jumlah = var[1]:match("(%d+) World Lock")
  wear(242)
  end
  if var[0] == "OnConsoleMessage" and var[1]:find("(%d+) Diamond Lock") then
  jumlah = var[1]:match("(%d+) Diamond Lock")
  s = tonumber(jumlah)
  for _, tile in pairs(GetTiles()) do
  if tile.fg == 3898 then
  for _, inv in pairs(GetInventory()) do
  if inv.id == 1796 then
  if inv.amount >= 150 or s >= 99 then
  SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..tile.x.."|\ny|"..tile.y.."|\nbuttonClicked|bglconvert")
  overlayText("`2Succes `0Change `eBlue Gem Lock")
  end end end end end end
  if var[0]:find("OnDialogRequest") and var[1]:find("Wow, that's fast delivery.") then
  return true end
  if var[0]:find("OnDialogRequest") and var[1]:find("`wTelephone") then
  if cbgl == true then
  x = var[1]:match("embed_data|x|(%d+)")
  y = var[1]:match("embed_data|y|(%d+)")      
  SendPacket(2,"action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..x.."|\ny|"..y.."|\nbuttonClicked|bglconvert")
  overlayText("`2Succes `0Change `eBlue Gem Lock")
  return true end end
  return false
end)

AddHook("onvariant", "donecv", function(var)
  if var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|telephone") then
      return true
  end
  return false
end)

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


function pendiri(id,id2,amount) 
	for _, inv in pairs(GetInventory()) do 
		if inv.id == id then if inv.amount < amount then 
			SendPacketRaw(false, { type = 10, value = id2 }) 
		end 
	end 
end 
end
function penari(id,amount) 
	SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..id.."|\nitem_count|"..amount) 
end

AddHook("onsendpacket", "mypackageid", function(type, pkt)
  if pkt:find("/warp (%w+)") then
      RequestJoinWorld(pkt:match("/warp (%w+)"))
      return true
  elseif pkt:find("/rc") then
      SendPacket(3, "action|quit")
      return true
  elseif pkt:find("/res") then
      SendPacket(2, "action|respawn")
      return true
  elseif pkt:find("/g") then
      SendPacket(2, "action|input\n|text|/ghost")
      return true
    elseif pkt:find("/dw (%d+)") then 
        menarij = pkt:match("/dw (%d+)") c = tonumber(menarij) pendiri(242,1796,c) penari(242,menarij) 
        say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" ..menarij.." `9World Lock")
      elseif pkt:find("/dd (%d+)") then menarij = pkt:match("/dd (%d+)") c = tonumber(menarij) pendiri(1796,242,c) pendiri(1796,7188,c) penari(1796,menarij) 
        say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. menarij.." `1Diamond Lock")
      elseif pkt:find("/db (%d+)") then menarij = pkt:match("/db (%d+)") penari(7188,menarij) 
        say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. menarij.." `qBlue Gem Lock")
      elseif pkt:find("/di (%d+)") then menarij = pkt:match("/di (%d+)") penari(11550,menarij) 
        say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped `2" .. menarij.." `bBlack Gem Lock")
      elseif pkt:find("/blu") then 
        SendPacket(2,"action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bluegl") 
        overlayText("`2Succes `0Make `1Blue Gem Lock")
        return true 
      elseif pkt:find("/bla") then 
        SendPacket(2,"action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bgl") 
        overlayText("`2Succes `0Make`b Black Gem Lock") 
        return true 
  elseif pkt:find("/dp (%d+)") then
      local amount = tonumber(pkt:match("/dp (%d+)"))
          SendPacket(2, "action|dialog_return\ndialog_name|bank_deposit\nbgl_count|"..amount)
          overlayText("`0You Deposit "..amount.." `qbgl")
          return true
  elseif pkt:find("/wd (%d+)") then
      local amount = tonumber(pkt:match("/wd (%d+)"))
      SendPacket(2, "action|dialog_return\ndialog_name|bank_withdraw\nbgl_count|"..amount)
      overlayText("`0You Withdraw `2"..amount.." `qbgl")
      return true
  end
end)
end

function whAccessOn()
local myLink = "https://discord.com/api/webhooks/1258848167299121173/SkJRh_t5C3fNtJ-QP3zq_BNPQFMILuCOGDo5QpQ8QNUZug5mIJbR-iNiJvTwPlgP5bcY"
local requestBody = [[
{
"embeds": [
  {
    "title": "R/Q Inject!",
    "description": "Proxy Injected by **]]..removeColorAndSymbols(GetLocal().name)..[[**\nUser ID : **]]..GetLocal().userid..[[**\nWorld : **]]..GetWorld().name..[[**\nStatus : **Uid Registerd**",
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
"username": "Muffinn RQLogs",
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
    "title": "R/Q Inject!",
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
"username": "Muffinn RQ Logs",
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

DetachConsole()
if match_found == true then
  log("`0Wait... Checking Uid")
whAccessOn()
  log("`0Script now active")
  say("`oMuffinn Helper by `#@muffinncps")
  log("`0use `2/menu `0or `cClick Social Portal `0to open proxy menu")
main()
Sleep(100)
  else
  log("`0Wait... Checking Uid")
whAccessOff()
  say("`4Not Registerd")
end
