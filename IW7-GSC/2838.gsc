/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2838.gsc
***************************************/

_id_4761() {
  precachemodel("barrier_cover_foam_128");
  precachemodel("barrier_cover_foam_128_d1");
  precachemodel("barrier_cover_foam_128_d2");
  precachemodel("barrier_cover_foam_128_d3");
  precachemodel("barrier_cover_foam_128_d4");
  precachemodel("barrier_cover_foam_128_d5");
  level.player._id_4759 = spawnstruct();
  level.player._id_4759._id_0019 = [];
  level.player._id_4759._id_11168 = [];
  level.player._id_4759._id_389C = 0;
  level.player._id_4759._id_A8C6 = undefined;
  level._id_7649["coverwall_expand"] = loadfx("vfx/iw7/core/equipment/coverwall/vfx_coverwall_foam_expand.vfx");
  level._id_7649["coverwall_collapse"] = loadfx("vfx/iw7/core/equipment/coverwall/vfx_coverwall_foam_collapse.vfx");
  level._id_7649["coverwall_explosion"] = loadfx("vfx/iw7/_requests/mp/power/vfx_trip_mine_explode.vfx");
  level._id_7649["coverwall_dud"] = loadfx("vfx/code/foam/vfx_code_foamblock_death.vfx");
  precacheitem("coverwall");
  setdvarifuninitialized("portable_cover_lifetime", 35);
  setdvarifuninitialized("debug_coverwall", 0);
  scripts\engine\utility::_id_6E39("coverwall_force_delete");
}

_id_475F(var_0) {
  var_1 = spawnstruct();
  var_1._id_015F = var_0;
  level.player._id_4759._id_11168[level.player._id_4759._id_11168.size] = var_1;
  var_1 _id_85AE(var_0);

  if (!isdefined(var_1._id_015F)) {
  var_1 _id_DFDF(1);
  return;
  }

  var_1 notify("coverwall_initiated");
  var_2 = var_0.origin;
  var_1 _id_DFDF();

  if (isdefined(var_1._id_152B)) {
  level.player._id_4759._id_11168 = scripts\engine\utility::array_remove(level.player._id_4759._id_11168, var_1);
  return;
  }

  if (isdefined(level._id_93A9) && level.player._id_4759._id_0019.size > 3) {
  var_3 = level.player._id_4759._id_0019.size - 3;

  for (var_4 = 0; var_4 < var_3; var_4++)
  level.player._id_4759._id_0019[var_4] notify("expired");
  }

  var_5 = (0, level.player.angles[1] - 90, 0);
  _id_4763(var_2, var_5, undefined, var_1);
}

_id_85AE(var_0) {
  thread _id_85E8(var_0);
  _id_85AD(var_0);
}

_id_85E8(var_0) {
  self endon("coverwall_initiated");
  var_0 waittill("entitydeleted");
  self._id_6643 = 1;
}

_id_85AD(var_0) {
  var_0 waittill("missile_stuck", var_1);
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self._id_01DE = var_1;

  if (isdefined(self._id_6643))
  return;

  if (isdefined(var_1) && isdefined(var_1.classname) && var_1.classname == "script_coverwall") {
  self._id_152B = 1;
  playfx(level._id_7649["coverwall_dud"], var_0.origin);
  }
}

_id_DFDF(var_0) {
  if (!scripts\engine\utility::array_contains(level.player._id_4759._id_11168, self))
  return;

  if (!isdefined(var_0))
  var_0 = 0;

  if (isdefined(self._id_015F)) {
  self.origin = self._id_015F.origin;
  self.angles = self._id_015F.angles;
  level.player._id_4759._id_A8C6 = self._id_015F.origin;
  self._id_015F delete();
  }

  if (var_0)
  level.player._id_4759._id_11168 = scripts\engine\utility::array_remove(level.player._id_4759._id_11168, self);
}

_id_DFBD() {
  level notify("removing_all_coverwalls_instantly");
  level endon("removing_all_coverwalls_instantly");
  scripts\engine\utility::_id_6E3E("coverwall_force_delete");
  var_0 = level.player._id_4759._id_11168;

  foreach (var_2 in var_0) {
  var_2 _id_DFDF(1);

  if (isdefined(var_2._id_BE07))
  var_2._id_BE07 notify("death");
  }

  for (;;) {
  if (level.player._id_4759._id_11168.size > 0) {
  scripts\engine\utility::waitframe();
  continue;
  }

  break;
  }

  scripts\engine\utility::_id_6E2A("coverwall_force_delete");
  level.player notify("stop_coverwall_doubletap");
}

