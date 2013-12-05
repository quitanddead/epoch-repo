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

//ERIC Tow/Lift
_logistic = execVM "=BTC=_Logistic\=BTC=_Logistic_Init.sqf";
//END-ERIC

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;

// DayZ Epoch config
spawnShoremode = 1; // Default = 1 (on shore)
spawnArea= 1500; // Default = 1500
MaxHeliCrashes= 5; // Default = 5
MaxVehicleLimit = 300; // Default = 50
MaxDynamicDebris = 0; // Default = 100
dayz_MapArea = 14000; // Default = 10000
dayz_maxLocalZombies = 30; // Default = 30 
DZE_BuildingLimit = 300; // Default = 150

dayz_paraSpawn = false;

dayz_maxAnimals = 8; // Default: 8
dayz_tameDogs = true;
DynamicVehicleDamageLow = 25; // Default: 0
DynamicVehicleDamageHigh = 100; // Default: 100

// Loadout config
DefaultMagazines = ["ItemBandage","ItemBandage","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemSodaCoke","FoodMRE","ItemPainkiller"];
DefaultWeapons = ["ItemWatch","ItemMap","ItemCompass","M9SD"];
DefaultBackpack = "DZ_Patrol_Pack_EP1";
DefaultBackpackWeapon = "";

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];
dayz_fullMoonNights = true;

//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf"; //Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
progressLoadingScreen 0.75;
call compile preprocessFileLineNumbers "Scripts\compiles.sqf"; //Compile custom compiles
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";

/* BIS_Effects_* fixes from Dwarden */
BIS_Effects_EH_Killed = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\killed.sqf";
BIS_Effects_AirDestruction = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\AirDestruction.sqf";
BIS_Effects_AirDestructionStage2 = compile preprocessFileLineNumbers "\z\addons\dayz_code\system\BIS_Effects\AirDestructionStage2.sqf";

BIS_Effects_globalEvent = {
	BIS_effects_gepv = _this;
	publicVariable "BIS_effects_gepv";
	_this call BIS_Effects_startEvent;
};

BIS_Effects_startEvent = {
	switch (_this select 0) do {
		case "AirDestruction": {
				[_this select 1] spawn BIS_Effects_AirDestruction;
		};
		case "AirDestructionStage2": {
				[_this select 1, _this select 2, _this select 3] spawn BIS_Effects_AirDestructionStage2;
		};
		case "Burn": {
				[_this select 1, _this select 2, _this select 3, false, true] spawn BIS_Effects_Burn;
		};
	};
};

"BIS_effects_gepv" addPublicVariableEventHandler {
	(_this select 1) call BIS_Effects_startEvent;
};

if ( ( (!isServer) || ( !hasInterface && !isDedicated ) ) && (isNull player) ) then
{
waitUntil {!isNull player};
waitUntil {time > 3};
};

if ( ( (!isServer) || ( !hasInterface && !isDedicated ) ) && (player != player) ) then
{
  waitUntil {player == player}; 
  waitUntil {time > 3};
};

if (isServer) then {
	call compile preprocessFileLineNumbers "dynamic_vehicle.sqf";				//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
    _id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";

	_void = [] execVM "R3F_Realism\R3F_Realism_Init.sqf";
	
	//Lights
	//[0,0,true,true,true,58,280,600,[0.698, 0.556, 0.419],"Generator_DZ",0.1] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
};

// ------------Server Side Only Addons----------START--------------------

if (isDedicated) then {
	//Declare global variables for SARGE/HC
	publicvariable "SAR_surv_kill_value";
	publicvariable "SAR_band_kill_value";
	publicvariable "SAR_DEBUG";
	publicvariable "SAR_EXTREME_DEBUG";
	publicvariable "SAR_DETECT_HOSTILE";
	publicvariable "SAR_DETECT_INTERVAL";
	publicvariable "SAR_HUMANITY_HOSTILE_LIMIT";
	//End Declare global variables for SARGE/HC
};

// ------------Server Side Only Addons----------END----------------------

// ------------Server AND Player AND HC Addons------START----------------

	//No if statement needed
	[] execVM "faction.sqf";

