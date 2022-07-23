local QBCore = exports['qb-core']:GetCoreObject()
PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
function QBCore.Functions.GetPlayerData(cb)
    if cb then
        cb(QBCore.PlayerData)
    else
        return QBCore.PlayerData
    end
end

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
     	PlayerData.job = job
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
	PlayerData = val
end)

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

Citizen.CreateThread(function()
    exports['qb-target']:SpawnPed({
        model = Config.GaragePed,
        coords = Config.GaragePedLocation, 
        minusOne = true, --may have to change this if your ped is in the ground
        freeze = true, 
        invincible = true, 
        blockevents = true,
        scenario = 'WORLD_HUMAN_DRUG_DEALER',
        target = { 
            options = {
                {
                    type="client",
                    event = "garage:CoffeeShopGarage",
                    icon = "fas fa-car",
                    label = "Dom"
                }
            },
          distance = 2.5,
        },
    })
end)

RegisterNetEvent('qb-coffeeshop:garage')
AddEventHandler('qb-coffeeshop:garage', function(cs)
    local vehicle = cs.vehicle
    local coords = Config.SpawnCarLocation
        if PlayerData.job.name == "420coffee" then
            if vehicle == Config.CompanyVehicle then		
                QBCore.Functions.SpawnVehicle(vehicle, function(veh)
                    SetVehicleNumberPlateText(veh, "420COFFEE"..tostring(math.random(1000, 9999)))
                    exports['LegacyFuel']:SetFuel(veh, 100.0)
                    SetEntityHeading(veh, coords.w)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                    SetVehicleEngineOn(veh, true, true)
                end, coords, true)
            end
        else
            QBCore.Functions.Notify('You are not an employee of 420 Coffee Shop.', 'error')
        end
end)

RegisterNetEvent('qb-coffeeshop:storecar')
AddEventHandler('qb-coffeeshop:storecar', function()
    QBCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    NetworkFadeOutEntity(car, true,false)
    Citizen.Wait(2000)
    QBCore.Functions.DeleteVehicle(car)
end)

RegisterNetEvent('garage:CoffeeShopGarage', function()
    exports['qb-menu']:openMenu({
        {
            header = "| 420 COFFEESHOP GARAGE |",
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = "• Take Out Vehicle",
            txt = "",
            params = {
                event = "qb-coffeeshop:garage",
                args = {
                    vehicle = Config.CompanyVehicle,
                }
            }
        },
        {
            header = "• Store Vehicle",
            txt = "Store Vehicle Inside Garage",
            params = {
                event = "qb-coffeeshop:storecar",
                args = {
                    
                }
            }
        },	
        {
            header = "Close (ESC)",
            isMenuHeader = true,
        },	
    })
end)
