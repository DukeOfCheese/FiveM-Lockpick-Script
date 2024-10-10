RegisterNetEvent('atlaslockpick:selectDoor', function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(entity) then return end

    local owner = NetworkGetEntityOwner(entity)
    TriggerClientEvent('atlaslockpick:unlockDoor', netId)
end)

RegisterNetEvent('atlaslockpick:checkVehicle', function(netId)
    if IsPlayerAceAllowed(source, Config.ace_permission) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        local doorLockStatus = GetVehicleDoorsLockedForPlayer(entity)
        if doorLockStatus == 1 then
            TriggerClientEvent('atlaslockpick:unlockingVehicle', -1, 'locked', netId)
        elseif doorLockStatus == 0 then
            TriggerClientEvent('atlaslockpick:unlockingVehicle', -1, 'unlocked', netId)
        else
            TriggerClientEvent('atlaslockpick:unlockingVehicle', -1, 'unknown', netId)
        end
    else
        TriggerClientEvent('atlaslockpick:unlockingVehicle', -1, 'noPerms', netId)
    end
end)