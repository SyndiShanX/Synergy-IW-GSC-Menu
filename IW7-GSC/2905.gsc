/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2905.gsc
***************************************/

_id_C97C(var_0) {
  if (isdefined(self._id_010C))
  return;

  self endon("enemy");
  self endon("death");
  self endon("damage");
  self endon("end_patrol");
  self endon("dog_attacks_ai");
  waittillframeend;

  if (isdefined(self._id_EED1))
  [[level._id_83D2["_patrol_endon_spotted_flag"]]]();

  thread _id_13749();
  thread _id_13759();
  self._id_015C = 32;
  self _meth_800B("stand");
  self._id_55B0 = 1;
  self._id_55ED = 1;
  self._id_0030 = 1;
  self._id_EE7E = 1;
  self._id_C3E8 = self._id_00BC;
  self._id_00BC = "no_cover";
  _id_0B91::_id_5514();

  if (isdefined(self._id_EE2C)) {
  self._id_C3FA = self._id_BCD6;
  self._id_BCD6 = self._id_EE2C;
  }

  _id_AD3A();
  _id_F4C7();
  var_1["ent"][1] = ::_id_7CD9;
  var_1["ent"][0] = _id_0B91::_id_7A8F;
  var_1["node"][1] = ::_id_7CDB;
  var_1["node"][0] = ::_id_7A92;
  var_1["struct"][1] = ::_id_7CE0;
  var_1["struct"][0] = _id_0B91::_id_7A97;
  var_2["ent"] = _id_0B91::_id_F3D3;
  var_2["node"] = _id_0B91::_id_F3D9;
  var_2["struct"] = _id_0B91::_id_F3D3;

  if (isdefined(var_0))
  self._id_0334 = var_0;

  if (isdefined(self._id_0334)) {
  var_3 = 1;
  var_4 = _id_7CD9();
  var_5 = _id_7CDB();
  var_6 = _id_7CE0();

  if (var_4.size) {
  var_7 = scripts\engine\utility::_id_DC6B(var_4);
  var_8 = "ent";
  }
  else if (var_5.size) {
  var_7 = scripts\engine\utility::_id_DC6B(var_5);
  var_8 = "node";
  } else {
  var_7 = scripts\engine\utility::_id_DC6B(var_6);
  var_8 = "struct";
  }
  } else {
  var_3 = 0;
  var_4 = _id_0B91::_id_7A8F();
  var_5 = _id_7A92();
  var_6 = _id_0B91::_id_7A97();

  if (var_4.size) {
  var_7 = scripts\engine\utility::_id_DC6B(var_4);
  var_8 = "ent";
  }
  else if (var_5.size) {
  var_7 = scripts\engine\utility::_id_DC6B(var_5);
  var_8 = "node";
  } else {
  var_7 = scripts\engine\utility::_id_DC6B(var_6);
  var_8 = "struct";
  }
  }

  var_9 = [];
  var_9["pause"] = "patrol_idle_";
  var_9["turn180"] = scripts\engine\utility::ter_op(isdefined(self._id_C97E), self._id_C97E, "patrol_turn180");
  var_9["smoke"] = "patrol_idle_smoke";
  var_9["stretch"] = "patrol_idle_stretch";
  var_9["checkphone"] = "patrol_idle_checkphone";
  var_9["phone"] = "patrol_idle_phone";
  var_10 = var_7;

  for (;;) {
  while (isdefined(var_10._id_C97F))
  wait 0.05;

  var_7._id_C97F = undefined;
  var_7 = var_10;
  self notify("release_node");
  var_7._id_C97F = 1;
  self._id_A8F4 = var_7;
  [[var_2[var_8]]](var_7);

  if (isdefined(var_7.radius) && var_7.radius > 0)
  self._id_015C = var_7.radius;
  else
  self._id_015C = 32;

  self waittill("goal");
  var_7 notify("trigger", self);

  if (isdefined(var_7._id_ED9E))
  scripts\engine\utility::_id_6E3E(var_7._id_ED9E);

  if (isdefined(var_7._id_ED80))
  _id_0B91::_id_65E1(var_7._id_ED80);

  if (isdefined(var_7._id_ED9B))
  scripts\engine\utility::_id_6E2A(var_7._id_ED9B);

  var_11 = var_7 [[var_1[var_8][var_3]]]();

  if (!var_11.size) {
  if (isdefined(var_7._id_ED88))
  self _meth_8221("face angle", var_7.angles[1]);

  self notify("reached_path_end");
  self notify("_patrol_reached_path_end");

  if (isalive(self._id_C991))
  self._id_C991 notify("master_reached_patrol_end");
  }

  var_12 = scripts\anim\reactions::_id_DD51;
  var_13 = var_7._id_ECF5;
  var_14 = 1;
  var_15 = 0;

  if (isdefined(var_7._id_EE79)) {
  var_16 = strtok(var_7._id_EE79, " ");

  for (var_17 = 0; var_17 < var_16.size; var_17++) {
  switch (var_16[var_17]) {
  case "keep_running":
  var_14 = 0;
  break;
  case "use_node":
  var_15 = 1;
  break;
  case "animset":
  var_17 = var_17 + 1;
  self._id_ECF5 = var_16[var_17];

  if (self._id_ECF5 == "default") {
  self._id_ECF5 = undefined;
  self._id_C9AB = undefined;
  self._id_C9AC = undefined;
  self._id_C987 = undefined;
  }

  _id_F4C7();
  }
  }
  }

  if (isdefined(var_7._id_EE2C))
  self._id_BCD6 = var_7._id_EE2C;

  if (var_7 _id_8BA5() && var_7 _id_ED4E() || isdefined(var_13) || isdefined(var_7._id_EDA0) && !scripts\engine\utility::_id_6E25(var_7._id_EDA0)) {
  if (!isdefined(self._id_C98F) && var_14)
  _id_C981(var_13, var_12, var_7);

  if (isdefined(var_7._id_EDA0) && !scripts\engine\utility::_id_6E25(var_7._id_EDA0))
  scripts\engine\utility::_id_6E4C(var_7._id_EDA0);

  var_7 _id_0B91::_id_027B();

  if (isdefined(var_13)) {
  if (isdefined(var_7._id_ED88))
  self _meth_8221("face angle", var_7.angles[1]);

  self._id_C99C = 1;
  var_18 = var_9[var_13];

  if (!isdefined(var_18)) {
  if (isdefined(level._id_C99E))
  var_18 = level._id_C99E[var_13];
  }

  if (isdefined(var_18)) {
  if (var_13 == "pause") {
  if (isdefined(self._id_C99D) && isdefined(self._id_C99D[var_13]))
  var_18 = self._id_C99D[var_13][randomint(self._id_C99D[var_13].size)];
  else
  var_18 = var_18 + randomintrange(1, 6);
  }

  if (var_15) {
  var_7 _id_0B06::_id_1ECE(self, var_18);
  var_7 _id_0B06::_id_1EC8(self, "gravity", var_18, undefined, var_12);
  }
  else
  _id_0B06::_id_1EC8(self, "gravity", var_18, undefined, var_12);
  }

  self._id_C99C = undefined;
  }

  if (var_11.size && (!isdefined(var_13) || var_13 != "turn180") && var_14 && (!isdefined(self._id_1025F) || !self._id_1025F))
  _id_C980(var_13, var_12);
  }

  if (!var_11.size) {
  if (isdefined(self._id_C982) && !isdefined(var_13)) {
  _id_C981("path_end_idle", var_12, var_7);

  for (;;) {
  var_19 = self._id_C982[randomint(self._id_C982.size)];
  _id_0B06::_id_1EC8(self, "gravity", var_19, undefined, var_12);
  }
  }

  break;
  }

  var_10 = scripts\engine\utility::_id_DC6B(var_11);
  }
}

