//DayZChernarus Mission System
//Original code by TheSzerdi, Falcyn and TAW_Tonic.

fnc_hTime = compile preprocessFile "Missions\misc\fnc_hTime.sqf"; //Random integer selector for mission wait time

//----------InitMissions--------//
MissionGo = 0;
MissionGoMinor = 0;
if ( !( hasInterface || isDedicated ) ) then { 
	SMarray = ["SM1","SM2","SM3","SM4","SM5","SM6"];
	[] execVM "missions\major\SMfinder.sqf"; //Starts major mission system
	SMarray2 = ["SM1","SM2","SM3","SM4","SM5","SM6"];
	[] execVM "missions\minor\SMfinder.sqf"; //Starts minor mission system
};
//---------EndInitMissions------//