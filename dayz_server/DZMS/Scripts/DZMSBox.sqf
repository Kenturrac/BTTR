/*
	Usage: [_crate,"type"] execVM "dir\DZMSBox.sqf";
		_crate is the crate to fill
		"type" is the type of crate
		"type" can be weapons or medical
*/
_crate = _this select 0;
_type = _this select 1;

// Clear the current cargo
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

// Define lists. Some lists are defined in DZMSWeaponCrateList.sqf in the ExtConfig.
_bpackList = ["DZ_Patrol_Pack_EP1","DZ_Assault_Pack_EP1","DZ_Czech_Vest_Puch","DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_CivilBackpack_EP1","DZ_Backpack_EP1","DZ_TerminalPack_EP1","DZ_CompactPack_EP1"];
_gshellList = ["HandGrenade_west","FlareGreen_M203","FlareWhite_M203","FlareRed_M203","SmokeShellRed","SmokeShellYellow","HandRoadFlare"];
_medical = ["ItemBandage","ItemMorphine","ItemEpinephrine","ItemPainkiller","FoodMRE","ItemAntibiotic","ItemBloodbag"];
_money = ["ItemSilverBar","ItemSilverBar2oz","ItemSilverBar3oz","ItemSilverBar4oz","ItemSilverBar5oz","ItemSilverBar6oz","ItemSilverBar7oz","ItemSilverBar8oz","ItemSilverBar9oz","ItemSilverBar10oz","ItemGoldBar","ItemGoldBar2oz","ItemGoldBar3oz","ItemGoldBar4oz","ItemGoldBar5oz","ItemGoldBar6oz","ItemGoldBar7oz","ItemGoldBar8oz","ItemGoldBar9oz","ItemGoldBar10oz"];

//////////////////////////////////////////////////////////////////
// Medical Crates

if (_type == "medical") then {
	
	_scount = count _medical;
	for "_x" from 0 to 15 do {
		_sSelect = floor(random _sCount);
		_item = _medical select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
	
		_scount = count _medical;
	for "_x" from 6 to 9 do {
		_sSelect = floor(random _sCount);
		_item = _medical select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
	_scount = count DZMSResidentalList;
	for "_x" from 1 to 4 do {
		_sSelect = floor(random _sCount);
		_item = DZMSResidentalList select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
		_scount = count DZMSTools;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
};

//////////////////////////////////////////////////////////////////
// Ikea Crates Big

if (_type == "Ikea") then {
	
	_scount = count DZMSIkeaListBig;
	for "_x" from 5 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListBig select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
		_scount = count DZMSIkeaListWoodpack;
	for "_x" from 5 to 12 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListWoodpack select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
		_scount = count DZMSIkeaListCinder;
	for "_x" from 1 to 4 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListCinder select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
		_scount = count DZMSIkeaListMetal;
	for "_x" from 0 to 6 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListMetal select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
		_scount = count DZMSTools;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
		_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
	
		_scount = count _bpackList;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	
		_scount = count DZMSIkeaListWeapons;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListWeapons select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
		_scount = count DZMSIkeaListBuild;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListBuild select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
		
};

//////////////////////////////////////////////////////////////////
// Ikea Crates small

if (_type == "Ikeasmall") then {
	
	_scount = count DZMSIkeaListBig;
	for "_x" from 5 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListBig select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
			_scount = count DZMSIkeaListWood;
	for "_x" from 15 to 25 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListWood select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
			_scount = count DZMSIkeaListCinder;
	for "_x" from 5 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListCinder select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
	_scount = count DZMSTools;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
	
		_scount = count _bpackList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	
};

//////////////////////////////////////////////////////////////////
// Ikea Crates Wood

if (_type == "IkeaWood") then {
	
	_scount = count DZMSIkeaListBig;
	for "_x" from 2 to 8 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListBig select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
	
		_scount = count DZMSIkeaListWeapons;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListWeapons select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
		_scount = count DZMSIkeaListWood;
	for "_x" from 5 to 20 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListWood select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
		scount = count DZMSIkeaListWoodpack;
	for "_x" from 5 to 12 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListWoodpack select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
	_scount = count DZMSTools;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _bpackList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	
};

//////////////////////////////////////////////////////////////////
// Ikea Crates Cinder

if (_type == "IkeaCinder") then {
	
	_scount = count DZMSIkeaListBig;
	for "_x" from 2 to 6 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListBig select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
		_scount = count DZMSIkeaListCinder;
	for "_x" from 1 to 5 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListCinder select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 3))];
	};
	
			_scount = count DZMSIkeaListCinder;
	for "_x" from 3 to 5 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListCinder select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
	_scount = count DZMSTools;
	for "_x" from 2 to 4 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
	};
	
	_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _bpackList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	
};

//////////////////////////////////////////////////////////////////
// Ikea Crates Metal

