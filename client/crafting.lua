local onCrafting = false

Citizen.CreateThread(function()
    while true do
        local closeTo = 0
        for k, v in pairs(Config.CraftingPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 1.5 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 1.5 do
                Wait(0)
                pedCoordsTextUi = GetEntityCoords(PlayerPedId())
                if Config.Central.onDuty and not onCrafting then 
                HelpFloating(closeTo.ui_text, vector3(pedCoordsTextUi.x, pedCoordsTextUi.y, pedCoordsTextUi.z))
                end
                if IsControlJustReleased(0, 38) and not onCrafting and  Config.Central.onDuty then
                    CraftingMenu()
                    SetEntityCoords(PlayerPedId(), closeTo.coords.x, closeTo.coords.y, closeTo.coords.z-1)
                    SetEntityHeading(PlayerPedId(),closeTo.heading)
                end
            end
        end
        Wait(250)
    end
end)

function CraftingMenu()
	local elements = {}
	for k,v in pairs(Config.ItemsCrafting) do
		table.insert(elements, {label = v.label, value = k})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_menu', {
        title    = ConfigLocales.title_craft_menu,
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
		CheckCrafting(data.current.value)
    end, function(data, menu)
        menu.close()
    end) 
end

function CheckCrafting(item)
	local elements = {
        { label = ConfigLocales.viewrecipe_menu, value = "view_recipe" },
        { label = ConfigLocales.craftitem_menu, value = "craft_item" },
    }
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_info', {
        title    = Config.ItemsCrafting[item].label .. ' Crafting Information',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()

        if data.current.value == "view_recipe" then
			ViewRecipe(item)
        elseif data.current.value == "craft_item" then
			TriggerServerEvent('angelo_minerjob:checkCrafting', item)
        end

    end, function(data, menu)
        menu.close()
    end)  
end

function ViewRecipe(item)
	local elements = {}
	for k,v in pairs(Config.ItemsCrafting[item].requiredItems) do
		table.insert(elements, {label = v.amount ..'x ' ..v.item_label})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_recipe', {
        title    = Config.ItemsCrafting[item].label .. ' Recipe',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
    end, function(data, menu)
        menu.close()
    end) 
end

RegisterNetEvent('angelo_minerjob:startCrafting')
AddEventHandler('angelo_minerjob:startCrafting', function(item)
    loadAnimDict('amb@prop_human_parking_meter@male@idle_a')
    TaskPlayAnim(GetPlayerPed(-1), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
    onCrafting = true
    if lib.progressBar({
        duration = 5000,
        label = ConfigLocales.progressBarCrafting,
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    }) then 
        onCrafting = false
        TriggerServerEvent('angelo_minerjob:giveCraftedItem', item)
        ClearPedTasks(PlayerPedId())
    end
end)
