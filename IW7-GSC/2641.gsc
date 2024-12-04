/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2641.gsc
***************************************/

init() {
  func_DEB3();
}

endgame(var_00, var_01) {
  if(gamealreadyended()) {
    return;
  }
  setnojiptime(1);
  level thread kill_all_zombies();
  func_B37C();
  level notify("game_ended", var_00);
  func_7384(1.0, "cg_fovScale", 1);

  if(var_01 == 4)
    wait 4.9;

  var_02 = 0;

  foreach(var_04 in level.players) {
    var_04 stopolcalsound("zmb_laststand_music");

    if(var_04 issplitscreenplayer()) {
      if(var_04 isreloading())
        var_04 playlocalsound("mus_zombies_gameover");

      continue;
    }

    var_04 playlocalsound("mus_zombies_gameover");
  }

  level.ingraceperiod = 0;
  setomnvar("allow_server_pause", 0);
  scripts\engine\utility::waitframe();
  level.time_survived = int((gettime() - level.starttime) / 1000);
  setomnvar("zm_time_survived", level.time_survived);
  setomnvarforallclients("post_game_state", 1);
  setdvar("g_deadChat", 1);
  setdvar("ui_allow_teamchange", 0);
  setdvar("bg_compassShowEnemies", 0);
  setdvar("scr_gameended", 1);
  setgameendtime(0);
  setomnvar("zm_ui_timer", 0);
  scripts\cp\cp_challenge::deactivate_current_challenge();

  foreach(var_04 in level.players)
  func_40A5(var_04);

  level.func_2AAD = 1;

  foreach(var_09 in level.agentarray) {
    if(isdefined(var_9.isactive) && var_9.isactive) {
      var_9.ignoreall = 1;
      var_09 scripts\cp\utility::enable_alien_scripted();
    }
  }

  setomnvarforallclients("post_game_state", 0);
  var_11 = func_FF5E(var_01);

  if(isdefined(var_11)) {
    if(isdefined(level.func_ADDF))
      [[level.func_ADDF]](var_01);

    func_ADDE(var_11);
    return;
  } else {}

  scripts\cp\cp_gamescore::calculate_players_total_end_game_score(1);

  if(isdefined(level.func_D7BB))
    [[level.func_D7BB]]();

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_04 in level.players)
    var_04 setclientdvar("ui_opensummary", 1);
  }

  setomnvarforallclients("post_game_state", 2);
  func_56DA(var_00, var_01);
  setomnvarforallclients("post_game_state", 1);
  var_14 = scripts\cp\cp_globallogic::spawnintermission;

  if(isdefined(level.func_4C58))
    var_14 = level.func_4C58;

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_04 in level.players)
    var_04 thread[[var_14]](var_01);
  }

  var_17 = func_7978(var_01);
  var_18 = func_7B85();
  scripts\cp\cp_analytics::endgame(var_17, var_18);
  setomnvarforallclients("post_game_state", 4);
  wait 11.0;
  setomnvarforallclients("post_game_state", 1);
  level notify("exitLevel_called");
  exitlevel(0);
}

kill_all_zombies() {
  wait 1;
  var_00 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_02 in var_00) {
    var_2.ignoreall = 1;
    var_2.scripted_mode = 1;
    var_02 ghostskulls_complete_status(getclosestpointonnavmesh(var_2.origin));

    if(!isdefined(var_2.agent_type)) {
      continue;
    }
    if(var_2.agent_type == "zombie_grey") {
      continue;
    }
    if(scripts\engine\utility::is_true(var_2.entered_playspace)) {
      continue;
    }
    switch (var_2.agent_type) {
      case "zombie_clown":
      case "zombie_cop":
      case "zombie_ghost":
      case "zombie_brute":
        break;
      case "generic_zombie":
        playfx(level._effect["head_loss"], var_02 gettagorigin("j_head"));
        var_02 setscriptablepartstate("head", "detached", 1);
        var_02 setscriptablepartstate("eyes", "eye_glow_off", 1);
        break;
    }

    var_02 getrandomarmkillstreak(var_2.health + 100, var_2.origin);
    wait 0.25;
  }
}

