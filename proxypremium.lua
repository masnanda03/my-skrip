-- [ R/Q HELPER - MUFFINN COMMUNITY ] --
RemoveHooks()
tabel_uid = {"134611", "475429", "788943", "37962", "100231",
	"343274", "774603", "1032", "588529", "836450", "597946", 
	"734484", "606623", "548750", "836498", "833921", "764408", 
	"101900", "653976", "775610", "852522", "853110", "18601", "546675", "864501", "855464", "141745", "859918", "862476", "698281", "76859", "859839", "239848", "172198", "681222", "870155", "193175", "650402", "237711", "771975", "875494", "327376", "869698"}

update_info = "Last Update : 3 Nov 2024"
local wl = 242
local dl = 1796
local bgl = 7188
local bbgl = 11550
local Name = GetLocal().name
local collectedSent = false
local found = false
local reme = 0
local qeme = 0
local normal = 0
local showuid = false
local time_now = os.date("`1%H:%M`0, `1%d-%m-%Y")
local data = {}
local datalock = {} 
local reds = 120
local greens = 110
local bluess = 100
local transp = 0
local BLOCK_DROPS = false
local BLOCK_CONVERT = true
local CONFIG = {
  FAST_CHANGE_BGL = false,
  AUTO_CHANGE_BGL = false,
  FAST_BUY_CHAMPAGNE = false,
  FAST_BUY_MEGAPHONE = false,
  AUTO_PULL = false,
  AUTO_KICK = false,
  AUTO_BAN = false
}

local AutoSpam, SpamText, SpamDelay = false, "Setting your spam text here", 5000
local activeBlinkskin = false
local options = {check_autospam = false, check_emoji = false}
local lastSpamTime, lastBlinkTime = 0, 0
local spamPaused, blinkPaused = false, false
local emoji = {
  "(wl)","(gtoken)","(gems)","(oops)","(cry)","(lol)","(sigh)","(mad)","(smile)","(tongue)", 
  "(wow)","(no)","(shy)","(wink)","(music)","(yes)","(love)","(heart)","(cool)","(kiss)",
  "(agree)","(see-no-evil)","(dance)","(sleep)","(punch)","(bheart)","(party)","(gems)","(plead)",
  "(peace)","(terror)","(troll)","(halo)","(nuke)","(evil)","(clap)","(grin)","(eyes)","(weary)","(moyai)"
}
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

function showBalance()
  datalock = {} 
  wl_balance = muffsid(242) 
  dl_balance = math.floor(muffsid(1796)) 
  bgl_balance = math.floor(muffsid(7188)) 
  black_balance = math.floor(muffsid(11550)) 
  total_balance = wl_balance + (dl_balance * 100) + (bgl_balance * 10000) + (black_balance * 1000000)
  
  mufflogs("`9Locks Balance: `#"..total_balance.." `9World Lock")
end

function take()
  for _, tile in pairs(GetTiles()) do
  if tile.fg == 1422 then
  for _, obj in pairs(GetObjectList()) do
  if obj.itemid == 1796 or obj.itemid == 242 or obj.itemid == 7188 then
  if obj.posX//32 == tile.x and obj.posY//32 == tile.y then
  pkt = {}
  pkt.type = 11
  pkt.value = obj.id
  pkt.x = obj.posX
  pkt.y = obj.posY
  SendPacketRaw(false,pkt)
  end
  end
  end
  end
  end
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

function say(txt)
SendPacket(2,"action|input\ntext|`9"..txt)
end

function mufflogs(text)
  LogToConsole("`w[`^muffinn.site.xyz`w] `9"..text)
end

function overlayText(text)
  var = {}
  var[0] = "OnTextOverlay"
  var[1] = "`w[`^muffinn.site.xyz`w] `9".. text
  SendVariantList(var)
end

function CHECKBOX(B)
  return B and "1" or "0"
end

function TimeNow()
   current = time_now
  return true
end

function muffsid(id) 
	for _, inv in pairs(GetInventory()) do 
		if inv.id == id then 
			return inv.amount 
		end
	end 
	return 0 
