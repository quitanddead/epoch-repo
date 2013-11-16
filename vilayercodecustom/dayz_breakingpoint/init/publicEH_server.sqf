/*
	Breaking Point - Server Public Event Handlers
	By Deathlyrage
*/
"dayzLogin"			addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerLogin};
"dayzLogin2"		addPublicVariableEventHandler {(_this select 1) call server_playerSetup};
"norrnRaLW"   		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\load_wounded.sqf"};
"norrnRLact"		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\load\load_wounded.sqf"};
"norrnRDead"   		addPublicVariableEventHandler {[_this select 1] execVM "\z\addons\dayz_code\medical\publicEH\deadState.sqf"};
"dayzHumanity"		addPublicVariableEventHandler {(_this select 1) spawn player_humanityChange};
"usecBleed"			addPublicVariableEventHandler {_id = (_this select 1) spawn fnc_usec_damageBleed};
"usecBandage"		addPublicVariableEventHandler {(_this select 1) call player_medBandage};
"usecInject"		addPublicVariableEventHandler {(_this select 1) call player_medInject};
"usecEpi"			addPublicVariableEventHandler {(_this select 1) call player_medEpi};
"usecTransfuse"		addPublicVariableEventHandler {(_this select 1) call player_medTransfuse};
"usecMorphine"		addPublicVariableEventHandler {(_this select 1) call player_medMorphine};
"usecPainK"			addPublicVariableEventHandler {(_this select 1) call player_medPainkiller};
"dayzDeath"			addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerDied};
"dayzPlayerSave"	addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerSync};
"dayzPublishObj"	addPublicVariableEventHandler {(_this select 1) call server_publishObj};
"dayzUpdateVehicle" addPublicVariableEventHandler {_id = (_this select 1) spawn server_updateObject};
"dayzPlayerMorph"	addPublicVariableEventHandler {(_this select 1) call server_playerMorph};
"dayzUpdate"		addPublicVariableEventHandler {_id = (_this select 1) spawn dayz_processUpdate};
"dayzLoginRecord"	addPublicVariableEventHandler {_id = (_this select 1) spawn dayz_recordLogin};
"dayzCharSave"		addPublicVariableEventHandler {_id = (_this select 1) spawn server_playerSync};

//Checking
"dayzSetFuel"		addPublicVariableEventHandler {(_this select 1) spawn local_setFuel};
"dayzSetFix"		addPublicVariableEventHandler {(_this select 1) call object_setFixServer};
"dayzDeleteObj"		addPublicVariableEventHandler {(_this select 1) spawn server_deleteObj};

"dayzHit" addPublicVariableEventHandler {
	_array = _this select 1;
	_type = _array select 0;
	switch(_type) do
	{
		case "dayzLogin": {
			_array = _array - [_type];
			diag_log(_array);
			_array spawn server_playerLogin;
		};
		case "dayzLogin2": {
			_array = _array - [_type];
			diag_log(_array);
			_array call server_playerSetup;
		};
		case "dayzDeath": {
			_array = _array - [_type];
			diag_log(_array);
			_array spawn server_playerDied;
		};
		default {
				(_this select 1) call fnc_usec_damageHandler;
		};
	};
};