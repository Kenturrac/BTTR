/*
	DayZ Mission System Timer by Vampire
	Based on fnc_hTime by TAW_Tonic and SMFinder by Craig
	This function is launched by the Init and runs continuously.
*/
private["_run","_wait","_lastTryFailed","_cntMis","_ranMis","_varName"];

diag_log text format ["[DZMS]: Major Mission Clock Starting!"];
_lastTryFailed = 0;

//Lets get the loop going
_run = true;
while {_run} do
{
	//Lets wait the random time
	if (_lastTryFailed == 0) then {
		_wait = round(random DZMSMajorMax);
		_wait = _wait + DZMSMajorMin;
	} else {
		_wait = DZMSMajorMin;
	};
	if (_wait > DZMSMajorMax) then {
		_wait = DZMSMajorMax;
	};
	diag_log format ["[DZMS]: Major Mission Time until Mission: %1", _wait];
    [_wait,5] call DZMSSleep;
	
	//Let's check that there are missions in the array.
	//If there are none, lets end the timer.
	_cntMis = count DZMSMajorArray;
	diag_log format ["[DZMS]: Major Mission - _cntMis: %1", _cntMis];
	if (_cntMis == 0) exitWith { _run = false; };
	
	//Lets check if there are enough player in the game
	if (((diag_fps) > DZMSMinFPS) && (DZMSMajorMinPlayer <= (count playableUnits)))  then {
		//Lets pick a mission
		_ranMis = floor (random _cntMis);
		_varName = DZMSMajorArray select _ranMis;
		diag_log format["[DZMS]: Start Mission %1.", _varName];
		
		// clean up all the existing units before starting a new one
		{if (alive _x) then {_x call DZMSPurgeObject;};} forEach DZMSUnitsMajor;
		
		// rebuild the array for the next mission
		DZMSUnitsMajor = [];
		
		//Let's Run the Mission
		[] execVM format ["\z\addons\dayz_server\DZMS\Missions\Major\%1.sqf",_varName];
		diag_log text format ["[DZMS]: Running Major Mission %1.",_varName];
		
		//Let's wait for it to finish or timeout
		waitUntil {DZMSMajDone};
		DZMSMajDone = nil;
		_lastTryFailed = 0;
	} else {
		diag_log format["[DZMS]: FPS to low or not enough player on the server to start a major mission. Current FPS: %1  Current Players: %2", diag_fps, (count playableUnits)];
		_lastTryFailed = 1;
		sleep 30;
	}
};