end 

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
add_label_with_icon|small|`8/cd <amount> `0: custom drop locks [/cd 1150 (means 11dl 50wl)]|left|482|
add_label_with_icon|small|`8/dw <amount> `0: drop `9World Lock|left|482|
add_label_with_icon|small|`8/dd <amount> `0: drop `1Diamond Lock|left|482|
add_label_with_icon|small|`8/db <amount> `0: drop `eBlue Gem Lock|left|482|
add_label_with_icon|small|`8/di <amount> `0: drop `bBlack Gem Lock|left|482|
add_label_with_icon|small|`8/wall `0: drop all `9World Lock|left|482|
add_label_with_icon|small|`8/dall `0: drop all `1Diamond Lock|left|482|
add_label_with_icon|small|`8/ball `0: drop all `eBlue Gem Lock|left|482|
add_label_with_icon|small|`8/bball `0: drop all `bBlack Gem Lock|left|482|
add_spacer|small|
add_label_with_icon|small|`0Custom Convert|left|3898|
add_label_with_icon|small|`8/dml `0: convert `eBlue Gem Lock `0to `1diamond lock|left|482|
add_label_with_icon|small|`8/bla `0: convert `eBlue Gem Lock `0to `bBlack Gem Lock|left|482|
add_label_with_icon|small|`8/blu `0: convert `bBlack Gem Lock `0to `eBlue Gem Lock|left|482|
add_label_with_icon|small|`8/cbgl `0: wrench for convert dl > bgl|left|482|
add_label_with_icon|small|`8/fbgl `0: fast convert dl > bgl|left|482|
add_label_with_icon|small|`8/buymega `0: fast buy megaphone|left|482|
add_label_with_icon|small|`8/buycham `0: fast buy champagne|left|482|
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
text_scaling_string|jakhelperbdjsjn|
add_smalltext|`7You can use this command|
add_label_with_icon|small|`8/wpl `0: auto pull|left|482|
add_label_with_icon|small|`8/wkk `0: auto kick|left|482|
add_label_with_icon|small|`8/wban `0: auto ban|left|482|
add_spacer|small|
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
add_url_button|Muffinn|`eMuffinn Website|noflags|https://muffinn.site.xyz|would you like to open website Muffinn Community?|0|0|
add_quick_exit||
add_button|command_back|`9Back|noflags|0|0|
]]
  SendVariantList(varlist_command)
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

local function getRandomElement(tbl)
  return tbl[math.random(#tbl)]
end

local function SendPacketSafely(type, packet)
  if GetWorld() ~= nil then
      SendPacket(type, packet)
      return true
  end
  return false
end

local function SafeSleep(ms)
  local start = os.clock()
  while os.clock() - start < ms/1000 do
      Sleep(10)
      if GetWorld() == nil then
          return false
      end
  end
  return true
end

local function spamLoop()
  local isPaused = false
  local lastSpamTime = 0

  while AutoSpam do
      local currentTime = os.clock()
      
      if GetWorld() == nil then
          if not isPaused then
              mufflogs("Auto Spam `4Paused `w(Not in world)")
              isPaused = true
          end
      else
          if isPaused then
              mufflogs("Auto Spam `2Resumed")
              isPaused = false
          end

          if currentTime - lastSpamTime >= SpamDelay / 1000 then
              local textToSend = SpamText
              if options.check_emoji then
                  textToSend = getRandomElement(emoji) .. " " .. textToSend
              end
              if SendPacketSafely(2, "action|input\ntext|" .. textToSend) then
                  lastSpamTime = currentTime
              end
          end
      end

      if not SafeSleep(100) then
          break
      end
  end
end

