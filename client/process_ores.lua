local washingOre = false
local ovenOre = false
local cuttingOre = false

--Washing
Citizen.CreateThread(function()
    while true do
        local closeTo = 0
        for k, v in pairs(Config.WashPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 5.0 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 5.0 do
                Wait(0)
                pedCoordsTextUi = GetEntityCoords(PlayerPedId())
                if Config.Central.onDuty then 
                HelpFloating(closeTo.ui_text, vector3(pedCoordsTextUi.x, pedCoordsTextUi.y, pedCoordsTextUi.z))
                end
                if IsControlJustReleased(0, 38) and not washingOre and Config.Central.onDuty then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 4.0 then
                        washingOre = true
                        while not HasAnimDictLoaded(closeTo.anim_dict) do
                            Wait(0)
                            RequestAnimDict(closeTo.anim_dict)
                        end
                        TaskPlayAnim(
                            PlayerPedId(),
                            closeTo.anim_dict,
                            closeTo.anim_base,
                            8.0,
                            -8.0,
                            -1,
                            2,
                            0,
                            false,
                            false,
                            false
                        )
                        local model = loadModel(GetHashKey(closeTo.prop))
                        local bowl = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                        AttachEntityToEntity(
                            bowl,
                            PlayerPedId(),
                            GetPedBoneIndex(PlayerPedId(), closeTo.propbone),
                            closeTo.PropPlacement[1], -- X
                            closeTo.PropPlacement[2], -- Y
                            closeTo.PropPlacement[3], -- Z
                            closeTo.PropPlacement[4], -- Pitch
                            closeTo.PropPlacement[5], -- Roll
                            closeTo.PropPlacement[6], -- Yaw
                            false,
                            true,
                            true,
                            true,
                            0,
                            true
                        )
                        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'easy'}, {'w', 'a', 's', 'd'})
                        if success then 
                           washingOre = false
                           ClearPedTasks(PlayerPedId())
                           DeleteObject(bowl)
                           NotifyClient(ConfigLocales.title_notify, ConfigLocales.success_skill_wash_ore, "success")
                           TriggerServerEvent("angelo_minerjob:get:wash:ore", closeTo.request_item, closeTo.request_item_count, closeTo.reward_item, closeTo.reward_item_count)
                        else
                            washingOre = false
                            ClearPedTasks(PlayerPedId())
                            DeleteObject(bowl)
                            NotifyClient(ConfigLocales.title_notify, ConfigLocales.error_skill_wash_ore, "error")
                        end                        
                    end
                end
            end
        end
        Wait(250)
    end
end)

--Oven

