private ["_missName","_coords","_direction","_modelCollection","_modelNumber","_model","_startPos","_plane","_aiGrp","_pilot","_wp","_wp_pos","_loop","_half","_newPos","_plane2","_chute","_box","_dropDir","_wp2","_boxContent","_boxNumber","_fallCount","_boxFin"];

//Name of the Mission
_missName = "Supply Drop";

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"An Airplane is flying In!\nGet to the location and capture the package!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM DZMSAddMajMarker;

//Lets get the AN2 Flying
_direction = round(random 1);
diag_log ("[DZMS]: _direction: " + str(_direction));
switch (_direction) do{
	//north
	//_startPos = [random 16500, 15350, 500] ;
	//east
	case 0: {_startPos = [16500, random 15350, 500]; };
	//south
	case 1: {_startPos = [random 16500, 0, 500]; };
	//west
	//_startPos = [0, random 15350, 500];
};
diag_log ("[DZMS]: _startPos: " + str(_startPos));

_modelCollection = ["C130J_US_EP1", "MV22_DZ", "AN2_DZ"];
diag_log ("[DZMS]: _modelCollection: " + str(count _modelCollection));
_modelNumber = floor(random (count _modelCollection));
diag_log ("[DZMS]: _modelNumber: " + str(_modelNumber));
_model = _modelCollection select _modelNumber;
diag_log ("[DZMS]: _model: " + str(_model));

_plane = createVehicle [_model, _startPos, [], 0, "FLY"];
[_plane] call DZMSProtectObj;
_plane engineOn true;
_plane flyInHeight 150;
_plane forceSpeed 160;

//Empty the plane
clearMagazineCargoGlobal _plane;
clearWeaponCargoGlobal _plane;

//Lets make AI for the plane and get them in it
_aiGrp = creategroup east;

_pilot = _aiGrp createUnit ["SurvivorW2_DZ",getPos _plane,[],0,"FORM"];
_pilot moveindriver _plane;
_pilot assignAsDriver _plane;

_wp = _aiGrp addWaypoint [[(_coords select 0), (_coords select 1),150], 0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";
_wp_pos = waypointPosition [_aiGrp,1];

_pilot addWeapon 'ItemCompass';
_pilot addWeapon 'ItemMap';
sleep 5;

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, unitArray]
[_coords,3,2,"DZMSUnitsMajor"] call DZMSAISpawn;
sleep 5;
[_coords,2,2,"DZMSUnitsMajor"] call DZMSAISpawn;
sleep 5;
[_coords,1,3,"DZMSUnitsMajor"] call DZMSAISpawn;
sleep 5;

