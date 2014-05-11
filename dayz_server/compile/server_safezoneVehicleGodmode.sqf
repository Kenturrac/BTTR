/*
		Vehicle godmode for safezones
		created by Kenturrac
*/

private ["_vehicleKlen","_vehicleBash","_vehicleHero","_resultBash","_resultKlen","_resultHero"];

_vehicleBash = [];
_vehicleKlen = [];
_vehicleHero = [];

manageGodmode = {
	private ["_whichSafezone","_objectList_old","_objectList_new","_searchParams","_index"];

	_whichSafezone = _this select 0;
	_objectList_old = _this select 1;
	_objectList_new = [];

	// Define search parameter
	if (_whichSafezone == "Bash") then {
		_searchParams = [zonebash_safezone,["Helicopter","Plane","LandVehicle"],120];
		//diag_log format ["SZ_VehGodmode: Check for Bash."];
	};
	if (_whichSafezone == "Klen") then {
		_searchParams = [zoneklen_safezone,["Helicopter","Plane","LandVehicle"],75];
		//diag_log format ["SZ_VehGodmode: Check for Klen."];
	};
	if (_whichSafezone == "Hero") then {
		_searchParams = [Hero_safezone,["Helicopter","Plane","LandVehicle"],75];
		//diag_log format ["SZ_VehGodmode: Check for HeroTrader."];
	};


	// Add protection to new objects and filter for objects that are not in the area anymore
	{
		// Add object to new list
		_objectList_new set [count _objectList_new,_x];
		// Check if object is already in old list
		if (_x in _objectList_old) then {
			// Find object in list
			_index = _objectList_old find _x;
			// Remove object from list
			_objectList_old set [_index,"deletethis"];
			_objectList_old = _objectList_old - ["deletethis"];
		} else {
			// Apply vehicle protection
			_x removeAllEventHandlers "handleDamage";
			_x addEventHandler ["handleDamage", {false}];
			_x allowDamage false;
		};	
	} forEach nearestObjects _searchParams;
	//diag_log format ["SZ_VehGodmode: %1 - vehicles with protection: %2", _whichSafezone, _objectList_new];

	{
		// Remove protection of all items left in old list
		_x addEventHandler ["handleDamage", {true}];
		_x removeAllEventHandlers "handleDamage";
		_x allowDamage true;
	} foreach _objectList_old;
	//diag_log format ["SZ_VehGodmode: %1 - vehicles that lost protection: %2", _whichSafezone, _objectList_old];
	
	_objectList_new;
};

while {true} do {
	_resultBash = nil;
	_resultKlen = nil;
	_resultHero = nil;

	// Bash
	_resultBash = ["Bash", _vehicleBash] call manageGodmode;
	waitUntil{!isNil "_resultBash"};
	_vehicleBash = _resultBash;
	
	// Klen
	_resultKlen = ["Klen", _vehicleKlen] call manageGodmode;
	waitUntil{!isNil "_resultKlen"};
	_vehicleKlen = _resultKlen;
	
	// Hero
	_resultHero = ["Hero", _vehicleHero] call manageGodmode;
	waitUntil{!isNil "_resultHero"};
	_vehicleHero = _resultHero;

	sleep 30;
};