/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2637.gsc
***************************************/

init_coop_challenge() {
  func_956D();

  if(!isdefined(level.challenge_scalar_func))
    level.challenge_scalar_func = ::func_4FE2;

  func_97B0();
}

func_C9B9() {
  [
    [level.challenge_pause_func]
  ]();
}

func_956D() {
  scripts\engine\utility::flag_init("pause_challenges");
  var_00 = getdvar("ui_mapname");
  level.zombie_challenge_table = "cp\zombies\" + var_00 + "
  _challenges.csv ";

  if(!_tableexists(level.zombie_challenge_table))
    level.zombie_challenge_table = undefined;

  level.challenge_data = [];

  if(isdefined(level.challenge_registration_func))
    [[level.challenge_registration_func]]();

  level.current_challenge_index = -1;
  level.current_challenge_progress_max = -1;
  level.current_challenge_progress_current = -1;
  level.current_challenge_percent = -1;
  level.current_challenge_target_player = -1;
  level.current_challenge_timer = -1;
  level.current_challenge_scalar = -1;
  level.current_challenge_title = -1;
  level.current_challenge_pre_challenge = 0;
  level.func_1BE8 = 1;
  level.func_D7B7 = 0;
  level.func_C1E1 = 0;
  level.func_110AC = 0;
}

update_challenge(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!current_challenge_is(var_00) || !scripts\cp\utility::coop_mode_has("challenge")) {
    return;
  }
  if(level.func_D7B7) {
    return;
  }
  var_10 = level.challenge_data[level.current_challenge];
  var_10 thread[[var_10.func_12E9C]](var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
}

func_62C6() {
  if(current_challenge_exist() && scripts\cp\utility::coop_mode_has("challenge"))
    deactivate_current_challenge();
}

deactivate_current_challenge() {
  if(!current_challenge_exist()) {
    return;
  }
  var_00 = level.challenge_data[level.current_challenge];
  func_12BF7();

  if(var_00[[var_0.func_9F82]]()) {
    func_56AD("challenge_success", 0);
    var_00[[var_0.func_E4C5]]();
    var_01 = "challenge";

    if(isdefined(level.func_3C24))
      var_01 = level.func_3C24;

    scripts\cp\cp_gamescore::update_players_encounter_performance(var_01, "challenge_complete");
    scripts\cp\cp_persistence::update_lb_aliensession_challenge(1);
    scripts\cp\cp_analytics::update_challenges_status(var_0.ref, 1);

    if(func_9F17(var_00)) {
      if(level.current_challenge_timer - level.storechallengetime <= 0.01)
        scripts\cp\zombies\zombie_analytics::func_AF63(var_0.ref, level.wave_num, level.storechallengetime - level.current_challenge_timer);
      else
        scripts\cp\zombies\zombie_analytics::func_AF63(var_0.ref, level.wave_num, level.current_challenge_timer);

      foreach(var_03 in level.players)
      var_03 thread scripts\cp\cp_vo::try_to_play_vo("challenge_success_generic", "zmb_comment_vo");

      level.func_C1E1++;
    }
  } else {
    func_56AD("challenge_failed", 0);

    if(func_9F17(var_00)) {
      if(isdefined(level.func_3C2B[var_0.ref]) && func_9F17(var_00))
        level.func_3C2B[var_0.ref]++;

      if(var_0.ref == "no_laststand" || var_0.ref == "no_bleedout" || var_0.ref == "protect_player")
        scripts\cp\zombies\zombie_analytics::func_AF64(var_0.ref, level.wave_num, 0, level.func_3C2B[var_0.ref]);
      else
        scripts\cp\zombies\zombie_analytics::func_AF64(var_0.ref, level.wave_num, var_0.current_progress / var_0.goal * 100, level.func_3C2B[var_0.ref]);

      foreach(var_03 in level.players) {
        if(!scripts\cp\utility::isplayingsolo() && level.players.size > 1) {
          scripts\cp\cp_vo::try_to_play_vo_on_all_players("challenge_fail_team");
          continue;
        }

        var_03 thread scripts\cp\cp_vo::try_to_play_vo("challenge_fail_solo", "zmb_comment_vo");
      }
    }

    var_00[[var_0.func_6AD0]]();
    level.func_1BE8 = 0;
    scripts\cp\cp_persistence::update_lb_aliensession_challenge(0);
    scripts\cp\cp_analytics::update_challenges_status(var_0.ref, 0);
  }

  level notify("challenge_deactivated");
  var_00[[var_0.func_4DDE]]();
}

func_9F17(var_00) {
  switch (var_0.ref) {
    case "challenge_success":
    case "challenge_failed":
    case "next_challenge":
      return 0;
    default:
      return 1;
  }
}

