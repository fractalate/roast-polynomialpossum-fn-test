-- lume.time(fn, ...)
-- Inserts the arguments into function fn and calls it. Returns the time in seconds the function fn took to execute followed by fn's returned values.
-- https://github.com/rxi/lume
local stopwatch = require("lume").time
local amounts = { 10, 100, 1000, 10000, 100000, 500000 }

-- 'closure', nested way
local closure = function(text)
	local inner = function()
		print(text)
	end
	inner(text)
end

-- usual, standard way
local inner = function(str)
	print(str)
end

local standard = function(text)
	inner(text)
end

-- case functions
local case_a = function(amount)
	for i = 0, amount do
		closure("text")
	end
end
local case_b = function(amount)
	for i = 0, amount do
		standard("text")
	end
end
local times = {}
for _, amount in ipairs(amounts) do
	local a_time = stopwatch(case_a, amount)
	local b_time = stopwatch(case_b, amount)
	table.insert(times, "amount: " .. amount .. " case a: " .. a_time .. " case b: " .. b_time)
end
for _, result in ipairs(times) do
	print(result)
end
