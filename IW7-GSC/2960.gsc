/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2960.gsc
***************************************/

func_7AA4() {
  var_00 = [];
  var_0["trigger_multiple_nobloodpool"] = ::func_12777;
  var_0["trigger_multiple_flag_set"] = ::func_1273F;
  var_0["trigger_multiple_flag_clear"] = ::func_1273D;
  var_0["trigger_multiple_sun_off"] = ::func_1279E;
  var_0["trigger_multiple_sun_on"] = ::func_1279F;
  var_0["trigger_use_flag_set"] = ::func_1273F;
  var_0["trigger_use_flag_clear"] = ::func_1273D;
  var_0["trigger_multiple_flag_set_touching"] = ::func_12744;
  var_0["trigger_multiple_flag_lookat"] = ::func_12760;
  var_0["trigger_multiple_flag_looking"] = ::func_12762;
  var_0["trigger_multiple_no_prone"] = ::func_12776;
  var_0["trigger_multiple_no_crouch_or_prone"] = ::func_12775;
  var_0["trigger_multiple_compass"] = ::func_12769;
  var_0["trigger_multiple_fx_volume"] = ::func_1276E;
  var_0["trigger_multiple_kleenex"] = ::func_12770;
  var_0["trigger_multiple_light_sunshadow"] = scripts\sp\lights::func_11203;
  var_0["trigger_multiple_jackal_boundary_autoturn"] = ::func_12759;
  var_0["trigger_multiple_jackal_boundary_warning"] = ::func_1275B;
  var_0["trigger_multiple_jackal_boundary_push"] = ::func_1275A;
  var_0["trigger_multiple_jackal_speed_touching"] = ::func_1275C;
  var_0["trigger_multiple_landingzone"] = ::func_1275E;
  var_0["trigger_multiple_arbitrary_up"] = ::func_12723;
  var_0["trigger_multiple_spacejump"] = ::func_12794;

  if(!scripts\sp\starts::func_9C4B()) {
    var_0["trigger_multiple_autosave"] = scripts\sp\autosave::func_12724;
    var_0["trigger_multiple_spawn"] = func_0B77::func_12797;
    var_0["trigger_multiple_spawn_reinforcement"] = func_0B77::func_12798;
  }

  var_0["trigger_multiple_slide"] = ::func_12792;
  var_0["trigger_multiple_depthoffield"] = ::func_1276A;
  var_0["trigger_multiple_tessellationcutoff"] = ::func_12772;
  var_0["trigger_damage_player_flag_set"] = ::func_1272F;
  var_0["trigger_multiple_sunflare"] = ::func_12771;
  var_0["trigger_multiple_glass_break"] = ::func_1274B;
  var_0["trigger_radius_glass_break"] = ::func_1274B;
  var_0["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
  var_0["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
  var_0["trigger_multiple_physics"] = ::func_1277E;
  var_0["trigger_multiple_fx_watersheeting"] = ::func_1276F;
  var_0["trigger_multiple_fakeactor_move"] = scripts\sp\fakeactor::func_12735;
  var_0["trigger_multiple_fakeactor_node_disable"] = scripts\sp\fakeactor::func_12736;
  var_0["trigger_multiple_fakeactor_node_enable"] = scripts\sp\fakeactor::func_12738;
  var_0["trigger_multiple_fakeactor_node_disablegroup"] = scripts\sp\fakeactor::func_12737;
  var_0["trigger_multiple_fakeactor_node_enablegroup"] = scripts\sp\fakeactor::func_12739;
  var_0["trigger_multiple_fakeactor_node_passthrough"] = scripts\sp\fakeactor::func_1273B;
  var_0["trigger_multiple_fakeactor_node_lock"] = scripts\sp\fakeactor::func_1273A;
  var_0["trigger_multiple_geo_mover"] = scripts\sp\geo_mover::func_12764;
  var_0["trigger_multiple_transient"] = ::func_12773;
  var_0["trigger_multiple_fire"] = ::func_1273C;
  var_0["trigger_radius_fire"] = ::func_1273C;
  return var_00;
}

func_1276F(var_00) {
  var_01 = 3;

  if(isdefined(var_0.func_ED75))
    var_01 = var_0.func_ED75;

  for (;;) {
    var_00 waittill("trigger", var_02);

    if(isplayer(var_02)) {
      var_02 _meth_836F(1, var_01);
      wait(var_01 * 0.2);
    }
  }
}

func_7AA5() {
  var_00 = [];
  var_0["friendly_mgTurret"] = func_0B77::func_73D9;

  if(!scripts\sp\starts::func_9C4B()) {
    var_0["camper_spawner"] = func_0B77::camper_trigger_think;
    var_0["flood_spawner"] = func_0B77::func_6F5D;
    var_0["trigger_spawner"] = func_0B77::func_12797;
    var_0["trigger_autosave"] = scripts\sp\autosave::func_12724;
    var_0["trigger_spawngroup"] = ::func_1279A;
    var_0["trigger_vehicle_spline_spawn"] = ::func_127AC;
    var_0["trigger_vehicle_spawn"] = func_0B77::func_12797;
    var_0["random_spawn"] = func_0B77::func_DC9B;
  }

  var_0["autosave_now"] = scripts\sp\autosave::func_2671;
  var_0["trigger_autosave_tactical"] = scripts\sp\autosave::func_12727;
  var_0["trigger_autosave_stealth"] = scripts\sp\autosave::func_12726;
  var_0["trigger_unlock"] = ::func_127A8;
  var_0["trigger_lookat"] = ::func_12760;
  var_0["trigger_looking"] = ::func_12762;
  var_0["trigger_cansee"] = ::func_1272B;
  var_0["flag_set"] = ::func_1273F;
  var_0["flag_set_player"] = ::func_12741;
  var_0["flag_unset"] = ::func_1273D;
  var_0["flag_clear"] = ::func_1273D;
  var_0["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
  var_0["radio_trigger"] = ::func_12787;
  var_0["trigger_ignore"] = ::func_12752;
  var_0["trigger_pacifist"] = ::func_1277C;
  var_0["trigger_delete"] = ::func_127A6;
  var_0["trigger_delete_on_touch"] = ::func_12731;
  var_0["trigger_off"] = ::func_127A6;
  var_0["trigger_outdoor"] = func_0B77::func_C75A;
  var_0["trigger_indoor"] = func_0B77::func_9409;
  var_0["trigger_hint"] = ::func_1274E;
  var_0["trigger_grenade_at_player"] = ::func_127A5;
  var_0["flag_on_cleared"] = ::func_1273E;
  var_0["flag_set_touching"] = ::func_12744;
  var_0["delete_link_chain"] = ::func_12730;
  var_0["trigger_slide"] = ::func_12792;
  var_0["trigger_dooropen"] = ::func_12734;
  var_0["stealth_shadow"] = ::func_1279C;
  var_0["geo_mover"] = scripts\sp\geo_mover::func_12764;
  var_0["no_crouch_or_prone"] = ::func_12775;
  var_0["no_prone"] = ::func_12776;
  return var_00;
}

func_9726() {
  scripts\sp\colors::init_colors();
  func_0B0B::init_audio();
  scripts\sp\utility::func_228A(getentarray("trigger_multiple_softlanding", "classname"));
  var_00 = func_7AA4();
  var_01 = func_7AA5();

  foreach(var_05, var_03 in var_00) {
    var_04 = getentarray(var_05, "classname");
    scripts\engine\utility::array_levelthread(var_04, var_03);
  }

  var_06 = getentarray("trigger_multiple", "classname");
  var_07 = getentarray("trigger_radius", "classname");
  var_04 = scripts\sp\utility::func_22A2(var_06, var_07);
  var_08 = getentarray("trigger_disk", "classname");
  var_04 = scripts\sp\utility::func_22A2(var_04, var_08);
  var_09 = getentarray("trigger_once", "classname");
  var_04 = scripts\sp\utility::func_22A2(var_04, var_09);

  if(!scripts\sp\starts::func_9C4B()) {
    for (var_10 = 0; var_10 < var_4.size; var_10++) {
      if(var_4[var_10].spawnflags & 32)
        thread func_0B77::func_12797(var_4[var_10]);
    }
  }

  var_11 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage"];

  foreach(var_13 in var_11) {
    var_04 = getentarray(var_13, "code_classname");

    foreach(var_15 in var_04) {
      if(isdefined(var_15.script_flag_true))
        level thread func_1278F(var_15);

      if(isdefined(var_15.script_flag_false))
        level thread func_1278E(var_15);

      if(isdefined(var_15.func_ED0E) || isdefined(var_15.func_ED0D))
        level thread scripts\sp\autosave::func_268B(var_15);

      if(isdefined(var_15.func_EE17))
        level thread scripts\sp\mgturret::func_B6BE(var_15);

      if(isdefined(var_15.func_EDF7))
        level thread func_0B77::func_A617(var_15);

      if(isdefined(var_15.func_EDF5))
        level thread scripts\sp\vehicle_code::func_A629(var_15);

      if(isdefined(var_15.script_emptyspawner))
        level thread func_0B77::func_61BD(var_15);

      if(isdefined(var_15.script_prefab_exploder))
        var_15.targetname = var_15.script_prefab_exploder;

      if(isdefined(var_15.targetname))
        level thread exploder_load(var_15);

      if(isdefined(var_15.func_EEEF))
        level thread func_12780(var_15);

      if(isdefined(var_15.func_ED18))
        level thread func_12729(var_15);

      if(isdefined(var_15.func_EEEE))
        var_15 thread func_1274C();

      if(isdefined(var_15.func_EE90))
        level thread func_0B77::func_DC8F(var_15);

      if(isdefined(var_15.targetname)) {
        var_16 = var_15.targetname;

        if(isdefined(var_1[var_16]))
          level thread[[var_1[var_16]]](var_15);
      }
    }
  }
}

func_1272E(var_00) {
  var_01 = 1;

  if(var_01)
    var_00 delete();
}

func_4984() {}

func_9CEA() {
  if(getdvar("createfx") != "")
    return 1;

  if(getdvarint("scr_art_tweak") > 0)
    return 1;

  if(isdefined(level.func_10CDA) && level.func_10CDA == "no_game")
    return 1;

  return 0;
}

func_12773(var_00) {
  var_02 = undefined;
  var_03 = undefined;

  if(isdefined(var_0.func_EEE7))
    var_02 = strtok(var_0.func_EEE7, " ");

  if(isdefined(var_0.func_EEE8))
    var_03 = strtok(var_0.func_EEE8, " ");

  if(isdefined(var_02)) {
    foreach(var_05 in var_02) {
      if(!scripts\engine\utility::flag_exist(var_05 + "_loaded"))
        scripts\engine\utility::flag_init(var_05 + "_loaded");
    }
  }

  if(isdefined(var_03)) {
    foreach(var_05 in var_03) {
      if(!scripts\engine\utility::flag_exist(var_05 + "_loaded"))
        scripts\engine\utility::flag_init(var_05 + "_loaded");
    }
  }

  for (;;) {
    var_00 waittill("trigger");

    if(isdefined(var_03))
      scripts\sp\utility::func_12651(var_03);

    if(isdefined(var_02))
      scripts\sp\utility::func_12643(var_02);
  }
}

func_1272F(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  for (;;) {
    var_00 waittill("trigger", var_02);

    if(!isalive(var_02)) {
      continue;
    }
    if(!isplayer(var_02)) {
      continue;
    }
    var_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_01, var_02);
  }
}

func_1273D(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  for (;;) {
    var_00 waittill("trigger");
    var_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_clear(var_01);
  }
}

func_1273E(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  for (;;) {
    var_00 waittill("trigger");
    wait 1;

    if(var_00 func_733E()) {
      continue;
    }
    break;
  }

  scripts\engine\utility::flag_set(var_01);
}

func_733E() {
  var_00 = _getaiarray("bad_guys");

  for (var_01 = 0; var_01 < var_0.size; var_1++) {
    var_02 = var_0[var_01];

    if(!isalive(var_02)) {
      continue;
    }
    if(var_02 istouching(self))
      return 1;

    wait 0.1;
  }

  var_00 = _getaiarray("bad_guys");

  for (var_01 = 0; var_01 < var_0.size; var_1++) {
    var_02 = var_0[var_01];

    if(var_02 istouching(self))
      return 1;
  }

  return 0;
}

func_1273F(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  for (;;) {
    var_00 waittill("trigger", var_02);
    var_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_01, var_02);

    if(!isdefined(var_00)) {
      break;
    }
  }
}

trigger_friendly_respawn(var_00) {
  var_00 endon("death");
  var_01 = getent(var_0.target, "targetname");
  var_02 = undefined;

  if(isdefined(var_01)) {
    var_02 = var_1.origin;
    var_01 delete();
  } else {
    var_01 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_02 = var_1.origin;
  }

  for (;;) {
    var_00 waittill("trigger");
    level.respawn_threshold = var_02;
    scripts\engine\utility::flag_set("respawn_friendlies");
    wait 0.5;
  }
}

func_1275E(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  if(!isdefined(level.func_A842))
    level.func_A842 = [];

  for (;;) {
    var_00 waittill("trigger", var_02);

    if(isalive(var_02) && isdefined(var_00) && var_02 istouching(var_00))
      level.func_A842 = scripts\engine\utility::array_add(level.func_A842, var_00);

    while (isalive(var_02) && isdefined(var_00) && var_02 istouching(var_00)) {
      if(!scripts\engine\utility::flag(var_01))
        thread func_1275F(var_01);

      wait 0.25;
    }

    level.func_A842 = scripts\engine\utility::array_remove(level.func_A842, var_00);
  }
}

func_1275F(var_00) {
  scripts\engine\utility::flag_set(var_00);

  for (;;) {
    level.func_A842 = scripts\engine\utility::array_removeundefined(level.func_A842);

    if(level.func_A842.size == 0) {
      break;
    }
    wait 0.25;
  }

  scripts\engine\utility::flag_clear(var_00);
}

func_12794(var_00) {
  var_00 _meth_84C0(1);

  if(isdefined(var_0.target)) {
    var_01 = getent(var_0.target, "targetname");
    var_00 getrankxp();
    var_00 linkto(var_01);
  }
}

func_12723(var_00) {
  var_00 _meth_84C0(1);

  if(isdefined(var_0.target)) {
    var_01 = getent(var_0.target, "targetname");
    var_00 getrankxp();
    var_00 linkto(var_01);
  }
}

func_12744(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  for (;;) {
    var_00 waittill("trigger", var_02);
    var_00 scripts\sp\utility::script_delay();

    if(isalive(var_02) && isdefined(var_00) && var_02 istouching(var_00))
      scripts\engine\utility::flag_set(var_01);

    while (isalive(var_02) && isdefined(var_00) && var_02 istouching(var_00))
      wait 0.25;

    scripts\engine\utility::flag_clear(var_01);
  }
}

trigger_friendly_stop_respawn(var_00) {
  for (;;) {
    var_00 waittill("trigger");
    scripts\engine\utility::flag_clear("respawn_friendlies");
  }
}

func_1274C() {
  thread func_1274D();
  level endon("trigger_group_" + self.func_EEEE);
  self waittill("trigger");
  level notify("trigger_group_" + self.func_EEEE, self);
}

func_1274D() {
  level waittill("trigger_group_" + self.func_EEEE, var_00);

  if(self != var_00)
    self delete();
}

func_12777(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(!isalive(var_01)) {
      continue;
    }
    var_1.func_10264 = 1;
    var_01 thread func_F611();
  }
}

