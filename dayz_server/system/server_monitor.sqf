private ["_resultLand","_resultAir","_resultSea","_VSL_Land","_lastIndex_VSL_Land","_VSL_Air","_lastIndex_VSL_Air","_VSL_Sea","_lastIndex_VSL_Sea","_vehicleAmountIn_VSL_Land","_vehicleAmountIn_VSL_Air","_vehicleAmountIn_VSL_Sea","_vehiclesWithOwner","_vehiclesWithoutOwner","_vehiclesWithoutOwner_Air","_vehiclesWithoutOwner_Sea","_vehiclesWithoutOwner_Land","_vehiclesToSpawn_Air","_vehiclesToSpawn_Sea","_vehiclesToSpawn_Land","_nul","_result","_pos","_wsDone","_dir","_isOK","_countr","_objWpnTypes","_objWpnQty","_dam","_selection","_totalvehicles","_object","_idKey","_type","_ownerID","_worldspace","_intentory","_hitPoints","_fuel","_damage","_key","_vehLimit","_hiveResponse","_objectCount","_codeCount","_data","_status","_val","_traderid","_retrader","_traderData","_id","_lockable","_debugMarkerPosition","_vehicle_0","_bQty","_vQty","_BuildingQueue","_objectQueue","_superkey","_shutdown","_res","_hiveLoaded"];

dayz_versionNo = 		getText(configFile >> "CfgMods" >> "DayZ" >> "version");
dayz_hiveVersionNo = 	getNumber(configFile >> "CfgMods" >> "DayZ" >> "hiveVersion");

_hiveLoaded = false;

_cpcimmune =[
"CinderWallHalf_DZ",
"CinderWall_DZ",
"CinderWallDoorway_DZ",
"MetalFloor_DZ",
"CinderWallDoorSmallLocked_DZ",
"CinderWallSmallDoorway_DZ",
"CinderWallDoor_DZ",
"Fence_corrugated_DZ",
"MetalPanel_DZ"
];

waitUntil{initialized}; //means all the functions are now defined

diag_log "HIVE: Starting";

waituntil{isNil "sm_done"}; // prevent server_monitor be called twice (bug during login of the first player)

if (isNil "server_initCount") then {
	server_initCount = 1;
} else {
	server_initCount = server_initCount + 1;
};
diag_log format["server_monitor.sqf execution count = %1", server_initCount];
	
// Custom Configs
if(isnil "MaxVehicleLimit") then {
	MaxVehicleLimit = 50;
};

if(isnil "MaxDynamicDebris") then {
	MaxDynamicDebris = 100;
};
if(isnil "MaxAmmoBoxes") then {
	MaxAmmoBoxes = 3;
};
if(isnil "MaxMineVeins") then {
	MaxMineVeins = 50;
};
// Custon Configs End

