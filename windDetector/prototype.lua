local config = require "config"

local animation = {
	filename = "__WindPower__/windDetector/img/animation.png",
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
		name = "wind_detector",
		icon = "__WindPower__/windDetector/img/icon.png",
		flags = {"goes-to-quickbar"},
		subgroup = "energy",
		order = "e[accumulator]-a[solar-panel]",
		place_result = "wind_detector",
		stack_size = 50
	},

	-- Recipe
	{
		type = "recipe",
		name = "wind_detector",
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"copper-cable", 5},
			{"iron-stick", 1},
			{"electronic-circuit", 2}
		},
		result = "wind_detector"
	},

	--REMOVE AFTER TESTING
	{
		type = "recipe",
		name = "wind_detector_TEST",
		enabled = true,
		energy_required = 0.5,
		ingredients =
		{
			{"iron-plate", 1}
		},
		result = "wind_detector"
	},




	--Main Entity
	{
		type = "generator",
		name = "wind_detector",
		icon = "__WindPower__/windDetector/img/icon.png",
		flags = {"placeable-neutral","player-creation"},
		minable = {mining_time = 1, result = "wind_detector"},
		max_health = 50,
		corpse = "big-remnants",
		dying_explosion = "medium-explosion",
		effectivity = config.DETECTOR_MAX_POWER,
		fluid_usage_per_tick = config.EFF_TO_KW_RATIO,
		resistances = {
			{
				type = "fire",
				percent = 80
			}
		},
		collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

		--drawing_box = {{-1.5, -5.5}, {0.5, 0.5}},

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
				filename = "__WindPower__/windDetector/wind_turbine.ogg",
				volume = 1.0
			},
			match_speed_to_activity = true,
		},
		min_perceived_performance = 0.25,
		performance_to_sound_speedup = 0.15,
	},

	-- Hidden Entity for emitting signal
	{
		type = "constant-combinator",
		name = "wind_detector_sensor",
		icon = "__base__/graphics/icons/constant-combinator.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "wind_detector"},
		max_health = 0,
		corpse = "small-remnants",

		order = "e[accumulator]-a[solar-panel]",

		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

		item_slot_count = 15,

		sprite = {
			filename = "__base__/graphics/entity/combinator/constanter.png",
			x = 0,
			width = 0,
			height = 0,
			shift = {0, 0},
		},
		circuit_wire_connection_point = {
			shadow = {
				red = {0.828125, 0.328125},
				green = {0.828125, -0.078125},
			},
			wire = {
				red = {0.515625, -0.078125},
				green = {0.515625, -0.484375},
			}
		},
		circuit_wire_max_distance = 7.5
	},



	--Wind icons for circuit network
	{
		type = "item-subgroup",
		name = "virtual_signal_wind",
		group = "signals",
		order = "c"
	},
	{
		type = "virtual-signal",
		name = "signal_wind_direction",
		icon = "__WindPower__/windDetector/img/direction-signal.png",
		subgroup = "virtual_signal_wind",
		order = "z[wind-a]",
	},
	{
		type = "virtual-signal",
		name = "signal_wind_speed",
		icon = "__WindPower__/windDetector/img/strength-signal.png",
		subgroup = "virtual_signal_wind",
		order = "z[wind-a]",
	},

})