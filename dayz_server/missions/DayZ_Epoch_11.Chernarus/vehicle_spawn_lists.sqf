/*
	created by Kenturrac

This file is filed with tuning values for your individual vehicle spawn behaviour on level start.
To set up actual spawning rules or add new spawn lists you have to modify the source code.

Type - vehicle type to spawn e.g."ATV_CZ_EP1";
Amount - the maximum amount of vehicles that should spawn with these settings, amount will be ignored in the generic list
MinDMG - minimal damage per vehicle part (0-100)
MaxDMG - maximum damage per vehicle part (0-100)
DMGType - there are two types: 0 - do damage to the vehicle according to the MinDMG and MaxDMG; 1 - some wheels should be missing and a air vehicle should leak, does nothing to water vehicles.
Spawnrule - there are a bunch of spawnrules set up already. but you can add more anyway. do it in the server_spawnVehicle.sqf
			spawnrules you can use(just add this number):		0 - spawn around buildings and next to roads - LAND
														1 - spawn in water next to the shore - Sea
														2 - spawn anywhere that is flat and not close to the debug area - Air
														3 - spawn on defined locations - Huey
Probability - the system will try to spawn vehicles from the spawn list once every restart. depending on the probability it will spawn this vehicle or not. (0-1 or 0.2,0.31,...)

short explanation:
[Type,Amount,MinDMG,MaxDMG,DMGType,Spawnrule,Probability]

example:
["UAZ_CDF",2,40,96,0,0,0.4]

besides that, you can set up the spawnpoints for the huey spawn and adjust the WildcardProbability. the wildcard add a chance to overright the damage values and spawns the vehicle more repaired. doesn't work for special spawn list.
*/


WildcardProbability = 0.07;

SpawnpointsHuey = [
	[10516,2286,11,0],		//Elektro
	[4778,10179,0,45],		//NWAF
	[4362,10425,0,180],		//NWAF
	[6362,7778,0,0],			//Stary Sobor
	[12255,9711,0,270],		//Berenzino
	[11450,7490,12,10],		//Polana Factory
	[4740,2546,0,180],		//Balota Airfield
	[12129,12629,0,20],		//NEAF
	[2556,5060,0,180]			//Zelenogorsk
];

