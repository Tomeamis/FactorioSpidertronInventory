SpiderName = "spidertron"

function AddSpider(spider)
	local regNum = script.register_on_entity_destroyed(spider)
	global.Spiders[regNum] = spider
end

script.on_init(function()
	local spiders = game.surfaces.nauvis.find_entities_filtered{name=SpiderName}
	global.Spiders = {}
	for _, spider in pairs(spiders) do
		AddSpider(spider)
	end
end)

function OnTick()
	for _, spider in pairs(global.Spiders) do
		local inventory = spider.get_inventory(defines.inventory.spider_trunk)
		inventory.sort_and_merge()
	end
end

script.on_nth_tick(60, OnTick)

script.on_event(defines.events.on_built_entity, function(event)
	if event.created_entity.name == SpiderName
	then
		AddSpider(event.created_entity)
	end
end)

script.on_event(defines.events.on_entity_destroyed, function (event)
	global.Spiders[event.registration_number] = nil
end)

script.on_event(
	defines.events.on_player_mined_entity,
	function(event)
		for key, spider in pairs(global.Spiders) do
			if spider == event.entity then
				global.Spiders[key] = nil
			end
		end
	end,
	{{filter = "name", name = SpiderName}}
)