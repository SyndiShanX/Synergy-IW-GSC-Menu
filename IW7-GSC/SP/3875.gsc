/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3875.gsc
************************/

main() {
  if(isdefined(level.var_10E6D)) {
    return;
  }

  init();
  thread func_B2F1();
  thread func_115E8();
}

init() {
  scripts\engine\utility::flag_set("stealth_enabled");
  level.var_10E6D = spawnstruct();
  level.var_10E6D.var_53A0 = spawnstruct();
  level.var_10E6D.save = spawnstruct();
  level.var_10E6D.var_21 = [];
  level.var_10E6D.var_74D5 = [];
  level.var_10E6D.var_53A0.state = "hidden";
  level.var_10E6D.var_53A0.var_DCCA = [];
  level.var_10E6D.var_53A0.var_DCCA["hidden"] = [];
  level.var_10E6D.var_53A0.var_DCCA["spotted"] = [];
  level.var_10E6D.var_53A0.timeout = 5;
  lib_0F19::func_4683();
  lib_0F1C::func_6855();
  level.var_10E6D.var_BF5E = 3000;
  level.var_10E6D.group = spawnstruct();
  level.var_10E6D.group.magicbullet = [];
  level.var_10E6D.group.groups = [];
  level.var_10E6D.group.var_1CEF = [];
  func_F342();
  func_9720();
  lib_0F27::func_1B3C();
  level.var_10E6D.var_B739 = 1;
  func_FA55();
}

func_FA55() {
  level lib_0F27::func_F5B4("do_stealth", ::lib_0F27::func_57C7);
  level lib_0F27::func_F5B4("is_in_stealth", ::lib_0F27::func_9C1E);
  lib_0F1B::func_F345();
}

func_F342() {
  var_00 = [];
  var_00["prone"] = 400;
  var_00["crouch"] = 800;
  var_00["stand"] = 1500;
  var_01 = [];
  var_01["prone"] = 800;
  var_01["crouch"] = 1500;
  var_01["stand"] = 3000;
  lib_0F27::func_F353(var_00, var_01);
  lib_0F19::func_F30F();
  func_95D1();
  lib_0F27::func_F357(0);
  func_6806("hidden");
}

func_95D1() {
  var_00["ai_eventDistDeath"]["spotted"] = getdvarint("ai_eventDistDeath");
  var_00["ai_eventDistDeath"]["hidden"] = 512;
  var_00["ai_eventDistPain"]["spotted"] = getdvarint("ai_eventDistPain");
  var_00["ai_eventDistPain"]["hidden"] = 256;
  var_00["ai_eventDistExplosion"]["spotted"] = getdvarint("ai_eventDistExplosion");
  var_00["ai_eventDistExplosion"]["hidden"] = 2048;
  var_00["ai_eventDistBullet"]["spotted"] = getdvarint("ai_eventDistBullet");
  var_00["ai_eventDistBullet"]["hidden"] = 64;
  var_00["ai_eventDistFootstepWalk"]["spotted"] = getdvarint("ai_eventDistFootstepWalk");
  var_00["ai_eventDistFootstepWalk"]["hidden"] = 50;
  var_00["ai_eventDistFootstep"]["spotted"] = getdvarint("ai_eventDistFootstep");
  var_00["ai_eventDistFootstep"]["hidden"] = 100;
  var_00["ai_eventDistFootstepSprint"]["spotted"] = getdvarint("ai_eventDistFootstepSprint");
  var_00["ai_eventDistFootstepSprint"]["hidden"] = 400;
  var_00["ai_eventDistGunShot"]["spotted"] = getdvarint("ai_eventDistGunShot");
  var_00["ai_eventDistGunShot"]["hidden"] = 2048;
  var_00["ai_eventDistSilencedShot"]["spotted"] = getdvarint("ai_eventDistSilencedShot");
  var_00["ai_eventDistSilencedShot"]["hidden"] = 128;
  var_00["ai_eventDistGunShotTeam"]["spotted"] = getdvarint("ai_eventDistGunShotTeam");
  var_00["ai_eventDistGunShotTeam"]["hidden"] = 750;
  var_00["ai_eventDistNewEnemy"]["spotted"] = getdvarint("ai_eventDistNewEnemy");
  var_00["ai_eventDistNewEnemy"]["hidden"] = 128;
  func_F395(var_00);
}

func_F395(param_00) {
  foreach(var_06, var_02 in param_00) {
    foreach(var_05, var_04 in var_02) {
      level.var_10E6D.var_21[var_06][var_05] = var_04;
    }
  }
}

