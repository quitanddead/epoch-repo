//Building Supply/Gold by Golgothan  (Full credit for original code to TheSzerdi & TAW_Tonic)

private ["_coords","_MainMarker","_chopper","_wait"];
[] execVM "missions\SMGoMajor.sqf";
WaitUntil {MissionGo == 1};

_coords = [getMarkerPos "center",0,5500,30,0,20,0] call BIS_fnc_findSafePos;

[nil,nil,rTitleText,"A FEMA C130 has crashed with building supplies and relief funds!", "PLAIN",10] call RE;

Ccoords = _coords;
publicVariable "Ccoords";
[] execVM "aimissionmarkers\addmarkers.sqf";

_chopper = ["C130J_wreck_EP1"] call BIS_fnc_selectRandom;

_c130crash = createVehicle [_chopper,_coords,[], 0, "NONE"];
_c130crash setVariable ["Sarge",1,true];
_c130crash setFuel 0.1;
_c130crash setVehicleAmmo 0.2;

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 6, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "missions\misc\fillBoxesBuilding.sqf";
_crate2 setVariable ["Sarge",1,true];
_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) + 6, _coords select 1,0],[], 90, "CAN_COLLIDE"];
[_crate2] execVM "missions\misc\fillBoxesGold.sqf";
_crate2 setVariable ["Sarge",1,true];
_crate3 = createVehicle ["RULaunchersBox",[(_coords select 0) - 14, (_coords select 1) -10,0],[], 0, "CAN_COLLIDE"];
[_crate3] execVM "missions\misc\fillBoxesH.sqf";
_crate3 setVariable ["Sarge",1,true];

_aispawn = [_coords,80,6,6,1] execVM "missions\add_unit_server.sqf";//AI Guards
sleep 5;
_aispawn = [_coords,80,6,4,1] execVM "missions\add_unit_server.sqf";//AI Guards
sleep 5;
_aispawn = [_coords,40,4,4,1] execVM "missions\add_unit_server.sqf";//AI Guards
sleep 5;
_aispawn = [_coords,80,6,4,1] execVM "missions\add_unit_server.sqf";//AI Guards

waitUntil{{isPlayer _x && _x distance _c130crash < 10  } count playableunits > 0}; 

[nil,nil,rTitleText,"The c130 has been taken by survivors!", "PLAIN",6] call RE;


[] execVM "aimissionmarkers\remmarkers.sqf";
MissionGo = 0;
Ccoords = 0;
publicVariable "Ccoords";


SM1 = 5;
[0] execVM "missions\major\SMfinder.sqf";