local function blinkLoop()
  local isPaused = false
  local lastBlinkTime = 0
  local currentColorIndex = 1

  while activeBlinkskin do
      local currentTime = os.clock()
      
      if GetWorld() == nil then
          if not isPaused then
              mufflogs("Blink Mode `4Paused `w(Not in world)")
              isPaused = true
          end
      else
          if isPaused then
              mufflogs("Blink Mode `2Resumed")
              isPaused = false
          end

          if currentTime - lastBlinkTime >= 1 then
              if SendPacketSafely(2, "action|setSkin\ncolor|" .. skin_colors[currentColorIndex]) then
                  currentColorIndex = (currentColorIndex % #skin_colors) + 1
                  lastBlinkTime = currentTime
              end
          end
      end

      if not SafeSleep(100) then
          break
      end
  end
end

AddHook("OnSendPacket", "FeatureControl", function(type, str)
  if str:find("EnableSpam|1") and not options.check_autospam then
      options.check_autospam = true
      AutoSpam = true
      mufflogs("Auto Spam `2Enabled")
      RunThread(spamLoop)
  elseif str:find("EnableSpam|0") and options.check_autospam then
      options.check_autospam = false
      AutoSpam = false
      mufflogs("Auto Spam `4Disabled")
  elseif str:find("buttonClicked|blinkskin") then
      activeBlinkskin = not activeBlinkskin
      if activeBlinkskin then
        mufflogs("Blink Mode `2Enabled")
          RunThread(blinkLoop)
      else
        mufflogs("Blink Mode `4Disabled")
      end
      return true
  end
  return false
end)

AddHook("OnSendPacket", "SettingSpam", function(type, str)
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
      ShowMainDialog()
      return true
     end
  end

  if str:find("/daw") then
    str:match("`6/daw")
    bgl = inv(7188)
    dl = inv(1796)
    wl = inv(242)
    ireng = inv(11550)
    dawlock = true
    mufflogs("Drop All Lock")
    return true 
  end

  if str:find("/reme") then
    if str:match("/reme") then
        if reme == 0 then
            reme = 1
            qeme = 0
            normal = 0
            say("Reme Mode `2Enable")
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
        say("Qeme Mode `2Enable")
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
        say("Normal Roullet Mode `2Enable")
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
                  say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped All `2" .. inv.amount.." `1Diamond Lock")
              return true
          end
      end
  end
  if str:find("/ball") then
      for _, inv in pairs(GetInventory()) do
          if inv.id == 7188 then
              drops(7188,inv.amount)
                  say("`0[`b"..removeColorAndSymbols(Name).."`0] Dropped All `2" .. inv.amount.." `cBlue Gem Lock")
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
      overlayText("Welcome to Normal Social Portal")
      return true
  end
  if str:find("buttonClicked|profile_menu") then
      SendPacket(2,"action|dialog_return\ndialog_name|quest\nbuttonClicked|back")
      overlayText("Welcome to Normal Profile Menu")
      return true
  end

--Fast Convert
  if str:find("/cbgl") then
    CONFIG.FAST_CHANGE_BGL = not CONFIG.FAST_CHANGE_BGL
    mufflogs(CONFIG.FAST_CHANGE_BGL and "`2Enabled `0Fast Change BGL" or "`4Disabled `0Fast Change BGL")
    return true
  end

  if str:find("/fbgl") then
    CONFIG.AUTO_CHANGE_BGL = not CONFIG.AUTO_CHANGE_BGL
    mufflogs(CONFIG.AUTO_CHANGE_BGL and "`2Enabled `0Auto Change BGL" or "`4Disabled `0Auto Change BGL")
    return true
  end

--Buyying others
if str:find("/buychamp") then
  local found_telephone = false
  local TELEPHONE_X, TELEPHONE_Y

  for _, tile in pairs(GetTiles()) do
      if tile.fg == 3898 then
          found_telephone = true
          TELEPHONE_X = tile.x
          TELEPHONE_Y = tile.y
          break
      end
  end
  if not found_telephone then
    mufflogs("`w[`4Oops`w] `wNo telephone in world. Please place a telephone down to use this feature.")
    return
  end

  SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..TELEPHONE_X.."|\ny|"..TELEPHONE_Y.."|\nbuttonClicked|getchamp")
  overlayText("Success Buy Champagne")
  return true
end

if str:find("/buymega") then
  local found_telephone = false
  local TELEPHONE_X, TELEPHONE_Y

  for _, tile in pairs(GetTiles()) do
      if tile.fg == 3898 then
          found_telephone = true
          TELEPHONE_X = tile.x
          TELEPHONE_Y = tile.y
          break
      end
  end
  if not found_telephone then
    mufflogs("`w[`4Oops`w] `wNo telephone in world. Please place a telephone down to use this feature.")
    return
  end
  
  SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..TELEPHONE_X.."|\ny|"..TELEPHONE_Y.."|\nbuttonClicked|megaconvert")
  overlayText("Success Buy Megaphone")
  return true
end

--Skin menu
if str:find("buttonClicked|redskin") then
  SendPacket(2, "action|setSkin\ncolor|1345519520")
  say("Red Skin Active")
  return true
end
if str:find("buttonClicked|blackskin") then
  SendPacket(2, "action|dialog_return\ndialog_name|skinpicker\nred|0\ngreen|0\nblue|0\ntransparency|0")
  say("Black Skin Active")
  return true
end

--bothax menu
if str:find("buttonClicked|active_modfly") then
  if _G.ModflyStatus then
      ChangeValue("[C] Modfly", false)
      overlayText("Modfly Inactive")
      _G.ModflyStatus = false
  else
      ChangeValue("[C] Modfly", true)
      overlayText("Modfly Active")
      _G.ModflyStatus = true
  end
  
  return true
end

if str:find("buttonClicked|active_antibounce") then
 if _G.AntibounceStatus then
      ChangeValue("[C] Antibounce", false)
      overlayText("Antibounce Inactive")
      _G.AntibounceStatus = false
  else
      ChangeValue("[C] Antibounce", true)
      overlayText("Antibounce Active")
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

