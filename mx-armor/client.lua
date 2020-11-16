ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(7)
    end
    Citizen.Wait(5000)
    ESX.TriggerServerCallback('mx-getarmour', function(result)
        if result[1].armor > 0 then
            SetPedArmour(PlayerPedId(), result[1].armor)
        end
    end)
end)

RegisterNetEvent('mx-takearmor')
AddEventHandler('mx-takearmor', function(name, num, notif)
    local ped = PlayerPedId()
    if GetPedArmour(ped) < num and GetPedArmour(ped) < 30 then
        exports['mythic_notify']:SendAlert('inform', notif)
            TriggerEvent("mythic_progbar:client:progress", {
                name = "unique_action_name",
                duration = 3000,
                label = "Armor giyiyorsun",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "amb@world_human_hiker_standing@male@idle_a",
                    anim = "idle_b",
                },
                prop = {
                    model = "",
                }
            }, function(status)
                if not status then
                    ClearPedTasks(ped)
                    SetPedArmour(ped, num)
                    TriggerServerEvent('mx-setarmour', tonumber(num))
                    TriggerServerEvent('mx-delitem', name)
                end
        end)
    else
        exports['mythic_notify']:SendAlert('inform', 'Üstünüzde zaten yelek var')
    end
end)

RegisterCommand('armorcikar', function()
        SetPedArmour(PlayerPedId(), 0)
end)