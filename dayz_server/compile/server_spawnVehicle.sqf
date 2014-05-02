/* 
			created by Kenturrac
	based on original spawn script "spawn_vehicles"
*/
private ["_typeToSpawn","_minDmg","_maxDmg","_dmgType","_spawnLocationType","_position","_dir","_temploop","_istoomany","_veh",
		"_marker","_allCfgLoots","_iClass","_itemTypes","_index","_location","_worldspace","_num","_weights","_cntWeights","_itemType",
		"_characterID","_uid","_damage","_array","_dam","_fuel","_hitpoints","_selection","_tempArray","_key"];

_typeToSpawn = _this select 0;
_minDmg = _this select 1;
_maxDmg = _this select 2;
_dmgType = _this select 3;
_spawnLocationType = _this select 4;
diag_log format["Veh-Spawn: _typeToSpawn: %1. _minDmg: %2. _maxDmg: %3. _dmgType: %4. _spawnLocationType: %5", _typeToSpawn, _minDmg, _maxDmg, _dmgType, _spawnLocationType];

// find spawnlocation - set up the rules how ever you want it here 
// in this case:
//	0 - spawn around buildings and next to roads - LAND
//	1 - spawn in water next to the shore - Sea
//	2 - spawn anywhere that is flat and not close to the debug area - Air
//	3 - spawn on defined locations - Huey
//	4 - m240 HUMVEE

if (_spawnLocationType == 0) then {
	// Spawn around buildings and 50% near roads
	if((random 1) > 0.65) then {
		while {true} do {
			waitUntil{!isNil "BIS_fnc_selectRandom"};
			_position = RoadList call BIS_fnc_selectRandom;
			_position = _position modelToWorld [0,0,0];
			waitUntil{!isNil "BIS_fnc_findSafePos"};
			_position = [_position,0,15,10,0,2000,0] call BIS_fnc_findSafePos;
			
			// check if more vehicles around
			_istoomany = _position nearObjects ["AllVehicles",50];
			if((count _istoomany) == 0) exitWith { /* diag_log format["Veh-Spawn: Found spawnpoint."]; */ };
		};
		//diag_log("Veh-Spawn: spawning near road " + str(_position));
	
	} else {
		while {true} do {
			waitUntil{!isNil "BIS_fnc_selectRandom"};
			_position = BuildingList call BIS_fnc_selectRandom;
			_position = _position modelToWorld [0,0,0];
			waitUntil{!isNil "BIS_fnc_findSafePos"};
			_position = [_position,0,40,5,0,2000,0] call BIS_fnc_findSafePos;
			
			// check if more vehicles around
			_istoomany = _position nearObjects ["AllVehicles",50];
			if((count _istoomany) == 0) exitWith { /* diag_log format["Veh-Spawn: Found spawnpoint."]; */ };
		};
		//diag_log("Veh-Spawn: spawning around buildings " + str(_position));
	};
	_dir = round(random 180);
};

if (_spawnLocationType == 1) then {
	// Spawn anywhere on coast on water
	while {true} do {
		waitUntil{!isNil "BIS_fnc_findSafePos"};
		_position = [MarkerPosition,0,DynamicVehicleArea,10,1,2000,1] call BIS_fnc_findSafePos;
		
		// check if more vehicles around
		_istoomany = _position nearObjects ["AllVehicles",50];
		if((count _istoomany) == 0) exitWith { /* diag_log format["Veh-Spawn: Found spawnpoint."]; */ };
	};
	//diag_log("Veh-Spawn: spawning boat near coast " + str(_position));
	_dir = round(random 180);
};

if (_spawnLocationType == 2) then {
	// Spawn air anywhere that is flat
	_temploop = true;
	while {_temploop} do {
		waitUntil{!isNil "BIS_fnc_findSafePos"};
		_position = [MarkerPosition,0,DynamicVehicleArea,50,0,2000,0] call BIS_fnc_findSafePos;
		if (((_position select 0)>900) &&((_position select 1)<13364)) then {			//check if pos is in defined spawn area
			// check if more vehicles around
			_istoomany = _position nearObjects ["AllVehicles",50];
			if((count _istoomany) == 0) then { 
				_temploop = false;
			};
		};
	};
	//diag_log("Veh-Spawn: spawning air anywhere flat " + str(_position));
	_dir = round(random 180);
};

