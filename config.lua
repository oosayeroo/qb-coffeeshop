Config = {}
Config.LuckItemsList = {}

Config.GaragePed = "g_m_importexport_01"  --change to whatever model you like
Config.GaragePedLocation = vector4(221.17, 370.18, 106.27, 67.75)
Config.SpawnCarLocation = vector4(213.74, 389.2, 106.87, 172.49)
Config.CompanyVehicle = 'surfer'
Config.VehiclePlate = "420COFFEE"
Config.JobName = '420coffee'

---===GIFT BOX OPENING=====--
--these LuckItems are a chance item you get when opening a gift box. these must be items you have in your shared/items.lua add as many as you like
Config.LuckItems = {
    "lockpick",
    "tosti",
    "advancedlockpick",
    "weed_white-widow_seed",
}

Config.CraftingTime = 5 --in seconds
---===joints====----
Config.JointCraftAmount = 3  --amount of joints you get from crafting a single time
Config.JointStressRelief = math.random(5 ,15)  --amount of stress to lower when smoking
---===coffee consume===---
Config.ThirstRelief = math.random(10 ,30)  ---amount of thirst to fill when drinking coffee
Config.CoffeeStressRelief = math.random(3 ,6)   --amount of stress to lower when drinking
Config.Items = {
label = "420coffee",
    slots = 3,  --make sure this number is the same as the amount of items you have in this list or it wont work
    items = {
        [1] = {
            name = "coffee-beans",
            price = 1,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "coffee-cup",
            price = 3,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "rolling_paper",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
        },
    }
}
