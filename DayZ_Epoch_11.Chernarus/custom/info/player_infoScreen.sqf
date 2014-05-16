/*
	Written by:
	Kenturrac
*/
[] spawn {
	waitUntil {!isNil "dayz_animalCheck"};

	waituntil {!isnull (finddisplay 46)};
	(finddisplay 46) displayaddeventhandler ["keydown","_this call infoScreen_buttons; false;"];
};

infoScreen_buttons = {
	switch (_this select 1) do {
		//F1 key
		case 59: 
		{
			// code here
			diag_log format ["F1"];
		};
	};
};