if (_type == "IkeaMetal") then {
	
	_scount = count DZMSIkeaListBig;
	for "_x" from 0 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListBig select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
	
		_scount = count DZMSIkeaListMetal;
	for "_x" from 5 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSIkeaListMetal select _sSelect;
		_crate addMagazineCargoGlobal [_item,2];
	};
	
	_scount = count DZMSTools;
	for "_x" from 2 to 4 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _bpackList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	
};

//////////////////////////////////////////////////////////////////
// Skin Crates

if (_type == "Skins") then {
	
	_scount = count DZMSSkinNormList;
	for "_x" from 3 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSSkinNormList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
	
	_scount = count DZMSSkinSpezialList;
	for "_x" from 1 to 3 do {
		_sSelect = floor(random _sCount);
		_item = DZMSSkinSpezialList select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};

	_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
	_scount = count DZMSTools;
	for "_x" from 1 to 3 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 2))];
	};
	
		_scount = count DZMSToolsSpez;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSToolsSpez select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 2))];
	};
		
			_scount = count DZMSResidentalList;
	for "_x" from 0 to 4 do {
		_sSelect = floor(random _sCount);
		_item = DZMSResidentalList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 4))];
	};
		
};

//////////////////////////////////////////////////////////////////
// Residental Crates

if (_type == "Residental") then {
	
	_scount = count DZMSResidentalList;
	for "_x" from 0 to 6 do {
		_sSelect = floor(random _sCount);
		_item = DZMSResidentalList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};

		_scount = count DZMSResidentalList;
	for "_x" from 3 to 5 do {
		_sSelect = floor(random _sCount);
		_item = DZMSResidentalList select _sSelect;
		_crate addMagazineCargoGlobal [_item,3];
	};
	
	_scount = count _medical;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = _medical select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 3))];
	};

	_scount = count DZMSTools;
	for "_x" from 1 to 3 do {
		_sSelect = floor(random _sCount);
		_item = DZMSTools select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
		_scount = count _bpackList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	
	_scount = count DZMSpistolList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSpistolList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 5))];
		};
	};
	
		_scount = count DZMSprimaryList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSprimaryList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 5))];
		};
	};
	
};

//////////////////////////////////////////////////////////////////
// Ammo Crates 

if (_type == "Ammo") then {
	
	_scount = count DZMSWeapAmmoList;
	for "_x" from 4 to 10 do {
		_sSelect = floor(random _sCount);
		_item = DZMSWeapAmmoList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 8))];
	};

		_scount = count DZMSVehicleAmmoList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSVehicleAmmoList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 1))];
	};
	
	_scount = count DZMSsniperList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSsniperList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 5))];
		};
	};
	
		_scount = count DZMSprimaryList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSprimaryList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 5))];
		};
	};
	
		_scount = count _money;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
	
			_scount = count DZMSToolsSpez;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSToolsSpez select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 3))];
	};
	
};
	
///////////////////////////////////////////////////////////////////
// Weapon Crates
if (_type == "weapons") then {
	// load grenades
	_scount = count _gshellList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = _gshellList select _sSelect;
		_crate addMagazineCargoGlobal [_item,(round(random 2))];
	};
   
	// load packs
	_scount = count _bpackList;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = _bpackList select _sSelect;
		_crate addBackpackCargoGlobal [_item,1];
	};
	 
	// load pistols
	_scount = count DZMSpistolList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSpistolList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load sniper
	_scount = count DZMSsniperList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSsniperList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load mg
	_scount = count DZMSmgList;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSmgList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};

	//load primary
	_scount = count DZMSprimaryList;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSprimaryList select _sSelect;
		_crate addWeaponCargoGlobal [_item,1];
		_ammo = [] + getArray (configFile >> "cfgWeapons" >> _item >> "magazines");
		if (count _ammo > 0) then {
			_crate addMagazineCargoGlobal [(_ammo select 0),(round(random 8))];
		};
	};
	
			_scount = count DZMSToolsSpez;
	for "_x" from 0 to 1 do {
		_sSelect = floor(random _sCount);
		_item = DZMSToolsSpez select _sSelect;
		_crate addWeaponCargoGlobal [_item,(round(random 2))];
	};
	
};

/*///////////////////////////////////////////////////////////////////
// Epoch Supply Crates
if (_type == "supply") then {
	// load tools
	_scount = count DZMSConTools;
	for "_x" from 0 to 2 do {
		_sSelect = floor(random _sCount);
		_item = DZMSConTools select _sSelect;
		_crate addWeaponCargoGlobal [_item, 1];
	};
	
	// load construction
	_scount = count DZMSConSupply;
	for "_x" from 0 to 30 do {
		_sSelect = floor(random _sCount);
		_item = DZMSConSupply select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
};

///////////////////////////////////////////////////////////////////
// Epoch Money Crates
if (_type == "money") then {
	// load money
	_scount = count _money;
	for "_x" from 0 to 3 do {
		_sSelect = floor(random _sCount);
		_item = _money select _sSelect;
		_crate addMagazineCargoGlobal [_item,1];
	};
};

*/