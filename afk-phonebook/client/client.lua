local QBCore = exports['qb-core']:GetCoreObject()
local open = false


RegisterNetEvent('afrikode:client:phonebook')
AddEventHandler('afrikode:client:phonebook', function()
    open = not open 
    SetNuiFocus(true, true)
    QBCore.Functions.TriggerCallback('afrikode:server:phoneBook', function(cb)
        local firstData = {}
        firstData.playerName = playerName
        firstData.phoneNumber = phoneNumber
            SendNUIMessage({
                type = 'phoneBookdata',
                playerName = playerName,
                phoneNumber = phoneNumber,
                job = v.job,
                field = v.field,
                action = open 
            })
        SetNuiFocus(false, false)
    end)
end)

RegisterNUICallback('closeNUI', function(data, cb)
    open = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'close'
    })
    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if open then
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = 'openPhoneBook',
                action = open 
            })
        end
    end
end)
