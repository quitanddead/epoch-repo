// passToSkynet.sqf

if (isDedicated) then {

	//Sync AI Units Back To HC
	{ if (!isPlayer _x) then {
			_x setOwner (owner HC);
			diag_log format ["_x = %1 transferred to %2", _x, name HC];
		};
	} forEach allUnits;

	sleep 300;

};