func_F611() {
  self notify("notify_wait_then_clear_skipBloodPool");
  self endon("notify_wait_then_clear_skipBloodPool");
  self endon("death");
  wait 2;
  self.func_10264 = undefined;
}

func_1277E(var_00) {
  var_01 = [];
  var_02 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  var_03 = getentarray(var_0.target, "targetname");

  foreach(var_05 in var_03) {
    var_06 = spawnstruct();
    var_6.origin = var_5.origin;
    var_6.script_parameters = var_5.script_parameters;
    var_6.script_damage = var_5.script_damage;
    var_6.radius = var_5.radius;
    var_2[var_2.size] = var_06;
    var_05 delete();
  }

  var_0.func_C6EA = var_2[0].origin;
  var_00 waittill("trigger");
  var_00 scripts\sp\utility::script_delay();

  foreach(var_06 in var_02) {
    var_09 = var_6.radius;
    var_10 = var_6.script_parameters;
    var_11 = var_6.script_damage;

    if(!isdefined(var_09))
      var_09 = 350;

    if(!isdefined(var_10))
      var_10 = 0.25;

    setdvar("tempdvar", var_10);
    var_10 = getdvarfloat("tempdvar");

    if(isdefined(var_11))
      radiusdamage(var_6.origin, var_09, var_11, var_11 * 0.5);

    physicsexplosionsphere(var_6.origin, var_09, var_09 * 0.5, var_10);
  }
}

