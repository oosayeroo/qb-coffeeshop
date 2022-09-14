update - 14/9/22 - update for new qb-inventory exports

Discord - https://discord.gg/XPuqBVtyqX

# A COFFEESHOP job for QBCore Framework

## Please note

- Please make sure u use the latest dependencies aswell as core for this in order to work.

- This Job has been tested on the latest build as of 23/7/2022.


## Dependencies :

QBCore Framework
qb-input 
qb-menu
qb-shops

Modi Maps Coffeeshop MLO available here - https://modi.tebex.io/package/4652236
Modi's Discord - https://discord.gg/7h3tYFykKx

## Credits : 

- qbcore team for their amazing scripts.
-MODI MAPS for their MLO


## Insert into @qb-core/shared/items.lua 

```
--qb-coffeeshop
	--coffeestuff
	['regular-coffee'] 			     = {['name'] = 'regular-coffee', 			   	['label'] = 'Coffee', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'regular-coffee.png', 	    	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A hot cup of joe'},
	['coffee-beans'] 			     = {['name'] = 'coffee-beans', 			  	   	['label'] = 'Coffee Beans', 		['weight'] = 500, 		['type'] = 'item', 		['image'] = 'coffee-beans.png', 		  	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'coffee beans'},
	['coffee-cup'] 				     = {['name'] = 'coffee-cup', 			  	   	['label'] = 'Cup', 			        ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'coffee-cup.png', 			   	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'cup for coffee'},
	['espresso-coffee'] 		     = {['name'] = 'espresso-coffee', 			   	['label'] = 'Espresso', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'espresso-coffee.png', 	    	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A hot cup of espresso'},
	['latte-coffee'] 			     = {['name'] = 'latte-coffee', 			     	['label'] = 'Latte', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'latte-coffee.png', 	    	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A hot cup of latte'},
	['americano-coffee'] 		     = {['name'] = 'americano-coffee', 			   	['label'] = 'Americano', 			['weight'] = 500, 		['type'] = 'item', 		['image'] = 'americano-coffee.png', 	   	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A hot cup of americano'},
	
	--weedstuff
	['whitewidow-joint'] 			 = {['name'] = 'whitewidow-joint', 		   		['label'] = 'White Widow Joint',	['weight'] = 0, 		['type'] = 'item', 		['image'] = 'whitewidow-joint.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop joint'},
	['skunk-joint'] 				 = {['name'] = 'skunk-joint', 			   		['label'] = 'Skunk Joint', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'skunk-joint.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop joint'},
	['purplehaze-joint'] 			 = {['name'] = 'purplehaze-joint', 	  	  		['label'] = 'Purple Haze Joint', 	['weight'] = 0, 		['type'] = 'item', 		['image'] = 'purplehaze-joint.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop joint'},
	['ogkush-joint'] 				 = {['name'] = 'ogkush-joint', 			  		['label'] = 'OG Kush Joint', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'ogkush-joint.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop joint'},
	['amnesia-joint'] 				 = {['name'] = 'amnesia-joint',     	  		['label'] = 'Amnesia Joint', 		['weight'] = 0, 		['type'] = 'item', 		['image'] = 'amnesia-joint.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop joint'},
	['ak47-joint'] 					 = {['name'] = 'ak47-joint', 			  		['label'] = 'AK47 Joint', 			['weight'] = 0, 		['type'] = 'item', 		['image'] = 'ak47-joint.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop joint'},
	['coffeeshop-giftbox'] 			 = {['name'] = 'coffeeshop-giftbox', 		  	['label'] = '420 Gift Box', 		['weight'] = 500, 		['type'] = 'item', 		['image'] = 'coffeeshop-giftbox.png', 		['unique'] = true,   	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'A 420 coffeeshop Giftbox'},
	
}

```
## DISCLAIMER - Any item you add to the Giftbox,case must be in your shared/items.lua too. 
## Insert Contents of @coffeeshop/Images into @qb-inventory/HTML/Images

## Insert into qb-core/shared/jobs.lua
``` 
['420coffee'] = {
		label = '420 CoffeeShop',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 75
            },
			['2'] = {
                name = 'Manager',
                payment = 100
            },
			['3'] = {
                name = 'Owner',
                isboss = true,
                payment = 125
            },
        },
	},

    ```
    
