data:extend({

	--Item
	{
		type = "item",
		name = "wind-detector",
		icon = "__wind-power__/graphics/icons/windsock.png",
		flags = { "goes-to-quickbar" },
		subgroup = "circuit-network",
		place_result="wind-detector",
		order = "b[combinators]-c[wind-detector]",
		stack_size= 50,
	},

	--Recipe
	{
		type = "recipe",
		name = "wind-detector",
		icon = "__wind-power__/graphics/icons/windsock.png",
		energy_required = 1.0,
		enabled = true,
		ingredients =
		{
			{"raw-wood", 1},
			--{"constant-combinator", 1},
			--{"advanced-circuit", 5}
		},
		result = "wind-detector"
	},

	--Entity
	{
		type = "constant-combinator",
		name = "wind-detector",
		icon = "__base__/graphics/icons/constant-combinator.png",
		flags = {"placeable-neutral", "player-creation"},
		open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
		close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
		minable = {hardness = 0.2, mining_time = 0.5, result = "wind-detector"},
		max_health = 50,
		corpse = "small-remnants",
		render_layer = "object",

		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},

		item_slot_count = 1,

		sprite ={
			filename = "__wind-power__/graphics/entity/wind-detector.png",
			x = 61,
			width = 61,
			height = 50,
			shift = {0.078125, 0.15625},
		},
		circuit_wire_connection_point =
		{
			shadow =
			{
				red = {0.828125, 0.328125},
				green = {0.828125, -0.078125},
			},
			wire =
			{
				red = {0.515625, -0.078125},
				green = {0.515625, -0.484375},
			}
		},
		circuit_wire_max_distance = 7.5
	},




	--Wind icons for circuit network

	{
		type = "item-subgroup",
		name = "virtual-signal-info",
		group = "signals",
		order = "c"
	},
	{
		type = "virtual-signal",
		name = "signal-wind-direction",
		icon = "__wind-power__/graphics/icons/direction-signal.png",
		subgroup = "virtual-signal-info",
		order = "z[wind-a]",
	},
	{
		type = "virtual-signal",
		name = "signal-wind-strength",
		icon = "__wind-power__/graphics/icons/strength-signal.png",
		subgroup = "virtual-signal-info",
		order = "z[wind-a]",
	},

})