local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("phonebook", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent("afrikode:client:phonebook", src)
end)


QBCore.Functions.CreateCallback('afrikode:server:phoneBook', function(source, cb)
    local phoneBook = {}
    local sql = "SELECT * FROM `players`"
    MySQL.Async.fetchAll(sql, function(result)
        for i = 1, #result, 1 do
            local isOnline = QBCore.Functions.GetPlayerByCitizenId(result[i].citizenid)
            local playerData = result[i]
            local playerName = json.decode(playerData.charinfo).firstname..' '..json.decode(playerData.charinfo).lastname
            local phoneNumber = json.decode(playerData.charinfo).phone
            local job = json.decode(playerData.job).name
            local field = json.decode(playerData.job).label
            if isOnline then
                phoneBook[#phoneBook+1] = {
                    playerName = '🟢 '..playerName,
                    phoneNumber = phoneNumber,
                    job = job,
                    field = field
                }
            elseif config.displayOfflineplayers then -- add this condition
                phoneBook[#phoneBook+1] = {
                    playerName = '⚪ '..playerName,
                    phoneNumber = phoneNumber,
                    job = job,
                    field = field
                }
            end
        end
        if config.displayOfflineplayers then -- sort the phone book based on the player name if displayOfflineplayers is true
            table.sort(phoneBook, function(a, b)
                return a.playerName < b.playerName
            end)
        else -- sort the phone book based on the job field if displayOfflineplayers is false
            table.sort(phoneBook, function(a, b)
                return a.field < b.field
            end)
        end
        cb(phoneBook)
    end)
end)