if (isServer and isNil "sm_done") then {

	serverVehicleCounter = [];
	_hiveResponse = [];

	for "_i" from 1 to 5 do {
		diag_log "HIVE: trying to get objects";
		_key = format["CHILD:302:%1:", dayZ_instance];
		_hiveResponse = _key call server_hiveReadWrite;  
		if ((((isnil "_hiveResponse") || {(typeName _hiveResponse != "ARRAY")}) || {((typeName (_hiveResponse select 1)) != "SCALAR")})) then {
			if ((_hiveResponse select 1) == "Instance already initialized") then {
				_superkey = profileNamespace getVariable "SUPERKEY";
				_shutdown = format["CHILD:400:%1:", _superkey];
				_res = _shutdown call server_hiveReadWrite;
				diag_log ("HIVE: attempt to kill.. HiveExt response:"+str(_res));
			} else {
				diag_log ("HIVE: connection problem... HiveExt response:"+str(_hiveResponse));
			
			};
			_hiveResponse = ["",0];
		} 
		else {
			diag_log ("HIVE: found "+str(_hiveResponse select 1)+" objects" );
			_i = 99; // break
		};
	};
	
	_BuildingQueue = [];
	_objectQueue = [];
	
	if ((_hiveResponse select 0) == "ObjectStreamStart") then {
	
		// save superkey
		profileNamespace setVariable ["SUPERKEY",(_hiveResponse select 2)];
		saveProfileNamespace;
		
		_hiveLoaded = true;
	
		diag_log ("HIVE: Commence Object Streaming...");
		_key = format["CHILD:302:%1:", dayZ_instance];
		_objectCount = _hiveResponse select 1;
		_bQty = 0;
		_vQty = 0;
		for "_i" from 1 to _objectCount do {
			_hiveResponse = _key call server_hiveReadWriteLarge;
			//diag_log (format["HIVE dbg %1 %2", typeName _hiveResponse, _hiveResponse]);
			if ((_hiveResponse select 2) isKindOf "ModularItems") then {
				_BuildingQueue set [_bQty,_hiveResponse];
				_bQty = _bQty + 1;
			} else {
				_objectQueue set [_vQty,_hiveResponse];
				_vQty = _vQty + 1;
			};
		};
		diag_log ("HIVE: got " + str(_bQty) + " Epoch Objects and " + str(_vQty) + " Vehicles");
	};
	
	// # NOW SPAWN OBJECTS #
	_totalvehicles = 0;
	_vehiclesWithOwner = 0;
	_vehiclesWithoutOwner = 0;
	_vehiclesWithoutOwner_Air = 0;
	_vehiclesWithoutOwner_Sea = 0;
	_vehiclesWithoutOwner_Land = 0;
	
	// VSL - Vehicle
	_VSL_Land = VehicleSpawnList_Land;
	_lastIndex_VSL_Land = (count _VSL_Land) - 1;
	_vehicleAmountIn_VSL_Land = 0;
	for "_x" from 0 to _lastIndex_VSL_Land do {
		_vehicleAmountIn_VSL_Land = _vehicleAmountIn_VSL_Land + ((_VSL_Land select _x) select 1); 
	};
	diag_log format["Veh-Spawn: Amount of vehicles in VehicleSpawnList_Land: %1", _vehicleAmountIn_VSL_Land];
	if (_vehicleAmountIn_VSL_Land < MaxVehicleLimit_Land) then {
		diag_log format["HIVE: Warning - Not enough Land vehicle in the list to reach the Land vehicle maximum. Have to fill the server with vehicles from the generic list. Vehicles in the list: %1. Max Land vehicles: %2", _vehicleAmountIn_VSL_Land, MaxVehicleLimit_Land];
	};
	
	_VSL_Air = VehicleSpawnList_Air;
	_lastIndex_VSL_Air = (count _VSL_Air) - 1;
	_vehicleAmountIn_VSL_Air = 0;
	for "_x" from 0 to _lastIndex_VSL_Air do {
		_vehicleAmountIn_VSL_Air = _vehicleAmountIn_VSL_Air + ((_VSL_Air select _x) select 1); 
	};
	diag_log format["Veh-Spawn: Amount of vehicles in VehicleSpawnList_Air: %1", _vehicleAmountIn_VSL_Air];
	if (_vehicleAmountIn_VSL_Air < MaxVehicleLimit_Air) then {
		diag_log format["HIVE: Warning - Not enough Air vehicle in the list to reach the Air vehicle maximum. Have to fill the server with vehicles from the generic list. Vehicles in the list: %1. Max Air vehicles: %2", _vehicleAmountIn_VSL_Air, MaxVehicleLimit_Air];
	};
	
	_VSL_Sea = VehicleSpawnList_Sea;
	_lastIndex_VSL_Sea = (count _VSL_Sea) - 1;
	_vehicleAmountIn_VSL_Sea = 0;
	for "_x" from 0 to _lastIndex_VSL_Sea do {
		_vehicleAmountIn_VSL_Sea = _vehicleAmountIn_VSL_Sea + ((_VSL_Sea select _x) select 1); 
	};
	diag_log format["Veh-Spawn: Amount of vehicles in VehicleSpawnList_Sea: %1", _vehicleAmountIn_VSL_Sea];
	if (_vehicleAmountIn_VSL_Sea < MaxVehicleLimit_Sea) then {
		diag_log format["HIVE: Warning - Not enough Sea vehicle in the list to reach the Sea vehicle maximum. Have to fill the server with vehicles from the generic list. Vehicles in the list: %1. Max Sea vehicles: %2", _vehicleAmountIn_VSL_Sea, MaxVehicleLimit_Sea];
	};
	
	{
		_idKey = 		_x select 1;
		_type =			_x select 2;
		_ownerID = 		_x select 3;

		_worldspace = 	_x select 4;
		_intentory =	_x select 5;
		_hitPoints =	_x select 6;
		_fuel =			_x select 7;
		_damage = 		_x select 8;
		
		_dir = 0;
		_pos = [0,0,0];
		_wsDone = false;
		if (count _worldspace >= 2) then
		{
			_dir = _worldspace select 0;
			if (count (_worldspace select 1) == 3) then {
				_pos = _worldspace select 1;
				_wsDone = true;
			}
		};			
		
		if (!_wsDone) then {
			if (count _worldspace >= 1) then { _dir = _worldspace select 0; };
			_pos = [getMarkerPos "center",0,4000,10,0,2000,0] call BIS_fnc_findSafePos;
			if (count _pos < 3) then { _pos = [_pos select 0,_pos select 1,0]; };
			diag_log ("MOVED OBJ: " + str(_idKey) + " of class " + _type + " to pos: " + str(_pos));
		};
		

		if (_damage < 1) then {
			//diag_log format["OBJ: %1 - %2", _idKey,_type];
			
			//Create it
			_object = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
			_object setVariable ["lastUpdate",time];
			_object setVariable ["ObjectID", _idKey, true];

			_lockable = 0;
			if(isNumber (configFile >> "CfgVehicles" >> _type >> "lockable")) then {
				_lockable = getNumber(configFile >> "CfgVehicles" >> _type >> "lockable");
			};

			// fix for leading zero issues on safe codes after restart
			if (_lockable == 4) then {
				_codeCount = (count (toArray _ownerID));
				if(_codeCount == 3) then {
					_ownerID = format["0%1", _ownerID];
				};
				if(_codeCount == 2) then {
					_ownerID = format["00%1", _ownerID];
				};
				if(_codeCount == 1) then {
					_ownerID = format["000%1", _ownerID];
				};
			};

			if (_lockable == 3) then {
				_codeCount = (count (toArray _ownerID));
				if(_codeCount == 2) then {
					_ownerID = format["0%1", _ownerID];
				};
				if(_codeCount == 1) then {
					_ownerID = format["00%1", _ownerID];
				};
			};

			_object setVariable ["CharacterID", _ownerID, true];
			
			clearWeaponCargoGlobal  _object;
			clearMagazineCargoGlobal  _object;
			// _object setVehicleAmmo DZE_vehicleAmmo;
			
			_object setdir _dir;
			_object setposATL _pos;
			_object setDamage _damage;
// ### [CPC] Indestructible Buildables Fix
							if (typeOf(_object) in _cpcimmune) then {
									_object addEventHandler ["HandleDamage", {false}];
									_object enableSimulation false;
							};
// ### [CPC] Indestructible Buildables Fix
			if ((typeOf _object) in dayz_allowedObjects) then {
				if (DZE_GodModeBase) then {
					_object addEventHandler ["HandleDamage", {false}];
				} else {
					_object addMPEventHandler ["MPKilled",{_this call object_handleServerKilled;}];
				};
				// Test disabling simulation server side on buildables only.
				_object enableSimulation false;
				// used for inplace upgrades and lock/unlock of safe
				_object setVariable ["OEMPos", _pos, true];
				
			};

			if (count _intentory > 0) then {
				if (_type in DZE_LockedStorage) then {
					// Fill variables with loot
					_object setVariable ["WeaponCargo", (_intentory select 0)];
					_object setVariable ["MagazineCargo", (_intentory select 1)];
					_object setVariable ["BackpackCargo", (_intentory select 2)];
				} else {

					//Add weapons
					_objWpnTypes = (_intentory select 0) select 0;
					_objWpnQty = (_intentory select 0) select 1;
					_countr = 0;					
					{
						if(_x in (DZE_REPLACE_WEAPONS select 0)) then {
							_x = (DZE_REPLACE_WEAPONS select 1) select ((DZE_REPLACE_WEAPONS select 0) find _x);
						};
						_isOK = 	isClass(configFile >> "CfgWeapons" >> _x);
						if (_isOK) then {
							_object addWeaponCargoGlobal [_x,(_objWpnQty select _countr)];
						};
						_countr = _countr + 1;
					} forEach _objWpnTypes; 
				
					//Add Magazines
					_objWpnTypes = (_intentory select 1) select 0;
					_objWpnQty = (_intentory select 1) select 1;
					_countr = 0;
					{
						if (_x == "BoltSteel") then { _x = "WoodenArrow" }; // Convert BoltSteel to WoodenArrow
						if (_x == "ItemTent") then { _x = "ItemTentOld" };
						_isOK = 	isClass(configFile >> "CfgMagazines" >> _x);
						if (_isOK) then {
							_object addMagazineCargoGlobal [_x,(_objWpnQty select _countr)];
						};
						_countr = _countr + 1;
					} forEach _objWpnTypes;

					//Add Backpacks
					_objWpnTypes = (_intentory select 2) select 0;
					_objWpnQty = (_intentory select 2) select 1;
					_countr = 0;
					{
						_isOK = 	isClass(configFile >> "CfgVehicles" >> _x);
						if (_isOK) then {
							_object addBackpackCargoGlobal [_x,(_objWpnQty select _countr)];
						};
						_countr = _countr + 1;
					} forEach _objWpnTypes;
				};
			};	
			
			if (_object isKindOf "AllVehicles") then {
				{
					_selection = _x select 0;
					_dam = _x select 1;
					if (_selection in dayZ_explosiveParts and _dam > 0.8) then {_dam = 0.8};
					[_object,_selection,_dam] call object_setFixServer;
				} forEach _hitpoints;

				_object setFuel _fuel;
				
				// check if vehicle is in safezone. if so, teleport it to parking lock 			- Kenturrac
				[_object] call server_safezoneCleanup;

				if (!((typeOf _object) in dayz_allowedObjects)) then {
					
					//_object setvelocity [0,0,1];
					_object call fnc_veh_ResetEH;		
					
					if(_ownerID != "0" and !(_object isKindOf "Bicycle")) then {
						_object setvehiclelock "locked";
					};
					
					//count vehicles
					if(_ownerID != "0") then { 			//vehicles with an ID are vehicles who have an owner or atleast a key
						_vehiclesWithOwner = _vehiclesWithOwner + 1;
					} else {								//vehicles without an ID are vehicles who don't have an owner or a key
						//diag_log format["Veh-Spawn: Found a spawned: %1", _type];
						_vehiclesWithoutOwner = _vehiclesWithoutOwner + 1;
						
						if (_object isKindOf "Land") then {
							_vehiclesWithoutOwner_Land = _vehiclesWithoutOwner_Land + 1;
							
							//check if this vehicle is in the list
							for "_x" from 0 to _lastIndex_VSL_Land do {
								
								if (_type == ((_VSL_Land select _x) select 0)) then {
									
									if (((_VSL_Land select _x) select 1) > 0) then {
										(_VSL_Land select _x) set [1, ((_VSL_Land select _x) select 1) - 1];	//if its in the list. decrease the spawn counter
										//diag_log format["Veh-Spawn: set number to: %1", (_VSL_Land select _x) select 1];
									} else {
										diag_log format["HIVE: Warning - Too many %1 without owner detected.", _type];
									};
									//exitWith {}; //exits the for scope - saves runtime
								};
							};
						};
						
						if (_object isKindOf "Air") then {
							_vehiclesWithoutOwner_Air = _vehiclesWithoutOwner_Air + 1;
							
							//check if this vehicle is in the list
							for "_x" from 0 to _lastIndex_VSL_Air do {
								
								if (_type == ((_VSL_Air select _x) select 0)) then {
									
									if (((_VSL_Air select _x) select 1) > 0) then {
										(_VSL_Air select _x) set [1, ((_VSL_Air select _x) select 1) - 1];	//if its in the list. decrease the spawn counter
										//diag_log format["Veh-Spawn: set number to: %1", (_VSL_Air select _x) select 1];
									} else {
										diag_log format["HIVE: Warning - Too many %1 without owner detected.", _type];
									};
									//exitWith {}; //exits the for scope - saves runtime
								};
							};
						};
						
						if (_object isKindOf "Ship") then {
							_vehiclesWithoutOwner_Sea = _vehiclesWithoutOwner_Sea + 1;
							
							//check if this vehicle is in the list
							for "_x" from 0 to _lastIndex_VSL_Sea do {
								
								if (_type == ((_VSL_Sea select _x) select 0)) then {
									
									if (((_VSL_Sea select _x) select 1) > 0) then {
										(_VSL_Sea select _x) set [1, ((_VSL_Sea select _x) select 1) - 1];	//if its in the list. decrease the spawn counter
										//diag_log format["Veh-Spawn: set number to: %1", (_VSL_Sea select _x) select 1];
									} else {
										diag_log format["HIVE: Warning - Too many %1 without owner detected.", _type];
									};
									//exitWith {}; //exits the for scope - saves runtime
								};
							};
						};
					};
					
					_totalvehicles = _totalvehicles + 1;

					// total each vehicle
					serverVehicleCounter set [count serverVehicleCounter,_type];
				};
			};

			//Monitor the object
			PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_object];
		};
	} forEach (_BuildingQueue + _objectQueue);
	// # END SPAWN OBJECTS #

	for "_x" from 0 to _lastIndex_VSL_Land do {
		if (((_VSL_Land select _x) select 1) == 0) then {
			_VSL_Land set [_x,"deletethis"];
		};
	};
	_VSL_Land = _VSL_Land - ["deletethis"];
	
	for "_x" from 0 to _lastIndex_VSL_Air do {
		if (((_VSL_Air select _x) select 1) == 0) then {
			_VSL_Air set [_x,"deletethis"];
		};
	};
	_VSL_Air = _VSL_Air - ["deletethis"];
	
	for "_x" from 0 to _lastIndex_VSL_Sea do {
		if (((_VSL_Sea select _x) select 1) == 0) then {
			_VSL_Sea set [_x,"deletethis"];
		};
	};
	_VSL_Sea = _VSL_Sea - ["deletethis"];
	
	// preload server traders menu data into cache
	if !(DZE_ConfigTrader) then {
		{
			// get tids
			_traderData = call compile format["menu_%1;",_x];
			if(!isNil "_traderData") then {
				{
					_traderid = _x select 1;

					_retrader = [];

					_key = format["CHILD:399:%1:",_traderid];
					_data = "HiveEXT" callExtension _key;

					//diag_log "HIVE: Request sent";
			
					//Process result
					_result = call compile format ["%1",_data];
					_status = _result select 0;
			
					if (_status == "ObjectStreamStart") then {
						_val = _result select 1;
						//Stream Objects
						//diag_log ("HIVE: Commence Menu Streaming...");
						call compile format["ServerTcache_%1 = [];",_traderid];
						for "_i" from 1 to _val do {
							_data = "HiveEXT" callExtension _key;
							_result = call compile format ["%1",_data];
							call compile format["ServerTcache_%1 set [count ServerTcache_%1,%2]",_traderid,_result];
							_retrader set [count _retrader,_result];
						};
						//diag_log ("HIVE: Streamed " + str(_val) + " objects");
					};

				} forEach (_traderData select 0);
			};
		} forEach serverTraders;
	};

	if (_hiveLoaded) then {
		//  spawn_vehicles
		//_vehiclesToSpawn_Overall = MaxVehicleLimit - _totalvehicles;   //-original Epoch code
		diag_log format["HIVE: Vehicles with owner: %1. Vehicles without owner: %2. Land Vehicles without owner: %3. Air Vehicles without owner: %4. Ship Vehicles without owner: %5. ", _vehiclesWithOwner, _vehiclesWithoutOwner, _vehiclesWithoutOwner_Land, _vehiclesWithoutOwner_Air, _vehiclesWithoutOwner_Sea];
		_vehiclesToSpawn_Land = MaxVehicleLimit_Land - _vehiclesWithoutOwner_Land;
		_vehiclesToSpawn_Air = MaxVehicleLimit_Air - _vehiclesWithoutOwner_Air;
		_vehiclesToSpawn_Sea = MaxVehicleLimit_Sea - _vehiclesWithoutOwner_Sea;
		diag_log format["HIVE: Vehicles to spawn - Land: %1. Air: %2. Sea: %3.", _vehiclesToSpawn_Land, _vehiclesToSpawn_Air, _vehiclesToSpawn_Sea];
		
		//prepare temp variables
		_resultLand = 0;
		_resultAir = 0;
		_resultSea = 0;
		
		if (_vehiclesToSpawn_Land > 0) then {
		_resultLand = [_VSL_Land, _vehiclesToSpawn_Land] call vehiclespawn_manager;
		waitUntil{_resultLand};
		diag_log format["_resultLand: %1.", _resultLand];
		};
		
		if ((_vehiclesToSpawn_Air > 0) && (count(_VSL_Air) != 0)) then {
			_resultAir = [_VSL_Air, _vehiclesToSpawn_Air] call vehiclespawn_manager;
			waitUntil{_resultAir};
			diag_log format["_resultAir: %1.", _resultAir];
		};
		
		if ((_vehiclesToSpawn_Sea > 0) && (count(_VSL_Sea) != 0)) then {
			_resultSea = [_VSL_Sea, _vehiclesToSpawn_Sea] call vehiclespawn_manager;
			waitUntil{_resultSea};
			diag_log format["_resultSea: %1.", _resultSea];
		};
	};
	
	//  spawn_roadblocks
	diag_log ("HIVE: Spawning # of Debris: " + str(MaxDynamicDebris));
	for "_x" from 1 to MaxDynamicDebris do {
		[] spawn spawn_roadblocks;
	};
	//  spawn_ammosupply at server start 1% of roadblocks
	diag_log ("HIVE: Spawning # of Ammo Boxes: " + str(MaxAmmoBoxes));
	for "_x" from 1 to MaxAmmoBoxes do {
		[] spawn spawn_ammosupply;
	};
	// call spawning mining veins
	diag_log ("HIVE: Spawning # of Veins: " + str(MaxMineVeins));
	for "_x" from 1 to MaxMineVeins do {
		[] spawn spawn_mineveins;
	};

	if(isnil "dayz_MapArea") then {
		dayz_MapArea = 10000;
	};
	if(isnil "HeliCrashArea") then {
		HeliCrashArea = dayz_MapArea / 2;
	};
	if(isnil "OldHeliCrash") then {
		OldHeliCrash = false;
	};

	// [_guaranteedLoot, _randomizedLoot, _frequency, _variance, _spawnChance, _spawnMarker, _spawnRadius, _spawnFire, _fadeFire]
	if(OldHeliCrash) then {
		_nul = [3, 4, (50 * 60), (15 * 60), 0.75, 'center', HeliCrashArea, true, false] spawn server_spawnCrashSite;
	};
	if (isDedicated) then {
		// Epoch Events
		_id = [] spawn server_spawnEvents;
		// server cleanup
		[] spawn {
			private ["_id"];
			sleep 200; //Sleep Lootcleanup, don't need directly cleanup on startup + fix some performance issues on serverstart
			waitUntil {!isNil "server_spawnCleanAnimals"};
			_id = [] execFSM "\z\addons\dayz_server\system\server_cleanup.fsm";
		};

		// spawn debug box
		_debugMarkerPosition = getMarkerPos "respawn_west";
		_debugMarkerPosition = [(_debugMarkerPosition select 0),(_debugMarkerPosition select 1),1];
		_vehicle_0 = createVehicle ["DebugBox_DZ", _debugMarkerPosition, [], 0, "CAN_COLLIDE"];
		_vehicle_0 setPos _debugMarkerPosition;
		_vehicle_0 setVariable ["ObjectID","1",true];

		// max number of spawn markers
		if(isnil "spawnMarkerCount") then {
			spawnMarkerCount = 10;
		};
		actualSpawnMarkerCount = 0;
		// count valid spawn marker positions
		for "_i" from 0 to spawnMarkerCount do {
			if (!([(getMarkerPos format["spawn%1", _i]), [0,0,0]] call BIS_fnc_areEqual)) then {
				actualSpawnMarkerCount = actualSpawnMarkerCount + 1;
			} else {
				// exit since we did not find any further markers
				_i = spawnMarkerCount + 99;
			};
			
		};
		diag_log format["Total Number of spawn locations %1", actualSpawnMarkerCount];
		
		endLoadingScreen;
	};

	call compile preprocessFileLineNumbers "\z\addons\dayz_server\DZAI\init\dzai_initserver.sqf";
	allowConnection = true;	
	[] ExecVM "\z\addons\dayz_server\DZMS\DZMSInit.sqf";
	sm_done = true;
	publicVariable "sm_done";
};
