/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\3475.gsc
***************************************/

init() {
  var_0 = spawnstruct();
  var_0._id_039B = "deployable_vest_marker_mp";
  var_0._id_B91A = "afr_mortar_ammo_01";
  var_0._id_017B = &"KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
  var_0._id_3A41 = &"KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
  var_0._id_67E5 = "deployable_juicebox_taken";
  var_0._id_110EA = "deployable_juicebox";
  var_0._id_10A38 = "used_deployable_juicebox";
  var_0._id_FC47 = "compass_objpoint_deploy_juiced_friendly";
  var_0._id_8C7A = 25;
  var_0._id_AC71 = 90.0;
  var_0._id_130FC = 50;
  var_0._id_EC44 = "destroyed_vest";
  var_0._id_13523 = "ballistic_vest_destroyed";
  var_0._id_5230 = "mp_vest_deployed_ui";
  var_0._id_C5C7 = "ammo_crate_use";
  var_0._id_C5BC = ::_id_C5BE;
  var_0._id_3936 = ::_id_3937;
  var_0._id_130EE = 500;
  var_0.maxhealth = 300;
  var_0._id_4D4A = "deployable_bag";
  var_0._id_4E76 = "deployable_ammo_mp";
  var_0._id_4E74 = loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death");
  var_0._id_1C9D = 1;
  var_0._id_1C96 = 0;
  var_0._id_B4D1 = 4;
  level._id_2F30["deployable_juicebox"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("deployable_juicebox", ::_id_128E0);
  level._id_5212["deployable_juicebox"] = [];
}

_id_128E0(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\deployablebox::_id_2A63(var_0, "deployable_juicebox");

  if (!isdefined(var_2) || !var_2)
  return 0;

  scripts\mp\matchdata::_id_AFC9("deployable_juicebox", self.origin);
  return 1;
}

_id_C5BE(var_0) {
  thread scripts\mp\perks\perkfunctions::_id_F769(15);
}

_id_3937(var_0) {
  return !scripts\mp\utility\game::isjuggernaut() && !scripts\mp\perks\perkfunctions::_id_8C03();
}