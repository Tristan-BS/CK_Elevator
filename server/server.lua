local lastUse = {}

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        print("^5[ck_elevator]^7 Resource ^2started ^7and ^2ready")
    end
end)


RegisterNetEvent("ck_elevator:requestTeleport", function(buildingName, floor)
    local src = source
    local now = os.time()

    -- Anti-Spam Cooldown (2 secs)
    if lastUse[src] and (now - lastUse[src]) < 2 then
        TriggerClientEvent("ck_elevator:notify", src, "Bitte warte kurz, bevor du den Aufzug erneut benutzt!", 'error')
        return
    end
    lastUse[src] = now

    -- Check
    if not floor or not floor.x or not floor.y or not floor.z then
        TriggerClientEvent("ck_elevator:notify", src, _U('errorFloor'), 'error')
        return
    end

    TriggerClientEvent("ck_elevator:doTeleport", src, floor)
    TriggerClientEvent("ck_elevator:notify", src, _U('notify', buildingName, floor.label), 'success')
end)
