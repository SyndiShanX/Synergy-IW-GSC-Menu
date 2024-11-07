/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2961.gsc
***************************************/

_id_7CCC(var_0) {
  var_1 = [];
  var_2 = _func_0BC(var_0);

  for (var_3 = 0; var_3 < var_2; var_3++)
  var_1[var_1.size] = _func_0BF(var_0, var_3);

  return var_1;
}

_id_77FF(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if (var_1.size < 1)
  return var_4;

  if (!isdefined(var_3))
  var_3 = 0;

  var_2 = squared(var_2);

  foreach (var_6 in var_1) {
  if (!isalive(var_6) || !isdefined(var_6) || !var_3 && isdefined(var_6._id_1491._id_58DA))
  continue;

  if (distancesquared(var_6.origin, var_0) <= var_2)
  var_4[var_4.size] = var_6;
  }

  return var_4;
}

_id_BD6B(var_0, var_1) {
  var_0 = var_0 * 17.6;
  var_2 = var_1 / var_0;
  return var_2;
}

_id_F40A(var_0, var_1, var_2) {
  var_3 = undefined;
  var_0 = tolower(var_0);
  var_4["friendly"] = 3;
  var_4["enemy"] = 1;
  var_4["objective"] = 5;
  var_4["neutral"] = 0;
  var_3 = var_4[var_0];
  var_2 = scripts\engine\utility::ter_op(isdefined(var_2), var_2, 1);
  _id_9196(var_3, var_1, var_2);
}

_id_45F8(var_0, var_1) {
  var_2 = "";

  if (var_0 < 0)
  var_2 = var_2 + "-";

  var_0 = _id_E753(var_0, 1, 0);
  var_3 = var_0 * 100;
  var_3 = int(var_3);
  var_3 = abs(var_3);
  var_4 = var_3 / 6000;
  var_4 = int(var_4);
  var_2 = var_2 + var_4;
  var_5 = var_3 / 100;
  var_5 = int(var_5);
  var_5 = var_5 - var_4 * 60;

  if (var_5 < 10)
  var_2 = var_2 + (":0" + var_5);
  else
  var_2 = var_2 + (":" + var_5);

  if (isdefined(var_1) && var_1) {
  var_6 = var_3;
  var_6 = var_6 - var_4 * 6000;
  var_6 = var_6 - var_5 * 100;
  var_6 = int(var_6 / 10);
  var_2 = var_2 + ("." + var_6);
  }

  return var_2;
}

_id_E753(var_0, var_1, var_2) {
  var_1 = int(var_1);

  if (var_1 < 0 || var_1 > 4)
  return var_0;

  var_3 = 1;

  for (var_4 = 1; var_4 <= var_1; var_4++)
  var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if (!isdefined(var_2) || var_2)
  var_5 = floor(var_5);
  else
  var_5 = ceil(var_5);

  var_0 = var_5 / var_3;
  return var_0;
}

_id_E754(var_0, var_1, var_2) {
  var_3 = var_0 / 1000;
  var_3 = _id_E753(var_3, var_1, var_2);
  var_0 = var_3 * 1000;
  return int(var_0);
}

_id_111DA(var_0, var_1, var_2) {
  var_2 = int(var_2 * 20);
  var_3 = [];

  for (var_4 = 0; var_4 < 3; var_4++)
  var_3[var_4] = (var_0[var_4] - var_1[var_4]) / var_2;

  var_5 = [];

  for (var_4 = 0; var_4 < var_2; var_4++) {
  wait 0.05;

  for (var_6 = 0; var_6 < 3; var_6++)
  var_5[var_6] = var_0[var_6] - var_3[var_6] * var_4;

  _func_1CA(var_5[0], var_5[1], var_5[2]);
  }

  _func_1CA(var_1[0], var_1[1], var_1[2]);
}

_id_65E3(var_0) {
  while (isdefined(self) && !self._id_65DB[var_0])
  self waittill(var_0);
}

_id_65E7(var_0) {
  while (isdefined(self) && !self._id_65DB[var_0])
  self waittill(var_0);
}

_id_65E4(var_0, var_1) {
  while (isdefined(self)) {
  if (_id_65DB(var_0))
  return;

  if (_id_65DB(var_1))
  return;

  scripts\engine\utility::_id_13762(var_0, var_1);
  }
}

_id_65E6(var_0, var_1) {
  var_2 = gettime();

  while (isdefined(self)) {
  if (self._id_65DB[var_0])
  break;

  if (gettime() >= var_2 + var_1 * 1000)
  break;

  _id_0B92::_id_65FA(var_0, var_1);
  }
}

_id_65E8(var_0) {
  while (isdefined(self) && self._id_65DB[var_0])
  self waittill(var_0);
}

_id_65DC(var_0) {}

_id_65E9(var_0, var_1) {
  while (isdefined(self)) {
  if (!_id_65DB(var_0))
  return;

  if (!_id_65DB(var_1))
  return;

  scripts\engine\utility::_id_13762(var_0, var_1);
  }
}

_id_65E0(var_0) {
  if (!isdefined(self._id_65DB)) {
  self._id_65DB = [];
  self._id_65EA = [];
  }

  self._id_65DB[var_0] = 0;
}

_id_65DF(var_0) {
  if (isdefined(self._id_65DB) && isdefined(self._id_65DB[var_0]))
  return 1;

  return 0;
}

_id_65E2(var_0, var_1) {
  self endon("death");
  wait(var_1);
  _id_65E1(var_0);
}

_id_65E1(var_0) {
  self._id_65DB[var_0] = 1;
  self notify(var_0);
}

_id_65DD(var_0, var_1) {
  if (self._id_65DB[var_0]) {
  self._id_65DB[var_0] = 0;
  self notify(var_0);
  }

  if (isdefined(var_1) && var_1)
  self._id_65DB[var_0] = undefined;
}

_id_65DE(var_0, var_1) {
  wait(var_1);

  if (isdefined(self))
  _id_65DD(var_0);
}

_id_65DB(var_0) {
  return self._id_65DB[var_0];
}

_id_78C8(var_0, var_1, var_2, var_3) {
  if (!var_0.size)
  return;

  if (!isdefined(var_1))
  var_1 = level.player;

  if (!isdefined(var_3))
  var_3 = -1;

  var_4 = var_1.origin;

  if (isdefined(var_2) && var_2)
  var_4 = var_1 geteye();

  var_5 = undefined;
  var_6 = var_1 getplayerangles();
  var_7 = anglestoforward(var_6);
  var_8 = -1;

  foreach (var_10 in var_0) {
  var_11 = vectortoangles(var_10.origin - var_4);
  var_12 = anglestoforward(var_11);
  var_13 = vectordot(var_7, var_12);

  if (var_13 < var_8)
  continue;

  if (var_13 < var_3)
  continue;

  var_8 = var_13;
  var_5 = var_10;
  }

  return var_5;
}

_id_78B9(var_0, var_1, var_2) {
  if (!var_0.size)
  return;

  if (!isdefined(var_1))
  var_1 = level.player;

  var_3 = var_1.origin;

  if (isdefined(var_2) && var_2)
  var_3 = var_1 geteye();

  var_4 = undefined;
  var_5 = var_1 getplayerangles();
  var_6 = anglestoforward(var_5);
  var_7 = -1;

  for (var_8 = 0; var_8 < var_0.size; var_8++) {
  var_9 = vectortoangles(var_0[var_8].origin - var_3);
  var_10 = anglestoforward(var_9);
  var_11 = vectordot(var_6, var_10);

  if (var_11 < var_7)
  continue;

  var_7 = var_11;
  var_4 = var_8;
  }

  return var_4;
}

_id_6E49(var_0, var_1, var_2) {
  scripts\engine\utility::_id_6E39(var_0);

  if (!isdefined(var_2))
  var_2 = 0;

  var_1 thread _id_0B92::_id_1287(var_0, var_2);
  return var_1;
}

_id_6E4A(var_0, var_1, var_2) {
  scripts\engine\utility::_id_6E39(var_0);

  if (!isdefined(var_2))
  var_2 = 0;

  for (var_3 = 0; var_3 < var_1.size; var_3++)
  var_1[var_3] thread _id_0B92::_id_1287(var_0, 0);

  return var_1;
}

_id_6E2B(var_0, var_1) {
  wait(var_1);
  scripts\engine\utility::_id_6E2A(var_0);
}

_id_ABD2() {
  if (level._id_B8D0)
  return;

  if (scripts\engine\utility::_id_6E25("game_saving"))
  return;

  for (var_0 = 0; var_0 < level.players.size; var_0++) {
  var_1 = level.players[var_0];

  if (!isalive(var_1))
  return;
  }

  scripts\engine\utility::_id_6E3E("game_saving");
  var_2 = "levelshots / autosave / autosave_" + level.script + "end";
  _func_1A0("levelend", &"AUTOSAVE_AUTOSAVE", var_2, 1);
  scripts\engine\utility::_id_6E2A("game_saving");
}

_id_16D5(var_0, var_1, var_2) {
  level._id_2668._id_6A42[var_0] = [];
  level._id_2668._id_6A42[var_0]["func"] = var_1;
  level._id_2668._id_6A42[var_0]["msg"] = var_2;
}

_id_E00D(var_0) {
  level._id_2668._id_6A42[var_0] = undefined;
}

_id_2677() {
  thread _id_266B("autosave_stealth", 8, 1);
}

_id_2678() {
  thread _id_266B("autosave_stealth", 8, 1, 1);
}

_id_2679() {
  _id_0B92::_id_2680();
  thread _id_0B92::_id_267F();
}

_id_2669(var_0) {
  thread _id_266B(var_0);
}

_id_266A(var_0) {
  thread _id_266B(var_0, undefined, undefined, 1);
}

_id_266B(var_0, var_1, var_2, var_3) {
  if (!isdefined(level._id_4B18))
  level._id_4B18 = 1;

  var_4 = "levelshots/autosave/autosave_" + level.script + level._id_4B18;
  var_5 = level _id_0B0E::_id_12891(level._id_4B18, "autosave", var_4, var_1, var_2, var_3);

  if (isdefined(var_5) && var_5)
  level._id_4B18++;
}

_id_2672(var_0, var_1) {
  thread _id_266B(var_0, var_1);
}

_id_2673(var_0, var_1) {
  thread _id_266B(var_0, var_1, undefined, 1);
}

_id_4EF6(var_0, var_1, var_2, var_3) {
  if (!isdefined(var_2))
  var_2 = 5;

  if (isdefined(var_3)) {
  var_3 endon("death");
  var_1 = var_3.origin;
  }

  for (var_4 = 0; var_4 < var_2 * 20; var_4++) {
  if (!isdefined(var_3)) {} else {}

  wait 0.05;
  }
}

_id_4EF7(var_0, var_1) {
  self notify("debug_message_ai");
  self endon("debug_message_ai");
  self endon("death");

  if (!isdefined(var_1))
  var_1 = 5;

  for (var_2 = 0; var_2 < var_1 * 20; var_2++)
  wait 0.05;
}

_id_4EF8(var_0, var_1, var_2, var_3) {
  if (isdefined(var_3)) {
  level notify(var_0 + var_3);
  level endon(var_0 + var_3);
  } else {
  level notify(var_0);
  level endon(var_0);
  }

  if (!isdefined(var_2))
  var_2 = 5;

  for (var_4 = 0; var_4 < var_2 * 20; var_4++)
  wait 0.05;
}

_id_4295(var_0, var_1) {
  return var_0 >= var_1;
}

_id_7E33(var_0, var_1, var_2) {
  return _id_0B92::_id_4461(var_0, var_1, var_2, ::_id_4295);
}

_id_79B3(var_0, var_1) {
  if (var_1.size < 1)
  return;

  var_2 = distance(var_1[0] _meth_814F(), var_0);
  var_3 = var_1[0];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
  var_5 = distance(var_1[var_4] _meth_814F(), var_0);

  if (var_5 < var_2)
  continue;

  var_2 = var_5;
  var_3 = var_1[var_4];
  }

  return var_3;
}

_id_7D80(var_0, var_1, var_2) {
  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
  if (distance(var_1[var_4].origin, var_0) <= var_2)
  var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

_id_7B5C(var_0, var_1, var_2) {
  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
  if (distance(var_1[var_4].origin, var_0) > var_2)
  var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

_id_78BB(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = 9999999;

  if (var_1.size < 1)
  return;

  var_3 = undefined;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
  if (!isalive(var_1[var_4]))
  continue;

  var_5 = distance(var_1[var_4].origin, var_0);

  if (var_5 >= var_2)
  continue;

  var_2 = var_5;
  var_3 = var_1[var_4];
  }

  return var_3;
}

_id_7A05(var_0, var_1, var_2) {
  if (!var_2.size)
  return;

  var_3 = undefined;
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = anglestoforward(var_4);
  var_6 = -1;

  foreach (var_8 in var_2) {
  var_4 = vectortoangles(var_8.origin - var_0);
  var_9 = anglestoforward(var_4);
  var_10 = vectordot(var_5, var_9);

  if (var_10 < var_6)
  continue;

  var_6 = var_10;
  var_3 = var_8;
  }

  return var_3;
}

_id_78B8(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = 9999999;

  if (var_1.size < 1)
  return;

  var_3 = undefined;

  foreach (var_7, var_5 in var_1) {
  var_6 = distance(var_5.origin, var_0);

  if (var_6 >= var_2)
  continue;

  var_2 = var_6;
  var_3 = var_7;
  }

  return var_3;
}

_id_78B5(var_0, var_1, var_2) {
  if (!isdefined(var_1))
  return undefined;

  var_3 = 0;

  if (isdefined(var_2) && var_2.size) {
  var_4 = [];

  for (var_5 = 0; var_5 < var_1.size; var_5++)
  var_4[var_5] = 0;

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
  for (var_6 = 0; var_6 < var_2.size; var_6++) {
  if (var_1[var_5] == var_2[var_6])
  var_4[var_5] = 1;
  }
  }

  var_7 = 0;

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
  if (!var_4[var_5] && isdefined(var_1[var_5])) {
  var_7 = 1;
  var_3 = distance(var_0, var_1[var_5].origin);
  var_8 = var_5;
  var_5 = var_1.size + 1;
  }
  }

  if (!var_7)
  return undefined;
  } else {
  for (var_5 = 0; var_5 < var_1.size; var_5++) {
  if (isdefined(var_1[var_5])) {
  var_3 = distance(var_0, var_1[0].origin);
  var_8 = var_5;
  var_5 = var_1.size + 1;
  }
  }
  }

  var_8 = undefined;

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
  if (isdefined(var_1[var_5])) {
  var_4 = 0;

  if (isdefined(var_2)) {
  for (var_6 = 0; var_6 < var_2.size; var_6++) {
  if (var_1[var_5] == var_2[var_6])
  var_4 = 1;
  }
  }

  if (!var_4) {
  var_9 = distance(var_0, var_1[var_5].origin);

  if (var_9 <= var_3) {
  var_3 = var_9;
  var_8 = var_5;
  }
  }
  }
  }

  if (isdefined(var_8))
  return var_1[var_8];
  else
  return undefined;
}

_id_78AA(var_0, var_1, var_2) {
  if (isdefined(var_1))
  var_3 = _func_072(var_1);
  else
  var_3 = _func_072();

  if (var_3.size == 0)
  return undefined;

  if (isdefined(var_2))
  var_3 = scripts\engine\utility::_id_22AC(var_3, var_2);

  return scripts\engine\utility::_id_7E2E(var_0, var_3);
}

_id_78AB(var_0, var_1, var_2) {
  if (isdefined(var_1))
  var_3 = _func_072(var_1);
  else
  var_3 = _func_072();

  if (var_3.size == 0)
  return undefined;

  return _id_78B5(var_0, var_3, var_2);
}

_id_7BDB(var_0, var_1, var_2, var_3) {
  if (!isdefined(var_3))
  var_3 = distance(var_0, var_1);

  var_3 = max(0.01, var_3);
  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_2 - var_0;
  var_6 = vectordot(var_5, var_4);
  var_6 = var_6 / var_3;
  var_6 = clamp(var_6, 0, 1);
  return var_6;
}

_id_3849(var_0, var_1) {
  if (!isdefined(var_1))
  var_1 = 1;

  if (!_id_D637(var_0))
  return 0;

  if (!sighttracepassed(self geteye(), var_0, var_1, self))
  return 0;

  return 1;
}

_id_D637(var_0) {
  if (!isdefined(var_0))
  return;

  var_1 = anglestoforward(self.angles);
  var_2 = vectornormalize(var_0 - self.origin);
  var_3 = vectordot(var_1, var_2);
  return var_3 > 0.766;
}

_id_1101B() {
  self notify("stop_magic_bullet_shield");

  if (isai(self)) {
  if (isdefined(self._id_C3B0)) {
  self._id_0050 = self._id_C3B0;
  self._id_C3B0 = undefined;
  }
  else
  self._id_0050 = 1;
  }

  self._id_B14F = undefined;
  self._id_00E0 = 0;
  self notify("internal_stop_magic_bullet_shield");
}

_id_B14E() {}

_id_B14F(var_0) {
  if (isai(self)) {}
  else
  self.health = 100000;

  self endon("internal_stop_magic_bullet_shield");

  if (isai(self)) {
  self._id_C3B0 = self._id_0050;
  self._id_0050 = 0.1;
  }

  self notify("magic_bullet_shield");
  self._id_B14F = 1;
  self._id_00E0 = 1;
}

_id_5550() {
  self._id_1491._id_55FC = 1;
}

_id_6215() {
  self._id_1491._id_55FC = 0;
}

_id_61DE() {
  self._id_10264 = undefined;
}

_id_5508() {
  self._id_10264 = 1;
}

_id_5131() {
  _id_B14F(1);
}

_id_7A31() {
  return self._id_0184;
}

_id_F416(var_0) {
  self._id_0184 = var_0;
}

_id_F415(var_0) {
  self._id_0180 = var_0;
}

_id_F39C(var_0) {
  self._id_012E = var_0;
}

_id_7B61() {
  return self._id_0223;
}

_id_F4B2(var_0) {
  self._id_0223 = var_0;
}

_id_5151(var_0) {
  scripts\common\exploder::_id_5152(var_0);
}

_id_8E80(var_0) {
  scripts\common\exploder::_id_8E81(var_0);
}

_id_100DA(var_0) {
  scripts\common\exploder::_id_100DB(var_0);
}

_id_10FEC(var_0) {
  scripts\common\exploder::_id_10FED(var_0);
}

_id_79A6(var_0) {
  return scripts\common\exploder::_id_79A7(var_0);
}

_id_6F54(var_0) {
  _id_0B77::_id_6F5A(var_0);
}

_id_7267(var_0, var_1, var_2, var_3) {
  if (!isdefined(var_1))
  var_1 = 4;

  thread _id_7268(var_0, var_1, var_2, var_3);
}

_id_C812() {
  if (isdefined(self._id_1491._id_4C42)) {
  self._id_1491._id_2274["crawl"] = self._id_1491._id_4C42["crawl"];
  self._id_1491._id_2274["death"] = self._id_1491._id_4C42["death"];
  self._id_1491._id_486A = self._id_1491._id_4C42["blood_fx_rate"];

  if (isdefined(self._id_1491._id_4C42["blood_fx"]))
  self._id_1491._id_4869 = self._id_1491._id_4C42["blood_fx"];
  }

  self._id_1491._id_2274["stand_2_crawl"] = [];

  if (isdefined(self._id_C05D))
  self._id_1491._id_D6A5 = "prone";

  self _meth_8221("face angle", self._id_1491._id_7266);
  self._id_1491._id_7266 = undefined;
}

_id_7268(var_0, var_1, var_2, var_3) {
  self._id_72CC = 1;
  self._id_1491._id_7280 = var_1;
  self._id_C089 = 1;
  self._id_C05D = var_3;
  self._id_1491._id_4C42 = var_2;
  self._id_4875 = ::_id_C812;
  self.maxhealth = 100000;
  self.health = 100000;
  _id_6215();

  if (!isdefined(var_3) || var_3 == 0)
  self._id_1491._id_7266 = var_0 + 181.02;
  else
  {
  self._id_1491._id_7266 = var_0;
  thread scripts\anim\notetracks::_id_C10C();
  }
}

_id_19D3() {
  self._id_10265 = 1;
  _id_54C6();
}

_id_D463(var_0) {
  self endon("death");
  self endon("stop_unresolved_collision_script");

  if (!isdefined(var_0))
  var_0 = 3;

  _id_E23C();
  childthread _id_D464();

  for (;;) {
  if (self._id_0366) {
  self._id_0366 = 0;

  if (self._id_12BE5 >= var_0) {
  if (isdefined(self._id_12BE9)) {
  var_1 = self._id_12BE9;

  if (isdefined(var_1._id_12BE7))
  var_1 [[var_1._id_12BE7]](self);
  }

  if (isdefined(self._id_8969))
  self [[self._id_8969]]();
  else
  _id_502A();
  }
  }
  else
  _id_E23C();

  wait 0.05;
  }
}

_id_D464() {
  for (;;) {
  self waittill("unresolved_collision", var_0);
  self._id_0366 = 1;
  self._id_12BE5++;
  self._id_12BE9 = var_0;
  }
}

_id_E23C() {
  self._id_0366 = 0;
  self._id_12BE5 = 0;
}

_id_502A() {
  var_0 = getnodesinradiussorted(self.origin, 500, 0, 200, "Path");

  if (var_0.size) {
  self _meth_805B();
  self dontinterpolate();
  self setorigin(var_0[0].origin);
  _id_E23C();
  } else {}
}

_id_11032() {
  self notify("stop_unresolved_collision_script");
  _id_E23C();
}

_id_9BB2() {
  return issentient(self) && !isalive(self);
}

_id_CE31(var_0, var_1, var_2, var_3, var_4) {
  if (_id_9BB2())
  return;

  var_5 = spawn("script_origin", self.origin);
  var_5 endon("death");
  thread _id_0B92::_id_517B(var_5, "sounddone");

  if (isdefined(var_1))
  var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else
  {
  var_5.origin = self.origin;
  var_5.angles = self.angles;
  var_5 linkto(self);
  }

  var_5 playsound(var_0, "sounddone");

  if (isdefined(var_2)) {
  if (!isdefined(_id_0B92::_id_1362A(var_5)))
  var_5 _meth_83AD();

  wait 0.05;
  }
  else
  var_5 waittill("sounddone");

  if (isdefined(var_3))
  self notify(var_3);

  var_5 delete();
}

_id_CE48(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (_id_9BB2())
  return;

  var_6 = spawn("script_origin", self.origin);
  var_6 endon("death");

  if (!isdefined(var_1))
  var_1 = "dirt";

  thread _id_0B92::_id_517B(var_6, "sounddone");

  if (isdefined(var_2))
  var_6 linkto(self, var_2, (0, 0, 0), (0, 0, 0));
  else
  {
  var_6.origin = self.origin;
  var_6.angles = self.angles;
  var_6 linkto(self);
  }

  var_6 _meth_824E(var_0, var_1, "sounddone");

  if (isdefined(var_3)) {
  if (!isdefined(_id_0B92::_id_1362A(var_6)))
  var_6 _meth_83AD();

  wait 0.05;
  }
  else
  var_6 waittill("sounddone");

  if (isdefined(var_4))
  self notify(var_4);

  var_6 delete();
}

_id_CE32(var_0, var_1) {
  _id_CE31(var_0, var_1, 1);
}

_id_CD80(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", (0, 0, 0));
  var_4 endon("death");
  thread scripts\engine\utility::_id_5179(var_4);

  if (!isdefined(var_2))
  var_2 = 0;

  if (!isdefined(var_3))
  var_3 = 0;

  if (isdefined(var_1))
  var_4.origin = self.origin + var_1;
  else
  var_4.origin = self.origin;

  var_4.angles = self.angles;
  var_4 linkto(self);
  var_4 playloopsound(var_0);
  var_4 _meth_8277(var_2, var_3);
  self waittill("stop sound" + var_0);
  var_4 stoploopsound(var_0);
  var_4 delete();
}

_id_CE2F(var_0, var_1) {
  _id_CE31(var_0, undefined, undefined, var_1);
}

_id_CD81(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");

  if (!isdefined(var_2))
  var_2 = 1;

  if (var_2)
  thread scripts\engine\utility::_id_5179(var_5);

  if (!isdefined(var_3))
  var_3 = 0;

  if (var_3)
  thread _id_5187(var_5);

  if (isdefined(var_1))
  var_5 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  else
  {
  var_5.origin = self.origin;
  var_5.angles = self.angles;
  var_5 linkto(self);
  }

  var_5 playloopsound(var_0);
  self waittill("stop sound" + var_0);

  if (isdefined(var_4)) {
  var_5 playsound(var_4, "sounddone");
  var_5 scripts\engine\utility::_id_50E1(0.15, ::stoploopsound, var_0);
  var_5 waittill("sounddone");
  var_5 delete();
  } else {
  var_5 stoploopsound(var_0);
  var_5 delete();
  }
}

_id_5187(var_0) {
  var_0 endon("death");

  while (isdefined(self))
  wait 0.05;

  if (isdefined(var_0))
  var_0 delete();
}

_id_106ED(var_0) {
  if (!isalive(var_0))
  return 1;

  if (!isdefined(var_0._id_6CDA))
  var_0 scripts\engine\utility::_id_13762("finished spawning", "death");

  if (isalive(var_0))
  return 0;

  return 1;
}

_id_23B7(var_0) {
  if (isdefined(var_0))
  self._id_1FBB = var_0;

  self _meth_83D0(level._id_EC87[self._id_1FBB]);
}

_id_23B8() {
  var_0 = tolower(self._id_111A4);

  switch (var_0) {
  case "c6":
  _id_23C2();
  break;
  case "c8":
  _id_23C4();
  break;
  case "c12":
  _id_23C5();
  break;
  case "no_boost":
  case "crew":
  case "riotshield":
  case "regular":
  case "juggernaut":
  case "elite":
  _id_23CA();
  break;
  default:
  break;
  }
}

_id_23B9() {
  var_0 = tolower(self._id_12BA4);

  switch (var_0) {
  case "c6":
  _id_23C2();
  break;
  case "c8":
  _id_23C4();
  break;
  case "c12":
  _id_23C5();
  break;
  case "soldier":
  case "civilian":
  case "c6i":
  _id_23CA();
  break;
  default:
  break;
  }
}

#using_animtree("c6");

