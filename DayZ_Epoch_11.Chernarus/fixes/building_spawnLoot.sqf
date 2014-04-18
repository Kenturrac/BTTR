	

    private["_obj","_type","_config","_positions","_iPos","_nearBy","_itemType","_itemTypes","_itemChances","_lootChance","_weights","_cntWeights","_index","_LootClass"];
     
    _obj =                  _this select 0;
    _type =                 typeOf _obj;
    _config =               configFile >> "CfgBuildingLoot" >> _type;
    _positions =    [] + getArray (_config >> "lootPos");
    //_itemTypes =  [] + getArray (_config >> "itemType"); // Default System
    _lootChance =   getNumber (_config >> "lootChance");
     
    //------------------//
    //CUSTOM LOOT SPAWNS//
    //------------------//
    _itemTypes = []; //Initialise array
    _itemChance = []; //Initialise array
     
    diag_log "SPAWNING WITH CUSTOM LOOT";//Remove This line after testing
     
    switch (_type) do { //Assign building classes
            case "Land_HouseV_1I4": { _LootClass = "Residential"; };
            case "Land_kulna": { _LootClass = "Residential"; };
            case "Land_Ind_Workshop01_04": { _LootClass = "Industrial"; };
            case "Land_hut06": { _LootClass = "Residential"; };
            case "Land_Hlidac_budka": { _LootClass = "Residential"; };
            case "Land_HouseV2_02_Interier": { _LootClass = "Residential"; };
            case "Land_A_Pub_01": { _LootClass = "Residential"; };
            case "Land_Shed_wooden": { _LootClass = "Residential"; };
            case "Land_HouseBlock_A1_1": { _LootClass = "Residential"; };
            case "Land_A_MunicipalOffice": { _LootClass = "Residential"; };
            case "Land_ruin_01": { _LootClass = "Residential"; };
            case "Land_HouseV2_04_interier": { _LootClass = "Residential"; };
            case "Land_HouseV2_01A": { _LootClass = "Residential"; };
            case "Land_psi_bouda": { _LootClass = "Residential"; };
            case "Land_KBud": { _LootClass = "Residential"; };
            case "Land_A_Castle_Bergfrit": { _LootClass = "Residential"; };
            case "Land_A_Castle_Stairs_A": { _LootClass = "Residential"; };
            case "Land_A_Castle_Gate": { _LootClass = "Residential"; };
            case "Land_sara_domek_zluty": { _LootClass = "Residential"; };
            case "Land_Church_01": { _LootClass = "Residential"; };
            case "Land_Church_03": { _LootClass = "Residential"; };
            case "Land_HouseB_Tenement": { _LootClass = "Residential"; };
            case "Land_Panelak": { _LootClass = "Residential"; };
            case "Land_Panelak2": { _LootClass = "Residential"; };
            case "Land_rail_station_big": { _LootClass = "Residential"; };
            case "Land_A_Office01": { _LootClass = "Residential"; };
            case "Land_A_Office02": { _LootClass = "Residential"; };
            case "Land_Ind_Workshop01_01": { _LootClass = "Industrial"; };
            case "Land_Ind_Garage01": { _LootClass = "Industrial"; };
            case "Land_Ind_Workshop01_02": { _LootClass = "Industrial"; };
            case "Land_Ind_Workshop01_L": { _LootClass = "Industrial"; };
            case "Land_Hangar_2": { _LootClass = "Industrial"; };
            case "Land_A_FuelStation_Build": { _LootClass = "Industrial"; };
            case "Land_Shed_Ind02": { _LootClass = "Industrial"; };
            case "Land_Misc_PowerStation": { _LootClass = "Industrial"; };
            case "Land_Shed_W01": { _LootClass = "Industrial"; };
            case "Land_Tovarna2": { _LootClass = "Industrial"; };
            case "Land_Ind_Vysypka": { _LootClass = "Industrial"; };
            case "Land_A_BuildingWIP": { _LootClass = "Industrial"; };
            case "Land_A_TVTower_Base": { _LootClass = "Industrial"; };
            case "Land_Misc_Cargo1Ao": { _LootClass = "Industrial"; };
            case "Land_Misc_Cargo1Bo": { _LootClass = "Industrial"; };
            case "Land_Nav_Boathouse": { _LootClass = "Industrial"; };
            case "Land_wagon_box": { _LootClass = "Industrial"; };
            case "Land_Rail_House_01": { _LootClass = "Industrial"; };
            case "Land_A_GeneralStore_01a": { _LootClass = "Supermarket"; };
            case "Land_A_GeneralStore_01": { _LootClass = "Supermarket"; };
            case "Land_A_Hospital": { _LootClass = "Hospital"; };
            case "MASH": { _LootClass = "Hospital"; };
            case "MASH_EP1": { _LootClass = "Hospital"; };
            case "USMC_WarfareBFieldhHospital": { _LootClass = "Hospital"; };
            case "Land_a_stationhouse": { _LootClass = "Military"; };
            case "Land_Mil_ControlTower": { _LootClass = "Military"; };
            case "Land_SS_hangar": { _LootClass = "Military"; };
            case "Land_Mil_House": { _LootClass = "Military"; };
            case "Camp": { _LootClass = "Military"; };
            case "CampEast": { _LootClass = "Military"; };
            case "CampEast_EP1": { _LootClass = "Military"; };
            case "Land_Mil_Barracks_i": { _LootClass = "MilitarySpecial"; };
            case "Land_Misc_deerstand": { _LootClass = "Hunting"; };
            case "Land_stodola_old_open": { _LootClass = "Farm"; };
            case "Land_Farm_Cowshed_a": { _LootClass = "Farm"; };
            case "Land_stodola_open": { _LootClass = "Farm"; };
            case "Land_Barn_W_01": { _LootClass = "Farm"; };
            case "Land_Barn_W_02": { _LootClass = "Farm"; };
            default { _LootClass = "Residential"; };
    };
     
    switch (_LootClass) do { //Find correct loot
            case "Residential": {
                    _itemTypes = [
                            ["ItemSodaMdew","magazine"],
                            ["ItemWatch","generic"],
                            ["ItemCompass","generic"],
                            ["ItemMap","weapon"],
                            ["Makarov","weapon"],
                            ["Colt1911","weapon"],
                            ["ItemFlashlight","generic"],
                            ["ItemKnife","generic"],
                            ["ItemMatchbox","generic"],
                            ["","generic"],
                            ["LeeEnfield","weapon"],
                            ["revolver_EP1","weapon"],
                           
                            ["DZ_Assault_Pack_EP1","object"], // 12
                            ["DZ_Czech_Vest_Puch","object"], // 12-0
                            ["DZ_ALICE_Pack_EP1","object"], // 16
                            ["DZ_TK_Assault_Pack_EP1","object"], // 16
                            ["DZ_British_ACU","object"], // 18
                           
                            ["Winchester1866","weapon"],
                            ["WeaponHolder_ItemTent","object"],
                            ["","military"],
                            ["","trash"],
                            ["Crossbow_DZ","weapon"],
                            ["Binocular","weapon"],
                            ["PartWoodPile","magazine"],
                            ["Skin_Camo1_DZ","magazine"],
                            ["Skin_Sniper1_DZ","magazine"],
                            ["WeaponHolder_ItemCrowbar","object"],
                            ["MR43","weapon"] // Remember the last object doesn't not need a comma
                     ];
                    _itemChance = [
                            0.01,
                            0.15,
                            0.05,
                            0.03,
                            0.13,
                            0.05,
                            0.03,
                            0.08,
                            0.06,
                            2,
                            0.06,
                            0.04,
                            0.05, //12
                            0.04, // 12-0
                            0.02, //16
                            0.02, //16
                            0.01, //18
                            0.01,
                            0.01,
                            0.03,
                            0.5,
                            0.01,
                            0.06,
                            0.06,
                            0.01,
                            0.01,
                            0.08,
                            0.03
                    ];
            };
            case "Industrial": {
                    _itemTypes = [
                            ["","generic"],
                            ["","trash"],
                            ["","military"],
                            ["WeaponHolder_PartGeneric","object"],
                            ["WeaponHolder_PartWheel","object"],
                            ["WeaponHolder_PartFueltank","object"],
                            ["WeaponHolder_PartEngine","object"],
                            ["WeaponHolder_PartGlass","object"],
                            ["WeaponHolder_PartVRotor","object"],
                            ["WeaponHolder_ItemJerrycan","object"],
                            ["WeaponHolder_ItemHatchet","object"],
                            ["ItemKnife","military"],
                            ["ItemToolbox","weapon"],
                            ["ItemWire","magazine"],
                            ["ItemTankTrap","magazine"]
                    ];
                    _itemChance = [
                            0.18,
                            0.29,
                            0.04,
                            0.04,
                            0.05,
                            0.02,
                            0.02,
                            0.04,
                            0.01,
                            0.04,
                            0.11,
                            0.07,
                            0.06,
                            0.01,
                            0.04
                    ];
            };
            case "Farm": {
                    _itemTypes = [
                            ["WeaponHolder_ItemJerrycan","object"],
                            ["","generic"],
                            ["huntingrifle","weapon"],
                            ["LeeEnfield","weapon"],
                            ["Winchester1866","weapon"],
                            ["","trash"],
                            ["Crossbow_DZ","weapon"],
                            ["PartWoodPile","magazine"],
                            ["WeaponHolder_ItemHatchet","object"],
                            ["MR43","weapon"],
                            ["WeaponHolder_ItemMachete","object"]
                    ];
                    _itemChance = [
                            0.06,
                            0.28,
                            0.01,
                            0.04,
                            0.03,
                            0.22,
                            0.03,
                            0.11,
                            0.17,
                            0.06,
                            0.03
                    ];
            };
            case "Supermarket": {
                    _itemTypes = [
                            ["ItemWatch","generic"],
                            ["ItemCompass","generic"],
                            ["ItemMap","weapon"],
                            ["Makarov","weapon"],
                            ["Colt1911","weapon"],
                            ["ItemFlashlight","generic"],
                            ["ItemKnife","generic"],
                            ["ItemMatchbox","generic"],
                            ["","generic"],
                            ["LeeEnfield","weapon"],
                            ["revolver_EP1","weapon"],
                                           
                            ["DZ_Assault_Pack_EP1","object"], // 12
                            ["DZ_Czech_Vest_Puch","object"], // 12-0
                            ["DZ_ALICE_Pack_EP1","object"], // 16
                            ["DZ_TK_Assault_Pack_EP1","object"], // 16
                            ["DZ_British_ACU","object"], // 18
                           
                            ["Winchester1866","weapon"],
                            ["WeaponHolder_ItemTent","object"],
                            ["","food"],
                            ["","trash"],
                            ["Crossbow_DZ","weapon"],
                            ["Binocular","weapon"],
                            ["PartWoodPile","magazine"],
                            ["MR43","weapon"]
                    ];
                    _itemChance = [
                            0.15,
                            0.01,
                            0.05,
                            0.02,
                            0.02,
                            0.05,
                            0.02,
                            0.05,
                            0.05,
                            0.01,
                            0.01,
                            0.05, //12
                            0.04, // 12-0
                            0.02, //16
                            0.02, //16
                            0.01, //18
                            0.01,
                            0.01,
                            0.3,
                            0.15,
                            0.01,
                            0.05,
                            0.02,
                            0.01
                    ];
            };
            case "Hospital": {
                    _itemTypes =    [
                            ["","trash"],
                            ["","hospital"],
                            ["MedBox0","object"]
                    ];
                    _itemChance = [
                            0.2,
                            1,
                            0.2
                    ];
            };
            case "Military": {
                    _itemTypes = [
                            ["M9","weapon"],
                            ["M16A2","weapon"],
                            ["M16A2GL","weapon"],
                            ["M9SD","weapon"],
                            ["AK_74","weapon"],
                            ["M4A1_Aim","weapon"],
                            ["AKS_74_kobra","weapon"],
                            ["AKS_74_U","weapon"],
                            ["AK_47_M","weapon"],
                            ["M24","weapon"],
                            ["M1014","weapon"],
                            ["DMR","weapon"],
                            ["M4A1","weapon"],
                            ["M14_EP1","weapon"],
                            ["UZI_EP1","weapon"],
                            ["Remington870_lamp","weapon"],
                            ["glock17_EP1","weapon"],
                            ["MP5A5","weapon"],
                            ["MP5SD","weapon"],
                            ["M4A3_CCO_EP1","weapon"],
                            ["Binocular","weapon"],
                            ["ItemFlashlightRed","military"],
                            ["ItemKnife","military"],
                            ["ItemGPS","weapon"],
                            ["ItemMap","military"],
                           
                            ["DZ_ALICE_Pack_EP1","object"], // 16
                            ["DZ_TK_Assault_Pack_EP1","object"], // 16
                            ["DZ_British_ACU","object"], // 18
                            ["DZ_CivilBackpack_EP1","object"], // 24
                            ["DZ_Backpack_EP1","object"], // 24
                           
                            //Normal
                            ["","medical"],
                            ["","generic"],
                            ["","military"],
                            //["Body","object"],
                            ["ItemEtool","weapon"],
                            ["ItemSandbag","magazine"],
                            ["Sa58P_EP1","weapon"],
                            ["Sa58V_EP1","weapon"],
                            ["BAF_L85A2_RIS_Holo","weapon"]
                    ];
                    _itemChance = [
                            0.05,
                            0.05,
                            0.01,
                            0.02,
                            0.15,
                            0.01,
                            0.08,
                            0.05,
                            0.05,
                            0.01,
                            0.10,
                            0.01,
                            0.02,
                            0.01,
                            0.05,
                            0.08,
                            0.10,
                            0.04,
                            0.02,
                            0.01,
                            0.06,
                            0.10,
                            0.10,
                            0.01,
                            0.05,
                            //Bags
                            0.08, //16
                            0.08, //16
                            0.06, //18
                            0.01, //24
                            0.01, //DZ_Backpack_EP1 24
                            0.10,
                            1.00,
                            2.50,
                            //0.20,
                            0.05,
                            0.02,
                            0.03,
                            0.03,
                            0.01
                    ];
            };
            case "MilitarySpecial": {
                    _itemTypes = [
                            ["M16A2","weapon"],
                            ["M16A2GL","weapon"],
                            ["M249_DZ","weapon"],
                            ["M9SD","weapon"],
                            //["M136","weapon"],
                            ["AK_74","weapon"],
                            ["M4A1_Aim","weapon"],
                            ["AKS_74_kobra","weapon"],
                            ["AKS_74_U","weapon"],
                            ["AK_47_M","weapon"],
                            ["M24","weapon"],
                            ["SVD_CAMO","weapon"],
                            ["M1014","weapon"],
                            ["M107_DZ","weapon"],
                            ["DMR","weapon"],
                            ["M4A1","weapon"],
                            ["M14_EP1","weapon"],
                            ["UZI_EP1","weapon"],
                            ["Remington870_lamp","weapon"],
                            ["glock17_EP1","weapon"],
                            ["M240_DZ","weapon"],
                            ["M4A1_AIM_SD_camo","weapon"],
                            ["M16A4_ACG","weapon"],
                            ["M4A1_HWS_GL_camo","weapon"],
                            ["Mk_48_DZ","weapon"],
                            ["M4A3_CCO_EP1","weapon"],
                            //Ammo
                            ["AmmoBoxSmall_556","object"],
                            ["AmmoBoxSmall_762","object"],
     
                            //["NVGoggles","weapon"],
                            ["Binocular","weapon"],
                            ["ItemFlashlightRed","military"],
                            ["ItemKnife","military"],
                            ["ItemGPS","weapon"],
                            ["ItemMap","military"],
                            ["Binocular_Vector","military"],
     
                            ["DZ_ALICE_Pack_EP1","object"], // 16
                            ["DZ_TK_Assault_Pack_EP1","object"], // 16
                            ["DZ_British_ACU","object"], // 18
                            ["DZ_CivilBackpack_EP1","object"], // 24
                            ["DZ_Backpack_EP1","object"], // 24            
     
                            ["","medical"],
                            ["","generic"],
                            ["","military"],
                            //["Body","object"],
                            ["PipeBomb","magazine"],
                            ["Sa58V_RCO_EP1","weapon"],
                            ["Sa58V_CCO_EP1","weapon"],
                            //["G36_C_SD_camo","weapon"],
                            ["M40A3","weapon"],
                            ["100Rnd_762x54_PK","magazine"]
                    ];
                    _itemChance = [
                            0.10,
                            0.05,
                            0.01,
                            0.02,
                            //0.01, //m136
                            0.10,
                            0.02,
                            0.10,
                            0.10,
                            0.10,
                            0.01,
                            0.01,
                            0.20,
                            0.01,
                            0.02,
                            0.10,
                            0.03,
                            0.20,
                            0.10,
                            0.20,
                            0.01,
                            0.04,
                            0.05,
                            0.02,
                            0.01,
                            0.08,
                            0.04,
                            0.02,
                            //0.01, //NVGoggles
                            0.10,
                            0.05,
                            0.15,
                            0.01, //ItemGPS
                            0.03,
                            0.01,
                            //Bags
                            0.08, //16
                            0.08, //16
                            0.06, //18
                            0.01, //24
                            0.01, //DZ_Backpack_EP1 24
                            0.30,
                            1.00,
                            5.00, //military
                            //0.20,
                            0.01, //PipeBomb
                            0.01, //Sa58V_RCO_EP1
                            0.01, //Sa58V_CCO_EP1
                            //0.01, //["G36_C_SD_camo","weapon"],
                            0.02, // M40A3
                            0.01    //["100Rnd_762x54_PK","magazine"]
                    ];
            };
            case "Hunting": {
                    _itemTypes = [
                            ["ItemMap","weapon"],
                            ["ItemFlashlight","generic"],
                            ["ItemKnife","generic"],
                            ["ItemMatchbox","generic"],
                            ["Crossbow_DZ","weapon"],
                            ["","military"],
                            ["WeaponHolder_ItemMachete", "object"],
                            ["huntingrifle","weapon"],
                            ["","hunter"]
                    ];
                    _itemChance = [
                            0.08,
                            0.05,
                            0.04,
                            0.06,
                            0.03,
                            2.00,
                            0.03,
                            0.04,
                            3.00
                    ];
            };
    };
    //------------------//
    //CUSTOM LOOT SPAWNS//
    //------------------//
    {
            if ((random 1) < _lootChance) then {
                    _iPos = _obj modelToWorld _x;
                    _nearBy = nearestObjects [_iPos, ["WeaponHolder","WeaponHolderBase"], 1];
                    if (count _nearBy == 0) then {
                            private["_index"];
                            _weights = [_itemTypes,_itemChance] call fnc_buildWeightedArray;
                            _index = _weights call BIS_fnc_selectRandom;
                            _itemType = _itemTypes select _index;
                            [_itemType select 0, _itemType select 1 , _iPos, 0.0]  call spawn_loot;
                    };
            };
    } forEach _positions;