func_12780(var_00) {
  var_01 = var_0.func_EEEF;
  var_00 waittill("trigger");
  var_02 = _getaiarray();

  for (var_03 = 0; var_03 < var_2.size; var_3++) {
    if(!isalive(var_2[var_03])) {
      continue;
    }
    if(isdefined(var_2[var_03].func_EEEF) && var_2[var_03].func_EEEF == var_01) {
      var_2[var_03].goalradius = 800;
      var_2[var_03] setgoalentity(level.player);
      level thread func_0B77::func_50F5(var_2[var_03]);
    }
  }
}

func_1278E(var_00) {
  var_01 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_false);
  var_00 func_1786(var_01);
  var_00 scripts\engine\utility::update_trigger_based_on_flags();
}

func_1278F(var_00) {
  var_01 = scripts\engine\utility::create_flags_and_return_tokens(var_0.script_flag_true);
  var_00 func_1786(var_01);
  var_00 scripts\engine\utility::update_trigger_based_on_flags();
}

func_1786(var_00) {
  for (var_01 = 0; var_01 < var_0.size; var_1++) {
    var_02 = var_0[var_01];

    if(!isdefined(level.trigger_flags[var_02]))
      level.trigger_flags[var_02] = [];

    level.trigger_flags[var_02][level.trigger_flags[var_02].size] = self;
  }
}

