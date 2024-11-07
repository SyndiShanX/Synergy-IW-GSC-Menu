/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2880.gsc
***************************************/

_id_DEB8(var_0, var_1) {
  level._id_1DBE[var_0] = var_1;
}

_id_7A2D(var_0) {
  if (!isdefined(level._id_1DBE) || !isdefined(level._id_1DBE[var_0]))
  return undefined;

  return level._id_1DBE[var_0];
}

#using_animtree("generic_human");

_id_CC7F(var_0, var_1) {
  self._id_DC6F = 0;

  if (isai(var_0) && !isdefined(var_0._id_9B89))
  var_0 _meth_8016("noclip");

  wait 0.1;
  var_0 _meth_806F(%root, 0.0);

  if (isdefined(var_0._id_9B89)) {
  if (isdefined(var_1) && var_1) {
  thread _id_DC82(var_0);
  thread _id_DC86(var_0);
  } else {
  thread _id_DC81(var_0);
  thread _id_DC86(var_0);
  }
  }
  else if (isdefined(var_1) && var_1) {
  thread _id_DC82(var_0);
  thread _id_DC85();
  } else {
  thread _id_DC81(var_0);
  thread _id_DC85();
  }

  self waittill("ambient_idle_scene_end");
}

_id_CC80(var_0, var_1, var_2) {
  if (!isdefined(var_1))
  var_1 = 1;

  if (!isdefined(var_2))
  var_2 = 1;

  if (isdefined(self._id_1DBC))
  self._id_1DBC = scripts\engine\utility::_id_107CE();

  var_3 = [];

  foreach (var_5 in var_0) {
  var_5._id_DC6F = 0;

  if (!var_1 && isai(var_5)) {
  var_5 _meth_8016("noclip");
  var_5 _meth_80F1(self.origin, self.angles, 100000.0);
  continue;
  }

  var_5.origin = self.origin;
  var_5.angles = self.angles;
  }

  if (var_2) {
  thread _id_DC83(var_0);
  thread _id_DC87(var_0);
  } else {
  thread _id_DC84(var_0);
  thread _id_DC87(var_0);
  }

  self waittill("ambient_idle_scene_end");
}

_id_4179() {
  self _meth_806F(%root, 0.1);
}

