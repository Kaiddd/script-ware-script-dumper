--- Script-Ware Script Dumper by nul#3174 ---

if not identifyexecutor or identifyexecutor() ~= "ScriptWare" then return end

local runService = game:GetService("RunService")
local savefolderas = makefolder
local savefileas = writefile
local folderexists = isfolder
local tostr = tostring
local disassem = disassemble
local placeid = game.PlaceId
local tbl = table
local tbl_insert = tbl.insert
local mth = math
local mth_random = mth.random
local tsk = task
local tsk_wait = tsk.wait
local foldername = string.gsub(game:GetService("MarketplaceService"):GetProductInfo(placeid).Name, "[^%w%s]", "")
mth.randomseed(tick())

local function decompile(a)
    if a:IsA("ModuleScript") or a:IsA("LocalScript") then
    tsk_wait(1.25)
        if pcall(function() tostr(disassem(a)) end) then
        tsk_wait(0.75)
        return tostr(disassem(a))
        end
    end
end

local function randomNumbers()
    runService.RenderStepped:Wait()
    return tostr(mth_random(1e9, 2e9))
end

local scripts = {}
local out

for i, v in next, getscripts() do
    if v:IsA("ModuleScript") or v:IsA("LocalScript") and not v:FindFirstAncestor("CoreGui") and not v:FindFirstAncestor("CorePackages") then
        if not v:FindFirstAncestor("Chat") and not v:FindFirstAncestor("PlayerModule") then
            tbl_insert(scripts, v)
        end
    end
end

for i, v in next, scripts do
	runService.RenderStepped:Wait()

	out = decompile(v)

	if not folderexists(tostr(foldername.."'s Script Dump Output")) then
		savefolderas(tostr(foldername.."'s Script Dump Output"))
	end

	savefileas(tostr(foldername.."'s Script Dump Output".."/"..v.Name..randomNumbers()..".lua"), tostr(out))
end
