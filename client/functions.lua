function HelpFloating(msg, coords)
    AddTextEntry('FloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadAnimDict = function(dict, anim)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function playWardrobeAnimation()
    local ped = PlayerPedId()
    local dict, anim = "mp_clothing@female@shirt", "try_shirt_positive_a"
  
  
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(33)
    end
  
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 48, 0.0, false, false, false)
end