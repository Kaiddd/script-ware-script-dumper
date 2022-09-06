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
local tsk_wait = tsk.wait
local coro = coroutine
local coro_wrap = coro.wrap
mth.randomseed(tick())

local function decompile(a)
    if a:IsA("ModuleScript") or a:IsA("LocalScript") then
	if pcall(function() tostr(disassem(a)) end) then
	if not tostr(disassem(a)) == "nil" and not tostr(disassem(a)) == nil and tostr(disassem(a)) then
        return tostr(disassem(a))
        end
        end
    end
end

local function randomNumbers()
    return tostr(mth_random(1e9, 2e9))
end

local foldername = string.gsub(game:GetService("MarketplaceService"):GetProductInfo(placeid).Name, "[^%w%s]", "") .. "'s Script Dump Output (" .. randomNumbers() .. ")"

local scripts = getscripts()
local out

for i, v in scripts do
	if not (v:IsA("LocalScript") or v:IsA("ModuleScript")) then continue end
	runService.RenderStepped:Wait()

	out = decompile(v)

	if not folderexists(tostr(foldername)) then
		savefolderas(tostr(foldername))
	end

	savefileas(tostr(foldername.."/"..v.Name..randomNumbers()..".lua"), tostr(out))
end
