--!strict
-- Tiny test harness for Lune. No dependencies, so it runs anywhere Lune runs.
-- Usage inside a spec:
--   local t = require("./harness")
--   t.describe("StatLogic", function()
--       t.it("adds stats", function()
--           t.expect(1 + 1).toBe(2)
--       end)
--   end)

local Harness = {}

local passed = 0
local failed = 0
local failures: { string } = {}
local prefix = ""

function Harness.describe(name: string, fn: () -> ())
	local old = prefix
	prefix = if old == "" then name else old .. " > " .. name
	fn()
	prefix = old
end

function Harness.it(name: string, fn: () -> ())
	local fullName = if prefix == "" then name else prefix .. " > " .. name
	local ok, err = pcall(fn)
	if ok then
		passed += 1
	else
		failed += 1
		table.insert(failures, fullName .. "\n    " .. tostring(err))
	end
end

local function deepEqual(a: any, b: any): boolean
	if type(a) ~= type(b) then
		return false
	end
	if type(a) ~= "table" then
		return a == b
	end
	for k, v in a do
		if not deepEqual(v, b[k]) then
			return false
		end
	end
	for k in b do
		if a[k] == nil then
			return false
		end
	end
	return true
end

function Harness.expect(actual: any)
	return {
		toBe = function(expected: any)
			if actual ~= expected then
				error(`expected {tostring(expected)}, got {tostring(actual)}`, 2)
			end
		end,
		toEqual = function(expected: any)
			if not deepEqual(actual, expected) then
				error("tables not deeply equal", 2)
			end
		end,
		toBeTruthy = function()
			if not actual then
				error(`expected truthy, got {tostring(actual)}`, 2)
			end
		end,
		toBeFalsy = function()
			if actual then
				error(`expected falsy, got {tostring(actual)}`, 2)
			end
		end,
		toThrow = function()
			local ok = pcall(actual)
			if ok then
				error("expected function to throw", 2)
			end
		end,
	}
end

function Harness.report(): boolean
	for _, f in failures do
		print("FAIL  " .. f)
	end
	print(`\n{passed} passed, {failed} failed`)
	return failed == 0
end

return Harness