--button pull
if str:find("action|wrench\n|netid|(%d+)") then 
  local id = str:match("action|wrench\n|netid|(%d+)")
  local netid0 = tonumber(id)
  
  local localPlayer = GetLocal()
  
  for _, plr in pairs(GetPlayerList()) do
      if plr.netid == netid0 then
          if plr.netid == localPlayer.netid then
              if CONFIG.AUTO_PULL then
                  mufflogs("`w[`4Oops`w] `9Can't pull your self sir")
                  return true
              elseif CONFIG.AUTO_KICK then
                  mufflogs("`w[`4Oops`w] `9Can't kick your self sir")
                  return true
              elseif CONFIG.AUTO_BAN then
                  mufflogs("`w[`4Oops`w] `9Can't ban your self sir")
                  return true
              end
          else
              if CONFIG.AUTO_PULL then
                  SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|pull")
                  SendPacket(2, "action|input\n|text|`b(cool) Gas Sir? `w[`0"..plr.name.."`w]")
                  return true
              elseif CONFIG.AUTO_KICK then
                  SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|kick")
                  return true
              elseif CONFIG.AUTO_BAN then
                  SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|world_ban")
                  return true
              end
          end
      end
  end
end

if str:find("buttonClicked|pullmode") or str:find("/wpl") then
  if str:match("buttonClicked|pullmode") or str:match("/wpl")then
  if not CONFIG.AUTO_PULL then
    CONFIG.AUTO_PULL = true
    CONFIG.AUTO_KICK = false
    CONFIG.AUTO_BAN = false
    say("Pull Mode `2Enabled")
      else
        CONFIG.AUTO_PULL = false
        CONFIG.AUTO_KICK = false
        CONFIG.AUTO_BAN = false
        say("Pull Mode `4Disable")
       end
     return true
  end
end

if str:find("buttonClicked|kickmode") or str:find("/wkk")then
  if str:match("buttonClicked|kickmode") or str:match("/wkk")then
  if not CONFIG.AUTO_KICK then
    CONFIG.AUTO_PULL = false
    CONFIG.AUTO_KICK = true
    CONFIG.AUTO_BAN = false
    say("Kick Mode `2Enabled")
      else
        CONFIG.AUTO_PULL = false
        CONFIG.AUTO_KICK = false
        CONFIG.AUTO_BAN = false
        say("Kick Mode `4Disable")
       end
     return true
  end
end

if str:find("buttonClicked|banmode") or str:find("/wban")then
  if str:match("buttonClicked|banmode") or str:match("/wban") then
  if not CONFIG.AUTO_BAN then
    CONFIG.AUTO_PULL = false
    CONFIG.AUTO_KICK = false
    CONFIG.AUTO_BAN = true
    say("Ban Mode `2Enabled")
      else
        CONFIG.AUTO_PULL = false
        CONFIG.AUTO_KICK = false
        CONFIG.AUTO_BAN = false
        say("Ban Mode `4Disable")
       end
     return true
  end
end

if str:find("/woff") then
  if str:match("/woff") then
    CONFIG.AUTO_PULL = false
    CONFIG.AUTO_KICK = false
    CONFIG.AUTO_BAN = false
    say("Disabled Wrench Mode")
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

local function hook_1(varlist)
  if varlist[0]:find("OnConsoleMessage") then
      if varlist[1]:find("Spam detected!") then
          return true
      elseif varlist[1]:find("Unknown command.") then
        mufflogs("`4Unknown command. `9Enter /menu or click social portal for valid list commands.")
          return true
      end
  end
  if varlist[0] == "OnSDBroadcast" then
    overlayText("Succes Blocked `4SDB!")
    return true
  end
  return false
end
AddHook("onvariant", "hook one", hook_1)

function extractNumbers(str)
  local numbers = {}
  for num in str:gmatch("`%$(%d+)") do
      table.insert(numbers, tonumber(num))
  end
  return numbers
end
function extractWithdrawNumbers(str)
    local numbers = {}
    local withdrawAmount = str:match("Withdrawn%s+(%d+)")
    local bankBalance = str:match("have%s+(%d+)")
    
    if withdrawAmount then table.insert(numbers, tonumber(withdrawAmount)) end
    if bankBalance then table.insert(numbers, tonumber(bankBalance)) end
    return numbers
end

