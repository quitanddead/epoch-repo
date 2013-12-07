// passToSkynet.sqf

if (isDedicated) then {
	while {true} do {
		// Sync AI Units Back To HC
		{ if (!isPlayer _x) then {
				diag_log format ["ERIC DEBUG: _x = %1 transferred to %2[%3] from %4", _x, name HC, owner HC, owner _x];
				_x setOwner (owner HC);
				diag_log format ["ERIC DEBUG: Confirming %1 new owner = %2, [AiE]Skynet = %3", _x, owner _x, owner HC];
			};
		} forEach allUnits;

		// Sync every 60 seconds
		sleep 60;
	};
};