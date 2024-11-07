/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\scripts\sp\maps\pearlharbor\pearlharbor_util.gsc
********************************************************************/

_id_36FF(var_0, var_1) {
  if (!isdefined(var_1) && isdefined(self.angles))
  var_1 = self.angles;

  var_2 = anglestoforward(var_1) * var_0[0];
  var_3 = anglestoright(var_1) * var_0[1];
  var_4 = anglestoup(var_1) * var_0[2];
  var_5 = self.origin + var_2 + var_3 + var_4;
  return var_5;
}

_id_BC53(var_0) {
  var_1 = getent(var_0, "targetname");

  if (isdefined(var_1)) {}
  else
  var_1 = scripts\engine\utility::_id_817E(var_0, "targetname");

  level.player setorigin(var_1.origin);

  if (!isdefined(var_1.angles))
  var_1.angles = (0, 0, 0);

  var_2 = undefined;

  if (isdefined(var_1._id_0334))
  var_2 = getent(var_1._id_0334, "targetname");

  if (isdefined(var_2))
  level.player setplayerangles(vectortoangles(var_2.origin - var_1.origin));
  else
  level.player setplayerangles(var_1.angles);

  if (!scripts\engine\utility::array_contains(level.struct, var_1))
  var_1 delete();
}

_id_F5A4() {
  _func_27F((0, 0, 0));
  thread _id_0B91::_id_241F(0);
}

_id_3C46(var_0, var_1, var_2) {
  level notify("new_map_sunlight");
  level endon("new_map_sunlight");

  if (var_2 <= 0.05) {
  _id_3C48(var_0, var_1);
  return;
  }

  var_3 = level._id_111D0._id_02CF;
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];
  var_7 = level._id_111D0._id_99E5;
  var_8 = var_0[0];
  var_9 = var_0[1];
  var_10 = var_0[2];
  var_11 = var_8 - var_4;
  var_12 = var_9 - var_5;
  var_13 = var_10 - var_6;
  var_14 = var_1 - var_7;
  var_15 = var_11 * (1 / (var_2 + 0.05) * 0.05);
  var_16 = var_12 * (1 / (var_2 + 0.05) * 0.05);
  var_17 = var_13 * (1 / (var_2 + 0.05) * 0.05);
  var_18 = var_14 * (1 / (var_2 + 0.05) * 0.05);

  while (var_2 > 0) {
  var_2 = var_2 - 0.05;
  var_4 = var_4 + var_15;
  var_5 = var_5 + var_16;
  var_6 = var_6 + var_17;
  var_7 = var_7 + var_18;
  var_3 = (var_4, var_5, var_6);
  _id_3C48(var_3, var_7);
  wait 0.05;
  }

  _id_3C48(var_0, var_1);
}

_id_3C44(var_0, var_1) {
  level notify("new_map_sunangles");
  level endon("new_map_sunangles");

  if (var_1 <= 0.05) {
  _id_3C45(var_0);
  return;
  }

  var_2 = level._id_111D0._id_1120D;
  var_3 = anglestoforward(level._id_111D0._id_1120D);
  var_4 = anglestoright(level._id_111D0._id_1120D);
  var_5 = anglestoup(level._id_111D0._id_1120D);
  var_6 = anglestoforward(var_0);
  var_7 = anglestoright(var_0);
  var_8 = anglestoup(var_0);
  var_9 = var_6 - var_3;
  var_10 = var_7 - var_4;
  var_11 = var_8 - var_5;
  var_12 = var_9 * (1 / (var_1 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_1 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_1 + 0.05) * 0.05);

  while (var_1 > 0) {
  var_1 = var_1 - 0.05;
  var_3 = var_3 + var_12;
  var_4 = var_4 + var_13;
  var_5 = var_5 + var_14;
  var_2 = _func_017(vectornormalize(var_3), vectornormalize(var_4), vectornormalize(var_5));
  _id_3C45(var_2);
  wait 0.05;
  }

  _id_3C45(var_0);
}

_id_3C47(var_0, var_1) {
  level notify("new_map_sunfx_offset");
  level endon("new_map_sunfx_offset");

  if (var_1 <= 0.05) {
  level._id_111D0._id_75AC = var_0;
  return;
  }

  var_2 = level._id_111D0._id_75AC;
  var_3 = anglestoforward(level._id_111D0._id_75AC);
  var_4 = anglestoright(level._id_111D0._id_75AC);
  var_5 = anglestoup(level._id_111D0._id_75AC);
  var_6 = anglestoforward(var_0);
  var_7 = anglestoright(var_0);
  var_8 = anglestoup(var_0);
  var_9 = var_6 - var_3;
  var_10 = var_7 - var_4;
  var_11 = var_8 - var_5;
  var_12 = var_9 * (1 / (var_1 + 0.05) * 0.05);
  var_13 = var_10 * (1 / (var_1 + 0.05) * 0.05);
  var_14 = var_11 * (1 / (var_1 + 0.05) * 0.05);

  while (var_1 > 0) {
  var_1 = var_1 - 0.05;
  var_3 = var_3 + var_12;
  var_4 = var_4 + var_13;
  var_5 = var_5 + var_14;
  var_2 = _func_017(vectornormalize(var_3), vectornormalize(var_4), vectornormalize(var_5));
  level._id_111D0._id_75AC = var_2;
  wait 0.05;
  }

  level._id_111D0._id_75AC = var_0;
}

_id_3C45(var_0) {
  _func_127(level._id_111D0._id_1120D, var_0, 0.05);
  level._id_111D0._id_1120D = var_0;
  _id_0B0A::_id_1121E("default", 0);
}

_id_3C48(var_0, var_1) {
  level._id_111D0._id_02CF = var_0;
  level._id_111D0._id_99E5 = var_1;
  _func_1CB(level._id_111D0._id_02CF[0], level._id_111D0._id_02CF[1], level._id_111D0._id_02CF[2], level._id_111D0._id_99E5);
}

_id_48BF(var_0) {
  if (!isdefined(level._id_002E))
  level._id_002E = [];

  if (!isdefined(var_0))
  var_0 = ["admiral", "salter", "eth3n"];

  foreach (var_2 in var_0) {
  if (isdefined(level._id_002E[var_2]) && isalive(level._id_002E[var_2]))
    continue;

  level._id_002E[var_2] = _id_0B91::_id_107EA(var_2, 1);
  level._id_002E[var_2]._id_0162 = 0;
  level._id_002E[var_2] _id_0B91::_id_B14F();
  level._id_002E[var_2] _meth_8250(0);
  level._id_002E[var_2] _id_0B91::_id_F3B5("b");
  level._id_002E[var_2] _meth_8504(1, "soldier");
  level._id_002E[var_2]._id_1FBB = var_2;

  if (var_2 == "admiral")
    level._id_002E["admiral"].name = "Raines";
  else if (var_2 == "salter")
    level._id_002E["salter"].name = "Salter";
  else if (var_2 == "eth3n")
    level._id_002E["eth3n"].name = "Ethan";

  var_3 = _id_7EFB(var_2);

  if (isdefined(var_3))
    level._id_002E[var_2] _id_0B91::_id_72EC(var_3, "primary");
  }
}

_id_7EFB(var_0) {
  var_1["admiral"] = "iw7_ake";
  var_1["salter"] = "iw7_m4+reflex";
  var_1["eth3n"] = "iw7_fhr";

  if (isdefined(var_1[var_0]))
  return var_1[var_0];
}

_id_BC05(var_0, var_1) {
  _id_48BF(var_1);

  if (!isdefined(var_1))
  var_1 = ["admiral", "salter", "eth3n"];

  if (scripts\engine\utility::array_contains(var_1, "admiral"))
  _id_1683(level._id_002E["admiral"], var_0 + "_admiral", 1);

  if (scripts\engine\utility::array_contains(var_1, "salter"))
  _id_1683(level._id_002E["salter"], var_0 + "_salter", 1);

  if (scripts\engine\utility::array_contains(var_1, "eth3n"))
  _id_1683(level._id_002E["eth3n"], var_0 + "_eth3n", 1);
}

_id_1683(var_0, var_1, var_2) {
  if (!isdefined(var_0))
  return;

  var_3 = scripts\engine\utility::_id_817E(var_1, "targetname");

  if (!isdefined(var_3)) {
  var_1 = tolower(var_1);
  var_3 = scripts\engine\utility::_id_817E(var_1, "targetname");
  }

  if (!isdefined(var_3)) {
  var_1 = tolower(var_1);
  var_3 = getnode(var_1, "targetname");
  }

  if (!isdefined(var_3)) {}

  if (!isdefined(var_3.angles))
  var_3.angles = (0, 0, 0);

  if (isplayer(var_0)) {
  var_0 setplayerangles(var_3.angles);
  var_0 setorigin(var_3.origin);
  }
  else if (isai(var_0)) {
  var_0 _meth_80F1(var_3.origin, var_3.angles);
  var_4 = var_0._id_164D[var_0._id_238F]._id_4BC0;
  var_5 = anim._id_2303[var_0._id_238F];
  var_6 = var_5._id_10E2F[var_4];

  if (isdefined(var_6._id_C704))
    var_0 _id_0A1E::_id_237F(var_6._id_C704);

  if (isdefined(var_2) && var_2)
    var_0 _meth_82EF(var_3.origin);
  }
}