func_1279A(var_00) {
  waittillframeend;
  var_01 = var_0.func_EEBA;

  if(!isdefined(level.spawn_group) || !isdefined(level.func_10727[var_01])) {
    return;
  }
  var_00 waittill("trigger");
  var_02 = scripts\engine\utility::random(level.func_10727[var_01]);

  foreach(var_05, var_04 in var_02)
  var_04 scripts\sp\utility::func_10619();
}

func_1279E(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(getdvarint("sm_sunenable") == 0) {
      continue;
    }
    _setsaveddvar("sm_sunenable", 0);
  }
}

func_1279F(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(getdvarint("sm_sunenable") == 1) {
      continue;
    }
    _setsaveddvar("sm_sunenable", 1);
  }
}

func_127AC(var_00) {
  var_00 waittill("trigger");
  var_01 = getentarray(var_0.target, "targetname");

  foreach(var_03 in var_01) {
    var_03 thread scripts\sp\vehicle_code::func_10809(70);
    wait 0.05;
  }
}

func_7D1F() {
  var_00 = [];
  var_01 = undefined;

  if(isdefined(self.target)) {
    var_02 = getentarray(self.target, "targetname");
    var_03 = [];

    foreach(var_05 in var_02) {
      if(var_5.classname == "script_origin")
        var_3[var_3.size] = var_05;

      if(issubstr(var_5.classname, "trigger"))
        var_0[var_0.size] = var_05;
    }

    var_02 = scripts\engine\utility::getstructarray(self.target, "targetname");

    foreach(var_05 in var_02)
    var_3[var_3.size] = var_05;

    if(var_3.size == 1) {
      var_09 = var_3[0];
      var_01 = var_9.origin;

      if(isdefined(var_9.code_classname))
        var_09 delete();
    }
  }

  var_10 = [];
  var_10["triggers"] = var_00;
  var_10["target_origin"] = var_01;
  return var_10;
}

func_12760(var_00) {
  func_12761(var_00, 1);
}

func_12762(var_00) {
  func_12761(var_00, 0);
}

func_12761(var_00, var_01) {
  var_02 = 0.78;

  if(isdefined(var_0.func_ED6D))
    var_02 = var_0.func_ED6D;

  var_03 = var_00 func_7D1F();
  var_04 = var_3["triggers"];
  var_05 = var_3["target_origin"];
  var_06 = isdefined(var_0.func_ED9A) || isdefined(var_0.script_noteworthy);
  var_07 = undefined;

  if(var_06) {
    var_07 = var_00 scripts\sp\utility::func_7D1E();

    if(!isdefined(level.flag[var_07]))
      scripts\engine\utility::flag_init(var_07);
  } else if(!var_4.size) {}

  if(var_01 && var_06)
    level endon(var_07);

  var_00 endon("death");
  var_08 = 1;

  if(isdefined(var_0.func_EE61))
    var_08 = var_0.func_EE61;

  for (;;) {
    if(var_06)
      scripts\engine\utility::flag_clear(var_07);

    var_00 waittill("trigger", var_09);
    var_10 = [];

    while (var_09 istouching(var_00)) {
      if(var_08 && !sighttracepassed(var_09 geteye(), var_05, 0, undefined)) {
        if(var_06)
          scripts\engine\utility::flag_clear(var_07);

        wait 0.5;
        continue;
      }

      var_11 = vectornormalize(var_05 - var_9.origin);
      var_12 = var_09 getplayerangles();
      var_13 = anglestoforward(var_12);
      var_14 = vectordot(var_13, var_11);

      if(var_14 >= var_02) {
        scripts\engine\utility::array_thread(var_04, scripts\sp\utility::func_F225, "trigger");

        if(var_06)
          scripts\engine\utility::flag_set(var_07, var_09);

        if(var_01) {
          return;
        }
        wait 2;
      } else if(var_06)
        scripts\engine\utility::flag_clear(var_07);

      if(var_08) {
        wait 0.5;
        continue;
      }

      wait 0.05;
    }
  }
}

func_1272B(var_00) {
  var_01 = [];
  var_02 = undefined;
  var_03 = var_00 func_7D1F();
  var_01 = var_3["triggers"];
  var_02 = var_3["target_origin"];
  var_04 = isdefined(var_0.func_ED9A) || isdefined(var_0.script_noteworthy);
  var_05 = undefined;

  if(var_04) {
    var_05 = var_00 scripts\sp\utility::func_7D1E();

    if(!isdefined(level.flag[var_05]))
      scripts\engine\utility::flag_init(var_05);
  } else if(!var_1.size) {}

  var_00 endon("death");
  var_06 = 12;
  var_07 = [];
  var_7[var_7.size] = (0, 0, 0);
  var_7[var_7.size] = (var_06, 0, 0);
  var_7[var_7.size] = (var_06 * -1, 0, 0);
  var_7[var_7.size] = (0, var_06, 0);
  var_7[var_7.size] = (0, var_06 * -1, 0);
  var_7[var_7.size] = (0, 0, var_06);

  for (;;) {
    if(var_04)
      scripts\engine\utility::flag_clear(var_05);

    var_00 waittill("trigger", var_08);

    while (level.player istouching(var_00)) {
      if(!var_08 func_392A(var_02, var_07)) {
        if(var_04)
          scripts\engine\utility::flag_clear(var_05);

        wait 0.1;
        continue;
      }

      if(var_04)
        scripts\engine\utility::flag_set(var_05);

      scripts\engine\utility::array_thread(var_01, scripts\sp\utility::func_F225, "trigger");
      wait 0.5;
    }
  }
}

