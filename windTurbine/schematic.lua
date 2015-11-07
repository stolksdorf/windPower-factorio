local utils = require "FAD.utils"




--[[ Schematic ]]--

WindTurbineSchematic = {
	name="wind_turbine",
	updateRateBySecond = 0.25,
	onPlace = function(entity, storage)
		debug("Placing a wind turbine!")
	end,
	onDestroy = function(entity, storage)

	end,
	onUpdate = function(entity, storage, event)
		local energy = game.wind_speed*100

		energy=100
		entity.fluidbox[1] = {type="wind", amount=game.wind_speed* 10, temperature=energy}

	end
}

return WindTurbineSchematic