local function cvhook(varlist)
  if varlist[0] == "OnConsoleMessage" and varlist[1]:find("(%d+) Diamond Lock") and CONFIG.AUTO_CHANGE_BGL then
      local jumlah = varlist[1]:match("(%d+) Diamond Lock")
      local current_dl = 0
      
      for _, inv in pairs(GetInventory()) do
          if inv.id == 1796 then
              current_dl = inv.amount
              break
          end
      end
      
      if current_dl >= 100 then
          local found_telephone = false
          local TELEPHONE_X, TELEPHONE_Y
          
          for _, tile in pairs(GetTiles()) do
              if tile.fg == 3898 then
                  found_telephone = true
                  TELEPHONE_X = tile.x
                  TELEPHONE_Y = tile.y
                  break
              end
          end

          if not found_telephone then
              mufflogs("`w[`4Oops`w] `9No telephone in world. Please place a telephone down to use this feature.")
              return
          end
          
          RunThread(function()
              Sleep(500)
              SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..TELEPHONE_X.."|\ny|"..TELEPHONE_Y.."|\nbuttonClicked|bglconvert")
          end)
      end
  end

  -- Handle Telephone Dialog
  if varlist[0]:find("OnDialogRequest") and varlist[1]:find("`wTelephone") then
      local TELEPHONE_X = varlist[1]:match("embed_data|x|(%d+)")
      local TELEPHONE_Y = varlist[1]:match("embed_data|y|(%d+)")
      
      -- Fast Change BGL
      if CONFIG.FAST_CHANGE_BGL then
          if muffsid(1796) < 100 then
              mufflogs("`w[`4Oops`w] `9You don't have `c100 Diamond Lock `9to Convert")
              return true
          end
          SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..TELEPHONE_X.."|\ny|"..TELEPHONE_Y.."|\nbuttonClicked|bglconvert")
          return true
      end
      return true
  end

  if varlist[0]:find("OnTalkBubble") and varlist[2]:find("You shattered") then
    return true
  end

  -- Block "fast delivery" dialog
  if varlist[0]:find("OnDialogRequest") and varlist[1]:find("Wow, that's fast delivery") then
      return true
  end

  -- Success message for BGL convert
  if varlist[0]:find("OnTalkBubble") and varlist[2]:find("You got `$Blue Gem Lock``!") then
      overlayText("Success Convert Diamond Lock to Blue Gem Lock")
      return true
  end

  -- Block all telephone dialog
  if varlist[0]:find("OnDialogRequest") and varlist[1]:find("telephone") then
    return true
  end

  -- Block merged locks
  if varlist[0]:find("OnTalkBubble") and varlist[2]:find("`2Withdrawn") then
    return true
  end

    -- Block all drop dialog
  if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("You merged") then
    return true
  end
  if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|drop") then
    return true
  end

    -- Block Deposit dialog
  if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("Deposited") then
    local numbers = extractNumbers(varlist[1])
    if #numbers >= 2 then
        local depositAmount = numbers[1]
        local bankBalance = numbers[2]
        overlayText("You Deposited `#"..depositAmount.." `9Blue Gem Locks! You have `#"..bankBalance.." `9in the bank now.")
    end
    return true
  end
  if varlist[0]:find("OnTalkBubble") and varlist[2]:find("Deposited") then
    return true
  end

    -- Block Withdrawn Dialog
    if varlist[0]:find("OnConsoleMessage") and varlist[1]:find("`2Withdrawn") then
        local numbers = extractWithdrawNumbers(varlist[1])
        if #numbers >= 2 then
            local withdrawAmount = numbers[1]
            local bankBalance = numbers[2]
            overlayText("You Withdrawn `#"..withdrawAmount.." `9Blue Gem Locks! You have `#"..bankBalance.." `9in the bank now.")
        end
        return true
    end
  if varlist[0]:find("OnTalkBubble") and varlist[2]:find("`2Withdrawn") then
    return true
  end
end
AddHook("onvariant", "convhook", cvhook)

AddHook("onvariant", "join_world", function(var)
  if var[0]:find("OnConsoleMessage") and var[1]:find("Welcome back,") then
      showBalance()
  end
  if var[0]:find("OnConsoleMessage") and var[1]:find("Moving to the last location") then
    mufflogs("Moving back to last location")
    return true
  end
end)

LogsCollect = LogsCollect or {}
LogsDropped = LogsDropped or {}

local function formatTimestamp()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local function convertToHighestUnit(wls)
    if wls >= 1000000 then
        return math.floor(wls / 1000000), "Black Gem Lock", "b"
    elseif wls >= 10000 then
        return math.floor(wls / 10000), "Blue Gem Lock", "e"
    elseif wls >= 100 then
        return math.floor(wls / 100), "Diamond Lock", "1"
    else
        return wls, "World Lock", "9"
    end
end

