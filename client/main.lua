local QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
local onDuty = true
PlayerJob = {}

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    CoffeeShop = AddBlipForCoord(241.32, 358.07, 105.59)
    SetBlipSprite (CoffeeShop, 469)
    SetBlipDisplay(CoffeeShop, 4)
    SetBlipScale  (CoffeeShop, 0.7)
    SetBlipAsShortRange(CoffeeShop, true)
    SetBlipColour(CoffeeShop, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("CoffeeShop")
    EndTextCommandSetBlipName(CoffeeShop)
end) 

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "420coffee" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
	onDuty = duty
end)

RegisterNetEvent("qb-coffeeshop:DutyC")
AddEventHandler("qb-coffeeshop:DutyC", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-coffeeshop:BeerFridge")
AddEventHandler("qb-coffeeshop:BeerFridge", function()
    TriggerEvent("inventory:client:SetCurrentStash", "420beerfridge")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "420beerfridge", {
        maxweight = 100000,
        slots = 20,
    })
end)

RegisterNetEvent("qb-coffeeshop:SnackBox")
AddEventHandler("qb-coffeeshop:SnackBox", function()
    TriggerEvent("inventory:client:SetCurrentStash", "420snackbox")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "420snackbox", {
        maxweight = 100000,
        slots = 20,
    })
end)

RegisterNetEvent("qb-coffeeshop:Storage")
AddEventHandler("qb-coffeeshop:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "420bigstorage1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "429bigstorage1", {
        maxweight = 800000,
        slots = 100,
    })
end)

RegisterNetEvent("qb-coffeeshop:Storage2")
AddEventHandler("qb-coffeeshop:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "420bigstorage2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "420bigstorage2", {
        maxweight = 800000,
        slots = 100,
    })
end)