_id_C981(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 0;

  if (isdefined(var_2._id_ED88)) {
  var_3 = var_2;
  self._id_C0C1 = 1;
  var_4 = 1;
  }

  if (isdefined(self._id_C9A7) && isdefined(self._id_C9A7[var_0]))
  var_3 _id_0B06::_id_1EC8(self, "gravity", self._id_C9A7[var_0], undefined, var_1, var_4);
  else if (isdefined(self._id_ECF5) && isdefined(level._id_EC85["generic"]["patrol_stop_" + self._id_ECF5]))
  _id_0B06::_id_1EC8(self, "gravity", "patrol_stop_" + self._id_ECF5, undefined, var_1);
  else
  var_3 _id_0B06::_id_1EC8(self, "gravity", "patrol_stop", undefined, var_1, var_4);
}

_id_C980(var_0, var_1) {
  if (isdefined(self._id_C9A3) && isdefined(self._id_C9A3[var_0]))
  _id_0B06::_id_1EC8(self, "gravity", self._id_C9A3[var_0], undefined, var_1);
  else if (isdefined(self._id_ECF5) && isdefined(level._id_EC85["generic"]["patrol_start_" + self._id_ECF5]))
  _id_0B06::_id_1EC8(self, "gravity", "patrol_start_" + self._id_ECF5, undefined, var_1);
  else
  _id_0B06::_id_1EC8(self, "gravity", "patrol_start", undefined, var_1);
}

