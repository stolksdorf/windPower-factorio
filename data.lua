
--Technology
--[[
data:extend({
	{
		type = "technology",
		name = "freight_logistics",
		icon = "__FreightLogistics__/img/technology.png",
		unit = {
			count = 50,
			time  = 10,
			ingredients = {
				{"science-pack-1", 1,},
				{"science-pack-2", 1,},
			},
		},
		prerequisites = {"rail-signals"},
		effects = {},
		order = "a-d-e",
	},
})
]]
-- Wind Fluid
data:extend({
	{
		type = "fluid",
		name = "wind",
		default_temperature = 20,
		heat_capacity = "1KJ",
		base_color = {r=1, g=1, b=1},
		flow_color = {r=1, g=1, b=1},
		max_temperature = 100,
		icon = "__WindPower__/img/wind.png",
		pressure_to_speed_ratio = 0.4,
		flow_to_energy_ratio = 0.59,
		order = "a[fluid]-b[wind]"
	}
})



require("windTurbine.prototype")

--require("prototypes.windDetector")
--require("prototypes.windTurbine")