_id_C120(var_0, var_1) {
  if (!isdefined(self.script_noteworthy))
  return 0;

  var_0 = tolower(var_0);
  var_2 = tolower(self.script_noteworthy);

  if (!isdefined(var_1)) {
  if (var_2 == var_0)
    return 1;

  return 0;
  }

  var_3 = strtok(var_2, var_1);

  foreach (var_5 in var_3) {
  if (var_5 == var_0)
    return 1;
  }

  return 0;
}

_id_C8ED(var_0, var_1) {
  if (!isdefined(self._id_EE79))
  return 0;

  var_0 = tolower(var_0);
  var_2 = tolower(self._id_EE79);

  if (!isdefined(var_1)) {
  if (var_2 == var_0)
    return 1;

  return 0;
  }

  var_3 = strtok(var_2, var_1);

  foreach (var_5 in var_3) {
  if (var_5 == var_0)
    return 1;
  }

  return 0;
}

_id_518F() {
  if (isdefined(self._id_B14F))
  _id_0B91::_id_1101B();

  self delete();
}

_id_CA95(var_0, var_1) {
  self _meth_84E5(0.0);
  _id_0B91::_id_F492(1);
  var_2 = _id_0E26::_id_10679(var_0);
  var_2 _id_0B91::_id_B14F(1);

  if (!isdefined(var_2))
  return;

  var_2 _id_0B91::_id_F492(1);
  var_2 endon("death");

  if (isdefined(var_1)) {
  var_2._id_55B1 = 1;
  wait(var_1);
  var_2._id_55B1 = undefined;
  }

  return var_2;
}

_id_EF24(var_0) {
  scripts\engine\utility::waitframe();
  var_1 = getentitylessscriptablearrayinradius(var_0, "targetname");
  var_2 = getentarray("generic_civilian_bodyonly", "targetname");

  foreach (var_4 in var_1) {
  if (!isdefined(var_4.script_noteworthy))
    continue;

  if (var_4._id_01F1 == "veh_civ_lnd_un_hatchback_static_black")
    continue;

  if (var_4._id_01F1 == "veh_civ_lnd_un_hatchback_static_blue")
    continue;

  var_5 = [];
  var_6 = [];
  var_7 = strtok(var_4.script_noteworthy, " ");

  foreach (var_9 in var_7) {
    var_10 = strtok(var_9, "_");

    if (var_10[0] == "car") {
    var_5[var_5.size] = var_10[1];
    continue;
    }

    if (var_10[0] == "body") {
    var_6[var_6.size] = var_10[1];
    continue;
    }

    if (var_10[0] == "c") {
    var_5[var_5.size] = var_10[1];
    continue;
    }

    if (var_10[0] == "b")
    var_6[var_6.size] = var_10[1];
  }

  if (var_5.size)
    radiusdamage(var_4.origin + (0, 0, 15), 24, 1, 1);

  foreach (var_13 in var_5) {
    var_14 = "ph_veh_hatchback_opendoor_" + var_13;
    var_4 _meth_82A2(_id_0B91::_id_7DC3(var_14));
  }

  foreach (var_13 in var_6) {
    var_17 = scripts\engine\utility::_id_DC6B(var_2);
    var_18 = var_17 _id_0B91::_id_10619(1);
    var_18.origin = var_4 gettagorigin("tag_origin");
    var_18.angles = var_4 gettagangles("tag_origin");
    var_19 = "dead_car_civi_" + var_13;

    if (!isdefined(var_4._id_4DED))
    var_4._id_4DEE = [];

    var_4._id_4DEE[var_4._id_4DEE.size] = var_18;

    if (var_13 == "driverwindow" || var_13 == "passengerwindow" || var_13 == "driverdoor" || var_13 == "driver") {
    radiusdamage(var_4.origin + (0, 0, 15), 24, 1, 1);
    var_4 _meth_8187("TAG_WINDSHIELD_FRONT", var_4._id_01F1);
    var_4 _meth_8187("TAG_WINDOW_FRONT_LEFT", var_4._id_01F1);
    var_18 thread _id_DC18();
    }

    if (isdefined(var_18._id_13525) && var_18._id_13525 == "unitednationsfemale")
    var_18.origin = var_18.origin + (0, 0, -2);

    var_18 scripts\engine\utility::_id_50E1(0.05, ::linkto, var_4, "tag_body");
    var_18 thread _id_0B06::_id_1ECA(var_18, var_19);
  }
  }
}

_id_DC18() {
  self endon("death");
  self setcandamage(1);
  self solid();
  self.health = 500;
  wait 2;

  for (;;) {
  self waittill("damage", var_0, var_0, var_0, var_0, var_1);

  if (isdefined(var_1) && isexplosivedamagemod(var_1)) {
    _id_0C60::_id_58B8();
    self delete();
    return;
  }
  }
}

_id_EF26(var_0) {
  scripts\engine\utility::waitframe();
  var_1 = getentitylessscriptablearrayinradius(var_0, "targetname");

  foreach (var_3 in var_1) {
  if (isdefined(var_3._id_4DEE))
    _id_0B91::_id_228A(var_3._id_4DEE);
  }
}

_id_EF25() {
  self endon("death");

  for (;;) {
  self waittill("damage", var_0, var_1);

  if (!isdefined(var_1))
    continue;

  if (var_1 == level.player)
    break;
  }

  thread scripts\engine\utility::_id_CD7F("ph_hill_streets_car_alarm");
}

_id_D20D() {
  self endon("entitydeleted");
  var_0 = getent("ocean_clip", "targetname");

  if (isdefined(var_0))
  var_0 delete();

  for (;;) {
  self waittill("trigger");
  level.player thread _id_0B91::_id_D2CD(25, 0.05);
  level.player setstance("stand");
  level.player allowjump(0);
  level.player _meth_800A(0);
  level.player _meth_8010(0);
  level.player _meth_8012(0);
  level.player _meth_836F(1, 2);
  level.player thread _id_D20C();

  while (level.player istouching(self)) {
    if (length(level.player _meth_816B()) < 1)
    wait 0.1;
    else
    wait 0.05;

    var_1 = level.player.origin;
    var_1 = var_1 + (0, 0, 46);
  }

  level.player notify("left_ocean");
  level.player thread _id_0B91::_id_D2CD(100, 0.05);
  level.player allowjump(1);
  level.player _meth_800A(1);
  level.player _meth_8010(1);
  level.player _meth_8012(1);
  }
}

_id_D20B(var_0) {
  var_1 = var_0.origin;
  var_0 _meth_8212(-100, 0.75);
  level.player waittill("left_ocean");
  var_0.origin = var_1;
}

_id_D20C() {
  self endon("left_ocean");
  self playsound("ph_water_splash_plr");
  var_0 = 45;
  var_1 = 1;

  for (;;) {
  var_2 = length(level.player _meth_816B());

  if (var_2 < 15) {
    wait 0.05;
    continue;
  }

  if (var_2 > var_0)
    var_2 = var_0;

  var_3 = var_0 / var_2;
  var_4 = var_1 * var_3;
  level.player playsound("ph_step_water_plr");
  wait(var_4);
  }
}

_id_39BC(var_0, var_1) {
  self endon("reached_end_node");
  self endon("death");
  _id_0B0F::_id_1D84();
  var_2 = undefined;

  for (;;) {
  self waittill("noteworthy", var_3);
  var_4 = strtok(var_3, " ");

  foreach (var_6 in var_4) {
    switch (var_6) {
    case "start_entry":
      var_2 = scripts\engine\utility::_id_107E6();
      var_2 linkto(self, "fx_entryburn_1", (0, 0, 0), (0, 0, 0));
      playfxontag(scripts\engine\utility::_id_7ECB("enemy_entry_fireball_base_a"), var_2, "tag_origin");
      break;
    case "stop_entry":
      stopfxontag(scripts\engine\utility::_id_7ECB("enemy_entry_fireball_base_a"), var_2, "tag_origin");
      var_2 delete();
      break;
    case "fire_missiles":
      self notify("stop_fire_missiles");
      var_7 = self._id_4BF7;
      var_8 = var_7 _id_0B91::_id_7A97();
      var_9 = _id_0B0F::_id_39D3(var_8);

      foreach (var_11 in var_9)
      thread _id_0B0F::_id_3987(var_11, [1, 3], [0.25, 0.5], undefined, undefined, var_0, var_1);

      break;
    case "stop_fire_missiles":
      self notify("stop_fire_missiles");
      break;
    }
  }
  }
}

_id_13D54() {
  var_0 = getentarray("window_decals", "targetname");
  scripts\engine\utility::_id_22D2(var_0, ::_id_13D51);
}

_id_13D51() {
  self endon("death");
  var_0 = getglass(self._id_0334);

  if (!isdefined(var_0))
  return;

  while (!isglassdestroyed(var_0))
  wait 0.05;

  self delete();
}

_id_13D53() {
  var_0 = getentarray("window_decals", "targetname");
  _id_0B91::_id_228A(var_0);
}

