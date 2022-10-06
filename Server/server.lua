local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('dln-mining:smeltStones')
AddEventHandler('dln-mining:smeltStones', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hasresources = false
    for k,v in pairs(Config.Resources) do
        if Player.Functions.GetItemByName(v.counterpart) ~= nil then
            hasresources = true
        end
    end
    if hasresources then
        TriggerClientEvent('dln-mining:smeltStonesCL', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the required resources to do this.')
    end
end)

RegisterNetEvent('dln-mining:server:sellMinerals')
AddEventHandler('dln-mining:server:sellMinerals', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hasresources = false
    for k,v in pairs(Config.Resources) do
        if Player.Functions.GetItemByName(v.ore) ~= nil then
            hasresources = true
        end
    end
    if hasresources then
        TriggerClientEvent('dln-mining:client:sellMinerals', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the required resources to do this.')
    end
end)

RegisterNetEvent('dln-mining:giveStones')
AddEventHandler('dln-mining:giveStones', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    for k,v in pairs(Config.Resources) do
        local rando = math.random(1,3)
        if Player.Functions.AddItem(v.stone, rando) then
            stoneName2 = string.gsub(v.stone, "_stone", " Stone")
            stoneName2 = stoneName2:gsub("^%l", string.upper)
        else
            TriggerClientEvent('QBCore:Notify', src, "Insufficient room in your inventory", "error")
        end
    end
end)

RegisterNetEvent('dln-mining:washStones')
AddEventHandler('dln-mining:washStones', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local hasresources = false
    for k,v in pairs(Config.Resources) do
        if Player.Functions.GetItemByName(v.stone) ~= nil then
            hasresources = true
        end
    end
    if hasresources then
        TriggerClientEvent('dln-mining:washStonesCL', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the required resources to do this.')
    end
end)

RegisterNetEvent('dln-mining:giveWashedStones')
AddEventHandler('dln-mining:giveWashedStones', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k,v in pairs(Config.Resources) do
        if Player.Functions.GetItemByName(v.stone) ~= nil then
            local amt = Player.Functions.GetItemByName(v.stone).amount
            Player.Functions.RemoveItem(v.stone, amt)
            Player.Functions.AddItem(v.counterpart, amt)
            stoneName = string.gsub(v.counterpart, "_washedstone", " Washed Stone")
            stoneName2 = string.gsub(v.stone, "_stone", " Stone")
            stoneName = stoneName:gsub("^%l", string.upper)
            stoneName2 = stoneName2:gsub("^%l", string.upper)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, 'Hey, you can bring these down to the lady at the recycling center in Sandy Shores.', "success")
end)

RegisterNetEvent('dln-mining:giveSmeltedStones')
AddEventHandler('dln-mining:giveSmeltedStones', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k,v in pairs(Config.Resources) do
        if Player.Functions.GetItemByName(v.counterpart) ~= nil then
            local amt = Player.Functions.GetItemByName(v.counterpart).amount
            Player.Functions.RemoveItem(v.counterpart, amt)
            Player.Functions.AddItem(v.ore, amt)
            stoneName = string.gsub(v.counterpart, "_washedstone", " Washed Stone")
            stoneName = stoneName:gsub("^%l", string.upper)
            oreName = v.ore:gsub("^%l", string.upper)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, 'Thank you for your business, I heard that Vangelico is looking for some stones like these.', "success")

end)

RegisterNetEvent('dln-mining:giveMoneyForStones')
AddEventHandler('dln-mining:giveMoneyForStones', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local payment = 0
    for k,v in pairs(Config.Resources) do
        if Player.Functions.GetItemByName(v.ore) ~= nil then
            local amt = Player.Functions.GetItemByName(v.ore).amount
            Player.Functions.RemoveItem(v.ore, amt)
            payment = payment + v.price * amt
            oreName = v.ore:gsub("^%l", string.upper)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, 'Thank you, these stones will look great in some jewelry.', "success")
    Player.Functions.AddMoney('cash', payment)
end)