RegisterNetEvent("qb-coffeeshop:OpenGiftBox")
AddEventHandler("qb-coffeeshop:OpenGiftBox", function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)

    local giftbox = `hei_heist_acc_box_trinket_02`  --change prop for giftbox if you want to
    RequestModel(giftbox)
    while (not HasModelLoaded(giftbox)) do
        Wait(1)
    end
    local gbobj = CreateObject(giftbox, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(gbobj)
    SetEntityAsMissionEntity(gbobj)

    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
    QBCore.Functions.Progressbar('name_here', 'Opening Gift Box...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})

        DeleteEntity(gbobj)

        TriggerServerEvent('QBCore:Server:RemoveItem', 'coffeeshop-giftbox', 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['coffeeshop-giftbox'], "remove")
        TriggerServerEvent('QBCore:Server:AddItem', "whitewidow-joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['whitewidow-joint'], "add")
		TriggerServerEvent('QBCore:Server:AddItem', "skunk-joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['skunk-joint'], "add")
		TriggerServerEvent('QBCore:Server:AddItem', "purplehaze-joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['purplehaze-joint'], "add")
        TriggerServerEvent('QBCore:Server:AddItem', "ogkush-joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['ogkush-joint'], "add")
        TriggerServerEvent('QBCore:Server:AddItem', "amnesia-joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['amnesia-joint'], "add")
        TriggerServerEvent('QBCore:Server:AddItem', "ak47-joint", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items['ak47-joint'], "add")

        TriggerServerEvent('qb-coffeeshop:server:GetGiftBoxLuck')
    end)
end)

RegisterNetEvent('qb-coffeeshop:client:SetGiftBoxItems', function(GiftBoxItemList)
	Config.LuckItemsList = GiftBoxItemList
end)

RegisterNetEvent("qb-coffeeshop:CreateGiftBox")
AddEventHandler("qb-coffeeshop:CreateGiftBox", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientGiftBox', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making A Gift Box..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "whitewidow-joint", 1)
                    			TriggerServerEvent('QBCore:Server:RemoveItem', "gift-box", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "skunk-joint", 1)
                                        TriggerServerEvent('QBCore:Server:RemoveItem', "purplehaze-joint", 1)
                                        TriggerServerEvent('QBCore:Server:RemoveItem', "ogkush-joint", 1)
                                        TriggerServerEvent('QBCore:Server:RemoveItem', "amnesia-joint", 1)
                                        TriggerServerEvent('QBCore:Server:RemoveItem', "ak47-joint", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "coffeeshop-giftbox", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["coffeeshop-giftbox"], "add")
                    			QBCore.Functions.Notify("You made a A Gift Box", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the items to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end  
end)

---====COFFEE MACHINE=====-----

RegisterNetEvent("qb-coffeeshop:BrewRegular")
AddEventHandler("qb-coffeeshop:BrewRegular", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientCoffee', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Brewing Coffee..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-beans", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-cup", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "regular-coffee", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["regular-coffee"], "add")
                    			QBCore.Functions.Notify("You Brewed Some Coffee", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:BrewEspresso")
AddEventHandler("qb-coffeeshop:BrewEspresso", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientCoffee', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Brewing Espresso..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-beans", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-cup", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "espresso-coffee", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["espresso-coffee"], "add")
                    			QBCore.Functions.Notify("You Brewed Some Coffee", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:BrewLatte")
AddEventHandler("qb-coffeeshop:BrewLatte", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientCoffee', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Brewing Latte..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-beans", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-cup", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "latte-coffee", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["latte-coffee"], "add")
                    			QBCore.Functions.Notify("You Brewed Some Coffee", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:BrewAmericano")
AddEventHandler("qb-coffeeshop:BrewAmericano", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientCoffee', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Brewing Americano..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-beans", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "coffee-cup", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "americano-coffee", 1)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["americano-coffee"], "add")
                    			QBCore.Functions.Notify("You Brewed Some Coffee", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

---====WEED SCALES===---

RegisterNetEvent("qb-coffeeshop:CreateWhiteWidow")
AddEventHandler("qb-coffeeshop:CreateWhiteWidow", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientWhiteWidow', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Joints..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "weed_white-widow", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "rolling_paper", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "whitewidow-joint", Config.WhiteWidowAmount)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["whitewidow-joint"], "add")
                    			QBCore.Functions.Notify("You made a White Widow Joint", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:CreateSkunk")
AddEventHandler("qb-coffeeshop:CreateSkunk", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientSkunk', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Joints..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "weed_skunk", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "rolling_paper", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "skunk-joint", Config.JointCraftAmount)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["skunk-joint"], "add")
                    			QBCore.Functions.Notify("You made a Skunk Joint", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:CreatePurpleHaze")
AddEventHandler("qb-coffeeshop:CreatePurpleHaze", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientPurpleHaze', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Joints..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "weed_purple-haze", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "rolling_paper", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "purplehaze-joint", Config.JointCraftAmount)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["purplehaze-joint"], "add")
                    			QBCore.Functions.Notify("You made a Purple Haze Joint", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:CreateOGKush")
AddEventHandler("qb-coffeeshop:CreateOGKush", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientOGKush', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Joints..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "weed_og-kush", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "rolling_paper", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "ogkush-joint", Config.JointCraftAmount)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ogkush-joint"], "add")
                    			QBCore.Functions.Notify("You made OG Kush Joints", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:CreateAmnesia")
AddEventHandler("qb-coffeeshop:CreateAmnesia", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientAmnesia', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Joints..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "weed_amnesia", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "rolling_paper", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "amnesia-joint", Config.JointCraftAmount)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["amnesia-joint"], "add")
                    			QBCore.Functions.Notify("You made Amnesia Joints", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)

RegisterNetEvent("qb-coffeeshop:CreateAK47")
AddEventHandler("qb-coffeeshop:CreateAK47", function()
    if onDuty then
    	QBCore.Functions.TriggerCallback('qb-coffeeshop:server:get:ingredientAK47', function(HasItems)  
    		if HasItems then
				QBCore.Functions.Progressbar("pickup_sla", "Making Joints..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_car_bomb",
					anim = "car_bomb_mechanic",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('QBCore:Server:RemoveItem', "weed_ak47", 1)
					TriggerServerEvent('QBCore:Server:RemoveItem', "rolling_paper", 1)
					TriggerServerEvent('QBCore:Server:AddItem', "ak47-joint", Config.JointCraftAmount)
                    			TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["ak47-joint"], "add")
                    			QBCore.Functions.Notify("You made AK47 Joints", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
			else
   				QBCore.Functions.Notify("You dont have the right stuff to make this", "error")
			end
		end)
	else 
		QBCore.Functions.Notify("You must be Clocked into work", "error")
	end
end)


RegisterNetEvent("qb-coffeeshop:shop")
AddEventHandler("qb-coffeeshop:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "420coffee", Config.Items)
end)

function CoffeeJointEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    CoffeeExtraEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            CoffeeExtraEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

RegisterNetEvent('qb-coffeeshop:SmokeJoint', function()
    QBCore.Functions.Progressbar("smoke_joint", "Lighting joint..", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"joint"})
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"joint"})
        end
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
		CoffeeJointEffect()
        TriggerEvent('animations:client:SmokeWeed')
        TriggerServerEvent('hud:server:RelieveStress', Config.JointStressRelief)
    end)
end)

function CoffeeExtraEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

ConsumeWeedCoffee = {
    ["regular-coffee"] = Config.ThirstRelief,
    ["latte-coffee"] = Config.ThirstRelief,
    ["espresso-coffee"] = Config.ThirstRelief,
    ["americano-coffee"] = Config.ThirstRelief,
}
RegisterNetEvent('qb-coffeeshop:DrinkCoffee', function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"coffee"})
    QBCore.Functions.Progressbar("drink_something", "Drinking..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumeWeedCoffee[itemName])
        TriggerServerEvent('hud:server:RelieveStress', Config.CoffeeStressRelief)
    end)
end)