_id_1CC5() {
  self endon("death");
  setdvarifuninitialized("ally_advance_debug", 0);

  if (!isdefined(level._id_A881))
  level._id_A881 = undefined;

  var_0 = getent(self._id_0334, "targetname");
  var_1 = getent(var_0._id_0334, "targetname");
  var_1 endon("trigger");
  var_1 endon("entitydeleted");
  self waittill("trigger");
  var_2 = undefined;

  if (_id_C8ED("retriggerable", " "))
  var_2 = 1;

  if (!_id_C8ED("skip_global_endon", " ") && !isdefined(var_2)) {
  level notify("new_ally_advance_trigger");
  level endon("new_ally_advance_trigger");
  }

  var_3 = [];
  var_4 = var_0 _id_0B91::_id_7A8F();

  foreach (var_6 in var_4) {
  if (var_6 _id_C8ED("advance_reinforcement", " ")) {
    var_3[var_3.size] = var_6;
    continue;
  }

  if (var_6 _id_C8ED("advance_ender", " "))
    var_6 endon("trigger");
  }

  if (isdefined(self._id_EDA0))
  scripts\engine\utility::_id_6E4C(self._id_EDA0);

  _id_0B91::_id_027B();
  _id_1CC6(var_1, var_0, var_3, var_2);

  foreach (var_6 in var_4) {
  if (var_6 _id_C8ED("advance_activate", " ") || isdefined(var_6.script_noteworthy) && var_6.script_noteworthy == "advance_activate")
    var_6 _id_0B91::_id_15F1();

  if (var_6 _id_C8ED("advance_disable", " "))
    var_6 scripts\engine\utility::_id_12778();

  if (var_6 _id_C8ED("advance_delete", " "))
    var_6 delete();
  }

  if (isdefined(var_1._id_02AF) && var_1._id_02AF == 64)
  var_1 scripts\engine\utility::_id_12778();

  var_1 notify("trigger");
}

_id_1CC6(var_0, var_1, var_2, var_3) {
  var_0 endon("entitydeleted");
  var_0 endon("trigger");
  var_4 = 0;

  if (isdefined(var_1._id_ED3C))
  var_4 = var_1._id_ED3C;

  for (;;) {
  wait 0.25;

  if (isdefined(var_3)) {
    if (isdefined(level._id_A881) && level._id_A881 == self) {

    }
    else if (!level.player istouching(self))
    continue;
  }

  level._id_A881 = self;
  var_5 = _func_074("axis", "all");
  var_5 = _id_0B91::_id_22BB(var_5);
  var_6 = [];

  foreach (var_8 in var_5) {
    if (var_8 istouching(var_1))
    var_6[var_6.size] = var_8;
  }

  foreach (var_11 in var_2) {
    if (!isdefined(var_11)) {
    var_6 = scripts\engine\utility::array_remove(var_6, var_11);
    continue;
    }

    if (var_6.size <= var_11._id_ED3C) {
    var_11 _id_0B91::_id_15F1();
    var_6 = scripts\engine\utility::array_remove(var_6, var_11);
    }
  }

  if (var_6.size <= var_4)
    break;
  }
}

_id_1CC2(var_0, var_1) {
  setdvarifuninitialized("ally_advance_debug", 0);

  if (!getdvarint("ally_advance_debug")) {
  if (isdefined(level._id_1CC2)) {
    foreach (var_3 in level._id_1CC2)
    var_3 destroy();

    level._id_1CC2 = undefined;
    level._id_1CC3 = undefined;
  }

  return;
  }

  var_5 = 5;

  foreach (var_7 in var_0)
  thread _id_0B91::_id_5B29(var_7.origin, var_5, (1, 0, 0), 1, 0, var_5);

  if (!isdefined(level._id_1CC2)) {
  level._id_1CC3 = 165;
  level._id_1CC2["aiAmount"] = _id_1CC4();
  level._id_1CC2["goalAmount"] = _id_1CC4();
  }

  level._id_1CC2["aiAmount"] _meth_834D("AI AMOUNT : " + var_0.size);
  level._id_1CC2["goalAmount"] _meth_834D("GOAL AMOUNT : " + var_1);
}

_id_1CC4() {
  var_0 = _id_0B3F::_id_49B2("default", 1.5);
  var_0.x = 0;
  var_0.y = level._id_1CC3;
  level._id_1CC3 = level._id_1CC3 + 15;
  return var_0;
}

_id_117BC() {
  self endon("death");

  for (;;) {
  self waittill("trigger");
  var_0 = _id_7D1C();

  foreach (var_2 in var_0) {
    if (!isdefined(var_2) || !isalive(var_2))
    continue;

    var_3 = var_2 _meth_8163();

    if (var_3 == self._id_EEE2)
    continue;

    thread _id_117BD(var_2, var_3);
  }

  wait 0.15;
  }
}

_id_7D1C() {
  var_0 = undefined;

  switch (self._id_02AF) {
  case 1:
    var_0 = _func_075("axis", "all");
    var_0[var_0.size] = level.player;
    break;
  case 2:
    var_0 = _func_075("allies", "all");
    var_0[var_0.size] = level.player;
    break;
  case 3:
    var_1 = _func_075("allies", "all");
    var_2 = _func_075("axis", "all");
    var_0 = scripts\engine\utility::_id_227F(var_1, var_2);
    var_0[var_0.size] = level.player;
    break;
  case 9:
    var_0 = _func_075("axis", "all");
    break;
  case 10:
    var_0 = _func_075("allies", "all");
    break;
  case 11:
    var_1 = _func_075("allies", "all");
    var_2 = _func_075("axis", "all");
    var_0 = scripts\engine\utility::_id_227F(var_1, var_2);
    break;
  }

  var_3 = [];

  foreach (var_5 in var_0) {
  if (!isdefined(var_5) || !isalive(var_5))
    continue;

  if (var_5 istouching(self))
    var_3[var_3.size] = var_5;

  wait 0.05;
  }

  return var_3;
}

_id_117BD(var_0, var_1) {
  var_0 notify("new_threat_biasgroup");
  var_0 endon("new_threat_biasgroup");
  var_0 endon("death");
  var_0 setthreatbiasgroup(self._id_EEE2);

  while (isdefined(self) && var_0 istouching(self))
  wait 0.15;

  if (var_1 == "")
  var_0 setthreatbiasgroup();
  else
  var_0 setthreatbiasgroup(var_1);
}

_id_323A() {
  self endon("death");

  if (isdefined(self._id_ED78))
  self endon(self._id_ED78);

  var_0 = scripts\engine\utility::_id_817E(self._id_0334, "targetname");
  var_1 = scripts\engine\utility::_id_817E(var_0._id_0334, "targetname");
  var_2 = 1;
  var_3 = 5;
  var_4 = 0.5;
  var_5 = 1.5;

  for (;;) {
  self waittill("trigger");

  while (level.player istouching(self)) {
    var_6 = undefined;

    if (isdefined(var_0.height))
    var_6 = var_0.height;

    var_7 = undefined;

    if (isdefined(var_1.height))
    var_7 = var_1.height;

    var_8 = _id_E45E(var_0.origin, var_0.radius, var_6);
    var_9 = _id_E45E(var_1.origin, var_1.radius, var_7);
    var_10 = randomintrange(1, 5);

    for (var_11 = 0; var_11 < var_10; var_11++) {
    magicbullet("generic_mg_turret_nosound", var_8, var_9);
    wait 0.1;
    }

    wait(randomfloatrange(0.5, 1.5));
  }
  }
}

_id_3FAC(var_0) {
  if (isdefined(self.team) && self.team == "neutral") {
  self endon("death");
  self endon("stop_screaming");
  var_0 = scripts\engine\utility::ter_op(isdefined(var_0), var_0, 8);
  thread _id_0B91::_id_C12D("stop_screaming", var_0);

  if (distance2dsquared(self.origin, level.player.origin) > squared(400))
    childthread _id_3FAB();

  wait(randomfloatrange(0.25, 1));
  var_1 = issubstr(self._id_01F1, "female");

  for (;;) {
    self playsound(_id_78A4(var_1));
    wait(randomfloatrange(1.5, 2.5));
  }
  }
}

_id_78A4(var_0) {
  if (!var_0) {
  var_1 = [];
  var_1[var_1.size] = "phstreets_fcv3_cryscream" + randomintrange(1, 7);
  var_1[var_1.size] = "phstreets_fcv2_cryscream" + randomintrange(1, 2);
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  var_1[var_1.size] = "phstreets_fcv4_cryscream1";
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  var_1[var_1.size] = "phstreets_fc1_allezvite";
  var_1[var_1.size] = "phstreets_fcv1_screamsatguns";
  var_1[var_1.size] = "phstreets_fc1_pourquoifontils";
  var_1[var_1.size] = "phstreets_fcv1_cryingjeneveux";
  var_1[var_1.size] = "phstreets_fc2_rungetoutofhere";
  var_1[var_1.size] = "phstreets_fc1_getoutoftheway";
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  var_1[var_1.size] = "phstreets_fcv3_cryscream_null";
  return scripts\engine\utility::random_weight_sorted(var_1);
  }

  var_2 = [];
  var_2[var_2.size] = "phstreets_mcv5_cryscream" + randomintrange(1, 3);
  var_2[var_2.size] = "phstreets_mcv1_cryscream1";
  var_2[var_2.size] = "phstreets_mcv2_cryscream1";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_mcv3_cryscream1";
  var_2[var_2.size] = "phstreets_mcv4_cryscream1";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_cv2_screamsofpain";
  var_2[var_2.size] = "phstreets_cv2_questcequecest";
  var_2[var_2.size] = "phstreets_cv1_couriraller";
  var_2[var_2.size] = "phstreets_cv3_degagez";
  var_2[var_2.size] = "phstreets_cv1_nono";
  var_2[var_2.size] = "phstreets_unm2_watchhhoutt";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  var_2[var_2.size] = "phstreets_fcv3_cryscream_null";
  return scripts\engine\utility::random_weight_sorted(var_2);
}

