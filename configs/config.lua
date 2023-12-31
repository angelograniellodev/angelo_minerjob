Config = {}

Config.ESXOLD = false -- ESX OLD == TRUE  OR NO == FALSE

Config.Job = "miner"

Config.CustomSounds = true 

Config.Blips = {
    {title="Central  De Minero", colour=31, id=486, scale = 1.0, x = 2827.793457, y = 2808.949463, z = 54.42}, 
    {title="Lavadero De Mineros", colour=18, id=685, scale = 1.0, x = -1563.177979, y = 2152.523193, z = 54.42},
    {title="Joyeria", colour=5, id=674, scale = 1.0, x = -1393.384644, y = -253.002197, z = 54.42},
}

Config.displayText = true -- Whether you want the heading text to show or not
Config.displayDistance = 5.0 -- From how far to start displaying text
Config.displayColor = "~g~"
Config.Peds = {
    {2827.793457, 2808.949463, 57.385376, 187.086609, 0x917ED459,"mp_m_weed_01", "Tienda De Mineria", "mini@strip_club@idles@bouncer@base", "base"},
    {-1393.384644, -253.002197, 43.147217, 226.771667, 0xF161D212,"s_m_m_highsec_01", "Venta De Joyas", "mini@strip_club@idles@bouncer@base", "base"}
}

Config.Central = {
    coords = vector3(2832.329590, 2808.000000, 57.385376),
    text_ui = "PRESIONA ~g~[E]~w~ PARA ENTRAR EN ~y~SERVICIO",
    distance = 2,
    onDuty = false,
}

Config.Garage = { 
    coords = vector3(2827.964844, 2800.074707, 57.199951),
    distance = 3, 
    text_ui = "PRESIONA ~g~[E]~w~ PARA SACAR/GUARDAR UN ~y~VEHICULO DE TRABAJO",
    heading_spawn  = 175.748032,
    spawn_code = "bobcatxl",
    vehicle_marker = true,
    vehicle = nil, --dont touch
}

--Mining Config
Config.Objects = {
    ['pickaxe'] = 'prop_tool_pickaxe',
}
Config.ItemsMining = {
    pickaxe = "pickaxe",
    drill  = "drill",
}

Config.MiningPositions = {
    {
        --Coords
        coords = vector3(2944.272461, 2772.949463, 38.221191), 
        heading = 99.212593,
        --Items
        item_name = "goldore", 
        item_count_minime = 1,
        item_count_max = 5,
        --Text Ui  
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~y~ORO",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        --Random 
        porcent_probability = 50,
        --Data 
        type = "mining",
    },
    {
        coords = vector3(2947.516602, 2772.738525, 38.120117), 
        heading = 82.204727,
        item_name = "goldore", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~y~ORO",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 50,
        type = "mining",
    },
    {
        coords = vector3(2945.076904, 2775.006592, 38.255005), 
        heading = 39.685040,
        item_name = "goldore", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~y~ORO",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 70,
        type = "mining",
    },
    --Silver
    {
        coords = vector3(2941.318604, 2774.373535, 38.255005), 
        heading = 53.858269,
        item_name = "uncut_silver", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~y~PLATA",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 70,
        type = "mining",
    },
    {
        coords = vector3(2940.540771, 2777.736328, 38.288696), 
        heading = 153.070862,
        item_name = "uncut_silver", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~y~PLATA",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 30,
        type = "mining",
    },
    {
        coords = vector3(2936.769287, 2776.734131, 38.136963), 
        heading = 257.952759,
        item_name = "uncut_silver", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~y~PLATA",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 70,
        type = "mining",
    },
    --Emerald
    {
        coords = vector3(2943.191162, 2783.287842, 38.659302), 
        heading = 221.102371,
        item_name = "uncut_emerald", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~g~ESMERALDA",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 30,
        type = "mining",
    },
    {
        coords = vector3(2941.595703, 2780.307617, 38.372925), 
        heading = 255.118103,
        item_name = "uncut_emerald", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~g~ESMERALDA",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 30,
        type = "mining",
    },
    {
        coords = vector3(2945.564941, 2779.727539, 38.423462), 
        heading = 39.685040,
        item_name = "uncut_emerald", 
        item_count_minime = 1,
        item_count_max = 5,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~g~ESMERALDA",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 30,
        type = "mining",
    },
    --Diamonds
    {
        coords = vector3(2982.0, 2824.0010, 45.893799), 
        heading = 303.307098,
        item_name = "uncut_diamond", 
        item_count_minime = 1,
        item_count_max = 2,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~b~DIAMANTE",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 90,
        type = "drill",
    }, 
    {
        coords = vector3(2984.0, 2821.3, 45.80454), 
        heading = 308.976379,
        item_name = "uncut_diamond", 
        item_count_minime = 1,
        item_count_max = 2,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~b~DIAMANTE",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 90,
        type = "drill",
    }, 
    {
        coords = vector3(2985.2, 2819.2, 45.992725), 
        heading = 294.803162,
        item_name = "uncut_diamond", 
        item_count_minime = 1,
        item_count_max = 2,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~b~DIAMANTE",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 90,
        type = "drill",
    },
    --Ruby ore
    {
        coords = vector3(3003.0, 2789.314209, 44.41101), 
        heading = 291.968506,
        item_name = "uncut_ruby", 
        item_count_minime = 1,
        item_count_max = 2,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~r~RUBY",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 90,
        type = "drill",
    },
    {
        coords = vector3(3004.0, 2786.518799, 44.259399), 
        heading = 291.968506,
        item_name = "uncut_ruby", 
        item_count_minime = 1,
        item_count_max = 2,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~r~RUBY",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 90,
        type = "drill",
    },
    {
        coords = vector3(3005.000006, 2784.2, 44.7), 
        heading = 291.968506,
        item_name = "uncut_ruby", 
        item_count_minime = 1,
        item_count_max = 2,
        ui_text = "PRESION ~g~[E]~w~ PARA MINAR ~r~RUBY",
        ui_text_help = "PRESION TECLA ~r~[BORRAR] ~w~PARA CANCELAR O EL ~r~[CLICK] ~w~PARA MINAR",
        porcent_probability = 90,
        type = "drill",
    },
}

