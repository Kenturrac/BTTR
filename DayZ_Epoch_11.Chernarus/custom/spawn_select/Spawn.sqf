private ["_position","_counter","_ok","_searchSpotToSpawnPlayer","_SpawnLocations_Index","_SpawnLocations_Item","_spawnPosition","_spawnInnerRadius","_spawnOuterRadius","_noOthersNear","_positionIsZero","_isIsland"];

diag_log ("DEBUG-Spawning: Start spawn selection spawning.");
cutText ["","BLACK OUT"];
_ok = createDialog "spawnSelectionScreen_DIALOG";
spawnSelect = -1;
diag_log ("DEBUG-Spawning: Start 'waitUntil'.");
waitUntil {spawnSelect != -1};
diag_log ("DEBUG-Spawning: spawnSelect: " +str(spawnSelect));

if (spawnSelect < 100) then {

	//spawn player
	_searchSpotToSpawnPlayer = true;
	_counter = 0;
	while {_counter < 20 and _searchSpotToSpawnPlayer} do {
		
		// find selected event spawnpoint
		_SpawnLocations_Index = spawnSelect;
		_SpawnLocations_Item = spawnLocations_Event select _SpawnLocations_Index;
		_spawnPosition = _SpawnLocations_Item select 0;
		_spawnInnerRadius = _SpawnLocations_Item select 1;
		_spawnOuterRadius = _SpawnLocations_Item select 2;

		//debug messages
		diag_log ("DEBUG-Spawning: _spawnLocations_Index: " + str(_SpawnLocations_Index));
		diag_log ("DEBUG-Spawning: _spawnLocations_Item: " + str(_SpawnLocations_Item));
		diag_log ("DEBUG-Spawning: _spawnPosition: " + str(_spawnPosition));
		diag_log ("DEBUG-Spawning: _spawnInnerRadius: " + str(_spawnInnerRadius));
		diag_log ("DEBUG-Spawning: _spawnOuterRadius: " + str(_spawnOuterRadius));

		_position = ([(_spawnPosition),(_spawnInnerRadius),(_spawnOuterRadius),10,0,2000,spawnShoremode] call BIS_fnc_findSafePos);
		diag_log ("DEBUG-Spawning: _position: " + str(_position));

		_noOthersNear = count (_position nearEntities ["Man",100]) == 0;
		_positionIsZero = ((_position select 0) == 0) and ((_position select 1) == 0);
		
		//Check if spawnspot is on a small island - Otmel check
		_pos 		= _position;
		_isIsland	= false;
		for [{_w=0},{_w<=150},{_w=_w+2}] do {
			_pos = [(_pos select 0),((_pos select 1) + _w),(_pos select 2)];
			if(surfaceisWater _pos) exitWith {
				_isIsland = true;
			};
		};
		
		//Stop while-loop, if you found a good spawn location 
		if ((_noOthersNear and !_positionIsZero) and !_isIsland) then {
			_searchSpotToSpawnPlayer = false;
			diag_log ("DEBUG-Spawning: Found a spawn location.");
		} else {
			diag_log ("DEBUG-Spawning: Haven't found a spawn location yet. _noOthersNear: " +str(_noOthersNear) + "/ _positionIsZero: " +str(_positionIsZero) + "/ _isIsland: " +str(_isIsland));
		};
		_counter = _counter + 1;
	};

	_position = [_position select 0,_position select 1,0];
	//diag_log("DEBUG: spawning player at" + str(_position));
	player setPosATL _position;
};
cutText ["","BLACK IN"];