func_392A(var_00, var_01) {
  for (var_02 = 0; var_02 < var_1.size; var_2++) {
    if(sighttracepassed(self geteye(), var_00 + var_1[var_02], 1, self))
      return 1;
  }

  return 0;
}

func_127A8(var_00) {
  var_01 = "not_set";

  if(isdefined(var_0.script_noteworthy))
    var_01 = var_0.script_noteworthy;

  var_02 = getentarray(var_0.target, "targetname");
  var_00 thread func_127A9(var_0.target);

  for (;;) {
    scripts\engine\utility::array_thread(var_02, scripts\engine\utility::trigger_off);
    var_00 waittill("trigger");
    scripts\engine\utility::array_thread(var_02, scripts\engine\utility::trigger_on);
    func_135AA(var_02, var_01);
    scripts\sp\utility::func_22A4(var_02, "relock");
  }
}

func_127A9(var_00) {
  self waittill("death");
  var_01 = getentarray(var_00, "targetname");
  scripts\engine\utility::array_thread(var_01, scripts\engine\utility::trigger_off);
}

func_135AA(var_00, var_01) {
  level endon("unlocked_trigger_hit" + var_01);
  var_02 = spawnstruct();

  for (var_03 = 0; var_03 < var_0.size; var_3++)
    var_0[var_03] thread func_E1A0(var_02, var_01);

  var_02 waittill("trigger");
  level notify("unlocked_trigger_hit" + var_01);
}

func_E1A0(var_00, var_01) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + var_01);
  self waittill("trigger");
  var_00 notify("trigger");
}

func_12729(var_00) {
  var_01 = undefined;

  if(isdefined(var_0.target)) {
    var_02 = getentarray(var_0.target, "targetname");

    if(issubstr(var_2[0].classname, "trigger"))
      var_01 = var_2[0];
  }

  if(isdefined(var_01))
    var_01 waittill("trigger", var_03);
  else
    var_00 waittill("trigger", var_03);

  var_04 = undefined;

  if(isdefined(var_01)) {
    if(var_3.team != level.player.team && level.player istouching(var_00))
      var_04 = level.player scripts\anim\battlechatter::func_7E32("custom");
    else if(var_3.team == level.player.team) {
      var_05 = "axis";

      if(level.player.team == "axis")
        var_05 = "allies";

      var_06 = scripts\anim\battlechatter::_meth_8145("custom", var_05);
      var_06 = scripts\engine\utility::get_array_of_farthest(level.player.origin, var_06);

      foreach(var_08 in var_06) {
        if(var_08 istouching(var_00)) {
          var_04 = var_08;

          if(func_28D5(var_8.origin)) {
            break;
          }
        }
      }
    }
  } else if(isplayer(var_03))
    var_04 = var_03 scripts\anim\battlechatter::func_7E32("custom");
  else
    var_04 = var_03;

  if(!isdefined(var_04)) {
    return;
  }
  if(func_28D5()) {
    return;
  }
  var_10 = var_04 scripts\sp\utility::func_4C39(var_0.func_ED18);

  if(!var_10)
    level scripts\engine\utility::delaythread(0.25, ::func_12729, var_00);
  else
    var_00 notify("custom_battlechatter_done");
}

func_28D5(var_00) {
  return distancesquared(var_00, level.player getorigin()) <= 262144;
}

func_12734(var_00) {
  var_00 waittill("trigger");
  var_01 = getentarray(var_0.target, "targetname");
  var_02 = [];
  var_2["left_door"] = -170;
  var_2["right_door"] = 170;

  foreach(var_04 in var_01) {
    var_05 = var_2[var_4.script_noteworthy];
    var_04 connectpaths();
    var_04 rotateyaw(var_05, 1, 0, 0.5);
  }
}

func_1274B(var_00) {
  var_01 = _getglassarray(var_0.target);

  if(!isdefined(var_01) || var_1.size == 0) {
    return;
  }
  for (;;) {
    level waittill("glass_break", var_02);

    if(var_02 istouching(var_00)) {
      var_03 = var_2.origin;
      wait 0.05;
      var_04 = var_2.origin;
      var_05 = undefined;

      if(var_03 != var_04)
        var_05 = var_04 - var_03;

      if(isdefined(var_05)) {
        foreach(var_07 in var_01)
        _destroyglass(var_07, var_05);

        break;
      } else {
        foreach(var_07 in var_01)
        _destroyglass(var_07);

        break;
      }
    }
  }

  var_00 delete();
}

func_12730(var_00) {
  var_00 waittill("trigger");
  var_01 = var_00 func_7C30();
  scripts\engine\utility::array_thread(var_01, ::func_5169);
}

func_7C30() {
  var_00 = [];

  if(!isdefined(self.script_linkto))
    return var_00;

  var_01 = strtok(self.script_linkto, " ");

  for (var_02 = 0; var_02 < var_1.size; var_2++) {
    var_03 = var_1[var_02];
    var_04 = getent(var_03, "script_linkname");

    if(isdefined(var_04))
      var_0[var_0.size] = var_04;
  }

  return var_00;
}

func_5169() {
  var_00 = func_7C30();
  scripts\engine\utility::array_thread(var_00, ::func_5169);
  self delete();
}

func_127A5(var_00) {
  var_00 endon("death");
  var_00 waittill("trigger");
  scripts\sp\utility::func_11813();
}

func_1274E(var_00) {
  if(!isdefined(level.func_56D9))
    level.func_56D9 = [];

  waittillframeend;
  var_01 = var_0.func_EDDC;
  var_00 waittill("trigger", var_02);

  if(isdefined(level.func_56D9[var_01])) {
    return;
  }
  level.func_56D9[var_01] = 1;
  var_02 scripts\sp\utility::func_56BA(var_01);
}