--Process Ores 

Config.WashPositions = {
    {
        --Coords
        coords = vector3(-1562.927490, 2153.894531, 52.212402), 
        --Items
        request_item = "stone",
        request_item_count = 5,
        reward_item = "goldore", 
        reward_item_count = 1,
        --Text Ui  
        ui_text = "PRESION ~g~[E]~w~ LAVAR EL ~y~ORO",
        --Random 
        porcent_probability = 50,
        --Data 
        type = "mining",
        --Animation and props
        anim_dict = "amb@world_human_gardener_plant@female@base",
        anim_base = "base_female",
        prop = "bzzz_prop_mine_bowl_gold_b",
        propbone = 18905,
        PropPlacement = {0.2, 0.3, -0.2, 0.0, -110.0, 0.0},
    },
}

Config.OvenPositions = {
    {
        --Coords
        coords = vector3(2953.938477, 2750.861572, 42.517944),
        heading = 43.52, 
        --Items
        request_item = "goldore",
        request_item_count = 5,
        reward_item = "goldbar", 
        reward_item_count = 1,
        request_item_coal = "carbon",
        request_item_coal_count = 2,
        --Text Ui  
        ui_text = "PRESION ~g~[E]~w~ FUNDIR EL ~y~ORO",
        --Animation and props
        anim_dict = "pickup_object",
        anim_base = "pickup_low",
        --PROGRES BAR LABEL 
        progressbar_duration = 6500, 
        progressbar_label = "COCINANDO PEPITA DE ORO",
    },
    {
        coords = vector3(2951.406494, 2750.624268, 42.450562),
        heading = 43.52, 
        request_item = "goldore",
        request_item_count = 5,
        reward_item = "goldbar", 
        reward_item_count = 1,
        request_item_coal = "carbon",
        request_item_coal_count = 2, 
        ui_text = "PRESION ~g~[E]~w~ FUNDIR EL ~y~ORO",
        anim_dict = "pickup_object",
        anim_base = "pickup_low",
        progressbar_duration = 6500, 
        progressbar_label = "COCINANDO PEPITA DE ORO",
    },
}

Config.CutMachinePositions = {
    {
        --Coords
        coords = vector3(2944.918701, 2744.294434, 42.265259),
        heading = 104.881889, 
        ui_text = "PRESION ~g~[E]~w~ PARA USAR LA ~r~MAQUINA",
    },
}

