--OLD ESX FRAMEWORK
if Config.ESXOLD then 
    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end
    
        PlayerData = ESX.GetPlayerData()
        esxloaded = true
    end)
end

local onSpawnedVehicle = false

local mining = false
local pickaxeItem = false

local drilling = false
local drilliItem = false
LaserDrill = {
    ["animations"] = {
        {"intro", "bag_intro", "intro_drill_bit"},
        {"drill_straight_start", "bag_drill_straight_start", "drill_straight_start_drill_bit"},
        {"drill_straight_end_idle", "bag_drill_straight_idle", "drill_straight_idle_drill_bit"},
        {"drill_straight_fail", "bag_drill_straight_fail", "drill_straight_fail_drill_bit"},
        {"drill_straight_end", "bag_drill_straight_end", "drill_straight_end_drill_bit"},
        {"exit", "bag_exit", "exit_drill_bit"}
    },
    ["scenes"] = {}
}

local fixvariables = false --Dont touch

--Check inventory items
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(950)
            TriggerServerEvent("angelo_minerjob:chekitemPickaxe")
            TriggerServerEvent("angelo_minerjob:chekitemDrill")
        end
    end
)

RegisterNetEvent(
    "itemPickaxeverify",
    function(itemPickaxe)
        if itemPickaxe then
            pickaxeItem = true
        else
            pickaxeItem = false
        end
    end
)

RegisterNetEvent(
    "itemDrillverify",
    function(itemDrill)
        if itemDrill then
            drilliItem = true
        else
            drilliItem = false
        end
    end
)

-- On and off Duty
local pointDuty =
    lib.points.new(
    {
        coords = Config.Central.coords,
        distance = Config.Central.distance
    }
)

function pointDuty:nearby()
    if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Job) then
        HelpFloating(Config.Central.text_ui, Config.Central.coords)
        if self.currentDistance < Config.Central.distance and IsControlJustReleased(0, 38) then
            if Config.Central.onDuty then
                Config.Central.onDuty = false
                ESX.TriggerServerCallback(
                    "esx_skin:getPlayerSkin",
                    function(skin)
                        TriggerEvent("skinchanger:loadSkin", skin)
                    end
                )
                playWardrobeAnimation()
                ESX.UI.Menu.CloseAll()
                ESX.Game.DeleteVehicle(Config.Garage.vehicle)
                NotifyClient(ConfigLocales.title_notify, ConfigLocales.offduty_notify, "info")
            else
                Config.Central.onDuty = true
                ESX.TriggerServerCallback(
                    "esx_skin:getPlayerSkin",
                    function(skin, jobSkin)
                        if skin.sex == 0 then
                            TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform.male)
                        elseif skin.sex == 1 then
                            TriggerEvent("skinchanger:loadClothes", skin, Config.Uniform.female)
                        end
                    end
                )
                playWardrobeAnimation()
                NotifyClient(ConfigLocales.title_notify, ConfigLocales.onduty_notify, "info")
            end
        end
    end
end

--Garage

local pointGarage =
    lib.points.new(
    {
        coords = Config.Garage.coords,
        distance = Config.Garage.distance
    }
)

function pointGarage:nearby()
    if Config.Central.onDuty then
        HelpFloating(Config.Garage.text_ui, GetEntityCoords(PlayerPedId()))
        DrawMarker(
            2,
            Config.Garage.coords.x,
            Config.Garage.coords.y,
            Config.Garage.coords.z,
            0.0,
            0.0,
            0.0,
            0.0,
            180.0,
            0.0,
            1.0,
            1.0,
            1.0,
            200,
            20,
            20,
            50,
            false,
            true,
            2,
            false,
            nil,
            nil,
            false
        )
        if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Job) and IsControlJustReleased(0, 38) then
            if onSpawnedVehicle then
                onSpawnedVehicle = false
                ESX.Game.DeleteVehicle(Config.Garage.vehicle)
                NotifyClient(ConfigLocales.title_notify, ConfigLocales.vehiclsaved_notify, "info")
            else
                onSpawnedVehicle = true
                ESX.Game.SpawnVehicle(
                    Config.Garage.spawn_code,
                    Config.Garage.coords,
                    Config.Garage.heading_spawn,
                    function(vehicle)
                        Config.Garage.vehicle = vehicle 
                        SetVehicleNumberPlateText(Config.Garage.vehicle, "ANG" .. tostring(math.random(1000, 9999)))
                        TaskWarpPedIntoVehicle(PlayerPedId(), Config.Garage.vehicle, -1)
                        SetVehicleEngineOn(Config.Garage.vehicle, true, true)
                        SetEntityHeading(Config.Garage.vehicle, Config.Garage.heading_spawn)
                    end
                )
                NotifyClient(ConfigLocales.title_notify, ConfigLocales.vehiclespawned_notify, "success")
            end
        end
    end
