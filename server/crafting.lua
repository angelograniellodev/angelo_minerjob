RegisterServerEvent('angelo_minerjob:checkCrafting')
AddEventHandler('angelo_minerjob:checkCrafting', function(itemId)
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	local getPlayerInv = xPlayer.getInventoryItem()
	local requiredItems = Config.ItemsCrafting[itemId].requiredItems
	local canCraft = false
	
	for k,v in pairs(requiredItems) do
		if xPlayer.getInventoryItem(v.item).count >= v.amount then
			canCraft = true
		else
			canCraft = false
			break
		end
	end
	
	if canCraft then
		TriggerClientEvent('angelo_minerjob:startCrafting', xPlayer.source, itemId)
	else
        NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.noitemscrafting, "error")
	end
end)

RegisterServerEvent('angelo_minerjob:giveCraftedItem')
AddEventHandler('angelo_minerjob:giveCraftedItem', function(itemId)
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	local requiredItems = Config.ItemsCrafting[itemId].requiredItems
	for k,v in pairs(requiredItems) do
		xPlayer.removeInventoryItem(v.item, v.amount)
	end
	xPlayer.addInventoryItem(itemId, 1)
    NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.craftingsuccess, "success")
end)