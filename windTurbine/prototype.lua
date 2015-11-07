local config = require "config"

local animation = {
	filename = "__WindPower__/windTurbine/img/animation.png",
	width = 246,
	height = 200,
	priority = "extra-high",
	shift = {1.8, -1.75},
	animation_speed = 1.3,

	frame_count = 40,
	line_length = 5,
}


data:extend({

	--Item
	{
		type = "item",
		name = "wind_turbine",
		icon = "__WindPower__/windTurbine/img/icon.png",
		flags = {"goes-to-quickbar"},
		subgroup = "energy",
		order = "e[accumulator]-a[solar-panel]",
		place_result = "wind_turbine",
		stack_size = 50
	},

	-- Recipe
	{
		type = "recipe",
		name = "wind_turbine",
		enabled = false,
		energy_required = 15,
		ingredients = {
			{"electric-engine-unit", 15},
			{"steel-plate", 100},
			{"advanced-circuit", 25},
			{"plastic-bar", 30}
		},
		result = "wind_turbine"
	},

	--REMOVE AFTER TESTING
	{
		type = "recipe",
		name = "wind_turbine_TEST",
		enabled = true,
		energy_required = 0.5,
		ingredients =
		{
			{"iron-plate", 1}
		},
		result = "wind_turbine"
	},



	{
		type = "generator",
		name = "wind_turbine",
		icon = "__WindPower__/windTurbine/img/icon.png",
		flags = {"placeable-neutral","player-creation"},
		minable = {mining_time = 1, result = "wind_turbine"},
		max_health = 300,
		corpse = "big-remnants",
		dying_explosion = "medium-explosion",
		effectivity = config.TURBINE_MAX_POWER,
		fluid_usage_per_tick = config.EFF_TO_KW_RATIO,
		resistances = {
			{
				type = "fire",
				percent = 80
			}
		},
		collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},

		drawing_box = {{-1.5, -5.5}, {0.5, 0.5}},

		fluid_box = {
			base_area = 1,
			pipe_covers = pipecoverspictures(),
			pipe_connections = {},
		},
		energy_source = {
			type = "electric",
			usage_priority = "secondary-output"
		},
		horizontal_animation = animation,
		vertical_animation = animation,

		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		working_sound = {
			sound = {
				filename = "__WindPower__/windTurbine/wind_turbine.ogg",
				volume = 1.0
			},
			match_speed_to_activity = true,
		},
		min_perceived_performance = 0.25,
		performance_to_sound_speedup = 0.15,
	},

})