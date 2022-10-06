local QBCore = exports['qb-core']:GetCoreObject()
local signedIn = false
local impacts = 0
local mining = false

--Setup Rocks
CreateThread(function()
    RequestModel(390804950)
    while not HasModelLoaded(390804950) do
        Wait(1)
    end
    for k,v in pairs(Config.MiningAreas) do
        local x, y, z = table.unpack(v)
        CreateObject(390804950, x, y, z, true, true, false)
    end
end)

--Sign in Action
RegisterNetEvent('dln-mining:client:toggleSignIn', function()
    signedIn = not signedIn
    if signedIn then
        QBCore.Functions.Notify("Hey, welcome to the mines, I recommend bringing a flashlight...", "success")
        QBCore.Functions.Notify("Also, make sure you sign out before you leave.", "success")
    else
        QBCore.Functions.Notify("Thanks for the extra help, see you around.", "success")
        QBCore.Functions.Notify("Oh hey! Also, remember to wash your stones before you leave or else they wont smelt them.", "success")
        QBCore.Functions.Notify("Use the crate over there on the table, it has cleaning supplies in it.", "error")
    end
end)

--[[Actions]]--
RegisterNetEvent('dln-mining:client:startMining', function()
    if not signedIn then
        QBCore.Functions.Notify("You aren't signed in.", "error")
        return
    end
    if not mining then
        mining = true
        CreateThread(function()
            while impacts < 5 do
                Wait(1)
                local ped = PlayerPedId()	
                RequestAnimDict("melee@large_wpn@streamed_core")
                Wait(100)
                TaskPlayAnim((ped), 'melee@large_wpn@streamed_core', 'ground_attack_on_spot', 8.0, 8.0, -1, 80, 0, 0, 0, 0)
                SetEntityHeading(ped, 270.0)
                TriggerServerEvent('InteractSound_SV:PlayOnSource', 'pickaxe', 0.5)
                if impacts == 0 then
                    pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
                    AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
                end  
                Wait(2500)
                ClearPedTasks(ped)
                impacts = impacts+1
                if impacts == 5 then
                    DetachEntity(pickaxe, 1, true)
                    DeleteEntity(pickaxe)
                    DeleteObject(pickaxe)
                    mineActive = false
                    impacts = 0
                    mining = false
                    if signedIn then
                        TriggerServerEvent('dln-mining:giveStones')
                    end
                    break
                end   
            end
        end)
    else
        QBCore.Functions.Notify('You are already mining.')
    end
end)

RegisterNetEvent('dln-mining:washStonesCL', function()
	TriggerEvent('animations:client:EmoteCommandStart', {"petting"})
	QBCore.Functions.Progressbar("washingstones", "Washing Stones", math.random(15000, 35000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {},
	function() -- Done
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		TriggerServerEvent('dln-mining:giveWashedStones')
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		QBCore.Functions.Notify("Cancelled..", "error")
	end)
end)

RegisterNetEvent('dln-mining:smeltStonesCL', function()
	TriggerEvent('animations:client:EmoteCommandStart', {"petting"})
	QBCore.Functions.Progressbar("washingstones", "Smelting Stones", math.random(15000, 35000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {},
	function() -- Done
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		TriggerServerEvent('dln-mining:giveSmeltedStones')
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		QBCore.Functions.Notify("Cancelled..", "error")
	end)
end)

RegisterNetEvent('dln-mining:client:sellMinerals', function()
	QBCore.Functions.Progressbar("washingstones", "Selling Minerals", math.random(3000, 5000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {},
	function() -- Done
		TriggerServerEvent('dln-mining:giveMoneyForStones')
	end, function() -- Cancel
		QBCore.Functions.Notify("Cancelled..", "error")
	end)
end)