_id_3FAB() {
  if (!isdefined(level._id_A896)) {
  level._id_A896 = gettime();
  _func_178("civi_screams", self.origin);
  }
  else if (gettime() - level._id_A896 > 4000) {
  _func_178("civi_screams", self.origin);
  level._id_A896 = gettime();
  }
}

_id_19C5(var_0) {
  self notify("new_run_path");
  self endon("new_run_path");
  self endon("cancel_path");
  self endon("death");

  if (!isdefined(var_0))
  var_0 = _id_0B91::_id_7A96();

  thread _id_3FAC();
  var_1 = var_0;

  for (;;) {
  self._id_4BEF = var_1;

  if (isdefined(var_1._id_0334) && !isdefined(var_1._id_027B) && !isdefined(var_1._id_EDA0)) {
    if (isdefined(var_1._id_EDA0) && scripts\engine\utility::_id_6E25(var_1._id_EDA0))
    continue;

    _id_0B91::_id_5504();
  }

  if (isdefined(var_1.animation))
    _id_842D(var_1);
  else
  {
    self._id_015C = 64;

    if (isdefined(var_1.radius))
    self._id_015C = var_1.radius;

    if (isdefined(var_1.height))
    self._id_015A = var_1.height;

    if (isnode(var_1))
    self _meth_82EE(var_1);
    else
    self _meth_82EF(var_1.origin);

    self waittill("goal");
  }

  if (_id_0B91::_id_65DF("ai_move_think_animation"))
    _id_0B91::_id_65E8("ai_move_think_animation");

  _id_0B91::_id_61DB();

  if (isdefined(var_1.animation) && isdefined(var_1._id_EE06))
    thread _id_8429(var_1);

  if (isdefined(var_1._id_EDBB))
    playfx(scripts\engine\utility::_id_7ECB(var_1._id_EDBB), var_1.origin);

  if (isdefined(var_1._id_ED41) && var_1._id_ED41) {
    var_2 = 9999;
    var_3 = 9999;

    if (isdefined(var_1._id_EE99)) {
    var_2 = var_1._id_EE99;
    var_3 = var_1._id_EE98;
    }

    var_4 = var_1._id_EE8F;
    radiusdamage(var_1.origin, var_4, var_2, var_3);
  }

  if (isdefined(var_1._id_EEB0)) {
    if (var_1 _id_C8ED("sound_on_ent", " "))
    thread _id_0B91::_id_CE2F(var_1._id_EEB0);
    else
    _func_178(var_1._id_EEB0, var_1.origin);
  }

  if (isdefined(var_1._id_ED76))
    thread scripts\engine\utility::_id_577E(var_1._id_ED76, var_1.origin);

  if (isdefined(var_1._id_EDE3))
    self._id_0180 = var_1._id_EDE3;

  if (isdefined(var_1._id_EDE4))
    self._id_0184 = var_1._id_EDE4;

  if (isdefined(var_1._id_EE01))
    thread _id_19EF(var_1);

  if (isdefined(var_1._id_ED9E))
    scripts\engine\utility::_id_6E3E(var_1._id_ED9E);

  if (isdefined(var_1._id_EDA0))
    scripts\engine\utility::_id_6E4C(var_1._id_EDA0);

  var_1 _id_0B91::_id_027B();

  if (isdefined(var_1.script_noteworthy) && isdefined(level._id_19C4[var_1.script_noteworthy]))
    self thread [[level._id_19C4[var_1.script_noteworthy]]](var_1);

  if (isdefined(var_1._id_ED56))
    _id_0B91::_id_51E1(var_1._id_ED56);

  if (isdefined(var_1._id_ED22)) {
    if (var_1._id_ED22)
    _id_0B91::_id_B14F();
    else
    _id_0B91::_id_1101B();
  }

  if (isdefined(var_1.animation)) {
    if (isdefined(var_1._id_EE06)) {
    var_5 = _id_7822(var_1);
    var_5 notify("ai_move_think_stop_loop");
    self _meth_83A1();
    }
    else
    _id_8426(var_1);
  }

  if (!isdefined(var_1._id_0334))
    break;

  var_1 = _id_7E98(var_1._id_0334, "targetname");
  self notify("new_path_goal");
  }

  self notify("completed_run_path");

  if (isdefined(var_1._id_ED43)) {
  if (isdefined(self._id_B14F))
    _id_0B91::_id_1101B();

  if (var_1 _id_C8ED("bullet_impact", " "))
    _id_19C3(var_1);

  _id_0B91::_id_54C6();
  }

  if (isdefined(var_1._id_ED54)) {
  if (isdefined(self._id_B14F))
    _id_0B91::_id_1101B();

  self delete();
  }
}

_id_842D(var_0) {
  if (var_0 _id_C8ED("no_reach"))
  return;

  var_1 = var_0;
  var_2 = var_0 _id_0B91::_id_7A97();

  foreach (var_4 in var_2) {
  if (var_4 _id_C8ED("animnode"))
    var_1 = var_4;
  }

  var_1 _id_0B06::_id_1ECE(self, var_0.animation);
}

_id_8426(var_0) {
  var_1 = _id_7822(var_0);

  if (!isdefined(var_0._id_EE82))
  var_1 thread _id_0B06::_id_1ECB(self, var_0.animation);
  else
  var_1 thread _id_0B06::_id_1EC7(self, var_0.animation);

  if (isdefined(var_0._id_ECED) && var_0._id_ECED) {
  self setcandamage(1);
  _id_0B91::_id_F2A8(1);
  }

  if (isdefined(var_0._id_EE2C)) {
  thread _id_842E(var_0);
  return;
  }

  var_2 = getanimlength(_id_0B91::_id_7DC3(var_0.animation));

  if (!_id_0B91::_id_65DF("ai_move_think_animation"))
  _id_0B91::_id_65E0("ai_move_think_animation");

  _id_0B91::_id_65E1("ai_move_think_animation");
  thread _id_0B91::_id_65DE("ai_move_think_animation", var_2);

  if (!isdefined(var_0._id_0334))
  wait(var_2);
}

_id_8429(var_0) {
  var_1 = _id_7822(var_0);
  var_1 thread _id_0B06::_id_1ECC(self, var_1.animation, "ai_move_think_stop_loop");
}

_id_7822(var_0) {
  var_1 = var_0;
  var_2 = var_0 _id_0B91::_id_7A97();

  foreach (var_4 in var_2) {
  if (var_4 _id_C8ED("animnode"))
    var_1 = var_4;
  }

  return var_1;
}

_id_842E(var_0) {
  scripts\engine\utility::waitframe();
  self _meth_82B1(_id_0B91::_id_7DC3(var_0.animation), var_0._id_EE2C);
}

_id_19EF(var_0) {
  var_1 = undefined;
  var_2 = var_0 _id_0B91::_id_7A97();

  foreach (var_4 in var_2) {
  if (isdefined(var_4._id_EE79) && var_4._id_EE79 == "target") {
    var_1 = var_4;
    break;
  }
  }

  if (!isdefined(var_1))
  return;

  if (!isdefined(self) || !isalive(self))
  return;

  var_6 = var_1 scripts\engine\utility::_id_107E6();
  var_7 = self._id_0180;
  self._id_0180 = 0;
  self _meth_82DE(var_6);
  scripts\engine\utility::waittill_any("clear_targeting", "cancel_path", "new_path_goal", "death");

  if (isdefined(self) && isalive(self)) {
  self._id_0180 = var_7;
  self _meth_8072();
  }

  var_6 delete();
}

_id_8428() {
  var_0 = _id_0B91::_id_7A97();
  var_0 = scripts\engine\utility::_id_2279(var_0, self);

  foreach (var_2 in var_0) {
  if (!isdefined(var_2._id_EDBB))
    continue;

  var_3 = 0;

  if (isdefined(var_2._id_ED96))
    var_3 = var_2._id_ED96;

  scripts\engine\utility::_id_C0A6(var_3, ::playfx, scripts\engine\utility::_id_7ECB(var_2._id_EDBB), var_2.origin);
  }
}

_id_19C3(var_0) {
  var_1 = undefined;

  if (isdefined(var_0) && isdefined(var_0._id_EED9))
  var_1 = var_0._id_EED9;
  else
  var_1 = scripts\engine\utility::_id_DC6B(["j_head", "j_shoulder_le", "j_shoulder_ri", "tag_weapon_chest"]);

  playfxontag(scripts\engine\utility::_id_7ECB("vfx_ph_flesh_hit_body_large"), self, var_1);
  _func_178("phstreets_hill_npc_bullet_death", self gettagorigin(var_1));
}

_id_7E98(var_0, var_1) {
  var_2 = getent(var_0, var_1);

  if (isdefined(var_2))
  return var_2;

  var_3 = getnode(var_0, var_1);

  if (isdefined(var_3))
  return var_3;

  return scripts\engine\utility::_id_817E(var_0, var_1);
}

