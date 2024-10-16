ESX = exports["es_extended"]:getSharedObject()

local coordenadasJugadores = {}

ESX.RegisterCommand(
    'traer',
    "admin", 
    function(xPlayer, args)
        local usuarioID = tonumber(args[1]) 
        local usuario = ESX.GetPlayerFromId(usuarioID)     
        
        local adminCoords = GetEntityCoords(GetPlayerPed(xPlayer.source), false)
        local oldCoords = GetEntityCoords(GetPlayerPed(usuarioID), false)
        
        coordenadasJugadores[usuarioID] = {x = oldCoords.x, y = oldCoords.y, z = oldCoords.z}
        usuario.setCoords({x = adminCoords.x, y = adminCoords.y, z = adminCoords.z})
        TriggerClientEvent('chat:addMessage', xPlayer.source , {
            color = {0, 255, 0},
            multiline = true,
            args = {"Traer ["..usuarioID.."]", "Usa /llevar " ..usuarioID.. " para devolver al usuario donde estaba"}
        })
    end, 
    false
)

ESX.RegisterCommand('llevar', "admin", function(xPlayer, args)
    local usuarioID = tonumber(args[1])
    local usuario = ESX.GetPlayerFromId(usuarioID)

    if usuarioID and coordenadasJugadores[usuarioID] then
        local coords = coordenadasJugadores[usuarioID]
        coordenadasJugadores[usuarioID] = nil
        if coords then
            usuario.setCoords({x = coords.x, y = coords.y, z = coords.z})
            TriggerClientEvent('chat:addMessage', xPlayer.source, {
                color = {0, 255, 255},
                multiline = true,
                args = {"Llevar [".. usuarioID .."]", "Usuario devuelto a su posicion anterior"}
            })
        end
    else
        TriggerClientEvent('chat:addMessage', xPlayer.source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Llevar [".. usuarioID .."]", "No se ha traido al usuario."}
        })
    end
end)