activate_new_challenge(var_00) {
  var_01 = level.challenge_data[var_00];

  if(!isdefined(level.func_3C2B[var_00]) && var_00 != "next_challenge")
    level.func_3C2B[var_00] = 0;

  if(var_01[[var_1.func_386E]]()) {
    var_02 = func_7897(var_00);

    if(isdefined(var_02)) {
      level.challenge_data[var_00].goal = var_02;
      level.current_challenge_scalar = var_02;
    } else
      level.current_challenge_scalar = -1;

    func_56AD(var_00, 1, var_02);
    func_F31A(var_00);
    level.current_challenge_pre_challenge = 0;
    var_01[[var_1.func_1609]]();
  } else
    var_01[[var_1.func_6ACB]]();
}

func_7897(var_00) {
  return [
    [level.challenge_scalar_func]
  ](var_00);
}

func_3C15() {
  level endon("game_ended");
  var_00 = int(gettime() + 5000);

  foreach(var_02 in level.players)
  var_02 setclientomnvar("ui_intel_title", 1);

  level.current_challenge_title = 1;
  wait 5;

  foreach(var_02 in level.players)
  var_02 setclientomnvar("ui_intel_title", -1);

  level.current_challenge_title = -1;
  wait 0.5;
}

func_56AD(var_00, var_01, var_02) {
  var_03 = tablelookup(level.zombie_challenge_table, 1, var_00, 0);

  foreach(var_05 in level.players) {
    if(var_01) {
      if(isdefined(var_02)) {
        var_05 setclientomnvar("ui_intel_challenge_scalar", var_02);
        var_05 setclientomnvar("ui_intel_progress_max", var_02);
      } else
        var_05 setclientomnvar("ui_intel_challenge_scalar", -1);

      var_05 setclientomnvar("ui_intel_prechallenge", 1);
      var_05 setclientomnvar("ui_intel_active_index", int(var_03));
      level.current_challenge_index = int(var_03);
      level.current_challenge_pre_challenge = 1;

      if(var_00 == "next_challenge")
        var_05 playlocalsound("zmb_challenge_config");
      else
        var_05 playlocalsound("zmb_challenge_start");

      var_05 setclientomnvar("zm_show_challenge", 4);
      level.current_zm_show_challenge = 4;
    }
  }

  if(var_01) {
    return;
  }
  if(level.current_zm_show_challenge != 2 && level.current_zm_show_challenge != 3 && level.current_zm_show_challenge != 4)
    level thread func_100CB(var_00, var_03);
}

func_100CB(var_00, var_01) {
  level endon("game_ended");
  wait 1;

  foreach(var_03 in level.players) {
    if(var_00 == "challenge_failed") {
      var_03 playlocalsound("zmb_challenge_fail");
      var_03 setclientomnvar("zm_show_challenge", 2);
      level.current_zm_show_challenge = 2;
      continue;
    }

    var_03 playlocalsound("zmb_challenge_complete");
    var_03 setclientomnvar("zm_show_challenge", 3);
    level.current_zm_show_challenge = 3;
  }

  wait 3.0;

  foreach(var_03 in level.players)
  var_03 thread reset_omnvars();

  setomnvar("zm_challenge_progress", 0);
  level.current_challenge_index = -1;
  level.current_challenge_progress_max = -1;
  level.current_challenge_progress_current = -1;
  level.current_challenge_percent = -1;
  level.current_challenge_target_player = -1;
  level.current_challenge_timer = -1;
  level.current_challenge_scalar = -1;
  level.current_challenge_pre_challenge = 0;
}

reset_omnvars() {
  wait 0.5;
  self setclientomnvar("ui_intel_active_index", -1);
  self setclientomnvar("ui_intel_progress_current", -1);
  self setclientomnvar("ui_intel_progress_max", -1);
  self setclientomnvar("ui_intel_percent", -1);
  self setclientomnvar("ui_intel_target_player", -1);
  self setclientomnvar("ui_intel_prechallenge", 0);
  self setclientomnvar("ui_intel_timer", -1);
  self setclientomnvar("ui_intel_challenge_scalar", -1);
}

register_challenge(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  var_11 = spawnstruct();
  var_11.ref = var_00;
  var_11.goal = var_01;
  var_11.default_success = var_02;
  var_11.func_9F82 = ::func_4FFA;

  if(isdefined(var_03))
    var_11.func_9F82 = var_03;

  var_11.func_386E = ::func_4FDD;

  if(isdefined(var_04))
    var_11.func_386E = var_04;

  var_11.func_1609 = var_05;
  var_11.func_4DDE = var_06;
  var_11.func_6ACB = ::func_4FED;

  if(isdefined(var_07))
    var_11.func_6ACB = var_07;

  var_11.func_12E9C = var_08;
  var_11.func_E4C5 = ::func_5011;

  if(isdefined(var_09))
    var_11.func_E4C5 = var_09;

  var_11.func_6AD0 = ::func_4FEE;

  if(isdefined(var_10))
    var_11.func_6AD0 = var_10;

  level.challenge_data[var_00] = var_11;
}