_id_754C(var_0, var_1) {
  var_2 = spawn("script_origin", level.player.origin);
  wait 0.1;
  var_2 playsound("phstreets_bink3d_conceptofevil");
  _func_1C5("bg_cinematicFullScreen", "0");
  _func_03F(var_0);
  scripts\engine\utility::_id_6E4C(var_1);
  var_2 _meth_83AD();
  _func_1F1();
  var_2 delete();
}

_id_DD5A(var_0, var_1, var_2) {
  if (!isdefined(level._id_DD58))
  level._id_DD58 = [];

  level._id_DD58["limit"] = getdvarint("r_reactiveMotionHelicopterLimit");
  level._id_DD58["radius"] = getdvarint("r_reactiveMotionHelicopterRadius");
  level._id_DD58["strength"] = getdvarint("r_reactiveMotionHelicopterStrength");
  _func_1C5("r_reactiveMotionHelicopterLimit", var_0);
  _func_1C5("r_reactiveMotionHelicopterRadius", var_1);
  _func_1C5("r_reactiveMotionHelicopterStrength", var_2);
}

_id_DD59() {
  _func_1C5("r_reactiveMotionHelicopterLimit", level._id_DD58["limit"]);
  _func_1C5("r_reactiveMotionHelicopterRadius", level._id_DD58["radius"]);
  _func_1C5("r_reactiveMotionHelicopterStrength", level._id_DD58["strength"]);
  level._id_DD58 = undefined;
}

_id_1510(var_0) {
  level endon(var_0 + "_disable");
  var_1 = getentarray(var_0, "script_noteworthy");
  scripts\engine\utility::_id_22D2(var_1, ::_id_1511);

  for (;;) {
  wait(randomfloatrange(4, 8));
  var_1 = scripts\engine\utility::_id_22BC(var_1);
  var_2 = _id_7BFB(var_1);

  if (!var_2.size)
    continue;

  var_3 = scripts\engine\utility::_id_DC6B(var_2);
  var_2 = scripts\engine\utility::array_remove(var_2, var_3);
  var_3 thread _id_150E();
  var_3 scripts\engine\utility::_id_13762("turret_on_target", "entitydeleted");

  if (!isdefined(var_3))
    continue;

  var_3 scripts\engine\utility::delaythread(1, ::_id_150C);
  var_4 = gettime();

  if (scripts\engine\utility::_id_4347() && var_2.size) {
    var_2 = scripts\engine\utility::_id_22BC(var_2);

    if (!var_2.size)
    continue;

    var_3 = scripts\engine\utility::_id_DC6B(var_2);
    var_3 thread _id_150E();
    var_3 scripts\engine\utility::_id_13762("turret_on_target", "entitydeleted");

    if (!isdefined(var_3))
    continue;

    if (gettime() - var_4 < 1000)
    wait 1;

    var_3 scripts\engine\utility::delaythread(1, ::_id_150C);
  }
  }
}

#using_animtree("script_model");

_id_150B() {
  self._id_55BA = 1;
  self notify("aatis_turret_disabled");
  self _meth_806F(%ph_aatis_gun_fire, 0.05);
  self cleartargetentity();
}

_id_150F(var_0) {
  level notify(var_0 + "_disable");
  var_1 = getentarray(var_0, "script_noteworthy");

  foreach (var_3 in var_1) {
  if (!isdefined(var_3))
    continue;

  var_3._id_11583 delete();
  var_3 delete();
  }

  _id_EA02(var_1);
}

_id_150E() {
  self notify("stop_idle_rotation");
  var_0 = self._id_11583;
  var_1 = scripts\engine\utility::_id_6EE1(self gettagangles("j_anim_barrel_rot"));
  var_2 = anglestoforward(var_1);
  var_0.origin = self.origin + var_2 * 5000;
  var_3 = anglestoup(self.angles);
  var_0.origin = var_0.origin + var_3 * randomintrange(2500, 4500);
}

_id_1511() {
  self notsolid();
  self setdefaultdroppitch(-30);
  self _meth_830F("manual");
  self _meth_83D0(#animtree);
  self._id_DD7B = 1;
  var_0 = spawn("script_origin", self.origin);
  self settargetentity(var_0);
  self._id_11583 = var_0;
  thread _id_14FE();
}

_id_14FE() {
  self endon("death");
  self endon("stop_idle_rotation");
  self endon("aatis_turret_disabled");
  var_0 = self._id_11583;
  var_1 = anglestoforward(self.angles);
  var_0.origin = self.origin + var_1 * 5000;
  var_2 = anglestoup(self.angles);
  var_0.origin = var_0.origin + var_2 * 2500;
  var_3 = scripts\engine\utility::_id_6EE1(self.angles);

  for (;;) {
  var_4 = var_3 + (0, 90, 0);
  var_1 = anglestoforward(var_4);
  var_5 = self.origin + var_1 * 5000;
  var_0.origin = (var_5[0], var_5[1], var_0.origin[2]);
  self waittill("turret_on_target");
  var_3 = var_4;
  }
}

_id_7BFB(var_0) {
  var_1 = [];

  foreach (var_3 in var_0) {
  if (!isdefined(var_3))
    continue;

  if (isdefined(var_3._id_55BA))
    continue;
  else if (isdefined(var_3._id_DD7B))
    var_1[var_1.size] = var_3;
  }

  var_5 = cos(45);
  var_6 = [];
  var_7 = [];

  foreach (var_3 in var_1) {
  if (var_3 _id_0B91::_id_13D91(level.player geteye(), level.player getplayerangles(), var_3.origin, var_5)) {
    var_6[var_6.size] = var_3;
    continue;
  }

  var_7[var_7.size] = var_3;
  }

  var_10 = scripts\engine\utility::_id_227F(var_6, var_7);
  return var_10;
}

_id_150C(var_0) {
  self endon("death");
  self endon("aatis_turret_disabled");
  self._id_DD7B = undefined;
  self _meth_806F(%ph_aatis_gun_fire, 0.05);
  wait 0.05;
  self shootturret();
  self _meth_82A2(%ph_aatis_gun_fire);
  self playsound("weap_aatis_fire");

  if (distance2dsquared(level.player.origin, self.origin) <= squared(20000)) {
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.2, 0.75, level.player.origin, 200);
  }

  if (!isdefined(var_0))
  childthread _id_150D();
}

_id_150D() {
  wait 5;
  thread _id_14FE();
  wait 2;
  self._id_DD7B = 1;
}

_id_035A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("stop_fire");
  self endon("death");
  var_5 = scripts\engine\utility::ter_op(isdefined(var_5), var_5, 0.15);
  var_7 = 0.6;
  var_8 = 1.2;

  if (isdefined(var_0)) {
  var_7 = var_0[0];
  var_8 = var_0[1];
  }

  for (;;) {
  wait(randomfloatrange(var_7, var_8));
  var_9 = randomintrange(8, 18);

  for (var_10 = 0; var_10 < var_9; var_10++) {
    if (isdefined(var_1)) {
    if (isdefined(var_6))
      self playsound(var_6);

    var_11 = undefined;

    if (isdefined(var_3))
      var_11 = var_3;

    var_12 = _id_E45E(var_1, var_2, var_11);
    var_13 = undefined;

    if (_func_2A6(self)) {
      var_13 = self gettagorigin("tag_flash");
      playfxontag(scripts\engine\utility::_id_7ECB("hill_mg_turret_muzflash"), self, "tag_flash");
    }
    else
    {
      var_13 = self.origin;
      var_14 = vectornormalize(var_12 - var_13);
      playfx(scripts\engine\utility::_id_7ECB("hill_mg_turret_muzflash"), var_13, var_14);
    }

    _func_02F(var_13, var_12, self._id_039B);
    }
    else
    self shootturret("tag_flash");

    wait(var_5);
  }
  }
}

_id_6B06(var_0) {
  var_1 = scripts\engine\utility::_id_817E(self._id_0334, "targetname");

  if (isdefined(self._id_ED78))
  var_0 = self._id_ED78;

  var_2 = _func_0C7(self._id_0334, "targetname");
  var_3 = undefined;

  if (isdefined(var_2)) {
  var_3 = _id_0B91::_id_2C17(var_2);
  var_3._id_1FBB = "generic";
  var_2 _id_0B06::_id_1EC3(var_3, var_2.animation);
  var_3 thread _id_0B91::_id_7748();
  var_3 _id_0B91::_id_16B7(_id_0B1B::_id_4D4C);
  var_3 setcandamage(1);
  var_3 _id_0B91::_id_F2A8(1);
  var_3.health = 100;
  }

  if (isdefined(var_3))
  self.origin = var_3 gettagorigin("tag_flash");

  self._id_039B = "generic_mg_turret_nosound";
  thread _id_035A(undefined, var_1.origin, var_1.radius, undefined, 1);
  level _id_0B91::_id_178D(_id_0B91::_id_137AA, var_0);

  if (isdefined(var_3))
  var_3 _id_0B91::_id_178D(_id_0B91::_id_137AA, "death");

  _id_0B91::_id_57D6();
  self notify("stop_fire");

  if (isdefined(var_3)) {
  if (!isalive(var_3))
    var_3 startragdoll();
  else
  {
    var_3 delete();

    if (isdefined(self._id_EE01))
    var_2 = _func_0C7(self._id_EE01, "script_linkname") _id_0B91::_id_10619();
  }
  }
}

