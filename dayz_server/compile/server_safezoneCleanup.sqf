/* 
			created by Kenturrac
	based on original spawn script "spawn_vehicles"
*/
private ["_object","_pos","_dir","_isTooMany","_bool","_counter","_counterMax","_isInsideOfSafezone","_searchParameter"];

_object = _this select 0;
_dir = floor(random 359);
_bool = true;
_counter = 0;
_counterMax = 20;
_isInsideOfSafezone = false;

// check if in range of safezone

// Bash
if ((_object distance zonebash_safezone) < 120) then {
	if (_object isKindOf "Air") then {									// spawn in an big open field.
		_searchParameter = [[4014,11154], 0, 50, 20, 0, 20, 0];
		_dir = 135;
	} else {															// spawn in parking lot
		_searchParameter = [[4073,11230], 0, 23, 5, 0, 20, 0];
	};
	diag_log format["Safezone-Spawn: Found vehicle in bash-safezone: %1", _object];
	_isInsideOfSafezone = true;
};

// Klen
if ((_object distance zoneklen_safezone) < 75) then {
	if (_object isKindOf "Air") then {									// spawn in an big open field.
		_searchParameter = [[10984,11511], 0, 50, 20, 0, 20, 0];
		_dir = 180;
	} else {															// spawn in parking lot
		_searchParameter = [[11047,11601], 0, 23, 5, 0, 20, 0];
	};
	diag_log format["Safezone-Spawn: Found vehicle in klen-safezone: %1", _object];
	_isInsideOfSafezone = true;
};

// Hero
if ((_object distance Hero_safezone) < 75) then {
	if (_object isKindOf "Air") then {									// spawn in an big open field.
		_searchParameter = [[12733,12708], 0, 50, 20, 0, 20, 0];
		_dir = 205;
	} else {															// spawn in parking lot
		_searchParameter = [[12552,12726], 0, 23, 5, 0, 20, 0];
	};
	diag_log format["Safezone-Spawn: Found vehicle in hero-safezone: %1", _object];
	_isInsideOfSafezone = true;
};

// If car is inside of safezone, try to find a spot in the parking lot.
if (_isInsideOfSafezone) then {
	while {_bool && (_counter <= _counterMax)} do {
		waitUntil{!isNil "BIS_fnc_findSafePos"};
		_pos = _searchParameter call BIS_fnc_findSafePos;
		
		// check if there is already a car at this place
		if (_object isKindOf "Air") then {
			_isTooMany = _pos nearObjects ["All",8];
		} else {
			_isTooMany = _pos nearObjects ["All",5];
		};
		_isTooMany = _pos nearObjects ["All",3];
		if((count _isTooMany) == 0) then {
			 diag_log format["Safezone-Spawn: Found parking spot."];
			 _bool = false;
		} else {
			//diag_log format["Safezone-Spawn: Vehicle too close. Search new spot."];
			_counter = _counter + 1;
		};
	};

	if (_counter <= _counterMax) then {
		// teleport object to new parking lot position
		if (count _pos < 3) then { _pos = [_pos select 0,_pos select 1,0]; };
		_object setdir _dir;
		_object setposATL _pos;
	} else {
		diag_log format["Safezone-Spawn: Could not find any spot in the parking lot. System will not move the car."];
	};
};