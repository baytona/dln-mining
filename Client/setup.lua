local QBCore = exports['qb-core']:GetCoreObject()
--[[NPC & Interactions]]--
--Setup NPC


local npc = nil
local smeltnpc = nil
local sellnpc = nil
CreateThread(function()
    setupBlips()
    RequestModel(GetHashKey("s_m_m_autoshop_02"))
	
    while not HasModelLoaded(GetHashKey("s_m_m_autoshop_02")) do
        Wait(1)
    end

    npc = CreatePed(4, 0xF06B849D, -594.88, 2090.22, 130.6, 55.36, false, true)

    FreezeEntityPosition(npc, true)
    SetEntityHeading(npc, 56.36)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    RequestAnimDict("anim@mp_corona_idles@male_d@idle_a")
    while not HasAnimDictLoaded("anim@mp_corona_idles@male_d@idle_a") do
    Wait(1000)
    end

    Wait(200)	
    TaskPlayAnim(npc,"anim@mp_corona_idles@male_d@idle_a","idle_a",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)

    -- Smelt NPC
    RequestModel(GetHashKey("mp_f_bennymech_01"))
	
    while not HasModelLoaded(GetHashKey("mp_f_bennymech_01")) do
        Wait(1)
    end

    smeltnpc = CreatePed(4, GetHashKey("mp_f_bennymech_01"), 2340.65, 3126.46, 47.21, 349.11, false, true)

    FreezeEntityPosition(smeltnpc, true)
    SetEntityHeading(smeltnpc, 349.11)
    SetEntityInvincible(smeltnpc, true)
    SetBlockingOfNonTemporaryEvents(smeltnpc, true)
    RequestAnimDict("amb@world_human_hang_out_street@Female_arm_side@idle_a")
    while not HasAnimDictLoaded("amb@world_human_hang_out_street@Female_arm_side@idle_a") do
    Wait(1000)
    end

    Wait(200)	
    TaskPlayAnim(smeltnpc,"amb@world_human_hang_out_street@Female_arm_side@idle_a","idle_a",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)

    -- Sell NPC
    RequestModel(GetHashKey("a_f_y_bevhills_04"))
	
    while not HasModelLoaded(GetHashKey("a_f_y_bevhills_04")) do
        Wait(1)
    end

    sellnpc = CreatePed(4, GetHashKey("a_f_y_bevhills_04"), -630.92, -229.83, 37.06, 349.11, false, true)

    FreezeEntityPosition(sellnpc, true)
    SetEntityHeading(sellnpc, 304.93)
    SetEntityInvincible(sellnpc, true)
    SetBlockingOfNonTemporaryEvents(sellnpc, true)
    RequestAnimDict("amb@world_human_hang_out_street@Female_arm_side@idle_a")
    while not HasAnimDictLoaded("amb@world_human_hang_out_street@Female_arm_side@idle_a") do
    Wait(1000)
    end

    Wait(200)	
    TaskPlayAnim(sellnpc,"amb@world_human_hang_out_street@Female_arm_side@idle_a","idle_a",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)

end)


--Add Target Actions
exports['qb-target']:AddTargetModel("s_m_m_autoshop_02", {
	options = {
		{
			event = "dln-mining:client:toggleSignIn",
			icon = "fas fa-clipboard",
			label = "Sign In/Out",
			canInteract = function(entity)
                if entity == npc then
                    return true
                end
			end, 
		},
	},
	distance = 2.5,
})

exports['qb-target']:AddTargetModel("mp_f_bennymech_01", {
	options = {
		{
            type = "server",
			event = "dln-mining:smeltStones",
			icon = "fas fa-fire-alt",
			label = "Smelt Ores",
			canInteract = function(entity)
                if entity == smeltnpc then
                    return true
                end
			end, 
		},
	},
	distance = 2.5,
})
exports['qb-target']:AddTargetModel("a_f_y_bevhills_04", {
	options = {
		{
            type = "server",
			event = "dln-mining:server:sellMinerals",
			icon = "fas fa-gem",
			label = "Sell Minerals",
			canInteract = function(entity)
                if entity == sellnpc then
                    return true
                end
			end, 
		},
	},
	distance = 2.5,
})
exports['qb-target']:AddTargetModel("prop_rock_4_c_2", {
	options = {
		{
            type = "client",
            event = "dln-mining:client:startMining",
            icon = "fas fa-sign-in-alt",
            label = "Start Mining",
            canInteract = function(entity, distance, data)
                if IsPedAPlayer(entity) then return false end
                if not signedIn then return false end
                return true
              end,
		},
	},
	distance = 2.5,
})
exports['qb-target']:AddTargetModel("prop_crate_05a", {
	options = {
		{
            type = "server",
            event = "dln-mining:washStones",
            icon = "fas fa-hands-wash",
            label = "Wash Stones",
		},
	},
	distance = 2.5,
})
  

function setupBlips()
    for k,v in pairs(Config.Blips) do
        local blip = AddBlipForCoord(v.pos)
        SetBlipSprite(blip, v.sprite)
        SetBlipDisplay(blip, 4)
		if k == 1 then
			SetBlipScale(blip, 0.6)
		else
			SetBlipScale(blip, 0.8)
		end
        SetBlipColour(blip, v.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)
    end
end