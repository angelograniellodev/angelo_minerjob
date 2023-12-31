RegisterServerEvent('angelo_minerjob:getItem')
AddEventHandler('angelo_minerjob:getItem', function(itemname, count, porcent_probability)
    local xPlayer = ESX.GetPlayerFromId(source)
    if math.random(0, 100) <= porcent_probability then
        xPlayer.addInventoryItem(itemname, count)
        if Config.CustomSounds then
            TriggerClientEvent("playBreakRock", source)
        end
    end
end)

RegisterServerEvent('angelo_minerjob:chekitemPickaxe')
AddEventHandler('angelo_minerjob:chekitemPickaxe', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local oneQuantity = xPlayer.getInventoryItem(Config.ItemsMining.pickaxe).count

	if oneQuantity > 0 then
		TriggerClientEvent('itemPickaxeverify', source, true) -- true
	else
		TriggerClientEvent('itemPickaxeverify', source, false) -- false
	end
end)

RegisterServerEvent('angelo_minerjob:chekitemDrill')
AddEventHandler('angelo_minerjob:chekitemDrill', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local oneQuantity = xPlayer.getInventoryItem(Config.ItemsMining.drill).count

	if oneQuantity > 0 then
		TriggerClientEvent('itemDrillverify', source, true) -- true
	else
		TriggerClientEvent('itemDrillverify', source, false) -- false
	end
end)

RegisterServerEvent('angelo_minerjob:get:wash:ore')
AddEventHandler('angelo_minerjob:get:wash:ore', function(requestitem, request_item_count, reward_item, reward_item_count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local oneQuantity = xPlayer.getInventoryItem(requestitem).count

	if oneQuantity >= request_item_count then
        xPlayer.removeInventoryItem(requestitem, request_item_count)
        xPlayer.addInventoryItem(reward_item, reward_item_count)
	else
        NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.no_item_washing_ore, "error")
	end
end)

RegisterServerEvent('angelo_minerjob:get:oven:ore')
AddEventHandler('angelo_minerjob:get:oven:ore', function(requestitem, request_item_count, reward_item, reward_item_count, coalitem, coalitemcount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local oneQuantity = xPlayer.getInventoryItem(requestitem).count
    local coalQuantity = xPlayer.getInventoryItem(coalitem).count
    if coalQuantity >= coalitemcount then 
        if oneQuantity >= request_item_count then
            xPlayer.addInventoryItem(coalitem, coalitemcount)
            xPlayer.removeInventoryItem(requestitem, request_item_count)
            xPlayer.addInventoryItem(reward_item, reward_item_count)
        else
            NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.nogoldoreitem, "error")
        end
    else 
        NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.nocoalitem, "error")
    end
end)

RegisterServerEvent('angelo_minerjob:get:cutting:items')
AddEventHandler('angelo_minerjob:get:cutting:items', function(item, rewarditem)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemQuantity = xPlayer.getInventoryItem(item).count
    print(item)
    if itemQuantity >= 5 then
        TriggerClientEvent("succes-cut-checking", source, item)
        xPlayer.removeInventoryItem(item, 5)
        if item == "uncut_silver" then 
        xPlayer.addInventoryItem("silverore", 1)
        elseif item == "uncut_diamond" then
            xPlayer.addInventoryItem("diamond", 1)
        elseif item == "uncut_emerald" then
            xPlayer.addInventoryItem("emerald", 1)
        elseif item == "uncut_ruby" then
            xPlayer.addInventoryItem("ruby", 1)
        end
    else 
        NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.noitemcut, "error")
        TriggerClientEvent("succes-cut-checking", source, "none")
    end
end)


-- For Soon uptdates: 

-- RegisterServerEvent('angelo_minerjob:destroyRandomItem')
-- AddEventHandler('angelo_minerjob:destroyRandomItem', function(itemname, count, porcent_probability)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     if math.random(0, 100) <= porcent_probability then
--         xPlayer.addInventoryItem(itemname, count)
--     end
-- end)