_id_DC81(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = 0;
  var_2 = level._id_EC85[var_0._id_1FBB]["idle_anims"].size;
  var_3 = level._id_EC85[var_0._id_1FBB]["idle_base"];
  var_4 = [];
  var_5 = 0;
  self notify("ambient_idle_scene_start");
  thread _id_0B06::_id_10CBF(var_0, "single anim");
  thread _id_0B06::_id_1FCA(var_0, "single anim");

  for (;;) {
  if (var_4.size >= var_2) {
  var_5 = randomint(var_2);
  var_4 = [];
  var_4 = scripts\engine\utility::_id_2279(var_4, var_5);
  } else {
  var_5 = randomint(var_2);

  for (;;) {
  if (scripts\engine\utility::array_contains(var_4, var_5)) {
  var_5 = randomint(var_2);
  continue;
  }

  var_4 = scripts\engine\utility::_id_2279(var_4, var_5);
  break;
  }
  }

  if (!isdefined(var_0))
  return;

  var_6 = level._id_EC85[var_0._id_1FBB]["idle_anims"][var_5];
  var_7 = _func_0CE(self.origin, self.angles, var_3);
  var_8 = _func_0CD(self.origin, self.angles, var_3);

  if (isdefined(var_0._id_9B89) || !isai(var_0)) {
  var_0.origin = var_7;
  var_0.angles = var_8;
  }
  else
  var_0 _meth_80F1(var_7, var_8, 100000.0);

  var_9 = undefined;

  if (isdefined(var_0._id_1ED4))
  var_9 = [[var_0._id_1ED4]]();

  var_10 = getanimlength(var_3);
  var_11 = randomintrange(1, 4);
  var_12 = var_10 * float(var_11);

  if (!isdefined(var_0))
  return;

  var_0 _meth_8018("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
  wait(var_12);

  if (!isdefined(var_0))
  return;

  _id_13596(var_3, var_6[0], var_0);

  if (!isdefined(var_0))
  return;

  var_0 _meth_806F(var_3, 0.1);
  var_0 _meth_8018("single anim", self.origin, self.angles, var_6[0], undefined, undefined, 0.2);
  var_13 = getanimlength(var_6[0]);
  wait(var_13);

  if (!isdefined(var_0))
  return;

  var_0 _meth_806F(var_6[0], 0.1);
  var_0 _meth_8018("single anim", self.origin, self.angles, var_6[1], undefined, undefined, 0.2);
  var_10 = getanimlength(var_6[1]);
  var_11 = randomintrange(1, 4);
  var_12 = var_10 * float(var_11);
  wait(var_12);

  if (!isdefined(var_0))
  return;

  _id_13596(var_6[1], var_6[2], var_0);

  if (!isdefined(var_0))
  return;

  var_0 _meth_806F(var_6[1], 0.1);
  var_0 _meth_8018("single anim", self.origin, self.angles, var_6[2], undefined, undefined, 0.2);
  var_14 = getanimlength(var_6[2]);
  wait(var_14);

  if (!isdefined(var_0))
  return;

  var_0 _meth_806F(var_6[2], 0.1);
  scripts\engine\utility::waitframe();
  }
}

_id_DC84(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = 0;
  var_2 = level._id_EC85[var_0[0]._id_1FBB]["idle_anims"].size;
  var_3 = level._id_EC85[var_0[0]._id_1FBB]["idle_base"];
  var_4 = [];
  var_5 = 0;
  self notify("ambient_idle_scene_start");

  foreach (var_7 in var_0) {
  if (!isdefined(var_7._id_1FEC))
  var_7 _id_0B06::_id_F64A();

  thread _id_0B06::_id_10CBF(var_7, "single anim");
  thread _id_0B06::_id_1FCA(var_7, "single anim");
  }

  for (;;) {
  if (var_4.size >= var_2) {
  var_5 = randomint(var_2);
  var_4 = [];
  var_4 = scripts\engine\utility::_id_2279(var_4, var_5);
  } else {
  var_5 = randomint(var_2);

  for (;;) {
  if (scripts\engine\utility::array_contains(var_4, var_5)) {
  var_5 = randomint(var_2);
  continue;
  }

  var_4 = scripts\engine\utility::_id_2279(var_4, var_5);
  break;
  }
  }

  var_9 = 0;
  var_10 = undefined;

  foreach (var_7 in var_0) {
  var_10 = level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5];
  var_12 = _func_0CE(self.origin, self.angles, var_3);
  var_13 = _func_0CD(self.origin, self.angles, var_3);
  var_3 = level._id_EC85[var_7._id_1FBB]["idle_base"];

  if (isdefined(var_7._id_9B89) || !isai(var_7)) {
  var_7.origin = var_12;
  var_7.angles = var_13;
  }
  else
  var_7 _meth_80F1(var_12, var_13, 100000.0);

  var_14 = undefined;

  if (isdefined(var_7._id_1ED4))
  var_14 = [[var_7._id_1ED4]]();

  var_15 = getanimlength(var_3);
  var_16 = randomintrange(1, 4);
  var_9 = var_15 * float(var_16);
  var_7 _meth_8018("single anim", self.origin, self.angles, var_3, undefined, undefined, 0.2);
  }

  wait(var_9);
  var_18 = [];

  foreach (var_7 in var_0)
  var_18 = scripts\engine\utility::_id_2279(var_18, level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5][0]);

  _id_13597(var_3, var_18, var_0);

  foreach (var_7 in var_0) {
  var_3 = level._id_EC85[var_7._id_1FBB]["idle_base"];
  var_10 = level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5];
  var_7 _meth_806F(var_3, 0.1);
  var_7 _meth_8018("single anim", self.origin, self.angles, var_10[0], undefined, undefined, 0.2);
  }

  var_23 = getanimlength(var_10[0]);
  wait(var_23);

  foreach (var_7 in var_0) {
  var_10 = level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5];
  var_7 _meth_806F(var_10[0], 0.1);
  var_7 _meth_8018("single anim", self.origin, self.angles, var_10[1], undefined, undefined, 0.2);
  }

  var_15 = getanimlength(var_10[1]);
  var_16 = randomintrange(1, 4);
  var_9 = var_15 * float(var_16);
  wait(var_9);
  var_18 = [];

  foreach (var_7 in var_0)
  var_18 = scripts\engine\utility::_id_2279(var_18, level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5][2]);

  _id_13597(var_10[1], var_18, var_0);

  foreach (var_7 in var_0) {
  var_3 = level._id_EC85[var_7._id_1FBB]["idle_base"];
  var_10 = level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5];
  var_7 _meth_806F(var_10[1], 0.1);
  var_7 _meth_8018("single anim", self.origin, self.angles, var_10[2], undefined, undefined, 0.2);
  }

  var_30 = getanimlength(var_10[2]);
  wait(var_30);

  foreach (var_7 in var_0) {
  var_10 = level._id_EC85[var_7._id_1FBB]["idle_anims"][var_5];
  var_7 _meth_806F(var_10[2], 0.1);
  }

  scripts\engine\utility::waitframe();
  }
}