_id_23C2() {
  self _meth_83D0(#animtree);
}

#using_animtree("c8");

_id_23C4() {
  self _meth_83D0(#animtree);
}

#using_animtree("c12");

_id_23C5() {
  self _meth_83D0(#animtree);
}

#using_animtree("generic_human");

_id_23CA() {
  self _meth_83D0(#animtree);
}

_id_23CC() {
  if (isarray(level._id_EC8C[self._id_1FBB])) {
  var_0 = randomint(level._id_EC8C[self._id_1FBB].size);
  self setmodel(level._id_EC8C[self._id_1FBB][var_0]);
  }
  else
  self setmodel(level._id_EC8C[self._id_1FBB]);
}

_id_10639(var_0, var_1, var_2) {
  if (!isdefined(var_1))
  var_1 = (0, 0, 0);

  var_3 = spawn("script_model", var_1);
  var_3._id_1FBB = var_0;
  var_3 _id_23B7();
  var_3 _id_23CC();

  if (isdefined(var_2))
  var_3.angles = var_2;

  return var_3;
}

_id_127AE(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if (!isdefined(var_2))
  return;

  var_2 waittill("trigger", var_3);
  level notify(var_0, var_3);
  return var_3;
}

_id_127B3(var_0) {
  return _id_127AE(var_0, "targetname");
}

_id_F3A1(var_0, var_1) {
  thread _id_F3A5(var_0, var_1, ::_id_13753, "set_flag_on_dead");
}

_id_F3A3(var_0, var_1) {
  thread _id_F3A5(var_0, var_1, ::_id_13754, "set_flag_on_dead_or_dying");
}

_id_61B8(var_0) {
  return;
}

_id_F3A8(var_0, var_1) {
  self waittill("spawned", var_2);

  if (_id_106ED(var_2))
  return;

  var_0._id_1912[var_0._id_1912.size] = var_2;
  _id_65E1(var_1);
}

_id_F3A5(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4._id_1912 = [];

  foreach (var_7, var_6 in var_0)
  var_6 _id_65E0(var_3);

  scripts\engine\utility::_id_22D2(var_0, ::_id_F3A8, var_4, var_3);

  foreach (var_7, var_6 in var_0)
  var_6 _id_65E3(var_3);

  [[var_2]](var_4._id_1912);
  scripts\engine\utility::_id_6E3E(var_1);
}

_id_F3AB(var_0, var_1) {
  if (!scripts\engine\utility::_id_6E25(var_1)) {
  var_0 waittill("trigger", var_2);
  scripts\engine\utility::_id_6E3E(var_1);
  return var_2;
  }
}

_id_F3AA(var_0) {
  if (scripts\engine\utility::_id_6E25(var_0))
  return;

  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
  scripts\engine\utility::_id_6E3E(var_0);
}

_id_13753(var_0, var_1, var_2) {
  var_10 = spawnstruct();

  if (isdefined(var_2)) {
  var_10 endon("thread_timed_out");
  var_10 thread _id_0B92::_id_13758(var_2);
  }

  var_10._id_00C1 = var_0.size;

  if (isdefined(var_1) && var_1 < var_10._id_00C1)
  var_10._id_00C1 = var_1;

  scripts\engine\utility::_id_22D2(var_0, _id_0B92::_id_13757, var_10);

  while (var_10._id_00C1 > 0)
  var_10 waittill("waittill_dead guy died");
}

_id_13754(var_0, var_1, var_2) {
  var_3 = [];

  foreach (var_5 in var_0) {
  if (isalive(var_5) && !var_5._id_0183)
  var_3[var_3.size] = var_5;
  }

  var_0 = var_3;
  var_7 = spawnstruct();

  if (isdefined(var_2)) {
  var_7 endon("thread_timed_out");
  var_7 thread _id_0B92::_id_13758(var_2);
  }

  var_7._id_00C1 = var_0.size;

  if (isdefined(var_1) && var_1 < var_7._id_00C1)
  var_7._id_00C1 = var_1;

  scripts\engine\utility::_id_22D2(var_0, _id_0B92::_id_13756, var_7);

  while (var_7._id_00C1 > 0)
  var_7 waittill("waittill_dead_guy_dead_or_dying");
}

_id_137B1(var_0) {
  self endon("damage");
  self endon("death");
  self waittillmatch("single anim", var_0);
}

_id_7A9D(var_0, var_1) {
  var_2 = _id_7A9E(var_0, var_1);

  if (var_2.size > 1)
  return undefined;

  return var_2[0];
}

_id_7A9E(var_0, var_1) {
  var_2 = _func_074("all", "all");
  var_3 = [];

  foreach (var_5 in var_2) {
  if (!isalive(var_5))
  continue;

  switch (var_1) {
  case "targetname":
  if (isdefined(var_5._id_0336) && var_5._id_0336 == var_0)
  var_3[var_3.size] = var_5;

  break;
  case "script_noteworthy":
  if (isdefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
  var_3[var_3.size] = var_5;

  break;
  }
  }

  return var_3;
}

_id_7D40(var_0, var_1) {
  var_2 = _id_7D43(var_0, var_1);

  if (!var_2.size)
  return undefined;

  return var_2[0];
}

_id_7D43(var_0, var_1) {
  var_2 = getentarray(var_0, var_1);
  var_3 = [];
  var_4 = [];

  foreach (var_6 in var_2) {
  if (var_6.code_classname != "script_vehicle")
  continue;

  var_4[0] = var_6;

  if (_func_113(var_6)) {
  if (isdefined(var_6._id_A90E)) {
  var_4[0] = var_6._id_A90E;
  var_3 = _id_22A2(var_3, var_4);
  }

  continue;
  }

  var_3 = _id_22A2(var_3, var_4);
  }

  return var_3;
}

_id_7A9F(var_0, var_1, var_2) {
  var_3 = _id_7AA0(var_0, var_1, var_2);

  if (var_3.size > 1)
  return undefined;

  return var_3[0];
}

_id_7AA0(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = "all";

  var_3 = _func_074("allies", var_2);
  var_3 = scripts\engine\utility::_id_227F(var_3, _func_074("axis", var_2));
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
  switch (var_1) {
  case "targetname":
  if (isdefined(var_3[var_5]._id_0336) && var_3[var_5]._id_0336 == var_0)
  var_4[var_4.size] = var_3[var_5];

  break;
  case "script_noteworthy":
  if (isdefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0)
  var_4[var_4.size] = var_3[var_5];

  break;
  }
  }

  return var_4;
}

_id_76F4(var_0, var_1) {
  if (isdefined(level._id_76F3[var_0])) {
  if (level._id_76F3[var_0]) {
  wait 0.05;

  if (isalive(self))
  self notify("gather_delay_finished" + var_0 + var_1);

  return;
  }

  level waittill(var_0);

  if (isalive(self))
  self notify("gather_delay_finished" + var_0 + var_1);

  return;
  }

  level._id_76F3[var_0] = 0;
  wait(var_1);
  level._id_76F3[var_0] = 1;
  level notify(var_0);

  if (isalive(self))
  self notify("gat  her_delay_finished" + var_0 + var_1);
}

_id_76F3(var_0, var_1) {
  thread _id_76F4(var_0, var_1);
  self waittill("gather_delay_finished" + var_0 + var_1);
}

_id_7F79(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  var_4 = var_0[var_3];
  var_5 = var_4._id_027C;

  if (!isdefined(var_5))
  continue;

  if (!isdefined(var_1[var_5]))
  continue;

  var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_22A2(var_0, var_1) {
  if (var_0.size == 0)
  return var_1;

  if (var_1.size == 0)
  return var_0;

  var_2 = var_0;

  foreach (var_4 in var_1) {
  var_5 = 0;

  foreach (var_7 in var_0) {
  if (var_7 == var_4) {
  var_5 = 1;
  break;
  }
  }

  if (var_5)
  continue;
  else
  var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_2290(var_0, var_1) {
  var_2 = var_0;

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
  if (scripts\engine\utility::array_contains(var_0, var_1[var_3]))
  var_2 = scripts\engine\utility::array_remove(var_2, var_1[var_3]);
  }

  return var_2;
}

_id_2285(var_0, var_1) {
  if (var_0.size != var_1.size)
  return 0;

  foreach (var_5, var_3 in var_0) {
  if (!isdefined(var_1[var_5]))
  return 0;

  var_4 = var_1[var_5];

  if (var_4 != var_3)
  return 0;
  }

  return 1;
}

_id_7F77() {
  var_0 = [];

  if (isdefined(self._id_EE01)) {
  var_1 = scripts\engine\utility::_id_7A9C();

  foreach (var_3 in var_1) {
  var_4 = getvehiclenodearray(var_3, "script_linkname");
  var_0 = scripts\engine\utility::_id_227F(var_0, var_4);
  }
  }

  return var_0;
}

_id_5B4A(var_0, var_1, var_2, var_3, var_4) {
  for (;;)
  wait 0.05;
}

_id_5B51(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_5 = gettime() + var_5 * 1000;

  while (gettime() < var_5) {
  wait 0.05;

  if (!isdefined(var_1) || !isdefined(var_1.origin))
  return;
  }
}

_id_5B4C(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_5B51(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_5B4D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 = gettime() + var_5 * 1000;

  while (gettime() < var_5)
  wait 0.05;
}

_id_5B4E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  var_1 endon("death");
  var_5 endon(var_6);

  for (;;)
  wait 0.05;
}

_id_5B52(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5 endon(var_6);

  for (;;)
  scripts\engine\utility::_id_5B4B(var_0, var_1, var_2, var_3, var_4, 0.05);
}

_id_5B4F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_6 = gettime() + var_6 * 1000;
  var_1 = var_1 * var_2;

  while (gettime() < var_6) {
  wait 0.05;

  if (!isdefined(var_0) || !isdefined(var_0.origin))
  return;
  }
}

_id_5B29(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for (var_9 = 0; var_9 < var_6; var_9++) {
  var_10 = var_7 * var_9;
  var_11 = cos(var_10) * var_1;
  var_12 = sin(var_10) * var_1;
  var_13 = var_0[0] + var_11;
  var_14 = var_0[1] + var_12;
  var_15 = var_0[2];
  var_8[var_8.size] = (var_13, var_14, var_15);
  }

  for (var_9 = 0; var_9 < var_8.size; var_9++) {
  var_16 = var_8[var_9];

  if (var_9 + 1 >= var_8.size) {
  var_17 = var_8[0];
  continue;
  }

  var_17 = var_8[var_9 + 1];
  }
}

_id_5B2B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 16;
  var_8 = 360 / var_7;
  var_9 = [];

  for (var_10 = 0; var_10 < var_7; var_10++) {
  var_11 = var_8 * var_10;
  var_12 = cos(var_11) * var_1;
  var_13 = sin(var_11) * var_1;
  var_14 = var_0[0] + var_12;
  var_15 = var_0[1] + var_13;
  var_16 = var_0[2];
  var_9[var_9.size] = (var_14, var_15, var_16);
  }

  thread _id_5B2A(var_9, var_2, var_3, var_4, var_5, var_6);
}

_id_5B2A(var_0, var_1, var_2, var_3, var_4, var_5) {
  for (var_6 = 0; var_6 < var_0.size; var_6++) {
  var_7 = var_0[var_6];

  if (var_6 + 1 >= var_0.size)
  var_8 = var_0[0];
  else
  var_8 = var_0[var_6 + 1];

  thread _id_5B52(var_7, var_8, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_28D7(var_0) {
  level notify("battlechatter_off_thread");
  scripts\anim\battlechatter::_id_29C1();

  if (isdefined(var_0)) {
  _id_F2DC(var_0, 0);
  var_1 = _func_072(var_0);
  } else {
  foreach (var_0 in anim._id_115E7)
  _id_F2DC(var_0, 0);

  var_1 = _func_072();
  }

  if (!isdefined(anim._id_3D4B) || !anim._id_3D4B)
  return;

  for (var_4 = 0; var_4 < var_1.size; var_4++)
  var_1[var_4]._id_28CF = 0;

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
  var_5 = var_1[var_4];

  if (!isalive(var_5))
  continue;

  if (!var_5._id_3D4B)
  continue;

  if (!var_5._id_9F6B)
  continue;

  var_5 _id_0B92::_id_1368E();
  anim._id_29B7 = 0;
  }

  var_6 = gettime() - anim._id_AA27["allies"];

  if (var_6 < 1500)
  wait(var_6 / 1000);

  if (isdefined(var_0))
  level notify(var_0 + " done speaking");
  else
  level notify("done speaking");
}

_id_28D8(var_0) {
  thread _id_0B92::_id_28D9(var_0);
}

_id_F2DA(var_0) {
  if (!anim._id_3D4B)
  return;

  if (var_0) {
  if (isdefined(self._id_ED17) && !self._id_ED17 || isdefined(self._id_12BA4) && self._id_12BA4 == "c8" || isdefined(self._id_12BA4) && self._id_12BA4 == "c12" || isdefined(self._id_238F) && self._id_238F == "seeker")
  self._id_28CF = 0;
  else
  self._id_28CF = 1;
  } else {
  self._id_28CF = 0;

  if (isdefined(self._id_9F6B) && self._id_9F6B)
  self waittill("done speaking");
  }
}

_id_F5C2(var_0, var_1) {
  if (!anim._id_3D4B)
  return;

  var_2 = getarraykeys(anim._id_46BD);
  var_3 = scripts\engine\utility::array_contains(var_2, var_1);

  if (!var_3)
  return;

  var_4 = _func_072(var_0);

  foreach (var_6 in var_4) {
  var_6 _id_F292(var_1);
  scripts\engine\utility::waitframe();
  }
}

_id_F292(var_0) {
  if (!anim._id_3D4B)
  return;

  var_1 = getarraykeys(anim._id_46BD);
  var_2 = scripts\engine\utility::array_contains(var_1, var_0);

  if (!var_2)
  return;

  if (self.type == "dog")
  return;

  if (isdefined(self._id_9F6B) && self._id_9F6B) {
  self waittill("done speaking");
  wait 0.1;
  }

  scripts\anim\battlechatter_ai::_id_E11B();
  waittillframeend;
  self._id_13525 = var_0;
  scripts\anim\battlechatter_ai::_id_185D();
}

_id_6EEB(var_0, var_1) {
  thread _id_F3B0(1, var_0, var_1);
}

_id_6EEA(var_0, var_1) {
  thread _id_F3B0(0, var_0, var_1);
}

_id_F3B0(var_0, var_1, var_2) {
  if (!isdefined(var_1))
  var_1 = "allies";

  if (!isdefined(var_2))
  var_2 = 0;
  else
  anim._id_C52F = 1;

  while (!isdefined(anim._id_3D4B))
  wait 0.05;

  if (!anim._id_3D4B)
  return;

  wait 1.5;
  level._id_6EE9[var_1] = var_0;
  var_3 = [];
  var_4 = [];

  if (isdefined(level._id_A056) && isdefined(level._id_A056._id_1630)) {
  if (!isdefined(level._id_D127) || anim.player != level._id_D127)
  anim.player._id_C4B2 = 1;

  var_4 = level._id_A056._id_1630;
  var_4 = scripts\engine\utility::_id_22BC(var_4);

  foreach (var_6 in var_4) {
  if (isdefined(var_6.team) && var_6.team != "allies")
  var_4 = scripts\engine\utility::array_remove(var_4, var_6);

  if (isdefined(var_6._id_ED2D) && var_6._id_ED2D == "fake")
  var_4 = scripts\engine\utility::array_remove(var_4, var_6);
  }
  }

  if (!var_0) {
  if (isdefined(anim._id_C52F))
  anim._id_C52F = 0;
  }

  var_3 = _func_072(var_1);
  var_3 = scripts\engine\utility::_id_227F(var_3, var_4);
  scripts\engine\utility::_id_22D2(var_3, ::_id_F3AF, var_0);
}

_id_F3AF(var_0) {
  self._id_6EE9 = var_0;
}

_id_7412() {
  var_0 = _func_072("allies");

  foreach (var_2 in var_0) {
  if (isalive(var_2))
  var_2 _id_F3C0(0);
  }

  level._id_7410 = 0;
}

_id_7413() {
  var_0 = _func_072("allies");

  foreach (var_2 in var_0) {
  if (isalive(var_2))
  var_2 _id_F3C0(1);
  }

  level._id_7410 = 1;
}

_id_F3C0(var_0) {
  if (var_0)
  self._id_7411 = undefined;
  else
  self._id_7411 = 1;
}

_id_CF8D() {
  thread _id_0E4E::_id_CF8E();
}

_id_CF8B() {
  thread _id_0E4E::_id_CF8C();
}

_id_4F4B() {
  self notify("Debug origin");
  self endon("Debug origin");
  self endon("death");

  for (;;) {
  var_0 = anglestoforward(self.angles);
  var_1 = var_0 * 30;
  var_2 = var_0 * 20;
  var_3 = anglestoright(self.angles);
  var_4 = var_3 * -10;
  var_3 = var_3 * 10;
  wait 0.05;
  }
}

_id_7A97() {
  var_0 = [];

  if (isdefined(self._id_EE01)) {
  var_1 = scripts\engine\utility::_id_7A9C();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
  var_3 = scripts\engine\utility::_id_817E(var_1[var_2], "script_linkname");

  if (isdefined(var_3))
  var_0[var_0.size] = var_3;
  }
  }

  return var_0;
}

_id_7A96() {
  var_0 = _id_7A97();

  if (!var_0.size)
  return undefined;

  return var_0[0];
}

_id_7A6F(var_0) {
  var_1 = self;

  while (isdefined(var_1._id_0334)) {
  wait 0.05;

  if (isdefined(var_1._id_0334)) {
  switch (var_0) {
  case "vehiclenode":
  var_1 = getvehiclenode(var_1._id_0334, "targetname");
  break;
  case "pathnode":
  var_1 = getnode(var_1._id_0334, "targetname");
  break;
  case "ent":
  var_1 = getent(var_1._id_0334, "targetname");
  break;
  case "struct":
  var_1 = scripts\engine\utility::_id_817E(var_1._id_0334, "targetname");
  break;
  default:
  }

  continue;
  }

  break;
  }

  var_2 = var_1;
  return var_2;
}

_id_11901(var_0) {
  self endon("death");
  wait(var_0);
  self notify("timeout");
}

_id_F3BC() {
  if (isdefined(self._id_F3BB))
  return;

  self._id_C3EC = self._id_0231;
  self._id_C3F4 = self._id_0232;
  self._id_C3F5 = self._id_01D3;
  self._id_0231 = 8;
  self._id_0232 = 8;
  self._id_01D3 = 1;
  self._id_F3BB = 1;
}

_id_12BFA() {
  if (!isdefined(self._id_F3BB))
  return;

  self._id_0231 = self._id_C3EC;
  self._id_0232 = self._id_C3F4;
  self._id_01D3 = self._id_C3F5;
  self._id_F3BB = undefined;
}

_id_22BA(var_0) {
  var_1 = [];
  var_2 = getarraykeys(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
  var_4 = var_2[var_3];

  if (!isalive(var_0[var_4]))
  continue;

  var_1[var_4] = var_0[var_4];
  }

  return var_1;
}

_id_22B9(var_0) {
  var_1 = [];

  foreach (var_3 in var_0) {
  if (!isalive(var_3))
  continue;

  var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_22BB(var_0) {
  var_1 = [];

  foreach (var_3 in var_0) {
  if (!isalive(var_3))
  continue;

  if (var_3 _id_58DA())
  continue;

  var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_22B5(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  if (var_0[var_3] != var_1)
  var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_22B2(var_0, var_1) {
  var_2 = [];

  foreach (var_5, var_4 in var_0) {
  if (var_1 == var_5)
  continue;

  var_2[var_5] = var_4;
  }

  return var_2;
}

_id_22B3(var_0, var_1) {
  if (var_1.size == 0)
  return var_0;

  var_2 = [];

  foreach (var_9, var_4 in var_0) {
  var_5 = 0;

  foreach (var_7 in var_1) {
  if (var_7 == var_9) {
  var_5 = 1;
  break;
  }
  }

  if (var_5)
  continue;

  var_2[var_9] = var_4;
  }

  return var_2;
}

_id_22B0(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size - 1; var_2++) {
  if (var_2 == var_1) {
  var_0[var_2] = var_0[var_2 + 1];
  var_1++;
  }
  }

  var_0[var_0.size - 1] = undefined;
  return var_0;
}

_id_22A4(var_0, var_1, var_2) {
  foreach (var_5, var_4 in var_0)
  var_4 notify(var_1, var_2);
}

_id_1115A() {
  var_0 = spawnstruct();
  var_0._id_2274 = [];
  var_0._id_A9A1 = 0;
  return var_0;
}

_id_11161(var_0, var_1) {
  var_0._id_2274[var_0._id_A9A1] = var_1;
  var_1._id_11159 = var_0._id_A9A1;
  var_0._id_A9A1++;
}

_id_11162(var_0, var_1) {
  _id_11167(var_0, var_1);
  var_0._id_2274[var_0._id_A9A1 - 1] = undefined;
  var_0._id_A9A1--;
}

_id_11163(var_0, var_1) {
  if (isdefined(var_0._id_2274[var_0._id_A9A1 - 1])) {
  var_0._id_2274[var_1] = var_0._id_2274[var_0._id_A9A1 - 1];
  var_0._id_2274[var_1]._id_11159 = var_1;
  var_0._id_2274[var_0._id_A9A1 - 1] = undefined;
  var_0._id_A9A1 = var_0._id_2274.size;
  } else {
  var_0._id_2274[var_1] = undefined;
  _id_11164(var_0);
  }
}

_id_11164(var_0) {
  var_1 = [];

  foreach (var_3 in var_0._id_2274) {
  if (!isdefined(var_3))
  continue;

  var_1[var_1.size] = var_3;
  }

  var_0._id_2274 = var_1;

  foreach (var_6, var_3 in var_0._id_2274)
  var_3._id_11159 = var_6;

  var_0._id_A9A1 = var_0._id_2274.size;
}

_id_11167(var_0, var_1) {
  var_0 _id_0B92::_id_11166(var_0._id_2274[var_0._id_A9A1 - 1], var_1);
}

_id_11165(var_0, var_1) {
  for (var_2 = 0; var_2 < var_1; var_2++)
  var_0 _id_0B92::_id_11166(var_0._id_2274[var_2], var_0._id_2274[randomint(var_0._id_A9A1)]);
}

_id_4C39(var_0) {
  return scripts\anim\battlechatter_ai::_id_4C3B(var_0);
}

_id_7CAE(var_0, var_1) {
  var_2 = newhudelem();

  if (level._id_4542) {
  var_2.x = 68;
  var_2.y = 35;
  } else {
  var_2.x = 58;
  var_2.y = 95;
  }

  var_2._id_002B = "center";
  var_2._id_002C = "middle";
  var_2._id_017D = "left";
  var_2._id_0382 = "middle";

  if (isdefined(var_1))
  var_3 = var_1;
  else
  var_3 = level._id_6A04;

  var_2 _meth_82C4(var_3, var_0, "hudStopwatch", 64, 64);
  return var_2;
}

_id_B8D1() {
  if (level._id_B8D0)
  return;

  if (isdefined(level._id_BF95))
  return;

  if (_id_93AB()) {
  level.player _meth_8591(1);
  _func_229();
  _id_0B28::_id_41ED();
  }

  level._id_B8D0 = 1;
  scripts\engine\utility::_id_6E3E("missionfailed");

  if (getdvar("failure_disabled") == "1")
  return;

  if (isdefined(level._id_B8BE)) {
  thread [[level._id_B8BE]]();
  return;
  }

  _func_143(_id_93AB());
}

_id_F487(var_0) {
  level._id_B8BE = var_0;
}

_id_027B() {
  if (isdefined(self._id_027B)) {
  wait(self._id_027B);
  return 1;
  }
  else if (isdefined(self._id_ED50) && isdefined(self._id_ED4F)) {
  wait(randomfloatrange(self._id_ED50, self._id_ED4F));
  return 1;
  }

  return 0;
}

_id_EF15() {
  var_0 = gettime();

  if (isdefined(self._id_EF15)) {
  wait(self._id_EF15);

  if (isdefined(self._id_EF1A))
  self._id_EF15 = self._id_EF15 + self._id_EF1A;
  }
  else if (isdefined(self._id_EF1C) && isdefined(self._id_EF1B)) {
  wait(randomfloatrange(self._id_EF1C, self._id_EF1B));

  if (isdefined(self._id_EF1A)) {
  self._id_EF1C = self._id_EF1C + self._id_EF1A;
  self._id_EF1B = self._id_EF1B + self._id_EF1A;
  }
  }

  return gettime() - var_0;
}

_id_79C8(var_0, var_1) {
  var_2 = _func_072(var_0);
  var_3 = [];

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
  var_5 = var_2[var_4];

  if (!isdefined(var_5._id_EDAD))
  continue;

  if (var_5._id_EDAD != var_1)
  continue;

  var_3[var_3.size] = var_5;
  }

  return var_3;
}

_id_7802() {
  var_0 = _func_072("allies");
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
  var_3 = var_0[var_2];

  if (!isdefined(var_3._id_EDAD))
  continue;

  var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_61C7() {
  if (isdefined(self._id_EDAD))
  return;

  if (!isdefined(self._id_C3BE))
  return;

  _id_F3B5(self._id_C3BE);
  self._id_C3BE = undefined;
}

_id_61C8() {
  self._id_5955 = 1;
  _id_61C7();
}

_id_54F7() {
  if (isdefined(self._id_BF06)) {
  self endon("death");
  self waittill("done_setting_new_color");
  }

  self _meth_8073();

  if (!isdefined(self._id_EDAD))
  return;

  self._id_C3BE = self._id_EDAD;
  level._id_22E0[_id_0B13::_id_7CE4()][self._id_EDAD] = scripts\engine\utility::array_remove(level._id_22E0[_id_0B13::_id_7CE4()][self._id_EDAD], self);
  _id_0B13::_id_AB3A();
  self._id_EDAD = undefined;
  self._id_4BDF = undefined;
}

_id_414F() {
  _id_54F7();
}

_id_79C7() {
  var_0 = self._id_EDAD;
  return var_0;
}

_id_FEEE(var_0) {
  return level._id_43A3[tolower(var_0)];
}

_id_F3B5(var_0) {
  var_1 = _id_FEEE(var_0);

  if (!isai(self)) {
  _id_F3B7(var_1);
  return;
  }

  if (self.team == "allies") {
  self._id_0132 = 1;
  self._id_0133 = 64;
  self._id_0231 = 0;
  self._id_0232 = 0;
  }

  self._id_ED34 = undefined;
  self._id_ED33 = undefined;
  self._id_C3BE = undefined;
  var_2 = _id_0B13::_id_7CE4();

  if (isdefined(self._id_EDAD))
  level._id_22E0[var_2][self._id_EDAD] = scripts\engine\utility::array_remove(level._id_22E0[var_2][self._id_EDAD], self);

  self._id_EDAD = var_1;
  level._id_22E0[var_2][var_1] = _id_22B9(level._id_22E0[var_2][var_1]);
  level._id_22E0[var_2][self._id_EDAD] = scripts\engine\utility::_id_2279(level._id_22E0[var_2][self._id_EDAD], self);
  thread _id_0B92::_id_BF01(var_1);
}

_id_F3B7(var_0) {
  self._id_EDAD = var_0;
  self._id_C3BE = undefined;
}

_id_6EDC(var_0) {
  var_1 = gettime() + var_0 * 1000;

  while (gettime() < var_1) {
  self playrumbleonentity("damage_heavy");
  wait 0.05;
  }
}

_id_6ED8(var_0) {
  self endon("death");
  self endon("flashed");
  wait 0.2;
  self _meth_80D0(0);
  wait(var_0 + 2);
  self _meth_80D0(1);
}

_id_E2B0() {
  scripts\common\createfx::_id_E2AB();
}

_id_C9D0(var_0) {
  var_0 = var_0 + "";

  if (isdefined(level.createfxexploders)) {
  var_1 = level.createfxexploders[var_0];

  if (isdefined(var_1)) {
  foreach (var_3 in var_1)
  var_3 scripts\engine\utility::_id_C9CF();

  return;
  }
  } else {
  foreach (var_6 in level.createfxent) {
  if (!isdefined(var_6.v["exploder"]))
  continue;

  if (var_6.v["exploder"] != var_0)
  continue;

  var_6 scripts\engine\utility::_id_C9CF();
  }
  }
}

_id_E2B1(var_0) {
  var_0 = var_0 + "";

  if (isdefined(level.createfxexploders)) {
  var_1 = level.createfxexploders[var_0];

  if (isdefined(var_1)) {
  foreach (var_3 in var_1)
  var_3 _id_E2B0();

  return;
  }
  } else {
  foreach (var_6 in level.createfxent) {
  if (!isdefined(var_6.v["exploder"]))
  continue;

  if (var_6.v["exploder"] != var_0)
  continue;

  var_6 _id_E2B0();
  }
  }
}

_id_9326(var_0) {
  self notify("ignoreAllEnemies_threaded");
  self endon("ignoreAllEnemies_threaded");

  if (var_0) {
  self._id_C3DE = self _meth_8163();
  var_1 = undefined;
  createthreatbiasgroup("ignore_everybody");
  self setthreatbiasgroup("ignore_everybody");
  var_2 = [];
  var_2["axis"] = "allies";
  var_2["allies"] = "axis";
  var_3 = _func_072(var_2[self.team]);
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++)
  var_4[var_3[var_5] _meth_8163()] = 1;

  var_6 = getarraykeys(var_4);

  for (var_5 = 0; var_5 < var_6.size; var_5++)
  _func_1D1(var_6[var_5], "ignore_everybody", 0);
  } else {
  var_1 = undefined;

  if (self._id_C3DE != "")
  self setthreatbiasgroup(self._id_C3DE);

  self._id_C3DE = undefined;
  }
}

_id_131CC() {
  _id_0B96::_id_13219();
}

_id_13221() {
  thread _id_0B98::_id_13222();
}

_id_131FF(var_0) {
  _id_0B96::_id_13201(var_0);
}

_id_13206(var_0) {
  _id_0B96::_id_13207(var_0);
}

_id_131D5(var_0, var_1) {
  _id_0B93::_id_1321A(var_0, var_1);
}

_id_864C(var_0, var_1) {
  if (isdefined(var_1))
  var_1 = var_1 * -100000;
  else
  var_1 = (0, 0, -100000);

  return bullettrace(var_0, var_0 + var_1, 0, self)["position"];
}

_id_3C4A(var_0) {
  self._id_D0CE = self._id_D0CE + var_0;
  self notify("update_health_packets");

  if (self._id_D0CE >= 3)
  self._id_D0CE = 3;
}

_id_8200(var_0, var_1) {
  var_2 = _id_8201(var_0, var_1);
  return var_2[0];
}

_id_8201(var_0, var_1) {
  return _id_0B96::_id_12B8(var_0, var_1);
}

_id_1749(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_0B79::_id_174A();
  var_0 = tolower(var_0);
  var_7 = _id_0B79::_id_174B(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  level._id_10C58[level._id_10C58.size] = var_7;
  level._id_10BA8[var_0] = var_7;
}

_id_F343(var_0) {
  level._id_5019 = var_0;
}

_id_F344(var_0) {
  level._id_501A = var_0;
}

_id_13D91(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize((var_2[0], var_2[1], 0) - (var_0[0], var_0[1], 0));
  var_5 = anglestoforward((0, var_1[1], 0));
  return vectordot(var_5, var_4) >= var_3;
}

_id_7951(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglestoforward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

_id_13D92(var_0, var_1) {
  var_2 = undefined;

  for (var_3 = 0; var_3 < level.players.size; var_3++) {
  var_4 = level.players[var_3] geteye();
  var_2 = scripts\engine\utility::within_fov(var_4, level.players[var_3] getplayerangles(), var_0, var_1);

  if (!var_2)
  return 0;
  }

  return 1;
}

_id_135AF(var_0, var_1) {
  var_2 = var_1 * 1000 - (gettime() - var_0);
  var_2 = var_2 * 0.001;

  if (var_2 > 0)
  wait(var_2);
}

_id_29C0() {
  anim._id_EF75 = gettime();
}

_id_5480(var_0) {
  _id_29C0();
  _id_0B06::_id_1F32(self, var_0);
}

_id_7749(var_0, var_1) {
  _id_29C0();
  _id_0B06::_id_1ECD(self, var_0, undefined, undefined, var_1);
}

_id_DBEF(var_0, var_1) {
  if (!isdefined(level._id_D24D)) {
  var_2 = spawn("script_origin", (0, 0, 0));
  var_2 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
  level._id_D24D = var_2;
  }

  _id_29C0();
  var_3 = 0;

  if (!isdefined(var_1))
  var_3 = level._id_D24D _id_74D7(::_id_CE31, level._id_EC91[var_0], undefined, 1);
  else
  var_3 = level._id_D24D _id_74DD(var_1, ::_id_CE31, level._id_EC91[var_0], undefined, 1);

  return var_3;
}

_id_DBF2(var_0) {
  level._id_D24D _id_CE31(level._id_EC91[var_0], undefined, 1);
}

_id_DBF5() {
  if (!isdefined(level._id_D24D))
  return;

  level._id_D24D delete();
}

_id_DBF0() {
  if (!isdefined(level._id_D24D))
  return;

  level._id_D24D _id_74D9();
}

_id_DBF1(var_0) {
  if (!isdefined(level._id_D24D)) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
  level._id_D24D = var_1;
  }

  level._id_D24D _id_CE31(level._id_EC91[var_0], undefined, 1);
}

_id_DBF4(var_0) {
  return _id_DBEF(var_0, 0.05);
}

_id_10350(var_0, var_1) {
  _id_0B92::_id_1778(var_0);
  _id_DBEF(var_0, var_1);
}

_id_10352(var_0) {
  _id_0B92::_id_1778(var_0);
  _id_DBF5();
  _id_DBF1(var_0);
}

_id_10353(var_0) {
  _id_0B92::_id_1778(var_0);
  _id_DBF2(var_0);
}

_id_D01B(var_0, var_1) {
  return _id_D01E(var_0, 0, undefined, undefined, undefined, var_1);
}

_id_1369(var_0, var_1, var_2, var_3, var_4) {
  if (_id_9BB2())
  return;

  var_5 = spawn("script_origin", (0, 0, 0));
  var_5 endon("death");
  var_5.origin = self.origin;
  var_5.angles = self.angles;
  var_5 linkto(self);

  if (var_1 > 0)
  var_5 scripts\engine\utility::_id_50E1(var_1, ::playsound, var_0, "sounddone");
  else
  var_5 playsound(var_0, "sounddone");

  if (isdefined(var_2)) {
  if (isarray(var_2)) {
  for (var_6 = 0; var_6 < var_2.size; var_6++) {
  if (isdefined(var_4) && isdefined(var_4[var_6])) {
  level.player scripts\engine\utility::delaythread(var_3[var_6], ::_id_D090, var_2[var_6], var_4[var_6]);
  continue;
  }

  level.player scripts\engine\utility::delaythread(var_3[var_6], ::_id_D090, var_2[var_6]);
  }
  }
  else if (isdefined(var_4))
  level.player scripts\engine\utility::delaythread(var_3, ::_id_D090, var_2, var_4);
  else
  level.player scripts\engine\utility::delaythread(var_3, ::_id_D090, var_2);
  }

  if (var_1 > 0)
  wait(var_1);

  if (!isdefined(_id_0B92::_id_1362A(var_5, level.player)))
  var_5 _meth_83AD();

  wait 0.05;
  var_5 delete();
}

_id_D01E(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (!isdefined(level._id_D01D)) {
  var_6 = spawn("script_origin", (0, 0, 0));
  var_6 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
  level._id_D01D = var_6;
  }

  _id_29C0();
  var_7 = 0;

  if (!isdefined(var_5))
  var_7 = level._id_D01D _id_74D7(::_id_1369, level._id_EC8E[var_0], var_1, var_2, var_3, var_4);
  else
  var_7 = level._id_D01D _id_74DD(var_5, ::_id_1369, level._id_EC8E[var_0], var_1, var_2, var_3, var_4);

  return var_7;
}

_id_D020() {
  if (!isdefined(level._id_D01D))
  return;

  level._id_D01D delete();
}

_id_D01C() {
  if (!isdefined(level._id_D01D))
  return;

  level._id_D01D _id_74D9();
}

_id_D01F(var_0) {
  _id_D020();

  if (!isdefined(level._id_D01D)) {
  var_1 = spawn("script_origin", (0, 0, 0));
  var_1 linkto(level.player, "", (0, 0, 0), (0, 0, 0));
  level._id_D01D = var_1;
  }

  level._id_D01D _id_1369(level._id_EC8E[var_0], 0);
}

_id_1034D(var_0, var_1) {
  _id_0B92::_id_1773(var_0);
  _id_D01B(var_0, var_1);
}

_id_1034F(var_0) {
  _id_0B92::_id_1773(var_0);
  _id_D01F(var_0);
}

_id_1034E(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0B92::_id_1773(var_0);
  _id_D01E(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_10346(var_0) {
  _id_0B92::_id_175F(var_0);
  _id_5480(var_0);
}

_id_10347(var_0) {
  _id_0B92::_id_1760(var_0);
  _id_7749(var_0);
}

_id_DBF3(var_0) {
  _id_DBEF(var_0);
}

_id_11145(var_0) {
  return "" + var_0;
}

_id_9329(var_0, var_1) {
  setignoremegroup(var_0, var_1);
  setignoremegroup(var_1, var_0);
}

_id_16E5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5["function"] = var_1;
  var_5["param1"] = var_2;
  var_5["param2"] = var_3;
  var_5["param3"] = var_4;
  level._id_10707[var_0][level._id_10707[var_0].size] = var_5;
}

_id_E031(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < level._id_10707[var_0].size; var_3++) {
  if (level._id_10707[var_0][var_3]["function"] != var_1)
  var_2[var_2.size] = level._id_10707[var_0][var_3];
  }

  level._id_10707[var_0] = var_2;
}

_id_693E(var_0, var_1) {
  if (!isdefined(level._id_10707))
  return 0;

  for (var_2 = 0; var_2 < level._id_10707[var_0].size; var_2++) {
  if (level._id_10707[var_0][var_2]["function"] == var_1)
  return 1;
  }

  return 0;
}

_id_E08B(var_0) {
  var_1 = [];

  foreach (var_3 in self._id_10708) {
  if (var_3["function"] == var_0)
  continue;

  var_1[var_1.size] = var_3;
  }

  self._id_10708 = var_1;
}

_id_1747(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach (var_7 in self._id_10708) {
  if (var_7["function"] == var_0)
  return;
  }

  var_9 = [];
  var_9["function"] = var_0;
  var_9["param1"] = var_1;
  var_9["param2"] = var_2;
  var_9["param3"] = var_3;
  var_9["param4"] = var_4;
  var_9["param5"] = var_5;
  self._id_10708[self._id_10708.size] = var_9;
}

_id_228A(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++) {
  if (isdefined(var_0[var_1]))
  var_0[var_1] delete();
  }
}

_id_229F(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
  var_0[var_1] _meth_81D0();
}

_id_931D(var_0) {
  self endon("death");
  self._id_0187 = 1;

  if (isdefined(var_0))
  wait(var_0);
  else
  wait 0.5;

  self._id_0187 = 0;
}

_id_15F5(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 _id_15F1();
}

_id_15F3(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 _id_15F1();
}

_id_5599(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 scripts\engine\utility::_id_12778();
}

_id_5598(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 scripts\engine\utility::_id_12778();
}

_id_624C(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 scripts\engine\utility::_id_1277A();
}

_id_624B(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 scripts\engine\utility::_id_1277A();
}

_id_77E1() {
  if (!isdefined(self._id_12BA3))
  _id_F294();

  return self._id_12BA3;
}

_id_F294() {
  if (!isdefined(level._id_19C9))
  level._id_19C9 = 0;

  self._id_12BA3 = "ai" + level._id_19C9;
  level._id_19C9++;
}

_id_F5C3(var_0, var_1) {
  var_2 = _func_072(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++)
  var_2[var_3]._id_0223 = var_1;
}

_id_E198() {
  _id_0B13::_id_43AA();
}

_id_107B3(var_0, var_1) {
  _id_0B13::_id_43AC(var_0, var_1);
}

_id_F55D(var_0, var_1) {
  if (!isdefined(level._id_4B58))
  level._id_4B58 = [];

  var_0 = _id_FEEE(var_0);
  var_1 = _id_FEEE(var_1);
  level._id_4B58[var_0] = var_1;

  if (!isdefined(level._id_4B58[var_1]))
  _id_F38A(var_1);
}

_id_F38A(var_0) {
  if (!isdefined(level._id_4B58))
  level._id_4B58 = [];

  level._id_4B58[var_0] = "none";
}

_id_DFEB(var_0) {
  var_1 = [];

  foreach (var_3 in var_0) {
  if (!isalive(var_3))
  continue;

  var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_DFDA(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  var_4 = var_0[var_3];

  if (!isdefined(var_4._id_EDAD))
  continue;

  if (var_4._id_EDAD == var_1)
  continue;

  var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_E05E(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  var_4 = var_0[var_3];

  if (!isdefined(var_4.script_noteworthy))
  continue;

  if (var_4.script_noteworthy == var_1)
  continue;

  var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_78AF(var_0, var_1) {
  var_2 = _id_79C8("allies", var_0);

  if (!isdefined(var_1))
  var_3 = level.player.origin;
  else
  var_3 = var_1;

  return scripts\engine\utility::_id_7E2E(var_3, var_2);
}

_id_E0AF(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  if (!issubstr(var_0[var_3].classname, var_1))
  continue;

  var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_E0B0(var_0, var_1) {
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  if (!issubstr(var_0[var_3]._id_01F1, var_1))
  continue;

  var_2[var_2.size] = var_0[var_3];
  }

  return var_2;
}

_id_78B0(var_0, var_1, var_2) {
  var_3 = _id_79C8("allies", var_0);

  if (!isdefined(var_2))
  var_4 = level.player.origin;
  else
  var_4 = var_2;

  var_3 = _id_E0AF(var_3, var_1);
  return scripts\engine\utility::_id_7E2E(var_4, var_3);
}

_id_DA6E(var_0, var_1) {
  for (;;) {
  var_2 = _id_78AF(var_0);

  if (!isalive(var_2)) {
  wait 1;
  continue;
  }

  var_2 _id_F3B5(var_1);
  return;
  }
}

_id_9931(var_0, var_1) {
  for (;;) {
  var_2 = _id_78AF(var_0);

  if (!isalive(var_2))
  return;

  var_2 _id_F3B5(var_1);
  return;
  }
}

_id_9932(var_0, var_1, var_2) {
  for (;;) {
  var_3 = _id_78B0(var_0, var_2);

  if (!isalive(var_3))
  return;

  var_3 _id_F3B5(var_1);
  return;
  }
}

_id_DA6F(var_0, var_1, var_2) {
  for (;;) {
  var_3 = _id_78B0(var_0, var_2);

  if (!isalive(var_3)) {
  wait 1;
  continue;
  }

  var_3 _id_F3B5(var_1);
  return;
  }
}

_id_E553(var_0) {
  self _meth_8221("face angle", var_0);
  self._id_01BA = 1;
}

_id_E555() {
  self._id_01BA = 0;
}

_id_9934(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = [];

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
  var_6 = var_0[var_5];

  if (var_3 || !issubstr(var_6.classname, var_2)) {
  var_4[var_4.size] = var_6;
  continue;
  }

  var_3 = 1;
  var_6 _id_F3B5(var_1);
  }

  return var_4;
}

_id_9933(var_0, var_1) {
  var_2 = 0;
  var_3 = [];

  for (var_4 = 0; var_4 < var_0.size; var_4++) {
  var_5 = var_0[var_4];

  if (var_2) {
  var_3[var_3.size] = var_5;
  continue;
  }

  var_2 = 1;
  var_5 _id_F3B5(var_1);
  }

  return var_3;
}

_id_13624(var_0) {
  _id_0B92::_id_13634(var_0, "script_noteworthy");
}

_id_13630(var_0) {
  _id_0B92::_id_13634(var_0, "targetname");
}

_id_135D5(var_0, var_1) {
  if (scripts\engine\utility::_id_6E25(var_0))
  return;

  level endon(var_0);
  wait(var_1);
}

_id_135F1(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_13635(var_0) {
  self endon("trigger");
  wait(var_0);
}

_id_135CA(var_0, var_1) {
  var_2 = spawnstruct();
  var_3 = [];
  var_3 = scripts\engine\utility::_id_227F(var_3, getentarray(var_0, "targetname"));
  var_3 = scripts\engine\utility::_id_227F(var_3, getentarray(var_1, "targetname"));

  for (var_4 = 0; var_4 < var_3.size; var_4++)
  var_2 thread _id_0B92::_id_65FB(var_3[var_4]);

  var_2 waittill("done");
}

_id_5CC9(var_0) {
  var_1 = _id_0B77::_id_1085E(var_0);
  return var_1;
}

_id_6B47(var_0) {
  if (!isdefined(var_0))
  var_0 = self;

  var_1 = _id_0B77::_id_1085E(var_0);
  var_1 [[level._id_6B43]]();
  var_1._id_10707 = var_0._id_10708;
  var_1._id_10708 = undefined;
  var_1 thread _id_0B77::_id_E81A();
  var_1._id_02AE = var_0;
  var_1._id_ED8A = 1;

  if (isdefined(var_0._id_EE5A))
  var_1._id_C05C = var_0._id_EE5A;

  if (isdefined(var_0._id_EE5F))
  var_1._id_C089 = var_0._id_EE5F;

  return var_1;
}

_id_2C17(var_0) {
  var_1 = _id_0B77::_id_1085E(var_0);
  var_1._id_10707 = var_0._id_10708;
  var_1._id_10708 = undefined;
  var_1 thread _id_0B77::_id_E81A();
  return var_1;
}

_id_5CC8(var_0) {
  if (!isdefined(var_0))
  var_0 = self;

  var_1 = _id_0B77::_id_1085E(var_0);
  var_1 [[level._id_5C7C]]();
  var_1._id_10707 = var_0._id_10708;
  var_1._id_10708 = undefined;
  var_1 thread _id_0B77::_id_E81A();
  return var_1;
}

_id_48C1() {
  var_0 = getentarray("corpse", "script_noteworthy");

  if (var_0.size)
  _id_22C7(var_0, ::_id_9591);

  var_0 = getentarray("corpse_noragdoll", "script_noteworthy");

  if (var_0.size)
  _id_22C7(var_0, ::_id_9591);

  var_0 = _id_7C84("corpse", "script_noteworthy");

  if (var_0.size)
  _id_22C7(var_0, ::_id_9591);
}

_id_9591() {
  if (!isdefined(self._id_ECF5))
  self delete();
  else
  {
  self._id_1FBB = "corpse";
  self _meth_839E();

  if (isai(self))
  self._id_0180 = 1;
  else
  self notsolid();

  if (isdefined(self._id_0334)) {
  var_0 = scripts\engine\utility::_id_7CD1(self._id_0334);
  self dontinterpolate();

  if (isai(self))
  self _meth_80F1(var_0.origin, var_0.angles);
  else
  {
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  }
  }

  var_1 = getweaponmodel(self.weapon);

  if (isdefined(var_1) && var_1 != "") {
  if (isai(self))
  _id_86E4();
  else
  self _meth_8096(var_1, "tag_weapon_right");

  if (!isdefined(self._id_EE5A)) {
  var_2 = spawn("weapon_" + self.weapon, self gettagorigin("tag_weapon_right"));
  var_2.angles = self gettagangles("tag_weapon_right");
  }
  }

  if (isai(self)) {
  if (self.script_noteworthy == "corpse_noragdoll")
  self._id_C089 = 1;

  _id_F333(self._id_ECF5);
  self _meth_81D0();
  return;
  }

  self _meth_8018("corpse_anim", self.origin, self.angles, _id_7DC1(self._id_ECF5), "deathplant", undefined, 0);

  if (self.script_noteworthy != "corpse_noragdoll") {
  var_3 = getanimlength(_id_7DC1(self._id_ECF5));

  if (var_3 > 0)
  wait(var_3 * 0.35);

  if (isdefined(self._id_71C8))
  self [[self._id_71C8]]();

  self startragdoll();
  }
  }
}

_id_7D1E() {
  if (isdefined(self._id_ED9A))
  return self._id_ED9A;

  if (isdefined(self.script_noteworthy))
  return self.script_noteworthy;
}

_id_F340() {
  self._id_0232 = 192;
  self._id_0231 = 192;
}

_id_4793(var_0) {
  if (var_0 == "on")
  _id_61E7();
  else
  _id_5514();
}

_id_13861(var_0, var_1, var_2) {
  if (var_0 == "on") {
  self._id_1198._id_13863 = 1;

  if (isdefined(var_2)) {
  if (var_2 == "right")
  self._id_13862 = "right";
  else
  self._id_13862 = "left";
  }

  if (!isdefined(var_1))
  self._id_13864 = level.player;
  else
  {
  self._id_13864 = var_1;

  if (!isdefined(var_1.origin))
  return;
  }
  }
  else
  self._id_1198._id_13863 = 0;
}

_id_DC45(var_0) {
  if (isplayer(self)) {
  switch (var_0) {
  case "raise":
  _id_0E4B::_id_1348D();
  break;
  case "lower":
  _id_0E4B::_id_13485();
  break;
  }

  return;
  }

  if (var_0 == "raise")
  self._id_2303._id_DC48 = 1;
  else
  self._id_2303._id_DC48 = 0;

  _id_0A1E::_id_236E();
}

_id_61E7(var_0) {
  if (self.type == "dog")
  return;

  if (!isdefined(var_0))
  self._id_4797 = 1;

  self._id_0358 = 0.2;
  level thread scripts\anim\cqb::_id_6CB4();
  _id_51E1("cqb");
}

_id_5514() {
  if (self.type == "dog")
  return;

  self._id_4797 = undefined;
  self._id_0358 = 0.3;
  self._id_478F = undefined;
  _id_4145();
}

_id_622F() {
  self._id_32D4 = 1;
}

_id_5574() {
  self._id_32D4 = undefined;
}

_id_4788(var_0) {
  if (!isdefined(var_0))
  self._id_4792 = undefined;
  else
  {
  self._id_4792 = var_0;

  if (!isdefined(var_0.origin))
  return;
  }
}

_id_F3B8(var_0) {
  if (isdefined(var_0) && var_0)
  self._id_72E7 = 1;
  else
  self._id_72E7 = undefined;
}

_id_F225(var_0, var_1) {
  if (isdefined(var_1))
  self notify(var_0, var_1);
  else
  self notify(var_0);
}

_id_137A3(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_3 endon("complete");
  var_3 scripts\engine\utility::delaythread(var_2, ::_id_F225, "complete");
  self waittillmatch(var_0, var_1);
}

_id_137A4(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_3 endon("complete");
  var_3 scripts\engine\utility::delaythread(var_2, ::_id_F225, "complete");
  self waittill(var_0, var_1);
  return var_1;
}

_id_6DDE(var_0) {
  if (!isdefined(self._id_11A3F))
  self._id_11A3F = [];

  if (isdefined(self._id_11A3F[var_0._id_12BA3]))
  return 0;

  self._id_11A3F[var_0._id_12BA3] = 1;
  return 1;
}

_id_7DC1(var_0) {
  return level._id_EC85[self._id_1FBB][var_0];
}

_id_8BC9(var_0) {
  return isdefined(level._id_EC85[self._id_1FBB][var_0]);
}

_id_7DC2(var_0, var_1) {
  return level._id_EC85[var_1][var_0];
}

_id_7DC3(var_0) {
  return level._id_EC85["generic"][var_0];
}

_id_8BCA(var_0) {
  return isdefined(level._id_EC85["generic"][var_0]);
}

_id_16EB(var_0, var_1, var_2) {
  if (!isdefined(level._id_12750)) {
  level._id_12750 = [];
  level._id_1274F = [];
  }

  level._id_12750[var_0] = var_1;
  precachestring(var_1);

  if (isdefined(var_2))
  level._id_1274F[var_0] = var_2;
}

_id_41E8(var_0, var_1) {
  _func_1D1(var_0, var_1, 0);
  _func_1D1(var_1, var_0, 0);
}

_id_11813() {
  scripts\anim\combat_utility::_id_11814();
}

_id_F417(var_0) {
  self._id_0186 = var_0;
}

_id_F3E0(var_0) {
  self._id_015C = var_0;
}

_id_F2A8(var_0) {
  self._id_0030 = var_0;
}

_id_F582(var_0, var_1) {
  if (getdvarint("ai_iw7", 0) == 1) {
  var_2 = "combat";
  _id_F48E(var_2, var_0);
  self._id_E80C = level._id_EC85[self._id_1FBB][var_0];
  return;
  }

  if (isdefined(var_1))
  self._id_1D64 = var_1;
  else
  self._id_1D64 = 1;

  _id_559A();
  self._id_E80C = level._id_EC85[self._id_1FBB][var_0];
  self._id_13872 = self._id_E80C;
}

_id_F48E(var_0, var_1) {
  scripts\asm\asm::_id_237A(var_0, "move", level._id_EC85[self._id_1FBB][var_1]);
}

_id_4169(var_0) {
  scripts\asm\asm::_id_2316(var_0, "move");
}

_id_F40E(var_0, var_1) {
  scripts\asm\asm::_id_237A(var_0, "idle", level._id_EC85[self._id_1FBB][var_1]);
}

_id_415D(var_0) {
  scripts\asm\asm::_id_2316(var_0, "idle");
}

_id_F35F() {
  self._id_1491._id_BCC8 = "walk";
  self._id_55B0 = 1;
  self._id_55ED = 1;
  self._id_EE56 = 1;
}

_id_F303(var_0, var_1, var_2, var_3) {
  scripts\anim\animset::_id_950F(var_0, var_1, var_2, var_3);
}

_id_F48F(var_0, var_1, var_2) {
  var_3 = scripts\anim\utility::_id_B028(var_0);

  if (isarray(var_1)) {
  var_3["straight"] = var_1[0];
  var_3["move_f"] = var_1[0];
  var_3["move_l"] = var_1[1];
  var_3["move_r"] = var_1[2];
  var_3["move_b"] = var_1[3];
  } else {
  var_3["straight"] = var_1;
  var_3["move_f"] = var_1;
  }

  if (isdefined(var_2))
  var_3["sprint"] = var_2;

  self._id_4C8F[var_0] = var_3;
}

_id_F2C9(var_0) {
  if (!isdefined(var_0))
  var_0 = 1;

  if (isdefined(self._id_22EE))
  self._id_22EE = var_0;
  else
  return;
}

_id_412D() {
  if (isdefined(self._id_22EE))
  self._id_22EE = 1;
}

_id_C81A(var_0) {
  var_1 = _id_0A1E::_id_2357(self._id_2303._id_2123, "move_walk_loop", "casual_purpose");
  scripts\asm\asm::_id_237A(var_0, "move", var_1);

  if (var_0 == "casual")
  thread _id_F2C9(1.15);
}

_id_416A() {
  thread _id_4169(scripts\asm\asm::_id_233C());
  thread _id_412D();
}

_id_51E1(var_0) {
  if (var_0 == "cqb")
  level thread scripts\anim\cqb::_id_6CB4();

  if (self._id_238F == "soldier") {
  if (var_0 == "casual" || var_0 == "casual_walk" || var_0 == "casual_gun")
  self._id_0358 = 0.1;
  else if (var_0 == "cqb")
  self._id_0358 = 0.2;
  else
  self._id_0358 = 0.3;
  }

  self._id_51E3 = var_0;
}

_id_4145() {
  self._id_51E3 = undefined;

  if (self._id_238F == "soldier")
  self._id_0358 = 0.3;
}

_id_F3C8(var_0) {
  var_1 = level._id_EC85["generic"][var_0];

  if (isarray(var_1))
  self._id_1095A = var_1;
  else
  self._id_1095A[0] = var_1;
}

_id_13035(var_0, var_1, var_2) {
  scripts\asm\asm_bb::_id_296E(var_0);
  scripts\asm\asm_bb::_id_296F(var_1);
  var_4 = (-16, 0, 0);
  var_5 = var_0 localtoworldcoords(var_4);
  var_6 = _func_16D(var_5, var_5 + (0, 0, -72));
  var_7 = (0, var_0.angles[1], 0);

  if (isdefined(self _meth_8138()))
  self unlink();

  self _meth_80F1(var_6, var_7);
  var_8 = var_0 _meth_8138();

  if (isdefined(var_8))
  self linkto(var_8);

  var_9 = self._id_238F;
  var_10 = self._id_164D[var_9]._id_4BC0;
  var_11 = anim._id_2303[var_9]._id_10E2F[var_10];
  scripts\asm\asm::_id_2388(var_9, var_10, var_11, var_11._id_116FB);
  scripts\asm\asm::_id_238A(var_9, "script_use_turret", 0.2);
}

_id_11051() {
  scripts\asm\asm_bb::_id_296E(undefined);
  scripts\asm\asm_bb::_id_296F(undefined);
}

_id_4154() {
  self._id_1095A = undefined;
  self notify("stop_specialidle");
}

_id_F3CB(var_0, var_1) {
  _id_F3CC(var_0, undefined, var_1);
}

_id_4155() {
  self notify("movemode");
  _id_624D();
  self._id_E80C = undefined;
  self._id_13872 = undefined;
}

_id_F3CC(var_0, var_1, var_2) {
  self notify("movemode");

  if (!isdefined(var_2) || var_2)
  self._id_1D64 = 1;
  else
  self._id_1D64 = undefined;

  _id_559A();
  self._id_E80C = level._id_EC85["generic"][var_0];
  self._id_13872 = self._id_E80C;

  if (isdefined(var_1)) {
  self._id_E80B = level._id_EC85["generic"][var_1];
  self._id_13871 = self._id_E80B;
  } else {
  self._id_E80B = undefined;
  self._id_13871 = undefined;
  }
}

_id_F583(var_0, var_1, var_2) {
  self notify("movemode");

  if (!isdefined(var_2) || var_2)
  self._id_1D64 = 1;
  else
  self._id_1D64 = undefined;

  _id_559A();
  self._id_E80C = level._id_EC85[self._id_1FBB][var_0];
  self._id_13872 = self._id_E80C;

  if (isdefined(var_1)) {
  self._id_E80B = level._id_EC85[self._id_1FBB][var_1];
  self._id_13871 = self._id_E80B;
  } else {
  self._id_E80B = undefined;
  self._id_13871 = undefined;
  }
}

_id_417A() {
  self notify("clear_run_anim");
  self notify("movemode");

  if (self.type == "dog") {
  self._id_1491._id_BCC8 = "run";
  self._id_55B0 = 0;
  self._id_55ED = 0;
  self._id_EE56 = undefined;
  return;
  }

  if (getdvarint("ai_iw7", 0) == 1) {
  var_0 = "combat";
  self._id_1198._id_1D64 = 0;
  _id_4169(var_0);
  self._id_E80C = undefined;
  return;
  }

  if (!isdefined(self._id_3B17))
  _id_624D();

  self._id_1D64 = undefined;
  self._id_E80C = undefined;
  self._id_13872 = undefined;
  self._id_E80B = undefined;
  self._id_13871 = undefined;
}

_id_CB0F(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_physicsjolt");

  if (!isdefined(var_0) || !isdefined(var_1) || !isdefined(var_2)) {
  var_0 = 400;
  var_1 = 256;
  var_2 = (0, 0, 0.075);
  }

  var_3 = var_0 * var_0;
  var_4 = 3;
  var_5 = var_2;

  for (;;) {
  wait 0.1;
  var_2 = var_5;

  if (self.code_classname == "script_vehicle") {
  var_6 = self vehicle_getspeed();

  if (var_6 < var_4) {
  var_7 = var_6 / var_4;
  var_2 = var_5 * var_7;
  }
  }

  var_8 = distancesquared(self.origin, level.player.origin);
  var_7 = var_3 / var_8;

  if (var_7 > 1)
  var_7 = 1;

  var_2 = var_2 * var_7;
  var_9 = var_2[0] + var_2[1] + var_2[2];

  if (var_9 > 0.025)
  _func_16B(self.origin, var_0, var_1, var_2[2], var_2[2] * 2.0);
  }
}

_id_F3D5(var_0) {
  self _meth_82ED(var_0);
}

_id_15F1(var_0, var_1, var_2) {
  if (!isdefined(var_0))
  _id_15F2(var_2);
  else
  {
  var_3 = getentarray(var_0, var_1);
  scripts\engine\utility::_id_22D2(var_3, ::_id_15F2, var_2);
  }
}

_id_15F2(var_0) {
  if (isdefined(self._id_ED33)) {
  self._id_1605 = 1;
  _id_0B13::_id_159B("allies");
  }

  if (isdefined(self._id_ED34)) {
  self._id_1605 = 1;
  _id_0B13::_id_159B("axis");
  }

  self notify("trigger", var_0);
}

_id_F1DE() {
  self delete();
}

_id_8B6C() {
  if (_id_0B13::_id_7CE4() == "axis")
  return isdefined(self._id_ED34) || isdefined(self._id_EDAD);

  return isdefined(self._id_ED33) || isdefined(self._id_EDAD);
}

_id_413D() {
  _id_4186("axis");
  _id_4186("allies");
}

_id_4186(var_0) {
  level._id_4BE0[var_0]["r"] = undefined;
  level._id_4BE0[var_0]["b"] = undefined;
  level._id_4BE0[var_0]["c"] = undefined;
  level._id_4BE0[var_0]["y"] = undefined;
  level._id_4BE0[var_0]["p"] = undefined;
  level._id_4BE0[var_0]["o"] = undefined;
  level._id_4BE0[var_0]["g"] = undefined;
}

_id_C12D(var_0, var_1) {
  self endon("death");

  if (var_1 > 0)
  wait(var_1);

  if (!isdefined(self))
  return;

  self notify(var_0);
}

_id_BE49() {
  self._id_C3FB = self.name;
  self.name = "";
}

_id_BE4A() {
  self.name = self._id_C3FB;
}

_id_86E4() {
  if (isai(self))
  scripts\anim\shared::_id_CC2C(self.weapon, "none");
  else
  self _meth_8096(getweaponmodel(self.weapon), "tag_weapon_right");
}

_id_86E2() {
  if (isai(self))
  scripts\anim\shared::_id_CC2C(self.weapon, "right");
  else
  self attach(getweaponmodel(self.weapon), "tag_weapon_right");
}

_id_CC06(var_0, var_1) {
  if (!scripts\anim\utility::_id_1A18(var_0))
  scripts\anim\init::_id_98E1(var_0);

  scripts\anim\shared::_id_CC2C(var_0, var_1);
}

_id_72EC(var_0, var_1) {
  if (!scripts\anim\init::_id_A000(var_0))
  scripts\anim\init::_id_98E1(var_0);

  var_2 = self.weapon != "none";
  var_3 = scripts\anim\utility_common::_id_9FCA();
  var_4 = var_1 == "sidearm";
  var_5 = var_1 == "secondary";

  if (var_2 && var_3 != var_4) {
  if (var_3)
  var_6 = "none";
  else if (var_5)
  var_6 = "back";
  else
  var_6 = "chest";

  scripts\anim\shared::_id_CC2C(self.weapon, var_6);
  self._id_AA45 = self.weapon;
  }
  else
  self._id_AA45 = var_0;

  scripts\anim\shared::_id_CC2C(var_0, "right");

  if (var_4)
  self._id_101B4 = var_0;
  else if (var_5)
  self._id_F0C4 = var_0;
  else
  self.primaryweapon = var_0;

  self.weapon = var_0;
  self._id_3250 = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

_id_D1FD(var_0) {
  var_1 = level.player.origin;

  for (;;) {
  if (distance(var_1, level.player.origin) > var_0)
  break;

  wait 0.05;
  }
}

_id_13763(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  thread _id_0B92::_id_13764(var_4, var_0, var_1);
  thread _id_0B92::_id_13764(var_4, var_2, var_3);
  var_4 waittill("done");
}

_id_137AA(var_0) {
  self waittill(var_0);
}

_id_56BA(var_0, var_1, var_2, var_3) {
  var_4 = _id_7B92();

  if (isdefined(level._id_1274F[var_0])) {
  if (var_4 [[level._id_1274F[var_0]]]())
  return;

  var_4 thread _id_0B92::_id_9021(level._id_12750[var_0], level._id_1274F[var_0], var_1, var_2, var_3);
  }
  else
  var_4 thread _id_0B92::_id_9021(level._id_12750[var_0]);
}

_id_56BE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_7B92();

  if (isdefined(level._id_1274F[var_0]) && var_5 [[level._id_1274F[var_0]]]())
  return;

  var_1 = scripts\engine\utility::ter_op(isdefined(var_1), var_1, 6);
  var_5 thread _id_0B92::_id_9021(level._id_12750[var_0], level._id_1274F[var_0], var_2, var_3, var_4, var_1);
}

_id_56BF(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_7B92();

  if (isdefined(level._id_1274F[var_0]) && var_6 [[level._id_1274F[var_0]]]())
  return;

  var_1 = scripts\engine\utility::ter_op(isdefined(var_1), var_1, 6);
  var_6 thread _id_0B92::_id_9021(level._id_12750[var_0], level._id_1274F[var_0], var_3, var_4, var_5, var_1, var_2);
}

_id_56BB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if (!isdefined(var_6))
  var_6 = 0;

  var_10 = _id_0B92::_id_900D(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  _id_56BA(var_10, var_7, var_8, var_9);
  thread _id_0B92::_id_900E(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_56BC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if (!isdefined(var_7))
  var_7 = 0;

  var_11 = _id_0B92::_id_900D(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
  thread _id_56BE(var_11, var_1, var_8, var_9, var_10);
  thread _id_0B92::_id_900E(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_56BD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if (!isdefined(var_8))
  var_8 = 0;

  var_12 = _id_0B92::_id_900D(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
  thread _id_56BF(var_12, var_1, var_2, var_9, var_10, var_11);
  thread _id_0B92::_id_900E(var_0, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_7ECF(var_0) {
  return level._id_EC85["generic"][var_0];
}

_id_61E3() {
  self._id_ED27 = 1;
}

_id_550D() {
  self._id_ED27 = 0;
  self notify("stop_being_careful");
}

_id_623B() {
  self._id_10AB7 = 1;
}

_id_5588() {
  self._id_10AB7 = undefined;
}

_id_550C() {
  self._id_55B5 = 1;
}

_id_61DF() {
  self._id_55B5 = undefined;
}

_id_F39F() {
  self._id_0132 = 1;
}

_id_F39E() {
  self._id_0132 = 0;
}

_id_10619(var_0, var_1) {
  if (isdefined(self._id_ED52)) {
  self endon("death");
  wait(self._id_ED52);
  }

  var_2 = undefined;
  var_3 = isdefined(self._id_EED1) && scripts\engine\utility::_id_6E25("stealth_enabled") && !scripts\engine\utility::_id_6E25("stealth_spotted");

  if (isdefined(self._id_ED6E))
  var_2 = _id_5CC8(self);
  else if (isdefined(self._id_ED8A))
  var_2 = _id_6B47(self);
  else if (isdefined(self._id_ED1B))
  var_2 = _id_2C17(self);
  else if (isdefined(self._id_EDB3) || isdefined(var_0))
  var_2 = self _meth_8393(var_3);
  else
  var_2 = self _meth_80B5(var_3);

  if (isdefined(var_1) && var_1 && isalive(var_2))
  var_2 _id_B14F();

  if (!isdefined(self._id_ED6E) && !isdefined(self._id_ED8A) && !isdefined(self._id_ED1B))
  _id_106ED(var_2);

  if (isdefined(self._id_EEB5))
  self delete();

  return var_2;
}

_id_74D7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnstruct();
  var_6 thread _id_0B92::_id_74DB(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return _id_0B92::_id_74DF(var_6);
}

_id_74DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnstruct();
  var_7 thread _id_0B92::_id_74DB(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if (isdefined(var_7._id_74DA) || var_7 scripts\engine\utility::_id_13736(var_0, "function_stack_func_begun") != "timeout")
  return _id_0B92::_id_74DF(var_7);
  else
  {
  var_7 notify("death");
  return 0;
  }
}

_id_74D9() {
  var_0 = [];

  if (isdefined(self._id_74D7[0]) && isdefined(self._id_74D7[0]._id_74DA))
  var_0[0] = self._id_74D7[0];

  self._id_74D7 = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if (!var_0.size)
  return;

  if (!var_0[0]._id_74DA)
  return;

  self._id_74D7 = var_0;
}

_id_5528() {
  self._id_55ED = 1;
}

_id_61F7() {
  self._id_55ED = undefined;
}

_id_559A() {
  self._id_C189 = 1;
}

_id_624D() {
  self._id_C189 = undefined;
}

_id_5504() {
  self._id_55B0 = 1;
}

_id_61DB() {
  self endon("death");
  waittillframeend;
  self._id_55B0 = undefined;
}

_id_F2E1(var_0, var_1) {
  _func_1A7(var_0, var_1);
}

_id_F3DD(var_0) {
  self._id_015C = var_0;
}

_id_F3D9(var_0) {
  self._id_A906 = var_0;
  self._id_A907 = undefined;
  self._id_A905 = undefined;
  self _meth_82EE(var_0);
}

_id_F3DA(var_0) {
  var_1 = getnode(var_0, "targetname");
  _id_F3D9(var_1);
}

_id_F3DC(var_0) {
  self._id_A906 = undefined;
  self._id_A907 = var_0;
  self._id_A905 = undefined;
  self _meth_82EF(var_0);
}

_id_F3D3(var_0) {
  _id_F3DC(var_0.origin);
  self._id_A905 = var_0;

  if (_func_2A4(var_0) && !isdefined(var_0.type))
  var_0.type = "struct";
}

_id_C27C(var_0) {
  objective_state(var_0, "done");
  level notify("objective_complete" + var_0);
}

_id_7C84(var_0, var_1) {
  var_2 = _func_0C8();
  var_3 = [];

  if (var_1 == "code_classname") {
  foreach (var_5 in var_2) {
  if (isdefined(var_5.code_classname) && var_5.code_classname == var_0)
  var_3[var_3.size] = var_5;
  }
  }
  else if (var_1 == "classname") {
  foreach (var_5 in var_2) {
  if (isdefined(var_5.classname) && var_5.classname == var_0)
  var_3[var_3.size] = var_5;
  }
  }
  else if (var_1 == "target") {
  foreach (var_5 in var_2) {
  if (isdefined(var_5._id_0334) && var_5._id_0334 == var_0)
  var_3[var_3.size] = var_5;
  }
  }
  else if (var_1 == "script_linkname") {
  foreach (var_5 in var_2) {
  if (isdefined(var_5._id_027C) && var_5._id_027C == var_0)
  var_3[var_3.size] = var_5;
  }
  }
  else if (var_1 == "script_noteworthy") {
  foreach (var_5 in var_2) {
  if (isdefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_0)
  var_3[var_3.size] = var_5;
  }
  }
  else if (var_1 == "targetname") {} else {}

  return var_3;
}

_id_22C6(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = 0;

  var_3 = [];

  foreach (var_5 in var_0) {
  var_5._id_00C1 = 1;

  if (getsubstr(var_5.classname, 7, 10) == "veh") {
  var_6 = var_5 _id_10808();

  if (isdefined(var_6._id_0334) && !isdefined(var_6._id_EE2B))
  var_6 thread _id_0B98::_id_845A();

  var_3[var_3.size] = var_6;
  continue;
  }

  var_6 = var_5 _id_10619(var_1);

  if (!var_2) {}

  var_3[var_3.size] = var_6;
  }

  if (!var_2) {}

  return var_3;
}

_id_22CD(var_0, var_1, var_2, var_3) {
  var_4 = _func_0C8(var_0);
  var_4 = _id_22A2(var_4, getentarray(var_0, "targetname"));

  if (isdefined(level._id_107A7)) {
  var_5 = scripts\engine\utility::_id_8180(var_0, "targetname");

  if (isdefined(var_3) && var_3)
  _id_51D6(var_5);

  var_6 = _id_0B77::_id_7BC6(var_5);
  var_4 = scripts\engine\utility::_id_227F(var_4, var_6);
  }

  return _id_22C6(var_4, var_1, var_2);
}

_id_22CB(var_0, var_1, var_2, var_3) {
  var_4 = _id_7C84(var_0, "script_noteworthy");
  var_4 = _id_22A2(var_4, getentarray(var_0, "script_noteworthy"));

  if (isdefined(level._id_107A7)) {
  var_5 = scripts\engine\utility::_id_8180(var_0, "script_noteworthy");

  if (isdefined(var_3) && var_3)
  _id_51D6(var_5);

  var_6 = _id_0B77::_id_7BC6(var_5);
  var_4 = scripts\engine\utility::_id_227F(var_4, var_6);
  }

  return _id_22C6(var_4, var_1, var_2);
}

_id_107CD(var_0, var_1) {
  var_2 = _func_0C7(var_0, "script_noteworthy");
  var_3 = var_2 _id_10619(var_1);
  return var_3;
}

_id_107EA(var_0, var_1) {
  var_2 = _func_0C7(var_0, "targetname");
  var_3 = var_2 _id_10619(var_1);
  return var_3;
}

_id_16C5(var_0, var_1, var_2) {
  if (getdvarint("loc_warnings", 0))
  return;

  if (!isdefined(level._id_545A))
  level._id_545A = [];

  if (level._id_545A.size == 5) {
  var_3 = level._id_545A[0];
  level._id_545A = _id_22B0(level._id_545A, 0);
  _id_12DB1();
  var_3 thread _id_52A5();
  }

  var_4 = "^3";

  if (isdefined(var_2)) {
  switch (var_2) {
  case "red":
  case "r":
  var_4 = "^1";
  break;
  case "green":
  case "g":
  var_4 = "^2";
  break;
  case "yellow":
  case "y":
  var_4 = "^3";
  break;
  case "blue":
  case "b":
  var_4 = "^4";
  break;
  case "cyan":
  case "c":
  var_4 = "^5";
  break;
  case "purple":
  case "p":
  var_4 = "^6";
  break;
  case "white":
  case "w":
  var_4 = "^7";
  break;
  case "bl":
  case "black":
  var_4 = "^8";
  break;
  }
  }

  var_5 = _id_0B3F::_id_49B2("default", 1);
  var_6 = level._id_545A.size;
  level._id_545A[var_6] = var_5;
  var_5._id_0142 = 1;
  var_5._id_02A4 = 20;
  var_5.x = 40;
  var_5.y = 260 + var_6 * 12;
  var_5._id_01AD = "" + var_4 + var_0 + ": ^7" + var_1;
  var_5.alpha = 0;
  var_5 fadeovertime(0.2);
  var_5.alpha = 1;
  var_5 endon("death");
  wait 8;
  level._id_545A = scripts\engine\utility::array_remove(level._id_545A, var_5);
  _id_12DB1();
  var_5 thread _id_52A5();
}

_id_52A5() {
  self endon("death");
  self fadeovertime(0.2);
  self _meth_820C(0.2);
  self.y = self.y - 12;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

_id_12DB1() {
  level._id_545A = scripts\engine\utility::_id_22BC(level._id_545A);

  foreach (var_2, var_1 in level._id_545A) {
  var_1 _meth_820C(0.2);
  var_1.y = 260 + var_2 * 12;
  }
}

_id_F3E6(var_0) {
  self._id_0162 = var_0;
}

_id_7B91() {
  var_0 = self.origin;
  var_1 = anglestoup(self getplayerangles());
  var_2 = self _meth_8157();
  var_3 = var_0 + (0, 0, var_2);
  var_4 = var_0 + var_1 * var_2;
  var_5 = var_3 - var_4;
  var_6 = var_0 + var_5;
  return var_6;
}

_id_F2D8(var_0) {
  self._id_2894 = var_0;
}

_id_F305() {
  if (!scripts\engine\utility::_id_16F3("platform", ::_id_F305))
  return;

  if (!isdefined(level._id_4542))
  level._id_4542 = getdvar("consoleGame") == "true";
  else
  {}

  if (!isdefined(level._id_13E0F))
  level._id_13E0F = getdvar("xenonGame") == "true";
  else
  {}

  if (!isdefined(level._id_DADB))
  level._id_DADB = getdvar("ps3Game") == "true";
  else
  {}

  if (!isdefined(level._id_13E0E))
  level._id_13E0E = getdvar("xb3Game") == "true";
  else
  {}

  if (!isdefined(level._id_DADC))
  level._id_DADC = getdvar("ps4Game") == "true";
  else
  {}
}

_id_9BEE() {
  if (level._id_13E0E || level._id_DADC || !level._id_4542)
  return 1;
  else
  return 0;
}

_id_266F(var_0) {
  return _id_0B0E::_id_1190(var_0);
}

_id_2670() {
  return _id_0B0E::_id_1190(1);
}

_id_F3C7(var_0) {
  self._id_4E2A = _id_7ECF(var_0);
}

_id_F333(var_0) {
  self._id_4E2A = _id_7DC1(var_0);
}

_id_4141() {
  self._id_4E2A = undefined;
}

_id_DB36() {
  scripts\anim\shared::_id_CC2C(self.weapon, "none");
  self.weapon = "none";
}

_id_1F53() {
  self _meth_83A1();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self notify("stop_animmode");
}

_id_5564() {
  self._id_1491._id_5605 = 1;
  self._id_0033 = 0;
}

_id_6224() {
  self._id_1491._id_5605 = 0;
  self._id_0033 = 1;
}

_id_2011(var_0) {
  self._id_1C78 = var_0;
}

_id_200C() {
  self._id_1C78 = undefined;
}

_id_200D(var_0, var_1) {
  if (var_1) {
  if (!isdefined(level._id_2006._id_5602) || level._id_2006._id_5602.size == 0 || var_0 == "all") {
  level._id_2006._id_5602 = [];
  level._id_2006._id_5602[0] = var_0;
  }
  else if (level._id_2006._id_5602[0] != "all")
  level._id_2006._id_5602 = scripts\engine\utility::_id_2284(level._id_2006._id_5602, [var_0]);
  } else {
  if (!isdefined(level._id_2006._id_5602) || level._id_2006._id_5602.size == 0)
  return;

  if (var_0 == "all")
  level._id_2006._id_5602 = undefined;
  else if (level._id_2006._id_5602[0] == "all") {
  level._id_2006._id_5602 = [];

  if (var_0 == "allies")
  level._id_2006._id_5602[0] = "axis";
  else
  level._id_2006._id_5602[0] = "allies";
  } else {
  level._id_2006._id_5602 = scripts\engine\utility::_id_22AC(level._id_2006._id_5602, [var_0]);
  return;
  }
  }
}

_id_A62F() {
  self _meth_80CB(0);
  self _meth_81D0();
  return 1;
}

_id_22D8(var_0, var_1, var_2) {
  var_3 = getarraykeys(var_0);
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++)
  var_6 = var_3[var_5];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
  var_6 = var_3[var_5];
  var_4[var_6] = spawnstruct();
  var_4[var_6]._id_1187 = 1;
  var_4[var_6] thread _id_0B92::_id_22D9(var_0[var_6], var_1, var_2);
  }

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
  var_6 = var_3[var_5];

  if (isdefined(var_0[var_6]) && var_4[var_6]._id_1187)
  var_4[var_6] waittill("_array_wait");
  }
}

_id_54C6() {
  self _meth_81D0((0, 0, 0));
}

_id_7FBC(var_0) {
  return level._id_EC8C[var_0];
}

_id_9D27() {
  return self playerads() > 0.5;
}

_id_5575() {
  self._id_E198 = undefined;
  self notify("_disable_reinforcement");
}

_id_137DF(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (!isdefined(var_5))
  var_5 = level.player;

  var_6 = spawnstruct();

  if (isdefined(var_3))
  var_6 thread _id_C12D("timeout", var_3);

  var_6 endon("timeout");

  if (!isdefined(var_0))
  var_0 = 0.92;

  if (!isdefined(var_1))
  var_1 = 0;

  var_7 = int(var_1 * 20);
  var_8 = var_7;
  self endon("death");
  var_9 = isai(self);
  var_10 = undefined;

  for (;;) {
  if (var_9)
  var_10 = self geteye();
  else
  var_10 = self.origin;

  if (var_5 _id_D1DF(var_10, var_0, var_2, var_4)) {
  var_8--;

  if (var_8 <= 0)
  return 1;
  }
  else
  var_8 = var_7;

  wait 0.05;
  }
}

_id_137E1(var_0, var_1, var_2, var_3) {
  _id_137DF(var_1, var_0, var_2, undefined, var_3);
}

_id_D1DF(var_0, var_1, var_2, var_3) {
  if (!isdefined(var_1))
  var_1 = 0.8;

  var_4 = _id_7B92();
  var_5 = var_4 geteye();
  var_6 = vectortoangles(var_0 - var_5);
  var_7 = anglestoforward(var_6);
  var_8 = var_4 getplayerangles();
  var_9 = anglestoforward(var_8);
  var_10 = vectordot(var_7, var_9);

  if (var_10 < var_1)
  return 0;

  if (isdefined(var_2))
  return 1;

  var_11 = bullettrace(var_0, var_5, 0, var_3);
  return var_11["fraction"] == 1;
}

_id_6001(var_0, var_1, var_2, var_3) {
  for (var_4 = 0; var_4 < level.players.size; var_4++) {
  if (level.players[var_4] _id_D1DF(var_0, var_1, var_2, var_3))
  return 1;
  }

  return 0;
}

_id_D63A(var_0) {
  var_1 = _id_7B92();
  var_2 = vectortoangles(var_0 - var_1 geteye());
  var_3 = anglestoforward(var_2);
  var_4 = var_1 getplayerangles();
  var_5 = anglestoforward(var_4);
  var_6 = vectorcross(var_3, var_5);

  if (var_6[2] < 0)
  return "left";
  else
  return "right";
}

_id_CFAC(var_0, var_1) {
  var_2 = gettime();

  if (!isdefined(var_1))
  var_1 = 0;

  if (isdefined(var_0._id_D412) && var_0._id_D412 + var_1 >= var_2)
  return var_0._id_D411;

  var_0._id_D412 = var_2;

  if (!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
  var_0._id_D411 = 0;
  return 0;
  }

  var_3 = level.player geteye();
  var_4 = var_0.origin;

  if (sighttracepassed(var_3, var_4, 1, level.player, var_0)) {
  var_0._id_D411 = 1;
  return 1;
  }

  var_5 = var_0 geteye();

  if (sighttracepassed(var_3, var_5, 1, level.player, var_0)) {
  var_0._id_D411 = 1;
  return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if (sighttracepassed(var_3, var_6, 1, level.player, var_0)) {
  var_0._id_D411 = 1;
  return 1;
  }

  var_0._id_D411 = 0;
  return 0;
}

_id_D40E(var_0, var_1) {
  var_2 = var_0 * var_0;

  for (var_3 = 0; var_3 < level.players.size; var_3++) {
  if (distancesquared(var_1, level.players[var_3].origin) < var_2)
  return 1;
  }

  return 0;
}

_id_1938(var_0, var_1) {
  if (!isdefined(var_0))
  return;

  var_2 = 0.75;

  while (var_0.size > 0) {
  wait 1;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  if (!isdefined(var_0[var_3]) || !isalive(var_0[var_3])) {
  var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_3]);
  continue;
  }

  if (_id_D40E(var_1, var_0[var_3].origin))
  continue;

  if (_id_6001(var_0[var_3].origin + (0, 0, 48), var_2, 1))
  continue;

  if (isdefined(var_0[var_3]._id_B14F))
  var_0[var_3] _id_1101B();

  var_0[var_3] delete();
  var_0 = scripts\engine\utility::array_remove(var_0, var_0[var_3]);
  }
  }
}

_id_178D(var_0, var_1, var_2, var_3) {
  _id_97A2();
  var_4 = spawnstruct();
  var_4._id_376B = self;
  var_4._id_74C2 = var_0;
  var_4._id_C8FD = [];

  if (isdefined(var_1))
  var_4._id_C8FD[var_4._id_C8FD.size] = var_1;

  if (isdefined(var_2))
  var_4._id_C8FD[var_4._id_C8FD.size] = var_2;

  if (isdefined(var_3))
  var_4._id_C8FD[var_4._id_C8FD.size] = var_3;

  if (!isdefined(level._id_13711._id_13590))
  level._id_13711._id_13590 = [var_4];
  else
  level._id_13711._id_13590[level._id_13711._id_13590.size] = var_4;
}

_id_168D(var_0, var_1, var_2, var_3) {
  _id_97A2();
  var_4 = spawnstruct();
  var_4._id_376B = self;
  var_4._id_74C2 = var_0;
  var_4._id_C8FD = [];

  if (isdefined(var_1))
  var_4._id_C8FD[var_4._id_C8FD.size] = var_1;

  if (isdefined(var_2))
  var_4._id_C8FD[var_4._id_C8FD.size] = var_2;

  if (isdefined(var_3))
  var_4._id_C8FD[var_4._id_C8FD.size] = var_3;

  level._id_13711._id_1523[level._id_13711._id_1523.size] = var_4;
}

_id_16DB(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_97A2();
  var_6 = spawnstruct();
  var_6._id_376B = self;
  var_6._id_74C2 = var_0;
  var_6._id_C8FD = [];

  if (isdefined(var_1))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_1;

  if (isdefined(var_2))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_2;

  if (isdefined(var_3))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_3;

  if (isdefined(var_4))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_4;

  if (isdefined(var_5))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_5;

  level._id_13711._id_E7F9[level._id_13711._id_E7F9.size] = var_6;
}

_id_16AA(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_97A2();
  var_6 = spawnstruct();
  var_6._id_376B = self;
  var_6._id_74C2 = var_0;
  var_6._id_C8FD = [];

  if (isdefined(var_1))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_1;

  if (isdefined(var_2))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_2;

  if (isdefined(var_3))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_3;

  if (isdefined(var_4))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_4;

  if (isdefined(var_5))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_5;

  level._id_13711._id_E7E0[level._id_13711._id_E7E0.size] = var_6;
}

_id_171F(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_97A2();
  var_6 = spawnstruct();
  var_6._id_74C2 = var_0;
  var_6._id_C8FD = [];

  if (isdefined(var_1))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_1;

  if (isdefined(var_2))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_2;

  if (isdefined(var_3))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_3;

  if (isdefined(var_4))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_4;

  if (isdefined(var_5))
  var_6._id_C8FD[var_6._id_C8FD.size] = var_5;

  level._id_13711._id_E80A[level._id_13711._id_E80A.size] = var_6;
}

_id_16CD(var_0) {
  _id_97A2();
  var_1 = spawnstruct();
  var_1._id_376B = self;
  var_1._id_6317 = var_0;
  level._id_13711._id_57D7[level._id_13711._id_57D7.size] = var_1;
}

_id_57D6() {
  _id_97A2();
  _id_57D5(level._id_13711._id_13590.size - 1);
}

_id_57D5(var_0) {
  _id_97A2();

  if (!isdefined(var_0))
  var_0 = 0;

  var_1 = spawnstruct();
  var_2 = level._id_13711._id_13590;
  var_3 = level._id_13711._id_57D7;
  var_4 = level._id_13711._id_E7F9;
  var_5 = level._id_13711._id_E7E0;
  var_6 = level._id_13711._id_E80A;
  var_7 = level._id_13711._id_1523;
  level._id_13711._id_13590 = [];
  level._id_13711._id_E7F9 = [];
  level._id_13711._id_57D7 = [];
  level._id_13711._id_1523 = [];
  level._id_13711._id_E7E0 = [];
  level._id_13711._id_E80A = [];
  var_1._id_00C1 = var_2.size;
  var_1 scripts\engine\utility::_id_22A1(var_2, _id_0B92::_id_13774, var_3);
  var_1 thread _id_0B92::_id_5767(var_7);
  var_1 endon("any_funcs_aborted");

  for (;;) {
  if (var_1._id_00C1 <= var_0)
  break;

  var_1 waittill("func_ended");
  }

  var_1 notify("all_funcs_ended");
  scripts\engine\utility::_id_22A1(var_4, _id_0B92::_id_68CE, []);
  scripts\engine\utility::_id_22A1(var_5, _id_0B92::_id_68CC);
  scripts\engine\utility::_id_22A1(var_6, _id_0B92::_id_68CD);
}

_id_578A() {
  var_0 = spawnstruct();
  var_1 = level._id_13711._id_E7F9;
  level._id_13711._id_E7F9 = [];

  foreach (var_3 in var_1)
  level _id_0B92::_id_68CE(var_3, []);

  var_0 notify("all_funcs_ended");
}

_id_9BB5() {
  if (isdefined(level._id_72AD) && level._id_72AD == 1)
  return 0;

  if (isdefined(level._id_501A) && level._id_501A == level._id_10CDA)
  return 1;

  if (isdefined(level._id_5019) && level._id_5019 == level._id_10CDA)
  return 1;

  if (isdefined(level._id_5018))
  return level._id_10CDA == "default";

  if (_id_0B79::_id_ABDA())
  return level._id_10CDA == level._id_10C58[0]["name"];

  return level._id_10CDA == "default";
}

_id_13BBF(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if (isdefined(var_1))
  var_2 = 1;

  if (isdefined(var_0)) {
  scripts\engine\utility::_id_6E27(var_0);
  level endon(var_0);
  }

  for (;;) {
  wait(randomfloatrange(0.15, 0.3));
  var_3 = self.origin + (0, 0, 150);
  var_4 = self.origin - (0, 0, 150);
  var_5 = bullettrace(var_3, var_4, 0, undefined);

  if (var_5["surfacetype"] != "water")
  continue;

  var_6 = "water_movement";

  if (isplayer(self)) {
  if (distance(self _meth_816B(), (0, 0, 0)) < 5)
  var_6 = "water_stop";
  }
  else if (isdefined(level._effect["water_" + self._id_1491._id_BCC8]))
  var_6 = "water_" + self._id_1491._id_BCC8;

  var_7 = scripts\engine\utility::_id_7ECB(var_6);
  var_3 = var_5["position"];
  var_8 = (0, self.angles[1], 0);
  var_9 = anglestoforward(var_8);
  var_10 = anglestoup(var_8);
  playfx(var_7, var_3, var_10, var_9);

  if (var_6 != "water_stop" && var_2)
  thread scripts\engine\utility::_id_CE2B(var_1, var_3);
  }
}

_id_B317(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if (!isdefined(var_1))
  var_1 = (0, 0, 0);

  for (;;) {
  self.origin = var_0.origin + var_1;
  self.angles = var_0.angles;
  wait 0.05;
  }
}

_id_BF95(var_0) {
  _id_0B28::_id_1355(var_0);
}

_id_BF97(var_0, var_1, var_2) {
  if (!scripts\engine\utility::_id_6E34("nextmission_preload_complete"))
  scripts\engine\utility::_id_6E39("nextmission_preload_complete");

  scripts\engine\utility::_id_6E2A("nextmission_preload_complete");
  _id_0B28::_id_1356(var_0, var_1, var_2);
  scripts\engine\utility::_id_6E3E("nextmission_preload_complete");
}

_id_BF98() {
  _id_0B28::_id_1357();
}

_id_CE6D(var_0) {}

_id_7F6E(var_0) {
  return _id_0B28::_id_12B0(var_0);
}

_id_7E2C(var_0) {
  return _id_0B28::_id_12AF(var_0);
}

_id_7F70(var_0) {
  return _id_0B28::_id_12B1(var_0);
}

_id_13705(var_0) {
  if (!isdefined(var_0))
  var_0 = level.script;

  _id_0B28::_id_1455(var_0);
}

_id_13C3C(var_0) {
  _id_0B28::_id_1463(var_0);
}

_id_13C60() {
  _id_0B28::_id_1464();
}

_id_B263(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_5[var_5.size] = var_0;

  if (isdefined(var_1))
  var_5[var_5.size] = var_1;

  if (isdefined(var_2))
  var_5[var_5.size] = var_2;

  if (isdefined(var_3))
  var_5[var_5.size] = var_3;

  if (isdefined(var_4))
  var_5[var_5.size] = var_4;

  return var_5;
}

_id_6AC4() {
  level._id_6AD2 = 1;
}

_id_C08C() {
  level._id_6AD2 = 0;
}

_id_806D() {
  var_0 = self _meth_8173();
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
  var_3 = var_0[var_2];
  var_1[var_3] = self getweaponammoclip(var_3);
  }

  var_4 = 0;

  if (isdefined(var_1["claymore"]) && var_1["claymore"] > 0)
  var_4 = var_1["claymore"];

  return var_4;
}

_id_1454(var_0) {
  wait(var_0);
}

_id_AB9A(var_0, var_1, var_2) {
  var_3 = getdvarfloat(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  if (var_6 > 0) {
  for (var_7 = var_4 / var_6; var_6; var_6--) {
  var_3 = var_3 + var_7;
  _func_1C5(var_0, var_3);
  wait(var_5);
  }
  }

  _func_1C5(var_0, var_1);
}

_id_AB89(var_0, var_1, var_2, var_3) {
  var_4 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_5 = var_1 - var_4;
  var_6 = 0.05;
  var_7 = int(var_2 / var_6);

  for (var_8 = var_5 / var_7; var_7; var_7--) {
  var_4 = var_4 + var_8;

  if (isdefined(var_3)) {
  var_9 = _id_E753(var_4, var_3);
  setomnvar(var_0, var_9);
  }
  else
  setomnvar(var_0, var_4);

  wait(var_6);
  }

  if (isdefined(var_3)) {
  var_9 = _id_E753(var_1, var_3);
  setomnvar(var_0, var_9);
  }
  else
  setomnvar(var_0, var_1);
}

_id_AB8B(var_0, var_1, var_2) {
  var_3 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for (var_7 = var_4 / var_6; var_6; var_6--) {
  var_3 = var_3 + var_7;
  setomnvar(var_0, int(var_3));
  wait(var_5);
  }

  setomnvar(var_0, int(var_1));
}

_id_AB9B(var_0, var_1, var_2, var_3) {
  if (_id_9BEE())
  _id_AB9A(var_0, var_2, var_3);
  else
  _id_AB9A(var_0, var_1, var_3);
}

_id_834F(var_0, var_1) {
  if (_id_9BB7())
  return;

  if (!isdefined(var_1))
  var_1 = 0;

  if (!var_1 && _id_9C32())
  return;

  level.player _meth_817A(var_0);
}

_id_D0A1(var_0) {
  if (_id_9BB7())
  return;

  if (_id_9C32())
  return;

  self _meth_817A(var_0);
}

_id_10327(var_0) {
  level._id_1031B._id_1098F = var_0;
}

_id_10326(var_0) {
  level._id_1031B._id_1098C = var_0;
}

_id_10324(var_0) {
  level._id_1031B._id_ABA1 = var_0;
}

_id_10325(var_0) {
  level._id_1031B._id_ABA2 = var_0;
}

_id_10321() {
  if (isdefined(level._id_C014) && level._id_C014)
  return;

  _id_0B0B::_id_F5A0();
  setslowmotion(level._id_1031B._id_1098C, level._id_1031B._id_1098F, level._id_1031B._id_ABA1);
}

_id_10322() {
  if (isdefined(level._id_C014) && level._id_C014)
  return;

  setslowmotion(level._id_1031B._id_1098F, level._id_1031B._id_1098C, level._id_1031B._id_ABA2);
  _id_0B0B::_id_F59F();
}

_id_16CC(var_0, var_1, var_2, var_3) {
  level._id_5FC6[var_0]["magnitude"] = var_1;
  level._id_5FC6[var_0]["duration"] = var_2;
  level._id_5FC6[var_0]["radius"] = var_3;
}

_id_BDF2(var_0, var_1, var_2) {
  level._id_1188._id_A90A = var_0;

  if (!isdefined(var_1))
  var_1 = 1;

  if (!isdefined(var_2))
  var_2 = 0;

  _func_146(0);
  _func_145(var_0, 0, 1.0, 1, var_2);
}

_id_BDDF(var_0, var_1, var_2, var_3, var_4) {
  thread _id_0B92::_id_BDE1(var_0, var_1, var_2, var_3, var_4);
}

_id_BDE3(var_0, var_1, var_2, var_3, var_4) {
  thread _id_0B92::_id_BDE1(var_0, var_1, var_2, var_3, var_4, 1);
}

_id_BDE5(var_0, var_1, var_2, var_3) {
  if (isdefined(var_1) && var_1 > 0) {
  thread _id_0B92::_id_BDE6(var_0, var_1, var_2, var_3);
  return;
  }

  _id_BDEC();
  _id_BDF2(var_0, var_2, var_3);
}

_id_BDD5(var_0, var_1, var_2, var_3) {
  if (!isdefined(var_2))
  var_2 = 1;

  if (!isdefined(var_3))
  var_3 = 0;

  if (isdefined(level._id_1188._id_A90A))
  _func_146(var_1, level._id_1188._id_A90A, var_3);
  else
  {}

  level._id_1188._id_A90A = var_0;
  _func_145(var_0, var_1, var_2, 0, var_3);
  level endon("stop_music");
  wait(var_1);
  level notify("done_crossfading");
}

_id_BDEC(var_0) {
  if (!isdefined(var_0) || var_0 <= 0)
  _func_146();
  else
  _func_146(var_0);

  level notify("stop_music");
}

_id_D121() {
  var_0 = getentarray("grenade", "classname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
  var_2 = var_0[var_1];

  if (var_2._id_01F1 == "weapon_claymore")
  continue;

  if (isdefined(var_2._id_C182))
  continue;

  for (var_3 = 0; var_3 < level.players.size; var_3++) {
  var_4 = level.players[var_3];

  if (distancesquared(var_2.origin, var_4.origin) < 75625)
  return 1;
  }
  }

  return 0;
}

_id_D022() {
  return getdvarint("player_died_recently", "0") > 0;
}

_id_7E72() {
  if (level._id_7683 < 1)
  return "easy";

  if (level._id_7683 < 2)
  return "medium";

  if (level._id_7683 < 3)
  return "hard";

  return "fu";
}

_id_7853(var_0) {
  var_1 = (0, 0, 0);

  foreach (var_3 in var_0)
  var_1 = var_1 + var_3.origin;

  return var_1 * (1.0 / var_0.size);
}

_id_7748() {
  self._id_4CF5 = [];
  self endon("entitydeleted");
  self endon("stop_generic_damage_think");

  for (;;) {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  foreach (var_11 in self._id_4CF5)
  thread [[var_11]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

_id_16B7(var_0) {
  self._id_4CF5[self._id_4CF5.size] = var_0;
}

_id_DFE6(var_0) {
  var_1 = [];

  foreach (var_3 in self._id_4CF5) {
  if (var_3 == var_0)
  continue;

  var_1[var_1.size] = var_3;
  }

  self._id_4CF5 = var_1;
}

_id_D4BF(var_0) {
  self playlocalsound(var_0);
}

_id_6278(var_0) {
  if (level.players.size < 1)
  return;

  foreach (var_2 in level.players) {
  if (var_0 == 1) {
  var_2 enableweapons();
  continue;
  }

  var_2 _meth_80AA();
  }
}

_id_11633(var_0) {
  level.player setorigin(var_0.origin);

  if (isdefined(var_0.angles))
  level.player setplayerangles(var_0.angles);
}

_id_11634(var_0) {
  level.player setplayerangles((0, 0, 0));

  if (isdefined(var_0.angles))
  level.player _meth_84EF(var_0.angles);

  level.player setorigin(var_0.origin, 1, 1);
  level.player _meth_8366((0, 0, 0));
}

_id_12687() {
  var_0 = [];

  if (isdefined(self._id_6633))
  var_0 = self._id_6633;

  if (isdefined(self._id_0114))
  var_0[var_0.size] = self._id_0114;

  scripts\engine\utility::_id_22A1(var_0, _id_0B92::_id_12688);
}

_id_C621(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_opening_fov");
  wait(var_0);
  level.player _meth_823D(var_1, var_2, 1, var_3, var_4, var_5, var_6, 1);
}

_id_77E3(var_0, var_1, var_2) {
  if (!isdefined(var_0))
  var_0 = "all";

  if (!isdefined(var_1))
  var_1 = "all";

  var_3 = _func_074(var_0, var_1);
  var_4 = [];

  foreach (var_6 in var_3) {
  if (var_6 istouching(self))
  var_4[var_4.size] = var_6;
  }

  return var_4;
}

_id_7964(var_0) {
  if (!isdefined(var_0))
  var_0 = "all";

  var_1 = [];

  if (var_0 == "all") {
  var_1 = _id_22A2(level._id_5CC3["allies"]._id_2274, level._id_5CC3["axis"]._id_2274);
  var_1 = _id_22A2(var_1, level._id_5CC3["neutral"]._id_2274);
  }
  else
  var_1 = level._id_5CC3[var_0]._id_2274;

  var_2 = [];

  foreach (var_4 in var_1) {
  if (!isdefined(var_4))
  continue;

  if (var_4 istouching(self))
  var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_7965(var_0) {
  var_1 = _id_22A2(level._id_5CC3["allies"]._id_2274, level._id_5CC3["axis"]._id_2274);
  var_1 = _id_22A2(var_1, level._id_5CC3["neutral"]._id_2274);
  var_2 = [];

  foreach (var_4 in var_1) {
  if (!isdefined(var_4))
  continue;

  if (isdefined(var_4._id_0336) && var_4._id_0336 == var_0)
  var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_F311(var_0) {
  self._id_00C1 = var_0;
}

_id_7226(var_0, var_1, var_2, var_3) {
  self notify("_utility::follow_path");
  self endon("_utility::follow_path");
  self endon("death");
  var_4 = undefined;

  if (!isdefined(var_0.classname)) {
  if (!isdefined(var_0.type))
  var_4 = "struct";
  else
  var_4 = "node";
  }
  else
  var_4 = "entity";

  if (!isdefined(var_1))
  var_1 = 300;

  var_5 = self._id_EDB0;
  self._id_EDB0 = 1;
  _id_0B77::_id_8409(var_0, var_4, var_2, var_1, var_3);
  self._id_EDB0 = var_5;

  if (!isdefined(self._id_EDB0) || !self._id_EDB0)
  self._id_015C = level._id_4FF6;
}

_id_61F1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (!isdefined(var_0))
  var_0 = 250;

  if (!isdefined(var_1))
  var_1 = 100;

  if (!isdefined(var_2))
  var_2 = var_0 * 2;

  if (!isdefined(var_3))
  var_3 = var_0 * 1.25;

  if (!isdefined(var_5))
  var_5 = 0;

  self._id_5953 = var_5;
  thread _id_0B92::_id_5F8E(var_0, var_1, var_2, var_3, var_4);
}

_id_5523() {
  self notify("stop_dynamic_run_speed");
}

_id_D282() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if (_id_8BAB())
  var_0 = 250;

  var_1 = distance(self.origin, level.player.origin);

  for (;;) {
  wait 2;
  self._id_015C = var_1;
  var_2 = level.player;
  self _meth_82ED(var_2);
  var_1 = var_1 - 175;

  if (var_1 < var_0) {
  var_1 = var_0;
  return;
  }
  }
}

_id_D281() {
  self notify("stop_player_seek");
}

_id_1376C(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");

  if (!isdefined(var_2))
  var_2 = 5;

  var_3 = gettime() + var_2 * 1000;

  while (isdefined(var_0)) {
  if (distance(var_0.origin, self.origin) <= var_1)
  break;

  if (gettime() > var_3)
  break;

  wait 0.1;
  }
}

_id_1376B(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while (isdefined(var_0)) {
  if (distance(var_0.origin, self.origin) <= var_1)
  break;

  wait 0.1;
  }
}

_id_1376D(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  while (isdefined(var_0)) {
  if (distance(var_0.origin, self.origin) > var_1)
  break;

  wait 0.1;
  }
}

_id_8BAB() {
  self endon("death");

  if (!isdefined(self.weapon))
  return 0;

  if (scripts\engine\utility::_id_13C07(self.weapon) == "spread")
  return 1;

  return 0;
}

_id_9F0E(var_0) {
  if (var_0 == "none")
  return 0;

  if (weaponinventorytype(var_0) != "primary")
  return 0;

  switch (scripts\engine\utility::_id_13C07(var_0)) {
  case "sniper":
  case "rocketlauncher":
  case "mg":
  case "smg":
  case "rifle":
  case "spread":
  case "pistol":
  return 1;
  default:
  return 0;
  }
}

_id_D0C8() {
  var_0 = self _meth_8173();

  if (!isdefined(var_0))
  return 0;

  foreach (var_2 in var_0) {
  if (issubstr(var_2, "thermal"))
  return 1;
  }

  return 0;
}

_id_13817(var_0, var_1) {
  self endon("death");

  if (!isdefined(var_1))
  var_1 = self._id_015C;

  for (;;) {
  self waittill("goal");

  if (distance(self.origin, var_0) < var_1 + 10)
  break;
  }
}

_id_D2CD(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if (!isdefined(level.player._id_764D))
  level.player._id_764D = var_2;

  var_3 = int(level.player._id_764D * var_0 * 0.01);
  level.player _id_D2D1(var_3, var_1);
}

_id_2B78(var_0, var_1) {
  var_2 = self;

  if (!isplayer(var_2))
  var_2 = level.player;

  if (!isdefined(var_2._id_BCF5))
  var_2._id_BCF5 = 1.0;

  var_3 = var_0 * 0.01;
  var_2 _id_2B76(var_3, var_1);
}

_id_D2D1(var_0, var_1) {
  var_2 = int(getdvar("g_speed"));

  if (!isdefined(level.player._id_764D))
  level.player._id_764D = var_2;

  var_3 = _id_0B92::_id_764E;
  var_4 = _id_0B92::_id_764F;
  level.player thread _id_D2CE(var_0, var_1, var_3, var_4, "player_speed_set");
}

_id_CF97(var_0, var_1) {
  var_2 = _id_0B92::_id_7647;
  var_3 = _id_0B92::_id_7648;
  level.player thread _id_D2CE(var_0, var_1, var_2, var_3, "player_bob_scale_set");
}

_id_2B76(var_0, var_1) {
  var_2 = self;

  if (!isplayer(var_2))
  var_2 = level.player;

  if (!isdefined(var_2._id_BCF5))
  var_2._id_BCF5 = 1.0;

  var_3 = _id_0B92::_id_BCF0;
  var_4 = _id_0B92::_id_BCF3;
  var_2 thread _id_D2CE(var_0, var_1, var_3, var_4, "blend_movespeedscale");
}

_id_D2CE(var_0, var_1, var_2, var_3, var_4) {
  self notify(var_4);
  self endon(var_4);
  var_5 = [[var_2]]();
  var_6 = var_0;

  if (isdefined(var_1)) {
  var_7 = var_6 - var_5;
  var_8 = 0.05;
  var_9 = var_1 / var_8;
  var_10 = var_7 / var_9;

  while (abs(var_6 - var_5) > abs(var_10 * 1.1)) {
  var_5 = var_5 + var_10;
  [[var_3]](var_5);
  wait(var_8);
  }
  }

  [[var_3]](var_6);
}

_id_D2CA(var_0) {
  if (!isdefined(level.player._id_764D))
  return;

  level.player _id_D2D1(level.player._id_764D, var_0);
  waittillframeend;
  level.player._id_764D = undefined;
}

_id_2B77(var_0) {
  var_1 = self;

  if (!isplayer(var_1))
  var_1 = level.player;

  if (!isdefined(var_1._id_BCF5))
  return;

  var_1 _id_2B76(1.0, var_0);
  var_1._id_BCF5 = undefined;
}

_id_11624(var_0) {
  if (isplayer(self)) {
  self setorigin(var_0.origin);
  self setplayerangles(var_0.angles);
  }
  else if (isai(self))
  self _meth_80F1(var_0.origin, var_0.angles);
  else
  {
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  }
}

_id_11645(var_0, var_1) {
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  self dontinterpolate();

  if (isplayer(self)) {
  self setorigin(var_2);
  self setplayerangles(var_3);
  }
  else if (isai(self))
  self _meth_80F1(var_2, var_3);
  else
  {
  self.origin = var_2;
  self.angles = var_3;
  }
}

_id_1160F(var_0) {
  self _meth_80F1(var_0.origin, var_0.angles);
  self _meth_82EF(self.origin);
  self _meth_82EE(var_0);
}

_id_BC00(var_0) {
  foreach (var_2 in level.createfxent)
  var_2.v["origin"] = var_2.v["origin"] + var_0;
}

_id_9F59() {
  return isdefined(self._id_102EB);
}

_id_2A75(var_0, var_1, var_2) {
  self endon("stop_sliding");
  self endon("death");
  var_3 = self;

  if (var_3 _id_65DF("is_sliding"))
  var_3 _id_65DD("is_sliding");
  else
  var_3 _id_65E0("is_sliding");

  var_4 = isdefined(level._id_4C5D);
  var_5 = level.player scripts\engine\utility::_id_107E6();
  var_3._id_102EB = var_5;
  var_6 = level.player scripts\engine\utility::_id_107E6();
  var_3._id_7601 = var_6;
  var_7 = scripts\engine\trace::_id_48BC(0, 1, 0, 0, 0, 0);
  var_8 = scripts\engine\trace::_id_DCED(level.player geteye(), level.player geteye() - (0, 0, 100), var_3, var_7);
  var_9 = 0;
  var_10 = (0, 0, 0);
  var_11 = var_8["normal"];

  for (;;) {
  if (!var_3 isjumping()) {
  var_8 = scripts\engine\trace::_id_DCED(level.player geteye(), level.player geteye() - (0, 0, 100), var_3, var_7);
  var_11 = var_8["normal"];

  if (isdefined(var_11)) {
  var_12 = vectordot(var_11, (0, 0, 1));

  if (var_12 <= 0.95) {
  var_9 = acos(var_12);
  var_10 = var_8["position"];
  break;
  }
  }
  }

  wait 0.05;
  }

  var_11 = vectornormalize(scripts\engine\utility::_id_6EE6(var_11, (0, 0, 1)));
  var_13 = vectornormalize(vectorcross(var_11, (0, 1, 0)));
  var_14 = vectornormalize(vectorcross(var_11, var_13));
  var_5.angles = var_3.angles;
  var_5.origin = var_3.origin;
  var_15 = vectortoangles(var_11) + var_11 * var_9;
  var_5._id_77BA = spawn("script_model", var_5.origin + anglestoforward(var_15) * 2000);
  var_5._id_77BA.angles = var_15;
  var_3._id_7601.angles = var_15;

  if (!isdefined(var_0))
  var_0 = var_3 _meth_816B() + (0, 0, -10);

  if (!isdefined(var_1))
  var_1 = 10;

  if (!isdefined(var_2))
  var_2 = 0.035;

  var_5 _meth_820E((0, 0, 15), 15, var_0);
  var_3 thread _id_CE2F("foot_slide_plr_start");
  var_3 _meth_84FE();
  var_3 _meth_846F("ges_slide", var_5._id_77BA, 0.2);

  if (isdefined(level._effect["vfx_slide_dirt"])) {
  var_16 = scripts\engine\utility::_id_7ECB("vfx_slide_dirt");
  playfxontag(scripts\engine\utility::_id_7ECB("vfx_slide_dirt"), var_3._id_7601, "tag_origin");
  var_3._id_7601 show();
  }

  var_3 _id_65E1("is_sliding");

  if (var_4) {
  var_3 _meth_823C(var_5, undefined, 1);
  wait 1.0;
  var_3 _meth_823D(var_5, "tag_origin", 1, 180, 180, 180, 180, 1);
  }
  else
  var_3 _meth_823D(var_5, "tag_origin", 0, 180, 180, 180, 180);

  _func_1C5("depthSortViewmodel", 1);
  var_3 scripts\engine\utility::_id_1C46(0);
  var_3 scripts\engine\utility::_id_1C60(0);
  var_3 scripts\engine\utility::_id_1C68(0);
  var_3 scripts\engine\utility::_id_1C62(0);
  var_3 thread _id_0B92::_id_5AAD(var_5, var_1, var_2);
  var_3 thread _id_CD81("foot_slide_plr_loop");
}

_id_6389() {
  var_0 = self;

  if (level.player _meth_8477()) {
  var_0 _meth_8442("ges_slide");
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread _id_CE2F("foot_slide_plr_end");
  }

  var_0 scripts\engine\utility::_id_50E1(0.2, ::_meth_84FD);

  if (level.player _meth_81AB()) {
  var_0 unlink();
  var_0 _meth_8366(var_0._id_102EB._id_029B);
  }

  if (isdefined(var_0._id_7601)) {
  if (isdefined(level._effect["vfx_slide_dirt"])) {
  var_1 = scripts\engine\utility::_id_7ECB("vfx_slide_dirt");

  if (isdefined(var_1))
  stopfxontag(scripts\engine\utility::_id_7ECB("vfx_slide_dirt"), var_0._id_7601, "tag_origin");
  }

  var_0._id_7601 delete();
  }

  if (var_0 _id_65DF("is_sliding") && var_0 _id_65DB("is_sliding"))
  var_0 _id_65DD("is_sliding");

  var_0._id_102EB delete();
  var_0 scripts\engine\utility::_id_1C46(1);
  var_0 scripts\engine\utility::_id_1C60(1);
  var_0 scripts\engine\utility::_id_1C68(1);
  var_0 scripts\engine\utility::_id_1C62(1);
  _func_1C5("depthSortViewmodel", 0);
  var_0 notify("stop_sliding");
}

_id_2A76(var_0, var_1, var_2) {
  var_3 = self;

  if (var_3 _id_65DF("is_sliding"))
  var_3 _id_65DD("is_sliding");
  else
  var_3 _id_65E0("is_sliding");

  var_3 thread _id_CE2F("foot_slide_plr_start");
  var_3 thread _id_CD81("foot_slide_plr_loop");
  var_4 = isdefined(level._id_4C5D);

  if (!isdefined(var_0))
  var_0 = var_3 _meth_816B() + (0, 0, -10);

  if (!isdefined(var_1))
  var_1 = 10;

  if (!isdefined(var_2))
  var_2 = 0.035;

  var_5 = spawn("script_origin", var_3.origin);
  var_5.angles = var_3.angles;
  var_3._id_102EB = var_5;
  var_5 _meth_820E((0, 0, 15), 15, var_0);
  var_3 _id_65E1("is_sliding");

  if (var_4)
  var_3 _meth_823C(var_5, undefined, 1);
  else
  var_3 _meth_823A(var_5);

  var_3 _meth_80AA();
  var_3 _meth_8010(0);
  var_3 _meth_800A(1);
  var_3 _meth_8013(0);
  var_3 thread _id_0B92::_id_5AAD(var_5, var_1, var_2);
}

_id_638A() {
  var_0 = self;
  var_0 notify("stop soundfoot_slide_plr_loop");
  var_0 thread _id_CE2F("foot_slide_plr_end");
  var_0 unlink();
  var_0 _meth_8366(var_0._id_102EB._id_029B);
  var_0._id_102EB delete();
  var_0 enableweapons();
  var_0 _meth_8010(1);
  var_0 _meth_800A(1);
  var_0 _meth_8013(1);
  var_0 notify("stop_sliding");

  if (var_0 _id_65DF("is_sliding") && var_0 _id_65DB("is_sliding"))
  var_0 _id_65DD("is_sliding");
}

_id_10808() {
  return _id_0B93::_id_13237(self);
}

_id_7E9C(var_0) {
  var_1 = _id_0B90::_id_7AA4();
  var_2 = [];

  foreach (var_6, var_4 in var_1) {
  if (!issubstr(var_6, "flag"))
  continue;

  var_5 = getentarray(var_6, "classname");
  var_2 = scripts\engine\utility::_id_227F(var_2, var_5);
  }

  var_7 = _id_0B90::_id_7AA5();

  foreach (var_9, var_4 in var_7) {
  if (!issubstr(var_9, "flag"))
  continue;

  var_5 = getentarray(var_9, "targetname");
  var_2 = scripts\engine\utility::_id_227F(var_2, var_5);
  }

  var_10 = undefined;

  foreach (var_12 in var_2) {
  if (var_12._id_ED9A == var_0)
  return var_12;
  }
}

_id_7E99(var_0) {
  var_1 = _id_0B90::_id_7AA4();
  var_2 = [];

  foreach (var_6, var_4 in var_1) {
  if (!issubstr(var_6, "flag"))
  continue;

  var_5 = getentarray(var_6, "classname");
  var_2 = scripts\engine\utility::_id_227F(var_2, var_5);
  }

  var_7 = _id_0B90::_id_7AA5();

  foreach (var_9, var_4 in var_7) {
  if (!issubstr(var_9, "flag"))
  continue;

  var_5 = getentarray(var_9, "targetname");
  var_2 = scripts\engine\utility::_id_227F(var_2, var_5);
  }

  var_10 = [];

  foreach (var_12 in var_2) {
  if (var_12._id_ED9A == var_0)
  var_10[var_10.size] = var_12;
  }

  return var_10;
}

_id_F623(var_0, var_1) {
  return (var_0[0], var_0[1], var_1);
}

_id_1796(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

_id_F622(var_0, var_1) {
  return (var_0[0], var_1, var_0[2]);
}

_id_F621(var_0, var_1) {
  return (var_1, var_0[1], var_0[2]);
}

_id_58DA() {
  return isdefined(self._id_1491._id_58DA);
}

_id_7C23(var_0) {
  var_1 = _id_7B92();

  if (!isdefined(var_0))
  var_0 = "steady_rumble";

  var_2 = spawn("script_origin", var_1 geteye());
  var_2._id_99E5 = 1;
  var_2 thread _id_0B92::_id_12E1F(var_1, var_0);
  return var_2;
}

_id_F581(var_0) {
  self._id_99E5 = var_0;
}

_id_E7C8(var_0) {
  thread _id_E7C9(1, var_0);
}

_id_E7C7(var_0) {
  thread _id_E7C9(0, var_0);
}

_id_E7C9(var_0, var_1) {
  self notify("new_ramp");
  self endon("new_ramp");
  self endon("death");
  var_2 = var_1 * 20;
  var_3 = var_0 - self._id_99E5;
  var_4 = var_3 / var_2;

  for (var_5 = 0; var_5 < var_2; var_5++) {
  self._id_99E5 = self._id_99E5 + var_4;
  wait 0.05;
  }

  self._id_99E5 = var_0;
}

_id_7B92() {
  if (isdefined(self)) {
  if (!scripts\engine\utility::array_contains(level.players, self))
  return level.player;
  else
  return self;
  }
  else
  return level.player;
}

_id_7B93() {
  return int(self _meth_8155("gameskill"));
}

_id_228B(var_0, var_1, var_2) {
  var_3 = [];
  var_1 = var_2 - var_1;

  foreach (var_5 in var_0) {
  var_3[var_3.size] = var_5;

  if (var_3.size == var_2) {
  var_3 = scripts\engine\utility::_id_22A7(var_3);

  for (var_6 = var_1; var_6 < var_3.size; var_6++)
  var_3[var_6] delete();

  var_3 = [];
  }
  }

  var_8 = [];

  foreach (var_5 in var_0) {
  if (!isdefined(var_5))
  continue;

  var_8[var_8.size] = var_5;
  }

  return var_8;
}

_id_1378E(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = 0.5;

  self endon("death");

  while (isdefined(self)) {
  if (distance(var_0, self.origin) <= var_1)
  break;

  wait(var_2);
  }
}

_id_558D() {
  self._id_01FD = 0;
}

_id_6242() {
  self._id_01FD = squared(512);
}

_id_61FF(var_0) {
  self._id_8CD0 = 1;
  self._id_C009 = 1;
  self._id_036C = 1;

  if (!isdefined(var_0) || !var_0) {
  self._id_596C = 1;
  self._id_01D0 = 64;
  self._id_0232 = 2048;
  _id_558D();
  }

  self._id_1096A = scripts\anim\animset::_id_8CD8;
  self._id_4C8F["run"] = scripts\anim\utility::_id_B028("heat_run");
}

_id_5537() {
  self._id_8CD0 = undefined;
  self._id_C009 = undefined;
  self._id_596C = undefined;
  self._id_036C = 0;
  self._id_01D0 = 512;
  self._id_1096A = undefined;
  self._id_4C8F = undefined;
}

_id_81FF() {
  return vehicle_getarray();
}

_id_8FE1(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = 0;

  var_3 = 0.5;
  level endon("clearing_hints");

  if (isdefined(level._id_9019))
  level._id_9019 _id_0B3F::_id_52DC();

  level._id_9019 = _id_0B3F::_id_49B2("default", 1.5);
  level._id_9019 _id_0B3F::_id_F801("MIDDLE", undefined, 0, 30 + var_2);
  level._id_9019._id_00B9 = (1, 1, 1);
  level._id_9019 _meth_834D(var_0);
  level._id_9019.alpha = 0;
  level._id_9019 fadeovertime(0.5);
  level._id_9019.alpha = 1;
  wait 0.5;
  level._id_9019 endon("death");

  if (isdefined(var_1))
  wait(var_1);
  else
  return;

  level._id_9019 fadeovertime(var_3);
  level._id_9019.alpha = 0;
  wait(var_3);
  level._id_9019 _id_0B3F::_id_52DC();
}

_id_8FF8() {
  var_0 = 1;

  if (isdefined(level._id_9019)) {
  level notify("clearing_hints");
  level._id_9019 fadeovertime(var_0);
  level._id_9019.alpha = 0;
  wait(var_0);
  }
}

_id_A5CE(var_0, var_1) {
  if (!isdefined(level._id_6E25[var_0]))
  return;

  if (!isdefined(var_1))
  var_1 = 0;

  foreach (var_3 in level._id_4E3F[var_0]) {
  foreach (var_5 in var_3) {
  if (isalive(var_5)) {
  var_5 thread _id_0B92::_id_A5CF(var_1);
  continue;
  }

  var_5 delete();
  }
  }
}

_id_7BB6(var_0, var_1, var_2, var_3) {
  if (!isdefined(var_3))
  var_3 = "player_view_controller";

  if (!isdefined(var_2))
  var_2 = (0, 0, 0);

  var_4 = var_0 gettagorigin(var_1);
  var_5 = spawnturret("misc_turret", var_4, var_3);
  var_5.angles = var_0 gettagangles(var_1);
  var_5 setmodel("tag_turret");
  var_5 linkto(var_0, var_1, var_2, (0, 0, 0));
  var_5 makeunusable();
  var_5 hide();
  var_5 _meth_830F("manual");
  return var_5;
}

_id_48AA(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4 childthread _id_0B92::_id_D961(var_0, self, var_1, var_2, var_3);
  return var_4;
}

_id_110A8(var_0) {
  if (!isdefined(self._id_110B7))
  self._id_110B7 = [];

  var_1 = [];
  var_2 = self _meth_8173();

  foreach (var_4 in var_2) {
  var_1[var_4] = [];
  var_1[var_4]["clip_left"] = self getweaponammoclip(var_4, "left");
  var_1[var_4]["clip_right"] = self getweaponammoclip(var_4, "right");
  var_1[var_4]["stock"] = self getweaponammostock(var_4);
  }

  if (!isdefined(var_0))
  var_0 = "default";

  self._id_110B7[var_0] = [];
  self._id_110B7[var_0]["current_weapon"] = self getcurrentweapon();
  self._id_110B7[var_0]["inventory"] = var_1;
}

_id_E2CF(var_0, var_1) {
  if (!isdefined(var_0))
  var_0 = "default";

  if (!isdefined(self._id_110B7) || !isdefined(self._id_110B7[var_0]))
  return;

  self takeallweapons();

  foreach (var_4, var_3 in self._id_110B7[var_0]["inventory"]) {
  if (weaponinventorytype(var_4) != "altmode")
  self giveweapon(var_4);

  self setweaponammoclip(var_4, var_3["clip_left"], "left");
  self setweaponammoclip(var_4, var_3["clip_right"], "right");
  self setweaponammostock(var_4, var_3["stock"]);
  }

  var_5 = self._id_110B7[var_0]["current_weapon"];

  if (var_5 != "none") {
  if (scripts\engine\utility::_id_9CEE(var_1))
  self _meth_83B6(var_5);
  else
  self _meth_83B5(var_5);
  }
}

_id_8E7E() {
  switch (self.code_classname) {
  case "light_spot":
  case "script_vehicle":
  case "script_model":
  self hide();
  break;
  case "script_brushmodel":
  self hide();
  self notsolid();

  if (self._id_02AF & 1)
  self connectpaths();

  break;
  case "trigger_multiple_flag_looking":
  case "trigger_multiple_flag_lookat":
  case "trigger_multiple_breachIcon":
  case "trigger_multiple_flag_set":
  case "trigger_use_touch":
  case "trigger_use":
  case "trigger_multiple":
  case "trigger_radius":
  scripts\engine\utility::_id_12778();
  break;
  default:
  }
}

_id_100D7() {
  switch (self.code_classname) {
  case "light_spot":
  case "script_vehicle":
  case "script_model":
  self show();
  break;
  case "script_brushmodel":
  self show();
  self solid();

  if (self._id_02AF & 1)
  self disconnectpaths();

  break;
  case "trigger_multiple_flag_looking":
  case "trigger_multiple_flag_lookat":
  case "trigger_multiple_breachIcon":
  case "trigger_multiple_flag_set":
  case "trigger_use_touch":
  case "trigger_use":
  case "trigger_multiple":
  case "trigger_radius":
  scripts\engine\utility::_id_1277A();
  break;
  default:
  }
}

_id_F492(var_0, var_1) {
  self notify("set_moveplaybackrate");
  self endon("set_moveplaybackrate");

  if (isdefined(var_1)) {
  var_2 = scripts\asm\asm::_id_2340();
  var_3 = var_0 - var_2;
  var_4 = 0.05;
  var_5 = var_1 / var_4;

  for (var_6 = var_3 / var_5; abs(var_0 - var_2) > abs(var_6 * 1.1); var_2 = scripts\asm\asm::_id_2340()) {
  scripts\asm\asm::_id_237B(var_2 + var_6);
  wait(var_4);
  }
  }

  scripts\asm\asm::_id_237B(var_0);
}

_id_22C7(var_0, var_1, var_2, var_3, var_4, var_5) {
  foreach (var_7 in var_0)
  var_7 thread _id_1747(var_1, var_2, var_3, var_4, var_5);
}

_id_22CA(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _func_0C8(var_0);
  var_6 = _id_22A2(var_6, getentarray(var_0, "targetname"));
  _id_22C7(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_22C9(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_7C84(var_0, "script_noteworthy");
  var_6 = _id_22A2(var_6, getentarray(var_0, "script_noteworthy"));
  _id_22C7(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_22C8(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_77DF(var_0);
  _id_22C7(var_6, var_1, var_2, var_3, var_4, var_5);
}

_id_61ED() {
  self._id_595D = 1;
}

_id_551B() {
  self._id_595D = undefined;
}

_id_4960(var_0) {
  if (!isdefined(level._id_11220))
  level._id_11220 = [];

  var_1 = spawnstruct();
  var_1.name = var_0;
  level._id_11220[var_0] = var_1;
  return var_1;
}

_id_6245() {
  thread _id_6246();
}

_id_6246() {
  self endon("death");

  for (;;) {
  self._id_115CE = 1;
  wait 0.05;
  }
}

_id_5590() {
  self._id_115CE = undefined;
}

_id_9A4D() {
  var_0 = [];
  var_0[0] = ["interactive_birds", "targetname"];
  var_0[1] = ["interactive_vulture", "targetname"];
  var_0[2] = ["interactive_fish", "script_noteworthy"];
  return var_0;
}

_id_B3CB(var_0) {
  var_1 = _id_9A4D();
  var_2 = [];

  foreach (var_4 in var_1) {
  var_5 = getentarray(var_4[0], var_4[1]);
  var_2 = scripts\engine\utility::_id_227F(var_2, var_5);
  }

  foreach (var_8 in var_2) {
  if (!isdefined(level._id_12EF[var_8._id_9A4B]._id_EB78))
  continue;

  foreach (var_11 in var_0) {
  if (!var_11 istouching(var_8))
  continue;

  if (!isdefined(var_11._id_9A4E))
  var_11._id_9A4E = [];

  var_11._id_9A4E[var_11._id_9A4E.size] = var_8 [[level._id_12EF[var_8._id_9A4B]._id_EB78]]();
  }
  }
}

_id_15BD() {
  if (!isdefined(self._id_9A4E))
  return;

  foreach (var_1 in self._id_9A4E)
  var_1 [[level._id_12EF[var_1._id_9A4B]._id_AE17]]();

  self._id_9A4E = undefined;
}

_id_515D(var_0) {
  _id_B3CB(var_0);

  foreach (var_2 in var_0)
  var_2._id_9A4E = undefined;
}

_id_B3CA(var_0) {
  if (getdvar("createfx") != "")
  return;

  var_1 = getentarray("script_brushmodel", "classname");
  var_2 = getentarray("script_model", "classname");

  for (var_3 = 0; var_3 < var_2.size; var_3++)
  var_1[var_1.size] = var_2[var_3];

  foreach (var_5 in var_0) {
  foreach (var_7 in var_1) {
  if (isdefined(var_7._id_EE89))
  var_7.targetname = var_7._id_EE89;

  if (!isdefined(var_7.targetname))
  continue;

  if (!isdefined(var_7._id_01F1))
  continue;

  if (var_7.code_classname != "script_model")
  continue;

  if (!var_7 istouching(var_5))
  continue;

  var_7._id_B3CC = 1;
  }
  }
}

_id_15AD() {
  var_0 = spawn("script_origin", (0, 0, 0));

  foreach (var_2 in level.createfxent) {
  if (!isdefined(var_2.v["masked_exploder"]))
  continue;

  var_0.origin = var_2.v["origin"];
  var_0.angles = var_2.v["angles"];

  if (!var_0 istouching(self))
  continue;

  var_3 = var_2.v["masked_exploder"];
  var_4 = var_2.v["masked_exploder_spawnflags"];
  var_5 = var_2.v["masked_exploder_script_disconnectpaths"];
  var_6 = spawn("script_model", (0, 0, 0), var_4);
  var_6 setmodel(var_3);
  var_6.origin = var_2.v["origin"];
  var_6.angles = var_2.v["angles"];
  var_2.v["masked_exploder"] = undefined;
  var_2.v["masked_exploder_spawnflags"] = undefined;
  var_2.v["masked_exploder_script_disconnectpaths"] = undefined;
  var_6._id_5635 = var_5;
  var_6.targetname = var_2.v["exploder"];
  scripts\common\exploder::_id_F9A6(var_6);
  var_2._id_01F1 = var_6;
  }

  var_0 delete();
}

_id_5146(var_0, var_1) {
  foreach (var_3 in var_0)
  var_3._id_5379 = [];

  var_5 = ["destructible_toy", "destructible_vehicle"];
  var_6 = 0;

  if (!isdefined(var_1))
  var_1 = 0;

  foreach (var_8 in var_5) {
  var_9 = getentarray(var_8, "targetname");

  foreach (var_11 in var_9) {
  foreach (var_3 in var_0) {
  if (var_1) {
  var_6++;
  var_6 = var_6 % 5;

  if (var_6 == 1)
  wait 0.05;
  }

  if (!var_3 istouching(var_11))
  continue;

  var_11 delete();
  break;
  }
  }
  }
}

_id_5153(var_0, var_1) {
  var_2 = getentarray("script_brushmodel", "classname");
  var_3 = getentarray("script_model", "classname");

  for (var_4 = 0; var_4 < var_3.size; var_4++)
  var_2[var_2.size] = var_3[var_4];

  var_5 = [];
  var_6 = spawn("script_origin", (0, 0, 0));
  var_7 = 0;

  if (!isdefined(var_1))
  var_1 = 0;

  foreach (var_9 in var_0) {
  foreach (var_11 in var_2) {
  if (!isdefined(var_11.targetname))
  continue;

  var_6.origin = var_11 _meth_814F();

  if (!var_9 istouching(var_6))
  continue;

  var_5[var_5.size] = var_11;
  }
  }

  _id_228A(var_5);
  var_6 delete();
}

_id_F70F(var_0) {
  self._id_6EC4 = var_0;
}

_id_6EC3() {
  var_0 = self._id_6ECA - gettime();

  if (var_0 < 0)
  return 0;

  return var_0 * 0.001;
}

_id_6EC5() {
  return _id_6EC3() > 0;
}

_id_6EC6(var_0) {
  if (isdefined(self._id_6EC4) && self._id_6EC4)
  return;

  var_1 = gettime() + var_0 * 1000.0;

  if (isdefined(self._id_6ECA))
  self._id_6ECA = max(self._id_6ECA, var_1);
  else
  self._id_6ECA = var_1;

  self notify("flashed");
  self _meth_82EB(1);
}

_id_13821() {
  for (;;) {
  var_0 = _func_074("axis", "all");
  var_1 = 0;

  foreach (var_3 in var_0) {
  if (!isalive(var_3))
  continue;

  if (var_3 istouching(self)) {
  var_1 = 1;
  break;
  }

  wait 0.0125;
  }

  if (!var_1) {
  var_5 = _id_77E3("axis");

  if (!var_5.size)
  break;
  }

  wait 0.05;
  }
}

_id_13822() {
  var_0 = 0;

  for (;;) {
  var_1 = _func_074("axis", "all");
  var_2 = 0;

  foreach (var_4 in var_1) {
  if (!isalive(var_4))
  continue;

  if (var_4 istouching(self)) {
  if (var_4 _id_58DA())
  continue;

  var_2 = 1;
  var_0 = 1;
  break;
  }

  wait 0.0125;
  }

  if (!var_2) {
  var_6 = _id_77E3("axis");

  if (!var_6.size)
  break;
  else
  var_0 = 1;
  }

  wait 0.05;
  }

  return var_0;
}

_id_13823(var_0) {
  _id_13821();
  scripts\engine\utility::_id_6E3E(var_0);
}

_id_1380D(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 _id_13823(var_1);
}

_id_D0F4() {
  if (isplayer(self))
  var_0 = self;
  else
  var_0 = level.player;

  return isdefined(var_0._id_02A6) && var_0._id_02A6._id_6F43;
}

_id_CFAA() {
  level.player _id_65DD("player_zero_attacker_accuracy");
  level.player._id_0185 = 0;
  level.player _id_0B35::_id_12E0B();
}

_id_CFB8() {
  level.player _id_65E1("player_zero_attacker_accuracy");
  level.player._id_0050 = 0;
  level.player._id_0185 = 1;
}

_id_F520(var_0) {
  var_1 = _id_7B92();
  var_1._id_86A9._id_CF81 = var_0;
  var_1 _id_0B35::_id_12E0B();
}

_id_2298(var_0) {
  var_1 = [];

  foreach (var_3 in var_0)
  var_1[var_3._id_EE79] = var_3;

  return var_1;
}

_id_2297(var_0) {
  var_1 = [];

  foreach (var_3 in var_0)
  var_1[var_3.classname] = var_3;

  return var_1;
}

_id_2299(var_0) {
  var_1 = [];

  foreach (var_3 in var_0) {
  if (isdefined(var_3._id_EDE8))
  var_1[var_3._id_EDE8] = var_3;
  }

  return var_1;
}

_id_78D5() {
  var_0 = _id_0B92::_id_78D1();
  var_1 = var_0["team"];

  foreach (var_3 in var_0["codes"]) {
  var_4 = level._id_22DF[var_1][var_3];

  if (isdefined(var_4))
  return var_4;
  }

  return undefined;
}

_id_78D3() {
  var_0 = _id_0B92::_id_78D1();
  var_1 = var_0["team"];

  foreach (var_3 in var_0["codes"]) {
  var_4 = level._id_22DD[var_1][var_3];

  if (isdefined(var_4))
  return var_4;
  }

  return undefined;
}

_id_6EC7() {
  self._id_6ECA = undefined;
  self _meth_82EB(0);
}

_id_7E96(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if (isdefined(var_2))
  return var_2;

  return scripts\engine\utility::_id_817E(var_0, var_1);
}

_id_7C9A(var_0) {
  return _func_2AE(var_0);
}

_id_7C9B(var_0) {
  return _func_2CA(var_0);
}

_id_858A() {
  thread _id_0B92::_id_636E();
  self endon("end_explode");
  self waittill("explode", var_0);
  _id_7751(var_0);
}

_id_7751(var_0) {
  _id_5FC7(var_0);
  _id_54EF(var_0);
}

_id_5FC7(var_0) {
  playrumbleonentity("grenade_rumble", var_0);
  earthquake(0.4, 0.5, var_0, 400);
}

_id_54EF(var_0) {
  if (level.player _meth_853E())
  return;

  if (!isdefined(level.player._id_A8FD))
  level.player._id_A8FD = gettime();
  else if (gettime() - level.player._id_A8FD < 3000)
  return;

  level.player._id_A8FD = gettime();

  foreach (var_2 in level.players) {
  if (distance(var_0, var_2.origin) > 600)
  continue;

  if (var_2 _meth_808F(var_0))
  var_2 thread _id_54F0(var_0);
  }
}

_id_54F0(var_0, var_1) {
  var_2 = _id_ECC4(var_0);

  foreach (var_5, var_4 in var_2)
  thread _id_0B35::_id_8587(var_5);
}

_id_2BC6(var_0) {
  if (!isdefined(self._id_4D2C))
  return;

  var_1 = _id_ECC4(self._id_4D2C.origin);

  foreach (var_4, var_3 in var_1)
  thread _id_0B35::_id_2BC1(var_4);
}

_id_ECC4(var_0) {
  var_1 = vectornormalize(anglestoforward(self.angles));
  var_2 = vectornormalize(anglestoright(self.angles));
  var_3 = vectornormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = [];
  var_7 = self getcurrentweapon();

  if (var_4 > 0 && var_4 > 0.5 && weapontype(var_7) != "riotshield")
  var_6["bottom"] = 1;

  if (abs(var_4) < 0.866) {
  if (var_5 > 0)
  var_6["right"] = 1;
  else
  var_6["left"] = 1;
  }

  return var_6;
}

_id_C971(var_0) {
  if (!isdefined(self._id_C3D0))
  self._id_C3D0 = self._id_0234;

  self._id_0234 = var_0;
}

_id_C972() {
  if (isdefined(self._id_C3D0))
  return;

  self._id_C3D0 = self._id_0234;
  self._id_0234 = 0;
}

_id_C970() {
  self._id_0234 = self._id_C3D0;
  self._id_C3D0 = undefined;
}

_id_13876() {
  if (isdefined(self._id_C3E3))
  return;

  self._id_C3E2 = self._id_0391;
  self._id_C3E3 = self._id_0392;
  self._id_0391 = 0;
  self._id_0392 = 0;
}

_id_13875() {
  self._id_0391 = self._id_C3E2;
  self._id_0392 = self._id_C3E3;
  self._id_C3E2 = undefined;
  self._id_C3E3 = undefined;
}

_id_6205() {
  thread _id_9330();
}

_id_9330() {
  self endon("disable_ignorerandombulletdamage_drone");
  self endon("death");
  self._id_0185 = 1;
  self._id_6B4B = self.health;
  self.health = 1000000;

  for (;;) {
  self waittill("damage", var_0, var_1);

  if (!isplayer(var_1) && issentient(var_1)) {
  if (isdefined(var_1._id_010C) && var_1._id_010C != self)
  continue;
  }

  self._id_6B4B = self._id_6B4B - var_0;

  if (self._id_6B4B <= 0)
  break;
  }

  self _meth_81D0();
}

_id_8E9A() {
  if (!isdefined(self._id_C3E9))
  self._id_C3E9 = self _meth_82C7(0);

  self hide();
}

_id_100FC() {
  if (!isai(self))
  self solid();

  if (isdefined(self._id_C3E9))
  self _meth_82C7(self._id_C3E9);

  self show();
}

_id_F2E7(var_0) {
  self._id_0371 = var_0;
}

_id_553C() {
  if (!isalive(self))
  return;

  if (!isdefined(self._id_0185))
  return;

  self notify("disable_ignorerandombulletdamage_drone");
  self._id_0185 = undefined;
  self.health = self._id_6B4B;
}

_id_11905(var_0) {
  var_1 = spawnstruct();
  var_1 scripts\engine\utility::delaythread(var_0, ::_id_F225, "timeout");
  return var_1;
}

_id_50E4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  childthread _id_0B92::_id_50E5(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_6E7C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if (!isarray(var_0))
  var_0 = [var_0, 0];

  thread _id_0B92::_id_6E7D(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

_id_13843(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if (!isarray(var_0))
  var_0 = [var_0, 0];

  thread _id_0B92::_id_13844(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
}

_id_61EB(var_0) {
  var_0 = var_0 * 1000;
  self._id_00F7 = 1;
  self._id_00E4 = var_0;
  self._id_BEFA = undefined;
}

_id_5517() {
  self._id_00F7 = 0;
  self._id_BEFA = 1;
}

_id_F3EC(var_0, var_1) {
  level._id_18D7 = var_0;
  level._id_18D6 = var_1;
}

_id_E1F2(var_0) {
  level._id_A936[var_0] = gettime();
}

_id_F323(var_0) {
  level._id_4C53 = var_0;
  thread _id_0B35::_id_E26C();
}

_id_4140() {
  level._id_4C53 = undefined;
  thread _id_0B35::_id_E26C();
}

_id_11147(var_0) {
  if (var_0.size > 1)
  return 0;

  var_1 = [];
  var_1["0"] = 1;
  var_1["1"] = 1;
  var_1["2"] = 1;
  var_1["3"] = 1;
  var_1["4"] = 1;
  var_1["5"] = 1;
  var_1["6"] = 1;
  var_1["7"] = 1;
  var_1["8"] = 1;
  var_1["9"] = 1;

  if (isdefined(var_1[var_0]))
  return 1;

  return 0;
}

_id_F2DC(var_0, var_1) {
  level._id_28CF[var_0] = var_1;
  _id_0B92::_id_12D95();
}

_id_C27B(var_0) {
  for (var_1 = 0; var_1 < 8; var_1++)
  _func_151(var_0, var_1, (0, 0, 0));
}

_id_7AE6(var_0) {
  var_1 = [];
  var_1["minutes"] = 0;

  for (var_1["seconds"] = int(var_0 / 1000); var_1["seconds"] >= 60; var_1["seconds"] = var_1["seconds"] - 60)
  var_1["minutes"]++;

  if (var_1["seconds"] < 10)
  var_1["seconds"] = "0" + var_1["seconds"];

  return var_1;
}

_id_D0CA(var_0) {
  var_1 = level.player getweaponslistprimaries();

  foreach (var_3 in var_1) {
  if (var_3 == var_0)
  return 1;
  }

  return 0;
}

_id_D0BD(var_0, var_1) {
  var_2 = level.player getweaponslistall();

  foreach (var_4 in var_2) {
  if (var_4 == var_0)
  return 1;
  }

  if (isdefined(var_1) && var_1 == 1) {
  if (level.player._id_110BD == var_0)
  return 1;

  if (level.player._id_110BA == var_0)
  return 1;
  }

  return 0;
}

_id_D0BE(var_0) {
  if (level.player._id_110BD == var_0)
  return 1;

  if (level.player._id_110BA == var_0)
  return 1;

  return 0;
}

_id_C264(var_0) {
  if (!isdefined(level._id_C265))
  level._id_C265 = [];

  if (!isdefined(level._id_C265[var_0]))
  level._id_C265[var_0] = level._id_C265.size + 1;

  return level._id_C265[var_0];
}

_id_C268(var_0) {
  return isdefined(level._id_C265) && isdefined(level._id_C265[var_0]);
}

_id_848C(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 - var_2;
  var_6 = var_3 - var_1;
  var_7 = var_5 / var_6;
  var_0 = var_0 - var_3;
  var_0 = var_7 * var_0;
  var_0 = var_0 + var_4;
  return var_0;
}

_id_BDF1(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 = var_1 * 0.001;
  return var_1;
}

_id_9B9D(var_0) {
  var_1 = _func_0A5(var_0);
  return var_1["count"];
}

_id_ACED(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

_id_509E(var_0) {
  level._id_AE21 = var_0;
}

_id_50A0(var_0) {
  switch (var_0) {
  case "titan":
  level._id_CC48 = "titan";
  break;
  case "moon_port":
  level._id_CC48 = "moon";
  break;
  case "marscrib":
  case "marsbase":
  case "marscrash":
  level._id_CC48 = "mars";
  break;
  case "rogue":
  level._id_CC48 = "asteroid";
  break;
  case "europa":
  level._id_CC48 = "europa";
  break;
  default:
  level._id_CC48 = "earth";
  break;
  }
}

_id_116CB(var_0) {
  _id_509E(var_0);
  level._id_116CC = var_0;
  _id_50A0(var_0);
}

_id_116CD(var_0) {
  level._id_25FA = var_0;
}

_id_7616(var_0, var_1) {
  thread _id_7617(var_0, var_1);
}

_id_7617(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_2 notify("new_volume_command");
  var_2 endon("new_volume_command");
  wait 0.05;
  _id_0B92::_id_7615(var_2, var_1);
}

_id_7619(var_0) {
  thread _id_761A(var_0);
}

_id_761A(var_0) {
  var_1 = getent(var_0, "script_noteworthy");
  var_1 notify("new_volume_command");
  var_1 endon("new_volume_command");
  wait 0.05;

  if (!isdefined(var_1._id_75BA))
  return;

  var_1._id_75BA = undefined;
  _id_7618(var_1);
}

_id_7618(var_0) {
  scripts\engine\utility::_id_22D2(var_0._id_7542, ::_id_E2B0);
}

_id_16AE(var_0, var_1) {
  if (!isdefined(level._id_4074))
  level._id_4074 = [];

  if (!isdefined(level._id_4074[var_1]))
  level._id_4074[var_1] = [];

  level._id_4074[var_1][level._id_4074[var_1].size] = var_0;
}

_id_4074(var_0) {
  var_1 = level._id_4074[var_0];
  var_1 = scripts\engine\utility::_id_22BC(var_1);
  _id_228A(var_1);
  level._id_4074[var_0] = undefined;
}

_id_4075(var_0) {
  if (!isdefined(level._id_4074))
  return;

  if (!isdefined(level._id_4074[var_0]))
  return;

  var_1 = level._id_4074[var_0];
  var_1 = scripts\engine\utility::_id_22BC(var_1);

  foreach (var_3 in var_1) {
  if (!isai(var_3))
  continue;

  if (!isalive(var_3))
  continue;

  if (!isdefined(var_3._id_B14F))
  continue;

  if (!var_3._id_B14F)
  continue;

  var_3 _id_1101B();
  }

  _id_228A(var_1);
  level._id_4074[var_0] = undefined;
}

_id_178A(var_0) {
  if (!isdefined(self._id_1274A))
  thread _id_0B92::_id_1789();

  self._id_1274A[self._id_1274A.size] = var_0;
}

_id_7DB7() {
  var_0 = [];
  var_1 = getentarray();

  foreach (var_3 in var_1) {
  if (!isdefined(var_3.classname))
  continue;

  if (scripts\engine\utility::string_starts_with(var_3.classname, "weapon_"))
  var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_BCA1(var_0, var_1, var_2) {
  self notify("newmove");
  self endon("newmove");

  if (!isdefined(var_2))
  var_2 = 200;

  var_3 = distance(self.origin, var_0);
  var_4 = var_3 / var_2;
  var_5 = vectornormalize(var_0 - self.origin);
  self moveto(var_0, var_4, 0, 0);
  self rotateto(var_1, var_4, 0, 0);
  wait(var_4);

  if (!isdefined(self))
  return;

  self._id_0381 = var_5 * (var_3 / var_4);
}

_id_6E3D(var_0) {
  level endon(var_0);
  self waittill("death");
  scripts\engine\utility::_id_6E3E(var_0);
}

_id_61EA() {
  level._id_4D4A = 1;
}

_id_5516() {
  level._id_4D4A = 0;
}

_id_9BAF() {
  return isdefined(level._id_4D4A) && level._id_4D4A;
}

_id_9BB7() {
  if (getdvar("e3demo") == "1")
  return 1;

  return 0;
}

_id_9C32() {
  if (level.script == "shipcrib_epilogue")
  return 1;

  return 0;
}

_id_51D5(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::_id_8180(var_0, var_1);
  _id_51D6(var_3, var_2);
}

_id_51D4(var_0) {
  if (!isdefined(var_0))
  return;

  var_1 = var_0._id_027C;

  if (isdefined(var_1) && isdefined(level._id_1115C["script_linkname"]) && isdefined(level._id_1115C["script_linkname"][var_1])) {
  foreach (var_4, var_3 in level._id_1115C["script_linkname"][var_1]) {
  if (isdefined(var_3) && var_0 == var_3)
  level._id_1115C["script_linkname"][var_1][var_4] = undefined;
  }

  if (level._id_1115C["script_linkname"][var_1].size == 0)
  level._id_1115C["script_linkname"][var_1] = undefined;
  }

  var_1 = var_0.script_noteworthy;

  if (isdefined(var_1) && isdefined(level._id_1115C["script_noteworthy"]) && isdefined(level._id_1115C["script_noteworthy"][var_1])) {
  foreach (var_4, var_3 in level._id_1115C["script_noteworthy"][var_1]) {
  if (isdefined(var_3) && var_0 == var_3)
  level._id_1115C["script_noteworthy"][var_1][var_4] = undefined;
  }

  if (level._id_1115C["script_noteworthy"][var_1].size == 0)
  level._id_1115C["script_noteworthy"][var_1] = undefined;
  }

  var_1 = var_0._id_0334;

  if (isdefined(var_1) && isdefined(level._id_1115C["target"]) && isdefined(level._id_1115C["target"][var_1])) {
  foreach (var_4, var_3 in level._id_1115C["target"][var_1]) {
  if (isdefined(var_3) && var_0 == var_3)
  level._id_1115C["target"][var_1][var_4] = undefined;
  }

  if (level._id_1115C["target"][var_1].size == 0)
  level._id_1115C["target"][var_1] = undefined;
  }

  var_1 = var_0._id_0336;

  if (isdefined(var_1) && isdefined(level._id_1115C["targetname"]) && isdefined(level._id_1115C["targetname"][var_1])) {
  foreach (var_4, var_3 in level._id_1115C["targetname"][var_1]) {
  if (isdefined(var_3) && var_0 == var_3)
  level._id_1115C["targetname"][var_1][var_4] = undefined;
  }

  if (level._id_1115C["targetname"][var_1].size == 0)
  level._id_1115C["targetname"][var_1] = undefined;
  }

  if (isdefined(level.struct)) {
  foreach (var_4, var_3 in level.struct) {
  if (var_0 == var_3)
  level.struct[var_4] = undefined;
  }
  }
}

_id_51D6(var_0, var_1) {
  if (!isdefined(var_0) || !isarray(var_0) || var_0.size == 0)
  return;

  var_1 = scripts\engine\utility::ter_op(isdefined(var_1), var_1, 0);
  var_1 = scripts\engine\utility::ter_op(var_1 > 0, var_1, 0);

  if (var_1 > 0) {
  foreach (var_3 in var_0) {
  _id_51D4(var_3);
  wait(var_1);
  }
  } else {
  foreach (var_3 in var_0)
  _id_51D4(var_3);
  }
}

_id_817F(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_817E(var_0, var_1);
  _id_51D4(var_2);
  return var_2;
}

_id_8181(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::_id_8180(var_0, var_1);
  _id_51D6(var_3, var_2);
  return var_3;
}

_id_13DCC(var_0) {
  var_1 = var_0 - self.origin;
  return (vectordot(var_1, anglestoforward(self.angles)), -1.0 * vectordot(var_1, anglestoright(self.angles)), vectordot(var_1, anglestoup(self.angles)));
}

_id_10460(var_0, var_1) {
  self _meth_8278(0, var_0);

  if (scripts\engine\utility::_id_9CEE(var_1))
  scripts\engine\utility::_id_50E1(var_0 + 0.05, ::stoploopsound);
  else
  scripts\engine\utility::_id_50E1(var_0 + 0.05, ::_meth_83AD);

  scripts\engine\utility::_id_50E1(var_0 + 0.1, ::delete);
}

_id_10461(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_1 = clamp(var_1, 0, 1);
  var_2 = max(0.05, var_2);
  self _meth_8278(0.0);
  wait 0.05;

  if (isdefined(var_3))
  self playloopsound(var_0);
  else
  self playsound(var_0);

  wait 0.05;
  scripts\engine\utility::_id_50E1(0.05, ::_meth_8278, var_1, var_2);
}

_id_5188() {
  self waittill("sounddone");
  self delete();
}

_id_5184(var_0) {
  self waittill(var_0);
  self delete();
}

_id_9ACE(var_0, var_1, var_2, var_3, var_4) {
  level._id_9AF3 = spawnstruct();
  level._id_9AF3._id_4480 = 3;
  level._id_9AF3._id_6AAA = 1.5;
  level._id_9AF3._id_6A9F = undefined;

  if (isdefined(var_3))
  level._id_9AF3._id_ACF2 = [var_0, var_1, var_2, var_3];
  else
  level._id_9AF3._id_ACF2 = [var_0, var_1, var_2];

  scripts\engine\utility::_id_C0A5(level._id_9AF3._id_ACF2, ::precachestring);
}

_id_9ACF(var_0) {
  level._id_9AF3._id_4C88 = var_0;
}

_id_9AD0(var_0, var_1, var_2) {
  level._id_9AF3._id_4480 = var_0;
  level._id_9AF3._id_6AAA = var_1;
  level._id_9AF3._id_6A9F = var_2;
}

_id_DE97(var_0, var_1, var_2) {
  scripts\anim\animset::_id_DEE7(var_0, var_1, var_2);
}

_id_2124(var_0) {
  return scripts\anim\animset::_id_2126(var_0);
}

_id_F2C8(var_0) {
  self._id_1F62 = var_0;
  self notify("move_loop_restart");

  if (var_0 == "creepwalk")
  self._id_0292 = 72;
}

_id_412C() {
  if (isdefined(self._id_1F62) && self._id_1F62 == "creepwalk")
  self._id_0292 = 30;

  self._id_1F62 = undefined;
  self notify("move_loop_restart");
}

_id_12641(var_0) {
  if (_func_119(var_0))
  return;

  if (!scripts\engine\utility::_id_6E34(var_0 + "_loaded"))
  scripts\engine\utility::_id_6E39(var_0 + "_loaded");

  _func_12F(var_0);

  while (!_func_119(var_0))
  scripts\engine\utility::waitframe();

  scripts\engine\utility::_id_6E3E(var_0 + "_loaded");
  level notify("new_transient_loaded");
}

_id_1264E(var_0) {
  if (!_func_119(var_0))
  return;

  _func_226(var_0);

  while (_func_119(var_0))
  scripts\engine\utility::waitframe();

  scripts\engine\utility::_id_6E2A(var_0 + "_loaded");
}

_id_12643(var_0) {
  foreach (var_2 in var_0)
  thread _id_12641(var_2);

  for (;;) {
  var_4 = 1;

  foreach (var_2 in var_0) {
  if (!_func_119(var_2)) {
  var_4 = 0;
  break;
  }
  }

  if (var_4)
  break;

  scripts\engine\utility::waitframe();
  }

  level notify("new_transient_loaded");
}

_id_12651(var_0) {
  foreach (var_2 in var_0)
  thread _id_1264E(var_2);

  for (;;) {
  var_4 = 1;

  foreach (var_2 in var_0) {
  if (_func_119(var_2)) {
  var_4 = 0;
  break;
  }
  }

  if (var_4)
  break;

  scripts\engine\utility::waitframe();
  }
}

_id_1263F(var_0) {
  scripts\engine\utility::_id_6E39(var_0 + "_loaded");
}

_id_1264C(var_0, var_1) {
  if (scripts\engine\utility::_id_6E25(var_0 + "_loaded"))
  _id_1264E(var_0);

  if (!scripts\engine\utility::_id_6E25(var_1 + "_loaded"))
  _id_12641(var_1);
}

_id_12653(var_0) {
  _func_225();
  _id_12641(var_0);
}

_id_F6DB(var_0, var_1, var_2) {
  if (!isdefined(level._id_4542))
  _id_F305();

  if (_id_9BEE())
  setdvar(var_0, var_2);
  else
  setdvar(var_0, var_1);
}

_id_F828(var_0, var_1, var_2) {
  if (!isdefined(level._id_4542))
  _id_F305();

  if (_id_9BEE())
  _func_1C5(var_0, var_2);
  else
  _func_1C5(var_0, var_1);
}

_id_7227(var_0, var_1) {
  self endon("death");
  self endon("stop_path");
  self notify("stop_going_to_node");
  self notify("follow_path");
  self endon("follow_path");
  wait 0.1;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;

  if (!isdefined(var_1))
  var_1 = 300;

  self._id_4B76 = var_2;
  var_2 _id_027B();

  while (isdefined(var_2)) {
  self._id_4B76 = var_2;

  if (isdefined(var_2._id_01BD))
  break;

  if (isdefined(level._id_1115C["targetname"][var_2._id_0336]))
  var_4 = ::_id_722A;
  else if (isdefined(var_2.classname))
  var_4 = ::_id_7228;
  else
  var_4 = ::_id_7229;

  if (isdefined(var_2.radius) && var_2.radius != 0)
  self._id_015C = var_2.radius;

  if (self._id_015C < 16)
  self._id_015C = 16;

  if (isdefined(var_2.height) && var_2.height != 0)
  self._id_015A = var_2.height;

  var_5 = self._id_015C;
  self childthread [[var_4]](var_2);

  if (isdefined(var_2.animation))
  var_2 waittill(var_2.animation);
  else
  {
  for (;;) {
  self waittill("goal");

  if (distance(var_2.origin, self.origin) < var_5 + 10 || self.team != "allies")
  break;
  }
  }

  var_2 notify("trigger", self);

  if (isdefined(var_2._id_ED9E))
  scripts\engine\utility::_id_6E3E(var_2._id_ED9E);

  if (isdefined(var_2._id_EE79)) {
  var_6 = strtok(var_2._id_EE79, " ");

  for (var_7 = 0; var_7 < var_6.size; var_7++) {
  if (isdefined(level._id_4C50))
  self [[level._id_4C50]](var_6[var_7], var_2);

  if (self.type == "dog")
  continue;

  switch (var_6[var_7]) {
  case "enable_cqb":
  _id_61E7();
  break;
  case "disable_cqb":
  _id_5514();
  break;
  case "deleteme":
  self delete();
  return;
  }
  }
  }

  if (!isdefined(var_2._id_EE95) && var_1 > 0 && self.team == "allies") {
  while (isalive(level.player)) {
  if (_id_722C(var_2, var_1))
  break;

  if (isdefined(var_2.animation)) {
  self._id_015C = var_5;
  self _meth_82EF(self.origin);
  }

  wait 0.05;
  }
  }

  if (!isdefined(var_2._id_0334))
  break;

  if (isdefined(var_2._id_EDA0))
  scripts\engine\utility::_id_6E4C(var_2._id_EDA0);

  var_2 _id_027B();
  var_2 = var_2 scripts\engine\utility::_id_7CD1();
  }

  self notify("path_end_reached");
}

_id_722C(var_0, var_1) {
  if (distance(level.player.origin, var_0.origin) < distance(self.origin, var_0.origin))
  return 1;

  var_2 = undefined;
  var_2 = anglestoforward(self.angles);
  var_3 = vectornormalize(level.player.origin - self.origin);

  if (isdefined(var_0._id_0334)) {
  var_4 = scripts\engine\utility::_id_7CD1(var_0._id_0334);
  var_2 = vectornormalize(var_4.origin - var_0.origin);
  }
  else if (isdefined(var_0.angles))
  var_2 = anglestoforward(var_0.angles);
  else
  var_2 = anglestoforward(self.angles);

  if (vectordot(var_2, var_3) > 0)
  return 1;

  if (distance(level.player.origin, self.origin) < var_1)
  return 1;

  return 0;
}

_id_7229(var_0) {
  self notify("follow_path_new_goal");

  if (isdefined(var_0.animation)) {
  var_0 _id_0B06::_id_1ECE(self, var_0.animation);
  self notify("starting_anim", var_0.animation);

  if (isdefined(var_0._id_EE79) && issubstr(var_0._id_EE79, "gravity"))
  var_0 _id_0B06::_id_1ECB(self, var_0.animation);
  else
  var_0 _id_0B06::_id_1ED1(self, var_0.animation);

  self _meth_82EF(self.origin);
  }
  else
  _id_F3D9(var_0);
}

_id_7228(var_0) {
  self notify("follow_path_new_goal");

  if (isdefined(var_0.animation)) {
  var_0 _id_0B06::_id_1ECE(self, var_0.animation);
  self notify("starting_anim", var_0.animation);

  if (isdefined(var_0._id_EE79) && issubstr(var_0._id_EE79, "gravity"))
  var_0 _id_0B06::_id_1ECB(self, var_0.animation);
  else
  var_0 _id_0B06::_id_1ED1(self, var_0.animation);

  self _meth_82EF(self.origin);
  }
  else
  _id_F3D3(var_0);
}

_id_722A(var_0) {
  self notify("follow_path_new_goal");

  if (isdefined(var_0.animation)) {
  var_0 _id_0B06::_id_1ECE(self, var_0.animation);
  self notify("starting_anim", var_0.animation);
  _id_5528();

  if (isdefined(var_0._id_EE79) && issubstr(var_0._id_EE79, "gravity"))
  var_0 _id_0B06::_id_1ECB(self, var_0.animation);
  else
  var_0 _id_0B06::_id_1ED1(self, var_0.animation);

  scripts\engine\utility::delaythread(0.05, ::_id_61F7);
  self _meth_82EF(self.origin);
  }
  else
  _id_F3DC(var_0.origin);
}

_id_D6D9(var_0) {
  if (!isdefined(level._id_D6D8))
  level._id_D6D8 = [];

  level._id_D6D8 = scripts\engine\utility::_id_2279(level._id_D6D8, var_0);
}

_id_765B() {
  if (level._id_13E0F)
  return 1;

  if (level._id_DADB)
  return 1;

  return 0;
}

_id_12B17(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "on");
}

_id_12B16(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "turn_off");
}

_id_12B18(var_0) {
  var_1 = "ui_actionslot_" + var_0 + "_forceActive";
  setdvar(var_1, "onetime");
}

_id_8C32(var_0, var_1) {
  if (!isdefined(level._id_8BB1))
  level._id_8BB1 = [];

  var_2 = var_0 + "_" + var_1;

  if (isdefined(level._id_8BB1[var_2]))
  return level._id_8BB1[var_2];

  var_3 = _func_0BC(var_0);

  if (var_3 > 0) {
  for (var_4 = 0; var_4 < var_3; var_4++) {
  var_5 = tolower(_func_0BF(var_0, var_4));

  if (var_5 == tolower(var_1)) {
  level._id_8BB1[var_2] = 1;
  return 1;
  }
  }

  level._id_8BB1[var_2] = 0;
  }

  return 0;
}

_id_1119E(var_0, var_1, var_2, var_3) {
  if (!isarray(var_0))
  var_0 = [var_0];

  var_4 = 320;
  var_5 = 200;
  var_6 = [];

  foreach (var_10, var_8 in var_0) {
  var_9 = _id_0B45::_id_111A0(var_8, var_1, var_4, var_5 + var_10 * 20, "center", var_2, var_3);
  var_6 = scripts\engine\utility::_id_227F(var_9, var_6);
  }

  wait(var_1);
  _id_0B45::_id_1119F(var_6, var_4, var_5, var_0.size);
}

_id_97A2() {
  if (!scripts\engine\utility::_id_16F3("waits", ::_id_97A2))
  return;

  level._id_13711 = spawnstruct();
  level._id_13711._id_13590 = [];
  level._id_13711._id_E7F9 = [];
  level._id_13711._id_E7E0 = [];
  level._id_13711._id_E80A = [];
  level._id_13711._id_57D7 = [];
  level._id_13711._id_1523 = [];
}

_id_F5AF(var_0, var_1) {
  var_2 = [];

  if (isstring(var_0))
  var_2 = scripts\engine\utility::_id_7CCF(var_0);
  else if (isarray(var_0))
  var_2 = var_0;

  if (var_2.size == 0)
  return;

  foreach (var_4 in var_1) {
  var_5 = undefined;

  foreach (var_7 in var_2) {
  if (!isdefined(var_7.script_noteworthy))
  continue;

  if (isplayer(var_4)) {
  if (var_7.script_noteworthy == "player") {
  var_5 = var_7;
  break;
  }
  }
  else if (isdefined(var_4.script_noteworthy) && var_4.script_noteworthy == var_7.script_noteworthy) {
  var_5 = var_7;
  break;
  }
  }

  if (isdefined(var_5)) {
  var_5._id_1146E = 1;
  var_4._id_10CBA = var_5;

  if (isai(var_4))
  var_4 _meth_82EF(var_5.origin);

  var_4 _id_11624(var_5);
  }
  }

  foreach (var_4 in var_1) {
  if (isdefined(var_4._id_10CBA))
  continue;

  foreach (var_7 in var_2) {
  if (!isdefined(var_7._id_1146E)) {
  var_7._id_1146E = 1;
  var_4._id_10CBA = var_7;

  if (isai(var_4))
  var_4 _meth_82EF(var_7.origin);

  var_4 _id_11624(var_7);
  break;
  }
  }
  }
}

_id_A6F2(var_0) {}

_id_61F0(var_0) {
  _id_0B27::_id_5F84(var_0);
}

_id_5522() {
  _id_0B27::_id_5557();
}

_id_D08C(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;

  if (level.player _id_7B8C() == "safe") {
  var_3 = 1.0;
  var_4 = 1;
  }

  var_5 = 0;

  if (isdefined(var_1))
  var_2 = self _meth_8441(var_0, var_1, var_5, var_3, undefined);
  else
  var_2 = self _meth_8441(var_0, undefined, var_5, var_3, undefined);

  return var_2;
}

_id_D091(var_0, var_1) {
  self endon("death");

  if (self _meth_819F())
  return 0;

  if (self _meth_81B8())
  return 0;

  return _id_D090(var_0, var_1);
}

_id_D090(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = undefined;
  var_4 = 0;

  if (level.player _id_7B8C() == "safe") {
  var_3 = 0.2;
  var_4 = 1;
  }

  if (isdefined(var_1) && _func_2A6(var_1))
  var_2 = self _meth_846F(var_0, var_1, var_3, undefined, undefined);
  else
  var_2 = self _meth_846F(var_0, undefined, var_3, undefined, undefined);

  if (var_2)
  thread _id_0E49::_id_D092(var_0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1);

  return var_2;
}

_id_77DB(var_0) {
  return level._id_1162[var_0]._id_10878 + level._id_1162[var_0]._id_1A09;
}

_id_77DD(var_0) {
  level._id_1162[var_0]._id_1912 = _id_22BB(level._id_1162[var_0]._id_1912);
  level._id_1162[var_0]._id_1912 = scripts\engine\utility::_id_22BC(level._id_1162[var_0]._id_1912);
  return level._id_1162[var_0]._id_1A09;
}

_id_77DE(var_0) {
  return level._id_1162[var_0]._id_10878;
}

_id_77DC(var_0) {
  return level._id_1162[var_0]._id_1A0D;
}

_id_77DF(var_0) {
  return level._id_1162[var_0]._id_1087B;
}

_id_77DA(var_0) {
  level._id_1162[var_0]._id_1912 = _id_22BB(level._id_1162[var_0]._id_1912);
  level._id_1162[var_0]._id_1912 = scripts\engine\utility::_id_22BC(level._id_1162[var_0]._id_1912);
  return level._id_1162[var_0]._id_1912;
}

_id_75C4(var_0, var_1, var_2, var_3) {
  if (!isdefined(self._id_760A))
  _id_75CE();

  thread _id_75C5(var_0, var_1, var_2, var_3);
}

_id_75C5(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");

  if (isdefined(var_3))
  self endon(var_3);

  if (isdefined(var_2))
  wait(var_2);

  _id_75CD();
  _id_1173C(var_1, var_0);
  playfxontag(scripts\engine\utility::_id_7ECB(var_0), self, var_1);
}

_id_75F8(var_0, var_1, var_2, var_3) {
  if (!isdefined(self._id_760A))
  _id_75CE();

  thread _id_75F9(var_0, var_1, var_2, var_3);
}

_id_1173C(var_0, var_1) {
  if (self._id_01F1 == "") {}

  if (!_id_8C32(self._id_01F1, var_0))
  return;
}

_id_75F9(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");

  if (isdefined(var_3))
  self endon(var_3);

  if (isdefined(var_2))
  wait(var_2);

  _id_75CD();
  _id_1173C(var_1, var_0);
  stopfxontag(scripts\engine\utility::_id_7ECB(var_0), self, var_1);
}

_id_75A0(var_0, var_1, var_2, var_3) {
  if (!isdefined(self._id_760A))
  _id_75CE();

  thread _id_75A1(var_0, var_1, var_2, var_3);
}

_id_75A1(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");

  if (isdefined(var_3))
  self endon(var_3);

  if (isdefined(var_2))
  wait(var_2);

  _id_75CD();
  _id_1173C(var_1, var_0);
  _func_121(scripts\engine\utility::_id_7ECB(var_0), self, var_1);
}

_id_79E1() {
  self._id_7609++;
  return _id_11145(self._id_7609);
}

_id_75CE() {
  if (isdefined(self._id_760A))
  return;

  self._id_760A = [];
  self._id_7609 = 0;
  thread _id_75CF();
}

_id_75CF() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = 0;

  for (;;) {
  self waittill("new_fx_call");

  while (self._id_760A.size > 0) {
  var_1 = self._id_760A[0];
  self._id_760A = scripts\engine\utility::array_remove(self._id_760A, var_1);
  self notify(var_1);
  var_0++;

  if (var_0 == 3) {
  wait 0.05;
  var_0 = 0;
  }
  }
  }
}

_id_75CD() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = _id_79E1();
  self._id_760A = scripts\engine\utility::_id_2279(self._id_760A, var_0);
  self notify("new_fx_call");
  self waittill(var_0);
}

_id_1102B(var_0) {
  if (isdefined(var_0))
  self _meth_8442(var_0);
  else
  self _meth_8442();

  self notify("gesture_stop");
}

_id_F526(var_0, var_1) {
  self notify("entering_new_demeanor");

  if (!isdefined(self._id_77C1))
  self._id_77C1 = spawnstruct();

  waittillframeend;

  switch (var_0) {
  case "normal":
  _id_0E49::_id_660C();
  break;
  case "relaxed":
  _id_0E49::_id_660D();
  break;
  case "safe":
  _id_0E49::_id_660E(var_1);
  break;
  case "magboots":
  _id_0E49::_id_660B();
  break;
  default:
  break;
  }
}

_id_7B8C() {
  return level.player _meth_846D();
}

_id_960B() {
  if (!isdefined(level._id_84D9)) {
  level._id_84D9 = getdvarint("bg_gravity");
  level._id_8519 = getomnvar("physics_gravity_z");
  }
}

_id_EBA6(var_0, var_1) {
  _id_960B();

  if (isdefined(var_0))
  _func_1C5("bg_gravity", level._id_84D9 * var_0);

  if (isdefined(var_1))
  _func_27F((0, 0, level._id_8519 * var_1));
}

_id_241F(var_0) {
  if (!isdefined(var_0))
  var_0 = 1;

  if (var_0 && !level._id_241D)
  level._id_241D = var_0;
  else if (!var_0 && level._id_241D)
  level._id_241D = var_0;

  if (isdefined(level._id_A056) && isdefined(level._id_A056._id_241A))
  [[level._id_A056._id_241A]](level._id_241D);
}

_id_F3E4(var_0, var_1) {
  _id_960B();

  if (isdefined(var_0))
  _func_1C5("bg_gravity", var_0);

  if (isdefined(var_1))
  _func_27F((0, 0, var_1));
}

_id_E1F0() {
  _func_1C5("bg_gravity", level._id_84D9);
  _func_27F((0, 0, level._id_8519));
}

_id_77B9(var_0) {
  if (isdefined(self._id_12BA4) && self._id_12BA4 == "c6")
  thread _id_0C4C::_id_1965(var_0);
  else
  {
  thread _id_0C4C::_id_194F(var_0 * 0.1);
  thread _id_0C4C::_id_1964(var_0);
  }

  self notify("stop_lookat");
  self notify("gesture_natural_stop");
  self._id_D4A4 = undefined;
}

_id_77BD(var_0) {
  thread _id_0C4C::_id_1967(var_0);
}

_id_7793(var_0) {
  thread _id_0C4C::_id_194F(var_0);
}

_id_779E(var_0) {
  if (self._id_12BA4 == "c6")
  thread _id_0C4C::_id_1965(var_0);
  else
  _id_0C4C::_id_1964(var_0);

  self notify("stop_lookat");
}

_id_7799(var_0, var_1, var_2) {
  self endon("death");
  thread _id_0C4C::_id_1955(var_0, var_1, var_2);
}

_id_779A(var_0, var_1, var_2, var_3) {
  thread _id_0C4C::_id_1956(var_0, var_1, var_2, var_3);
}

_id_7798(var_0, var_1, var_2) {
  thread _id_0C4C::_id_194E(var_0, var_1, var_2);
}

_id_779C(var_0, var_1) {
  thread _id_0C4C::_id_1959(var_0, var_1);
}

_id_779B(var_0, var_1) {
  _id_0C4C::_id_196A(var_0, var_1);
}

_id_7797(var_0, var_1) {
  _id_0C4C::_id_1969(var_0, var_1);
}

_id_77A9(var_0) {
  _id_0C4C::_id_195D(var_0);
}

_id_77B7(var_0) {
  _id_0C4C::_id_1960(var_0);
}

_id_7791(var_0, var_1, var_2) {
  _id_0C4C::_id_194C(var_0, var_1, var_2);
}

_id_7790(var_0, var_1) {
  _id_0C4C::_id_192F(var_0, var_1);
}

_id_7792(var_0, var_1) {
  self endon("death");
  self endon("stop_lookat");
  self endon("eye_gesture_stop");

  if (!isdefined(self._id_9BDC))
  thread _id_7798(var_0, 4.0, 0.1);

  if (isdefined(var_1) && var_1)
  thread _id_7799(var_0, 0.15, 0.7);

  wait 0.7;

  for (;;) {
  thread _id_7797(var_0, 2.0);
  wait(randomfloatrange(3.0, 5.0));
  var_2 = var_0 geteye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
  thread _id_7797(var_2, 2.0);
  wait(randomfloatrange(0.25, 0.5));

  if (scripts\engine\utility::_id_4347()) {
  var_2 = var_0 geteye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
  thread _id_7797(var_2, 2.0);
  wait(randomfloatrange(0.25, 0.5));
  }
  }
}

_id_77B8(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("gesture_stop");
  var_4 = squared(var_1);
  _id_0B44::_id_168F();
  var_5 = distance2dsquared(self.origin, var_2.origin);

  for (;;) {
  if (var_5 < var_4 && _id_0B44::_id_3838(var_1 * 3.0))
  break;

  var_5 = distance2dsquared(self.origin, var_2.origin);
  scripts\engine\utility::waitframe();
  }

  self._id_D4A4 = 1;

  if (isdefined(var_3)) {
  thread _id_77B7(var_0);
  self [[var_3]]();
  }
  else
  _id_77B7(var_0);

  wait 2.0;
  _id_0B44::_id_DFB5();
  self._id_D4A4 = 0;
}

_id_D123() {
  var_0 = level.player _meth_8473();

  if (isdefined(var_0))
  return 1;
  else
  return 0;
}

_id_7B9D() {
  return level._id_D127._id_B154 / _id_0B35::_id_7A59();
}

_id_A1A8(var_0) {
  if (!isdefined(level._id_A056))
  return 0;

  if (!isdefined(level._id_A056._id_68B3))
  return 0;

  if (!isdefined(var_0))
  return level._id_A056._id_68B3.running;
  else if (!isdefined(level._id_A056._id_68B3._id_68B6[var_0]))
  return 0;
  else
  return level._id_A056._id_68B3._id_68B6[var_0].running;
}

_id_13793() {
  while (_id_A1A8())
  wait 0.05;
}

_id_13792(var_0, var_1) {
  if (!isdefined(var_1))
  var_1 = 1;

  while (!isdefined(level._id_A056._id_68B3._id_68B6[var_0]))
  wait 0.05;

  while (!_id_A1A8(var_0))
  wait 0.05;

  if (var_1) {
  while (_id_A1A8(var_0))
  wait 0.05;
  }
}

_id_D15B(var_0) {
  if (!isdefined(level._id_A056))
  return 0;

  if (level._id_A056._id_D3C1 == var_0)
  return 1;
  else
  return 0;
}

_id_B324() {
  if (isdefined(level._id_A056) && level._id_A056._id_B323)
  return 1;
  else
  return 0;
}

_id_793C(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = var_0[1] - var_3[1];
  var_4 = var_4 + 360;
  var_4 = int(var_4) % 360;

  if (var_4 > 350 || var_4 < 10)
  var_5 = "8";
  else if (var_4 < 60)
  var_5 = "9";
  else if (var_4 < 120)
  var_5 = "6";
  else if (var_4 < 150)
  var_5 = "3";
  else if (var_4 < 210)
  var_5 = "2";
  else if (var_4 < 240)
  var_5 = "1";
  else if (var_4 < 300)
  var_5 = "4";
  else
  var_5 = "7";

  return var_5;
}

_id_1C49(var_0) {
  if (var_0) {
  if (!isdefined(self._id_55CA))
  self._id_55CA = 0;

  self._id_55CA--;

  if (!self._id_55CA)
  level.player _id_65DD("no_grenade_block_gesture");
  } else {
  if (!isdefined(self._id_55CA))
  self._id_55CA = 0;

  self._id_55CA++;
  level.player _id_65E1("no_grenade_block_gesture");
  }
}

_id_1C75(var_0) {
  if (var_0) {
  if (!isdefined(self._id_55E8))
  self._id_55E8 = 0;

  self._id_55E8--;

  if (!self._id_55E8)
  scripts\engine\utility::_id_6E2A("weapon_scanning_off");
  } else {
  if (!isdefined(self._id_55E8))
  self._id_55E8 = 0;

  self._id_55E8++;
  scripts\engine\utility::_id_6E3E("weapon_scanning_off");
  }
}

_id_1C39(var_0) {
  if (var_0) {
  if (!isdefined(self._id_55C0))
  self._id_55C0 = 0;

  self._id_55C0--;

  if (!self._id_55C0)
  level.player _id_65DD("disable_antigrav_float");
  } else {
  if (!isdefined(self._id_55C0))
  self._id_55C0 = 0;

  self._id_55C0++;

  if (!level.player _id_65DF("disable_antigrav_float"))
  level.player _id_65E0("disable_antigrav_float");

  level.player _id_65E1("disable_antigrav_float");
  }
}

_id_1C3E(var_0) {
  if (var_0) {
  if (!isdefined(self._id_55C2))
  self._id_55C2 = 0;

  self._id_55C2--;

  if (!self._id_55C2)
  _func_1C5("cg_drawCrosshair", 1);
  } else {
  if (!isdefined(self._id_55C2))
  self._id_55C2 = 0;

  self._id_55C2++;
  _func_1C5("cg_drawCrosshair", 0);
  }
}

_id_1C72(var_0) {
  if (var_0) {
  if (!isdefined(self._id_55E7))
  self._id_55E7 = 0;

  self._id_55E7--;

  if (!self._id_55E7)
  _func_1C5("bg_disableWeaponFirstRaiseAnims", 0);
  } else {
  if (!isdefined(self._id_55E7))
  self._id_55E7 = 0;

  self._id_55E7++;
  _func_1C5("bg_disableWeaponFirstRaiseAnims", 1);
  }
}

_id_82EA(var_0) {
  _id_1143E();
  self giveweapon(var_0);
  self _meth_84E8(var_0);
}

_id_1143E() {
  var_0 = self _meth_8524();

  if (var_0 != "none")
  self _meth_83B8(var_0);
}

_id_7AD7() {
  var_0 = self _meth_8524();

  if (var_0 != "none")
  return var_0;
  else
  return undefined;
}

_id_8294(var_0) {
  self._id_1586 = var_0;
  self giveweapon(var_0);

  if (!isdefined(self._id_55BD) || !self._id_55BD)
  self _meth_8299(1, "weapon", var_0);
}

_id_11425() {
  self _meth_8299(1, "");
  self _meth_83B8(self._id_1586);
  self._id_1586 = undefined;
}

_id_77C9() {
  if (isdefined(self._id_1586))
  return self._id_1586;
  else
  return "";
}

_id_1C34(var_0) {
  if (var_0) {
  if (!isdefined(self._id_55BD))
  self._id_55BD = 0;

  self._id_55BD--;

  if (!self._id_55BD) {
  if (isdefined(self._id_1586))
  self _meth_8299(1, "weapon", self._id_1586);
  }
  } else {
  if (!isdefined(self._id_55BD))
  self._id_55BD = 0;

  self._id_55BD++;
  self _meth_8299(1, "");
  }
}

_id_9B4D() {
  if (!isdefined(self._id_55BD))
  return 1;

  if (!self._id_55BD)
  return 1;
  else
  return 0;
}

_id_7D74(var_0, var_1) {
  if (isdefined(var_0) && var_0 == 1)
  var_2 = level.player _meth_8172("primary", "altmode");
  else
  var_2 = level.player _meth_8172("primary");

  var_3 = [];
  var_4 = level.player _id_7AD7();

  if (isdefined(var_4) && (!isdefined(var_1) || var_1 == 0)) {
  foreach (var_6 in var_2) {
  if (var_6 != var_4)
  var_3[var_3.size] = var_6;
  }
  }
  else
  var_3 = var_2;

  return var_3;
}

_id_1145A(var_0) {
  _id_0B29::_id_11456(var_0);
  self _meth_83B8(var_0);
}

_id_11428() {
  _id_0B29::_id_11427();
  self takeallweapons();
}

_id_9C8D() {
  return scripts\engine\utility::_id_6E25("primary_equipment_input_down");
}

_id_9C11() {
  if (self == level.player) {
  if (!isdefined(self._id_93B5) || self._id_93B5 == 0)
  return 0;
  else
  return 1;
  }
  else if (!isdefined(self._id_2023))
  return 0;
  else
  return 1;
}

_id_13657() {
  scripts\engine\utility::_id_6E5A("primary_equipment_input_down");
}

_id_13655() {
  scripts\engine\utility::_id_6E4C("primary_equipment_input_down");
}

_id_13656() {
  self waittill("primary_equipment_pressed");
  scripts\engine\utility::_id_6E4C("primary_equipment_input_down");
}

_id_9C8E() {
  return scripts\engine\utility::_id_6E25("primary_equipment_in_use");
}

_id_9CB5() {
  return scripts\engine\utility::_id_6E25("secondary_equipment_input_down");
}

_id_13662() {
  scripts\engine\utility::_id_6E5A("secondary_equipment_input_down");
}

_id_13660() {
  scripts\engine\utility::_id_6E4C("secondary_equipment_input_down");
}

_id_13661() {
  self waittill("secondary_equipment_pressed");
  scripts\engine\utility::_id_6E4C("secondary_equipment_input_down");
}

_id_9CB6() {
  return scripts\engine\utility::_id_6E25("secondary_equipment_in_use");
}

_id_7BD6() {
  if (level.player._id_4B2B == "")
  return undefined;
  else
  return level.player._id_4B2B;
}

_id_7BD7() {
  if (level.player._id_4B2B == "")
  return 0;
  else if (_id_799D(level.player._id_4B2B) == "drain")
  return 1;
  else
  return level.player getammocount(level.player._id_4B2B);
}

_id_7C3D() {
  if (level.player._id_4B21 == "")
  return undefined;
  else
  return level.player._id_4B21;
}

_id_7C3E() {
  if (level.player._id_4B21 == "")
  return 0;
  else if (_id_799D(level.player._id_4B21) == "drain")
  return 1;
  else
  return level.player getammocount(level.player._id_4B21);
}

_id_7CAF() {
  if (level.player._id_110BD == "")
  return undefined;
  else
  return level.player._id_110BD;
}

_id_7CB0() {
  if (level.player._id_110BD != "" && _id_799D(level.player._id_110BD) == "drain")
  return 1;

  return level.player._id_110BE;
}

_id_7CB1() {
  if (level.player._id_110BA == "")
  return undefined;
  else
  return level.player._id_110BA;
}

_id_7CB2() {
  if (level.player._id_110BA != "" && _id_799D(level.player._id_110BA) == "drain")
  return 1;

  return level.player._id_110BB;
}

_id_799C(var_0) {
  var_1 = [::_id_7BD6, ::_id_7CAF, ::_id_7C3D, ::_id_7CB1];
  var_2 = [::_id_7BD7, ::_id_7CB0, ::_id_7C3E, ::_id_7CB2];

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
  var_4 = [[var_1[var_3]]]();
  var_5 = [[var_2[var_3]]]();

  if (isdefined(var_4) && var_4 == var_0)
  return var_5;
  }
}

_id_D0C9() {
  if (!isdefined(level.player._id_110C0) || !level.player._id_110C0)
  return 0;
  else
  return 1;
}

_id_799D(var_0) {
  return _id_0B29::_id_129C(var_0);
}

_id_78E4() {
  if (getdvarint("ai_corpseSynch"))
  return self _meth_82CC();

  return self.origin;
}

_id_9187(var_0, var_1, var_2) {
  _id_0B58::_id_9188(var_0, var_1, var_2);
}

_id_9189(var_0, var_1, var_2) {
  _id_0B58::_id_918A(var_0, var_1, var_2);
}

_id_9199(var_0, var_1) {
  _id_0B58::_id_919A(var_0, var_1);
}

_id_9196(var_0, var_1, var_2, var_3) {
  _id_0B58::_id_9197(var_3, var_0, var_1, var_2, 0);
}

_id_9198(var_0, var_1, var_2, var_3) {
  _id_0B58::_id_9197(var_3, var_0, var_1, var_2, 1);
}

_id_9193(var_0) {
  _id_0B58::_id_9194(var_0);
}

_id_918D(var_0, var_1) {
  _id_0B58::_id_CC8D(var_0, var_1);
  level notify("hudoutline_anim_complete");
  level notify("hudoutline_anim_complete" + var_0);
}

_id_918E(var_0, var_1) {
  thread _id_0B58::_id_CC8E(var_0, var_1);
}

_id_91A9(var_0) {
  if (!isdefined(var_0))
  var_0 = 1;

  _func_1C5("r_hudoutlineEnable", 1);
  var_1 = "0.5 0.5 0.5";
  var_2 = "1 1 1";

  if (var_0) {
  var_1 = "0.5 0.5 0.5 1";
  var_2 = "0.5 0.5 0.5 0.2";
  var_3 = "0.5 0.5 0.5 1";
  var_4 = "0.7 0.7 0.7 1";
  var_5 = "0.5 0.5 0.5 1";
  } else {
  var_1 = "0.5 0.5 0.5 0";
  var_2 = "0.5 0.5 0.5 0";
  var_3 = "0.5 0.5 0.5 1";
  var_4 = "0.5 0.5 0.5 0.5";
  var_5 = "0.5 0.5 0.5 0.5";
  }

  _func_1C5("r_hudoutlineFillColor0", var_1);
  _func_1C5("r_hudoutlineFillColor1", var_2);
  _func_1C5("r_hudoutlineOccludedOutlineColor", var_3);
  _func_1C5("r_hudoutlineOccludedInlineColor", var_4);
  _func_1C5("r_hudoutlineOccludedInteriorColor", var_5);
  _func_1C5("r_hudOutlineOccludedColorFromFill", 1);
}

_id_91A8(var_0, var_1) {
  var_2["allies"] = "friendly";
  var_2["axis"] = "enemy";
  var_2["team3"] = "neutral";
  var_2["dead"] = "neutral";

  if (isdefined(var_1))
  var_3 = var_1;
  else if (isdefined(self.team))
  var_3 = self.team;
  else
  var_3 = "dead";

  if (var_0 && isdefined(var_2[var_3]))
  _id_F40A(var_2[var_3], 0);
  else
  self _meth_818B();
}

_id_9131(var_0) {
  setomnvar("ui_show_bink", 1);
  _func_1C5("bg_cinematicFullScreen", "0");
  _func_1C5("bg_cinematicCanPause", "1");
  _func_03D(var_0);

  while (!iscinematicplaying())
  scripts\engine\utility::waitframe();

  while (iscinematicplaying())
  scripts\engine\utility::waitframe();

  _func_1F1();
  setomnvar("ui_show_bink", 0);
  _func_1C5("bg_cinematicFullScreen", "1");
  _func_1C5("bg_cinematicCanPause", "1");
}

_id_918B(var_0, var_1, var_2) {
  if (isdefined(level.player._id_20F8))
  _id_918C();

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait 0.05;
  _func_1C5("r_hudoutlineEnable", 1);
  level.player._id_20F8 = scripts\engine\utility::_id_107E6();
  setomnvar("ui_inworld_ar_ent", level.player._id_20F8);

  if (!isdefined(var_0))
  var_0 = "ar_callouts_default";

  setomnvar("ui_ar_object_text", var_0);
  wait 0.05;

  if (isdefined(var_1) && var_1)
  _id_9196(6, 1, 1, "default");
  else
  _id_9196(6, 0, 1, "default");

  setomnvar("ui_show_ar_elem", 1);
  thread _id_1182(var_2);
}

_id_1182(var_0) {
  level.player endon("stop_ar_callout");
  self endon("death");

  for (;;) {
  if (isdefined(var_0))
  var_1 = self.origin + var_0;
  else
  var_1 = self.origin + (0, 0, 30);

  level.player._id_20F8.origin = var_1;
  wait 0.05;
  }
}

_id_918C() {
  _id_9193("default");
  setomnvar("ui_show_ar_elem", 0);
  wait 0.1;
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player._id_20F8 delete();
  level.player._id_20F8 = undefined;
}

_id_9145(var_0, var_1) {
  if (!isdefined(var_0))
  var_0 = "fluff_messages_default";

  if (!isdefined(var_1))
  var_1 = 1;

  setomnvar("ui_sp_fluff_messaging", var_0);
  setomnvar("ui_sp_fluff_messaging_context", var_1);
}

_id_914C(var_0, var_1, var_2, var_3) {
  var_4 = 20;

  if (!isdefined(var_2))
  var_2 = "default";

  switch (var_2) {
  case "intel_acepilot0":
  var_4 = 0;
  break;
  case "intel_acepilot1":
  var_4 = 1;
  break;
  case "intel_acepilot2":
  var_4 = 2;
  break;
  case "intel_acepilot3":
  var_4 = 3;
  break;
  case "intel_acepilot4":
  var_4 = 4;
  break;
  case "intel_acepilot5":
  var_4 = 5;
  break;
  case "intel_acepilot6":
  var_4 = 6;
  break;
  case "intel_acepilot7":
  var_4 = 7;
  break;
  case "intel_acepilot8":
  var_4 = 8;
  break;
  case "intel_acepilot9":
  var_4 = 9;
  break;
  case "intel_acepilot10":
  var_4 = 10;
  break;
  case "intel_acepilot11":
  var_4 = 11;
  break;
  case "intel_acepilot12":
  var_4 = 12;
  break;
  case "intel_acepilot13":
  var_4 = 13;
  break;
  case "intel_acepilot14":
  var_4 = 14;
  break;
  case "intel_acepilot15":
  var_4 = 15;
  break;
  case "intel_acepilot16":
  var_4 = 16;
  break;
  case "intel_acepilot17":
  var_4 = 17;
  break;
  case "intel_acepilot18":
  var_4 = 18;
  break;
  case "intel_acepilot19":
  var_4 = 19;
  break;
  case "default":
  var_4 = 20;
  break;
  case "capops_intel":
  var_4 = 20;
  break;
  case "tally_intel":
  var_4 = 21;
  break;
  case "jackal_intel":
  var_4 = 22;
  break;
  case "sdf_intel_1":
  var_4 = 23;
  break;
  case "news_intel":
  var_4 = 24;
  break;
  case "eweapon_intel":
  var_4 = 25;
  break;
  case "scan_intel":
  var_4 = 26;
  break;
  case "intel_captain0":
  var_4 = 27;
  break;
  case "intel_captain1":
  var_4 = 28;
  break;
  case "intel_captain2":
  var_4 = 29;
  break;
  case "intel_captain3":
  var_4 = 30;
  break;
  case "intel_captain4":
  var_4 = 31;
  break;
  case "intel_captain5":
  var_4 = 32;
  break;
  case "intel_captain6":
  var_4 = 33;
  break;
  case "intel_captain7":
  var_4 = 34;
  break;
  case "intel_captain8":
  var_4 = 35;
  break;
  case "intel_captain9":
  var_4 = 36;
  break;
  case "intel_scrap":
  var_4 = 37;
  break;
  case "intel_reticle":
  var_4 = 38;
  break;
  case "intel_attachment":
  var_4 = 39;
  break;
  }

  setomnvar("ui_sp_intel_messaging_image_index", var_4);
  setomnvar("ui_sp_intel_messaging_text", var_1);
  setomnvar("ui_sp_intel_messaging_header", var_0);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread _id_12EE();
  var_5 = var_2 == "tally_intel";

  if (var_5)
  level.player thread _id_12ED();

  if (isdefined(var_3))
  setomnvar("ui_sp_intel_messaging_ent", 1);
  else
  setomnvar("ui_sp_intel_messaging_ent", 0);

  var_6 = "close";
  var_7 = gettime() / 1000;
  var_8 = 5.0;

  while (var_5 && !isdefined(level.player._id_9951) || !var_5 && gettime() / 1000 - var_7 < var_8) {
  if (isdefined(level.player._id_9963)) {
  var_6 = "waypoint";
  break;
  }

  wait 0.05;
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player._id_9951 = undefined;

  if (var_6 == "waypoint" && isdefined(var_3)) {
  var_9 = scripts\engine\utility::_id_107CE(var_3, (0, 0, 0));
  var_9._id_928E = newhudelem();
  var_9._id_928E setshader("intel_hint_icon", 32, 32);
  var_9._id_928E._id_00B9 = (0, 1, 0.976);
  var_9._id_928E.alpha = 1.0;
  var_9._id_928E setwaypoint(1, 1, 0);
  var_9._id_928E _meth_8346(var_9);
  var_10 = distance2dsquared(level.player.origin, var_9.origin);

  for (;;) {
  if (distance2dsquared(level.player.origin, var_9.origin) < squared(75.0) || distance2dsquared(level.player.origin, var_9.origin) > var_10 * 2.5)
  break;

  wait 0.05;
  }

  var_9._id_928E destroy();
  var_9 delete();
  level.player._id_9963 = undefined;
  } else {
  level.player notify("dismiss_skipped");
  level.player._id_9951 = undefined;
  return;
  }
}

_id_12EE() {
  level notify("stopstop_intel_waypoint_int");
  level endon("stop_intel_waypoint");
  self._id_9963 = undefined;
  self notifyonplayercommand("set_waypoint", "+weapnext");
  self waittill("set_waypoint");
  self._id_9963 = 1;
}

_id_12ED() {
  self endon("dismiss_skipped");
  self notifyonplayercommand("intel_dismiss", "+gostand");
  self notifyonplayercommand("intel_dismiss", "+activate");
  self notifyonplayercommand("intel_dismiss", "+usereload");
  self waittill("intel_dismiss");
  self._id_9951 = 1;
}

_id_9674() {
  var_0 = getentarray("manipulate_ent", "script_noteworthy");
  scripts\engine\utility::_id_22D2(var_0, ::_id_B2FC);
}

_id_B2FC() {
  if (isdefined(self._id_EDA0))
  scripts\engine\utility::_id_6E39(self._id_EDA0);

  if (isdefined(self._id_ED48))
  scripts\engine\utility::_id_6E39(self._id_ED48);

  if (isdefined(self._id_EE9E)) {
  self._id_10BA1 = self.angles;

  if (!isdefined(self._id_EE9C))
  self._id_EE9C = (0, 0, 0);

  self._id_E746 = [];

  for (var_0 = 0; var_0 < 3; var_0++) {
  if (self._id_EE9C[var_0] != 0) {
  if (self._id_EE9E[var_0] > 0) {
  self._id_E746[var_0] = _id_0B4D::_id_10AB0(self._id_EE9E[var_0] * 10, 0, self._id_10BA1[var_0] + self._id_EE9C[var_0], 0);
  continue;
  }
  }
  }

  thread _id_E702();
  }

  if (isdefined(self._id_EEEA)) {
  self._id_10CCA = self.origin;

  if (!isdefined(self._id_EEE9))
  self._id_EEE9 = (0, 0, 0);

  self._id_12689 = [];

  for (var_0 = 0; var_0 < 3; var_0++) {
  if (self._id_EEE9[var_0] != 0) {
  if (self._id_EEEA[var_0] > 0) {
  self._id_12689[var_0] = _id_0B4D::_id_10AB0(self._id_EEEA[var_0] * 10, 0, self._id_10CCA[var_0] + self._id_EEE9[var_0], 0);
  continue;
  }
  }
  }

  thread _id_12686();
  }

  thread _id_B2FB();
  thread _id_B2FA();
}

_id_12686() {
  self endon("death");
  self endon("stop_manipulate_ent");

  if (isdefined(self._id_EDA0))
  scripts\engine\utility::_id_6E4C(self._id_EDA0);

  for (;;) {
  var_0 = [];

  for (var_1 = 0; var_1 < 3; var_1++) {
  if (self._id_EEEA[var_1] == 0) {
  var_0[var_1] = self._id_10CCA[var_1];
  continue;
  }

  if (self._id_EEEA[var_1] != 0 && self._id_EEE9[var_1] == 0) {
  var_0[var_1] = self.origin[var_1] + self._id_EEEA[var_1] / 20;
  continue;
  }

  if (self._id_EEEA[var_1] > 0 && self._id_EEE9[var_1] != 0)
  var_0[var_1] = _id_0B4D::_id_10AB4(self._id_12689[var_1], self._id_10CCA[var_1]);
  }

  self.origin = (var_0[0], var_0[1], var_0[2]);
  scripts\engine\utility::waitframe();
  }
}

_id_E702() {
  self endon("death");
  self endon("stop_manipulate_ent");

  if (isdefined(self._id_EDA0))
  scripts\engine\utility::_id_6E4C(self._id_EDA0);

  for (;;) {
  var_0 = [];

  for (var_1 = 0; var_1 < 3; var_1++) {
  if (self._id_EE9E[var_1] == 0) {
  var_0[var_1] = self._id_10BA1[var_1];
  continue;
  }

  if (self._id_EE9E[var_1] != 0 && self._id_EE9C[var_1] == 0) {
  var_0[var_1] = self.angles[var_1] + self._id_EE9E[var_1] / 20;
  continue;
  }

  if (self._id_EE9E[var_1] > 0 && self._id_EE9C[var_1] != 0)
  var_0[var_1] = _id_0B4D::_id_10AB4(self._id_E746[var_1], self._id_10BA1[var_1]);
  }

  self.angles = (var_0[0], var_0[1], var_0[2]);
  scripts\engine\utility::waitframe();
  }
}

_id_B2FB() {
  self endon("death");

  if (isdefined(self._id_ED48)) {
  scripts\engine\utility::_id_6E4C(self._id_ED48);

  if (isdefined(self._id_ED54) && self._id_ED54)
  self delete();
  else
  self notify("stop_manipulate_ent");
  }
}

_id_B2FA() {
  scripts\engine\utility::_id_13762("death", "stop_manipulate_ent");

  if (isdefined(self._id_E746)) {
  foreach (var_1 in self._id_E746)
  _id_0B4D::_id_10AAA(var_1);
  }

  if (isdefined(self._id_12689)) {
  foreach (var_1 in self._id_12689)
  _id_0B4D::_id_10AAA(var_1);
  }
}

_id_9DB4(var_0) {
  if (isdefined(self._id_00E2) && self._id_00E2 != "alt_none" && self._id_00E2 != "none" && getweaponbasename(self._id_00E2) == var_0)
  return 1;

  return 0;
}

_id_9FFE(var_0) {
  var_1 = getweaponattachments(var_0);

  if (!isdefined(var_1))
  return 0;

  foreach (var_3 in var_1) {
  if (issubstr(var_3, "epic"))
  return 1;
  }

  return 0;
}

_id_11150(var_0, var_1) {
  if (var_0.size <= var_1.size)
  return var_0;

  if (getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1)
  return getsubstr(var_0, 0, var_0.size - var_1.size);

  return var_0;
}

_id_F398(var_0, var_1) {
  self._id_68C6[var_0] = var_1;
}

_id_F2A4(var_0) {
  var_1 = getarraykeys(self._id_68C6);

  for (var_2 = 0; var_2 < var_1.size; var_2++)
  self._id_68C6[var_1[var_2]] = var_0;
}

_id_137AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_8 = spawnstruct();
  var_8._id_117B8 = 0;

  if (isdefined(var_0)) {
  var_0 childthread scripts\engine\utility::_id_13806(var_1, var_8);
  var_8._id_117B8++;
  }

  if (isdefined(var_2)) {
  var_2 childthread scripts\engine\utility::_id_13806(var_3, var_8);
  var_8._id_117B8++;
  }

  if (isdefined(var_4)) {
  var_4 childthread scripts\engine\utility::_id_13806(var_5, var_8);
  var_8._id_117B8++;
  }

  if (isdefined(var_6)) {
  var_6 childthread scripts\engine\utility::_id_13806(var_7, var_8);
  var_8._id_117B8++;
  }

  while (var_8._id_117B8) {
  var_8 waittill("returned");
  var_8._id_117B8--;
  }

  var_8 notify("die");
}

_id_7A8F() {
  var_0 = [];

  if (isdefined(self._id_EE01)) {
  var_1 = scripts\engine\utility::_id_7A9C();

  foreach (var_3 in var_1) {
  var_4 = getentarray(var_3, "script_linkname");

  if (var_4.size > 0)
  var_0 = scripts\engine\utility::_id_227F(var_0, var_4);
  }
  }

  return var_0;
}

_id_7A9A() {
  var_0 = [];

  if (isdefined(self._id_EE01)) {
  var_1 = scripts\engine\utility::_id_7A9C();

  foreach (var_3 in var_1) {
  var_4 = getvehiclenodearray(var_3, "script_linkname");

  if (var_4.size > 0)
  var_0 = scripts\engine\utility::_id_227F(var_0, var_4);
  }
  }

  return var_0;
}

_id_7A8E() {
  var_0 = _id_7A8F();
  return var_0[0];
}

_id_E820(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentarray(var_0, "targetname");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);

  if (isdefined(level._id_8134)) {
  var_6 = call [[level._id_8134]](var_0);

  foreach (var_8 in var_6) {
  if (_func_2A8(var_8))
  scripts\engine\utility::_id_22D2([var_8], var_1, var_2, var_3, var_4);
  }
  }

  var_5 = scripts\engine\utility::_id_8180(var_0, "targetname");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);
  var_5 = call [[level._id_7FF3]](var_0, "targetname");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "targetname");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);
}

_id_E81F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentarray(var_0, "script_noteworthy");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);

  if (isdefined(level._id_8134)) {
  var_6 = call [[level._id_8134]]();

  foreach (var_8 in var_6) {
  if (isdefined(var_8.script_noteworthy) && var_8.script_noteworthy == var_0 && _func_2A8(var_8))
  scripts\engine\utility::_id_22D2([var_8], var_1, var_2, var_3, var_4);
  }
  }

  var_5 = scripts\engine\utility::_id_8180(var_0, "script_noteworthy");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);
  var_5 = call [[level._id_7FF3]](var_0, "script_noteworthy");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);
  var_5 = getvehiclenodearray(var_0, "script_noteworthy");
  scripts\engine\utility::_id_22D2(var_5, var_1, var_2, var_3, var_4);
}

_id_7B27(var_0) {
  var_1 = getent(var_0, "script_noteworthy");

  if (isdefined(var_1))
  return var_1;

  if (scripts\engine\utility::_id_9F64()) {
  var_1 = call [[level._id_7FF9]](var_0, "script_noteworthy");

  if (isdefined(var_1))
  return var_1;
  }

  var_1 = scripts\engine\utility::_id_817E(var_0, "script_noteworthy");

  if (isdefined(var_1))
  return var_1;

  var_1 = getvehiclenode(var_0, "script_noteworthy");

  if (isdefined(var_1))
  return var_1;
}

_id_9C39(var_0) {
  var_1 = level._id_AED4[var_0];
  return var_1._id_00C1 > var_1._id_B425;
}

_id_12BDD(var_0) {
  thread scripts\engine\utility::_id_12BDC(var_0);
  wait 0.05;
}

_id_7EB4(var_0, var_1, var_2) {
  if (!isdefined(var_2))
  var_2 = 500000;

  var_3 = 0;
  var_4 = undefined;

  foreach (var_6 in var_1) {
  var_7 = distance(var_6.origin, var_0);

  if (var_7 <= var_3 || var_7 >= var_2)
  continue;

  var_3 = var_7;
  var_4 = var_6;
  }

  return var_4;
}

_id_22C1(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size - 1; var_2++) {
  for (var_3 = var_2 + 1; var_3 < var_0.size; var_3++) {
  if (var_0[var_3] [[var_1]]() < var_0[var_2] [[var_1]]()) {
  var_4 = var_0[var_3];
  var_0[var_3] = var_0[var_2];
  var_0[var_2] = var_4;
  }
  }
  }

  return var_0;
}

_id_965C() {
  if (isdefined(level.script))
  return;

  level.script = tolower(getdvar("mapname"));
}

_id_93A6() {
  if (getdvarint("g_specialistMode"))
  return 1;
  else
  return 0;
}

_id_93AB() {
  if (getdvarint("g_yoloMode"))
  return 1;
  else
  return 0;
}

_id_B979(var_0, var_1) {
  var_0 waittill("trigger", var_2);
  level.player _meth_80D8(0.1, 0.1);
  level.player scripts\engine\utility::_id_1C35(0);

  while (!level.player isonground())
  wait 0.05;

  var_3 = level.player getstance();

  if (var_3 != var_1) {
  level.player setstance(var_1);

  if (var_3 == "prone")
  wait 0.2;
  }

  level.player _meth_80A6();
  level.player scripts\engine\utility::_id_1C35(1);
  return var_2;
}

_id_19FA(var_0, var_1, var_2, var_3, var_4) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if (!var_3) {
  while (scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648))
  wait 0.05;
  }

  self._id_72BD = self.weapon;

  if (isdefined(var_4)) {
  if (self.weapon != var_4)
  _id_192C(self.weapon);

  self._id_72BA = self._id_C828;
  _id_72EC(var_4, "primary");
  self._id_13CAE = 1;
  return;
  }

  _id_72EC(var_1, "primary");
  _id_192C(var_0);
  self._id_72BB = var_0;
  self._id_72BC = var_1;
  self._id_42AE = var_2;
  self._id_72BA = self._id_72BC;
}

_id_4125(var_0, var_1, var_2) {
  self notify("ai_weapon_override");
  self endon("ai_weapon_override");

  if (!var_1) {
  while (scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), self.origin, 0.173648))
  wait 0.05;
  }

  if (isdefined(var_2)) {
  if (isdefined(self._id_13C4D) && self._id_13C4D._id_01F1 == getweaponmodel(var_2))
  self._id_13C4D delete();

  _id_CC06(var_2, "right");
  }
  else
  _id_CC06(self._id_72BD, "right");

  if (isdefined(self._id_13C4D) && var_0)
  self._id_13C4D delete();

  self._id_72BA = undefined;
  self._id_13CAE = 0;
}

_id_192C(var_0) {
  self._id_13C4D = spawn("script_model", self gettagorigin("tag_stowed_back"));
  self._id_13C4D setmodel(getweaponmodel(var_0));
  self._id_13C4D notsolid();
  self._id_13C4D.angles = self gettagangles("tag_stowed_back");
  self._id_13C4D linkto(self, "tag_stowed_back");
}

_id_46AD(var_0, var_1) {
  level notify("countdown_start");
  level endon("countdown_start");
  level endon("countdown_end");
  setomnvar("ui_countdown_mission_text", var_1);
  setomnvar("ui_countdown_timer", gettime() + var_0 * 1000);
  wait(var_0);
  level notify(var_1);
  wait 5;
  setomnvar("ui_countdown_timer", 0);
}

_id_46AB() {
  level notify("countdown_end");
  setomnvar("ui_countdown_timer", 0);
}

_id_F44E(var_0) {
  level._id_C086 = !var_0;
}

_id_ABD9() {
  return !level._id_C086;
}

_id_CE10(var_0, var_1, var_2) {
  _func_1C5("bg_cinematicFullScreen", "1");
  _func_1C5("bg_cinematicCanPause", "1");
  _func_03D(var_0);
  thread _id_0B35::_id_E080();
  _id_E006();

  if (_id_93A6())
  _id_0B78::hide_helmet_impacts();

  level.player scripts\engine\utility::_id_1C71(0);
  level.player _meth_80F9(1);
  level.player _meth_80D1();
  level.player _meth_8475();
  level.player _meth_8559(0);
  setomnvar("ui_hide_hud", 1);
  level.player _id_1C3E(0);
  setomnvar("ui_hide_weapon_info", 1);

  while (!iscinematicplaying())
  scripts\engine\utility::waitframe();

  thread _id_3F71(var_1);

  if (isdefined(var_2)) {
  _id_3F72(var_2);

  if (_id_93A6())
  _id_0B78::show_helmet_impacts();

  level.player scripts\engine\utility::_id_1C71(1);
  level.player _meth_80A1();
  level.player _meth_80F9(0);
  level.player _meth_8475();
  level.player _meth_8559(1);
  level.player thread _id_0B35::_id_8CBA();
  setomnvar("ui_hide_hud", 0);
  level.player _id_1C3E(1);
  setomnvar("ui_hide_weapon_info", 0);
  level notify("skippable_cinematic_done");

  while (iscinematicplaying())
  scripts\engine\utility::waitframe();

  _func_1C5("bg_cinematicFullScreen", "0");
  _func_1C5("bg_cinematicCanPause", "0");
  setomnvar("ui_is_bink_skippable", 0);
  _func_1F1();
  } else {
  while (iscinematicplaying())
  scripts\engine\utility::waitframe();

  _func_1C5("bg_cinematicFullScreen", "0");
  _func_1C5("bg_cinematicCanPause", "0");
  setomnvar("ui_is_bink_skippable", 0);
  _func_1F1();

  if (_id_93A6())
  _id_0B78::show_helmet_impacts();

  level.player scripts\engine\utility::_id_1C71(1);
  level.player _meth_80A1();
  level.player _meth_80F9(0);
  level.player _meth_8475();
  level.player _meth_8559(1);
  level.player thread _id_0B35::_id_8CBA();
  setomnvar("ui_hide_hud", 0);
  level.player _id_1C3E(1);
  setomnvar("ui_hide_weapon_info", 0);
  level notify("skippable_cinematic_done");
  }
}

_id_3F71(var_0) {
  level endon("skippable_cinematic_done");

  if (isdefined(var_0))
  self waittill(var_0);

  setomnvar("ui_is_bink_skippable", 1);

  for (;;) {
  level.player waittill("luinotifyserver", var_1, var_2);

  if (var_1 == "skip_bink_input") {
  level notify("cinematic_skipped");
  _func_1F1();
  break;
  }
  }
}

_id_3F72(var_0) {
  level endon("cinematic_skipped");
  var_0 = var_0 * 1000;

  for (;;) {
  var_1 = _func_03C();

  if (var_1 >= var_0)
  return;

  scripts\engine\utility::waitframe();
  }
}

_id_93AC() {
  return level.player _id_65DF("zero_gravity") && level.player _id_65DB("zero_gravity");
}

_id_E006(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if (!isdefined(var_0))
  var_0 = 1;

  if (!isdefined(var_1))
  var_1 = 1;

  if (!isdefined(var_2))
  var_2 = 1;

  if (!isdefined(var_3))
  var_3 = 1;

  if (!isdefined(var_4))
  var_4 = 1;

  if (!isdefined(var_5))
  var_5 = 1;

  if (!isdefined(var_6))
  var_6 = 0;

  if (var_0)
  thread _id_0E26::_id_DFC1();

  if (var_1)
  thread _id_0E25::_id_DFBE();

  if (var_2)
  thread _id_0E21::_id_DFBA();

  if (var_3)
  thread _id_0B16::_id_DFBD();

  if (var_4)
  thread _id_0B1D::_id_DFBF();

  if (var_5)
  thread _id_0E2D::_id_5139();

  if (var_6)
  thread _id_0E2D::_id_A5B9();
}

_id_F6FE(var_0) {
  self._id_6A8B = var_0;
}

_id_41AD(var_0) {
  self._id_6A8B = "asm";

  if (!isdefined(self._id_6B14) || !self._id_6B14)
  _id_0A1E::_id_2376();
}

_id_9DEB(var_0) {
  if (!isai(self) && (!isdefined(self._id_6B14) || !self._id_6B14))
  return 0;

  if (!isdefined(self._id_6A8B))
  self._id_6A8B = "asm";

  var_1 = [];
  var_1["asm"] = 0;
  var_1["filler"] = 1;
  var_1["vignette"] = 2;

  if (var_1[var_0] >= var_1[self._id_6A8B])
  return 1;

  return 0;
}

_id_F708(var_0) {
  var_0 = max(var_0, 2);
  level._id_2A6F = var_0;
}

dyndof(var_0, var_1) {
  level notify("stop_dyndof");

  if (isdefined(level.dyndof))
  level.dyndof = undefined;

  level.dyndof = _id_0B92::create_dyndof();
  level thread _id_0B92::dyndof_thread();
}

dyndof_farsettings(var_0, var_1, var_2) {
  if (isdefined(var_0))
  level.dyndof.farstart = var_0;

  if (isdefined(var_1))
  level.dyndof.farend = var_1;

  if (isdefined(var_2))
  level.dyndof.farblur = var_2;
}

dyndof_disable() {
  level notify("stop_dyndof");
  _id_0B92::destroy_dyndof();
  _id_0B0A::_id_583D(1);
}

isactorwallrunning() {
  if (isdefined(self._id_138BC))
  return 1;

  return 0;
}