local function add_drop_log(amount, item_name, color)
    local timestamp = formatTimestamp()
    local log_entry = {
        actt = string.format("\nadd_label_with_icon|small|[%s] %s `oDropped `w%d `%s%s|left|14128|\n",
                             timestamp,
                             GetLocal().name,
                             amount,
                             color,
                             item_name),
        netid = GetLocal().netID,
        acts = string.format("Dropped %d %s", amount, item_name),
        timestamp = timestamp
    }
    table.insert(LogsDropped, log_entry)
end

local function addCollectLog(items)
    local timestamp = formatTimestamp()
    local totalWLs = 0
    
    -- Hitung total WLs
    for _, item in ipairs(items) do
        totalWLs = totalWLs + (item.amount * item.value)
    end
    
    -- Konversi ke unit tertinggi
    local convertedAmount, unitName, unitColor = convertToHighestUnit(totalWLs)
    
    local logMessage = string.format("[%s] %s `oCollected `w%d `%s%s", 
        timestamp, GetLocal().name, convertedAmount, unitColor, unitName)
    local chatMessage = string.format("`w[`b%s`w] `0Collected `w%d `%s%s", 
        removeColorAndSymbols(GetLocal().name), convertedAmount, unitColor, unitName)

    table.insert(LogsCollect, {
        act = "\nadd_label_with_icon|small|" .. logMessage .. "|left|14128|\n",
        netid = GetLocal().netID,
        acts = string.format("Collected %d %s", convertedAmount, unitName),
        timestamp = timestamp
    })

    SendPacket(2, "action|input\ntext|" .. chatMessage)
end

local function combined_hook(varlist)
    if varlist[0] == "OnConsoleMessage" then
        if varlist[1]:find("Your atoms are suddenly") then
            overlayText("Ghost Mode `2Enable")
            return true
        elseif varlist[1]:find("Your body stops shimmering") then
            overlayText("Ghost Mode `4Removed")
            return true
        elseif varlist[1]:find("Applying cheats") then
            return true
        elseif varlist[1]:find("`6<(.+)") then
            return false
        elseif varlist[1]:find("Collected") then
            local items = {}
            local patterns = {
                {pattern = "(%d+) World Lock", name = "World Lock", color = "9", value = 1},
                {pattern = "(%d+) Diamond Lock", name = "Diamond Lock", color = "1", value = 100},
                {pattern = "(%d+) Blue Gem Lock", name = "Blue Gem Lock", color = "e", value = 10000},
                {pattern = "(%d+) Black Gem Lock", name = "Black Gem Lock", color = "b", value = 1000000}
            }
            
            for _, p in ipairs(patterns) do
                local amount = tonumber(varlist[1]:match("Collected  `w" .. p.pattern))
                if amount then
                    table.insert(items, {amount = amount, name = p.name, color = p.color, value = p.value})
                end
            end

            if #items > 0 then
                addCollectLog(items)
                return true
            end
        end
    elseif varlist[0] == "OnTalkBubble" then
        local message = varlist[2]
        local patterns = {
            {pattern = "Dropped `2(%d+) `9World Lock", color = "9", name = "World Lock", value = 1},
            {pattern = "Dropped `2(%d+) `1Diamond Lock", color = "1", name = "Diamond Lock", value = 100},
            {pattern = "Dropped `2(%d+) `eBlue Gem Lock", color = "e", name = "Blue Gem Lock", value = 10000},
            {pattern = "Dropped `2(%d+) `bBlack Gem Lock", color = "b", name = "Black Gem Lock", value = 1000000}
        }
        
        for _, p in ipairs(patterns) do
            local amount = tonumber(message:match(p.pattern))
            if amount then
                add_drop_log(amount, p.name, p.color)
                return true
            end
        end
    end
    return false
end

AddHook("onvariant", "Combined Hook", combined_hook)

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

function DOUBLE_CLICK_ITEM(ITEM_ID)
  local packet = {
      type = 10,
      value = ITEM_ID
  }
  SendPacketRaw(false, packet)
end

local function GET_BALANCE()
  local WLS = muffsid(242)
  local DLS = muffsid(1796)
  local BGLS = muffsid(7188)
  local BLGLS = muffsid(11550)
  return WLS + (DLS * 100) + (BGLS * 10000) + (BLGLS * 1000000)
end