// ------------Server AND Player Addons------END-------------------------

// ------------Player AND HC Addons------START---------------------------

if ( (!( hasInterface || isDedicated )) || isPlayer ) then {
	//[EPOCH-35]
	diag_log format ["---Loading AGN Safe Trader Zones"];
	[] execVM 'AGN\agn_SafeZoneCommander.sqf';
	//[/EPOCH-35]
};

// ------------Player AND HC Addons------END-----------------------------

// ------------Headless Client Only Addons------START--------------------

if ( !( hasInterface || isDedicated ) ) then {
	// UPSMON for SAR_AI
	diag_log format ["---Loading UPSMON for SAR_AI"];
	call compile preprocessFileLineNumbers "addons\UPSMON\scripts\Init_UPSMON.sqf";
	// SHK for SAR_AI
	diag_log format ["---Loading SHK for SAR_AI"];
	call compile preprocessfile "addons\SHK_pos\shk_pos_init.sqf";
	// run SAR_AI
	diag_log format ["---Loading SAR_AI"];
	[] execVM "addons\SARGE\SAR_AI_init.sqf";
	//Start AI Missions
	[] execVM "Scripts\AIMissions.sqf";
};

// ------------Headless Client Only Addons------END----------------------

// ------------Player Side Only Addons----------START--------------------

if ( !isDedicated && hasInterface ) then {
	//Repair/Refuel Addon
	diag_log format ["---Loading Repair/Refuel Addon"];
    [] execVM "Scripts\repairactions.sqf";

	//Eric Add AH Debug Monitor For All Players
	[] execVM "Scripts\AH_DebugMonitor.sqf";	
};

// ------------Player Side Only Addons----------END----------------------

// ---------------Map Addons---------------START-------------------------

//[EPOCH-50] Curt - Novy Lug
diag_log format ["---Loading [AiE] Custom Novy Lug Base"];
[] execVM "NovyLugBase\NovyLugBase.sqf";

//[EPOCH-50] Curt - Balota
diag_log format ["---Loading [AiE] Custom Balota"];
[] execVM "Balota\Balota.sqf";

//[EPOCH-50] Curt - Zelenogorsk
diag_log format ["---Loading [AiE] Custom Zelenogorsk"];
[] execVM 'Zelen\Zelen.sqf';

//[EPOCH-50] Curt - Cherno
diag_log format ["---Loading [AiE] Custom Chero"];
[] execVM 'Cherno\Cherno.sqf';

//[EPOCH-50] Aaron - NWAF
diag_log format ["---Loading [AiE] Custom NWAF"];
[] execVM 'NWAF\NWAF.sqf';

//[EPOCH-50] Found Online - NWAF
diag_log format ["---Loading [AiE] Custom NWAF Base"];
[] execVM 'NWAFBase\NWAFBase.sqf';

//[EPOCH-50] Aaron - Electro
diag_log format ["---Loading [AiE] Custom Electro"];
[] execVM 'Electro\Electro.sqf';

//[EPOCH-50] Curt - GreenMountain
diag_log format ["---Loading [AiE] Custom Green Mountain"];
[] execVM 'GreenMountain\GreenMountain.sqf';

//[EPOCH-50] Curt - Berenzino
diag_log format ["---Loading [AiE] Custom Berenzino"];
[] execVM 'Berenzino\Berenzino.sqf';

//[EPOCH-50] Curt - North Base
diag_log format ["---Loading [AiE] Custom North Base"];
[] execVM 'NorthBase\NorthBase.sqf';

//[EPOCH-50] Jir - Shipment
diag_log format ["---Loading [AiE] Custom North Base"];
[] execVM 'Shipment\Shipment.sqf';

//[EPOCH-50] Jir - Admin Base 02
diag_log format ["---Loading [AiE] Custom Admin Base"];
[] execVM 'AdminBase02\AdminBase02.sqf';

//[EPOCH-50] Curt - Admin Base 01
diag_log format ["---Loading [AiE] Custom Admin Base"];
[] execVM 'AdminBase01\AdminBase01.sqf';

// ------------Map Addons------------------END---------------------------