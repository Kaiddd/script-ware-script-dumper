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
local tsk_spawn = tsk.spawn
local coro = coroutine
local coro_wrap = coro.wrap
mth.randomseed(tick())

local function decompile(a)
    if a:IsA("ModuleScript") or a:IsA("LocalScript") then
	if pcall(function() tostr(disassem(a)) end) and tostr(disassem(a)) ~= nil then
	tsk_wait(0.25)
        return tostr(disassem(a))
        end
    end
end

local function randomNumbers()
    return tostr(mth_random(1e9, 2e9))
end

local foldername = string.gsub(game:GetService("MarketplaceService"):GetProductInfo(placeid).Name, "[^%w%s]", "") .. "'s Script Dump Output (" .. randomNumbers() .. ")"

local scripts = {}
local out

tsk_spawn(coro_wrap(function()
for i, v in getscripts() do
    if v:IsA("ModuleScript") or v:IsA("LocalScript") and not v:FindFirstAncestor("CoreGui") and not v:FindFirstAncestor("CorePackages") then
        tbl_insert(scripts, v)
    end
end
end))

tsk_spawn(coro_wrap(function()
for i, v in scripts do
	runService.RenderStepped:Wait()

	out = decompile(v)

	if not folderexists(tostr(foldername)) then
		savefolderas(tostr(foldername))
	end

	savefileas(tostr(foldername.."/"..v.Name..randomNumbers()..".lua"), tostr(out))
end
end))
