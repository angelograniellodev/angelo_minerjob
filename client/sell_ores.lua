Citizen.CreateThread(function()
    while true do
        local closeTo = 0
        for k, v in pairs(Config.SellOresPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 1.5 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 1.5 do
                Wait(0)
                pedCoordsTextUi = GetEntityCoords(PlayerPedId())
                HelpFloating(closeTo.ui_text, vector3(pedCoordsTextUi.x, pedCoordsTextUi.y, pedCoordsTextUi.z))
                if IsControlJustReleased(0, 38) then
                    SellMenu()
                end
            end
        end
        Wait(250)
    end
end)

function SellMenu()
	local elements = {}
	for k,v in pairs(Config.SellItems) do
		table.insert(elements, {label = v.label .. ' | $' .. v.price, item = k, type = 'slider', value = v.min, min = v.min, max = v.max})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sellitems_minerjob', {
        title    = 'Pawnshop',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
		TriggerServerEvent('angelo_minerjob:sellores', data.current.item, data.current.value)
    end, function(data, menu)
        menu.close()
    end) 
end