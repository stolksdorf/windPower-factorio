require "config"
require "utils"

local multiplier = 1000

local windPower = {
	blueprints ={},
	entities={}
}

local ppp = function(entity)
	for index, t in pairs(entity) do
		game.player.print(index)
	end
	game.player.print("---");
end


local onTick = function(event)
	-- Randomly update the wind
	if USE_RANDOM_WIND and event.tick % UPDATE_RATE == 1 then

		game.player.print("Updating wind");

		local wind_speed = (game.wind_speed * multiplier) + math.random(-1,1)*WIND_DELTA
		if wind_speed > MAX_WIND then wind_speed = MAX_WIND end
		if wind_speed < MIN_WIND then wind_speed = MIN_WIND end
		game.wind_speed = wind_speed/multiplier
	end
end


windPower.blueprints["wind-detector"]={
	onPlace = function(entity)
		entity.operable = false
		return entity
	end,
	onDestroy = function(entity) end,
	onTick = function(detector, event)
		local wind_speed = math.floor(game.wind_speed*multiplier)
		detector.set_circuit_condition(1, {parameters = {
			{count = wind_speed, index = 1, signal = {name = "wind", type = "item"}}
		}})
	end
}

windPower.blueprints["wind-turbine"]={
	onPlace = function(turbine)
		game.player.print("Placing Wind Turbine");
		return turbine
	end,
	onDestroy = function(entity) end,
	onTick = function(turbine, event)
		local energy = game.wind_speed*1000



		turbine.fluidbox[1] = {type="water", amount=10, temperature=energy}

--[[

		current = turbine.fluidbox[1]                       -- store current liquid
		 current.temperature = current.temperature + 1      -- change current temperature
		 turbine.fluidbox[1] = current                       -- update entity liquid
]]--
		--game.player.print(turbine.fluidbox[1].temperature)
	end
}












--Event Handlers
game.on_event(defines.events.on_tick,function(event)
	handleOnTick(windPower, event)
	onTick(event)
end)
game.on_init(function()
	windPower = handleOnLoad(windPower)
end)
game.on_load(function()
	windPower = handleOnLoad(windPower)
end)
game.on_save(function()
	global.windPowerEntities = windPower.entities
end)
game.on_event(defines.events.on_built_entity,function(event)
	windPower = handleEntityBuilt(windPower, event)
end)
game.on_event(defines.events.on_robot_built_entity,function(event)
	windPower = handleEntityBuilt(windPower, event)
end)
game.on_event(defines.events.on_preplayer_mined_item,function(event)
	windPower = handleEntityRemoved(windPower, event)
end)
game.on_event(defines.events.on_robot_pre_mined,function(event)
	windPower = handleEntityRemoved(windPower, event)
end)
game.on_event(defines.events.on_entity_died,function(event)
	windPower = handleEntityRemoved(windPower, event)
end)


--[[
wind_detectors = {}
createBuildableEntity(wind_detectors, 'wind-detector', function(detector)
	local wind_speed = math.floor(game.wind_speed*multiplier)
	detector.set_circuit_condition(1, {parameters = {{count=wind_speed, index=1, signal={name="wind", type="item"}}}})
end)

wind_turbines = {}
createBuildableEntity(wind_turbines, 'wind-turbines', function(detector)
	local wind_speed = math.floor(game.wind_speed*multiplier)
	detector.set_circuit_condition(1, {parameters = {{count=wind_speed, index=1, signal={name="wind", type="item"}}}})
end)

--[[
-- Create the wind detectors
local wind_detectors = createBuildableEntity('wind-detector', function(detector)
	local wind_speed = math.floor(game.wind_speed*multiplier)
	detector.set_circuit_condition(1, {parameters = {{count=wind_speed, index=1, signal={name="wind", type="item"}}}})
end)
]]--

--[[
game.on_event(defines.events.on_tick, function(event)
	for i, detector in ipairs(wind_detectors) do
		local wind_speed = math.floor(game.wind_speed*multiplier)
		detector.set_circuit_condition(1, {parameters = {{count=wind_speed, index=1, signal={name="wind", type="item"}}}})
	end
end)
]]--

-- Randomize the wind speed
--[[
game.on_event(defines.events.on_tick, function(event)
	game.player.print('TICK3')
	if event.tick % UPDATE_RATE == 1 then
		local wind_speed = (game.wind_speed * multiplier) + math.random(-1,1)*WIND_DELTA
		if wind_speed > MAX_WIND then wind_speed = MAX_WIND end
		if wind_speed < MIN_WIND then wind_speed = MIN_WIND end
		game.wind_speed = wind_speed/multiplier
	end

	for i, detector in ipairs(wind_detectors) do
		local wind_speed = math.floor(game.wind_speed*multiplier)
		game.player.print(wind_speed)
		detector.set_circuit_condition(1, {parameters = {{count=wind_speed, index=1, signal={name="wind", type="item"}}}})
	end

	for i, turbine in ipairs(wind_turbines) do
		local energy = game.wind_speed*100000
		turbine.energy = energy
	end

end)
]]--w


--[[
game.on_init(function()
	onLoad()
	debug('init')
end)

game.on_load(function()
	onLoad()
	debug('loading')
end)

game.on_save(function()
	global.windDetectors = wind_detectors
end)

function onLoad()
	if not global.windDetectors then
		global.windDetectors = {}
	end

	wind_detectors = global.windDetectors
end
]]--