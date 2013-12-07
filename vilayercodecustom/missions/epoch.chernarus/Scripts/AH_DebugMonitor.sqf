/* Stripped from AHconfig.sqf for all players */
/* ********************************************************************************* */
/*  DebugMonitor TXT      */ _BottomDebug = '[AiE] aieclan.com'; //do not use ' or " in this text.
/*  DebugMonitor Key      */ _ODK =  0xCF;	/* google DIK_KeyCodes (0xCF is END) */
/*  Use DebugMonitor      */ _DMS =  true;	/* true or false */	/* starts up with debugmonitor ON if true */
/*  DebugMonitor Action   */ _DMW = false;	/* true or false */	/* "Debug" option on mousewheel */
/*  DebugMonitor ITEM     */ _DBI = false;	/* item or false */	/* _DBI = 'your item choice'; */
/* ********************************************************************************* */

waitUntil {!isNull player && isPlayer player};

fnc_debugX0 = {
	if (isNil 'debugMonitorX') then 
	{
		debugMonitorX = true;
		[] spawn fnc_debugX;
	}
	else
	{
		debugMonitorX = !debugMonitorX;
		hintSilent '';
		[] spawn fnc_debugX;
	};
};	
fnc_debugX = {
	admin_debug_run = false;
	_item = _DBI;
	_state = true;
	while {debugMonitorX} do
	{
		if (str(_item) == 'false') then
		{
			_state = true;
		}
		else
		{
			_state = _item in (magazines player +weapons player);
		};
		if !(_state) then {debugMonitorX = false;hintSilent '';};
		
		_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
		if (player == vehicle player) then {_pic = (gettext (configFile >> 'cfgWeapons' >> (currentWeapon player) >> 'picture'));
		}else{_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));};
		
		_txt = '';
		_txt = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'displayName'));
		
		_stime = 0;
		if(serverTime > 36000)then{_stime = time;}else{_stime = serverTime;};
		_hours = (_stime/60/60);
		_hours = toArray (str _hours);
		_hours resize 1;
		_hours = toString _hours;
		_hours = compile _hours;
		_hours = call  _hours;
		_minutes = floor(_stime/60);
		_minutes2 = _minutes - (_hours*60);
		
		hintSilent parseText format ["
		<t size='1' font='Bitstream' align='Center' >[%1]</t><br/>
		<img size='4.75' image='%4'/><br/>
		<t size='1' font='Bitstream' align='left' color='#CC0000'>Blood: </t><t size='1' font='Bitstream' align='right'>%2</t><br/>
		<t size='1' font='Bitstream' align='left' color='#0066CC'>Humanity: </t><t size='1' font='Bitstream' align='right'>%3</t><br/>
		<br/>
		<t size='1' font='Bitstream' align='left' color='#FFBF00'>Zombie Kills: </t><t size='1' font='Bitstream' align='right'>%9</t><br/>
		<t size='1' font='Bitstream' align='left' color='#FFBF00'>Murders: </t><t size='1' font='Bitstream' align='right'>%10</t><br/>
		<t size='1' font='Bitstream' align='left' color='#FFBF00'>Bandits Killed: </t><t size='1' font='Bitstream' align='right'>%11</t><br/>
		<br/>
		<t size='1' font='Bitstream' align='left' color='#FFBF00'>UPTIME: </t><t size='1' font='Bitstream' align='right'>%5h %6min</t><br/>
		<t size='1' font='Bitstream' align='left' color='#FFBF00'>FPS: </t><t size='1' font='Bitstream' align='right'>%8</t><br/>
		<t size='1' font='Bitstream' align='Center' color='#CC0000'>%7</t>
		",
		_txt,
		(r_player_blood),
		round (player getVariable['humanity', 0]),
		_pic,
		_hours,
		_minutes2,
		_BottomDebug,
		(round diag_fps),
		(player getVariable['zombieKills', 0]),
		(player getVariable['humanKills', 0]),
		(player getVariable['banditKills', 0])
		];
		sleep 1;
	};
};

[] spawn fnc_debugX0;
