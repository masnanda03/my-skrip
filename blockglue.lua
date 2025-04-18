-- [ MAKE GLUE - MUFFINN COMMUNITY ] --
tabel_uid = {"134611", "911", "837096", "134486", "1002", "1009"}

-- [NO TOUCH BICES] --
-- Chemical IDs and Recipe Requirements
local BLOCK_GLUE_ID = 1866
local MAX_BLOCK_GLUE = 249
local CHEMICAL_M_ID = 922
local CHEMICAL_R_ID = 916
local CHEMICAL_P_ID = 918
local VEND_PRICE = 0
local VEND_ITEMS_PER_LOCK = 0
local VEND_TOTAL_LOCKS = 1

-- Mapping of chemical IDs to their names
local CHEMICAL_NAMES = {
    [CHEMICAL_M_ID] = "`bChemical M",
    [CHEMICAL_R_ID] = "`4Chemical R", 
    [CHEMICAL_P_ID] = "`pChemical P"
}

-- Recipe Requirements
local RECIPE_REQUIREMENTS = {
    [CHEMICAL_M_ID] = 1,
    [CHEMICAL_R_ID] = 1,
    [CHEMICAL_P_ID] = 1
}

local function say(txt)
    SendPacket(2,"action|input\ntext|`9"..txt)
end

local function mufflogs(text)
    LogToConsole("`w[`bBlockGlue`w] `9"..text)
end

local function findItem(id)
    for _, itm in pairs(GetInventory()) do
        if itm.id == id then
            return itm.amount
        end    
    end
    return 0
end

local function punch(x, y) 
    local pkt = {} 
    pkt.px = math.floor(GetLocal().pos.x / 32 + x)
    pkt.py = math.floor(GetLocal().pos.y / 32 + y)
    pkt.type = 3 
    pkt.value = 18 
    pkt.x = GetLocal().pos.x 
    pkt.y = GetLocal().pos.y
    SendPacketRaw(false, pkt)
end

local function dropItem(itemId)
    local itemAmount = findItem(itemId)
    if itemAmount > 0 then
        FindPath(LABORATORY_X - 1, LABORATORY_Y, 100)
        Sleep(500)
        SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..itemId.."|\nitem_count|"..itemAmount)
    end
end

local function vendItem()
    FindPath(VEND_X, VEND_Y, 100)
    Sleep(500)
    
    SendPacket(2, "action|dialog_return\ndialog_name|vend_edit\nx|"..VEND_X.."|\ny|"..VEND_Y.."|\nbuttonClicked|addstock\nsetprice|"..VEND_PRICE.."\nchk_peritem|"..VEND_ITEMS_PER_LOCK.."\nchk_perlock|"..VEND_TOTAL_LOCKS)
    Sleep(1000)
end

local function takeIngredients()
    for ingredientId, requiredAmount in pairs(RECIPE_REQUIREMENTS) do
        local currentAmount = findItem(ingredientId)
        
        if currentAmount < requiredAmount then
            local itemFound = false
            for _, obj in pairs(GetObjectList()) do
                if obj.id == ingredientId then
                    local x = math.floor(obj.pos.x / 32)
                    local y = math.floor(obj.pos.y / 32)
                    
                    say("`wTaking ["..CHEMICAL_NAMES[ingredientId].."`w]")
                    
                    FindPath(x, y, 100)
                    Sleep(500)
                    itemFound = true
                    return ingredientId
                end
            end
            
            if not itemFound then
                say("`wCan't Find ["..CHEMICAL_NAMES[ingredientId].."`w]. `4Script terminated.")
                return nil
            end
        end
    end
    
    return nil
end

local function processChemicals()
    local mysteriousChemicalCount = findItem(BLOCK_GLUE_ID)
    
    if mysteriousChemicalCount > MAX_BLOCK_GLUE and ADD_VEND then
        vendItem()
    end
    
    local allIngredientsAvailable = true
    for ingredientId, requiredAmount in pairs(RECIPE_REQUIREMENTS) do
        if findItem(ingredientId) < requiredAmount then
            allIngredientsAvailable = false
            break
        end
    end
    
    if allIngredientsAvailable then
        local chemicalIds = {CHEMICAL_M_ID, CHEMICAL_R_ID, CHEMICAL_P_ID}
        for _, chemId in ipairs(chemicalIds) do
            local itemCount = findItem(chemId)
            if itemCount > 1 then
                dropItem(chemId)
                Sleep(500)
            end
        end
        
        punch(1, 0)
        Sleep(500)
        punch(1, 0)
        Sleep(500)
        
        FindPath(LABORATORY_X, LABORATORY_Y, 60)
        Sleep(500)
        
        return true
    else
        local collectedIngredientId = takeIngredients()
        if collectedIngredientId then
            return true
        else
            return false
        end
    end
    
    return true
end

function main()
    while true do
        if not processChemicals() then
            break
        end
        Sleep(1000)
    end
end

local function hook_1(varlist)
    if varlist[0]:find("OnConsoleMessage") then
        if varlist[1]:find("Spam detected!") then
            return true
        end
    end
    if varlist[0] == "OnSDBroadcast" then
        return true
    end
    return false
end
AddHook("onvariant", "hook one", hook_1)

local user = GetLocal().userid
local match_found = false

for _, id in pairs(tabel_uid) do
    if user == tonumber(id) then
        match_found = true
        break
    end
end

DetachConsole()
if match_found then
    mufflogs("Checking userid to make sure you have access")
    Sleep(1000)
    mufflogs("Uid match with `2"..GetLocal().userid)
    Sleep(1000)
    mufflogs("Player authentication `2successfuly.")
    Sleep(1000)
    say("`9Auto Make Block Glue by `#@muffinncps")

    main()
else
    mufflogs("Checking userid to make sure you have access")
    Sleep(1000)
    say("`4Not Registerd")
    Sleep(1000)
    mufflogs("Contact `#@muffinncps `9if u already buy this script")
end