end

--General Mining

Citizen.CreateThread(
    function()
        while true do
            local closeTo = 0
            for k, v in pairs(Config.MiningPositions) do
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.coords, true) <= 2.5 then
                    closeTo = v
                    break
                end
            end
            if type(closeTo) == "table" and not Config.Central.onDuty then
                while GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), closeTo.coords, true) <= 1.7 do
                    Wait(0)
                    pedCoordsTextUi = GetEntityCoords(PlayerPedId())
                    HelpFloating(closeTo.ui_text, vector3(pedCoordsTextUi.x, pedCoordsTextUi.y, pedCoordsTextUi.z + 1))
                    if IsControlJustReleased(0, 38) then
                        if not fixvariables then
                            local player, distance = ESX.Game.GetClosestPlayer()
                            if distance == -1 or distance >= 4.0 then
                                if closeTo.type == "mining" then
                                    if pickaxeItem then
                                    mining = true
                                    SetEntityCoords(PlayerPedId(), closeTo.coords)
                                    SetEntityHeading(PlayerPedId(), closeTo.heading)
                                    FreezeEntityPosition(PlayerPedId(), true)

                                    local model = loadModel(GetHashKey(Config.Objects["pickaxe"]))
                                    local axe = CreateObject(model, GetEntityCoords(PlayerPedId()), true, false, false)
                                    AttachEntityToEntity(
                                        axe,
                                        PlayerPedId(),
                                        GetPedBoneIndex(PlayerPedId(), 57005),
                                        0.08,
                                        -0.04,
                                        -0.10,
                                        80.0,
                                        -20.0,
                                        175.0,
                                        false,
                                        true,
                                        true,
                                        true,
                                        0,
                                        true
                                    )
                                    while mining do
                                        Wait(0)
                                        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"))
                                        HelpFloating(closeTo.ui_text_help, GetEntityCoords(PlayerPedId()))
                                        DisableControlAction(0, 24, true)
                                        if IsDisabledControlJustReleased(0, 24) then
                                            if Config.CustomSounds then
                                                SendNUIMessage(
                                                    {
                                                        transactionType = "playSound",
                                                        transactionFile = "pickaxe",
                                                        transactionVolume = 0.9
                                                    }
                                                )
                                            end
                                            while not HasAnimDictLoaded("melee@large_wpn@streamed_core") do
                                                Wait(0)
                                                RequestAnimDict("melee@large_wpn@streamed_core")
                                            end
                                            TaskPlayAnim(
                                                PlayerPedId(),
                                                "melee@large_wpn@streamed_core",
                                                "ground_attack_on_spot",
                                                8.0,
                                                -8.0,
                                                -1,
                                                2,
                                                0,
                                                false,
                                                false,
                                                false
                                            )
                                            local timer = GetGameTimer() + 1020
                                            while GetGameTimer() <= timer do
                                                Wait(0)
                                                DisableControlAction(0, 24, true)
                                            end
                                            ClearPedTasks(PlayerPedId())
                                            itemCount = math.random(closeTo.item_count_minime, closeTo.item_count_max)
                                            TriggerServerEvent(
                                                "angelo_minerjob:getItem",
                                                closeTo.item_name,
                                                itemCount,
                                                closeTo.porcent_probability
                                            )
                                        elseif IsControlJustReleased(0, 194) then
                                            break
                                        end
                                    end
                                    mining = false
                                    DeleteObject(axe)
                                    FreezeEntityPosition(PlayerPedId(), false)
                                else
                                    NotifyClient(ConfigLocales.title_notify, ConfigLocales.noitempickaxe_notify, "error")
                                end
                                else
                                    if closeTo.type == "drill" then
                                        if drilliItem then 
                                        local ped = PlayerPedId()
                                        SetEntityHeading(ped, closeTo.heading)
                                        Citizen.Wait(10)
                                        local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
                                        local animDict = "anim_heist@hs3f@ig9_vault_drill@laser_drill@"
                                        loadAnimDict(animDict)
                                        local laserDrillModel = "ch_prop_laserdrill_01a"
                                        loadModel(laserDrillModel)

                                        laserDrill = CreateObject(GetHashKey(laserDrillModel), pedCo, 1, 0, 0)

                                        vaultPos = vector3(closeTo.coords.x, closeTo.coords.y, closeTo.coords.z)
                                        vaultRot =
                                            vector3(
                                            GetEntityRotation(ped).x,
                                            GetEntityRotation(ped).y,
                                            GetEntityRotation(ped).z
                                        )

                                        for i = 1, #LaserDrill["animations"] do
                                            LaserDrill["scenes"][i] =
                                                NetworkCreateSynchronisedScene(
                                                vaultPos,
                                                vaultRot,
                                                2,
                                                true,
                                                false,
                                                1065353216,
                                                0,
                                                1.3
                                            )
                                            NetworkAddPedToSynchronisedScene(
                                                ped,
                                                LaserDrill["scenes"][i],
                                                animDict,
                                                LaserDrill["animations"][i][1],
                                                4.0,
                                                -4.0,
                                                1033,
                                                0,
                                                1000.0,
                                                0
                                            )
                                            NetworkAddEntityToSynchronisedScene(
                                                laserDrill,
                                                LaserDrill["scenes"][i],
                                                animDict,
                                                LaserDrill["animations"][i][3],
                                                1.0,
                                                -1.0,
                                                1148846080
                                            )
                                        end

                                        NetworkStartSynchronisedScene(LaserDrill["scenes"][1])
                                        Wait(GetAnimDuration(animDict, "intro") * 1000)

                                        NetworkStartSynchronisedScene(LaserDrill["scenes"][2])
                                        PlayCamAnim(cam, "drill_straight_start_cam", animDict, vaultPos, vaultRot, 0, 2)
                                        Wait(GetAnimDuration(animDict, "drill_straight_start") * 1000)

                                        NetworkStartSynchronisedScene(LaserDrill["scenes"][3])
                                        PlayCamAnim(cam, "drill_straight_idle_cam", animDict, vaultPos, vaultRot, 0, 2)
                                        Citizen.Wait(10)
                                        drilling = true
                                        Drilling.Start(
                                            function(status)
                                                if status then
                                                    NetworkStartSynchronisedScene(LaserDrill["scenes"][5])
                                                    PlayCamAnim(
                                                        cam,
                                                        "drill_straight_end_cam",
                                                        animDict,
                                                        vaultPos,
                                                        vaultRot,
                                                        0,
                                                        2
                                                    )
                                                    Wait(GetAnimDuration(animDict, "drill_straight_end") * 1000)
                                                    NetworkStartSynchronisedScene(LaserDrill["scenes"][6])
                                                    PlayCamAnim(cam, "exit_cam", animDict, vaultPos, vaultRot, 0, 2)
                                                    Wait(GetAnimDuration(animDict, "exit") * 1000)
                                                    ClearPedTasks(ped)
                                                    DeleteObject(laserDrill)
                                                    SetEntityAlpha(vault, 0, 0)
                                                    SetEntityAlpha(vault, 255, 0)
                                                    drilling = false
                                                    TriggerServerEvent(
                                                        "angelo_minerjob:getItem",
                                                        closeTo.item_name,
                                                        itemCount,
                                                        closeTo.porcent_probability
                                                    )
                                                else
                                                    NetworkStartSynchronisedScene(LaserDrill["scenes"][4])
                                                    PlayCamAnim(
                                                        cam,
                                                        "drill_straight_fail_cam",
                                                        animDict,
                                                        vaultPos,
                                                        vaultRot,
                                                        0,
                                                        2
                                                    )
                                                    Wait(GetAnimDuration(animDict, "drill_straight_fail") * 1000 - 1500)
                                                    ClearPedTasks(ped)
                                                    DeleteObject(laserDrill)
                                                    drilling = false
                                                end
                                            end)
                                        else 
                                            NotifyClient(ConfigLocales.title_notify, ConfigLocales.noitemdrill_notify, "error")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Wait(250)
        end
    end
)

RegisterNetEvent(
    "playBreakRock",
    function()
        SendNUIMessage(
            {
                transactionType = "playSound",
                transactionFile = "breakrock",
                transactionVolume = 0.9
            }
        )
    end
)

while true do
    if drilling then
        Citizen.Wait(1)
        UseParticleFxAssetNextCall("core")
        Wait(200)
        local dust =
            StartNetworkedParticleFxNonLoopedAtCoord(
            "ent_dst_rocks",
            vaultPos.x,
            vaultPos.y,
            vaultPos.z,
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