VehicleSpawnList_Land = [

//Low value but repaired
["ATV_CZ_EP1",3,0,50,0,0,1],
["ATV_US_EP1",3,0,50,0,0,1],
["car_hatchback",3,0,50,0,0,1],
["car_sedan",3,0,50,0,0,1],
["datsun1_civil_1_open",3,0,50,0,0,1],
["datsun1_civil_2_covered",3,0,50,0,0,1],
["datsun1_civil_3_open",3,0,50,0,0,1],
["GLT_M300_LT",3,0,50,0,0,1],
["GLT_M300_ST",3,0,50,0,0,1],
["Ikarus",3,0,50,0,0,1],
["Ikarus_TK_CIV_EP1",3,0,50,0,0,1],
["Lada1",3,0,50,0,0,1],
["Lada1_TK_CIV_EP1",3,0,50,0,0,1],
["Lada2",3,0,50,0,0,1],
["Lada2_TK_CIV_EP1",3,0,50,0,0,1],
["LadaLM",3,0,50,0,0,1],
["M1030_US_DES_EP1",3,0,50,0,0,1],
["Old_moto_TK_Civ_EP1",3,0,50,0,0,1],
["tractor",3,0,50,0,0,1],
["TT650_Civ",3,0,50,0,0,1],
["TT650_Ins",3,0,50,0,0,1],
["TT650_TK_CIV_EP1",3,0,50,0,0,1],
["Volha_1_TK_CIV_EP1",3,0,50,0,0,1],
["Volha_2_TK_CIV_EP1",3,0,50,0,0,1],
["VolhaLimo_TK_CIV_EP1",3,0,50,0,0,1],
["VWGolf",3,0,50,0,0,1],

//Mid value maybe broken
["hilux1_civil_1_open",3,35,95,0,0,1],
["hilux1_civil_2_covered",3,35,95,0,0,1],
["hilux1_civil_3_open_EP1",3,35,95,0,0,1],
["Kamaz",3,35,95,0,0,1],
["KamazRefuel_DZ",1,45,95,1,0,1],
["LandRover_CZ_EP1",3,35,95,0,0,1],
["LandRover_TK_CIV_EP1",3,35,95,0,0,1],
["MTVR_DES_EP1",3,35,95,0,0,1],
["MtvrRefuel_DES_EP1_DZ",1,45,95,1,0,1],
["Offroad_DSHKM_Gue_DZE",3,75,95,1,0,1],
["Policecar",3,40,85,0,0,1],
["Pickup_PK_GUE_DZE",3,35,95,0,0,1],
["Pickup_PK_INS_DZE",3,35,95,0,0,1],
["Pickup_PK_TK_GUE_EP1_DZE",3,35,95,1,0,1],
["S1203_ambulance_EP1",3,35,80,0,0,1],
["S1203_TK_CIV_EP1",3,35,80,0,0,1],
["Skoda",3,25,70,0,0,1],
["SkodaBlue",3,25,70,0,0,1],
["SkodaGreen",3,25,70,0,0,1],
["SkodaRed",3,25,70,0,0,1],
["UAZ_CDF",1,65,100,1,0,1],
["UAZ_INS",1,65,100,1,0,1],
["UAZ_RU",1,65,100,1,0,1],
["UAZ_Unarmed_TK_CIV_EP1",1,65,100,1,0,1],
["UAZ_Unarmed_TK_EP1",1,65,100,1,0,1],
["UAZ_Unarmed_UN_EP1",1,65,100,1,0,1],
["Ural_CDF",3,35,95,0,0,1],
["UralRefuel_TK_EP1_DZ",1,45,95,1,0,1],
["Ural_TK_CIV_EP1",3,35,95,0,0,1],
["Ural_UN_EP1",3,35,95,0,0,1],
["V3S_Open_TK_CIV_EP1",3,35,95,0,0,1],
["V3S_Open_TK_EP1",3,35,95,0,0,1],
["V3S_Refuel_TK_GUE_EP1_DZ",1,45,95,1,0,1],

//High value really broken
["GAZ_Vodnik_MedEvac",1,65,100,1,0,1],
["HMMWV_Ambulance",1,65,100,0,0,1],
["HMMWV_Ambulance_CZ_DES_EP1",1,65,100,0,0,1],
["HMMWV_DES_EP1",3,65,100,0,0,1],
["HMMWV_DZ",3,65,100,0,0,1],
["SUV_Blue",1,65,100,1,0,1],
["SUV_Camo",1,65,100,1,0,1],
["SUV_Charcoal",1,65,100,1,0,1],
["SUV_Green",1,65,100,1,0,1],
["SUV_Orange",1,65,100,1,0,1],
["SUV_Pink",1,65,100,1,0,1],
["SUV_Red",1,65,100,1,0,1],
["SUV_Silver",1,65,100,1,0,1],
["SUV_TK_CIV_EP1",1,65,100,1,0,1],
["SUV_White",1,65,100,1,0,1],
["SUV_Yellow",1,65,100,1,0,1],
["UAZ_MG_TK_EP1_DZE",1,65,100,1,0,1],

//special
["BTR40_TK_GUE_EP1",1,70,100,1,0,0.7],
["BTR40_TK_INS_EP1",1,70,100,1,0,0.7]
];

VehicleSpawnList_Air = [
["AH6X_DZ",1,65,100,1,2,1],
["AN2_DZ",2,10,50,0,2,1],
["MH6J_DZ",1,65,100,1,2,1],
["Mi17_Civilian_DZ",1,65,100,1,2,1],

//special
["C130J_US_EP1",1,0,10,1,2,0.6],
["UH1H_DZE",1,85,100,1,3,0.5]
];

VehicleSpawnList_Sea = [
["JetSkiYanahui_Case_Blue",1,0,50,0,1,1],
["JetSkiYanahui_Case_Green",1,0,50,0,1,1],
["JetSkiYanahui_Case_Red",1,0,50,0,1,1],
["JetSkiYanahui_Case_Yellow",1,0,50,0,1,1],
["PBX",2,0,50,0,1,1]
];

VehicleSpawnList_Generic = [
["MMT_Civ",1,0,0,0,0,1],
["Old_bike_TK_INS_EP1",1,0,0,0,0,1]
];