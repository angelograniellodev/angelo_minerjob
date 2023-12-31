RegisterServerEvent('angelo_minerjob:sellores')
AddEventHandler('angelo_minerjob:sellores', function(itemName, itemAmount)
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	local priceMultiplier = Config.SellItems[itemName].price * itemAmount
	
	if xPlayer.getInventoryItem(itemName).count >= itemAmount then
		xPlayer.addMoney(priceMultiplier)
		xPlayer.removeInventoryItem(itemName, itemAmount)
        NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.success_sell_notify, "success")
	else
        NotifyServer(source, ConfigLocales.title_notify, ConfigLocales.noitems_sell_notify, "error")
	end
end)