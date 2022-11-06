local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = true
PlayerJob = {}

local onDuty = true

-- target

Citizen.CreateThread(function()
	exports['qb-target']:AddBoxZone("CoffeeShopBusiness", vector3(245.13, 372.04, 105.91), 0.35, 0.35, {
		name = "CoffeeShopBusiness",
		heading = 155.73,
		debugPoly = false,
		minZ=105.80,
		maxZ=106.10,
	}, {
		options = {
		    {  
			event = "qb-coffeeshop:CoffeeShopBusinessMenu",
			icon = "far fa-clipboard",
			label = "Access Business",
			job = "420coffee",
		    },
		},
		distance = 1.5
	})

		exports['qb-target']:AddBoxZone("CoffeeMenu", vector3(248.61, 372.51, 106.02), 0.80, 0.60, {
			name = "CoffeeMenu",
			heading = 247,
			debugPoly = false,
			minZ=105.85,
			maxZ=106.30,
		}, {
			options = {
			    {
				event = "qb-coffeeshop:CoffeeMenu",
				icon = "fas fa-coffee",
				label = "Coffee Machine",
                job = "420coffee",
			    },
			},
			distance = 1.5
		})


	exports['qb-target']:AddBoxZone("CoffeeShopFridge", vector3(246.08, 371.71, 105.74), 0.9, 1.15, {
		name="CoffeeShopFridge",
		heading=159,
		debugPoly=false,
		minZ=104.9,
		maxZ=105.6,
	}, {
		options = {
			{
				event = "qb-coffeeshop:BeerFridge",
				icon = "fas fa-beer",
				label = "Beer Fridge",
				job = "420coffee",
			},
		},
		distance = 1.5
	})


		exports['qb-target']:AddBoxZone("CoffeeShopSnackBox", vector3(245.13, 372.04, 105.0), 0.6, 0.65, {
		name="CoffeeShopSnackBox",
		heading=159,
		debugPoly=false,
		minZ=104.1,
		maxZ=105.3,
		}, {
		    options = {
			{
			    event = "qb-coffeeshop:SnackBox",
			    icon = "fas fa-cookie",
			    label = "Snack Box",
			    job = "420coffee",
			},
		    },
		    distance = 1.2
		})


         exports['qb-target']:AddBoxZone("CoffeeShopScales", vector3(248.13, 372.23, 104.83), 0.4, 0.7, {
            name="CoffeeShopScales",
            heading=250,
            debugPoly=false,
            minZ=104.1,
            maxZ=105.0,
        }, {
                options = {
                    {
                        event = "qb-coffeeshop:WeedScales",
                        icon = "fas fa-cannabis",
                        label = "Weed Scales",
                        job = "420coffee",
                    },
                },
                distance = 1.5
            })

end)



-- QB-MENU --

RegisterNetEvent('qb-coffeeshop:CoffeeShopBusinessMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            
            header = "| 420 COFFEESHOP |",
            isMenuHeader = true, 
        },
        {
            
            header = "• Toggle Duty",
            txt = "",
            params = {
                event = "qb-coffeeshop:DutyC"
            }
        },
        {
            
            header = "• Charge Customer",
            txt = "",
            params = {
                event = "qb-coffeeshop:bill"
            }
        },
        {
            
            header = "• Order Items",
            txt = "Order New Ingredients!",
            params = {
                event = "qb-coffeeshop:shop"
            }
        },
        {

            header = "• Manage Business",
            txt = "Open Boss Menu",
            params = {
                event = "qb-bossmenu:client:OpenMenu"
            }
        },
        {
            id = 7,
            header = "Close (ESC)",
            isMenuHeader = true, 
        },
    })
end)

RegisterNetEvent('qb-coffeeshop:CoffeeMenu', function(data)
    exports['qb-menu']:openMenu({
        {
            
            header = "| COFFEE MACHINE |",
            isMenuHeader = true, 
        },
        {
            
            header = "• Regular Coffee",
            txt = "",
            params = {
                event = "qb-coffeeshop:BrewRegular"
            }
        },
        {
            
            header = "• Espresso",
            txt = "",
            params = {
                event = "qb-coffeeshop:BrewEspresso"
            }
        },
        {
            
            header = "• Latte",
            txt = "",
            params = {
                event = "qb-coffeeshop:BrewLatte"
            }
        },
        {
            
            header = "• Americano",
            txt = "",
            params = {
                event = "qb-coffeeshop:BrewAmericano"
            }
        },
        {
            id = 7,
            header = "Close (ESC)",
            isMenuHeader = true, 
        },
    })
end)


RegisterNetEvent('qb-coffeeshop:WeedScales', function(data)
    exports['qb-menu']:openMenu({
        {
            
            header = "| WEED SCALES |",
            isMenuHeader = true, 
        },
        {
            
            header = "• 420 Gift Box",
            txt = "Contains 1 of each joint",
            params = {
                event = "qb-coffeeshop:CreateGiftBox"
            }
        },
        {
            
            header = "• White Widow Joint",
            txt = "",
            params = {
                event = "qb-coffeeshop:CreateWhiteWidow"
            }
        },
        {
            
            header = "• Skunk Joint",
            txt = "",
            params = {
                event = "qb-coffeeshop:CreateSkunk"
            }
        },
        {
            
            header = "• Purple Haze Joint",
            txt = "",
            params = {
                event = "qb-coffeeshop:CreatePurpleHaze"
            }
        },
        {
            
            header = "• OG Kush Joint",
            txt = "",
            params = {
                event = "qb-coffeeshop:CreateOGKush"
            }
        },
        {
            
            header = "• Amnesia Joint",
            txt = "",
            params = {
                event = "qb-coffeeshop:CreateAmnesia"
            }
        },
        {
            
            header = "• AK47 Joint",
            txt = "",
            params = {
                event = "qb-coffeeshop:CreateAK47"
            }
        },
        {
            id = 7,
            header = "Close (ESC)",
            isMenuHeader = true, 
        },
    })
end)

-- BILLING SYSTEM --
RegisterNetEvent("qb-coffeeshop:bill")
AddEventHandler("qb-coffeeshop:bill", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Create Receipt",
		submitText = "Bill",
        inputs = {
            {
                text = "Server ID(#)",
				name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = "Bill Price ($)", -- text you want to be displayed as a place holder
                name = "billprice", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                isRequired = false -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            }
			
        }
    })
    if bill ~= nil then
        if bill.citizenid == nil or bill.billprice == nil then 
            return 
        end
        TriggerServerEvent("qb-coffeeshop:bill:player", bill.citizenid, bill.billprice)
    end
end)