if (_spawnLocationType == 3) then {
	// Spawn on defined locations - Huey
	while {true} do {
		waitUntil{!isNil "BIS_fnc_selectRandom"};
		_position = SpawnpointsHuey call BIS_fnc_selectRandom;
		_dir = _position select 3;
		_position resize 3;

		// check if more vehicles around
		_istoomany = _position nearObjects ["AllVehicles",10];
		if((count _istoomany) == 0) exitWith { /* diag_log format["Veh-Spawn: Found spawnpoint."]; */ };
	};
	//diag_log("Veh-Spawn: spawning huey at specific position " + str(_position));
};

//unused right now
if (_spawnLocationType == 4) then {
	// Spawn on defined locations - M240
		while {true} do {
		waitUntil{!isNil "BIS_fnc_selectRandom"};
		_position = SpawnpointsM240HUMVEE call BIS_fnc_selectRandom;
		_dir = _position select 3;
		_position resize 3;

		// check if more vehicles around
		_istoomany = _position nearObjects ["AllVehicles",10];
		if((count _istoomany) == 0) exitWith { /* diag_log format["Veh-Spawn: Found spawnpoint."]; */ };
	};
	//diag_log("Veh-Spawn: spawning m240humvee at specific position " + str(_position));
};

// only proceed if two params otherwise BIS_fnc_findSafePos failed and may spawn in air
if ((count _position) >= 2) then { 
	
	// create vehicle 
	_veh = createVehicle [_typeToSpawn, _position, [], 0, "CAN_COLLIDE"];
	_veh setdir _dir;
	_veh setpos _position;

	// debug stuff
	if(DZEdebug) then {
		_marker = createMarker [str(_position) , _position];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "DOT";
		_marker setMarkerText _typeToSpawn;
	};	

	// get position aligned with ground
	_location = getPosATL _veh;
	
	// create position including direction
	_worldspace = [_dir,_location];

	//	defince cargo
	clearWeaponCargoGlobal  _veh;
	clearMagazineCargoGlobal  _veh;
	// _veh setVehicleAmmo DZE_vehicleAmmo;

	// Add 0-3 loots to vehicle using random cfgloots 
	_num = floor(random 4);
	_allCfgLoots = ["trash","civilian","food","generic","medical","military","policeman","hunter","worker","clothes","militaryclothes","specialclothes","trash"];

	for "_x" from 1 to _num do {
		_iClass = _allCfgLoots call BIS_fnc_selectRandom;

		_itemTypes = [];
		if (DZE_MissionLootTable) then {
			_itemTypes = ((getArray (missionConfigFile >> "cfgLoot" >> _iClass)) select 0);
		} else {
			_itemTypes = ((getArray (configFile >> "cfgLoot" >> _iClass)) select 0);
		};

		_index = dayz_CLBase find _iClass;
		_weights = dayz_CLChances select _index;
		_cntWeights = count _weights;
		
		_index = floor(random _cntWeights);
		_index = _weights select _index;
		_itemType = _itemTypes select _index;
		_veh addMagazineCargoGlobal [_itemType,1];
		//diag_log("Veh-Spawn: spawed loot inside vehicle " + str(_itemType));
	};

	_characterID = "0";
		
	//Generate UID test using time
	// _uid = str( round (dateToNumber date)) + str(round time);
	_uid = _worldspace call dayz_objectUID2;
	//_uid = format["%1%2",(round time),_uid];
	
	// set damage values to vehicle
	_damage = 0;
	_array = [];
	_dam = 0;
	_fuel = 0;
	if (getNumber(configFile >> "CfgVehicles" >> _typeToSpawn >> "isBicycle") != 1) then {

		// just set low base dmg - may change later
		_damage = 0;	
	
		// generate damage on all parts depending the damage type
		if (_dmgType == 0) then {												//maybe drivable/flyable
			_hitpoints = _veh call vehicle_getHitpoints;
			//diag_log format["Veh-Spawn: _hitpoints of %1: %2.",_typeToSpawn ,_hitpoints];
			{
				_dam = ((random(_maxDmg-_minDmg))+_minDmg) / 100;
				_selection = getText(configFile >> "cfgVehicles" >> _typeToSpawn >> "HitPoints" >> _x >> "name");
				if (_dam > 0) then {
					_array set [count _array,[_selection,_dam]];
				};
				//diag_log format["Veh-Spawn: %1 - Set _dam of %2 to: %3",_typeToSpawn, _selection ,_dam];
			} forEach _hitpoints;	
		
		} else {																// undrivable/unflyable
			if (_veh isKindOf "Land") then {
				_hitpoints = _veh call vehicle_getHitpoints;
				{
					// generate damage on all parts depending on the values
					_dam = ((random(_maxDmg-_minDmg))+_minDmg) / 100;
					_selection = getText(configFile >> "cfgVehicles" >> _typeToSpawn >> "HitPoints" >> _x >> "name");
					_tempArray = toArray _selection;
					_tempArray resize 5;
					if (toString _tempArray == "wheel") then {			// check if it's a wheel
						if ((random 1) > 0.5) then {			// 50% chance to kill the wheel
							if (_dam > 0) then {
								_array set [count _array,[_selection,_dam]];
							};
						} else {
							_array set [count _array,[_selection,1]];
						};
					} else {											// if not, just do random dmg
						if (_dam > 0) then {
							_array set [count _array,[_selection,_dam]];
						};
					};
					//diag_log format["Veh-Spawn: %1 - Set _dam of %2 to: %3",_typeToSpawn, _selection ,_dam];
				} forEach _hitpoints;	
			};
			
			if (_veh isKindOf "Air") then {
				_hitpoints = _veh call vehicle_getHitpoints;
				{
					// generate damage on all parts depending on the values
					_dam = ((random(_maxDmg-_minDmg))+_minDmg) / 100;
					_selection = getText(configFile >> "cfgVehicles" >> _typeToSpawn >> "HitPoints" >> _x >> "name");
					if (_dam > 0) then {
						_array set [count _array,[_selection,_dam]];
					};
					//diag_log format["Veh-Spawn: %1 - Set _dam of %2 to: %3",_typeToSpawn, _selection ,_dam];
				} forEach _hitpoints;	
				
				// this will make the chopper leak
				_damage = 0.5;	
			};
			
			if (_veh isKindOf "Sea") then {
				//ignore since it doesn't matter what you set here
			};
		};
		
		// New fuel min max 
		if ((_veh isKindOf "Air") && (_dmgType == 1)) then {
			_fuel = 0;
		} else {
			_fuel = (random(_maxDmg-_minDmg)) / 100;
		};
		//diag_log format["Veh-Spawn: Set _fuel to: %1",_fuel];
	};

	// TODO: check if uid already exists and if so increment by 1 and check again as soon as we find nothing continue.

	//Send request
	_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance, _typeToSpawn, _damage , _characterID, _worldspace, [], _array, _fuel,_uid];
	diag_log ("HIVE: WRITE: "+ str(_key)); 
	_key call server_hiveWrite;

	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_veh];

	// Switched to spawn so we can wait a bit for the ID
	[_veh,_uid,_fuel,_damage,_array,_characterID,_typeToSpawn] spawn {
		private["_object","_uid","_fuel","_damage","_array","_characterID","_done","_retry","_key","_result","_outcome","_oid","_selection","_dam","_typeToSpawn"];

		_object = _this select 0;
		_uid = _this select 1;
		_fuel = _this select 2;
		_damage = _this select 3;
		_array = _this select 4;
		_characterID = _this select 5;
		_typeToSpawn = _this select 6;

		_done = false;
		_retry = 0;
		// TODO: Needs major overhaul
		while {_retry < 10} do {
			sleep 1;
			// GET DB ID
			_key = format["CHILD:388:%1:",_uid];
			diag_log ("HIVE: WRITE: "+ str(_key));
			_result = _key call server_hiveReadWrite;
			_outcome = _result select 0;
			if (_outcome == "PASS") then {
				_oid = _result select 1;
				_object setVariable ["ObjectID", _oid, true];
				diag_log("CUSTOM: Selected " + str(_oid));
				_done = true;
				_retry = 100;
			} else {
				diag_log("CUSTOM: trying again to get id for: " + str(_uid));
				_done = false;
			};
			_retry = _retry + 1;
		};
		if(!_done) exitWith { deleteVehicle _object; diag_log("CUSTOM: failed to get id for : " + str(_uid)); };

		_object setVariable ["lastUpdate",time];
		_object setVariable ["CharacterID", _characterID, true];
		_object setDamage _damage;

		// Set Hits after ObjectID is set
		{
			_selection = _x select 0;
			_dam = _x select 1;
			if (_selection in dayZ_explosiveParts and _dam > 0.8) then {_dam = 0.8};
			[_object,_selection,_dam] call object_setFixServer;
		} forEach _array;
		
		_object setFuel _fuel;
		
		_object setvelocity [0,0,1];

		_object call fnc_veh_ResetEH;

		// testing - should make sure everyone has eventhandlers for vehicles was unused...
		PVDZE_veh_Init = _object;
		publicVariable "PVDZE_veh_Init";

		diag_log ("PUBLISH: Created " + (_typeToSpawn) + " with ID " + str(_uid));
	};
	
	
} else {
	diag_log("Veh-Spawn: ERROR - No vehicle spawned. _position incorrect: " + str(count _position));
};