local function drop_items(blgls, bgls, dls, wls)
  local function drop(item_id, count, item_type)
      if count > 0 then
          local current = muffsid(item_id)
          
          if current < count then
              if item_id == 242 and muffsid(1796) > 0 then
                  SendPacketRaw(false, {type = 10, value = 1796})
                  Sleep(500)
              elseif item_id == 1796 and muffsid(7188) > 0 then 
                  SendPacketRaw(false, {type = 10, value = 7188})
                  Sleep(500)
              elseif item_id == 7188 and muffsid(11550) > 0 then
                  SendPacketRaw(false, {type = 10, value = 11550})
                  Sleep(500)
              end
              
              Sleep(250)
          end

          current = muffsid(item_id)

          if current >= count then
              SendPacket(2, "action|drop\n|itemID|"..item_id)
              Sleep(150)
              SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..item_id.."|\nitem_count|"..count)
              Sleep(250)
          end
      end
  end

  drop(11550, blgls, "blgl")
  drop(7188, bgls, "bgl")
  drop(1796, dls, "dl")
  drop(242, wls, "wl")
end

local function send_drop_message(name, amount, item_type)
  local item_names = {
      wl = "`9World Lock",
      dl = "`1Diamond Lock",
      bgl = "`eBlue Gem Lock",
      blgl = "`bBlack Gem Lock"
  }
  SendPacket(2, "action|input\n|text|`0[`b"..name.."`0] Dropping `w"..amount.." "..item_names[item_type])
end

AddHook("onsendpacket", "mypackageid", function(type, pkt)
  if pkt:find("/warp (%w+)") then
      RequestJoinWorld(pkt:match("/warp (%w+)"))
      return true
  elseif pkt:find("/rc") then
      SendPacket(3, "action|quit")
      return true
  elseif pkt:find("/res") then
      say("Respawn dulu dek (cry)")
      SendPacket(2, "action|respawn")
      return true
  elseif pkt:find("/g") then
      SendPacket(2, "action|input\n|text|/ghost")
      return true
  -- Drop World Lock
  elseif pkt:find("/dw (%d+)") then 
      local amount = tonumber(pkt:match("/dw (%d+)"))
      send_drop_message(removeColorAndSymbols(GetLocal().name), amount, "wl")
      Sleep(100)
      drop_items(0, 0, 0, amount)
      add_drop_log(amount, "World Lock", "9")
      return true
  -- Drop Diamond Lock
  elseif pkt:find("/dd (%d+)") then 
      local amount = tonumber(pkt:match("/dd (%d+)"))
      send_drop_message(removeColorAndSymbols(GetLocal().name), amount, "dl")
      Sleep(100)
      drop_items(0, 0, amount, 0)
      add_drop_log(amount, "Diamond Lock", "1")
      return true
  -- Drop Blue Gem Lock
  elseif pkt:find("/db (%d+)") then 
      local amount = tonumber(pkt:match("/db (%d+)"))
      send_drop_message(removeColorAndSymbols(GetLocal().name), amount, "bgl")
      Sleep(100)
      drop_items(0, amount, 0, 0)
      add_drop_log(amount, "Blue Gem Lock", "e")
      return true
  -- Drop Black Gem Lock
  elseif pkt:find("/di (%d+)") then 
      local amount = tonumber(pkt:match("/di (%d+)"))
      send_drop_message(removeColorAndSymbols(GetLocal().name), amount, "blgl")
      Sleep(100)
      drop_items(amount, 0, 0, 0)
      add_drop_log(amount, "Black Gem Lock", "b")
      return true
  -- Custom Drop (berdasarkan World Lock value)
  elseif pkt:find("/cd (%d+)") then
      local value = tonumber(pkt:match("/cd (%d+)"))
      if not value then return false end

      local balance = GET_BALANCE()
      if value > balance then
          mufflogs("`4Error: `9Requested drop amount exceeds balance.")
          return false
      end

      BLOCK_DROPS = true
      BLOCK_CONVERT = true

      RunThread(function()
          local drop_blgls = math.floor(value / 1000000)
          value = value % 1000000
          local drop_bgls = math.floor(value / 10000)
          value = value % 10000
          local drop_dls = math.floor(value / 100)
          local drop_wls = value % 100

          local total_wls = (drop_blgls * 1000000) + (drop_bgls * 10000) + (drop_dls * 100) + drop_wls

          mufflogs(string.format("`2Dropping Locks`w: %d `bBlack Gem Locks`w, %d `eBlue Gem Locks`w, %d `1Diamond Locks`w, and %d `9World Locks",
              drop_blgls, drop_bgls, drop_dls, drop_wls))

          SendPacket(2, "action|input\n|text|"..string.format("`0[`b%s`0] Dropping `2%d `9World Lock", removeColorAndSymbols(GetLocal().name), total_wls))
          Sleep(100)
          drop_items(drop_blgls, drop_bgls, drop_dls, drop_wls)

          if drop_blgls > 0 then add_drop_log(drop_blgls, "Black Gem Lock", "b") end
          if drop_bgls > 0 then add_drop_log(drop_bgls, "Blue Gem Lock", "e") end
          if drop_dls > 0 then add_drop_log(drop_dls, "Diamond Lock", "1") end
          if drop_wls > 0 then add_drop_log(drop_wls, "World Lock", "9") end
      end)

      return true
  elseif pkt:find("/blu") then 
    if muffsid(11550) < 1 then
      overlayText("You need at least 1 Black Gem Lock to convert to Blue Gem Lock")
    else
      SendPacket(2,"action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bluegl") 
      say("Succes Convert `bBlack Gem Lock `9to `eBlue Gem Lock")
    end
      return true 
  elseif pkt:find("/bla") then 
    if muffsid(7188) < 100 then
      overlayText("You need 100 Blue Gem Lock to convert to Black Gem Lock")
    else
      SendPacket(2,"action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bgl") 
      say("Succes Convert `eBlue Gem Lock `9to `bBlack Gem Lock") 
    end
      return true 
  elseif pkt:find("/dml") then 
    if muffsid(7188) < 1 then
      overlayText("You need at least 1 Blue Gem Lock to convert to Diamond Lock")
    else
      DOUBLE_CLICK_ITEM(7188)
      say("Succes Convert `eBlue Gem Lock `9to `1Diamond Lock") 
    end
      return true 
  elseif pkt:find("/dp (%d+)") then
      local amount = tonumber(pkt:match("/dp (%d+)"))
      SendPacket(2, "action|dialog_return\ndialog_name|bank_deposit\nbgl_count|"..amount)
      return true
  elseif pkt:find("/wd (%d+)") then
      local amount = tonumber(pkt:match("/wd (%d+)"))
      SendPacket(2, "action|dialog_return\ndialog_name|bank_withdraw\nbgl_count|"..amount)
      return true
  end
  return false
end)
end

