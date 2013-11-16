waituntil {!alive player ; !isnull (finddisplay 46)};
if ((getPlayerUID player) in ["51361798","116334982","106982534","106734150","73665926","119653894","67442502"]) then {
	sleep 30;
	player addaction [("<t color=""#0074E8"">" + ("Tools Menu") +"</t>"),"admintools\Eexcute.sqf","",5,false,true,"",""];
};