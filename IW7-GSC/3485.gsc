/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\3485.gsc
***************************************/

init() {
  var_0 = spawnstruct();
  var_0._id_B923 = [];
  var_0._id_B923["allies"] = "vehicle_mig29_desert";
  var_0._id_B923["axis"] = "vehicle_mig29_desert";
  var_0._id_93B9 = "veh_mig29_dist_loop";
  var_0._id_4464 = "compass_objpoint_airstrike_friendly";
  var_0._id_4463 = "compass_objpoint_airstrike_busy";
  var_0._id_02B3 = 5000;
  var_0._id_8863 = 15000;
  var_0._id_8D13 = 500;
  var_0._id_C74F = "airstrike_mp_roll";
  var_0._id_C4C6 = ::_id_5D24;
  var_0._id_C52E = ::_id_40F7;
  var_0._id_3ED0 = 1;
  var_0._id_F1CA = "KS_hqr_airstrike";
  var_0._id_93BA = "KS_ast_inbound";
  var_0._id_2C5A = "projectile_cbu97_clusterbomb";
  var_0._id_C21A = 3;
  var_0._id_5703 = 350;
  var_0._id_5FEF = 200;
  var_0._id_5FEA = 120;
  var_0._id_5FF4 = loadfx("vfx/core/smktrail/poisonous_gas_linger_medium_thick_killer_instant");
  var_0._id_5FEE = 0.25;
  var_0._id_5FED = 0.5;
  var_0._id_5FEC = 13;
  var_0._id_5FE7 = 1.0;
  var_0._id_5FE8 = 10;
  var_0._id_C263 = "gas_strike_mp";
  var_0._id_A640 = (0, 0, 60);
  level._id_CC43["gas_airstrike"] = var_0;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("gas_airstrike", ::_id_C5BB);
}

_id_C5BB(var_0, var_1) {
  var_2 = scripts\mp\utility\game::_id_8027(self.team);

  if (isdefined(level._id_C22F)) {
  self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
  return 0;
  } else {
  var_3 = scripts\mp\killstreaks\plane::_id_F1AA(var_0, "gas_airstrike", ::_id_5AB7);
  return isdefined(var_3) && var_3;
  }
}

_id_5AB7(var_0, var_1, var_2, var_3) {
  level._id_C22F = 0;
  wait 1;
  var_4 = scripts\mp\killstreaks\plane::_id_806A();
  var_5 = anglestoforward((0, var_2, 0));
  _id_5976(var_3, var_0, var_1, var_5, var_4);
  self waittill("gas_airstrike_flyby_complete");
}

_id_5976(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level._id_CC43[var_0];
  var_6 = scripts\mp\killstreaks\plane::_id_7EBE(var_2, var_3, var_5._id_8863, 1, var_4, var_5._id_02B3, 0, var_0);
  level thread scripts\mp\killstreaks\plane::_id_5857(var_1, self, var_1, var_6["startPoint"] + (0, 0, randomint(var_5._id_8D13)), var_6["endPoint"] + (0, 0, randomint(var_5._id_8D13)), var_6["attackTime"], var_6["flyTime"], var_3, var_0);
}

_id_40F7(var_0, var_1, var_2) {
  var_0 notify("gas_airstrike_flyby_complete");
}

_id_5D24(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  wait(var_2);
  var_5 = level._id_CC43[var_4];
  var_6 = var_5._id_C21A;
  var_7 = var_5._id_5703 / var_5._id_02B3;

  while (var_6 > 0) {
  thread _id_5D35(var_3, var_4);
  var_6--;
  wait(var_7);
  }
}

_id_5D35(var_0, var_1) {
  level._id_C22F++;
  var_2 = self;
  var_3 = level._id_CC43[var_1];
  var_4 = anglestoforward(var_2.angles);
  var_5 = _id_10836(var_3._id_2C5A, var_2.origin, var_2.angles);
  var_5 movegravity(var_4 * (var_3._id_02B3 / 1.5), 3.0);
  var_6 = spawn("script_model", var_5.origin);
  var_6 setmodel("tag_origin");
  var_6.origin = var_5.origin;
  var_6.angles = var_5.angles;
  var_5 setmodel("tag_origin");
  wait 0.1;
  var_7 = var_6.origin;
  var_8 = var_6.angles;

  if (level._id_10A56)
  playfxontag(level._id_1AFD, var_6, "tag_origin");
  else
  playfxontag(level._id_1AF7, var_6, "tag_origin");

  wait 1.0;
  var_9 = bullettrace(var_6.origin, var_6.origin + (0, 0, -1000000.0), 0, undefined);
  var_10 = var_9["position"];
  var_5 _id_C4CD(var_0, var_10, var_1);
  var_6 delete();
  var_5 delete();
  level._id_C22F--;

  if (level._id_C22F == 0)
  level._id_C22F = undefined;
}

_id_10836(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3.angles = var_2;
  var_3 setmodel(var_0);
  return var_3;
}

_id_C4CD(var_0, var_1, var_2) {
  var_3 = level._id_CC43[var_2];
  var_4 = spawn("trigger_radius", var_1, 0, var_3._id_5FEF, var_3._id_5FEA);
  var_4.owner = var_0;
  var_5 = var_3._id_5FEF;
  var_6 = spawnfx(var_3._id_5FF4, var_1);
  triggerfx(var_6);
  wait(randomfloatrange(var_3._id_5FEE, var_3._id_5FED));
  var_7 = var_3._id_5FEC;
  var_8 = spawn("script_model", var_1 + var_3._id_A640);
  var_8 linkto(var_4);

  for (self._id_A63A = var_8; var_7 > 0.0; var_7 = var_7 - var_3._id_5FE7) {
  foreach (var_10 in level._id_3CB5)
  var_10 _id_20CC(var_0, var_1, var_4, self, var_3._id_5FE8);

  wait(var_3._id_5FE7);
  }

  self._id_A63A delete();
  var_4 delete();
  var_6 delete();
}

_id_20CC(var_0, var_1, var_2, var_3, var_4) {
  if (var_0 scripts\mp\utility\game::isenemy(self) && isalive(self) && self istouching(var_2)) {
  var_3 _meth_8253(self.origin, 1, var_4, var_4, var_0, "MOD_RIFLE_BULLET", "gas_strike_mp");

  if (!scripts\mp\utility\game::isusingremote()) {
  var_5 = scripts\mp\perks\perkfunctions::_id_20E0(var_0, self, 2.0);
  self shellshock("default", var_5);
  }
  }
}