_id_4763(var_0, var_1, var_2, var_3) {
  var_3 notify("spawning_coverwall");
  var_2 = scripts\engine\utility::ter_op(isdefined(var_2), var_2, 200);
  var_4 = _func_2D6(var_0, var_1, var_2);

  if (!isdefined(var_4)) {
  if (isdefined(var_3.origin))
  playfx(level._id_7649["coverwall_dud"], var_3.origin);

  level.player._id_4759._id_11168 = scripts\engine\utility::array_remove(level.player._id_4759._id_11168, var_3);
  return;
  }

  _func_178("deployable_cover_expand", var_0);
  var_4._id_132AA = [];
  var_3._id_BE07 = var_4;
  _func_178("deployable_cover_expand", var_0);

  if (isdefined(level._id_93A9)) {
  var_5 = spawnfx(level._id_7649["coverwall_expand_vr"], var_0, anglestoforward(var_1), anglestoup(var_1));
  triggerfx(var_5);
  var_4._id_132AA[var_4._id_132AA.size] = var_5;
  }
  else
  playfx(level._id_7649["coverwall_expand"], var_0, anglestoforward(var_1), anglestoup(var_1));

  var_4.owner = self;
  var_3 thread _id_475E(35);
  var_4 thread _id_475A();

  if (1)
  var_4 thread _id_475D();

  if (isdefined(level.player._id_4759) && level.player._id_4759._id_389C)
  thread _id_B9C4();

  if (getdvarint("debug_coverwall"))
  var_4 thread _id_5B31();

  thread _id_10696(var_4);
  _id_0F18::_id_10E8A("broadcast", "attack", var_0, 1000);
  var_4 _id_4765();
  level.player._id_4759._id_0019[level.player._id_4759._id_0019.size] = var_4;
}

_id_4765() {
  self endon("coverwall_expand_finish");
  scripts\engine\utility::_id_6E4C("coverwall_force_delete");
}

_id_475A() {
  self endon("death");
  self endon("coverwall_expand_finish");

  for (;;) {
  self waittill("coverwall_expand_hit_actor", var_0);

  if (var_0.team == "axis") {
  if (var_0 _id_3870())
  var_0 _meth_81D0();
  }
  }
}

_id_3870() {
  var_0["c8"] = 1;
  var_0["c12"] = 1;

  if (isdefined(self._id_12BA4) && isdefined(var_0[self._id_12BA4]))
  return 0;

  return 1;
}

_id_5B31() {
  self endon("death");

  for (;;) {
  var_0 = self.origin;
  var_1 = var_0 + anglestoforward(self.angles) * 100;
  _id_0B1C::_id_5B5D(var_0, var_1, (0, 1, 0), 1, 0);
  wait 0.05;
  }
}

_id_10696(var_0) {
  var_0 endon("death");
  var_0 waittill("coverwall_expand_finish");
  var_1 = var_0.origin;
  var_2 = (1, 0, 0);
  var_3 = (0, 1, 0);
  var_4 = 30;
  var_5 = 26;
  var_6 = (0, 90, 0);
  var_7 = "right";
  var_8 = "a";
  var_0._id_473D = [];

  for (var_9 = 1; var_9 < 5; var_9++) {
  var_10 = scripts\engine\utility::ter_op(var_8 == "a", var_5, var_5 * -1);
  var_11 = scripts\engine\utility::ter_op(var_7 == "right", var_4, var_4 * -1);
  var_12 = scripts\engine\utility::ter_op(var_7 == "right", var_0.angles + (0, 90, 0), var_0.angles - (0, 90, 0));
  var_13 = var_3;
  var_14 = "coverwall_" + var_0 getentitynumber() + "_" + var_7 + "_" + var_8;
  var_10 = anglestoforward(var_0.angles) * var_10;
  var_15 = anglestoright(var_0.angles) * var_11;
  var_16 = var_1 + var_10 + var_15;

  if (var_0 _id_3913(var_16, var_12))
  var_0._id_473D[var_7 + "_" + var_8] = _func_2CB(var_16, var_12, "cover stand", 512, var_14);
  else
  var_13 = var_2;

  var_8 = scripts\engine\utility::ter_op(var_8 == "a", "b", "a");
  var_7 = scripts\engine\utility::ter_op(var_9 >= 2, "left", "right");

  if (var_9 == 2)
  wait 0.05;
  }

  var_0 thread _id_B9FB();
}