_id_F293(var_0, var_1) {
  var_2 = _id_0B91::_id_77DA(var_0);
  var_3 = getent(var_1, "targetname");

  foreach (var_5 in var_2)
  var_5 _meth_82F1(var_3);
}

_id_F2D4(var_0) {
  var_1 = _func_072("axis");
  var_2 = getent(var_0, "targetname");

  foreach (var_4 in var_1)
  var_4 _meth_82F1(var_2);
}

_id_137F8(var_0) {
  for (;;) {
  var_1 = _func_072("axis");

  if (var_1.size <= var_0)
    break;

  wait 0.5;
  }
}

_id_EA00(var_0, var_1) {
  var_2 = 262144;
  var_3 = [];

  if (isdefined(var_0))
  var_3 = _id_0B91::_id_77DA(var_0);
  else
  var_3 = _func_072("axis");

  foreach (var_5 in var_3) {
  var_6 = distance2dsquared(level.player.origin, var_5.origin);

  if ((!isdefined(var_1) || !var_1) && var_6 >= var_2 && !sighttracepassed(level.player geteye(), var_5.origin + (0, 0, 60)))
    var_5 scripts\engine\utility::delaythread(randomfloatrange(0, 0.5), ::_id_A5E4);
  }
}

_id_A5E4() {
  scripts\engine\utility::waitframe();
  self _meth_81D0();
}

_id_2C16() {
  _id_0B55::_id_7B05();
  self _meth_8307(self.name, &"");
}

_id_2C15() {
  self setcandamage(1);
  self.team = "allies";
  thread _id_0B32::_id_73B1(self);
}

_id_E45E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if (isdefined(var_3)) {
  var_5 = var_3 / var_1;
  var_4 = var_1 - var_1 * randomfloat(var_5);
  }
  else
  var_4 = var_1 * randomfloat(1.0);

  var_6 = randomfloat(360.0);
  var_7 = sin(var_6);
  var_8 = cos(var_6);
  var_9 = var_4 * var_8;
  var_10 = var_4 * var_7;
  var_11 = 0;

  if (isdefined(var_2))
  var_11 = randomfloatrange(0, var_2);

  var_9 = var_9 + var_0[0];
  var_10 = var_10 + var_0[1];
  var_11 = var_11 + var_0[2];
  return (var_9, var_10, var_11);
}

_id_16BD(var_0, var_1, var_2) {
  if (getdvarint("loc_warnings", 0))
  return;

  if (!isdefined(level._id_4EC3))
  level._id_4EC3 = [];

  var_3 = "^3";

  if (isdefined(var_2)) {
  switch (var_2) {
    case "red":
    case "r":
    var_3 = "^1";
    break;
    case "green":
    case "g":
    var_3 = "^2";
    break;
    case "yellow":
    case "y":
    var_3 = "^3";
    break;
    case "blue":
    case "b":
    var_3 = "^4";
    break;
    case "cyan":
    case "c":
    var_3 = "^5";
    break;
    case "purple":
    case "p":
    var_3 = "^6";
    break;
    case "white":
    case "w":
    var_3 = "^7";
    break;
    case "bl":
    case "black":
    var_3 = "^8";
    break;
  }
  }

  var_4 = _id_0B3F::_id_49B2("default", 1.5);
  var_4._id_AEC4 = 0;
  var_4._id_002B = "left";
  var_4._id_002C = "top";
  var_4._id_0142 = 1;
  var_4._id_02A4 = 20;
  var_4.alpha = 0;
  var_4 fadeovertime(0.5);
  var_4.alpha = 1;
  var_4.x = 40;
  var_4.y = 325;
  var_4._id_01AD = " " + var_3 + "< " + var_0 + " > ^7" + var_1;
  var_4._id_00B9 = (1, 1, 1);
  level._id_4EC3 = scripts\engine\utility::_id_229C(level._id_4EC3, var_4, 0);

  foreach (var_7, var_6 in level._id_4EC3) {
  if (var_7 == 0)
    continue;

  if (isdefined(var_6))
    var_6.y = 325 - var_7 * 18;
  }

  wait 2;
  var_8 = 40;
  var_4 fadeovertime(3);
  var_4.alpha = 0;

  for (var_7 = 0; var_7 < var_8; var_7++) {
  var_4._id_00B9 = (1, 1, 0 / (var_8 - var_7));
  wait 0.05;
  }

  wait 4;
  var_4 destroy();
  scripts\engine\utility::_id_22BC(level._id_4EC3);
}

_id_EA01(var_0) {
  if (!isdefined(var_0)) {
  if (isdefined(self) && _func_2A6(self))
    var_0 = self;
  }

  if (isdefined(var_0)) {
  if (isdefined(var_0._id_B14F) && var_0._id_B14F)
    var_0 _id_0B91::_id_1101B();

  var_0 delete();
  return 1;
  }

  return 0;
}

_id_EA02(var_0) {
  foreach (var_2 in var_0) {
  if (!isdefined(var_2))
    continue;

  _id_EA01(var_2);
  }
}

_id_15F6(var_0) {
  var_1 = getent(var_0, "targetname");

  if (isdefined(var_1))
  _id_0B91::_id_15F5(var_0);
}

_id_15F4(var_0) {
  var_1 = getent(var_0, "script_noteworthy");

  if (isdefined(var_1))
  _id_0B91::_id_15F3(var_0);
}

_id_61E6() {
  self endon("death");

  for (;;) {
  self waittill("trigger", var_0);
  var_0 _id_0B91::_id_61E7();
  }
}

_id_5513() {
  self endon("death");

  for (;;) {
  self waittill("trigger", var_0);
  var_0 _id_0B91::_id_5514();
  }
}

_id_39DB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  var_0 endon("death");
  self endon("stop_fire_missiles");

  if (isdefined(var_5))
  self endon(var_5);

  if (!isdefined(var_3))
  var_3 = 1;

  if (!isdefined(self._id_B8B2))
  self._id_B8B2 = _id_0B0F::_id_39D2();

  if (!isdefined(var_0._id_B8B2))
  var_0._id_B8B2 = _id_0B0F::_id_39D2();

  for (;;) {
  if (isarray(var_3))
    var_7 = randomintrange(var_3[0], var_3[1]);
  else
    var_7 = var_3;

  for (var_8 = 0; var_8 <= var_7; var_8++) {
    var_9 = scripts\engine\utility::_id_DC6B(self._id_B8B2[var_1]);
    var_10 = scripts\engine\utility::_id_DC6B(var_0._id_B8B2[var_2]);
    var_11 = spawnstruct();
    var_11.origin = var_0 gettagorigin(var_10);
    var_11._id_FF3E = 1;
    var_11._id_FF23 = 0;
    thread _id_0B0F::_id_3986(var_11, undefined);
    wait(randomfloatrange(0.25, 0.75));
  }

  wait(randomfloatrange(var_4[0], var_4[1]));
  }
}

_id_39A7() {
  var_0 = getent("capitalship_heli", "targetname");

  while (isdefined(var_0._id_108DA))
  wait 0.05;

  var_0._id_108DA = 1;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  scripts\engine\utility::waitframe();
  var_1 = var_0 _id_0B91::_id_10808();
  self._id_90DF = var_1;
  self linkto(var_1);
  var_1 sethoverparams(2000, 50, 50);
  var_1 setmaxpitchroll(0, 5);
  var_1 _meth_8379("slow");
  var_1 setvehgoalpos(var_1.origin + (0, 0, 1), 1);
  scripts\engine\utility::waitframe();
  var_0._id_108DA = undefined;
}

_id_39A8(var_0) {
  self._id_90DF sethoverparams(0, 0, 0);

  if (isdefined(var_0)) {
  self._id_90DF setvehgoalpos(var_0, 1);
  scripts\engine\utility::waittill_any("near_goal", "goal");
  }

  self unlink();
  self._id_90DF delete();
}

_id_11679() {
  level._id_4C50 = ::_id_3FC1;
  var_0 = getentarray("temp_civs", "targetname");

  foreach (var_2 in var_0)
  var_2 thread _id_3FAF();
}

_id_3FAF() {
  var_0 = self._id_EE79;
  scripts\engine\utility::_id_6E4C(var_0);
  var_1 = _id_0B91::_id_10619();
  var_1._id_1FBB = "generic";
  var_1._id_BCD6 = self._id_EE2C;
  var_1._id_015C = 128;
  var_1 _id_0B91::_id_13876();
  var_1 _id_0B91::_id_5528();
  var_1 _id_0B91::_id_5504();
  var_1 _meth_8250(1);
  var_2 = var_1 scripts\engine\utility::_id_7CD1();
  var_1 _id_0B91::_id_7227(var_2, 0);
  wait 1;

  while (isdefined(var_1) && isalive(var_1) && _id_0B91::_id_D1DF(var_1 geteye(), 0.6, 1))
  wait 0.1;

  if (isdefined(var_1) && isalive(var_1))
  var_1 delete();
}

