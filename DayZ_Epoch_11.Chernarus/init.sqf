/*	
	For DayZ Epoch
	Addons Credits: Jetski Yanahui by Kol9yN, Zakat, Gerasimow9, YuraPetrov, zGuba, A.Karagod, IceBreakr, Sahbazz
*/

startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	11;					//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;


//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// DayZ Epoch config
spawnShoremode = 0; // Default = 0 (on shore)
eventSpawnselection = 0; //Default = 0 (Spawn selection for Admin events)
spawnLocations = [							//spawnLocations [[X,Y,Z],MinRadius,MaxRadius)
				[[3600,2360,0],0,500], 		//Komarovo
				[[4000,2460,0],0,500], 		//Balota
				[[6700,2760,0],700,1400], 		//Chernogorsk
				[[10300,2160,0],700,1300], 	//Elektro
				[[13400,5660,0],0,500], 		//Solnichy
				[[13300,6860,0],0,700], 		//Solnichy
				[[12600,9060,0],0,1000], 		//Berenzino
				[[10700,8060,0],500,800], 		//Polana
				[[10200,5860,0],0,300], 		//Staroye
				[[7900,5160,0],0,300], 		//Mogilevka
				[[4100,4860,0],0,400], 		//Kozlovka
				[[2200,5260,0],150,400], 		//Zelenogorsk southwest
				[[3000,5760,0],150,400] 		//Zelenogorsk north
];
spawnLocations_Event = [						//spawnLocations [[X,Y,Z],MinRadius,MaxRadius)
					[[6800,11560,0],0,1000] 	//Devils Castle
];

MaxHeliCrashes= 2;
MaxAmmoBoxes = 0;		// Ammobox = 3
MaxMineVeins = 0;		// Minen = 50
MaxVehicleLimit = 350; // ignore it. not used anymore
MaxVehicleLimit_Land = 250;
MaxVehicleLimit_Air = 7;
MaxVehicleLimit_Sea = 0;
MaxDynamicDebris = 30; // Default = 100

dayz_MapArea = 18000; // Default = 10000

dayz_paraSpawn = false;
DZE_R3F_WEIGHT = true;	// player gewicht

dayz_minpos = -1; 
dayz_maxpos = 16000;

dayz_sellDistance_vehicle = 20;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;

dayz_maxAnimals = 2; // Default: 8
dayz_tameDogs = false;
DynamicVehicleDamageLow = 45; // Default: 0
DynamicVehicleDamageHigh = 100; // Default: 100
DynamicVehicleFuelLow = 0;
DynamicVehicleFuelHigh = 35;

DZE_BuildOnRoads = false; // Default: False
DZE_BuildingLimit = 250;
DZE_PlayerZed = false;
DZE_PlotPole = [50,70];
DZE_MissionLootTable = true;

dayz_maxLocalZombies = 15; // Default = 30 
dayz_maxGlobalZombiesInit = 25;		// Default: 40
dayz_maxGlobalZombiesIncrease = 2; // Default: 10
dayz_maxZeds = 500; 				// Default: 500

setViewDistance 1100;
setTerrainGrid 30;

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"]];
dayz_fullMoonNights = true;


//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
call compile preprocessFileLineNumbers "custom\compiles.sqf"; //Compile custom compiles
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

if (isServer) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\dynamic_vehicle.sqf";
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\vehicle_spawn_lists.sqf";
	
	//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
	
	DZE_DiagVerbose = true; //Reports fps, total object count, and player count.
	DZE_DiagFpsSlow = true; //Report fps every 5 minutes
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";	
	
	//Lights
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
	
	//Spawn selection
	if (eventSpawnselection == 1) then {
		waitUntil {!isNil ("PVDZE_plr_LoginRecord")}; 
		if (dayzPlayerLogin2 select 2) then {
			[] execVM "custom\spawn_select\Spawn.sqf"; 
		};
	};
};

//Start Dynamic Weather
execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";


#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

//safezone
[] execVM "custom\safezone\dami_SZ.sqf";



