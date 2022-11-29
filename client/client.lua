local blowtorch = false
local blowTorchUse = false

exports.ox_target:addSphereZone({
    coords = vector3(-271.0651, 2199.7939, 129.807),
    radius = 0.5,
    debug = false,
    options = {
        {
            name = 'sphere',
            event = 'ox_target:debug',
            icon = 'fa-solid fa-hand',
            label = 'Vzít hořák',
            canInteract = function(entity, distance, coords, name)
                if blowtorch ~= true then
                    return true
                end
            end,
            onSelect = function(data)
                blowtorch = true
                lib.showTextUI('[E] - Manipulace s hořákem', {
                    position = "left-center",
                    icon = 'hand',
                    style = {
                        borderRadius = 0,
                        backgroundColor = '#48BB78',
                        color = 'white'
                    }
                })
            end
    
        },
        {
            name = 'sphere',
            event = 'ox_target:debug',
            icon = 'fa-solid fa-hand',
            label = 'Vrátit hořák',
            canInteract = function(entity, distance, coords, name)
                if blowtorch then
                    return true
                end
            end,
            onSelect = function(data)
                blowtorch = false
                blowTorchUse = false
                lib.hideTextUI()
            end
    
        }
    }
})

Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    while true do
        Wait(0)
        if blowtorch then
            if IsControlJustReleased(1, 51) then
                if not blowTorchUse then
                    blowTorchUse = true
                    TaskPlayAnim(playerPed, "amb@world_human_const_blowtorch@male@blowtorch@base", "base", 2.0, 1.0, 5000, 5000, 1, true, true, true)
                    lib.notify({
                        title = "Hořák",
                        description = "Nahříváš hořák..",
                        type = 'error'
                    })
        
                else
                    ClearPedTasksImmediately(PlayerPedId())
                    lib.hideTextUI()
                    blowTorchUse = false
                end
            end
        else
            Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    local playerPed = PlayerPedId()
    while true do
        Wait(3000)
        if blowTorchUse then
            local coords = GetEntityCoords(playerPed)
            TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
        end
    end
end)