_id_3FC1(var_0, var_1) {
  self endon("death");

  if (var_0 == "kill") {
  var_2 = getnodearray("civilian_cower", "script_noteworthy");
  sortbydistance(var_2, self.origin);
  var_3 = _id_78B1();
  _id_0B91::_id_F3D9(var_3);

  for (;;) {
    if (!_id_0B91::_id_CFAC(self) && distance2d(level.player.origin, self.origin) > 1200)
    self _meth_81D0();

    wait 15;
  }
  }
}

_id_78B1() {
  var_0 = getnodearray("civilian_cower", "script_noteworthy");
  var_1 = sortbydistance(var_0, self.origin);

  foreach (var_3 in var_0) {
  if (!isdefined(var_3._id_10439)) {
    var_3._id_C2CF = 1;
    return var_3;
  }
  }
}

_id_B7C2() {
  for (;;) {
  self waittill("trigger");
  var_0 = getdvarint("r_umbraminobjectcontribution");
  _func_1C5("r_umbraminobjectcontribution", self._id_EDE8);

  while (level.player istouching(self))
    wait 0.15;

  _func_1C5("r_umbraminobjectcontribution", var_0);
  }
}

_id_1F8A() {
  var_0 = self.animation;

  if (isdefined(self._id_EDA0))
  scripts\engine\utility::_id_6E4C(self._id_EDA0);

  _id_0B91::_id_027B();
  self _meth_83D0(#animtree);
  thread _id_0B06::_id_1ECC(self, var_0);

  if (isdefined(self._id_EE2C)) {
  scripts\engine\utility::waitframe();
  self _meth_82B1(_id_0B91::_id_7DC3(var_0)[0], self._id_EE2C);
  }

  if (isdefined(self._id_ED48)) {
  scripts\engine\utility::_id_6E4C(self._id_ED48);
  self delete();
  }
}

_id_126C4() {
  self endon("entitydeleted");
  self waittill("trigger");
  glassradiusdamage(self.origin, 6, 9999, 9999);
}

_id_D024() {
  self endon("entitydeleted");
  var_0 = strtok(self._id_EE79, " ");

  for (;;) {
  self waittill("trigger", var_1);

  foreach (var_3 in var_0) {
    if (var_3 == "stand") {
    level.player scripts\engine\utility::_id_1C68(0);
    continue;
    }

    if (var_3 == "crouch") {
    level.player scripts\engine\utility::_id_1C40(0);
    continue;
    }

    if (var_3 == "prone")
    level.player scripts\engine\utility::_id_1C60(0);
  }

  while (var_1 istouching(self))
    wait 0.1;

  foreach (var_3 in var_0) {
    if (var_3 == "stand") {
    level.player scripts\engine\utility::_id_1C68(1);
    continue;
    }

    if (var_3 == "crouch") {
    level.player scripts\engine\utility::_id_1C40(1);
    continue;
    }

    if (var_3 == "prone")
    level.player scripts\engine\utility::_id_1C60(1);
  }
  }
}

_id_D290() {
  self endon("death");

  for (;;) {
  self waittill("trigger");
  level.player _meth_84FE();

  while (level.player istouching(self))
    wait 0.05;

  level.player _meth_84FD();
  }
}

_id_1028F() {
  if (!isdefined(level._id_1028D)) {
  level._id_1028D = getent("skybox_blend_default_to_blue", "targetname");
  level._id_1028B = getent("skybox_blend_blue_to_space", "targetname");
  }
}

_id_1028E() {
  _id_1028F();
  level._id_1028D hide();
  level._id_1028B hide();
}

_id_1028C() {
  if (isdefined(level._id_1028D))
  level._id_1028D delete();

  if (isdefined(level._id_1028B))
  level._id_1028B delete();
}

_id_10D14() {
  level notify("stop_sequence_timer");
  level endon("stop_sequence_timer");
  var_0 = gettime();
  level._id_D907 = 0;

  if (getdvarint("E3", 0) && !isdefined(level._id_5FA8) && !getdvarint("e3_negus", 0)) {
  var_0 = -6000;
  level._id_5FA8 = 1;
  }

  if (isdefined(level._id_D906))
  level._id_D906 destroy();

  var_1 = newhudelem();
  var_1.x = -50;
  var_1.y = 375;
  var_1._id_013B = 1.2;
  level._id_D906 = var_1;

  for (;;) {
  wait 0.1;
  var_2 = (gettime() - var_0) * 0.001;
  level._id_D907 = var_2;
  }
}

_id_13801(var_0) {
  if (!isdefined(level._id_D907))
  return;

  while (level._id_D907 < var_0)
  wait 0.1;
}

_id_1103B() {
  level notify("stop_sequence_timer");
  level endon("stop_sequence_timer");
  wait 2.5;

  if (isdefined(level._id_D906))
  level._id_D906 destroy();
}

_id_13248() {
  self endon("death");

  if (!isdefined(level._id_118DC))
  level._id_118DC = gettime() / 1000;

  for (var_0 = self._id_4BF7; isdefined(self) && isdefined(self._id_4BF7); var_7 = abs(var_2 - _id_13247())) {
  if (!isdefined(var_0._id_0334))
    return;

  if (isdefined(var_0._id_EE79) && var_0._id_EE79 == "end_vehicle_time_sync") {
    self _meth_83E6(0, 50, 50);
    return;
  }

  var_1 = getvehiclenode(var_0._id_0334, "targetname");

  if (!isdefined(var_1))
    return;

  var_2 = var_1._id_EEBF;

  if (!isdefined(var_2))
    return;

  var_3 = _id_13247();
  var_4 = var_2 - var_3;
  var_5 = distance(self.origin, var_1.origin);
  var_6 = var_5 / var_4 / 17.6;

  if (var_6 < 0)
    var_6 = 10;

  self vehicle_setspeed(var_6, var_6 / 4, var_6 / 4);

  while (self._id_4BF7 == var_0)
    wait 0.05;

  var_5 = distance(self.origin, self._id_4BF7.origin);
  var_0 = self._id_4BF7;
  }
}

_id_13247() {
  return gettime() / 1000 - level._id_118DC;
}

_id_13249(var_0) {
  while (_id_13247() < var_0)
  wait 0.05;
}

_id_65D6() {
  level._id_65D4 = [];
  var_0 = getentarray("ent_cleanup_trigger", "script_noteworthy");
  var_1 = getentarray();
  var_2 = _func_0C8();

  foreach (var_4 in var_0) {
  level._id_65D4[var_4._id_EDF9] = [];
  var_4 thread _id_65D7(var_4._id_EDF9);
  }

  foreach (var_7 in var_1) {
  if (!isdefined(var_7._id_EDF9))
    continue;

  level._id_65D4[var_7._id_EDF9][level._id_65D4[var_7._id_EDF9].size] = var_7;
  }

  foreach (var_10 in var_2) {
  if (!isdefined(var_10._id_EDF9))
    continue;

  level._id_65D4[var_10._id_EDF9][level._id_65D4[var_10._id_EDF9].size] = var_10;
  }
}

_id_65D7(var_0) {
  level endon("ent_cleanup_" + var_0);
  self waittill("trigger");
  thread _id_65D5(var_0);
}

_id_65D5(var_0) {
  level notify("ent_cleanup_" + var_0);
  var_1 = 0;

  foreach (var_3 in level._id_65D4[var_0]) {
  if (!isdefined(var_3))
    continue;

  var_3 delete();
  var_1++;
  }

  level._id_65D4[var_0] = undefined;

  if (!level._id_65D4.size)
  level._id_65D4 = undefined;
}

#using_animtree("generic_human");

_id_13435() {
  setdvarifuninitialized("visibility_cover_debug", 0);
  precachemodel("fullbody_sdf_army");
  notifyoncommand("cover_debug_trace", "+sprint_zoom");
  var_0 = [];
  var_1 = 15;
  var_2 = 0;
  var_3 = 500;

  for (;;) {
  wait 0.05;

  if (!level.player _meth_8439())
    continue;

  if (!getdvarint("visibility_cover_debug"))
    continue;

  if (length(level.player _meth_814C()) > 0.15)
    continue;

  var_4 = 99999;
  var_5 = anglestoforward(level.player getplayerangles());
  var_6 = level.player geteye() + var_5 * var_4;
  var_7 = scripts\engine\trace::_id_DCED(level.player geteye(), var_6, level.player);
  var_8 = var_7["position"];
  var_9 = getnodesinradius(var_8, var_3, 0, 24, "Cover");
  _id_0B91::_id_228A(var_0);
  var_0 = [];

  foreach (var_11 in var_9) {
    if (isdefined(var_11._id_4703))
    continue;

    if (var_2 >= var_1)
    break;

    var_1++;
    var_12 = spawn("script_model", var_11.origin);
    var_12 _meth_83D0(#animtree);

    if (isdefined(var_11.angles))
    var_12.angles = var_11.angles;

    var_12 setmodel("fullbody_sdf_army");
    var_12 _meth_839E();
    var_0[var_0.size] = var_12;
    var_13 = var_11 _id_4702();

    if (!isdefined(var_13["animation"]))
    continue;

    var_12 thread _id_1EDF(var_13, var_11);
  }

  while (level.player _meth_8439())
    wait 0.05;
  }
}

_id_4702() {
  var_0 = [];
  var_0["animation"] = undefined;
  var_0["angles"] = undefined;

  switch (self.classname) {
  case "node_exposed":
    var_0["animation"] = %hm_grnd_red_exposed_aim_5_ar;
    break;
  case "node_cover_left":
    var_0["animation"] = %hm_grnd_org_cover_left_crouch_hide_to_fullexp_ar;
    var_0["angles"] = vectortoangles(anglestoleft(self.angles));
    break;
  case "node_cover_right":
    var_0["animation"] = %hm_grnd_org_cover_right_crouch_hide_to_fullexp_ar;
    var_0["angles"] = vectortoangles(anglestoright(self.angles));
    break;
  case "node_cover_crouch":
    var_0["animation"] = %hm_grnd_red_exposed_crouch_aim_5_ar;
    break;
  case "node_cover_stand":
    var_0["animation"] = %hm_grnd_red_exposed_aim_5_ar;
    break;
  case "node_cover_prone":
    var_0["animation"] = %prone_aim_5;
    break;
  }

  return var_0;
}

_id_1EDF(var_0, var_1) {
  var_2 = var_0["animation"];
  var_3 = self.angles;

  if (isdefined(var_0["angles"]))
  var_3 = var_0["angles"];

  self _meth_82A2(var_2);
  scripts\engine\utility::waitframe();
  var_4 = getmovedelta(var_2);
  var_5 = _func_079(var_2);
  var_6 = rotatevector(var_4, self.angles);
  var_7 = self.origin + var_6;
  self.origin = var_7;
  self.angles = var_3;
  self dontinterpolate();
}

_id_103BE() {
  self setthreatbiasgroup("snipers");
}

_id_37A9() {
  precachemodel("fx_org_view");
}

_id_CCBE() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("fx_org_view");
  var_0 linkto(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0._id_C04F = 1;
  var_1 = scripts\engine\utility::_id_8180("fxchain_start", "script_noteworthy");
  level._id_AD40 = [];
  level._id_C1E0 = var_1.size;

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
  var_1[var_2]._id_3C0A = var_2;
  var_1[var_2] _id_6C76();
  }

  var_1 = undefined;
  level._id_C1E0 = undefined;
  level._id_AD40 = scripts\engine\utility::_id_22C3(level._id_AD40, ::_id_445A);
  level._id_37CF = level._id_AD40[0]["start_struct"];
  level._id_37CE = 0;
  playfxontag(scripts\engine\utility::_id_7ECB(level._id_37CF._id_EE79), var_0, "tag_origin");
  level._id_AD40 = undefined;
  var_3 = scripts\engine\utility::_id_8180("fxchain_transition", "targetname");
  thread _id_68A8(var_0);

  for (;;) {
  wait 0.25;

  if (level._id_37CE)
    continue;

  var_4 = sortbydistance(var_3, level.player.origin)[0];

  if (distance2dsquared(level.player.origin, var_4.origin) <= squared(var_4.radius)) {
    var_5 = scripts\engine\utility::_id_817E(var_4.script_noteworthy, "targetname");
    var_6 = scripts\engine\utility::_id_817E(var_4._id_EE79, "targetname");
    var_7 = vectordot(anglestoforward(var_4.angles), level.player.origin - var_4.origin);
    var_8 = undefined;

    if (var_7 > 0 && level._id_37CF._id_3C0A == var_6._id_3C0A)
    var_8 = var_5;

    if (var_7 < 0 && level._id_37CF._id_3C0A == var_5._id_3C0A)
    var_8 = var_6;

    if (isdefined(var_8))
    _id_12660(var_8, var_0);
  }

  var_9 = [];

  foreach (var_11 in scripts\engine\utility::_id_8180(level._id_37CF._id_0336, "target"))
    var_9[var_9.size] = _id_7A8D(var_11, level._id_37CF);

  if (isdefined(level._id_37CF._id_0334)) {
    var_13 = scripts\engine\utility::_id_8180(level._id_37CF._id_0334, "targetname");

    foreach (var_15 in var_13) {
    var_9[var_9.size] = _id_7A8D(level._id_37CF, var_15);

    if (isdefined(var_15._id_0334)) {
      var_16 = scripts\engine\utility::_id_8180(var_15._id_0334, "targetname");

      foreach (var_18 in var_16)
      var_9[var_9.size] = _id_7A8D(var_15, var_18);
    }
    }
  }

  var_9 = scripts\engine\utility::_id_22C3(var_9, ::_id_445A);
  var_8 = var_9[0]["start_struct"];

  if (var_8.origin != level._id_37CF.origin) {
    if (var_8._id_EE79 != level._id_37CF._id_EE79) {
    _id_12660(var_8, var_0);
    continue;
    }

    level._id_37CF = var_8;
  }
  }
}

_id_6C76() {
  if (isdefined(self._id_0334)) {
  var_0 = scripts\engine\utility::_id_8180(self._id_0334, "targetname");

  foreach (var_2 in var_0) {
    if (!isdefined(var_2._id_3C0A)) {
    var_2._id_3C0A = self._id_3C0A;
    level._id_AD40[level._id_AD40.size] = _id_7A8D(self, var_2);
    level._id_C1E0++;
    var_2 _id_6C76();
    }
  }
  }
}

_id_7A8D(var_0, var_1) {
  var_2 = [];
  var_2["start_struct"] = var_0;
  var_2["closest_point"] = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
  return var_2;
}

_id_445A(var_0, var_1) {
  return distancesquared(var_0["closest_point"], level.player.origin) < distancesquared(var_1["closest_point"], level.player.origin);
}

_id_68A8(var_0) {
  scripts\engine\utility::_id_6E4C("dust_cloud_hit");
  stopfxontag(scripts\engine\utility::_id_7ECB(level._id_37CF._id_EE79), var_0, "tag_origin");
  level._id_37CE = 1;
  scripts\engine\utility::_id_6E4C("c6_reveal_started");
  level._id_37CF = scripts\engine\utility::_id_817E("droppod_camfx_start", "targetname");
  playfxontag(scripts\engine\utility::_id_7ECB(level._id_37CF._id_EE79), var_0, "tag_origin");
  level._id_37CE = 0;

  if (!getdvarint("e3", 0) == 1) {
  scripts\engine\utility::_id_6E4C("pod_door_landed");
  stopfxontag(scripts\engine\utility::_id_7ECB(level._id_37CF._id_EE79), var_0, "tag_origin");
  level._id_37CF._id_EE79 = "indoor_ash";
  playfxontag(scripts\engine\utility::_id_7ECB(level._id_37CF._id_EE79), var_0, "tag_origin");
  }

  scripts\engine\utility::_id_6E4C("breach_started");
  _id_12660(scripts\engine\utility::_id_817E("slowmo_camfx_start", "targetname"), var_0);
}

_id_12660(var_0, var_1) {
  stopfxontag(scripts\engine\utility::_id_7ECB(level._id_37CF._id_EE79), var_1, "tag_origin");
  playfxontag(scripts\engine\utility::_id_7ECB(var_0._id_EE79), var_1, "tag_origin");
  level._id_37CF = var_0;
}

_id_1283D(var_0) {
  var_1 = [];
  var_2 = "";

  for (;;) {
  var_3 = "";

  foreach (var_5 in var_0) {
    if (_func_119(var_5)) {
    if (var_3 == "") {
      var_3 = var_3 + var_5;
      continue;
    }

    var_3 = var_3 + "," + var_5;
    }
  }

  if (var_3 != var_2 && !scripts\engine\utility::array_contains(var_1, var_2)) {
    var_1 = scripts\engine\utility::_id_2279(var_1, var_2);
    var_2 = var_3;
  }

  wait 0.5;
  }
}

_id_311B(var_0) {
  if (getdvarint("bruteforce_removal") == 0)
  return;

  var_1 = scripts\engine\utility::_id_817E(var_0, "targetname");
  wait 2;
  _id_311C(var_1, "script_model");
  _id_311C(var_1, "script_brushmodel");
  _id_311C(var_1, "script_origin");
}

_id_311C(var_0, var_1) {
  var_2 = getentarray(var_1, "code_classname");
  var_3 = anglestoforward(var_0.angles);

  foreach (var_5 in var_2) {
  if (vectordot(var_3, vectornormalize(var_0.origin - var_5.origin)) > 0)
    var_5 thread _id_D8F6();
  }
}

_id_D8F6() {
  var_0 = squared(2000);

  for (;;) {
  wait 0.05;
  var_1 = distancesquared(level.player.origin, self.origin);

  if (var_1 > var_0)
    continue;

  var_2 = 0.8 - _id_0B4D::_id_C097(var_0 * 0.5, var_0, var_1);
  }
}

_id_8FC9() {
  var_0 = _func_0C8("hill_street_idle_civis");

  foreach (var_2 in var_0) {
  var_3 = var_2 _id_0B91::_id_10619(1);

  if (isdefined(var_2._id_EEB0))
    var_3 thread _id_11118(var_2._id_EEB0);
  }
}

_id_11118(var_0) {
  while (isdefined(self)) {
  self playsound(var_0);
  wait(lookupsoundlength(var_0) / 1000 + randomintrange(1, 4));
  }
}

_id_B284(var_0) {
  var_1 = _id_0B91::_id_7C23();
  var_1._id_99E5 = 0;
  var_1.origin = var_0.origin;
  return var_1;
}