#using_animtree("generic_human");

_id_10B63() {
  if (self._id_1491._id_D6A5 == "crouch" && isdefined(self._id_1491._id_2274)) {
  var_0 = self._id_1491._id_2274["stance_change"];

  if (isdefined(var_0)) {
  self _meth_82E4("stand_up", var_0, %root, 1);
  scripts\anim\shared::_id_592B("stand_up");
  }
  }
}

_id_C99B() {
  self endon("enemy");
  self _meth_8016("zonly_physics", 0);
  self _meth_8221("face current");
  _id_10B63();
  var_0 = level._id_EC85["generic"]["patrol_radio_in_clear"];
  self _meth_82E4("radio", var_0, %root, 1);
  scripts\anim\shared::_id_592B("radio");
  _id_12942();
}

_id_12942() {
  if (!isdefined(self._id_0233))
  return;

  var_0 = self._id_0233;
  var_1 = var_0 - self.origin;
  var_1 = (var_1[0], var_1[1], 0);
  var_2 = lengthsquared(var_1);

  if (var_2 < 1)
  return;

  var_1 = var_1 / sqrt(var_2);
  var_3 = anglestoforward(self.angles);

  if (vectordot(var_3, var_1) < -0.5) {
  self _meth_8016("zonly_physics", 0);
  self _meth_8221("face current");
  _id_10B63();
  var_4 = level._id_EC85["generic"]["patrol_turn180"];
  self _meth_82E4("move", var_4, %root, 1);

  if (animhasnotetrack(var_4, "code_move")) {
  scripts\anim\shared::_id_592B("move");
  self _meth_8221("face motion");
  self _meth_8016("none", 0);
  }

  scripts\anim\shared::_id_592B("move");
  }
}

_id_F4C7() {
  if (isdefined(self._id_ECF5)) {
  if (isdefined(level._id_EC85["generic"]["patrol_walk_" + self._id_ECF5]))
  self._id_C9AB = "patrol_walk_" + self._id_ECF5;

  if (isdefined(level._id_EC85["generic"]["patrol_walk_weights_" + self._id_ECF5]))
  self._id_C9AC = "patrol_walk_weights_" + self._id_ECF5;

  if (isdefined(level._id_EC85["generic"]["patrol_idle_" + self._id_ECF5]))
  self._id_C987 = "patrol_idle_" + self._id_ECF5;
  }

  var_0 = "patrol_walk";

  if (isdefined(self._id_C9AB))
  var_0 = self._id_C9AB;

  var_1 = undefined;

  if (isdefined(self._id_C9AC))
  var_1 = self._id_C9AC;

  if (isdefined(self._id_ECF5)) {
  if (isdefined(level._id_EC85["generic"]["patrol_idle_" + self._id_ECF5]))
  _id_0B91::_id_F3C8("patrol_idle_" + self._id_ECF5);
  }

  _id_0B91::_id_F3CC(var_0, var_1);
}

