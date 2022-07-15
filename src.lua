--- Script-Ware Script Dumper by nul#3174 ---

if not identifyexecutor then return end

if identifyexecutor and identifyexecutor() ~= "ScriptWare" then return end

local newfolder = makefolder
local newfile = writefile
local tostr = tostring
local disassem = disassemble
local placeid = game.PlaceId
local tbl = table
local tbl_insert = tbl.insert
local mth = math
local mth_random = mth.random
local mth_randomseed = mth.randomseed
local foldername = string.gsub(game:GetService("MarketplaceService"):GetProductInfo(placeid).Name, "[^%w%s]", "")

local function decompile(a)
    if a:IsA("ModuleScript") or a:IsA("LocalScript") then
    task.wait(2)
        if pcall(function() tostr(disassem(a)) end) then
        return tostr(disassem(a))
        end
    end
end

local function randomNumbers()
    mth_randomseed(tick())
    game:GetService("RunService").RenderStepped:Wait()
    return tostr(mth_random(1e9, 2e9))
end

local scripts = {}
local out

for i, v in next, game:GetDescendants() do
    if v:IsA("ModuleScript") or v:IsA("LocalScript") and not v:FindFirstAncestor("CoreGui") and not v:FindFirstAncestor("CorePackages") then
        if not v:FindFirstAncestor("Chat") and not v:FindFirstAncestor("PlayerModule") then
            tbl_insert(scripts, v)
        end
    end
end

for i, v in next, scripts do

out = decompile(v)

if not isfolder(tostr(foldername.."'s Script Dump Output")) then
    makefolder(tostr(foldername.."'s Script Dump Output"))
end

writefile(tostr(foldername.."'s Script Dump Output".."/"..v.Name..randomNumbers()..".lua"), tostr(out))

end