_id_DC85() {
  _id_0A1E::_id_2386();
  self notify("ambient_idle_scene_end");
}

_id_DC88(var_0) {
  foreach (var_2 in var_0) {
  if (_func_2A6(var_2)) {
  var_2 _id_0A1E::_id_2386();
  var_2 notify("ambient_idle_scene_end");
  }
  }
}

_id_DC86(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");

  if (_func_2A6(var_0))
  var_0 _id_4179();

  self notify("ambient_idle_scene_end");
}

_id_DC87(var_0) {
  self endon("death");
  self waittill("ambient_scene_end");

  foreach (var_2 in var_0) {
  if (_func_2A6(var_2))
  var_2 _meth_83A1();
  }

  self notify("ambient_idle_scene_end");
}

_id_DC82(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = level._id_EC85[var_0._id_1FBB]["idle_anims"].size;
  var_2 = level._id_EC85[var_0._id_1FBB]["idle_base"];
  var_3 = [];
  var_4 = 0;
  self notify("ambient_idle_scene_start");
  thread _id_0B06::_id_10CBF(var_0, "single anim");
  thread _id_0B06::_id_1FCA(var_0, "single anim");

  for (;;) {
  if (var_3.size >= var_1) {
  var_4 = randomint(var_1);
  var_3 = [];
  var_3 = scripts\engine\utility::_id_2279(var_3, var_4);
  } else {
  var_4 = randomint(var_1);

  for (;;) {
  if (scripts\engine\utility::array_contains(var_3, var_4)) {
  var_4 = randomint(var_1);
  continue;
  }

  var_3 = scripts\engine\utility::_id_2279(var_3, var_4);
  break;
  }
  }

  var_5 = level._id_EC85[var_0._id_1FBB]["idle_anims"][var_4];
  var_6 = _func_0CE(self.origin, self.angles, var_2);
  var_7 = _func_0CD(self.origin, self.angles, var_2);

  if (isdefined(var_0._id_9B89) || !isai(var_0)) {
  var_0.origin = var_6;
  var_0.angles = var_7;
  }
  else
  var_0 _meth_80F1(var_6, var_7, 100000.0);

  var_8 = undefined;

  if (isdefined(var_0._id_1ED4))
  var_8 = [[var_0._id_1ED4]]();

  var_9 = getanimlength(var_2);
  var_10 = randomintrange(1, 4);
  var_11 = var_9 * float(var_10);
  var_0 _meth_8018("single anim", self.origin, self.angles, var_2, undefined, undefined, 0.2);
  wait(var_11);
  var_0 _meth_806F(var_2, 0.1);
  var_0 _meth_8018("single anim", self.origin, self.angles, var_5, undefined, undefined, 0.2);
  var_12 = getanimlength(var_5);
  wait(var_12);
  var_0 _meth_806F(var_5, 0.1);
  scripts\engine\utility::waitframe();
  }
}