_id_1374A() {
  self endon("end_patrol");

  if (isdefined(self._id_C98C))
  self._id_C98C endon("death");

  self waittill("enemy");
}

_id_13759() {
  self waittill("death");

  if (!isdefined(self))
  return;

  self notify("release_node");

  if (!isdefined(self._id_A8F4))
  return;

  self._id_A8F4._id_C97F = undefined;
}

_id_13749() {
  self endon("death");
  _id_1374A();
  var_0 = _id_0B91::_id_65DF("_stealth_enabled") && _id_0B91::_id_65DB("_stealth_enabled");
  self._id_EE7E = 0;

  if (isdefined(self._id_C3E8))
  self._id_00BC = self._id_C3E8;

  if (!var_0) {
  _id_0B91::_id_4154();
  self._id_00BC = self._id_C3E8;
  _id_0B91::_id_417A();
  self _meth_800B("stand", "crouch", "prone");
  self._id_55B0 = 0;
  self._id_55ED = 0;
  self _meth_83A1();
  self notify("stop_animmode");
  self._id_EE56 = undefined;
  self._id_015C = level._id_4FF6;
  }

  if (isdefined(self._id_C3C3))
  self._id_0190 = self._id_C3C3;

  self._id_BCD6 = 1;

  if (!isdefined(self))
  return;

  self notify("release_node");

  if (!isdefined(self._id_A8F4))
  return;

  self._id_A8F4._id_C97F = undefined;
}

_id_7CD9() {
  var_0 = [];

  if (isdefined(self._id_0334))
  var_0 = getentarray(self._id_0334, "targetname");

  return var_0;
}

_id_7CDB() {
  var_0 = [];

  if (isdefined(self._id_0334))
  var_0 = getnodearray(self._id_0334, "targetname");

  return var_0;
}

_id_7CE0() {
  var_0 = [];

  if (isdefined(self._id_0334))
  var_0 = scripts\engine\utility::_id_8180(self._id_0334, "targetname");

  return var_0;
}

_id_7A92() {
  var_0 = [];

  if (isdefined(self._id_EE01)) {
  var_1 = strtok(self._id_EE01, " ");

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
  var_3 = getnode(var_1[var_2], "script_linkname");

  if (isdefined(var_3))
  var_0[var_0.size] = var_3;
  }
  }

  return var_0;
}

_id_10118(var_0) {
  self endon("release_node");
}

_id_AD3A() {
  if (isdefined(self._id_C991)) {
  self._id_C991 thread _id_CA83();
  return;
  }

  if (!isdefined(self._id_EE81))
  return;

  waittillframeend;
  var_0 = _func_074(self.team, "dog");
  var_1 = undefined;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
  if (!isdefined(var_0[var_2]._id_EE81))
  continue;

  if (var_0[var_2]._id_EE81 != self._id_EE81)
  continue;

  var_1 = var_0[var_2];
  self._id_C991 = var_1;
  var_1._id_C98C = self;
  break;
  }

  if (!isdefined(var_1))
  return;

  var_1 thread _id_CA83();
}