func_12731(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(isdefined(var_01))
      var_01 delete();
  }
}

func_127A6(var_00) {
  var_00 waittill("trigger");
  var_00 scripts\engine\utility::trigger_off();

  if(!isdefined(var_0.script_linkto)) {
    return;
  }
  var_01 = strtok(var_0.script_linkto, " ");

  for (var_02 = 0; var_02 < var_1.size; var_2++)
    scripts\engine\utility::array_thread(getentarray(var_1[var_02], "script_linkname"), scripts\engine\utility::trigger_off);
}

func_12752(var_00) {
  thread func_1278D(var_00, scripts\sp\utility::func_F416, scripts\sp\utility::func_7A31);
}

func_1277C(var_00) {
  thread func_1278D(var_00, scripts\sp\utility::func_F4B2, scripts\sp\utility::func_7B61);
}

func_1278D(var_00, var_01, var_02) {
  for (;;) {
    var_00 waittill("trigger", var_03);

    if(!isalive(var_03)) {
      continue;
    }
    if(var_03[[var_02]]()) {
      continue;
    }
    var_03 thread func_11A40(var_00, var_01);
  }
}

func_11A40(var_00, var_01) {
  self endon("death");
  self.ignoreme = 1;
  [
    [var_01]
  ](1);
  self.ignoretriggers = 1;
  wait 1;
  self.ignoretriggers = 0;

  while (self istouching(var_00))
    wait 1;

  [
    [var_01]
  ](0);
}

func_12787(var_00) {
  var_00 waittill("trigger");
  scripts\sp\utility::func_DBEF(var_0.script_noteworthy);
}

func_12741(var_00) {
  var_01 = var_00 scripts\sp\utility::func_7D1E();

  if(!isdefined(level.flag[var_01]))
    scripts\engine\utility::flag_init(var_01);

  for (;;) {
    var_00 waittill("trigger", var_02);

    if(!isplayer(var_02)) {
      continue;
    }
    var_00 scripts\sp\utility::script_delay();
    scripts\engine\utility::flag_set(var_01);
  }
}

func_12771(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(isdefined(var_0.script_noteworthy))
      var_01 func_0B0A::func_1121E(var_0.script_noteworthy, var_0.script_delay);

    scripts\engine\utility::waitframe();
  }
}

