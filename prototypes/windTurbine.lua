data:extend({

	{
		type = "item",
		name = "wind-turbine",
		icon = "__wind-power__/graphics/icons/turbine.png",
		flags = {"goes-to-quickbar"},
		subgroup = "energy",
		order = "e[accumulator]-a[basic-accumulator]",
		place_result = "wind-turbine",
		stack_size = 32
	},

	-- Recipe
	{
		type = "recipe",
		name = "wind-turbine",
		enabled = true,
		--energy_required = 5,
		energy_required = 0.5,
		ingredients =
		{
			--[[
			{"iron-gear-wheel", 10},
			{"steel-plate", 10},
			{"electronic-circuit", 5}
			]]--
			{"iron-plate", 1}
		},
		result = "wind-turbine"
	},



	{
		type = "generator",
		name = "wind-turbine",
		icon = "__base__/graphics/icons/steam-engine.png",
		flags = {"placeable-neutral","player-creation"},
		minable = {mining_time = 1, result = "wind-turbine"},
		max_health = 300,
		corpse = "big-remnants",
		dying_explosion = "medium-explosion",
		effectivity = 1,
		fluid_usage_per_tick = 0.1,
		resistances =
		{
			{
				type = "fire",
				percent = 80
			}
		},
		collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
		selection_box = {{-2, -2}, {2, 2}},

		--tile_width = 2,
		--tile_height = 2,

		fluid_box =
		{
			base_area = 1,
			pipe_covers = pipecoverspictures(),
			pipe_connections =
			{

			},
		},
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-output"
		},
		horizontal_animation =
		{

			filename = "__wind-power__/graphics/entity/wind-turbine-animation.png",
			width = 327,
			height = 250,
			priority = "extra-high",
			shift = {3.5, -5.5},
			animation_speed = 0.5,

			frame_count = 24,
			line_length = 6,

		},
		vertical_animation =
		{
			filename = "__wind-power__/graphics/entity/wind-turbine-animation.png",
			width = 327,
			height = 250,
			priority = "extra-high",
			shift = {3.5, -5.5},
			animation_speed = 0.5,

			frame_count = 24,
			line_length = 6,

		},

		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		working_sound =
		{
			sound =
			{
				filename = "__wind-power__/sound/wind-turbine.ogg",
				volume = 0.75
			},
			match_speed_to_activity = true,
		},
		min_perceived_performance = 0.1,
		performance_to_sound_speedup = 0.25
	},






--[[

	--Entity
	{
		type = "accumulator",
		name = "wind-turbine",
		icon = "__wind-power__/graphics/icons/turbine.png",
		flags = {"placeable-neutral", "player-creation"},
		minable = {hardness = 0.2, mining_time = 0.5, result = "wind-turbine"},
		max_health = 150,
		corpse = "medium-remnants",
		collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
		selection_box = {{-2, -2}, {2, 2}},
		energy_source =
		{
			type = "electric",
			buffer_capacity = "10000kW",
			usage_priority = "terciary",
			input_flow_limit = "0kW",
			output_flow_limit = "30000kW"
		},
		picture =
		{
			filename = "__wind-power__/graphics/entity/wind-turbine.png",
			width = 450,
			height = 393,
			priority = "extra-high",
			shift = {3.5, -5.5}
		},
		charge_animation =
		{
			filename = "__base__/graphics/entity/basic-accumulator/basic-accumulator-charge-animation.png",
			width = 138,
			height = 135,
			line_length = 8,
			frame_count = 24,
			shift = {0.482, -0.638},
			animation_speed = 0.5
		},
		charge_cooldown = 0,
		charge_light = {intensity = 0, size = 0},
		discharge_animation =
		{
			filename = "__base__/graphics/entity/basic-accumulator/basic-accumulator-discharge-animation.png",
			width = 147,
			height = 128,
			line_length = 8,
			frame_count = 24,
			shift = {0.395, -0.525},
			animation_speed = 0.5
		},
		discharge_cooldown = 0,
		discharge_light = {intensity = 0, size = 0},
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		working_sound =
		{
			sound =
			{
				filename = "__base__/sound/accumulator-working.ogg",
				volume = 1
			},
			idle_sound = {
				filename = "__base__/sound/accumulator-idle.ogg",
				volume = 0.4
			},
			max_sounds_per_type = 5
		},
	},

]]--

})