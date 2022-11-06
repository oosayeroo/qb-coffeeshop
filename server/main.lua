local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent("qb-coffeeshop:bill:player")
AddEventHandler("qb-coffeeshop:bill:player", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == Config.JobName then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                        MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
                            ['citizenid'] = billed.PlayerData.citizenid,
                            ['amount'] = amount,
                            ['society'] = biller.PlayerData.job.name,
                            ['sender'] = biller.PlayerData.charinfo.firstname
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
        end
end)

RegisterNetEvent('qb-coffeeshop:server:GetGiftBoxLuck', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        for i = 1, 1, 1 do
            local item = Config.LuckItems[math.random(1, #Config.LuckItems)]
            Player.Functions.AddItem(item, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
            Wait(500)
        end
    end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientCoffee', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local beans = Ply.Functions.GetItemByName("coffee-beans")
    local cup = Ply.Functions.GetItemByName("coffee-cup")
    if beans ~= nil and cup ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

--===JOINT CRAFTING==---

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientWhiteWidow', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local widow = Ply.Functions.GetItemByName("weed_white-widow")
    local paper = Ply.Functions.GetItemByName("rolling_paper")
    if widow ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientSkunk', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local skunk = Ply.Functions.GetItemByName("weed_skunk")
    local paper = Ply.Functions.GetItemByName("rolling_paper")
    if skunk ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientPurpleHaze', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local phaze = Ply.Functions.GetItemByName("weed_purple-haze")
    local paper = Ply.Functions.GetItemByName("rolling_paper")
    if phaze ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientOGKush', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local kush = Ply.Functions.GetItemByName("weed_og-kush")
    local paper = Ply.Functions.GetItemByName("rolling_paper")
    if kush ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientAmnesia', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local amnesia = Ply.Functions.GetItemByName("weed_amnesia")
    local paper = Ply.Functions.GetItemByName("rolling_paper")
    if amnesia ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientAK47', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local ak47 = Ply.Functions.GetItemByName("weed_ak47")
    local paper = Ply.Functions.GetItemByName("rolling_paper")
    if ak47 ~= nil and paper ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-coffeeshop:server:get:ingredientGiftBox', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local jak47 = Ply.Functions.GetItemByName("ak47-joint")
    local jwidow = Ply.Functions.GetItemByName("whitewidow-joint")
    local jamnesia = Ply.Functions.GetItemByName("amnesia-joint")
    local jphaze = Ply.Functions.GetItemByName("purplehaze-joint")
    local jskunk = Ply.Functions.GetItemByName("skunk-joint")
    local jkush = Ply.Functions.GetItemByName("ogkush-joint")
    if jak47 ~= nil and jwidow ~= nil and jamnesia ~= nil and jphaze ~= nil and jskunk ~= nil and jkush ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent('qb-coffeeshop:server:giftboxitems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('coffeeshop-giftbox', 1)
    Player.Functions.AddItem('whitewidow-joint', 1)
    Player.Functions.AddItem('skunk-joint', 1)
    Player.Functions.AddItem('purplehaze-joint', 1)
    Player.Functions.AddItem('ogkush-joint', 1)
    Player.Functions.AddItem('amnesia-joint', 1)
    Player.Functions.AddItem('ak47-joint', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makegiftbox', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('coffeeshop-giftbox', 1)
    Player.Functions.RemoveItem('whitewidow-joint', 1)
    Player.Functions.RemoveItem('skunk-joint', 1)
    Player.Functions.RemoveItem('purplehaze-joint', 1)
    Player.Functions.RemoveItem('ogkush-joint', 1)
    Player.Functions.RemoveItem('amnesia-joint', 1)
    Player.Functions.RemoveItem('ak47-joint', 1)
    Player.Functions.RemoveItem('gift-box', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeregular', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('regular-coffee', 1)
    Player.Functions.RemoveItem('coffee-beans', 1)
    Player.Functions.RemoveItem('coffee-cup', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeespresso', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('espresso-coffee', 1)
    Player.Functions.RemoveItem('coffee-beans', 1)
    Player.Functions.RemoveItem('coffee-cup', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makelatte', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('latte-coffee', 1)
    Player.Functions.RemoveItem('coffee-beans', 1)
    Player.Functions.RemoveItem('coffee-cup', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeamericano', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('americano-coffee', 1)
    Player.Functions.RemoveItem('coffee-beans', 1)
    Player.Functions.RemoveItem('coffee-cup', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makewidowjoint', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('whitewidow-joint', Config.JointCraftAmount)
    Player.Functions.RemoveItem('weed_white-widow', 1)
    Player.Functions.RemoveItem('rolling_paper', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeskunkjoint', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('skunk-joint', Config.JointCraftAmount)
    Player.Functions.RemoveItem('weed_skunk', 1)
    Player.Functions.RemoveItem('rolling_paper', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makephazejoint', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('purplehaze-joint', Config.JointCraftAmount)
    Player.Functions.RemoveItem('weed_purple-haze', 1)
    Player.Functions.RemoveItem('rolling_paper', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeogkushjoint', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('ogkush-joint', Config.JointCraftAmount)
    Player.Functions.RemoveItem('weed_og-kush', 1)
    Player.Functions.RemoveItem('rolling_paper', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeamnesiajoint', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('amnesia-joint', Config.JointCraftAmount)
    Player.Functions.RemoveItem('weed_amnesia', 1)
    Player.Functions.RemoveItem('rolling_paper', 1)
end)

RegisterNetEvent('qb-coffeeshop:server:makeakjoint', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('ak47-joint', Config.JointCraftAmount)
    Player.Functions.RemoveItem('weed_ak47', 1)
    Player.Functions.RemoveItem('rolling_paper', 1)
end)

QBCore.Functions.CreateUseableItem("coffeeshop-giftbox", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-coffeeshop:OpenGiftBox", source, item.name)
end)

QBCore.Functions.CreateUseableItem("regular-coffee", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:DrinkCoffee", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("latte-coffee", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:DrinkCoffee", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("americano-coffee", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:DrinkCoffee", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("espresso-coffee", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:DrinkCoffee", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("whitewidow-joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:SmokeJoint", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("ogkush-joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:SmokeJoint", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("purplehaze-joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:SmokeJoint", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("amnesia-joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:SmokeJoint", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("skunk-joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:SmokeJoint", src, item.name)
    end
end)

QBCore.Functions.CreateUseableItem("ak47-joint", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("qb-coffeeshop:SmokeJoint", src, item.name)
    end
end)

