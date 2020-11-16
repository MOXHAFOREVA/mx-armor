ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Items = {
    ['smallarmor'] = {number = 35,  notify = "Hafif yeleği giydin"},
    ['armor'] = {number = 65,  notify = "Yeleği giydin"},
    ['heavyarmor'] = {number = 100, notify = "Ağır yeleği giydin"},
}

for k,v in pairs(Items) do
ESX.RegisterUsableItem(k, function (source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
         TriggerClientEvent('mx-takearmor', src, k, v.number, v.notify)
    end)
end

RegisterServerEvent('mx-delitem')
AddEventHandler('mx-delitem', function(name)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)

xPlayer.removeInventoryItem(name, 1)
end)

ESX.RegisterServerCallback('mx-getarmour', function (source, cb)   
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    MySQL.Async.fetchAll('SELECT armor FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('mx-setarmour')
AddEventHandler('mx-setarmour', function(armour)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('UPDATE users SET armor = @armor WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@armor'] = armour
    })
end)

