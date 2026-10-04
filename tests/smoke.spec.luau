--!strict
-- Proves the harness works. Replace with real specs as Logic modules appear.
local t = require("./harness")

t.describe("harness", function()
	t.it("compares values", function()
		t.expect(2 + 2).toBe(4)
	end)
	t.it("compares tables", function()
		t.expect({ a = 1, b = { 2, 3 } }).toEqual({ a = 1, b = { 2, 3 } })
	end)
end)

return nil