func_F354(param_00, param_01) {
  if(isdefined(param_00)) {
    level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"] = param_00["prone"];
    level.var_10E6D.var_53A0.var_DCCA["hidden"]["crouch"] = param_00["crouch"];
    level.var_10E6D.var_53A0.var_DCCA["hidden"]["stand"] = param_00["stand"];
  }

  if(isdefined(param_01)) {
    level.var_10E6D.var_53A0.var_DCCA["spotted"]["prone"] = param_01["prone"];
    level.var_10E6D.var_53A0.var_DCCA["spotted"]["crouch"] = param_01["crouch"];
    level.var_10E6D.var_53A0.var_DCCA["spotted"]["stand"] = param_01["stand"];
  }
}

func_B2F1() {
  for (;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    lib_0F26::func_117D1(1);
    setsaveddvar("ai_corpseSynch", 1);
    scripts\engine\utility::flag_wait("stealth_spotted");
    lib_0F26::func_117D1(0);
    setsaveddvar("ai_corpseSynch", 0);
    if(getdvarint("ai_threatsightDisplay", 1)) {
      foreach(var_01 in level.players) {
        var_01 thread scripts\sp\utility::play_sound_on_entity("ui_stealth_busted");
      }
    }

    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }

    func_6806("spotted");
    thread func_10E20();
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    if(!scripts\engine\utility::flag("stealth_enabled")) {
      continue;
    }

    func_6806("hidden");
    waittillframeend;
  }
}

func_115E8() {
  level.var_10E6D.enemies["axis"] = [];
  level.var_10E6D.enemies["allies"] = [];
  for (;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    level.var_10E6D.enemies["axis"] = level.players;
    level.var_10E6D.enemies["allies"] = getaiarray("axis");
    wait(0.05);
  }
}

func_6806(param_00) {
  level.var_10E6D.var_53A0.state = param_00;
  foreach(var_04, var_02 in level.var_10E6D.var_21) {
    setsaveddvar(var_04, var_02[param_00]);
    var_03 = "ai_busyEvent" + getsubstr(var_04, 8);
    setsaveddvar(var_03, var_02[param_00]);
  }
}

func_10E20() {
  while (scripts\engine\utility::flag("stealth_spotted")) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    var_00 = level.var_10E6D.group.groups;
    foreach(var_04, var_02 in var_00) {
      var_03 = lib_0F27::func_79F6("stealth_spotted", var_04);
      if(!scripts\engine\utility::flag(var_03)) {
        continue;
      }

      var_02 = scripts\engine\utility::array_removeundefined(var_02);
      if(var_02.size > 0) {
        if(var_02[0].team == "allies") {
          continue;
        }
      }

      thread func_1284D(var_04);
    }

    scripts\engine\utility::flag_waitopen_or_timeout("stealth_spotted", level.var_10E6D.var_53A0.timeout * 1.25);
  }

  var_00 = level.var_10E6D.group.groups;
  foreach(var_04, var_02 in var_00) {
    lib_0F27::func_868A("stealth_spotted", var_04);
  }
}

func_1284D(param_00) {
  var_01 = lib_0F27::func_79F5(param_00);
  scripts\engine\utility::array_thread(var_01, ::func_C13A, param_00);
  level endon("enemy_" + param_00);
  if(var_01.size > 0) {
    var_02 = func_3DB9(param_00);
    if(!var_02) {
      return;
    }

    wait(level.var_10E6D.var_53A0.timeout);
    var_02 = func_3DB9(param_00);
    if(!var_02) {
      return;
    }
  }

  level notify("enemy_" + param_00 + "_stop");
  lib_0F27::func_868A("stealth_spotted", param_00);
}

func_C13A(param_00) {
  self notify("notify_level_on_enemy");
  self endon("notify_level_on_enemy");
  var_01 = "enemy_" + param_00;
  self endon("death");
  level endon(var_01);
  level endon(var_01 + "_stop");
  self waittill("enemy");
  level notify(var_01);
}

func_3DB9(param_00) {
  if(scripts\engine\utility::istrue(level.player.var_9BFA)) {
    return 0;
  }

  var_01 = lib_0F27::func_79F5(param_00);
  foreach(var_03 in var_01) {
    if(isalive(var_03.isnodeoccupied)) {
      return 0;
    }
  }

  return 1;
}

func_9720() {
  scripts\engine\utility::flag_init("stealth_player_nade");
  level.var_10E6D.save.var_D202 = 0;
  scripts\engine\utility::array_thread(level.players, ::func_D0B1);
}

func_D0B1() {
  for (;;) {
    self waittill("grenade_pullback");
    scripts\engine\utility::flag_set("stealth_player_nade");
    self waittill("grenade_fire", var_00);
    thread func_D0B2(var_00);
  }
}

func_D0B2(param_00) {
  level.var_10E6D.save.var_D202++;
  param_00 scripts\engine\utility::waittill_notify_or_timeout("death", 10);
  level.var_10E6D.save.var_D202--;
  waittillframeend;
  if(!level.var_10E6D.save.var_D202) {
    scripts\engine\utility::flag_clear("stealth_player_nade");
  }
}