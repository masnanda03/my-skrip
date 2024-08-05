local json = require("json")
local http = require("socket.http")

local function get_github_file(repo, path)
    local url = string.format("https://raw.githubusercontent.com/%s/main/%s", repo, path)
    local body, code = http.request(url)
    if code ~= 200 then
        error("Failed to fetch file from GitHub")
    end
    return body
end

local function is_uid_registered(uid, file)
    local json_data = get_github_file("masnanda03/my-skrip", "uids.json")
    local data = json.decode(json_data)
    
    if data[file] and data[file].uids then
        for _, registered_uid in ipairs(data[file].uids) do
            if registered_uid == uid then
                return true
            end
        end
    end
    
    return false
end

-- Replace with the actual UID and file name
local uid = GetLocal().userid
local file = "sc1.lua"

if is_uid_registered(uid, file) then
    print("UID is registered. Running script")
    dofile("autosurg.lua")
else
    print("UID is not registered for this file. Access denied.")
end
