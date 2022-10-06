Config = {}
Config.MiningAreas = {
    vector3(-590.65, 2074.04, 130.3),
    vector3(-591.24, 2066.23, 130),
    vector3(-587.56, 2059.08, 129.64)    
}

Config.Resources = {
    {stone = 'diamond_stone', counterpart = 'diamond_washedstone', ore = 'diamond', price = math.random(110,134)},
    {stone = 'silver_stone', counterpart = 'silver_washedstone', ore = 'silver', price = math.random(62,89)},
    {stone = 'gold_stone', counterpart = 'gold_washedstone', ore = 'gold', price = math.random(89,110)},
}

Config.Blips = {
    {sprite = 653, label = "Mining Area", color = 43, pos = vector3(-596.46807861328,2089.3596191406,131.4126739502)},
    {sprite = 12, label = "Ore Smelting", color = 43, pos = vector3(2341.1784667969,3127.98046875,48.208740234375)},
    {sprite = 434, label = "Minerals Trader", color = 43, pos = vector3(-631.30017089844,-230.05151367188,38.057060241699)},
}