-- https://github.com/rxi/lume
local stopwatch = require("lume").time


local work_size = 75
local test_cases_count = 8
local test_cases = { }


local accumulator = 1000 ^ 4
for k = 0, test_cases_count do
	table.insert(test_cases, math.floor(accumulator ^ .25))
	accumulator = accumulator * 10
end


local work = function(size)
	local result = 1
	for i = 1, size do
		local j = i
		while j > 1 do
			if j % 2 == 0 then
				j = j / 2
			else
				j = 3 * j + 1
			end
			result = result + 1
		end
	end
	return result
end


local closure_empty = function(size)
	local inner = function()
	end
	inner()
end

local closure_work = function(size)
	local inner = function()
		work(size)
	end
	inner()
end


local standard_empty_inner = function(size)
end
local standard_empty = function(size)
	standard_empty_inner(size)
end


local standard_work_inner = function(size)
	work(size)
end
local standard_work = function(size)
	standard_work_inner(size)
end



local run_test_case = function(fn, count)
	for i = 0, count do
		fn(work_size)
	end
end


for _, test_case in ipairs(test_cases) do
	local standard_time = stopwatch(run_test_case, standard_empty, test_case)
	local closure_time = stopwatch(run_test_case, closure_empty, test_case)
	local penalty = closure_time - standard_time
	local penalty_per_call = penalty / test_case

	print("empty," .. test_case .. "," .. standard_time .. "," .. closure_time .. "," .. penalty .. "," .. penalty_per_call)
end


for _, test_case in ipairs(test_cases) do
	local standard_time = stopwatch(run_test_case, standard_work, test_case)
	local closure_time = stopwatch(run_test_case, closure_work, test_case)
	local penalty = closure_time - standard_time
	local penalty_per_call = penalty / test_case

	print("work," .. test_case .. "," .. standard_time .. "," .. closure_time .. "," .. penalty .. "," .. penalty_per_call)
end
