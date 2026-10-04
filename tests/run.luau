--!strict
-- Entry point: `lune run tests/run`
-- Add each new spec file to SPECS. Specs only require pure modules from
-- src/shared/Logic and src/shared/Data (those never touch Roblox APIs).

local process = require("@lune/process")
local t = require("./harness")

local SPECS = {
	"./smoke.spec",
	-- "./StatLogic.spec",
}

for _, path in SPECS do
	local ok, err = pcall(require, path)
	if not ok then
		t.it("load " .. path, function()
			error(err)
		end)
	end
end

if not t.report() then
	process.exit(1)
end
