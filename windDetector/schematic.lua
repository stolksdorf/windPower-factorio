local utils = require "FAD.utils"
local config = require "config"



--[[ Schematic ]]--

WindDetectorSchematic = {
	name="wind_detector",
	updateRateBySecond = 1.5,

	onPlace = function(entity, storage)
		debug("Placing a wind dectector!")
		storage.sensor = entity.surface.create_entity{name = 'wind_detector_sensor', position = {
			x = entity.position.x,
			y = entity.position.y - 1,
		}}
		storage.sensor.destructible = false
		storage.sensor.operable = false
	end,
	onDestroy = function(entity, storage)
		if utils.isValid(storage.sensor) then
			storage.sensor.destroy()
		end
	end,
	onUpdate = function(entity, storage, event)

		local windSpeed = math.floor((game.wind_speed - config.MIN_WIND)/(config.MAX_WIND - config.MIN_WIND)*100)

		entity.fluidbox[1] = {type="wind", amount=10, temperature=windSpeed+10}

		if utils.isValid(storage.sensor) then
			utils.setCircuitCondition(storage.sensor, {
				virtual= {
					signal_wind_direction = math.floor(game.wind_orientation *360),
					signal_wind_speed = windSpeed
				}
			})
		end
	end
}

return WindDetectorSchematic