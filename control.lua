local config = require "config"
local utils = require "FAD.utils"
local Mod = require "FAD.mod"

--Mod Defintion
local WindPowerMod = Mod.register("WindPowerMod")

--Entities
WindPowerMod.addSchematic(require "windTurbine.schematic")
WindPowerMod.addSchematic(require "windDetector.schematic")




if config.USE_RANDOM_WIND then
	WindPowerMod.addOnTickListener(function(event)
		-- Randomly update the wind
		if event.tick % (config.UPDATE_RATE*60) == 1 then

			utils.print("Updating wind");

			local multiplier = 1000

			local wind_speed = (game.wind_speed * multiplier) + math.random(-1,1)*config.WIND_DELTA
			if wind_speed > config.MAX_WIND then wind_speed = config.MAX_WIND end
			if wind_speed < config.MIN_WIND then wind_speed = config.MIN_WIND end
			game.wind_speed = wind_speed/multiplier
		end
	end)
end













--[[
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


		current = turbine.fluidbox[1]                       -- store current liquid
		 current.temperature = current.temperature + 1      -- change current temperature
		 turbine.fluidbox[1] = current                       -- update entity liquid
		--game.player.print(turbine.fluidbox[1].temperature)
	end

]]