_id_CA83() {
  _id_0B91::_id_106ED(self);

  if (isdefined(self._id_010C))
  return;

  self endon("enemy");
  self endon("death");
  self endon("end_patrol");

  if (isdefined(self._id_EED1))
  [[level._id_83D2["_patrol_endon_spotted_flag"]]]();

  self._id_C98C endon("death");
  thread _id_13749();
  self._id_015C = 4;
  self._id_0030 = 1;
  var_0 = _id_CA84();
  var_1 = vectornormalize(self.origin - self._id_C98C.origin);
  var_2 = anglestoright(self._id_C98C.angles);
  var_3 = "left";

  if (vectordot(var_1, var_2) > 0)
  var_3 = "right";

  wait 1;
  thread _id_CA86();
  thread _id_CA87();
  self._id_C3C3 = self._id_0190;
  self._id_0190 = 70;

  for (;;) {
  if (isdefined(self._id_C98C) && !isdefined(self._id_C98C._id_C99C)) {
  var_0 = _id_CA88(var_0);

  if (var_3 == "null")
  var_3 = "back";

  var_3 = _id_CA85(var_0, var_3);
  self._id_C986 = var_0[var_3].origin;
  }
  else
  self._id_C986 = self.origin;

  self _meth_82EF(self._id_C986);
  wait 0.05;
  }
}

_id_CA84() {
  var_0 = [];
  var_1 = spawnstruct();
  var_1._id_C6C0 = [];
  var_1._id_C6C0[var_1._id_C6C0.size] = "right";
  var_1._id_C6C0[var_1._id_C6C0.size] = "back_right";
  var_2 = spawnstruct();
  var_2._id_C6C0 = [];
  var_2._id_C6C0[var_2._id_C6C0.size] = "right";
  var_2._id_C6C0[var_2._id_C6C0.size] = "back_right";
  var_2._id_C6C0[var_2._id_C6C0.size] = "back";
  var_3 = spawnstruct();
  var_3._id_C6C0 = [];
  var_3._id_C6C0[var_3._id_C6C0.size] = "back_right";
  var_3._id_C6C0[var_3._id_C6C0.size] = "back_left";
  var_3._id_C6C0[var_3._id_C6C0.size] = "back";
  var_4 = spawnstruct();
  var_4._id_C6C0 = [];
  var_4._id_C6C0[var_4._id_C6C0.size] = "left";
  var_4._id_C6C0[var_4._id_C6C0.size] = "back_left";
  var_4._id_C6C0[var_4._id_C6C0.size] = "back";
  var_5 = spawnstruct();
  var_5._id_C6C0 = [];
  var_5._id_C6C0[var_5._id_C6C0.size] = "left";
  var_5._id_C6C0[var_5._id_C6C0.size] = "back_left";
  var_6 = spawnstruct();
  var_0["right"] = var_1;
  var_0["left"] = var_5;
  var_0["back_right"] = var_2;
  var_0["back_left"] = var_4;
  var_0["back"] = var_3;
  var_0["null"] = var_6;
  return var_0;
}

_id_CA88(var_0) {
  var_1 = vectortoangles(self._id_C98C._id_A8F4.origin - self._id_C98C.origin);
  var_2 = self._id_C98C.origin;
  var_3 = anglestoright(var_1);
  var_4 = anglestoforward(var_1);
  var_0["right"].origin = var_2 + var_3 * 40 + var_4 * 30;
  var_0["left"].origin = var_2 + var_3 * -40 + var_4 * 30;
  var_0["back_right"].origin = var_2 + var_3 * 32 + var_4 * -16;
  var_0["back_left"].origin = var_2 + var_3 * -32 + var_4 * -16;
  var_0["back"].origin = var_2 + var_4 * -48;
  var_0["null"].origin = self.origin;
  var_5 = getarraykeys(var_0);

  for (var_6 = 0; var_6 < var_5.size; var_6++) {
  var_7 = var_5[var_6];
  var_0[var_7]._id_3E06 = 0;
  var_0[var_7]._id_DE05 = 0;
  }

  return var_0;
}

_id_CA82(var_0) {
  var_1 = getarraykeys(var_0);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
  var_3 = var_1[var_2];

  if (var_3 == "null")
  continue;
  }
}

