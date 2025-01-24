lib.versionCheck('DukeOfCheese/FiveM-Lockpick-Script')

RegisterNetEvent('atlaslockpick:selectVehicle', function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(entity) then return end

    local owner = NetworkGetEntityOwner(entity)
    TriggerClientEvent('atlaslockpick:unlockVehicle', netId)
end)

RegisterNetEvent('atlaslockpick:checkVehicle', function(netId)
    local src = source
    if IsPlayerAceAllowed(source, Config.ace_permission) then
        local entity = NetworkGetEntityFromNetworkId(netId)
        local doorLockStatus = GetVehicleDoorsLockedForPlayer(entity)
        if doorLockStatus == 1 then
            TriggerClientEvent('atlaslockpick:unlockingVehicle', src, 'locked', netId)
        elseif doorLockStatus == 0 then
            TriggerClientEvent('atlaslockpick:unlockingVehicle', src, 'unlocked', netId)
        else
            TriggerClientEvent('atlaslockpick:unlockingVehicle', src, 'unknown', netId)
        end
    else
        TriggerClientEvent('atlaslockpick:unlockingVehicle', src, 'noPerms', netId)
    end
end)