func_72BF() {
  level thread endgame("axis", func_7979("host_end"));
}

func_B37C() {
  game["state"] = "postgame";
  level.gameended = 1;
}

gamealreadyended() {
  return game["state"] == "postgame" || level.gameended;
}

func_7384(var_00, var_01, var_02) {
  if(!isdefined(var_00))
    var_00 = 0;

  foreach(var_04 in level.players) {
    var_04 thread freezeplayerforroundend(var_00);
    var_04 thread func_E760(4.0);
    var_04 freegameplayhudelems();
    var_04 setclientdvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);

    if(isdefined(var_01) && isdefined(var_02))
      var_04 setclientdvars(var_01, var_02);
  }

  foreach(var_07 in level.agentarray)
  var_07 scripts\cp\utility::freezecontrolswrapper(1);
}

freezeplayerforroundend(var_00) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();

  if(!isdefined(var_00))
    var_00 = 0.05;

  wait(var_00);
  scripts\cp\utility::freezecontrolswrapper(1);
}

func_E760(var_00) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

func_7B85() {
  var_00 = 0;

  if(isdefined(level.starttime))
    var_00 = gettime() - level.starttime;

  return var_00;
}

freegameplayhudelems() {
  if(isdefined(self.perkicon)) {
    if(isdefined(self.perkicon[0])) {
      self.perkicon[0] scripts\cp\utility::destroyelem();
      self.perkname[0] scripts\cp\utility::destroyelem();
    }

    if(isdefined(self.perkicon[1])) {
      self.perkicon[1] scripts\cp\utility::destroyelem();
      self.perkname[1] scripts\cp\utility::destroyelem();
    }

    if(isdefined(self.perkicon[2])) {
      self.perkicon[2] scripts\cp\utility::destroyelem();
      self.perkname[2] scripts\cp\utility::destroyelem();
    }
  }

  self notify("perks_hidden");
  self.lowermessage scripts\cp\utility::destroyelem();
  self.lowertimer scripts\cp\utility::destroyelem();

  if(isdefined(self.proxbar))
    self.proxbar scripts\cp\utility::destroyelem();

  if(isdefined(self.proxbartext))
    self.proxbartext scripts\cp\utility::destroyelem();
}

func_40A5(var_00) {
  var_00 notify("select_mode");
  var_00 notify("reset_outcome");
  var_0.pers["stats"] = var_0.func_10E53;
  var_00 scripts\cp\utility::allow_player_ignore_me(1);
  var_00 setclientomnvar("ui_intel_progress_current", -1);
  var_00 setclientomnvar("ui_intel_progress_max", -1);
  var_00 setclientomnvar("ui_intel_percent", -1);
  var_00 setclientomnvar("ui_intel_target_player", -1);
  var_00 setclientomnvar("ui_intel_prechallenge", 0);
  var_00 setclientomnvar("ui_intel_timer", -1);
  var_00 setclientomnvar("ui_intel_challenge_scalar", -1);
  var_00 setclientomnvar("zombie_number_of_ticket", 0);
  var_00 setrankedplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
  var_00 scripts\cp\utility::clearlowermessages();

  if(isdefined(var_0.pap))
    var_0.pap = [];

  if(isdefined(var_0.powerupicons))
    var_0.powerupicons = [];

  if(isdefined(var_0.func_456D))
    var_0.func_456D = [];

  if(isdefined(var_0.powers))
    var_0.powers = [];

  var_00 func_4172();
}

func_FF5E(var_00) {
  if((var_00 == 1 || var_00 == 2) && getdvar("ui_mapname") == "cp_jackal_ass")
    return "cp_titan";

  return undefined;
}

func_ADDE(var_00) {
  func_A5D7();
  level scripts\engine\utility::waittill_any_timeout(15, "intermission_over");
  setdvar("ui_mapname", var_00);
  setdvar("g_gametype", "aliens");
  var_01 = "map " + var_00;
}