_id_DC83(var_0) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_1 = level._id_EC85[var_0[0]._id_1FBB]["idle_anims"].size;
  var_2 = [];
  var_3 = 0;
  var_4 = self;
  self notify("ambient_idle_scene_start");

  foreach (var_6 in var_0) {
  var_7 = level._id_EC85[var_6._id_1FBB]["idle_base"];
  var_8 = _func_0CE(self.origin, self.angles, var_7);
  var_9 = _func_0CD(self.origin, self.angles, var_7);
  var_6.origin = var_8;
  var_6.angles = var_9;
  thread _id_0B06::_id_10CBF(var_6, "single anim");
  thread _id_0B06::_id_1FCA(var_6, "single anim");
  var_10 = undefined;

  if (isdefined(var_6._id_1ED4))
  var_10 = [[var_6._id_1ED4]]();

  var_6 _meth_8018("single anim", self.origin, self.angles, var_7, undefined, var_10, 0.0);
  }

  for (;;) {
  if (var_2.size >= var_1) {
  var_3 = randomint(var_1);
  var_2 = [];
  var_2 = scripts\engine\utility::_id_2279(var_2, var_3);
  } else {
  var_3 = randomint(var_1);

  for (;;) {
  if (scripts\engine\utility::array_contains(var_2, var_3)) {
  var_3 = randomint(var_1);
  continue;
  }

  var_2 = scripts\engine\utility::_id_2279(var_2, var_3);
  break;
  }
  }

  var_12 = [];
  var_13 = 0;
  var_14 = randomintrange(1, 4);

  foreach (var_6 in var_0) {
  var_7 = level._id_EC85[var_6._id_1FBB]["idle_base"];
  var_8 = _func_0CE(self.origin, self.angles, var_7);
  var_9 = _func_0CD(self.origin, self.angles, var_7);
  var_6.origin = var_8;
  var_6.angles = var_9;
  var_10 = undefined;

  if (isdefined(var_6._id_1ED4))
  var_10 = [[var_6._id_1ED4]]();

  var_16 = getanimlength(var_7);
  var_13 = var_16;
  var_6 _meth_8018("single anim", self.origin, self.angles, var_7, undefined, var_10, 0.2);
  }

  wait(var_13);
  var_18 = 0;

  foreach (var_21, var_6 in var_0) {
  var_7 = level._id_EC85[var_6._id_1FBB]["idle_base"];
  var_20 = level._id_EC85[var_6._id_1FBB]["idle_anims"][var_3];
  var_8 = _func_0CE(self.origin, self.angles, var_20);
  var_9 = _func_0CD(self.origin, self.angles, var_20);
  var_6.origin = var_8;
  var_6.angles = var_9;
  var_10 = undefined;

  if (isdefined(var_6._id_1ED4))
  var_10 = [[var_6._id_1ED4]]();

  var_6 _meth_8018("single anim", self.origin, self.angles, var_20, undefined, var_10, 0.2);
  var_18 = getanimlength(var_20);
  }

  wait(var_18);
  }
}

_id_9B63(var_0) {
  return isdefined(level._id_1DBE) && isdefined(level._id_1DBE[var_0]);
}

_id_9B62(var_0) {
  if (isdefined(var_0.script_noteworthy) && _id_9B63(var_0.script_noteworthy))
  return 1;

  return 0;
}

_id_13596(var_0, var_1, var_2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_2 endon("death");

  if (!isdefined(var_2))
  return;

  var_3 = length2d(level.player.origin - var_2.origin);
  var_4 = length2d(level.player.origin - var_2 scripts\anim\utility::_id_7DC6(var_1));
  var_5 = float(getdvar("g_speed")) * 0.25;

  for (;;) {
  if (var_3 / var_5 > getanimlength(var_1) && var_4 / var_5 > getanimlength(var_1))
  break;

  if (!isdefined(var_2))
  return;

  var_3 = length2d(level.player.origin - var_2.origin);
  var_4 = length2d(level.player.origin - var_2 scripts\anim\utility::_id_7DC6(var_1));
  var_5 = float(getdvar("g_speed")) * 0.25;
  var_6 = getanimlength(var_0);
  wait(var_6);
  }
}

_id_13597(var_0, var_1, var_2) {
  self endon("death");
  self endon("ambient_idle_scene_end");
  var_3 = undefined;
  var_4 = undefined;
  var_5 = float(getdvar("g_speed")) * 0.25;

  for (;;) {
  var_6 = 0;

  for (var_7 = 0; var_7 < var_2.size; var_7++) {
  var_8 = var_2[var_7];
  var_3 = length2d(level.player.origin - var_8.origin);
  var_4 = length2d(level.player.origin - var_8 scripts\anim\utility::_id_7DC6(var_1[var_7]));
  var_5 = float(getdvar("g_speed")) * 0.25;

  if (var_3 / var_5 > getanimlength(var_1[var_7]) && var_4 / var_5 > getanimlength(var_1[var_7]))
  var_6++;
  }

  if (var_6 >= var_2.size)
  break;

  var_9 = getanimlength(var_0);
  wait(var_9);
  }
}

_id_CDD6(var_0, var_1, var_2) {
  self endon("stop_idles");
  self endon("death");
  var_0 endon("death");
  var_3 = [];
  var_4 = var_2;
  var_5 = undefined;
  var_0._id_DC89 = 1;

  for (;;) {
  _id_0B06::_id_1F35(var_0, var_1);

  if (var_4.size < 1)
  var_4 = var_3;

  var_5 = randomint(var_4.size);
  _id_0B06::_id_1F35(var_0, var_4[var_5]);
  var_3 = scripts\engine\utility::_id_2279(var_3, var_4[var_5]);
  var_4 = scripts\engine\utility::array_remove(var_4, var_4[var_5]);
  scripts\engine\utility::waitframe();
  }
}

_id_11036() {
  self notify("stop_idles");
  self._id_DC89 = undefined;
}