Citizen.CreateThread(function()
    while true do
        local closeTo = 0
        for k, v in pairs(Config.OvenPositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 1.5 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 1.5 do
                Wait(0)
                pedCoordsTextUi = GetEntityCoords(PlayerPedId())
                if Config.Central.onDuty then 
                HelpFloating(closeTo.ui_text, vector3(pedCoordsTextUi.x, pedCoordsTextUi.y, pedCoordsTextUi.z))
                end
                if IsControlJustReleased(0, 38) and not washingOre and Config.Central.onDuty then
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance == -1 or distance >= 1.5 then  
                        ovenOre = true
                        FreezeEntityPosition(PlayerPedId(), true)
                        SetEntityCoords(PlayerPedId(), closeTo.coords.x, closeTo.coords.y, closeTo.coords.z)
                        SetEntityHeading(PlayerPedId(), closeTo.heading)
                        Citizen.Wait(20)
                        TaskPlayAnim(
                            PlayerPedId(),
                            closeTo.anim_dict,
                            closeTo.anim_base,
                            8.0,
                            -8.0,
                            -1,
                            2,
                            0,
                            false,
                            false,
                            false
                        )
                        Citizen.Wait(950)
                        ClearPedTasks(PlayerPedId())
                        if lib.progressBar({
                            duration = closeTo.progressbar_duration,
                            label = closeTo.progressbar_label,
                            useWhileDead = false,
                            canCancel = false,
                            disable = {
                                car = true,
                            },
                        }) then 
                            ovenOre = false 
                            FreezeEntityPosition(PlayerPedId(), false)
                            TaskPlayAnim(
                                PlayerPedId(),
                                closeTo.anim_dict,
                                closeTo.anim_base,
                                8.0,
                                -8.0,
                                -1,
                                2,
                                0,
                                false,
                                false,
                                false
                            ) 
                            Citizen.Wait(950)
                            ClearPedTasks(PlayerPedId())
                            Citizen.Wait(90)
                            TriggerServerEvent("angelo_minerjob:get:oven:ore", closeTo.request_item, closeTo.request_item_count, closeTo.reward_item, closeTo.reward_item_count, closeTo.request_item_coal, closeTo.request_item_coal_count)
                        else 
                            ovenOre = false 
                            FreezeEntityPosition(PlayerPedId(), false) 
                        end
                    end
                end
            end
        end
        Wait(250)
    end
end)

--Cut ores

Citizen.CreateThread(function()
    while true do
        local closeTo = 0
        for k, v in pairs(Config.CutMachinePositions) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 1.5 then
                closeTo = v
                break
            end
        end
        if type(closeTo) == 'table' then
            while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 1.5 do
                Wait(0)
                pedCoordsTextUi = GetEntityCoords(PlayerPedId())
                if Config.Central.onDuty and not cuttingOre then 
                HelpFloating(closeTo.ui_text, vector3(pedCoordsTextUi.x, pedCoordsTextUi.y, pedCoordsTextUi.z))
                end
                if IsControlJustReleased(0, 38) and not cuttingOre and Config.Central.onDuty then
                    SendNUIMessage({
                        type = "showNUIMachine",
                    })
                    SetNuiFocus(true,true)
                    SetEntityCoords(PlayerPedId(), closeTo.coords.x, closeTo.coords.y, closeTo.coords.z)
                    SetEntityHeading(PlayerPedId(), closeTo.heading)
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            end
        end
        Wait(250)
    end
end)

RegisterNUICallback('cuttore', function(data)
    TriggerServerEvent("angelo_minerjob:get:cutting:items", data.data)
end)

RegisterNUICallback('nuioff', function(data)
	SetNuiFocus(false,false)
end)

RegisterNetEvent(
    "succes-cut-checking",
    function(item)
        print(item)
        if item == "uncut_silver" and not cuttingOre then 
            cuttingOre = true
            SetNuiFocus(false,false)
            while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                Wait(0)
                RequestAnimDict("anim@mp_player_intmenu@key_fob@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@mp_player_intmenu@key_fob@", "fob_click",8.0,-8.0,-1,2,0,false,false,false)
            SetNuiFocus(false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("gestures@f@standing@casual") do
                Wait(0)
                RequestAnimDict("gestures@f@standing@casual")
            end
            TaskPlayAnim(PlayerPedId(),"gestures@f@standing@casual", "gesture_point",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("anim@amb@casino@valet_scenario@pose_a@") do
                Wait(0)
                RequestAnimDict("anim@amb@casino@valet_scenario@pose_a@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@amb@casino@valet_scenario@pose_a@", "base_a_m_y_vinewood_01",8.0,-8.0,-1,2,0,false,false,false)
            local x, y, z = 2944.5083, 2744.10425, 43.4130721
            local obj = CreateObject(GetHashKey('bzzz_prop_mine_silver_b'), x, y, z, true, true, true)
            SetEntityRotation(obj, 0.0, 0.0, 0.0, 1, true)
            FreezeEntityPosition(obj, true)
            cuttingOreParticle = true 
            particlesPos = GetEntityCoords(obj)
            Citizen.Wait(3220)
            while not HasAnimDictLoaded("mp_common") do
                Wait(0)
                RequestAnimDict("mp_common")
            end
            TaskPlayAnim(PlayerPedId(),"mp_common", "givetake1_a",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            FreezeEntityPosition(obj, false)
            DeleteObject(obj)
            cuttingOre = false
            cuttingOreParticle = false
        elseif item == "uncut_diamond" and not cuttingOre then 
            cuttingOre = true
            SetNuiFocus(false,false)
            while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                Wait(0)
                RequestAnimDict("anim@mp_player_intmenu@key_fob@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@mp_player_intmenu@key_fob@", "fob_click",8.0,-8.0,-1,2,0,false,false,false)
            SetNuiFocus(false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("gestures@f@standing@casual") do
                Wait(0)
                RequestAnimDict("gestures@f@standing@casual")
            end
            TaskPlayAnim(PlayerPedId(),"gestures@f@standing@casual", "gesture_point",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("anim@amb@casino@valet_scenario@pose_a@") do
                Wait(0)
                RequestAnimDict("anim@amb@casino@valet_scenario@pose_a@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@amb@casino@valet_scenario@pose_a@", "base_a_m_y_vinewood_01",8.0,-8.0,-1,2,0,false,false,false)
            local x, y, z = 2944.5083, 2744.10425, 43.4130721
            local obj = CreateObject(GetHashKey('bzzz_prop_mine_diamond_b'), x, y, z, true, true, true)
            SetEntityRotation(obj, 0.0, 0.0, 0.0, 1, true)
            FreezeEntityPosition(obj, true)
            cuttingOreParticle = true 
            particlesPos = GetEntityCoords(obj)
            Citizen.Wait(3220)
            while not HasAnimDictLoaded("mp_common") do
                Wait(0)
                RequestAnimDict("mp_common")
            end
            TaskPlayAnim(PlayerPedId(),"mp_common", "givetake1_a",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            FreezeEntityPosition(obj, false)
            DeleteObject(obj)
            cuttingOre = false
            cuttingOreParticle = false
        elseif item == "uncut_emerald" and not cuttingOre then 
            cuttingOre = true
            SetNuiFocus(false,false)
            while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                Wait(0)
                RequestAnimDict("anim@mp_player_intmenu@key_fob@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@mp_player_intmenu@key_fob@", "fob_click",8.0,-8.0,-1,2,0,false,false,false)
            SetNuiFocus(false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("gestures@f@standing@casual") do
                Wait(0)
                RequestAnimDict("gestures@f@standing@casual")
            end
            TaskPlayAnim(PlayerPedId(),"gestures@f@standing@casual", "gesture_point",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("anim@amb@casino@valet_scenario@pose_a@") do
                Wait(0)
                RequestAnimDict("anim@amb@casino@valet_scenario@pose_a@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@amb@casino@valet_scenario@pose_a@", "base_a_m_y_vinewood_01",8.0,-8.0,-1,2,0,false,false,false)
            local x, y, z = 2944.5083, 2744.10425, 43.4130721
            local obj = CreateObject(GetHashKey('bzzz_prop_mine_emerald_b'), x, y, z, true, true, true)
            SetEntityRotation(obj, 0.0, 0.0, 0.0, 1, true)
            FreezeEntityPosition(obj, true)
            cuttingOreParticle = true 
            particlesPos = GetEntityCoords(obj)
            Citizen.Wait(3220)
            while not HasAnimDictLoaded("mp_common") do
                Wait(0)
                RequestAnimDict("mp_common")
            end
            TaskPlayAnim(PlayerPedId(),"mp_common", "givetake1_a",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            FreezeEntityPosition(obj, false)
            DeleteObject(obj)
            cuttingOre = false
            cuttingOreParticle = false
        elseif item == "uncut_ruby" and not cuttingOre then 
            cuttingOre = true
            SetNuiFocus(false,false)
            while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                Wait(0)
                RequestAnimDict("anim@mp_player_intmenu@key_fob@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@mp_player_intmenu@key_fob@", "fob_click",8.0,-8.0,-1,2,0,false,false,false)
            SetNuiFocus(false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("gestures@f@standing@casual") do
                Wait(0)
                RequestAnimDict("gestures@f@standing@casual")
            end
            TaskPlayAnim(PlayerPedId(),"gestures@f@standing@casual", "gesture_point",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            while not HasAnimDictLoaded("anim@amb@casino@valet_scenario@pose_a@") do
                Wait(0)
                RequestAnimDict("anim@amb@casino@valet_scenario@pose_a@")
            end
            TaskPlayAnim(PlayerPedId(),"anim@amb@casino@valet_scenario@pose_a@", "base_a_m_y_vinewood_01",8.0,-8.0,-1,2,0,false,false,false)
            local x, y, z = 2944.5083, 2744.10425, 43.4130721
            local obj = CreateObject(GetHashKey('bzzz_prop_mine_ruby_b'), x, y, z, true, true, true)
            SetEntityRotation(obj, 0.0, 0.0, 0.0, 1, true)
            FreezeEntityPosition(obj, true)
            cuttingOreParticle = true 
            particlesPos = GetEntityCoords(obj)
            Citizen.Wait(3220)
            while not HasAnimDictLoaded("mp_common") do
                Wait(0)
                RequestAnimDict("mp_common")
            end
            TaskPlayAnim(PlayerPedId(),"mp_common", "givetake1_a",8.0,-8.0,-1,2,0,false,false,false)
            Citizen.Wait(1200)
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            FreezeEntityPosition(obj, false)
            DeleteObject(obj)
            cuttingOre = false
            cuttingOreParticle = false
        elseif item == "none" then
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
            cuttingOre = false
            cuttingOreParticle = false
            SetNuiFocus(false, false)
        end
    end
)

while true do
    if cuttingOreParticle then
        Citizen.Wait(1)
        UseParticleFxAssetNextCall("core")
        Wait(200)
        local dust =
            StartNetworkedParticleFxNonLoopedAtCoord(
            "ent_dst_rocks",
            particlesPos.x,
            particlesPos.y,
            particlesPos.z,
            0.0,
            0.0,
            0.0,
            0.4,
            0.0,
            0.0,
            0.0
        )
        Wait(350)
    else
        Citizen.Wait(950)
    end
end