func_E2AE() {
  func_A5D7();
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);

  for (var_00 = 3; var_00 > 0; var_0--) {
    iprintlnbold("RESTARTING IN..." + var_00);
    wait 1;
  }

  map_restart(1);
}

func_A5D7() {
  foreach(var_01 in level.characters)
  var_01 getrandomarmkillstreak(100000, var_1.origin);

  var_03 = scripts\cp\cp_agent_utils::getactiveagentsofspecies("alien");

  foreach(var_05 in var_03)
  var_05 suicide();
}

func_D40D(var_00) {
  if(var_00 == 4) {
    level.func_E40B = 0;
    level.func_E40C = 0;

    foreach(var_02 in level.players)
    var_02 thread func_56C4();

    var_04 = level.players.size - level.func_E40B;

    while (level.func_E40B < level.players.size) {
      var_05 = var_04;
      var_04 = level.players.size - level.func_E40B;

      if(var_04 != var_05)
        iprintlnbold("Waiting for " + var_04 + " player's to vote");

      wait 0.5;
    }

    if(level.func_E40C == level.players.size)
      return 1;
  }

  return 0;
}

func_56C4() {
  wait 3.0;
  scripts\cp\cp_laststand::clear_last_stand_timer(self);
  self setclientomnvar("retry_popup", 1);
  self waittill("luinotifyserver", var_00);
  level.func_E40B = level.func_E40B + 1;

  if(var_00 == "retry_level")
    level.func_E40C = level.func_E40C + 1;
}

func_4172() {
  if(isdefined(self.powers)) {
    foreach(var_01 in getarraykeys(self.powers)) {
      var_02 = self.powers[var_01].charges * -1;
      scripts\cp\powers\coop_powers::power_adjustcharges(var_02);
    }
  }

  scripts\cp\powers\coop_powers::func_13F00("secondary");
  scripts\cp\powers\coop_powers::func_13F00("primary");
}

func_7978(var_00) {
  switch (var_00) {
    case 1:
      return "all_escape";
    case 2:
      return "some_escape";
    case 3:
      return "fail_escape";
    case 8:
    case 5:
    case 4:
      return "died";
    case 6:
      return "host_quit";
    case 7:
      return "gas_fail";
    default:
  }
}

func_56C5() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("luinotifyserver", var_00);

    if(var_00 == "close_menu") {
      level.func_AE3F = level.func_AE3F + 1;
      continue;
    } else {
      switch (var_00) {
        case "dpad_team_ammo_ap":
        case "dpad_team_ammo_in":
        case "dpad_team_ammo_stun":
        case "dpad_team_ammo_reg":
          break;
        case "dpad_team_boost":
        case "dpad_team_armor":
        case "dpad_team_adrenaline":
        case "dpad_team_explosives":
          break;
        case "dpad_maaws":
        case "dpad_riotshield":
        case "dpad_death_machine":
        case "dpad_war_machine":
          break;
        case "perk_bullet_damage":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_health":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_rigger":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_medic":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_robotics":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_demolition":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_gunslinger":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_hybrid":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;
        case "perk_pistol_zemc":
        case "perk_pistol_zg18":
        case "perk_pistol_magnum":
        case "perk_pistol_znrg":
          break;
        case "perk_skill_pet":
        case "perk_skill_electric_arc":
        case "perk_skill_mortar":
        case "perk_skill_drone":
        case "perk_skill_heal_ring":
        case "perk_skill_stasis":
        case "perk_skill_invulnerable":
        case "perk_skill_infinite_ammo":
          break;
        case "iw6_kriss_mp":
        case "iw6_cprgm_mp":
        case "iw6_cppanzerfaust3_mp":
        case "iw6_l115a3_mp+acogsniper":
        case "iw6_vks_mp+vksscope":
        case "iw6_svu_mp":
        case "iw6_g28_mp":
        case "iw6_imbel_mp":
        case "iw6_microtar_mp":
        case "iw6_pdw_mp":
        case "iw6_vepr_mp":
        case "iw6_pp19_mp":
        case "iw6_maul_mp":
        case "iw6_cbjms_mp":
        case "iw6_mts255_mp":
        case "iw6_fp6_mp":
        case "iw6_honeybadger_mp":
        case "iw6_aliendlc11li_mp":
        case "iw6_m27_mp":
        case "iw6_lsat_mp":
        case "iw6_dlcweap02_mp+dlcweap02scope":
        case "iw6_plasmaauto_mp":
        case "iw7_erad_mp":
        case "iw7_crb_mp":
        case "iw7_devastator_mp":
        case "iw7_chargeshot_mp":
        case "iw7_spas_mp":
        case "iw7_forge_mp":
        case "iw7_nrg_mp":
        case "iw7_ake_mp":
        case "iw7_m1_mp":
        case "iw7_ar57_mp":
        case "iw7_m8_mp+m8scope":
        case "iw7_cheytac_mp+cheytacscope":
        case "iw7_kbs_mp+kbsscope":
        case "iw6_arx160_mp":
        case "iw6_kac_mp":
        case "iw7_glprox_mp":
        case "iw6_panzerfaust3_mp":
        case "iw6_mp443_mp":
        case "iw6_m9a1_mp":
        case "iw6_magnum_mp":
        case "iw6_p226_mp":
          break;
      }
    }
  }
}

