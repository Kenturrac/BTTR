private ["_cTarget","_isOk","_display","_inVehicle"];
disableSerialization;
_display = (_this select 0);
_inVehicle = (vehicle player) != player;
_cTarget = cursorTarget;
if(_inVehicle) then {
	_cTarget = (vehicle player);
};

_isOk = false;
{
	if(!_isOk) then {
		_isOk = _cTarget isKindOf _x;
	};
} forEach ["LandVehicle","Air", "Ship"];

// Prevents player from looting locked vehicles in general and vehicles in safezone (player is able to loot from the inside of the vehicle)
if (_isOk and (((vehicle player) distance _cTarget) < 12)) then {
	if (locked _cTarget) then {
		cutText [(localize "str_epoch_player_7") , "PLAIN DOWN"];
		_display closeDisplay 1;
	} else {
		if ( inSafeZone && !(player in (crew _cTarget)) ) then {
			cutText ["In Safezones you can only loot vehicles from the inside." , "PLAIN DOWN"];
			_display closeDisplay 1;
		};
	};
};

// Prevents players opening others backpacks
if (inSafeZone and _cTarget isKindOf "Man" and alive _cTarget and (((vehicle player) distance _cTarget) < 12)) then {
	cutText ["Cannot access other players gear in the safezone." , "PLAIN DOWN"];
	_display closeDisplay 1;
};