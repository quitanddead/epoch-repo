// passToSkynet.sqf

if (isDedicated) then {
	while {true} do {
		// Sync AI Units Back To HC
		{
		//diag_log format ["ERIC DEBUG: AI Sync Check"];

		if (!isNull HC && !isPlayer _x) then {
				if (owner _x != owner HC) then {
					diag_log format ["ERIC DEBUG: Unit _x = %1 transferring to %2[%3] from %4[%5]", _x, owner HC, name HC, owner _x, name _x];
					_x setOwner (owner HC);
					sleep 0.1;
					diag_log format ["ERIC DEBUG: Confirming %1 new owner = %2[%3], [AiE]Skynet = %4", _x, owner _x, name _x, owner HC];
				};
			};
		} forEach allUnits;

		//diag_log format ["ERIC DEBUG: AI Sync Check Complete"];

		// Sync every 60 seconds
		sleep 60;
	};
};