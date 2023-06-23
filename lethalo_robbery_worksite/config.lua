-- Made by Lethalo

Config = {}

Config.RespawnTime = 120 -- In minutes
Config.StayTime = 5 -- Time object stay there when you are leaving
Config.PoliceCount = 0 -- Min Police Needed

Config.TimeWhenAlertForCameras = 10 -- In Seconds
Config.TimeWhenSpawnForObjects = 3 -- In Seconds
Config.SendDispatchToCops = 20 -- In Seconds

Config.Inventory = 'qs-inventory' -- qs-inventory or qb-inventory

-- After suffle item list, this is the amount of object that will not spawn
Config.MinusTotalItem = 4 -- Should Never be more than min item in Config.Zones

Config.UsePsDispatch = true -- If set to false check client.lua Line 146

Config.Zones = { -- Polyzone
    [1] = {
        dots = {
            vector2(117.8639907837, -460.19625854492),
            vector2(154.38139343262, -356.8360900879),
            vector2(43.311721801758, -315.71417236328),
            vector2(-5.1887884140014, -452.95779418946),
            vector2(33.618659973144, -460.2241821289)
        },
        options ={
            name = "chantiera",
            debugPoly = false,
            maxZ = 80.0
        }
    },
    [2] = {
        dots =  {
            vector2(-220.06838989258, -1113.8122558594),
            vector2(-126.44193267822, -1112.021118164),
            vector2(-64.934242248536, -963.80834960938),
            vector2(-158.0572052002, -928.99017333984)
        },
        options = {
            name = "chantierb",
            debugPoly = false,
            maxZ = 80.0
        }
    },
    [3] = {
        dots = {
            vector2(-447.60580444336, -1082.9138183594),
            vector2(-436.44314575196, -1045.0927734375),
            vector2(-435.9055480957, -993.86938476562),
            vector2(-441.31832885742, -957.74426269532),
            vector2(-439.36459350586, -879.55010986328),
            vector2(-474.9912109375, -871.4839477539),
            vector2(-515.91571044922, -971.80963134766),
            vector2(-507.94647216796, -1056.1657714844)
        },
        options = {
            name = "chantierc",
            debugPoly = false,
            maxZ = 80.0
        }
    }
}

Config.MarkerType = 20 -- See https://docs.fivem.net/docs/game-references/markers/

Config.Items = { -- Model to load must match with Config.Spawns "item"

    scie = 'prop_tool_consaw', -- scie = saw
    drill = 'prop_tool_drill',
    tuyau = 'prop_byard_pipes01',
    vis = 'prop_tool_box_04',

}

Config.Spawns = {
    [1] = {
        {item = 'scie', position = vector3(59.69, -369.79, 40.61)},
        {item = 'scie', position = vector3(86.05, -447.97, 38.24)},

        {item = 'vis', position = vector3(45.39, -396.74, 38.90)},
        {item = 'vis', position = vector3(38.76, -425.47, 38.90)},
        {item = 'vis', position = vector3(16.31, -430.73, 38.85)},

        {item = 'drill', position = vector3(91.36, -411.45, 37.66)},

        {item = 'tuyau', position = vector3(77.48, -435.84, 36.53)},
    },
    [2] = {
        {item = 'scie', position = vector3(-180.3, -1088.29, 17.69)},
        {item = 'scie', position = vector3(-158.25, -1065.68, 17.69)},

        {item = 'vis', position = vector3(-144.83, -1099.67, 17.69)},
        {item = 'vis', position = vector3(-174.76, -1108.22, 17.69)},
        {item = 'vis', position = vector3(-165.01, -1097.26, 35.14)},

        {item = 'drill', position = vector3(-165.73, -1082.92, 29.14)},
        {item = 'drill', position = vector3(-140.74, -1074.24, 29.14)},
        

        {item = 'tuyau', position = vector3(-144.29, -1101.9, 29.14)},
        {item = 'tuyau', position = vector3(-159.27, -1069.45, 35.14)},

    },
    [3] = {
        {item = 'scie', position = vector3(-456.86, -1024.03, 22.62)},
        {item = 'scie', position = vector3(-457.32, -900.3, 37.68)},

        {item = 'vis', position = vector3(-482.36, -990.28, 22.55)},
        {item = 'vis', position = vector3(-444.83, -929.51, 28.39)},
        {item = 'vis', position = vector3(-454.72, -931.17, 37.68)},
        {item = 'vis', position = vector3(-463.34, -1048.72, 39.81)},
        {item = 'vis', position = vector3(-469.95, -1048.96, 22.55)},

        {item = 'drill', position = vector3(-442.55, -966.33, 24.9)},
        {item = 'drill', position = vector3(-469.14, -956.88, 37.68)},

        {item = 'tuyau', position = vector3(-487.17, -1014.89, 22.55)},
        {item = 'tuyau', position = vector3(-491.17, -1016.08, 39.81)},
        {item = 'tuyau', position = vector3(-455.52, -1008.13, 22.86)},
    },
}

Config.Translation = {
    Recolt = "Récupérer...",
    FirstEntrance = "Le chantier est interdit au public",
    SecondEntrance = "...Il y a peut être du matériel utile",
    AlertCams = "Des caméras vous surveillent",
    Heavy = "Vous êtes encombrer"
}