_loop = true;
_half = false;
while {_loop} do {
	if (!Alive _plane OR !Alive _pilot) then {
		sleep 5;
		
		// We are going to pretend the plane was shot down nearby
		deleteVehicle _plane;
		deleteVehicle _pilot;

		_newPos = [(_coords select 0) + (random(2000)),(_coords select 1) - (random(2000)),0];
		
		if (surfaceIsWater _newPos) then {
			//newPos is water, so lets just drop it on mark
			//This is a temporary fix for needed logic
			_newPos = _coords;
		};
		
		//Create the plane and kill it
		_plane2 = createVehicle [_model, [(_newPos select 0),(_newPos select 1),200], [], 0, "FLY"];
		[_plane2] call DZMSProtectObj;
		_plane2 engineOn true;
		_plane2 flyInHeight 150;
		_plane2 forceSpeed 200;
		sleep 2;
		_plane2 setDamage 1;
		
		//Update the location
		[_coords,"AN2 Wreck"] ExecVM DZMSAddMajMarker;
		[nil,nil,rTitleText,"The airplane with the carepackage was shot down by UN Peacekeepers!\nGo Find the Supplies!", "PLAIN",10] call RE;
		
		_chute = createVehicle ["ParachuteMediumEast", [(_newPos select 0),(_newPos select 1),200], [], 0, "FLY"];
		[_chute] call DZMSProtectObj;
		_box = createVehicle ["USVehicleBox", [(_newPos select 0),(_newPos select 1),200],[], 0, "CAN_COLLIDE"];
		[_box] call DZMSProtectObj;
		_box attachTo [_chute, [0, 0, 1]];
		
		_loop = false;
	};
	
	if ((Alive _plane) AND (Alive _pilot) AND ((_plane distance _wp_pos) <= 1200) AND (!(_half))) then {
		//[nil,nil,rTitleText,"The airplane with the carepackage is only 1200m out from the drop point!", "PLAIN",10] call RE;
		
		//Keep on truckin'
		_plane forceSpeed 150;
		_plane flyInHeight 130;
		_plane setspeedmode "LIMITED";
		_half = true;
	};
	

	if ((Alive _plane) AND (Alive _pilot) AND ((_plane distance [(_wp_pos select 0), (_wp_pos select 1), (getpos _plane select 2)]) <= 70)) then {
		//Drop the package
		sleep 1;
		
		_dropDir = getDir _plane;
		_newPos = [(getPosATL _plane select 0) - 15*sin(_dropDir), (getPosATL _plane select 1) - 15*cos(_dropDir), (getPosATL _plane select 2) - 10];

//		Massage to Grap the Mission Target
//		[nil,nil,rTitleText,"The Ikeabox Testplain has reached the location and dropped the cargo!", "PLAIN",10] call RE;
		
		_chute = createVehicle ["ParachuteMediumEast", _newPos, [], 0, "NONE"];
		[_chute] call DZMSProtectObj;
		_box = createVehicle ["USVehicleBox", _newPos,[], 0, "CAN_COLLIDE"];
		[_box] call DZMSProtectObj;
		_box attachTo [_chute, [0, 0, 1.5]];
		
		deleteWaypoint [_aiGrp, 1];
		_wp2 = _aiGrp addWaypoint [[11,11,150], 0];
		_wp2 setWaypointType "MOVE";
		_wp2 setWaypointBehaviour "CARELESS";
		_plane forceSpeed 350;
		_plane setSpeedmode "FULL";
		
		_loop = false;
	};
};

//The box was dropped, lets get it on the ground.
_fallCount = 0;
while {_fallCount < 45} do {
	if (((getPos _box) select 2) < 1) then {_fallCount = 46};
	sleep 0.1;
	_fallCount = _fallCount + 0.1;
};

detach _box;
_box setpos [(getpos _box select 0), (getpos _box select 1), 0];
_boxFin = createVehicle ["USVehicleBox",[(getpos _box select 0),(getpos _box select 1), 0],[],0,"CAN_COLLIDE"];
diag_log ("[DZMS]: Box dropped at: " + str(getpos _boxFin));
deletevehicle _box;
deletevehicle _chute;
//[[(getpos _boxFin select 0), (getpos _boxFin select 1), 0],"AN2 Cargo"] ExecVM DZMSAddMajMarker;
clearWeaponCargoGlobal _boxFin;
clearMagazineCargoGlobal _boxFin;
clearBackpackCargoGlobal _boxFin;

switch (_model) do{
	case "C130J_US_EP1":	{_boxContent = DZMS_C130_Loot select floor(random (count DZMS_C130_Loot));};
	case "MV22_DZ":		{_boxContent = DZMS_MV22_Loot select floor(random (count DZMS_MV22_Loot));};
	case "AN2_DZ":		{_boxContent = DZMS_AN2_Loot select floor(random (count DZMS_AN2_Loot));};
	default 				{diag_log ("[DZMS]: ERROR! No case for _model: " + str(count _model))};
};
diag_log format["[DZMS]: _boxContent: _%1_", _boxContent];

[_boxFin,_boxContent] ExecVM DZMSBoxSetup;
[_boxFin] call DZMSProtectObj;

//Wait until the player is within 30 meters and also meets the kill req
[position _boxFin,"DZMSUnitsMajor"] call DZMSWaitMissionComp;

//Let everyone know the mission is over
// [nil,nil,rTitleText,"The carepackage has been secured by Survivors!", "PLAIN",6] call RE;
diag_log text format["[DZMS]: Major SM10 Drop Mission has Ended."];
sleep 10;
deleteMarker "DZMSMajMarker";
deleteMarker "DZMSMajDot";

//Let the timer know the mission is over
DZMSMajDone = true;