Citizen.CreateThread(function()
    while true do
        if Config.Garage.vehicle_marker then 
            Citizen.Wait(1)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local targetCoords = GetEntityCoords(Config.Garage.vehicle)
            local playerDistance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, true)
            local proximityDistance = 5.0
            if playerDistance <= proximityDistance and not IsPedInAnyVehicle(playerPed, false) then
                DrawMarker(
                    2,
                    targetCoords.x,
                    targetCoords.y,
                    targetCoords.z + 2,
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
            else
                Citizen.Wait(850)
            end
        else 
            Citizen.Wait(1200)
        end 
    end
end)