_id_3913(var_0, var_1) {
  var_2 = getclosestpointonnavmesh(var_0);
  var_3 = distance(var_0, var_2);

  if (var_3 > 17) {
  if (getdvarint("debug_coverwall")) {}

  return 0;
  }

  if (getdvarint("debug_coverwall")) {}

  var_4 = scripts\engine\trace::_id_3A09(var_0 + (0, 0, 20), var_0, 18, 72, var_1, self, scripts\engine\trace::_id_4956(1));

  if (isdefined(var_4["fraction"]) && var_4["fraction"] < 0.5) {
  if (getdvarint("debug_coverwall"))
  scripts\engine\trace::_id_5B66(var_4, (1, 0, 0), 0, 200);

  return 0;
  }

  var_5 = getgroundposition(var_0, 16) + (0, 0, 50);
  var_6 = var_5 + anglestoforward(var_1) * 100;
  var_4 = scripts\engine\trace::_id_DCED(var_5, var_6);

  if (isdefined(var_4["fraction"]) && var_4["fraction"] < 1) {
  if (getdvarint("debug_coverwall"))
  scripts\engine\trace::_id_5B66(var_4, (1, 0, 0), 1, 200);

  return 0;
  }

  if (getdvarint("debug_coverwall"))
  scripts\engine\trace::_id_5B66(var_4, (0, 1, 0), 1, 200);

  return 1;
}

_id_B9FB() {
  self endon("death");
  wait 1.5;

  if (isdefined(self._id_473D) && !self._id_473D.size)
  return;

  self endon("death");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = [];

  if (isdefined(self._id_473D["right_a"]))
  var_0 = self._id_473D["right_a"];
  else if (isdefined(self._id_473D["left_a"]))
  var_0 = self._id_473D["left_a"];

  if (isdefined(self._id_473D["right_b"]))
  var_1 = self._id_473D["right_b"];
  else if (isdefined(self._id_473D["left_b"]))
  var_1 = self._id_473D["left_b"];

  if (isdefined(var_0))
  var_2[var_2.size] = var_0;

  if (isdefined(var_1))
  var_2[var_2.size] = var_1;

  for (;;) {
  var_2 = scripts\engine\utility::_id_22BC(var_2);

  if (!var_2.size)
  return;

  foreach (var_4 in var_2) {
  if (!var_4 _id_C049()) {
  _id_E16A(var_4);
  _id_E0E1(var_4);
  break;
  }
  }

  wait 1.5;
  }
}

_id_E16A(var_0) {
  var_1 = undefined;
  var_2 = strtok(var_0._id_0336, "_");
  var_3 = var_2[2] + "_" + var_2[3];

  switch (var_3) {
  case "right_a":
  var_1 = self._id_473D["left_a"];
  break;
  case "left_a":
  var_1 = self._id_473D["right_a"];
  break;
  case "left_b":
  var_1 = self._id_473D["right_b"];
  break;
  case "right_b":
  var_1 = self._id_473D["left_b"];
  break;
  }

  if (isdefined(var_1)) {
  var_1._id_9CA1 = 1;
  _id_E0E1(var_1);
  }
}

_id_E0E1(var_0) {
  foreach (var_4, var_2 in self._id_473D) {
  if (var_0 == self._id_473D[var_4]) {
  if (getdvarint("debug_coverwall"))
  var_3 = var_0.origin;

  _func_2CC(var_0);
  self._id_473D = _id_0B91::_id_22B2(self._id_473D, var_4);
  return;
  }
  }
}

_id_C049() {
  var_0 = spawnstruct();
  var_0._id_10B89 = self.origin + (0, 0, 15);
  var_0._id_62A3 = var_0._id_10B89 + anglestoforward(self.angles) * 40;
  var_1 = spawnstruct();
  var_1._id_10B89 = self.origin + (0, 0, 40);
  var_1._id_62A3 = var_1._id_10B89 + anglestoforward(self.angles) * 40;
  var_2 = 0;
  var_3 = scripts\engine\trace::_id_48BC(0, 1, 1, 1, 1, 1, 0);
  var_4 = [var_0, var_1];

  foreach (var_6 in var_4) {
  var_7 = scripts\engine\trace::_id_DCED(var_6._id_10B89, var_6._id_62A3, self.owner, var_3);

  if (isdefined(var_7["fraction"])) {
  if (var_7["fraction"] == 1) {
  if (getdvarint("debug_coverwall")) {}

  var_2++;
  continue;
  }

  if (getdvarint("debug_coverwall"))
  scripts\engine\trace::_id_5B66(var_7, (0, 1, 0), 0, 20);
  }
  }

  return var_2 != 2;
}

_id_5B54(var_0, var_1, var_2) {
  self endon("death");

  for (;;) {
  _id_0B1C::_id_5B54(var_0, var_1, var_2, 32, 1);
  wait 0.05;
  }
}

