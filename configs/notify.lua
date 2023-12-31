function NotifyClient(title, msg, type)
    if type == "info" then
    exports['okokNotify']:Alert(title, msg, 3500, "info")
    elseif type == "error" then
    exports['okokNotify']:Alert(title, msg, 3500, "error")
    elseif type  == "success" then 
        exports['okokNotify']:Alert(title, msg, 3500, "success")
    else
        print("NOTIFY TYPE BUGGED")
    end
end

function NotifyServer(source, title, msg, type)
    if type == "info" then
        TriggerClientEvent('okokNotify:Alert', source, title, msg, 3500, 'info')
    elseif type == "error" then
        TriggerClientEvent('okokNotify:Alert', source, title, msg, 3500, 'error')
    elseif type  == "success" then 
        TriggerClientEvent('okokNotify:Alert', source, title, msg, 3500, 'success')
    else
        print("NOTIFY TYPE BUGGED")
    end
end