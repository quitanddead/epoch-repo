if (isServer) then {
	waitUntil{dayz_preloadFinished};
};
_id = [] execFSM "\z\addons\dayz_server\system\player_monitor.fsm";