if (!isDedicated) then {
	player_unlockDoor = {
		private ["_ok"];
		if (!isNull dayz_selectedDoor) then
		{
			_obj = dayz_selectedDoor;
			_objectCharacterID 	= _obj getVariable ["CharacterID","0"];
			if (DZE_Lock_Door == _objectCharacterID) then
			{
				[player,"combo_unlock",0,false] call dayz_zombieSpeak;
				_display = findDisplay 41144;
				_display closeDisplay 3000;
				if(_obj animationPhase "Open_hinge" == 0) then
				{
					_obj animate ["Open_hinge", 1];
				};
				if(_obj animationPhase "Open_latch" == 0) then
				{
					_obj animate ["Open_latch", 1];
				};
			}
			else
			{
				DZE_Lock_Door = "";
				[player,"combo_locked",0,false] call dayz_zombieSpeak;
				_display = findDisplay 41144;
				_display closeDisplay 3000;
				
				cutText ["WRONG CODE ENTERED - WAIT 12 SECONDS", "PLAIN DOWN"];
				if (isNil 'KeyCodeTry') then {KeyCodeTry = true;};
				[] spawn {sleep 12;KeyCodeTry = nil;};
				[] spawn {
					while {KeyCodeTry} do
					{
						_display = findDisplay 41144;
						_display closeDisplay 3000;
						sleep 0.1;
					};
				};
			};
		}
		else
		{
			_display = findDisplay 41144;
			_display closeDisplay 3000;
		};
	};
};