_id_475E(var_0) {
  self._id_BE07 thread _id_0B91::_id_C12D("expired", var_0);
  var_1 = self._id_BE07 scripts\engine\utility::_id_13734("expired", "death");
  var_2 = var_1 == "death";
  var_3 = self._id_BE07.origin;
  var_4 = self._id_BE07.owner;

  if (scripts\engine\utility::_id_6E25("coverwall_force_delete"))
  scripts\engine\utility::waitframe();

  if (isdefined(self._id_BE07) && isdefined(self._id_BE07._id_473D)) {
  foreach (var_6 in self._id_BE07._id_473D) {
  if (isdefined(var_6))
  _func_2CC(var_6);
  }
  }

  if (isdefined(self._id_BE07._id_BE64))
  _func_27C(self._id_BE07._id_BE64);

  if (isdefined(self._id_BE07))
  self._id_BE07 _meth_8514(var_2);

  if (isdefined(self._id_BE07._id_132AA)) {
  foreach (var_9 in self._id_BE07._id_132AA)
  var_9 delete();
  }

  if (!var_2) {
  var_11 = self._id_BE07.angles;
  playfx(level._id_7649["coverwall_collapse"], var_3, anglestoforward(var_11), anglestoup(var_11));
  _func_178("deployable_cover_contract", var_3);
  }

  var_4._id_4759._id_0019 = scripts\engine\utility::array_remove(var_4._id_4759._id_0019, self._id_BE07);
  scripts\engine\utility::_id_6E59("coverwall_force_delete", 1.5);

  if (!var_4._id_4759._id_0019.size) {
  if (isdefined(var_4._id_4759._id_5AE6)) {
  var_4 notify("stop_coverwall_doubletap");
  var_4._id_4759._id_5AE6 = undefined;
  }
  }

  level.player._id_4759._id_11168 = scripts\engine\utility::array_remove(level.player._id_4759._id_11168, self);
}

_id_475D() {
  self endon("death");
  self endon("entitydeleted");
  self waittill("coverwall_expand_finish");
  self._id_BE64 = _func_316(self);
}

_id_B9C4() {
  if (isdefined(self._id_4759._id_5AE6))
  return;

  self._id_4759._id_5AE6 = 1;
  self endon("stop_coverwall_doubletap");
  var_0 = 0;
  var_1 = 0.3;

  for (;;) {
  if (level.player usebuttonpressed()) {
  var_0 = 0;

  while (level.player usebuttonpressed()) {
  var_0 = var_0 + 0.05;
  wait 0.05;
  }

  if (var_0 >= var_1)
  continue;

  var_0 = 0;

  while (!level.player usebuttonpressed() && var_0 < var_1) {
  var_0 = var_0 + 0.05;
  wait 0.05;
  }

  if (var_0 >= var_1)
  continue;

  thread _id_0B91::_id_CE2F("deployable_cover_det_trig");
  wait 0.3;
  _id_2BCE();
  self._id_4759._id_5AE6 = undefined;
  self notify("stop_coverwall_doubletap");
  return;
  }

  wait 0.05;
  }
}

_id_2BCE() {
  foreach (var_1 in self._id_4759._id_0019) {
  _id_475C(var_1);
  scripts\engine\utility::_id_6E59("coverwall_force_delete", 0.2);
  }
}

_id_475C(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = var_2 + (0, 0, 32);

  if (scripts\engine\utility::_id_6E34("in_vr_mode") && scripts\engine\utility::_id_6E25("in_vr_mode"))
  playfx(level._id_7649["coverwall_explosion_vr"], var_2);
  else
  playfx(level._id_7649["coverwall_explosion"], var_2);

  _func_178("deployable_cover_explode", var_2);
  earthquake(0.4, 0.6, var_0.owner.origin, 450);
  level.player playrumbleonentity("damage_heavy");
  var_0 notify("death");
  scripts\engine\utility::_id_6E59("coverwall_force_delete", 0.1);

  if (!isdefined(var_1))
  radiusdamage(var_3, 150, 250, 120, var_0.owner, "MOD_EXPLOSIVE", "coverwall");
}

_id_596D() {
  if (isdefined(self._id_596D))
  return;

  self._id_596D = 1;
  self endon("death");
  self endon("stop_for_coverwalls");

  for (;;) {
  var_0 = getentarray("script_coverwall", "classname");

  foreach (var_2 in var_0) {
  if (isdefined(var_2._id_BE64))
  _func_27C(var_2._id_BE64);

  var_3 = distancesquared(self.origin, var_2.origin);

  if (var_3 < squared(200))
  var_2 notify("expired");
  }

  wait 0.75;
  }
}

_id_551C() {
  self notify("stop_for_coverwalls");
  self._id_596D = undefined;
}