func_1276A(var_00) {
  waittillframeend;

  for (;;) {
    var_00 waittill("trigger", var_01);
    var_02 = var_0.func_ED68;
    var_03 = var_0.func_ED67;
    var_04 = var_0.func_ED66;
    var_05 = var_0.func_ED65;
    var_06 = var_0.func_ED64;
    var_07 = var_0.func_ED63;
    var_08 = var_0.script_delay;

    if(var_02 != level.func_5832["base"]["goal"]["nearStart"] || var_03 != level.func_5832["base"]["goal"]["nearEnd"] || var_04 != level.func_5832["base"]["goal"]["nearBlur"] || var_05 != level.func_5832["base"]["goal"]["farStart"] || var_06 != level.func_5832["base"]["goal"]["farEnd"] || var_07 != level.func_5832["base"]["goal"]["farBlur"]) {
      func_0B0A::func_5848(var_02, var_03, var_04, var_05, var_06, var_07, var_08);
      wait(var_08);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12772(var_00) {
  if(level.func_13E0F || level.func_DADB) {
    return;
  }
  waittillframeend;

  for (;;) {
    var_00 waittill("trigger", var_01);
    var_02 = var_0.func_EEDF;
    var_03 = var_0.func_EEE0;
    var_04 = var_0.script_delay;

    if(var_02 != level.func_11714.func_4CA6 || var_03 != level.func_11714.func_4CA8) {
      var_02 = max(0, var_02);
      var_02 = min(10000, var_02);
      var_03 = max(0, var_03);
      var_03 = min(10000, var_03);
      func_0B0A::func_11716(var_02, var_03, var_04);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_12792(var_00) {
  setdvarifuninitialized("use_legacy_slide", 0);

  for (;;) {
    var_00 waittill("trigger", var_01);
    var_01 thread func_102ED(var_00);
  }
}

func_102ED(var_00) {
  if(isdefined(self.vehicle)) {
    return;
  }
  if(scripts\sp\utility::func_9F59() || self isjumping() || scripts\sp\utility::func_9C11() || func_0E4F::func_9C7B()) {
    return;
  }
  if(isdefined(self.func_D323)) {
    return;
  }
  self endon("death");

  if(soundexists("SCN_cliffhanger_player_hillslide"))
    self playsound("SCN_cliffhanger_player_hillslide");

  var_01 = undefined;

  if(isdefined(var_0.script_accel))
    var_01 = var_0.script_accel;

  self endon("cancel_sliding");

  if(getdvarint("use_legacy_slide") > 0)
    thread scripts\sp\utility::func_2A76();
  else
    thread scripts\sp\utility::func_2A75(undefined, var_01);

  for (;;) {
    if(!self istouching(var_00)) {
      break;
    }
    wait 0.05;
  }

  if(isdefined(level.func_62F7))
    wait(level.func_62F7);

  if(getdvarint("use_legacy_slide") > 0)
    scripts\sp\utility::func_638A();
  else
    scripts\sp\utility::func_6389();
}

func_1276E(var_00) {
  var_01 = spawn("script_origin", (0, 0, 0));
  var_0.fx = [];

  foreach(var_03 in level.createfxent)
  func_23C8(var_03, var_00, var_01);

  var_01 delete();

  if(!isdefined(var_0.target)) {
    return;
  }
  var_05 = getentarray(var_0.target, "targetname");
  var_0.func_75AD = 1;

  foreach(var_07 in var_05) {
    switch (var_7.classname) {
      case "trigger_multiple_fx_volume_on":
        var_07 thread func_1276D(var_00);
        break;
      case "trigger_multiple_fx_volume_off":
        var_07 thread func_1276C(var_00);
        break;
      default:
        break;
    }
  }
}

func_1276D(var_00) {
  for (;;) {
    self waittill("trigger");

    if(!var_0.func_75AD)
      scripts\engine\utility::array_thread(var_0.fx, scripts\sp\utility::func_E2B0);

    wait 1;
  }
}

func_1276C(var_00) {
  for (;;) {
    self waittill("trigger");

    if(var_0.func_75AD)
      scripts\engine\utility::array_thread(var_0.fx, scripts\engine\utility::pauseeffect);

    wait 1;
  }
}

func_23C8(var_00, var_01, var_02) {
  if(isdefined(var_0.v["soundalias"]) && var_0.v["soundalias"] != "nil") {
    if(!isdefined(var_0.v["stopable"]) || !var_0.v["stopable"])
      return;
  }

  var_2.origin = var_0.v["origin"];

  if(var_02 istouching(var_01))
    var_1.fx[var_1.fx.size] = var_00;
}

func_12769(var_00) {
  var_01 = var_0.script_parameters;

  if(!isdefined(level.func_B7AE))
    level.func_B7AE = "";

  for (;;) {
    var_00 waittill("trigger");

    if(level.func_B7AE != var_01)
      scripts\sp\compass::setupminimap(var_01);
  }
}

func_12775(var_00) {
  scripts\engine\utility::array_thread(level.players, ::func_BFE5, var_00);
}

func_BFE5(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(!isdefined(var_01)) {
      continue;
    }
    if(var_01 != self) {
      continue;
    }
    while (var_01 istouching(var_00)) {
      var_01 getnumownedactiveagents(0);
      var_01 getnumberoffrozenticksfromwave(0);
      wait 0.05;
    }

    var_01 getnumownedactiveagents(1);
    var_01 getnumberoffrozenticksfromwave(1);
  }
}

func_1275A(var_00) {
  if(!isdefined(level.func_A0E4))
    level.func_A0E4 = 0;

  var_0.func_12751 = level.func_A0E4;
  level.func_A0E4++;
  var_0.func_C75B = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_0.func_98F5 = scripts\engine\utility::getstruct(var_0.func_C75B.target, "targetname");

  for (;;) {
    var_00 waittill("trigger", var_01);

    if(!isdefined(level.func_D127) || var_01 != level.func_D127) {
      continue;
    }
    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_push")) {
      continue;
    }
    var_00 thread[[level.func_A056.trigger_func.func_A0E2]]();

    while (isalive(var_01) && isdefined(var_00) && var_01 istouching(var_00) && isdefined(level.func_D127))
      wait 0.05;

    var_00 thread[[level.func_A056.trigger_func.func_A0E3]]();
  }
}

func_1275B(var_00) {
  var_01 = "trigger_jackal_boundary_warning";

  if(!isdefined(level.func_A392))
    level.func_A392 = [];

  if(!scripts\engine\utility::flag_exist(var_01))
    scripts\engine\utility::flag_init(var_01);

  var_02 = scripts\engine\utility::getstruct(var_0.target, "targetname");

  if(!isdefined(var_02)) {
    var_02 = getent(var_0.target, "targetname");
    var_03 = 1;
  } else
    var_03 = 0;

  for (;;) {
    var_00 waittill("trigger", var_04);

    if(!isdefined(level.func_D127) || var_04 != level.func_D127) {
      continue;
    }
    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
      while (isalive(var_04) && isdefined(var_00) && var_04 istouching(var_00) && isdefined(level.func_D127) && level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning"))
        wait 0.05;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_warning")) {
      continue;
    }
    if(!scripts\engine\utility::flag(var_01)) {
      scripts\engine\utility::flag_set(var_01);
      var_02 thread func_A391(var_04, var_03, var_01);
      level.func_A392 = scripts\engine\utility::array_add(level.func_A392, var_00);
    }

    while (isalive(var_04) && isdefined(var_00) && var_04 istouching(var_00) && isdefined(level.func_D127))
      wait 0.05;

    level.func_A392 = scripts\engine\utility::array_remove(level.func_A392, var_00);

    if(level.func_A392.size == 0)
      scripts\engine\utility::flag_clear(var_01);
  }
}

func_A391(var_00, var_01, var_02) {
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_3.func_138F0 = 0;
  var_04 = 0;

  if(var_01) {
    var_05 = _getpartname(self.model, 0);
    var_03 linkto(self, var_05, (0, 0, 0), (0, 0, 0));
  } else
    var_3.origin = self.origin;

  var_06 = 0;

  while (var_06 < 1) {
    if(scripts\engine\utility::flag(var_02) || scripts\engine\utility::flag("jackal_is_autoturning"))
      var_06 = 0;
    else
      var_6++;

    var_07 = vectornormalize(self.origin - level.func_D127.origin);
    var_08 = anglestoforward(level.func_D127.angles);
    var_09 = vectordot(var_07, var_08);
    var_10 = vectornormalize(level.func_D127.spaceship_vel);
    var_11 = vectordot(var_07, var_10);

    if(var_09 > 0.1 && var_11 > 0.1) {
      if(var_04) {
        var_04 = 0;
        var_03[[level.func_A056.trigger_func.func_A0E5]](var_04);
      }
    } else if(!var_04) {
      var_04 = 1;
      var_03[[level.func_A056.trigger_func.func_A0E5]](var_04);
    }

    wait 0.05;
  }

  var_03[[level.func_A056.trigger_func.func_A0E5]](0);
  var_03 delete();
}

func_12759(var_00) {
  var_01 = "trigger_jackal_boundary_autoturn";
  var_02 = "jackal_is_autoturning";

  if(!scripts\engine\utility::flag_exist(var_01))
    scripts\engine\utility::flag_init(var_01);

  if(!scripts\engine\utility::flag_exist(var_02))
    scripts\engine\utility::flag_init(var_02);

  var_03 = scripts\engine\utility::getstruct(var_0.target, "targetname");

  for (;;) {
    var_00 waittill("trigger", var_04);

    if(!isdefined(level.func_D127) || var_04 != level.func_D127 || scripts\engine\utility::flag(var_01)) {
      continue;
    }
    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
      while (isalive(var_04) && isdefined(var_00) && var_04 istouching(var_00) && isdefined(level.func_D127) && level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn"))
        wait 0.05;
    }

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_map_boundary_autoturn")) {
      continue;
    }
    if(!scripts\engine\utility::flag(var_01)) {
      scripts\engine\utility::flag_set(var_01);

      if(!scripts\engine\utility::flag(var_02))
        var_03 thread[[level.func_A056.trigger_func.func_A0E1]](var_00, var_04, var_01, var_02);

      level.func_A056.func_2698 = scripts\engine\utility::array_add(level.func_A056.func_2698, var_00);
    }

    while (isalive(var_04) && isdefined(var_00) && var_04 istouching(var_00) && isdefined(level.func_D127))
      wait 0.05;

    level.func_A056.func_2698 = scripts\engine\utility::array_remove(level.func_A056.func_2698, var_00);

    if(level.func_A056.func_2698.size == 0)
      scripts\engine\utility::flag_clear(var_01);
  }
}

func_1275C(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(!isdefined(level.func_D127) || var_01 != level.func_D127) {
      continue;
    }
    var_00 func_A2FF();

    while (isalive(var_01) && isdefined(var_00) && var_01 istouching(var_00) && isdefined(level.func_D127))
      wait 0.25;

    var_00 func_A300();
  }
}

func_A2FF() {
  if(!isdefined(level.func_A056) || !isdefined(level.func_A056.func_10991)) {
    return;
  }
  level.func_A056.func_10991 = scripts\engine\utility::array_add(level.func_A056.func_10991, self);
  level.func_A056.func_10991 = scripts\engine\utility::array_sort_with_func(level.func_A056.func_10991, ::func_9C91);
  level notify("notify_new_jackal_speed_zone");
}

func_A300() {
  if(!isdefined(level.func_A056) || !isdefined(level.func_A056.func_10991)) {
    return;
  }
  level.func_A056.func_10991 = scripts\engine\utility::array_remove(level.func_A056.func_10991, self);
  level notify("notify_new_jackal_speed_zone");
}

func_9C91(var_00, var_01) {
  return var_0.func_EE8C > var_1.func_EE8C;
}

func_12776(var_00) {
  scripts\engine\utility::array_thread(level.players, ::func_C00E, var_00);
}

func_C00E(var_00) {
  for (;;) {
    var_00 waittill("trigger", var_01);

    if(!isdefined(var_01)) {
      continue;
    }
    if(var_01 != self) {
      continue;
    }
    while (var_01 istouching(var_00)) {
      var_01 getnumownedactiveagents(0);
      wait 0.05;
    }

    var_01 getnumownedactiveagents(1);
  }
}

exploder_load(var_00) {
  level endon("killexplodertridgers" + var_0.targetname);
  var_00 waittill("trigger");

  if(isdefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(!var_00 scripts\sp\utility::script_delay())
      wait 4;

    level thread exploder_load(var_00);
    return;
  }

  if(!var_00 scripts\sp\utility::script_delay() && isdefined(var_0.func_ED85))
    wait(var_0.func_ED85);

  scripts\engine\utility::exploder(var_0.targetname);
  level notify("killexplodertridgers" + var_0.targetname);
}

func_12770(var_00) {
  if(getdvarint("kleenex") != 1) {
    return;
  }
  var_00 waittill("trigger");
  scripts\sp\utility::func_A6F2();
}

func_1279C(var_00) {
  var_00 endon("death");
  var_01 = "stealth_in_shadow";

  for (;;) {
    var_00 waittill("trigger", var_02);

    if(!var_02 scripts\sp\utility::func_65DF(var_01)) {
      continue;
    }
    if(var_02 scripts\sp\utility::func_65DB(var_01)) {
      continue;
    }
    var_02 thread func_93A4(var_00, var_01);
  }
}

func_93A4(var_00, var_01) {
  self endon("death");
  scripts\sp\utility::func_65E1(var_01);

  while (isdefined(var_00) && self istouching(var_00))
    wait 0.05;

  scripts\sp\utility::func_65DD(var_01);
}

func_1273C(var_00) {
  var_00 endon("death");
  var_01 = 2;
  var_02 = 2;
  var_03 = 0;

  if(!isdefined(var_0.script_delay_min) && !isdefined(var_0.script_delay_max)) {
    var_0.script_delay_min = 0.3;
    var_0.script_delay_max = 0.9;
  }

  if(isdefined(var_0.script_damage))
    var_01 = var_0.script_damage;

  for (;;) {
    var_00 waittill("trigger", var_04);
    var_05 = var_0.origin;

    if(isplayer(var_04)) {
      var_03 = var_01;

      if(var_0.classname == "trigger_radius_fire") {
        if(isdefined(var_0.script_radius)) {
          if(distance2dsquared(var_4.origin, var_0.origin) <= squared(var_0.script_radius)) {
            if(isdefined(var_0.func_EE51) && isnumber(var_0.func_EE51))
              var_02 = var_0.func_EE51;

            var_03 = var_03 * var_02;
          }
        }
      } else if(isdefined(var_0.target)) {
        var_06 = scripts\engine\utility::getstruct(var_0.target, "targetname");
        var_05 = var_6.origin;

        if(isdefined(var_6.script_radius)) {
          if(distance2dsquared(var_4.origin, var_6.origin) <= squared(var_6.script_radius)) {
            if(isdefined(var_0.func_EE51) && isnumber(var_0.func_EE51))
              var_02 = var_0.func_EE51;

            var_03 = var_03 * var_02;
          }
        }
      }
    }

    var_04 getrandomarmkillstreak(var_03, var_05);

    if(var_03 < 6)
      var_04 playrumbleonentity("damage_light");
    else
      var_04 playrumbleonentity("damage_heavy");

    var_00 scripts\sp\utility::script_delay();
  }
}