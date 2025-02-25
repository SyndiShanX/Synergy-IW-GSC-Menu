/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\vehicle\jackal_hintmanager.gsc
**************************************************/

hintmanager_init() {
  scripts\engine\utility::flag_init("flag_jackal_hintmanaged_hint");
  var_00 = spawnstruct();
  var_00.hints = [];
  var_00.running = 0;
  var_00.var_54F1 = 0;
  return var_00;
}

hint_manager_common_hints() {
  lib_0BDC::jackal_hintmanager_hint_add("roll", & "ZEROG_ROTATE_TUTORIAL_HINT", ::hint_roll_conditions, ::hint_roll_terminator, ["+actionslot 3", "+actionslot 4"]);
  lib_0BDC::jackal_hintmanager_hint_add("missiles", & "JACKAL_MISSILE", ::hint_missile_conditions, ::hint_missile_terminator, ["+frag"]);
  lib_0BDC::jackal_hintmanager_hint_add("weaponDrone", & "JACKAL_MARK_DROPZONE", ::hint_weapdrone_conditions, ::hint_weapdrone_terminator);
  lib_0BDC::jackal_hintmanager_hint_add("dodfight", & "JACKAL_ADS", ::hint_dogfight_conditions, ::hint_dogfight_terminator, ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"]);
  lib_0BDC::jackal_hintmanager_hint_add("ascend", & "ZEROG_ASCEND_TUTORIAL_HINT", ::hint_ascend_conditions, ::hint_ascend_terminator, ["+gostand"]);
  lib_0BDC::jackal_hintmanager_hint_add("descend", & "ZEROG_DESCEND_TUTORIAL_HINT", ::hint_descend_conditions, ::hint_descend_terminator, ["+stance"]);
}

hint_manager() {
  level.var_D127 endon("player_exit_jackal");
  if(scripts\sp\utility::func_93A6()) {
    return;
  }

  if(!scripts\sp\gameskill::map_has_jackal_arena()) {
    return;
  }

  if(!scripts\sp\gameskill::jackal_arena_is_early_in_the_game() && level.var_7683 == 3) {
    return;
  }

  lib_0BDC::func_137D6();
  wait(1);
  jackal_hintmanager_run_action_watchers();
  lib_0BDC::jackal_hintmanager_refresh_all_timers();
  do_progression_specific_tutorials();
  for (;;) {
    foreach(var_01 in level.var_A056.hintmanager.hints) {
      if((level.var_A056.hintmanager jackal_hint_common_conditions(var_01) && [
          [var_01.hint_conditions]
        ](var_01)) || var_01.var_7258) {
        level.var_A056.hintmanager jackal_hint(var_01);
        jackal_hint_common_cooldown(var_01);
      }
    }

    wait(0.25);
  }
}

jackal_hintmanager_run_action_watchers() {
  foreach(var_01 in level.var_A056.hintmanager.hints) {
    if(isdefined(var_01.action_note)) {
      level thread hintmanager_action_watcher(var_01);
    }
  }
}

hintmanager_action_watcher(param_00) {
  level.var_D127 endon("player_exit_jackal");
  foreach(var_02 in param_00.hint_terminator_actions) {
    level.player notifyonplayercommand(param_00.action_note, var_02);
  }

  param_00.last_action_time = gettime();
  for (;;) {
    level.player waittill(param_00.action_note);
    param_00.last_action_time = gettime();
  }
}

jackal_hint(param_00) {
  scripts\engine\utility::flag_set("flag_jackal_hintmanaged_hint");
  self.hinting = 1;
  self.var_C8 = param_00.hint_name;
  param_00.hinting = 1;
  scripts\sp\utility::func_56BA(param_00.hint_name);
  jackal_hint_waittill_termination(param_00);
  param_00.var_7258 = 0;
  param_00.hinting = 0;
  param_00.last_time = gettime();
  self.var_C8 = "";
  self.hinting = 0;
  scripts\engine\utility::flag_clear("flag_jackal_hintmanaged_hint");
}

jackal_hint_waittill_termination(param_00) {
  if(isdefined(param_00.action_note)) {
    level.player endon(param_00.action_note);
  }

  var_01 = param_00.hint_display_time;
  while (var_01 > 0) {
    if(jackal_hint_common_terminators()) {
      break;
    }

    if([
        [param_00.hint_terminator]
      ](param_00)) {
      break;
    }

    var_01 = var_01 - 0.05;
    wait(0.05);
  }
}

jackal_hint_common_conditions(param_00) {
  if(self.var_54F1) {
    return 0;
  }

  if(level.var_A056.var_68B3.running) {
    return 0;
  }

  if(param_00.var_54F1) {
    return 0;
  }

  return 1;
}

jackal_hint_common_terminators() {
  if(self.var_54F1) {
    return 1;
  }

  return 0;
}

jackal_hint_common_cooldown(param_00) {
  wait(0.5);
}

do_progression_specific_tutorials() {
  if(scripts\sp\gameskill::map_has_jackal_arena() && scripts\sp\gameskill::get_num_jackal_arenas_completed() == 2) {
    tutorial_oneoff_roll();
  }
}

tutorial_oneoff_roll() {
  level.var_D127 endon("player_exit_jackal");
  wait(10);
  var_00 = 0;
  var_01 = 0;
  level.player.holding_roll = 0;
  thread tutorial_oneoff_watch_roll();
  for (;;) {
    if(tutorial_roll_pass_conditions()) {
      var_00 = var_00 + 0.05;
      var_01 = var_01 + 0.05;
    } else {
      var_00 = 0;
    }

    if(tutorial_roll_hint_conditions()) {
      if(!scripts\engine\utility::flag("flag_jackal_hintmanaged_hint")) {
        scripts\engine\utility::flag_set("flag_jackal_hintmanaged_hint");
        scripts\sp\utility::func_56BA("roll");
      }
    } else if(scripts\engine\utility::flag("flag_jackal_hintmanaged_hint")) {
      scripts\engine\utility::flag_clear("flag_jackal_hintmanaged_hint");
    }

    if(var_00 > 1.25 || var_01 > 2.5) {
      break;
    }

    wait(0.05);
  }

  level.player notify("completed_roll_tutorial");
  if(scripts\engine\utility::flag("flag_jackal_hintmanaged_hint")) {
    scripts\engine\utility::flag_clear("flag_jackal_hintmanaged_hint");
  }
}

tutorial_roll_pass_conditions() {
  if(!level.player.holding_roll) {
    return 0;
  }

  if(level.var_241D && level.var_D127.setglobalsoundcontext == "hover") {
    return 0;
  }

  if(level.var_A056.hintmanager.var_54F1) {
    return 0;
  }

  return 1;
}

tutorial_roll_hint_conditions() {
  if(level.player.holding_roll) {
    return 0;
  }

  if(level.var_241D && level.var_D127.setglobalsoundcontext == "hover") {
    return 0;
  }

  if(level.var_A056.hintmanager.var_54F1) {
    return 0;
  }

  return 1;
}

tutorial_oneoff_watch_roll() {
  level.player endon("completed_roll_tutorial");
  level.var_D127 endon("player_exit_jackal");
  level.player notifyonplayercommand("start_roll", "+actionslot 3");
  level.player notifyonplayercommand("start_roll", "+actionslot 4");
  level.player notifyonplayercommand("stop_roll", "-actionslot 3");
  level.player notifyonplayercommand("stop_roll", "-actionslot 4");
  for (;;) {
    level.player waittill("start_roll");
    level.player.holding_roll = 1;
    level.player waittill("stop_roll");
    level.player.holding_roll = 0;
  }
}

hint_roll_conditions(param_00) {
  if(!scripts\sp\utility::func_D123()) {
    return 0;
  }

  var_01 = gettime();
  if(abs(level.var_D127.angles[2]) > 110) {
    if(!isdefined(param_00.inverted_time)) {
      param_00.inverted_time = var_01;
    }
  } else {
    param_00.inverted_time = undefined;
  }

  if(lib_0BD1::func_D30D()) {
    return 0;
  }

  if(level.var_D127 lib_0BDC::func_8B87()) {
    return 0;
  }

  if(scripts\sp\utility::func_7B9D() < 0.5) {
    return 0;
  }

  if(gettime() - param_00.last_time < 30000) {
    return 0;
  }

  if(isdefined(param_00.inverted_time) && var_01 - param_00.inverted_time > 1000 && var_01 - param_00.last_action_time > -20536) {
    param_00.inverted_time = 1;
    return 1;
  }

  return 0;
}

hint_roll_terminator(param_00) {
  if(!scripts\sp\utility::func_D123()) {
    return 0;
  }

  if(lib_0BD1::func_D30D()) {
    return 0;
  }

  if(level.var_D127 lib_0BDC::func_8B87()) {
    return 1;
  }

  if(scripts\sp\utility::func_7B9D() < 0.5) {
    return 1;
  }

  return 0;
}

hint_missile_conditions(param_00) {
  if(level.var_D127.missiles.var_C1 <= 0) {
    return 0;
  }

  if(!scripts\sp\utility::func_D123()) {
    return 0;
  }

  var_01 = level.player _meth_848A();
  if(!isdefined(var_01) || !isdefined(var_01[0])) {
    return 0;
  }

  if(gettime() - param_00.last_time < 30000) {
    return 0;
  }

  if(gettime() - param_00.last_action_time < 140000) {
    return 0;
  }

  return 1;
}

hint_missile_terminator(param_00) {
  return 0;
}

hint_weapdrone_conditions(param_00) {
  if(!scripts\engine\utility::flag("jackal_missile_drone_primed")) {
    return 0;
  }

  if(gettime() - param_00.last_time < 90000) {
    return 0;
  }

  if(gettime() - level.var_D127.missiles.var_A8E8 < 90000) {
    return 0;
  }

  if(level.var_A056.var_933B.size > 0) {
    return 0;
  }

  if(!scripts\sp\utility::func_D123()) {
    return 0;
  }

  var_01 = level.player _meth_848A();
  if(isdefined(var_01) && isdefined(var_01[0])) {
    return 0;
  }

  if(level.var_D127 lib_0BDC::func_8B87()) {
    return 0;
  }

  if(scripts\sp\utility::func_7B9D() < 0.5) {
    return 0;
  }

  if(level.player adsbuttonpressed()) {
    return 0;
  }

  if(level.player attackbuttonpressed()) {
    return 0;
  }

  return 1;
}

hint_weapdrone_terminator(param_00) {
  if(scripts\engine\utility::flag("jackal_missile_drone_active")) {
    return 1;
  }

  if(level.var_A056.var_933B.size > 3) {
    return 0;
  }

  return 0;
}

hint_dogfight_conditions(param_00) {
  if(!isdefined(level.player.var_4BE7)) {
    return 0;
  }

  var_01 = vectordot(anglestoforward(level.var_D127.angles), vectornormalize(level.player.var_4BE7.origin - level.var_D127.origin));
  var_02 = distance(level.player.var_4BE7.origin, level.var_D127.origin);
  if(var_02 > 18000 || var_01 < 0.85) {
    return 0;
  }

  if(gettime() - param_00.last_time < -20536) {
    return 0;
  }

  if(gettime() - level.var_A056.var_A976 < 140000) {
    return 0;
  }

  return 1;
}

hint_dogfight_terminator(param_00) {
  return 0;
}

hint_ascend_conditions(param_00) {
  if(gettime() - param_00.last_time < 10000) {
    return 0;
  }

  if(gettime() - param_00.last_action_time < 90000) {
    return 0;
  }

  if(!common_ascend_descend_conditions()) {
    return 0;
  }

  if(get_target_capship_local_z() > -2000) {
    return 0;
  }

  return 1;
}

hint_ascend_terminator(param_00) {
  return 0;
}

hint_descend_conditions(param_00) {
  if(gettime() - param_00.last_time < 10000) {
    return 0;
  }

  if(gettime() - param_00.last_action_time < 90000) {
    return 0;
  }

  if(!common_ascend_descend_conditions()) {
    return 0;
  }

  if(get_target_capship_local_z() < 5000) {
    return 0;
  }

  return 1;
}

hint_descend_terminator(param_00) {
  return 0;
}

common_ascend_descend_conditions() {
  if(level.var_D127.setglobalsoundcontext != "hover") {
    return 0;
  }

  if(!isdefined(level.var_A056.target_capitalship)) {
    return 0;
  }

  var_00 = vectordot(anglestoforward(level.var_D127.angles), vectornormalize(level.var_A056.target_capitalship.origin - level.var_D127.origin));
  var_01 = distance(level.var_A056.target_capitalship.origin, level.var_D127.origin);
  if(var_01 > 30000 || var_00 < 0.75) {
    return 0;
  }

  return 1;
}

get_target_capship_local_z() {
  var_00 = rotatevectorinverted(level.var_D127.origin - level.var_A056.target_capitalship.origin, level.var_A056.target_capitalship.angles);
  return var_00[2];
}