_id_CA85(var_0, var_1) {
  var_0[var_1]._id_DE05 = 1;

  for (var_2 = 0; var_2 < var_0[var_1]._id_C6C0.size; var_2++) {
  var_3 = var_0[var_1]._id_C6C0[var_2];

  if (var_0[var_3]._id_3E06)
  continue;

  if (self _meth_8200(var_0[var_3].origin))
  return var_3;

  var_0[var_3]._id_3E06 = 1;
  }

  for (var_2 = 0; var_2 < var_0[var_1]._id_C6C0.size; var_2++) {
  var_3 = var_0[var_1]._id_C6C0[var_2];

  if (var_0[var_3]._id_DE05)
  continue;

  var_3 = _id_CA85(var_0, var_3);
  return var_3;
  }

  return "null";
}

_id_CA86(var_0) {
  if (isdefined(self._id_010C))
  return;

  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self._id_C98C endon("death");

  if (isdefined(self._id_C98C.script_noteworthy) && self._id_C98C.script_noteworthy == "cqb_patrol") {
  _id_0B91::_id_F35F();
  return;
  }

  if (!isdefined(var_0))
  var_0 = 200;

  _id_0B91::_id_F35F();

  for (;;) {
  wait 0.1;
  var_1 = self._id_C986;
  var_2 = distancesquared(self.origin, self._id_C986);

  if (var_2 > squared(var_0)) {
  if (self._id_1491._id_BCC8 == "run")
  continue;

  _id_0B06::_id_1EC8(self, "gravity", "patrol_dog_start");
  _id_0B91::_id_417A();
  self._id_EE56 = 1;
  continue;
  }

  if (self._id_1491._id_BCC8 != "walk") {
  self notify("stopped_while_patrolling");
  _id_0B06::_id_1EC8(self, "gravity", "patrol_dog_stop");
  _id_0B91::_id_F35F();
  }
  }
}

_id_CA87(var_0, var_1) {
  if (isdefined(self._id_010C))
  return;

  self endon("enemy");
  self endon("death");
  self endon("end_patrol");
  self._id_C98C endon("death");

  if (isdefined(self._id_C98C.script_noteworthy) && self._id_C98C.script_noteworthy == "cqb_patrol") {
  for (;;) {
  wait 0.05;
  var_2 = self._id_C986;
  var_3 = distancesquared(self.origin, self._id_C986);

  if (var_3 < squared(16)) {
  if (self._id_BCD6 > 0.4)
  self._id_BCD6 = self._id_BCD6 - 0.05;

  continue;
  }

  if (var_3 > squared(48)) {
  if (self._id_BCD6 < 1.8)
  self._id_BCD6 = self._id_BCD6 + 0.05;

  continue;
  }

  self._id_BCD6 = 1;
  }
  }

  if (!isdefined(var_0))
  var_0 = 16;

  if (!isdefined(var_1))
  var_1 = 48;

  var_4 = var_0 * var_0;
  var_5 = var_1 * var_1;

  for (;;) {
  wait 0.05;
  var_2 = self._id_C986;
  var_3 = distancesquared(self.origin, self._id_C986);

  if (self._id_1491._id_BCC8 != "walk") {
  self._id_BCD6 = 1;
  continue;
  }

  if (var_3 < var_4) {
  if (self._id_BCD6 > 0.4)
  self._id_BCD6 = self._id_BCD6 - 0.05;

  continue;
  }

  if (var_3 > var_5) {
  if (self._id_BCD6 < 0.75)
  self._id_BCD6 = self._id_BCD6 + 0.05;

  continue;
  }

  self._id_BCD6 = 0.5;
  }
}

_id_8BA5() {
  if (isdefined(self._id_027B) || isdefined(self._id_ED50))
  return 1;

  return 0;
}

_id_ED4E() {
  if (isdefined(self._id_027B))
  return self._id_027B > 0.5;

  if (isdefined(self._id_ED50))
  return self._id_ED50 > 0.5;

  return 0;
}