func_56DA(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(isdefined(var_3.connectedpostgame) || var_3.pers["team"] == "spectator") {
      continue;
    }
    var_03 thread func_C752(var_00, var_01);
    var_03 thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("game_win", var_00);
}

func_C752(var_00, var_01) {
  self endon("disconnect");
  self notify("reset_outcome");
  wait 0.5;
  var_02 = self.pers["team"];

  if(!isdefined(var_02) || var_02 != "allies" && var_02 != "axis")
    var_02 = "allies";

  while (scripts\cp\cp_hud_message::isdoingsplash())
    wait 0.05;

  self endon("reset_outcome");

  if(isdefined(self.pers["team"]) && var_00 == var_02)
    var_03 = func_7979("win");
  else
    var_03 = func_7979("fail");

  self setclientomnvar("ui_round_end_title", var_03);

  if(isdefined(var_01))
    self setclientomnvar("ui_round_end_reason", var_01);

  self setclientomnvar("zm_ui_show_eog_score", 1);
}

func_DEB3() {
  if(isdefined(level.func_62D2))
    [[level.func_62D2]]();
  else
    func_DEAC();
}

func_DEAC() {
  level.end_game_string_index = [];
  level.end_game_string_index["win"] = 1;
  level.end_game_string_index["fail"] = 2;
  level.end_game_string_index["all_escape"] = 1;
  level.end_game_string_index["some_escape"] = 2;
  level.end_game_string_index["fail_escape"] = 3;
  level.end_game_string_index["kia"] = 4;
  level.end_game_string_index["host_end"] = 5;
}

func_7979(var_00) {
  return level.end_game_string_index[var_00];
}

func_E761(var_00, var_01) {
  var_02 = 0;

  while (!var_02) {
    var_03 = level.players;
    var_02 = 1;

    foreach(var_05 in var_03) {
      if(!isdefined(var_5.func_58DD)) {
        continue;
      }
      if(!var_05 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }
      var_02 = 0;
    }

    wait 0.5;
  }

  if(!var_01) {
    wait(var_00);
    level notify("round_end_finished");
    return;
  }

  wait(var_00 / 2);
  level notify("give_match_bonus");
  wait(var_00 / 2);
  var_02 = 0;

  while (!var_02) {
    var_03 = level.players;
    var_02 = 1;

    foreach(var_05 in var_03) {
      if(!isdefined(var_5.func_58DD)) {
        continue;
      }
      if(!var_05 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }
      var_02 = 0;
    }

    wait 0.5;
  }

  level notify("round_end_finished");
}