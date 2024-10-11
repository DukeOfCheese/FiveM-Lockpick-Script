local function unlockDoor(vehicle)
    TriggerServerEvent("atlaslockpick:checkVehicle", VehToNet(vehicle))
end

local function onSelectDoor(data)
    local entity = data.entity
    if NetworkGetEntityOwner(entity) == cache.playerId then
        return unlockDoor(entity)
    end
    TriggerServerEvent('atlaslockpick:selectDoor', VehToNet(entity))
end

RegisterNetEvent('atlaslockpick:unlockDoor', function(netId)
    unlockDoor(NetToVeh(netId))
end)

RegisterNetEvent('atlaslockpick:unlockingVehicle')
AddEventHandler('atlaslockpick:unlockingVehicle', function(status, netId)
    local vehicle = NetToVeh(netId)
    local vehicleModel = GetEntityModel(vehicle)
    local isAllowed = true
    for _, allowedModel in pairs(Config.BlacklistedVehicles) do
        if GetHashKey(allowedModel) == vehicleModel then
            isAllowed = false
            break
        end
    end
    if not isAllowed then
        lib.notify({title = "Atlas Lockpick", description = "You cannot lockpick this vehicle!", type = "error", duration = 2000, position = "center-right"})
        return
    end
    if status == 'unlocked' then
        lib.notify({title = "Atlas Lockpick", description = "Vehicle is already unlocked!", type = "error", duration = 2000, position = "center-right"})
    elseif status == 'locked' then
        local pick = lib.skillCheck({'easy', 'medium', 'medium', 'hard'}, {'e'})
        if pick then
            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
            SetVehicleAlarmTimeLeft(vehicle, 0)
            lib.notify({title = "Atlas Lockpick", description = "Doors unlocked!", type = "success", duration = 3000, position = "center-right"})
        else
            SetVehicleAlarmTimeLeft(vehicle, 30000)
            lib.notify({title = "Atlas Lockpick", description = "Failed lockpick", type = "warning", duration = 2000, position = "center-right"})
        end
    elseif status == 'noPerms' then
        lib.notify({title = "Atlas Lockpick", description = "You don't have permission to do that!", type = "error", duration = 2000, position = "center-right"})
    elseif status == 'unknown' then
        lib.notify({title = "Atlas Lockpick", description = "ERROR", type = "error", duration = 2000, position = "center-right"})
    end
end)

exports.ox_target:addGlobalVehicle({
    {
        name = 'atlaslockpick:lockpickVeh',
        icon = 'fa-solid fa-key',
        label = 'Lockpick Vehicle',
        distance = 2,
        onSelect = function(data)
            onSelectDoor(data)
        end
    }
})