update_challenge_progress(var_00, var_01) {
  if(scripts\engine\utility::flag("pause_challenges")) {
    return;
  }
  foreach(var_03 in level.players) {
    var_03 setclientomnvar("zm_show_challenge", 1);
    var_03 setclientomnvar("ui_intel_progress_current", var_00);
    level.current_zm_show_challenge = 1;
  }

  setomnvar("zm_challenge_progress", var_00 / var_01);
  level.current_challenge_progress_max = var_01;
  level.current_challenge_progress_current = var_00;
}

func_4FDD() {
  return 1;
}

func_4FED() {}

func_4FFA() {
  if(isdefined(self.success))
    return self.success;
  else
    return 0;
}

default_successfunc() {
  if(isdefined(self.success))
    return self.success;
  else
    return self.default_success;
}

func_4FEE() {}

default_resetsuccess() {
  self.success = self.default_success;
}

func_5011() {}

current_challenge_exist() {
  return isdefined(level.current_challenge);
}

current_challenge_is(var_00) {
  return current_challenge_exist() && level.current_challenge == var_00;
}

func_12BF7() {
  level.current_challenge = undefined;
}

func_F31A(var_00) {
  level.current_challenge = var_00;
  scripts\cp\zombies\zombie_analytics::func_AF62(level.current_challenge, level.wave_num);
  level.func_110AC = gettime() / 1000;
}

func_7B31() {
  if(!isdefined(level.func_C1E1))
    return 0;
  else
    return level.func_C1E1;
}

func_97B0() {
  if(!isdefined(level.zombie_challenge_table)) {
    return;
  }
  var_00 = level.zombie_challenge_table;
  var_01 = 0;
  var_02 = 1;
  var_03 = 99;
  var_04 = 1;
  var_05 = 2;
  var_06 = 6;
  var_07 = 7;
  var_08 = 8;

  for (var_09 = var_02; var_09 <= var_03; var_9++) {
    var_10 = tablelookup(var_00, var_01, var_09, var_04);

    if(var_10 == "") {
      break;
    }
    var_11 = tablelookup(var_00, var_01, var_09, var_05);
    var_12 = tablelookup(var_00, var_01, var_09, var_08);

    if(isdefined(level.challenge_data[var_10])) {
      level.challenge_data[var_10].func_1C81 = var_11;
      level.challenge_data[var_10].func_1C8C = int(tablelookup(var_00, var_01, var_09, var_06));
      level.challenge_data[var_10].active_time = strtok(var_12, " ");
    }
  }
}

func_4FE2(var_00) {
  return 1;
}

update_death_challenges(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(scripts\engine\utility::is_true(self.died_poorly)) {
    return;
  }
  if(!isdefined(level.current_challenge)) {
    return;
  }
  var_09 = level.current_challenge;

  if(isdefined(level.custom_death_challenge_func)) {
    var_10 = self[[level.custom_death_challenge_func]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);

    if(!scripts\engine\utility::is_true(var_10))
      return;
  }
}

update_current_challenge_timer(var_00) {
  level endon("stop_challenge_timer");
  level endon("game_ended");
  level endon("challenge_deactivated");
  self endon("success");
  var_01 = 0;
  var_02 = level.current_challenge_timer;

  while (level.current_challenge_timer > 0) {
    wait 0.1;

    if(scripts\engine\utility::flag("pause_challenges")) {
      foreach(var_04 in level.players) {
        var_04 setclientomnvar("ui_intel_timer", -1);
        var_04 setclientomnvar("zm_show_challenge", 10);
      }

      scripts\engine\utility::flag_waitopen("pause_challenges");
      var_06 = int(gettime() + level.current_challenge_timer * 1000);

      foreach(var_04 in level.players) {
        var_04 setclientomnvar("ui_intel_timer", var_06);
        var_04 setclientomnvar("zm_show_challenge", level.current_zm_show_challenge);
      }
    }

    level.current_challenge_timer = level.current_challenge_timer - 0.1;

    if(isdefined(var_00))
      update_challenge_progress(int(var_02 - level.current_challenge_timer), int(var_02));
  }
}

default_timer(var_00) {
  level endon("game_ended");
  level endon("challenge_deactivated");
  self endon("success");
  var_01 = var_00;

  while (var_01 > 0) {
    wait 0.1;

    if(scripts\engine\utility::flag("pause_challenges")) {
      continue;
    }
    var_01 = var_01 - 0.1;
  }

  self.success = self.default_success;
  level thread deactivate_current_challenge();
}