Config.CraftingPositions = {
    {
        coords = vector3(2943.942871, 2748.105469, 43.349487),
        heading = 110.551186, 
        ui_text = "PRESION ~g~[E]~w~ PARA CONSTRUIR ~b~MATERIALES",
    },
}

Config.ItemsCrafting = {
	['goldring'] = {
		label = 'Anillo De Oro',
		craftingtime = 20000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 1 },
            { item = "silverore", item_label = "Barra De Silver", amount = 4 },
		}
	},
    ['goldchain'] = {
		label = 'Collar De Oro',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 2 },
            { item = "silverore", item_label = "Barra De Silver", amount = 6 },
		}
	},
    ['diamondring'] = {
		label = 'Anillo De Diamante',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 2 },
            { item = "silverore", item_label = "Barra De Silver", amount = 10 },
            { item = "diamond", item_label = "Barra De Silver", amount = 1 },
		}
	},
    ['diamondchain'] = {
		label = 'Collar De Diamantes',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 3 },
            { item = "silverore", item_label = "Barra De Silver", amount = 15 },
            { item = "diamond", item_label = "Barra De Silver", amount = 2 },
		}
	},
    ['emeraldring'] = {
		label = 'Anillo De Esmeralda',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 2 },
            { item = "silverore", item_label = "Barra De Silver", amount = 10 },
            { item = "emerald", item_label = "Barra De Silver", amount = 1 }
		}
	},
    ['emeraldchain'] = {
		label = 'Collar De Esmeralda',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 2 },
            { item = "silverore", item_label = "Barra De Silver", amount = 15 },
            { item = "emerald", item_label = "Barra De Silver", amount = 2 }
		}
	},
    ['rubyring'] = {
		label = 'Anillo De Ruby',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 2 },
            { item = "silverore", item_label = "Barra De Silver", amount = 10 },
            { item = "ruby", item_label = "Barra De Silver", amount = 1 }
		}
	},
    ['rubychain'] = {
		label = 'Collar De Ruby',
		craftingtime = 25000,
		requiredItems = {
			{ item = "goldbar", item_label = "Barra De Oro", amount = 2 },
            { item = "silverore", item_label = "Barra De Silver", amount = 15 },
            { item = "ruby", item_label = "Barra De Silver", amount = 2 }
		}
	},
}

Config.SellOresPositions = {
    {
        coords = vector3(-1392.092285, -254.189011, 43.147217),
        ui_text = "PRESION ~g~[E]~w~ ~g~ VENDER ~y~JOYAS",
    },
}

Config.SellItems = {

	['goldring'] = {
		label = 'Anillo De Oro',
		min = 5,
		max = 20,
		price = 1200
	},
	
	['goldchain'] = {
		label = 'Cadena De Oro',
		min = 5,
		max = 20,
		price = 1500
	},

    ['diamondring'] = {
		label = 'Anillo De Diamante',
		min = 1,
		max = 20,
		price = 2500
	},
	
    ['diamondchain'] = {
		label = 'Collar De Diamantes',
		min = 1,
		max = 20,
		price = 3500
	},

    ['emeraldring'] = {
		label = 'Anillo De Esmeralda',
		min = 1,
		max = 20,
		price = 1900
	},
    ['emeraldchain'] = {
		label = 'Collar De Esmeralda',
		min = 1,
		max = 20,
		price = 2300
	},
    ['rubyring'] = {
		label = 'Anillo De Ruby',
		min = 1,
		max = 20,
		price = 3500
	},
    ['rubychain'] = {
		label = 'Collar De Ruby',
		min = 1,
		max = 20,
		price = 4500
	},
}

Config.Uniform = {
    male = {
        ['tshirt_1'] = 195,  ['tshirt_2'] = 0,
        ['torso_1'] = 350,   ['torso_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 208,   ['pants_2'] = 2,
        ['shoes_1'] = 37,   ['shoes_2'] = 2,
        ['helmet_1'] = 169,  ['helmet_2'] = 0,
    },
    female = {
        ['tshirt_1'] = 168,  ['tshirt_2'] = 0,
        ['torso_1'] = 361,   ['torso_2'] = 0,
        ['arms'] = 0,
        ['pants_1'] = 213,   ['pants_2'] = 2,
        ['shoes_1'] = 4,   ['shoes_2'] = 3,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
    }
}