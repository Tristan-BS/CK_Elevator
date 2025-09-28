local ESX = nil


if Config.UseESXNotify then
    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(200)
            if GetGameTimer() > 10000 then break end
        end
    end)
end

local lastUse = 0

-- Notify helper
local function notify(msg, notifyType)
    if Config.UseESXNotify and ESX and ESX.ShowNotification then
        ESX.ShowNotification(msg)
    else
        --RiP Notify
        local nType = notifyType or 'default'

        -- Safety Check if resource exists
        if GetResourceState("RiP-Notify") == "started" then
            exports["RiP-Notify"]:sendNotify(nType, 3000, "Fahrstuhl", msg)
        else
            -- Fallback
            BeginTextCommandThefeedPost("STRING")
            AddTextComponentSubstringPlayerName(msg)
            EndTextCommandThefeedPostTicker(false, true)
        end
    end
end

-- Draw 3d Text
local function DrawText3D(x, y, z, text)
    local onScreen,_x,_y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextCentre(1)
        SetTextOutline()
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(_x,_y)
    end
end

-- Fade and teleport
RegisterNetEvent("ck_elevator:doTeleport", function(floor)
    DoScreenFadeOut(Config.FadeMs)
    while not IsScreenFadedOut() do Wait(0) end

    local ped = PlayerPedId()
    SetEntityCoordsNoOffset(ped, floor.x, floor.y, floor.z, false, false, false)
    if floor.h then SetEntityHeading(ped, floor.h + 0.0) end

    if Config.PlayElevatorDing then
        PlaySoundFrontend(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true)
    end

    DoScreenFadeIn(Config.FadeMs)
end)

RegisterNetEvent("ck_elevator:notify", function(msg, nType)
    notify(msg, nType)
end)


-- Find closest floor
local function getClosestFloorIndex(building, pos)
    local best, idx = 999999, 1
    for i, f in ipairs(building.floors) do
        local d = #(pos - vector3(f.x, f.y, f.z))
        if d < best then best, idx = d, i end
    end
    return idx, best
end

-- Main loop
CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local pPos = GetEntityCoords(ped)

        for _, building in ipairs(Config.Buildings) do
            local idx = getClosestFloorIndex(building, pPos)
            local ref = building.floors[idx]
            local dist = #(pPos - vector3(ref.x, ref.y, ref.z))

            if dist <= Config.DrawDistance then
                sleep = 0
                if Config.ShowMarkers then
                    DrawMarker(1, ref.x, ref.y, ref.z - 1.0,
                               0,0,0, 0,0,0, 0.6,0.6,0.4,
                               255,255,255,120, false,false,2,false)
                end
                if dist <= Config.InteractDistance then
                    -- Text per position
                    local upText   = (idx < #building.floors) and _U('up') or ""
                    local downText = (idx > 1) and _U('down') or ""

                    -- If up and down, put ____
                    local sep = (upText ~= "" and downText ~= "") and "\n____\n\n" or ""

                    DrawText3D(ref.x, ref.y, ref.z+0.9,
                        string.format("%s\n%s%s%s", building.name, upText, sep, downText))

                    -- Key check
                    if IsControlJustPressed(0, Config.KeyUp) and idx < #building.floors then
                        local now = GetGameTimer()
                        if now - lastUse >= Config.CooldownMs then
                            lastUse = now
                            local target = building.floors[idx + 1]
                            TriggerServerEvent("ck_elevator:requestTeleport", building.name, target)
                        end
                    elseif IsControlJustPressed(0, Config.KeyDown) and idx > 1 then
                        local now = GetGameTimer()
                        if now - lastUse >= Config.CooldownMs then
                            lastUse = now
                            local target = building.floors[idx - 1]
                            TriggerServerEvent("ck_elevator:requestTeleport", building.name, target)
                        end
                    end
                end
            end
        end

        Wait(sleep)
    end
end)
