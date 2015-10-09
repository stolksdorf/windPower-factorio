require "config"
require "defines"


function handleEntityBuilt(mod, event)
	if mod.blueprints[event.created_entity.name]~= nil then
		local tab = mod.entities[event.created_entity.name]
		table.insert(tab,mod.blueprints[event.created_entity.name].onPlace(event.created_entity))
		mod.entities[event.created_entity.name] = tab
	end
	return mod
end

function handleEntityRemoved(mod, event)
	if mod.blueprints[event.entity.name]~= nil then
		for index, entity in ipairs(mod.entities[event.entity.name]) do
			if entity==event.entity then
				local tab = mod.entities[event.entity.name]
				table.remove(tab,index)
				mod.blueprints[event.entity.name].onDestroy(v)
				mod.entities[event.entity.name] = tab
				break
			end
		end
	end
	return mod
end

function handleOnTick(mod, event)
	--game.player.print("--")
	--game.player.print(count(mod.blueprints))
	--game.player.print(count(mod.entities))
	for name, blueprint in pairs(mod.blueprints) do
		for index, entity in pairs(mod.entities[name]) do
			if entity.valid then
				blueprint.onTick(entity, event)
			end
		end
	end
	return mod
end

function handleOnLoad(mod)
	mod.entities = global.windPowerEntities or {}
	for name,blueprint in pairs(mod.blueprints) do
		mod.entities[name] = mod.entities[name] or {}
	end
	return mod
end