function whAccessOn()
local myLink = "https://discord.com/api/webhooks/1305179797135032340/3hOO3gi6uquO_FiuJXHgNCzGc2JzUr1N3vjB15nSfrOxLa6v_dlaiHpfixNwc7q3JDe-"
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
      "url": "https://media.discordapp.net/attachments/1196488075837190195/1299781477554454640/roullete.webp?ex=671f1c15&is=671dca95&hm=4d2483c38e96d8e77c0d5d8e7cf9ea163b14bb1b9a3c2a2b0c967be5c84bd8a4&=&format=webp"
    }
  }
],
"username": "Muffinn RQLogs",
"avatar_url": "https://images-ext-1.discordapp.net/external/FME3u6PuTVVZ4f0Q-Ait1RF_4VokmiaBwdzE1pk5qDo/%3Fsize%3D1024/https/cdn.discordapp.com/avatars/1091651204494409839/36835dfa7cbb30a3c1bd7766f07db186.png?format=webp&quality=lossless",
"attachments": []
}
]]
MakeRequest(myLink, "POST", {["Content-Type"] = "application/json"}, requestBody)
end
function whAccessOff()
local myLink = "https://discord.com/api/webhooks/1305179797135032340/3hOO3gi6uquO_FiuJXHgNCzGc2JzUr1N3vjB15nSfrOxLa6v_dlaiHpfixNwc7q3JDe-"
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
      "url": "https://media.discordapp.net/attachments/1196488075837190195/1299781477554454640/roullete.webp?ex=671f1c15&is=671dca95&hm=4d2483c38e96d8e77c0d5d8e7cf9ea163b14bb1b9a3c2a2b0c967be5c84bd8a4&=&format=webp"
    }
  }
],
"username": "Muffinn RQ Logs",
"avatar_url": "https://images-ext-1.discordapp.net/external/FME3u6PuTVVZ4f0Q-Ait1RF_4VokmiaBwdzE1pk5qDo/%3Fsize%3D1024/https/cdn.discordapp.com/avatars/1091651204494409839/36835dfa7cbb30a3c1bd7766f07db186.png?format=webp&quality=lossless",
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
  mufflogs("Checking userid to make sure you have access")
  Sleep(1000)
  mufflogs("Uid match with `2"..GetLocal().userid)
  whAccessOn()
  mufflogs("Player authentication `2successfuly.")
  showBalance()
  mufflogs("Use /menu or click on friend button to open menu")
  say("`9r/q proxy inject by `#@muffinncps")
  main()
  Sleep(100)
  else
    mufflogs("Checking userid to make sure you have access")
    whAccessOff()
  say("`4Not Registerd")
  mufflogs("Contact `#@muffinncps `9if u already buy this script")
end
