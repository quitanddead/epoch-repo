activateAddons [
];

activateAddons [];
initAmbientLife;

_this = createCenter west;
_center_0 = _this;

_group_0 = createGroup _center_0;

_unit_0 = objNull;
if (true) then
{
  _this = _group_0 createUnit ["US_Soldier_TL_EP1", [3736.3584, 6000.9678], [], 0, "CAN_COLLIDE"];
  _unit_0 = _this;
  _this setUnitAbility 0.60000002;
  if (true) then {_group_0 selectLeader _this;};
  if (true) then {selectPlayer _this;};
};

_vehicle_0 = objNull;
if (true) then
{
  _this = createVehicle ["Land_Mil_Barracks_i", [3719.3232, 5968.875, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_0 = _this;
  _this setDir -163.38731;
  _this setPos [3719.3232, 5968.875, -3.0517578e-005];
};

_vehicle_1 = objNull;
if (true) then
{
  _this = createVehicle ["SignM_FARP_Winchester_EP1", [3725.8962, 6002.6079, -6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_1 = _this;
  _this setDir -151.08919;
  _this setPos [3725.8962, 6002.6079, -6.1035156e-005];
};

_vehicle_2 = objNull;
if (true) then
{
  _this = createVehicle ["Sign_Danger", [3724.063, 6003.2905], [], 0, "CAN_COLLIDE"];
  _vehicle_2 = _this;
  _this setDir 25.386911;
  _this setPos [3724.063, 6003.2905];
};

_vehicle_4 = objNull;
if (true) then
{
  _this = createVehicle ["Sign_Danger", [3718.6895, 6010.1484, 6.1035156e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_4 = _this;
  _this setDir 84.381424;
  _this setPos [3718.6895, 6010.1484, 6.1035156e-005];
};

_vehicle_6 = objNull;
if (true) then
{
  _this = createVehicle ["Sign_1L_Noentry_EP1", [3729.0559, 6007.4712, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_6 = _this;
  _this setDir -131.39705;
  _this setPos [3729.0559, 6007.4712, -3.0517578e-005];
};

_vehicle_8 = objNull;
if (true) then
{
  _this = createVehicle ["Sign_1L_Noentry_EP1", [3724.1646, 6013.5635], [], 0, "CAN_COLLIDE"];
  _vehicle_8 = _this;
  _this setDir -131.39705;
  _this setPos [3724.1646, 6013.5635];
};

_vehicle_11 = objNull;
if (true) then
{
  _this = createVehicle ["RoadBarrier_long", [3727.7095, 6009.0796, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_11 = _this;
  _this setDir 48.386696;
  _this setPos [3727.7095, 6009.0796, -3.0517578e-005];
};

_vehicle_13 = objNull;
if (true) then
{
  _this = createVehicle ["RoadBarrier_long", [3725.3513, 6011.7393, -3.0517578e-005], [], 0, "CAN_COLLIDE"];
  _vehicle_13 = _this;
  _this setDir 47.905254;
  _this setPos [3725.3513, 6011.7393, -3.0517578e-005];
};

processInitCommands;
runInitScript;
finishMissionInit;
