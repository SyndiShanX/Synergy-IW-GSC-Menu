/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gamelogic.gsc
************************************/

func_C530(param_00) {
  if(isdefined(level.var_72F2)) {
    return;
  }

  level endon("abort_forfeit");
  level thread func_72F3();
  level.var_72F2 = 1;
  if(!level.teambased && level.players.size > 1) {
    wait(10);
  } else {
    wait(1.05);
  }

  level.var_72F1 = 0;
  var_01 = 20;
  matchforfeittimer(var_01);
  var_02 = & "";
  if(!isdefined(param_00)) {
    var_02 = game["end_reason"]["players_forfeited"];
    var_03 = level.players[0];
  } else if(var_01 == "axis") {
    var_03 = game["end_reason"]["allies_forfeited"];
    var_03 = "axis";
  } else if(var_01 == "allies") {
    var_03 = game["end_reason"]["axis_forfeited"];
    var_03 = "allies";
  } else if(level.multiteambased && issubstr(var_01, "team_")) {
    var_03 = var_01;
  } else {
    var_03 = "tie";
  }

  level.var_72B3 = 1;
  if(isplayer(var_03)) {
    logstring("forfeit, win: " + var_03 getxuid() + "(" + var_03.name + ")");
  } else {
    logstring("forfeit, win: " + var_03 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  }

  thread endgame(var_03, var_02);
}

func_72F3() {
  level endon("game_ended");
  level waittill("abort_forfeit");
  level.var_72F1 = 1;
  setomnvar("ui_match_start_countdown", 0);
}

matchforfeittimer_internal(param_00) {
  waittillframeend;
  level endon("match_forfeit_timer_beginning");
  while (param_00 > 0 && !level.gameended && !level.var_72F1 && !level.ingraceperiod) {
    setomnvar("ui_match_start_countdown", param_00);
    param_00--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  }

  setomnvar("ui_match_start_countdown", 0);
}

matchforfeittimer(param_00) {
  level notify("match_forfeit_timer_beginning");
  var_01 = int(param_00);
  setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  matchforfeittimer_internal(var_01);
}

func_5007(param_00) {
  if(param_00 == "allies") {
    iprintln( & "MP_FACTION_UNSA_ELIMINATED");
    logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    thread endgame("axis", game["end_reason"]["allies_eliminated"]);
    return;
  }

  if(param_00 == "axis") {
    iprintln( & "MP_FACTION_SDF_ELIMINATED");
    logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
    thread endgame("allies", game["end_reason"]["axis_eliminated"]);
    return;
  }

  logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  if(level.teambased) {
    thread endgame("tie", game["end_reason"]["tie"]);
    return;
  }

  thread endgame(undefined, game["end_reason"]["tie"]);
}

default_ononeleftevent(param_00) {
  if(level.teambased) {
    var_01 = scripts\mp\utility::getlastlivingplayer(param_00);
    if(isdefined(var_01)) {
      var_01 thread givelastonteamwarning();
    }
  } else {
    var_01 = scripts\mp\utility::getlastlivingplayer();
    logstring("last one alive, win: " + var_01.name);
    thread endgame(var_01, game["end_reason"]["enemies_eliminated"]);
  }

  return 1;
}

func_E75E(param_00, param_01) {
  func_3E53(param_00);
  if(scripts\mp\utility::istrue(param_01)) {
    level notify("roundEnd_CheckScoreLimit");
    level endon("roundEnd_CheckScoreLimit");
    scripts\engine\utility::waitframe();
  }

  var_02 = scripts\mp\utility::getwingamebytype();
  if(scripts\mp\utility::inovertime()) {
    if(scripts\mp\utility::istimetobeatrulegametype()) {
      if(scripts\mp\utility::settimetobeat(param_00)) {
        foreach(var_04 in level.players) {
          var_04 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_04.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_04 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_04.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        thread endgame(param_00, game["end_reason"]["score_limit_reached"]);
        return;
      }

      return;
    }

    thread endgame(var_03, game["end_reason"]["score_limit_reached"]);
    return;
  }

  var_06 = game["teamScores"]["allies"];
  var_07 = game["teamScores"]["axis"];
  var_08 = var_06 >= level.roundscorelimit;
  var_09 = var_07 >= level.roundscorelimit;
  if(level.roundscorelimit > 0) {
    if(var_08 && var_09) {
      if(var_06 == var_07) {
        thread endgame("tie", game["end_reason"]["score_limit_reached"]);
        return;
      }

      if(var_06 > var_07) {
        thread endgame("allies", game["end_reason"]["score_limit_reached"]);
        return;
      }

      thread endgame("axis", game["end_reason"]["score_limit_reached"]);
      return;
    }

    if(var_08) {
      thread endgame("allies", game["end_reason"]["score_limit_reached"]);
      return;
    }

    if(var_09) {
      thread endgame("axis", game["end_reason"]["score_limit_reached"]);
      return;
    }

    return;
  }
}

default_ontimelimit() {
  var_00 = "tie";
  if(level.teambased) {
    if(scripts\mp\utility::inovertime()) {
      if(scripts\mp\utility::istimetobeatvalid()) {
        var_00 = game["timeToBeatTeam"];
      }
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_00 = "axis";
    } else if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
      var_00 = "allies";
    }

    logstring("time limit, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_00 = scripts\mp\gamescore::gethighestscoringplayer();
    if(scripts\mp\gamescore::ishighestscoringplayertied()) {
      var_00 = "tie";
    }

    if(isdefined(var_00) && isplayer(var_00)) {
      logstring("time limit, win: " + var_00.name);
    } else {
      logstring("time limit, tie");
    }
  }

  thread endgame(var_00, game["end_reason"]["time_limit_reached"]);
}

default_onhalftime() {
  var_00 = undefined;
  thread endgame("halftime", game["end_reason"]["time_limit_reached"]);
}

forceend(param_00) {
  if(level.hostforcedend || level.var_72B3) {
    return;
  }

  scripts\mp\gamescore::updateplacement();
  if(level.teambased) {
    scripts\mp\gamescore::func_12F4A("axis");
    scripts\mp\gamescore::func_12F4A("allies");
  }

  var_01 = undefined;
  if(level.teambased) {
    if(game["teamScores"]["allies"] == game["teamScores"]["axis"]) {
      var_01 = "tie";
    } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
      var_01 = "axis";
    } else {
      var_01 = "allies";
    }

    logstring("host ended game, win: " + var_01 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_01 = scripts\mp\gamescore::gethighestscoringplayer();
    if(isdefined(var_01)) {
      logstring("host ended game, win: " + var_01.name);
    } else {
      logstring("host ended game, tie");
    }
  }

  level.var_72B3 = 1;
  level.hostforcedend = 1;
  if(level.splitscreen) {
    var_02 = game["end_reason"]["ended_game"];
  } else {
    var_02 = game["end_reason"]["host_ended_game"];
  }

  if(isdefined(param_00) && param_00 == 2) {
    var_02 = game["end_reason"]["allies_forfeited"];
  }

  level notify("force_end");
  thread endgame(var_01, var_02);
}

func_C587(param_00) {
  var_01 = game["end_reason"]["score_limit_reached"];
  var_02 = "tie";
  if(level.multiteambased) {
    var_02 = scripts\mp\gamescore::playlocalsound();
    if(var_02 == "none") {
      var_02 = "tie";
    }
  } else if(level.teambased) {
    if(game["teamScores"]["axis"] != game["teamScores"]["allies"]) {
      if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
        var_02 = "axis";
      } else {
        var_02 = "allies";
      }
    }

    logstring("scorelimit, win: " + var_02 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
  } else {
    var_02 = scripts\mp\gamescore::gethighestscoringplayer();
    if(scripts\mp\utility::istrue(param_00) && scripts\mp\gamescore::ishighestscoringplayertied()) {
      var_02 = "tie";
    }

    if(isdefined(var_02) && isplayer(var_02)) {
      logstring("scorelimit, win: " + var_02.name);
    } else {
      logstring("scorelimit, tie");
    }
  }

  thread endgame(var_02, var_01);
  return 1;
}

updategameevents() {
  if(scripts\mp\utility::matchmakinggame() && !level.ingraceperiod && !isdefined(level.disableforfeit) || !level.disableforfeit) {
    if(level.multiteambased) {
      var_00 = 0;
      var_01 = 0;
      for (var_02 = 0; var_02 < level.teamnamelist.size; var_02++) {
        var_00 = var_00 + level.teamcount[level.teamnamelist[var_02]];
        if(level.teamcount[level.teamnamelist[var_02]]) {
          var_01 = var_01 + 1;
        }
      }

      for (var_02 = 0; var_02 < level.teamnamelist.size; var_02++) {
        if(var_00 == level.teamcount[level.teamnamelist[var_02]] && game["state"] == "playing") {
          thread func_C530(level.teamnamelist[var_02]);
          return;
        }
      }

      if(var_01 > 1) {
        level.var_72F2 = undefined;
        level notify("abort_forfeit");
      }
    } else if(level.teambased) {
      if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing") {
        thread func_C530("axis");
        return;
      }

      if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing") {
        thread func_C530("allies");
        return;
      }

      if(level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0) {
        level.var_72F2 = undefined;
        level notify("abort_forfeit");
      }
    } else {
      if(level.teamcount["allies"] + level.teamcount["axis"] == 1 && level.maxplayercount > 1) {
        thread func_C530();
        return;
      }

      if(level.teamcount["axis"] + level.teamcount["allies"] > 1) {
        level.var_72F2 = undefined;
        level notify("abort_forfeit");
      }
    }
  }

  if(!scripts\mp\utility::getgametypenumlives() && !isdefined(level.disablespawning) || !level.disablespawning) {
    return;
  }

  if(!scripts\mp\utility::gamehasstarted()) {
    return;
  }

  if(level.ingraceperiod) {
    return;
  }

  if(level.multiteambased) {
    return;
  }

  if(level.teambased) {
    var_03["allies"] = 0;
    var_03["axis"] = 0;
    foreach(var_05 in level.players) {
      if(var_05.team == "spectator" || !isdefined(var_05.hasspawned) || isdefined(var_05.hasspawned) && !var_05.hasspawned) {
        continue;
      }

      var_03[var_05.team] = var_03[var_05.team] + var_05.pers["lives"];
    }

    if(scripts\mp\utility::istrue(level.disablespawning)) {
      var_03["allies"] = 0;
      var_03["axis"] = 0;
    }

    if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_03["allies"] && !var_03["axis"]) {
      return [
        [level.ondeadevent]
      ]("all");
    }

    if(!level.alivecount["allies"] && !var_03["allies"]) {
      return [
        [level.ondeadevent]
      ]("allies");
    }

    if(!level.alivecount["axis"] && !var_03["axis"]) {
      return [
        [level.ondeadevent]
      ]("axis");
    }

    var_07 = level.alivecount["allies"] == 1;
    var_08 = level.alivecount["axis"] == 1;
    if(var_07 || var_08) {
      var_09 = 0;
      var_0A = undefined;
      if(var_07) {
        foreach(var_05 in level.players) {
          if(var_05.team == "allies") {
            if(!isalive(var_05)) {
              var_09 = var_09 + var_05.pers["lives"];
            }
          }
        }

        if(var_09 == 0) {
          if(!isdefined(level.var_C50B["allies"]) || gettime() > level.var_C50B["allies"] + 5000) {
            level.var_C50B["allies"] = gettime();
            var_0D = [
              [level.ononeleftevent]
            ]("allies");
            if(isdefined(var_0D)) {
              if(!isdefined(var_0A)) {
                var_0A = var_0D;
              }

              var_0A = var_0A || var_0D;
            }
          }
        }
      }

      if(var_08) {
        foreach(var_05 in level.players) {
          if(var_05.team == "axis") {
            if(!isalive(var_05)) {
              var_09 = var_09 + var_05.pers["lives"];
            }
          }
        }

        if(var_09 == 0) {
          if(!isdefined(level.var_C50B["axis"]) || gettime() > level.var_C50B["axis"] + 5000) {
            level.var_C50B["axis"] = gettime();
            var_10 = [
              [level.ononeleftevent]
            ]("axis");
            if(isdefined(var_10)) {
              if(!isdefined(var_0A)) {
                var_0A = var_10;
              }

              var_0A = var_0A || var_10;
            }
          }
        }
      }

      return var_0A;
    }

    return;
  }

  var_03 = 0;
  foreach(var_06 in level.players) {
    if(var_06.team == "spectator") {
      continue;
    }

    var_04 = var_04 + var_06.pers["lives"];
  }

  if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_04) {
    return [
      [level.ondeadevent]
    ]("all");
  }

  var_13 = scripts\mp\utility::getpotentiallivingplayers();
  if(var_13.size == 1) {
    return [
      [level.ononeleftevent]
    ]("all");
  }
}

waittillend_of_anim_set_walk() {
  if(!isdefined(level.finalkillcam_winner)) {
    return 0;
  }

  level waittill("final_killcam_done");
  return 1;
}

timelimitclock_intermission(param_00) {
  setgameendtime(gettime() + int(param_00 * 1000));
  var_01 = spawn("script_origin", (0, 0, 0));
  var_01 hide();
  if(param_00 >= 10) {
    wait(param_00 - 10);
  }

  for (;;) {
    var_01 playsound("ui_mp_timer_countdown");
    wait(1);
  }
}

waitforplayers(param_00) {
  var_01 = gettime();
  var_02 = var_01 + param_00 * 1000 - 200;
  if(param_00 > 5) {
    var_03 = gettime() + getdvarint("min_wait_for_players") * 1000;
  } else {
    var_03 = 0;
  }

  var_04 = level.var_4533 / 3;
  for (;;) {
    if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"]) {
      break;
    }

    var_05 = level.maxplayercount;
    var_06 = gettime();
    if((var_05 >= var_04 && var_06 > var_03) || var_06 > var_02) {
      break;
    }

    wait(0.05);
  }
}

prematchperiod() {
  level endon("game_ended");
  level.var_4533 = getdvarint("party_partyPlayerCountNum");
  if(level.prematchperiod > 0) {
    func_B415();
  } else {
    func_B414();
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();
  foreach(var_01 in level.players) {
    scripts\mp\playerlogic::clearprematchlook(var_01);
    var_01 scripts\mp\utility::freezecontrolswrapper(0, 1);
    if(!isdefined(var_01.pers["team"])) {
      continue;
    }

    var_02 = var_01.pers["team"];
    var_03 = scripts\mp\utility::getobjectivehinttext(var_02);
    if(!isdefined(var_03) || !var_01.hasspawned) {
      continue;
    }

    var_04 = 0;
    if(game["defenders"] == var_02) {
      var_04 = 1;
    }

    var_01 setclientomnvar("ui_objective_text", var_04);
  }

  if(game["state"] != "playing") {}
}

_meth_8487() {
  level endon("game_ended");
  if(!isdefined(game["clientActive"])) {
    while (getactiveclientcount() == 0) {
      wait(0.05);
    }

    game["clientActive"] = 1;
  }

  while (level.ingraceperiod > 0) {
    wait(1);
    level.ingraceperiod--;
  }

  level notify("grace_period_ending");
  wait(0.05);
  scripts\mp\utility::gameflagset("graceperiod_done");
  level.ingraceperiod = 0;
  if(game["state"] != "playing") {
    return;
  }

  if(scripts\mp\utility::getgametypenumlives()) {
    var_00 = level.players;
    for (var_01 = 0; var_01 < var_00.size; var_01++) {
      var_02 = var_00[var_01];
      if(!var_02.hasspawned && var_02.sessionteam != "spectator" && !isalive(var_02)) {
        var_02.getgrenadefusetime = "hud_status_dead";
      }
    }
  }

  level thread updategameevents();
}

sethasdonecombat(param_00, param_01) {
  param_00.hasdonecombat = param_01;
  var_02 = !scripts\mp\utility::istrue(param_00.pers["hasDoneAnyCombat"]);
  if(var_02 && param_01) {
    param_00.pers["hasDoneAnyCombat"] = 1;
    if(isdefined(param_00.pers["hasMatchLoss"]) && param_00.pers["hasMatchLoss"]) {
      return;
    }

    func_12EC3(param_00);
  }
}

func_12F66(param_00) {
  if(!param_00 scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(!scripts\mp\utility::istrue(param_00.pers["hasDoneAnyCombat"])) {
    return;
  }

  if(scripts\mp\utility::istrue(param_00.pers["recordedLoss"])) {
    param_00 scripts\mp\persistence::statadd("losses", -1);
  }

  param_00 scripts\mp\persistence::statadd("wins", 1);
  param_00 scripts\mp\utility::updatepersratio("winLossRatio", "wins", "losses");
  param_00 scripts\mp\persistence::statadd("currentWinStreak", 1);
  var_01 = param_00 scripts\mp\persistence::statget("currentWinStreak");
  if(var_01 > param_00 scripts\mp\persistence::statget("winStreak")) {
    param_00 scripts\mp\persistence::func_10E54("winStreak", var_01);
  }

  param_00 scripts\mp\persistence::statsetchild("round", "win", 1);
  param_00 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

func_12EC3(param_00) {
  if(!param_00 scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(!scripts\mp\utility::istrue(param_00.pers["hasDoneAnyCombat"])) {
    return;
  }

  param_00.pers["hasMatchLoss"] = 1;
  if(!scripts\mp\utility::istrue(self.joinedinprogress)) {
    param_00 scripts\mp\persistence::statadd("losses", 1);
    param_00 scripts\mp\utility::updatepersratio("winLossRatio", "wins", "losses");
    param_00.pers["recordedLoss"] = 1;
  }

  param_00 scripts\mp\persistence::statadd("gamesPlayed", 1);
  param_00 scripts\mp\persistence::statsetchild("round", "loss", 1);
}

func_12F42(param_00) {
  if(!param_00 scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(!scripts\mp\utility::istrue(param_00.pers["hasDoneAnyCombat"])) {
    return;
  }

  if(scripts\mp\utility::istrue(param_00.pers["recordedLoss"])) {
    param_00 scripts\mp\persistence::statadd("losses", -1);
    param_00 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
  }

  param_00 scripts\mp\persistence::statadd("ties", 1);
  param_00 scripts\mp\utility::updatepersratio("winLossRatio", "wins", "losses");
  param_00 scripts\mp\persistence::statsetchild("round", "loss", 0);
}

updatewinlossstats(param_00) {
  if(scripts\mp\utility::func_D957()) {
    return;
  }

  if(!scripts\mp\utility::waslastround()) {
    return;
  }

  level.processedwinloss = 1;
  var_01 = level.players;
  foreach(var_03 in level.players) {
    if(!isdefined(var_03) || !var_03 scripts\mp\utility::rankingenabled()) {
      continue;
    }

    if(isai(var_03)) {
      continue;
    }

    var_03 giveachievement("MP_ACHIEVEMENT_1");
  }

  func_12EF0();
  if(!isdefined(param_00) || isdefined(param_00) && isstring(param_00) && param_00 == "tie") {
    foreach(var_03 in level.players) {
      if(isdefined(var_03.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && var_03 ishost()) {
        var_03 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
        continue;
      }

      func_12F42(var_03);
    }

    return;
  }

  if(isplayer(param_00)) {
    if(level.hostforcedend && param_00 ishost()) {
      param_00 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
      return;
    }

    for (var_07 = 0; var_07 < min(level.placement["all"].size, 3); var_07++) {
      func_12F66(level.placement["all"][var_07]);
    }

    return;
  }

  if(isstring(param_00)) {
    foreach(var_03 in level.players) {
      if(isdefined(var_03.connectedpostgame)) {
        continue;
      }

      if(level.hostforcedend && var_03 ishost()) {
        var_03 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
        continue;
      }

      if(param_00 == "tie") {
        func_12F42(var_03);
        continue;
      }

      if(var_03.pers["team"] == param_00) {
        func_12F66(var_03);
        continue;
      }

      if(scripts\mp\utility::istrue(var_03.pers["recordedLoss"])) {
        var_03 scripts\mp\persistence::func_10E54("currentWinStreak", 0);
      }
    }

    return;
  }
}

func_12EF0() {
  if(level.gametype != "infect") {
    return;
  }

  foreach(var_01 in level.players) {
    if(var_01.sessionstate == "spectator" && !var_01.clearstartpointtransients) {
      continue;
    } else if(scripts\mp\utility::istrue(var_01.pers["hasDoneAnyCombat"])) {
      continue;
    } else if(var_01.team == "axis") {
      continue;
    } else {
      var_01 sethasdonecombat(var_01, 1);
    }
  }
}

freezeplayerforroundend(param_00) {
  self endon("disconnect");
  scripts\mp\utility::clearlowermessages();
  if(!isdefined(param_00)) {
    param_00 = 0.05;
  }

  wait(param_00);
  scripts\mp\utility::freezecontrolswrapper(1);
}

updatematchbonusscores(param_00) {
  if(!game["timePassed"]) {
    return;
  }

  if(!scripts\mp\utility::matchmakinggame()) {
    return;
  }

  if(!scripts\mp\utility::gettimelimit() || level.var_72B3) {
    var_01 = scripts\mp\utility::gettimepassed() / 1000;
    var_01 = min(var_01, 1200);
  } else {
    var_01 = scripts\mp\utility::gettimelimit() * 60;
  }

  if(level.teambased) {
    if(param_00 == "allies") {
      var_02 = "allies";
      var_03 = "axis";
    } else if(var_02 == "axis") {
      var_02 = "axis";
      var_03 = "allies";
    } else {
      var_02 = "tie";
      var_03 = "tie";
    }

    if(var_02 != "tie") {
      setwinningteam(var_02);
    }

    foreach(var_05 in level.players) {
      if(isdefined(var_05.connectedpostgame)) {
        continue;
      }

      if(!var_05 scripts\mp\utility::rankingenabled()) {
        continue;
      }

      if(var_05.timeplayed["total"] < 1 || var_05.pers["participation"] < 1) {
        continue;
      }

      if(level.hostforcedend && var_05 ishost()) {
        continue;
      }

      if(!scripts\mp\utility::istrue(var_05.pers["hasDoneAnyCombat"])) {
        continue;
      }

      if(var_02 == "tie") {
        var_06 = var_05 func_3716("tie", var_01);
        var_05 thread _meth_837D("tie", var_06);
        var_05.var_B3DD = var_06;
        continue;
      }

      if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == var_02) {
        var_06 = var_05 func_3716("win", var_01);
        var_05 thread _meth_837D("win", var_06);
        var_05.var_B3DD = var_06;
        continue;
      }

      if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == var_03) {
        var_06 = var_05 func_3716("loss", var_01);
        var_05 thread _meth_837D("loss", var_06);
        var_05.var_B3DD = var_06;
      }
    }

    return;
  }

  var_08 = "win";
  var_09 = "loss";
  if(!isdefined(param_00)) {
    var_08 = "tie";
    var_09 = "tie";
  }

  foreach(var_05 in level.players) {
    if(isdefined(var_05.connectedpostgame)) {
      continue;
    }

    if(var_05.timeplayed["total"] < 1 || var_05.pers["participation"] < 1) {
      continue;
    }

    if(!scripts\mp\utility::istrue(var_05.pers["hasDoneAnyCombat"])) {
      continue;
    }

    var_0B = 0;
    for (var_0C = 0; var_0C < min(level.placement["all"].size, 3); var_0C++) {
      if(level.placement["all"][var_0C] != var_05) {
        continue;
      }

      var_0B = 1;
    }

    if(var_0B) {
      var_06 = var_05 func_3716(var_08, var_01);
      var_05 thread _meth_837D("win", var_06);
      var_05.var_B3DD = var_06;
      continue;
    }

    var_06 = var_05 func_3716(var_09, var_01);
    var_05 thread _meth_837D("loss", var_06);
    var_05.var_B3DD = var_06;
  }
}

func_3716(param_00, param_01) {
  var_02 = scripts\mp\rank::getscoreinfovalue(param_00);
  var_03 = scripts\mp\rank::getmatchbonusspm();
  var_04 = param_01 / 60 * var_03;
  var_05 = self.timeplayed["total"] / param_01;
  var_06 = int(var_02 * var_04 * var_05);
  return var_06;
}

_meth_837D(param_00, param_01) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  scripts\mp\rank::giverankxp(param_00, param_01);
  if(scripts\mp\utility::waslastround()) {
    if(param_00 == "win") {
      thread scripts\mp\awards::givemidmatchaward("match_complete_win");
      return;
    }

    thread scripts\mp\awards::givemidmatchaward("match_complete");
  }
}

setxenonranks(param_00) {
  var_01 = level.players;
  for (var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(!isdefined(var_03.destroynavrepulsor) || !isdefined(var_03.pers["team"])) {
      continue;
    }
  }

  for (var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(!isdefined(var_03.setculldist) || !isdefined(var_03.var_E9)) {
      continue;
    }

    if(120 > var_03.timeplayed["total"]) {
      continue;
    }

    var_04 = var_03.setculldist - var_03.var_E9 / var_03.timeplayed["total"] / 60;
    setplayerteamrank(var_03, var_03.clientid, var_04);
  }
}

func_3E54(param_00) {
  if(isdefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }

  if(game["state"] != "playing") {
    setgameendtime(0);
    return;
  }

  runjiprules();
  if(scripts\mp\utility::gettimelimit() <= 0) {
    if(isdefined(level.starttime)) {
      setgameendtime(level.starttime);
    } else {
      setgameendtime(0);
    }

    return;
  }

  if(!scripts\mp\utility::gameflag("prematch_done")) {
    setgameendtime(0);
    return;
  }

  if(!isdefined(level.starttime)) {
    return;
  }

  var_01 = gettimeremaining();
  setgameendtime(gettime() + int(var_01));
  if(var_01 > 0) {
    return;
  }

  [
    [level.ontimelimit]
  ]();
}

runjiprules() {
  if(!isdefined(level.nojip)) {
    level.nojip = 0;
  }

  if(!level.nojip) {
    if(scripts\mp\utility::isroundbased() && !level.nojip) {
      switch (level.gametype) {
        case "front":
        case "dom":
          var_00 = checkdomjiprules();
          break;

        case "sd":
        case "sr":
        case "siege":
          var_00 = checksdjiprules();
          break;

        case "ctf":
          var_00 = checkctfjiprules();
          break;

        case "ball":
          var_00 = checkballjiprules();
          break;

        case "dd":
          var_00 = checkddjiprules();
          break;

        default:
          var_00 = checkdefaultjiprules();
          break;
      }

      if(var_00) {
        setnojiptime(1);
        level.nojip = 1;
        return;
      }

      return;
    }

    if(scripts\mp\utility::gettimepassedpercentage() > level.timepercentagecutoff) {
      setnojiptime(1);
      level.nojip = 1;
      return;
    }
  }
}

checkdomjiprules() {
  if(!scripts\mp\utility::func_9DF6()) {
    if(getteamscoreint("axis") > 150 || getteamscoreint("allies") > 150) {
      return 1;
    }

    if(scripts\mp\utility::gettimepassedpercentage() > 75) {
      return 1;
    }
  }

  return 0;
}

checksdjiprules() {
  var_00 = scripts\mp\utility::getroundswon("axis");
  var_01 = scripts\mp\utility::getroundswon("allies");
  var_02 = 3;
  if(scripts\mp\utility::isanymlgmatch()) {
    var_02 = 5;
  }

  if(var_00 >= var_02 || var_01 >= var_02) {
    return 1;
  }

  return 0;
}

checkctfjiprules() {
  if(!scripts\mp\utility::func_9DF6()) {
    if(scripts\mp\utility::gettimepassedpercentage() > level.timepercentagecutoff) {
      return 1;
    }
  }

  var_00 = abs(getteamscoreint("axis") - getteamscoreint("allies"));
  if(var_00 > 10) {
    return 1;
  }

  return 0;
}

checkballjiprules() {
  if(!scripts\mp\utility::func_9DF6()) {
    if(scripts\mp\utility::gettimepassedpercentage() > level.timepercentagecutoff) {
      return 1;
    }
  }

  var_00 = abs(getteamscoreint("axis") - getteamscoreint("allies"));
  if(var_00 > 15) {
    return 1;
  }

  return 0;
}

checkddjiprules() {
  var_00 = scripts\mp\utility::getroundswon("axis");
  var_01 = scripts\mp\utility::getroundswon("allies");
  if(var_00 + var_01 >= 3) {
    return 1;
  }

  return 0;
}

checkdefaultjiprules() {
  if(scripts\mp\utility::nextroundisfinalround()) {
    if(scripts\mp\utility::gettimepassedpercentage() > level.timepercentagecutoff) {
      return 1;
    }
  }

  return 0;
}

getteamscoreint(param_00) {
  return int(game["teamScores"][param_00]);
}

gettimeremaining() {
  return scripts\mp\utility::gettimelimit() * 60 * 1000 - scripts\mp\utility::gettimepassed();
}

gettimeremainingpercentage() {
  var_00 = scripts\mp\utility::gettimelimit() * 60 * 1000;
  return var_00 - scripts\mp\utility::gettimepassed() / var_00;
}

func_3E53(param_00) {
  if(level.roundscorelimit <= 0 || scripts\mp\utility::isobjectivebased()) {
    return;
  }

  if(isdefined(level.var_EC3C) && level.var_EC3C) {
    return;
  }

  if(level.gametype == "conf" || level.gametype == "jugg") {
    return;
  }

  if(!level.teambased) {
    return;
  }

  level.var_CF33 = 0;
  var_01 = 0;
  if(level.gametype == "dom" || level.gametype == "tdef") {
    var_01 = func_42AC(param_00);
  } else if(scripts\mp\utility::gettimepassed() > -5536) {
    var_01 = estimatedtimetillscorelimit(param_00) < 1;
  }

  if(!level.var_CF33 && var_01) {
    level.var_CF33 = 1;
    level notify("match_ending_soon", "score");
  }

  if(!level.var_CF33 && scripts\mp\utility::func_38F3()) {
    if(getteamscore(param_00) >= int(level.scorelimit * level.currentround - level.scorelimit / 2)) {
      scripts\mp\utility::leaderdialog("halfway_friendly_boost", param_00, "status");
      scripts\mp\utility::leaderdialog("halfway_enemy_boost", scripts\mp\utility::getotherteam(param_00), "status");
      level.didhalfscorevoboost = 1;
    }
  }
}

checkplayerscorelimitsoon() {
  if(level.roundscorelimit <= 0 || scripts\mp\utility::isobjectivebased()) {
    return;
  }

  if(level.teambased) {
    return;
  }

  if(scripts\mp\utility::gettimepassed() < -5536) {
    return;
  }

  if(level.gametype == "gun") {
    if(self.destroynavrepulsor == 14) {
      level notify("match_ending_soon", "score");
      return;
    }

    return;
  }

  var_00 = estimatedtimetillscorelimit();
  if(var_00 < 2) {
    level notify("match_ending_soon", "score");
  }
}

checkscorelimit(param_00) {
  if(scripts\mp\utility::cantiebysimultaneouskill()) {
    param_00 = 1;
  }

  if(scripts\mp\utility::istrue(param_00)) {
    level notify("checkScoreLimit");
    level endon("checkScoreLimit");
    scripts\engine\utility::waitframe();
  }

  if(scripts\mp\utility::isobjectivebased()) {
    return 0;
  }

  if(isdefined(level.var_EC3C) && level.var_EC3C) {
    return 0;
  }

  if(game["state"] != "playing") {
    return 0;
  }

  if(level.roundscorelimit <= 0) {
    return 0;
  }

  var_01 = 0;
  if(level.teambased) {
    for (var_02 = 0; var_02 < level.teamnamelist.size; var_02++) {
      if(game["teamScores"][level.teamnamelist[var_02]] >= level.roundscorelimit) {
        var_01 = 1;
        break;
      }
    }
  } else {
    foreach(var_04 in level.players) {
      if(var_04.destroynavrepulsor >= level.roundscorelimit) {
        var_01 = 1;
        break;
      }
    }
  }

  if(!var_01) {
    return 0;
  }

  return func_C587(param_00);
}

updategametypedvars() {
  level endon("game_ended");
  while (game["state"] == "playing") {
    if(isdefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        wait(0.1);
        continue;
      }
    }

    wait(1);
  }
}

func_B415() {
  thread matchstarttimer("match_starting_in", level.prematchperiod + level.var_D84E);
  waitforplayers(level.prematchperiod);
  if(level.var_D84E > 0 && !isdefined(level.hostmigrationtimer)) {
    var_00 = level.var_D84E;
    if((scripts\mp\utility::isroundbased() && !scripts\mp\utility::func_9DF6()) || scripts\mp\utility::ismlgmatch()) {
      var_00 = level.prematchperiod;
    }

    level notify("match_start_real_countdown", var_00);
    matchstarttimer("match_starting_in", var_00);
  }
}

matchstarttimer_internal(param_00) {
  waittillframeend;
  level endon("match_start_timer_beginning");
  while (param_00 > 0 && !level.gameended) {
    setomnvar("ui_match_start_countdown", param_00);
    if(param_00 == 0) {
      visionsetnaked("", 0);
    }

    param_00--;
    wait(1);
  }

  setomnvar("ui_match_start_countdown", 0);
}

matchstarttimer(param_00, param_01) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_02 = int(param_01);
  if(var_02 >= 2) {
    setomnvar("ui_match_start_text", param_00);
    matchstarttimer_internal(var_02);
  }

  visionsetnaked("", 0);
}

func_B414() {
  visionsetnaked("", 0);
}

func_C585(param_00) {
  if(!isdefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(param_00) {
    level.var_8865 = "overtime";
    if(scripts\mp\utility::islastwinbytwo()) {
      var_01 = func_7E07();
      if(var_01 != game["defenders"]) {
        game["switchedsides"] = !game["switchedsides"];
        level.var_11374 = 1;
        return;
      }

      level.var_11374 = undefined;
      return;
    }

    game["switchedsides"] = !game["switchedsides"];
    level.var_11374 = 1;
    return;
  }

  level.var_8865 = "halftime";
  game["switchedsides"] = !game["switchedsides"];
  level.var_11374 = 1;
}

func_3E43(param_00) {
  if(!level.teambased) {
    return 0;
  }

  if(!isdefined(level.var_E765) || !level.var_E765) {
    return 0;
  }

  if(game["roundsPlayed"] % level.var_E765 == 0 || param_00) {
    func_C585(param_00);
    return 1;
  }

  return 0;
}

func_11939() {
  if(level.gameended) {
    var_00 = gettime() - level.gameendtime / 1000;
    var_01 = level.var_D706 - var_00;
    if(var_01 < 0) {
      return 0;
    }

    return var_01;
  }

  if(scripts\mp\utility::gettimelimit() <= 0) {
    return undefined;
  }

  if(!isdefined(level.starttime)) {
    return undefined;
  }

  var_02 = scripts\mp\utility::gettimelimit();
  var_00 = gettime() - level.starttime / 1000;
  var_01 = level.var_561F / 1000 + scripts\mp\utility::gettimelimit() * 60 - var_02;
  if(isdefined(level.timepaused)) {
    var_02 = var_02 + level.timepaused;
  }

  return var_02 + level.var_D706;
}

freegameplayhudelems() {
  if(isdefined(self.perkicon)) {
    if(isdefined(self.perkicon[0])) {
      self.perkicon[0] scripts\mp\hud_util::destroyelem();
      self.perkname[0] scripts\mp\hud_util::destroyelem();
    }

    if(isdefined(self.perkicon[1])) {
      self.perkicon[1] scripts\mp\hud_util::destroyelem();
      self.perkname[1] scripts\mp\hud_util::destroyelem();
    }

    if(isdefined(self.perkicon[2])) {
      self.perkicon[2] scripts\mp\hud_util::destroyelem();
      self.perkname[2] scripts\mp\hud_util::destroyelem();
    }
  }

  self notify("perks_hidden");
  if(!level.doeomcombat) {
    self.lowermessage scripts\mp\hud_util::destroyelem();
    self.lowertimer scripts\mp\hud_util::destroyelem();
  }

  if(isdefined(self.proxbar)) {
    self.proxbar scripts\mp\hud_util::destroyelem();
  }

  if(isdefined(self.proxbartext)) {
    self.proxbartext scripts\mp\hud_util::destroyelem();
  }
}

gethostplayer() {
  var_00 = getentarray("player", "classname");
  for (var_01 = 0; var_01 < var_00.size; var_01++) {
    if(var_00[var_01] ishost()) {
      return var_00[var_01];
    }
  }
}

hostidledout() {
  var_00 = gethostplayer();
  if(isdefined(var_00) && !var_00.hasspawned && !isdefined(var_00.selectedclass)) {
    return 1;
  }

  return 0;
}

func_E761(param_00, param_01) {
  var_02 = 0;
  while (!var_02) {
    var_03 = level.players;
    var_02 = 1;
    foreach(var_05 in var_03) {
      if(!var_05 scripts\mp\hud_message::isdoingsplash()) {
        continue;
      }

      var_02 = 0;
    }

    wait(0.5);
  }

  if(!level.doeomcombat) {
    setomnvarforallclients("post_game_state", 2);
  }

  foreach(var_05 in level.players) {
    var_05 thread scripts\mp\utility::func_F8A0(0);
  }

  if(!param_01) {
    wait(param_00);
  } else {
    wait(param_00 / 2);
    level notify("give_match_bonus");
    wait(param_00 / 2);
    var_02 = 0;
    while (!var_02) {
      var_03 = level.players;
      var_02 = 1;
      foreach(var_05 in var_03) {
        if(!var_05 scripts\mp\hud_message::isdoingsplash()) {
          continue;
        }

        var_02 = 0;
      }

      wait(0.5);
    }
  }

  setomnvarforallclients("post_game_state", 1);
  level notify("round_end_finished");
}

func_E760(param_00) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

initwaypointbackgrounds() {
  level.waypointcolors["koth_enemy"] = "enemy";
  level.waypointbgtype["koth_enemy"] = 2;
  level.waypointcolors["koth_friendly"] = "friendly";
  level.waypointbgtype["koth_friendly"] = 2;
  level.waypointcolors["koth_neutral"] = "neutral";
  level.waypointbgtype["koth_neutral"] = 2;
  level.waypointcolors["waypoint_hardpoint_contested"] = "contest";
  level.waypointbgtype["waypoint_hardpoint_contested"] = 2;
  level.waypointcolors["waypoint_hardpoint_losing"] = "contest";
  level.waypointbgtype["waypoint_hardpoint_losing"] = 2;
  level.waypointcolors["waypoint_hardpoint_target"] = "neutral";
  level.waypointbgtype["waypoint_hardpoint_target"] = 2;
  level.waypointcolors["waypoint_taking_chevron"] = "contest";
  level.waypointbgtype["waypoint_taking_chevron"] = 2;
  level.waypointcolors["waypoint_ball_download"] = "neutral";
  level.waypointbgtype["waypoint_ball_download"] = 1;
  level.waypointcolors["waypoint_ball_pass"] = "friendly";
  level.waypointbgtype["waypoint_ball_pass"] = 1;
  level.waypointcolors["waypoint_ball_upload"] = "neutral";
  level.waypointbgtype["waypoint_ball_upload"] = 1;
  level.waypointcolors["waypoint_neutral_ball"] = "neutral";
  level.waypointbgtype["waypoint_neutral_ball"] = 1;
  level.waypointcolors["waypoint_capture_a"] = "enemy";
  level.waypointbgtype["waypoint_capture_a"] = 2;
  level.waypointcolors["waypoint_capture_b"] = "enemy";
  level.waypointbgtype["waypoint_capture_b"] = 2;
  level.waypointcolors["waypoint_capture_c"] = "enemy";
  level.waypointbgtype["waypoint_capture_c"] = 2;
  level.waypointcolors["waypoint_defend_a"] = "friendly";
  level.waypointbgtype["waypoint_defend_a"] = 2;
  level.waypointcolors["waypoint_defend_b"] = "friendly";
  level.waypointbgtype["waypoint_defend_b"] = 2;
  level.waypointcolors["waypoint_defend_c"] = "friendly";
  level.waypointbgtype["waypoint_defend_c"] = 2;
  level.waypointcolors["waypoint_losing_a"] = "contest";
  level.waypointbgtype["waypoint_losing_a"] = 2;
  level.waypointcolors["waypoint_losing_b"] = "contest";
  level.waypointbgtype["waypoint_losing_b"] = 2;
  level.waypointcolors["waypoint_losing_c"] = "contest";
  level.waypointbgtype["waypoint_losing_c"] = 2;
  level.waypointcolors["waypoint_bomb"] = "neutral";
  level.waypointbgtype["waypoint_bomb"] = 2;
  level.waypointcolors["waypoint_bomb_defusing"] = "contest";
  level.waypointbgtype["waypoint_bomb_defusing"] = 2;
  level.waypointcolors["waypoint_bomb_planting"] = "contest";
  level.waypointbgtype["waypoint_bomb_planting"] = 2;
  level.waypointcolors["waypoint_defuse_a"] = "enemy";
  level.waypointbgtype["waypoint_defuse_a"] = 2;
  level.waypointcolors["waypoint_defuse_b"] = "enemy";
  level.waypointbgtype["waypoint_defuse_b"] = 2;
  level.waypointcolors["waypoint_bank_a"] = "neutral";
  level.waypointbgtype["waypoint_bank_a"] = 2;
  level.waypointcolors["waypoint_bank_b"] = "neutral";
  level.waypointbgtype["waypoint_bank_b"] = 2;
  level.waypointcolors["waypoint_blitz_defend"] = "friendly";
  level.waypointbgtype["waypoint_blitz_defend"] = 2;
  level.waypointcolors["waypoint_blitz_defend_round"] = "friendly";
  level.waypointbgtype["waypoint_blitz_defend_round"] = 1;
  level.waypointcolors["waypoint_defend_round"] = "friendly";
  level.waypointbgtype["waypoint_defend_round"] = 1;
  level.waypointcolors["waypoint_blitz_goal"] = "enemy";
  level.waypointbgtype["waypoint_blitz_goal"] = 2;
  level.waypointcolors["waypoint_uplink_contested"] = "contest";
  level.waypointbgtype["waypoint_uplink_contested"] = 2;
  level.waypointcolors["waypoint_dogtags"] = "enemy";
  level.waypointcolors["waypoint_dogtags_friendlys"] = "friendly";
  level.waypointcolors["waypoint_taking_flag"] = "contest";
  level.waypointbgtype["waypoint_taking_flag"] = 2;
  level.waypointcolors["waypoint_capture_kill"] = "enemy";
  level.waypointbgtype["waypoint_capture_kill"] = 2;
  level.waypointcolors["waypoint_capture_kill_round"] = "enemy";
  level.waypointbgtype["waypoint_capture_kill_round"] = 1;
  level.waypointcolors["waypoint_capture_recover"] = "friendly";
  level.waypointbgtype["waypoint_capture_recover"] = 2;
  level.waypointcolors["waypoint_capture_take"] = "enemy";
  level.waypointbgtype["waypoint_capture_take"] = 2;
  level.waypointcolors["waypoint_captureneutral_a"] = "neutral";
  level.waypointbgtype["waypoint_captureneutral_a"] = 2;
  level.waypointcolors["waypoint_captureneutral_b"] = "neutral";
  level.waypointbgtype["waypoint_captureneutral_b"] = 2;
  level.waypointcolors["waypoint_captureneutral_c"] = "neutral";
  level.waypointbgtype["waypoint_captureneutral_c"] = 2;
  level.waypointcolors["waypoint_contested_a"] = "contest";
  level.waypointbgtype["waypoint_contested_a"] = 2;
  level.waypointcolors["waypoint_contested_b"] = "contest";
  level.waypointbgtype["waypoint_contested_b"] = 2;
  level.waypointcolors["waypoint_contested_c"] = "contest";
  level.waypointbgtype["waypoint_contested_c"] = 2;
  level.waypointcolors["waypoint_escort"] = "friendly";
  level.waypointbgtype["waypoint_escort"] = 1;
  level.waypointcolors["waypoint_reset_marker"] = "contest";
  level.waypointbgtype["waypoint_reset_marker"] = 2;
  level.waypointcolors["waypoint_returning_flag"] = "contest";
  level.waypointbgtype["waypoint_returning_flag"] = 2;
  level.waypointcolors["waypoint_scoring_foe_a"] = "enemy";
  level.waypointbgtype["waypoint_scoring_foe_a"] = 2;
  level.waypointcolors["waypoint_scoring_foe_b"] = "enemy";
  level.waypointbgtype["waypoint_scoring_foe_b"] = 2;
  level.waypointcolors["waypoint_scoring_friend_a"] = "friendly";
  level.waypointbgtype["waypoint_scoring_friend_a"] = 2;
  level.waypointcolors["waypoint_scoring_friend_b"] = "friendly";
  level.waypointbgtype["waypoint_scoring_friend_b"] = 2;
  level.waypointcolors["waypoint_taking_a"] = "contest";
  level.waypointbgtype["waypoint_taking_a"] = 2;
  level.waypointcolors["waypoint_taking_b"] = "contest";
  level.waypointbgtype["waypoint_taking_b"] = 2;
  level.waypointcolors["waypoint_taking_c"] = "contest";
  level.waypointbgtype["waypoint_taking_c"] = 2;
  level.waypointcolors["waypoint_target_a"] = "enemy";
  level.waypointbgtype["waypoint_target_a"] = 2;
  level.waypointcolors["waypoint_target_b"] = "enemy";
  level.waypointbgtype["waypoint_target_b"] = 2;
}

callback_startgametype() {
  scripts\mp\load::main();
  scripts\mp\utility::levelflaginit("round_over", 0);
  scripts\mp\utility::levelflaginit("game_over", 0);
  scripts\mp\utility::levelflaginit("block_notifies", 0);
  scripts\mp\utility::levelflaginit("post_game_level_event_active", 0);
  level.prematchperiod = 0;
  level.var_D84E = 0;
  level.var_D701 = 0;
  level.preloadcinematicforall = 0;
  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));
  if(scripts\mp\utility::matchmakinggame()) {
    setdvar("isMatchMakingGame", 1);
  } else {
    setdvar("isMatchMakingGame", 0);
  }

  if(level.multiteambased) {
    setdvar("ui_numteams", level.var_C246);
  }

  if(!isdefined(game["gamestarted"])) {
    game["clientid"] = 0;
    game["truncated_killcams"] = 0;
    if(!isdefined(game["attackers"]) || !isdefined(game["defenders"])) {
      thread scripts\engine\utility::error("No attackers or defenders team defined in level .gsc.");
    }

    if(!isdefined(game["attackers"])) {
      game["attackers"] = "allies";
    }

    if(!isdefined(game["defenders"])) {
      game["defenders"] = "axis";
    }

    if(!isdefined(game["state"])) {
      game["state"] = "playing";
    }

    game["allies"] = "UNSA";
    game["axis"] = "SDF";
    game["strings"]["press_to_spawn"] = & "PLATFORM_PRESS_TO_SPAWN";
    game["strings"]["spawn_next_round"] = & "MP_SPAWN_NEXT_ROUND";
    game["strings"]["spawn_flag_wait"] = & "MP_SPAWN_FLAG_WAIT";
    game["strings"]["spawn_point_capture_wait"] = & "MP_SPAWN_POINT_CAPTURE_WAIT";
    game["strings"]["spawn_tag_wait"] = & "MP_SPAWN_TAG_WAIT";
    game["strings"]["waiting_to_spawn"] = & "MP_WAITING_TO_SPAWN";
    game["strings"]["waiting_to_safespawn"] = & "MP_WAITING_TO_SAFESPAWN";
    game["strings"]["match_starting"] = & "MP_MATCH_STARTING";
    game["strings"]["change_class"] = & "MP_CHANGE_CLASS_NEXT_SPAWN";
    game["strings"]["change_rig"] = & "LUA_MENU_MP_CHANGE_RIG_NEXT_SPAWN";
    game["strings"]["last_stand"] = & "MPUI_LAST_STAND";
    game["strings"]["final_stand"] = & "MPUI_FINAL_STAND";
    game["strings"]["c4_death"] = & "MPUI_C4_DEATH";
    game["strings"]["must_select_loadout_to_spawn"] = & "MP_INGAME_ONLY_SELECT_LOADOUT_TO_SPAWN";
    game["strings"]["cowards_way"] = & "PLATFORM_COWARDS_WAY_OUT";
    game["colors"]["black"] = (0, 0, 0);
    game["colors"]["white"] = (1, 1, 1);
    game["colors"]["grey"] = (0.5, 0.5, 0.5);
    game["colors"]["cyan"] = (0.35, 0.7, 0.9);
    game["colors"]["orange"] = (0.9, 0.6, 0);
    game["colors"]["blue"] = (0.2, 0.3, 0.7);
    game["colors"]["red"] = (0.75, 0.25, 0.25);
    game["colors"]["green"] = (0.25, 0.75, 0.25);
    game["colors"]["yellow"] = (0.65, 0.65, 0);
    game["strings"]["allies_name"] = scripts\mp\teams::isonladder("allies");
    game["icons"]["allies"] = scripts\mp\teams::_meth_81B2("allies");
    game["colors"]["allies"] = scripts\mp\teams::_meth_81A4("allies");
    game["strings"]["axis_name"] = scripts\mp\teams::isonladder("axis");
    game["icons"]["axis"] = scripts\mp\teams::_meth_81B2("axis");
    game["colors"]["axis"] = scripts\mp\teams::_meth_81A4("axis");
    game["colors"]["friendly"] = (0.2588235, 0.6392157, 0.8745098);
    game["colors"]["enemy"] = (0.9294118, 0.2313726, 0.1411765);
    game["colors"]["contest"] = (1, 0.8588235, 0);
    game["colors"]["neutral"] = (1, 1, 1);
    initwaypointbackgrounds();
    if(game["colors"]["allies"] == game["colors"]["black"]) {
      game["colors"]["allies"] = game["colors"]["grey"];
    }

    if(game["colors"]["axis"] == game["colors"]["black"]) {
      game["colors"]["axis"] = game["colors"]["grey"];
    }

    [
      [level.onprecachegametype]
    ]();
    setdvarifuninitialized("min_wait_for_players", 5);
    if(level.console) {
      if(!level.splitscreen) {
        if(scripts\mp\utility::ismlgmatch() || isdedicatedserver()) {
          level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod_comp");
        } else {
          level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "graceperiod");
        }

        level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
      }
    } else {
      if(scripts\mp\utility::ismlgmatch() || isdedicatedserver()) {
        level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "playerwaittime_comp");
      } else {
        level.prematchperiod = scripts\mp\tweakables::gettweakablevalue("game", "playerwaittime");
      }

      level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
    }

    setnojipscore(0);
    setnojiptime(0);
  } else {
    setdvarifuninitialized("min_wait_for_players", 5);
    if(level.console) {
      if(!level.splitscreen) {
        level.prematchperiod = 5;
        level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
      }
    } else {
      level.prematchperiod = 5;
      level.var_D84E = scripts\mp\tweakables::gettweakablevalue("game", "matchstarttime");
    }
  }

  if(!isdefined(game["status"])) {
    game["status"] = "normal";
  }

  setdvar("ui_overtime", scripts\mp\utility::inovertime());
  if(game["status"] != "overtime" && game["status"] != "halftime") {
    if(!isdefined(game["switchedsides"]) && game["switchedsides"] == 1 && scripts\mp\utility::ismoddedroundgame()) {
      game["teamScores"]["allies"] = 0;
      game["teamScores"]["axis"] = 0;
    }

    if(level.multiteambased) {
      for (var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
        game["teamScores"][level.teamnamelist[var_00]] = 0;
      }
    }
  }

  if(!isdefined(game["timePassed"])) {
    game["timePassed"] = 0;
  }

  if(!isdefined(game["roundsPlayed"])) {
    game["roundsPlayed"] = 0;
  }

  if(!isdefined(game["overtimeRoundsPlayed"])) {
    game["overtimeRoundsPlayed"] = 0;
  }

  if(!isdefined(game["finalRound"])) {
    game["finalRound"] = 0;
  }

  setomnvar("ui_last_round", game["finalRound"]);
  if(!isdefined(game["roundsWon"])) {
    game["roundsWon"] = [];
  }

  if(!isdefined(game["timeToBeat"])) {
    game["timeToBeat"] = 0;
  }

  if(!isdefined(game["timeToBeatOld"])) {
    game["timeToBeatOld"] = 0;
  }

  if(!isdefined(game["timeToBeatTeam"])) {
    game["timeToBeatTeam"] = "none";
  }

  if(!isdefined(game["timeToBeatScore"])) {
    game["timeToBeatScore"] = 0;
  }

  if(level.teambased) {
    if(!isdefined(game["roundsWon"]["axis"])) {
      game["roundsWon"]["axis"] = 0;
    }

    if(!isdefined(game["roundsWon"]["allies"])) {
      game["roundsWon"]["allies"] = 0;
    }

    if(level.multiteambased) {
      for (var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
        if(!isdefined(game["roundsWon"][level.teamnamelist[var_00]])) {
          game["roundsWon"][level.teamnamelist[var_00]] = 0;
        }
      }
    }
  }

  level.gameended = 0;
  level.var_72B3 = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getdvarint("g_hardcore");
  level.tactical = (scripts\mp\utility::matchmakinggame() && getdvarint("scr_tactical")) || getdvarint("scr_game_tacticalmode");
  var_01 = scripts\mp\utility::isanymlgmatch() || level.tactical;
  setdvar("disable_energy_bullet_ricochet", var_01);
  if(level.tactical) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
    setdvar("jump_slowdownEnable", 1);
    setdvar("sprintLeap_enabled", 0);
    setdvar("scr_" + level.gametype + "_doubleJump", 1);
    setdvar("scr_game_doubleJump", 1);
    level.supportdoublejump_MAYBE = 1;
  }

  if(level.hardcoremode) {
    logstring("game mode: hardcore");
  }

  level.diehardmode = getdvarint("scr_diehard");
  level.var_3B1E = getdvarint("scr_game_casualScoreStreaks");
  if(!isdefined(level.crankedbombtimer)) {
    level.crankedbombtimer = getdvarint("scr_" + level.gametype + "_crankedBombTimer", 0);
  }

  level.supportcranked = scripts\engine\utility::ter_op(getdvarint("scr_" + level.gametype + "_crankedBombTimer") > 0, 1, 0);
  if(!level.teambased) {
    level.diehardmode = 0;
  }

  if(level.diehardmode) {
    logstring("game mode: diehard");
  }

  level.allowkillstreaks = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_allowKillstreaks", "scr_game_allowKillstreaks");
  level.allowperks = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_allowPerks", "scr_game_allowPerks");
  level.allowsupers = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_allowSupers", "scr_game_allowSupers");
  level.var_11260 = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_superFastChargeRate", "scr_game_superFastChargeRate");
  level.superpointsmod = scripts\mp\utility::_meth_803B("scr_" + level.gametype + "_superPointsMod", "scr_game_superPointsMod");
  if(!level.tactical) {
    level.supportdoublejump_MAYBE = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_doubleJump", "scr_game_doubleJump");
  }

  level.supportwallrun_MAYBE = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_wallRun", "scr_game_wallRun");
  level.spawnprotectiontimer = scripts\mp\utility::_meth_803B("scr_" + level.gametype + "_spawnProtectionTimer", "scr_game_spawnProtectionTimer");
  level.scoremod = [];
  level.scoremod["kill"] = getdvarint("scr_" + level.gametype + "_pointsPerKill");
  level.scoremod["death"] = getdvarint("scr_" + level.gametype + "_pointsPerDeath");
  level.scoremod["headshot"] = getdvarint("scr_" + level.gametype + "_pointsHeadshotBonus");
  level.var_B4A1 = 5;
  level.var_B4A0 = 32;
  level.usestartspawns = 1;
  level.maxallowedteamkills = scripts\mp\utility::botgetworldsize("scr_" + level.gametype + "_ffPunishLimit", "scr_game_ffPunishLimit");
  thread scripts\mp\powerloot::init();
  thread scripts\mp\healthoverlay::init();
  thread scripts\mp\killcam::init();
  thread scripts\mp\final_killcam::func_9807();
  thread scripts\mp\battlechatter_mp::init();
  thread scripts\mp\music_and_dialog::init();
  thread[[level.var_9994]]();
  thread scripts\mp\class::init();
  thread scripts\mp\persistence::init();
  thread scripts\mp\missions::init();
  thread scripts\mp\rank::init();
  thread scripts\mp\playercards::init();
  thread scripts\mp\menus::init();
  thread scripts\mp\hud::init();
  thread scripts\mp\serversettings::init();
  thread scripts\mp\teams::init();
  thread scripts\mp\weapons::init();
  thread scripts\mp\outline::init();
  thread scripts\mp\shellshock::init();
  thread scripts\mp\deathicons::init();
  thread scripts\mp\damagefeedback::init();
  thread scripts\mp\lightarmor::init();
  thread scripts\mp\killstreaks\_chill_common::chill_init();
  thread scripts\mp\objpoints::init();
  thread scripts\mp\gameobjects::init();
  thread scripts\mp\spectating::init();
  thread scripts\mp\spawnlogic::init();
  thread scripts\mp\matchdata::init();
  thread scripts\mp\clientmatchdata::init();
  thread scripts\mp\awards::init();
  thread scripts\mp\areas::init();
  thread scripts\mp\adrenaline::init();
  thread scripts\mp\killstreak_loot::init();
  thread[[level.var_A6A2]]();
  thread scripts\mp\passives::init();
  thread scripts\mp\perks\_perks::init();
  thread scripts\mp\events::init();
  thread scripts\mp\defcon::init();
  thread[[level.var_B3E7]]();
  thread scripts\mp\zipline::init();
  thread scripts\mp\archetypes\archcommon::init();
  thread scripts\mp\powers::init();
  thread scripts\mp\drone_pet::init();
  thread scripts\mp\whizby::init();
  thread scripts\mp\analyticslog::init();
  thread scripts\mp\loot::init();
  thread scripts\mp\supers::init();
  thread scripts\mp\callouts::init();
  thread func_1C74();
  thread ismp_init();
  thread scripts\mp\weapons::func_13AB2();
  thread scripts\mp\supers::func_13B6B();
  thread scripts\mp\gestures_mp::init();
  thread scripts\mp\sentientpoolmanager::init();
  thread scripts\mp\objidpoolmanager::init();
  thread scripts\mp\contracts::init();
  thread scripts\mp\utility::initarbitraryuptriggers();
  thread scripts\mp\broshot::initbroshotfx();
  if(level.teambased) {
    thread scripts\mp\friendicons::init();
  }

  thread scripts\mp\hud_message::init();
  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread scripts\mp\codcasterclientmatchdata::init();
  }

  game["gamestarted"] = 1;
  level.currentround = game["roundsPlayed"] + 1;
  level.maxplayercount = 0;
  level.wavedelay["allies"] = 0;
  level.wavedelay["axis"] = 0;
  level.lastwave["allies"] = 0;
  level.lastwave["axis"] = 0;
  level.waveplayerspawnindex["allies"] = 0;
  level.waveplayerspawnindex["axis"] = 0;
  level.var_1BE7["allies"] = [];
  level.var_1BE7["axis"] = [];
  level.var_1659 = [];
  if(level.multiteambased) {
    for (var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
      level.var_1461[level.teamnamelist[var_00]] = 0;
      level.var_1301[level.teamnamelist[var_00]] = 0;
      level.var_1462[level.teamnamelist[var_00]] = 0;
      level.var_1168[level.teamnamelist[var_00]] = [];
    }
  }

  setomnvar("ui_scorelimit", 0);
  setdvar("ui_allow_teamchange", 1);
  setomnvar("ui_round_hint_override_attackers", 0);
  setomnvar("ui_round_hint_override_defenders", 0);
  if(scripts\mp\utility::getgametypenumlives()) {
    setdvar("g_deadChat", 0);
  } else {
    setdvar("g_deadChat", 1);
  }

  var_02 = getdvarint("scr_" + level.gametype + "_waverespawndelay");
  if(var_02) {
    level.wavedelay["allies"] = var_02;
    level.wavedelay["axis"] = var_02;
    level.lastwave["allies"] = 0;
    level.lastwave["axis"] = 0;
    if(level.multiteambased) {
      for (var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
        level.var_1461[level.teamnamelist[var_00]] = var_02;
        level.var_1301[level.teamnamelist[var_00]] = 0;
      }
    }

    level thread func_13BE6();
  }

  scripts\mp\utility::gameflaginit("prematch_done", 0);
  level._meth_8487 = 15;
  level.ingraceperiod = level._meth_8487;
  scripts\mp\utility::gameflaginit("graceperiod_done", 0);
  level.playovertime = 0;
  level.var_E75F = 6;
  level.var_6C71 = 3;
  level.var_8864 = 3;
  level.noragdollents = getentarray("noragdoll", "targetname");
  level.scorelimit = scripts\mp\utility::getwatcheddvar("scorelimit");
  level.roundlimit = scripts\mp\utility::getwatcheddvar("roundlimit");
  level.winlimit = scripts\mp\utility::getwatcheddvar("winlimit");
  if(level.roundlimit != 1) {
    setomnvar("ui_current_round", level.currentround);
  }

  if(level.scorelimit == 1) {
    level.roundscorelimit = 1;
    level.totalscorelimit = level.winlimit;
  } else {
    level.roundscorelimit = level.scorelimit * game["roundsPlayed"] + 1;
    level.totalscorelimit = level.scorelimit * level.roundlimit;
  }

  if(scripts\mp\utility::func_E269()) {
    level.roundscorelimit = level.scorelimit;
    level.totalscorelimit = level.scorelimit;
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);
  }

  if(scripts\mp\utility::func_9ECF() && scripts\mp\utility::inovertime()) {
    scripts\mp\gamescore::func_12EE5();
  }

  if(level.teambased) {
    scripts\mp\gamescore::updateteamscore("axis");
    scripts\mp\gamescore::updateteamscore("allies");
    if(level.multiteambased) {
      for (var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
        scripts\mp\gamescore::updateteamscore(level.teamnamelist[var_00]);
      }
    }
  }

  thread func_12F54();
  level notify("update_scorelimit");
  if(isdefined(level.matchrecording_init)) {
    level thread[[level.matchrecording_init]]();
  }

  [
    [level.onstartgametype]
  ]();
  level.var_EC3F = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off", 80);
  level.timepercentagecutoff = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off", 80);
  if(!level.console && getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server") {
    thread func_132A3();
  }

  thread func_10D9F();
  level thread scripts\mp\utility::func_12F5B();
  level thread timelimitthread();
  level thread scripts\mp\final_killcam::func_5853();
  level thread updateleaderboardstatscontinuous();
}

func_132A3() {
  for (;;) {
    if(level.rankedmatch) {
      exitlevel(0);
    }

    if(!getdvarint("xblive_privatematch")) {
      exitlevel(0);
    }

    if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server") {
      exitlevel(0);
    }

    wait(5);
  }
}

timelimitthread() {
  level endon("game_ended");
  var_00 = scripts\mp\utility::gettimepassed();
  while (game["state"] == "playing") {
    thread func_3E54(var_00);
    var_00 = scripts\mp\utility::gettimepassed();
    if(isdefined(level.starttime)) {
      if(gettimeremaining() < 3000) {
        wait(0.1);
        continue;
      }
    }

    wait(1);
  }
}

func_12F54() {
  for (;;) {
    level scripts\engine\utility::waittill_either("update_scorelimit", "update_winlimit");
    if(scripts\mp\utility::inovertime()) {
      if(scripts\mp\utility::istimetobeatrulegametype()) {
        foreach(var_01 in level.players) {
          var_01 setclientomnvar("ui_friendly_time_to_beat", scripts\engine\utility::ter_op(var_01.team == game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
          var_01 setclientomnvar("ui_enemy_time_to_beat", scripts\engine\utility::ter_op(var_01.team != game["timeToBeatTeam"], game["timeToBeat"], game["timeToBeatOld"]));
        }

        setomnvar("ui_scorelimit", scripts\engine\utility::ter_op(scripts\mp\utility::istimetobeatvalid(), game["timeToBeatScore"], 1));
      } else if(scripts\mp\utility::iswinbytworulegametype()) {
        var_03 = game["roundsWon"][game["defenders"]];
        var_04 = game["roundsWon"][game["attackers"]];
        var_05 = 0;
        if(var_03 == var_04) {
          var_05 = var_03 + 2;
        } else if(var_03 > var_04) {
          var_05 = var_03 + 1;
        } else {
          var_05 = var_04 + 1;
        }

        setomnvar("ui_scorelimit", var_05);
      } else {
        usenormalscorelimit();
      }

      continue;
    }

    usenormalscorelimit();
  }
}

usenormalscorelimit() {
  if(!scripts\mp\utility::isroundbased() || !scripts\mp\utility::isobjectivebased() || scripts\mp\utility::ismoddedroundgame()) {
    setomnvar("ui_scorelimit", level.totalscorelimit);
    thread checkscorelimit();
    return;
  }

  setomnvar("ui_scorelimit", level.winlimit);
}

playtickingsound() {
  self endon("death");
  self endon("stop_ticking");
  level endon("game_ended");
  var_00 = level.bombtimer;
  for (;;) {
    self playsound("ui_mp_suitcasebomb_timer");
    if(var_00 > 10) {
      var_00 = var_00 - 1;
      wait(1);
    } else if(var_00 > 4) {
      var_00 = var_00 - 0.5;
      wait(0.5);
    } else if(var_00 > 1) {
      var_00 = var_00 - 0.4;
      wait(0.4);
    } else {
      var_00 = var_00 - 0.3;
      wait(0.3);
    }

    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

stoptickingsound() {
  self notify("stop_ticking");
}

func_118F7() {
  level endon("game_ended");
  wait(0.05);
  var_00 = spawn("script_origin", (0, 0, 0));
  var_00 hide();
  var_01 = scripts\engine\utility::ter_op(scripts\mp\utility::isanymlgmatch(), 5, 2);
  while (game["state"] == "playing") {
    if(!level.var_1191F && scripts\mp\utility::gettimelimit()) {
      var_02 = gettimeremaining() / 1000;
      var_03 = int(var_02 + 0.5);
      if(var_03 >= 30 && var_03 <= 60) {
        level notify("match_ending_soon", "time");
      }

      if(var_03 <= 10 || var_03 <= 30 && var_03 % var_01 == 0) {
        level notify("match_ending_very_soon");
        if(var_03 == 0) {
          break;
        }

        var_00 playsound("ui_mp_timer_countdown");
      }

      if(var_02 - floor(var_02) >= 0.05) {
        wait(var_02 - floor(var_02));
      }
    }

    wait(1);
  }
}

func_7687() {
  level endon("game_ended");
  if(isdefined(game["startTimeFromMatchStart"])) {
    level.starttimefrommatchstart = game["startTimeFromMatchStart"];
  }

  level waittill("prematch_over");
  level.starttime = gettime();
  level.var_561F = 0;
  if(!isdefined(game["startTimeFromMatchStart"])) {
    game["startTimeFromMatchStart"] = gettime();
    level.starttimefrommatchstart = gettime();
    scripts\mp\matchdata::func_C558();
  }

  if(isdefined(game["roundMillisecondsAlreadyPassed"])) {
    level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
    game["roundMillisecondsAlreadyPassed"] = undefined;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundStartTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  var_00 = gettime();
  while (game["state"] == "playing") {
    if(!level.var_1191F) {
      game["timePassed"] = game["timePassed"] + gettime() - var_00;
    }

    var_00 = gettime();
    wait(1);
  }
}

func_12F45(param_00) {
  var_01 = level.timerstoppedforgamemode || isdefined(level.hostmigrationtimer);
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    var_01 = 0;
  }

  if(!level.var_1191F && var_01) {
    level.var_1191F = 1;
    level.var_1191E = gettime();
    var_02 = gettimeremaining();
    if(isdefined(param_00)) {
      setgameendtime(param_00);
    } else {
      setgameendtime(gettime() + int(var_02));
    }

    setomnvar("ui_match_timer_stopped", 1);
    return;
  }

  if(level.var_1191F && !var_01) {
    level.var_1191F = 0;
    level.var_561F = level.var_561F + gettime() - level.var_1191E;
    var_02 = gettimeremaining();
    if(isdefined(param_00)) {
      setgameendtime(param_00);
    } else {
      setgameendtime(gettime() + int(var_02));
    }

    setomnvar("ui_match_timer_stopped", 0);
  }
}

pausetimer(param_00) {
  level.timerstoppedforgamemode = 1;
  func_12F45(param_00);
}

resumetimer(param_00) {
  level.timerstoppedforgamemode = 0;
  func_12F45(param_00);
}

func_10D9F() {
  setslowmotion(1, 1, 0);
  thread func_7687();
  level.var_1191F = 0;
  level.timerstoppedforgamemode = 0;
  setomnvar("ui_prematch_period", 1);
  prematchperiod();
  sysprint("MatchStarted: Completed");
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();
  scripts\mp\utility::gameflagset("prematch_done");
  level notify("prematch_over");
  setomnvar("ui_prematch_period", 0);
  func_12F45();
  if(scripts\mp\utility::gettimelimit() > 0) {
    setomnvar("ui_match_timer_hidden", 0);
  } else {
    setomnvar("ui_match_timer_hidden", 1);
  }

  thread func_118F7();
  thread _meth_8487();
  thread scripts\mp\missions::func_E75B();
}

func_13BE6() {
  level endon("game_ended");
  while (game["state"] == "playing") {
    var_00 = gettime();
    if(var_00 - level.lastwave["allies"] > level.wavedelay["allies"] * 1000) {
      level notify("wave_respawn_allies");
      level.lastwave["allies"] = var_00;
      level.waveplayerspawnindex["allies"] = 0;
    }

    if(var_00 - level.lastwave["axis"] > level.wavedelay["axis"] * 1000) {
      level notify("wave_respawn_axis");
      level.lastwave["axis"] = var_00;
      level.waveplayerspawnindex["axis"] = 0;
    }

    if(level.multiteambased) {
      for (var_01 = 0; var_01 < level.teamnamelist.size; var_01++) {
        if(var_00 - level.lastwave[level.teamnamelist[var_01]] > level.var_1461[level.teamnamelist[var_01]] * 1000) {
          var_02 = "wave_rewpawn_" + level.teamnamelist[var_01];
          level notify(var_02);
          level.lastwave[level.teamnamelist[var_01]] = var_00;
          level.waveplayerspawnindex[level.teamnamelist[var_01]] = 0;
        }
      }
    }

    wait(0.05);
  }
}

func_7E07() {
  var_00["allies"] = 0;
  var_00["axis"] = 0;
  var_01["allies"] = 0;
  var_01["axis"] = 0;
  foreach(var_03 in level.players) {
    var_04 = var_03.pers["team"];
    if(isdefined(var_04) && var_04 == "allies" || var_04 == "axis") {
      var_00[var_04] = var_00[var_04] + var_03.setculldist;
      var_01[var_04] = var_01[var_04] + var_03.var_E9;
    }
  }

  if(var_00["allies"] > var_00["axis"]) {
    return "allies";
  } else if(var_00["axis"] > var_00["allies"]) {
    return "axis";
  }

  if(var_01["allies"] < var_01["axis"]) {
    return "allies";
  } else if(var_01["axis"] < var_01["allies"]) {
    return "axis";
  }

  if(randomint(2) == 0) {
    return "allies";
  }

  return "axis";
}

rankedmatchupdates(param_00) {
  if(scripts\mp\utility::matchmakinggame()) {
    setxenonranks();
    if(hostidledout()) {
      level.hostforcedend = 1;
      logstring("host idled out");
      endlobby();
    }

    updatematchbonusscores(param_00);
  }

  updatewinlossstats(param_00);
}

func_56E0(param_00, param_01) {
  if(level.var_8865 == "halftime" && level.roundlimit && game["roundsPlayed"] * 2 == level.roundlimit) {
    foreach(var_03 in level.players) {
      var_03 setplayermusicstate("mus_mp_halftime");
    }
  } else if(level.playovertime) {
    foreach(var_03 in level.players) {
      var_03 setplayermusicstate("mus_mp_halftime");
    }
  } else if(level.var_8865 == "halftime" && !level.roundlimit) {
    foreach(var_03 in level.players) {
      var_03 setplayermusicstate("mus_mp_halftime");
    }
  }

  if(!level.doeomcombat && scripts\mp\utility::ismoddedroundgame() && game["finalRound"] == 0) {
    param_00 = "roundend";
  }

  foreach(var_03 in level.players) {
    if(level.teambased) {
      var_03 thread scripts\mp\hud_message::teamoutcomenotify(param_00, 1, param_01);
      continue;
    }

    var_03 thread scripts\mp\hud_message::func_C752(param_00, param_01);
  }
}

func_56DA(param_00, param_01) {
  setomnvar("ui_match_over", 1);
  foreach(var_03 in level.players) {
    if(level.teambased) {
      var_03 thread scripts\mp\hud_message::teamoutcomenotify(param_00, 0, param_01);
      continue;
    }

    var_03 thread scripts\mp\hud_message::func_C752(param_00, param_01);
  }

  level notify("game_win", param_00);
}

func_56E1() {
  level notify("spawning_intermission");
  foreach(var_01 in level.players) {
    var_01 thread scripts\mp\playerlogic::spawnintermission();
  }

  var_03 = level.var_8865;
  if(var_03 == "halftime") {
    if(level.roundlimit) {
      if(game["roundsPlayed"] * 2 == level.roundlimit) {
        var_03 = "halftime";
      } else {
        var_03 = "intermission";
      }
    } else {
      var_03 = "intermission";
    }
  }

  level notify("round_switch", var_03);
  if(game["finalRound"] == 1) {
    var_03 = "finalround";
  }

  var_04 = 0;
  if(isdefined(level.var_11374)) {
    var_04 = game["end_reason"]["switching_sides"];
  }

  foreach(var_01 in level.players) {
    var_01 thread scripts\mp\hud_message::teamoutcomenotify(var_03, 1, var_04);
  }

  func_E761(level.var_8864, 0);
}

func_7384(param_00, param_01, param_02, param_03) {
  if(!isdefined(param_00)) {
    param_00 = 0;
  }

  if(!isdefined(param_03)) {
    param_03 = 0;
  }

  if(param_00 > 0 && param_03) {
    thread slowmotionendofgame(param_00);
  }

  if(param_00 > 1 && !scripts\mp\utility::istrue(level.nukegameover)) {
    thread func_636B(param_00);
  }

  thread sendgameendedfrozennotify(param_00);
  foreach(var_05 in level.players) {
    var_05 thread freezeplayerforroundend(param_00);
    var_05 thread func_E760(4);
    var_05 freegameplayhudelems();
    var_05 setclientdvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);
    if(isdefined(param_01) && isdefined(param_02)) {
      if(param_01 == "cg_fovScale" && var_05 issplitscreenplayer()) {
        var_05 setclientdvars(param_01, 0.75);
      }

      var_05 setclientdvars(param_01, param_02);
    }
  }

  foreach(var_08 in level.agentarray) {
    var_08 scripts\mp\utility::freezecontrolswrapper(1);
  }
}

func_636B(param_00) {
  var_01 = param_00 * 1.3;
  visionsetfadetoblack("bw", var_01);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
}

slowmotionendofgame(param_00) {
  setslowmotion(1, 0.4, param_00);
  setendofroundsoundtimescalefactor();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(param_00);
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();
}

setendofroundsoundtimescalefactor() {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("voice_air_3d", 0);
  soundsettimescalefactor("voice_radio_3d", 0);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("voice_narration_2d", 0);
  soundsettimescalefactor("voice_special_2d", 0);
  soundsettimescalefactor("voice_bchatter_1_3d", 0);
  soundsettimescalefactor("plr_ui_ingame_unres_2d", 0);
  soundsettimescalefactor("hurt_nofilter_2d", 0.15);
  soundsettimescalefactor("amb_bed_2d", 0.25);
  soundsettimescalefactor("amb_elm_ext_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_unres_3d", 0.25);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.25);
  soundsettimescalefactor("reload_plr_res_2d", 0.3);
  soundsettimescalefactor("reload_plr_unres_2d", 0.3);
  soundsettimescalefactor("scn_fx_unres_3d", 0.25);
  soundsettimescalefactor("scn_fx_unres_2d", 0.25);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("scn_lfe_unres_3d", 0);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0.25);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0.25);
  soundsettimescalefactor("weap_npc_main_3d", 0.25);
  soundsettimescalefactor("weap_npc_mech_3d", 0.25);
  soundsettimescalefactor("weap_npc_mid_3d", 0.25);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.25);
  soundsettimescalefactor("weap_npc_lo_3d", 0.25);
  soundsettimescalefactor("melee_npc_3d", 0.25);
  soundsettimescalefactor("melee_plr_2d", 0.25);
  soundsettimescalefactor("special_hi_unres_1_3d", 0.25);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.25);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.25);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0.3);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0.3);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("shock1_nofilter_3d", 0.25);
  soundsettimescalefactor("equip_use_unres_3d", 0.3);
  soundsettimescalefactor("explo_1_3d", 0.3);
  soundsettimescalefactor("explo_2_3d", 0.3);
  soundsettimescalefactor("explo_3_3d", 0.3);
  soundsettimescalefactor("explo_4_3d", 0.3);
  soundsettimescalefactor("explo_5_3d", 0.3);
  soundsettimescalefactor("explo_lfe_3d", 0.3);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.3);
  soundsettimescalefactor("projectile_loop_close", 0.3);
  soundsettimescalefactor("projectile_loop_mid", 0.3);
  soundsettimescalefactor("projectile_loop_dist", 0.3);
}

resetsoundtimescalefactor() {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0);
  soundsettimescalefactor("weap_npc_main_3d", 0);
  soundsettimescalefactor("weap_npc_mech_3d", 0);
  soundsettimescalefactor("weap_npc_mid_3d", 0);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0);
  soundsettimescalefactor("weap_npc_lo_3d", 0);
  soundsettimescalefactor("melee_npc_3d", 0);
  soundsettimescalefactor("melee_plr_2d", 0);
  soundsettimescalefactor("special_hi_unres_1_3d", 0);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("equip_use_unres_3d", 0);
  soundsettimescalefactor("explo_1_3d", 0);
  soundsettimescalefactor("explo_2_3d", 0);
  soundsettimescalefactor("explo_3_3d", 0);
  soundsettimescalefactor("explo_4_3d", 0);
  soundsettimescalefactor("explo_5_3d", 0);
  soundsettimescalefactor("explo_lfe_3d", 0);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0);
  soundsettimescalefactor("projectile_loop_close", 0);
  soundsettimescalefactor("projectile_loop_mid", 0);
  soundsettimescalefactor("projectile_loop_dist", 0);
}

sendgameendedfrozennotify(param_00) {
  wait(param_00);
  level notify("game_ended_frozen");
}

func_E2A9() {
  setomnvarforallclients("post_game_state", 0);
  level notify("restarting");
  game["state"] = "playing";
  map_restart(1);
}

endgame(param_00, param_01, param_02) {
  if(isdefined(level.endgame)) {
    [
      [level.endgame]
    ](param_00, param_01);
    return;
  }

  func_6322(param_00, param_01, param_02);
}

func_6322(param_00, param_01, param_02) {
  if(!isdefined(param_02)) {
    param_02 = 0;
  }

  if(level.gameended) {
    return;
  }

  if(game["roundsPlayed"] < 24) {
    setmatchdata("utcRoundEndTimeSeconds", game["roundsPlayed"], getsystemtime());
  }

  scripts\mp\matchdata::func_C557();
  var_03 = 0;
  if(level.hostforcedend || level.var_72B3) {
    var_03 = 1;
  }

  if(scripts\mp\utility::inovertime()) {
    if(game["overtimeRoundsPlayed"] == 0) {
      setmatchdata("firstOvertimeRoundIndex", game["roundsPlayed"]);
    }

    if(!var_03) {
      game["overtimeRoundsPlayed"]++;
    }
  }

  if(level.teambased) {
    if(param_00 == "axis" || param_00 == "allies") {
      if(!var_03) {
        game["roundsWon"][param_00]++;
      }

      if(!isdefined(level.finalkillcam_winner)) {
        level.finalkillcam_winner = param_00;
      }
    } else if(!isdefined(level.finalkillcam_winner)) {
      level.finalkillcam_winner = "none";
    }

    scripts\mp\gamescore::updateteamscore("axis");
    scripts\mp\gamescore::updateteamscore("allies");
    if(scripts\mp\utility::isroundbased() && game["roundsPlayed"] < 24 && level.gametype != "koth") {
      setmatchdata("alliesRoundScore", game["roundsPlayed"], getteamscore("allies"));
      setmatchdata("axisRoundScore", game["roundsPlayed"], getteamscore("axis"));
    }
  } else {
    if(isdefined(param_00) && isplayer(param_00) && !var_03) {
      game["roundsWon"][param_00.guid]++;
    }

    if(!isdefined(level.finalkillcam_winner)) {
      if(isstring(param_00) && param_00 == "tie") {
        level.finalkillcam_winner = "none";
      } else {
        level.finalkillcam_winner = param_00.guid;
      }
    }
  }

  scripts\mp\gamescore::updateplacement();
  if(!var_03) {
    game["roundsPlayed"]++;
  }

  level.playovertime = scripts\mp\utility::func_1004B();
  if(scripts\mp\utility::nextroundisfinalround()) {
    game["finalRound"] = 1;
  }

  if(scripts\mp\utility::waslastround()) {
    param_00 = checkmodeoverridetie(param_00);
  }

  var_04 = func_6321(param_00, param_01, param_02);
  if(var_04 && scripts\mp\utility::waslastround()) {
    func_6320(param_00, param_01, param_02);
  }
}

checkmodeoverridetie(param_00) {
  if(level.gametype == "ctf" && param_00 == "tie" && !level.winrule) {
    scripts\mp\gamescore::func_12F4A("axis");
    scripts\mp\gamescore::func_12F4A("allies");
    var_01 = getteamscore("allies");
    var_02 = getteamscore("axis");
    if(var_01 != var_02) {
      param_00 = scripts\engine\utility::ter_op(var_01 > var_02, "allies", "axis");
    }
  }

  return param_00;
}

func_6323() {
  if(isdefined(level.finalkillcam_winner)) {
    level.finalkillcam_timegameended[level.finalkillcam_winner] = scripts\mp\utility::getsecondspassed();
    level notify("game_cleanup");
    level waittill("final_killcam_done");
  }
}

func_6321(param_00, param_01, param_02) {
  level.gameendtime = gettime();
  level.gameended = 1;
  level.ingraceperiod = 0;
  level.doeomcombat = 0;
  if(getdvarint("scr_eom_combat")) {
    if(scripts\mp\utility::waslastround()) {
      level.doeomcombat = 1;
    }
  }

  scripts\engine\utility::waitframe();
  scripts\mp\gamescore::updateplacement();
  level.recordfinalkillcam = 0;
  level.ignorescoring = 1;
  level.var_561D = 1;
  scripts\mp\final_killcam::preloadfinalkillcam();
  if(scripts\mp\utility::waslastround()) {
    level notify("round_end_music", param_00);
  }

  if(level.doeomcombat) {
    setomnvarforallclients("post_game_state", 1);
    setomnvarforallclients("post_game_state", 2);
    foreach(var_04 in level.players) {
      if(level.teambased) {
        var_04 thread scripts\mp\hud_message::teamoutcomenotify(param_00, 0, param_01);
        continue;
      }

      var_04 thread scripts\mp\hud_message::func_C752(param_00, param_01);
    }

    func_7384(3, "cg_fovScale", 1, 1);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3);
    game["state"] = "postgame";
    level notify("game_ended", param_00);
    scripts\mp\utility::func_ABF4("game_over");
    scripts\mp\utility::func_ABF4("block_notifies");
    scripts\engine\utility::waitframe();
    foreach(var_04 in level.players) {
      var_04 setclientdvar("ui_opensummary", 1);
      if(scripts\mp\utility::wasonlyround() || scripts\mp\utility::waslastround()) {
        var_04 scripts\mp\killstreaks\_killstreaks::func_41C0();
      }
    }
  } else {
    setomnvarforallclients("post_game_state", 1);
    game["state"] = "postgame";
    level notify("game_ended", param_01);
    scripts\mp\utility::func_ABF4("game_over");
    scripts\mp\utility::func_ABF4("block_notifies");
    scripts\engine\utility::waitframe();
    foreach(var_04 in level.players) {
      var_04 setclientdvar("ui_opensummary", 1);
      if(scripts\mp\utility::wasonlyround() || scripts\mp\utility::waslastround()) {
        var_04 scripts\mp\killstreaks\_killstreaks::func_41C0();
      }
    }

    func_7384(1, "cg_fovScale", 1, 0);
  }

  setgameendtime(0);
  thread scripts\mp\analyticslog::logevent_sendplayerindexdata();
  scripts\mp\playerlogic::printpredictedspawnpointcorrectness();
  if(scripts\mp\analyticslog::analyticsspawnlogenabled()) {
    scripts\mp\analyticslog::analyticsstorespawndata();
  }

  if(isdefined(level.matchrecording_dump)) {
    [
      [level.matchrecording_dump]
    ]();
  }

  rankedmatchupdates(param_00);
  setdvar("g_deadChat", 1);
  setdvar("ui_allow_teamchange", 0);
  setdvar("bg_compassShowEnemies", 0);
  func_56E0(param_00, param_01);
  if(!scripts\mp\utility::waslastround()) {
    level notify("round_win", param_00);
    func_E761(level.var_E75F, 1);
  } else {
    func_E761(0, 1);
  }

  func_6323();
  setslowmotion(1, 1, 0);
  resetsoundtimescalefactor();
  if(level.teambased) {
    scripts\mp\gamescore::func_12F4A("axis");
    scripts\mp\gamescore::func_12F4A("allies");
  }

  if(!scripts\mp\utility::wasonlyround() && !param_02) {
    if(!scripts\mp\utility::waslastround()) {
      if(level.playovertime) {
        param_00 = "overtime";
        game["status"] = "overtime";
      }

      scripts\mp\utility::levelflagclear("block_notifies");
      if(func_3E43(level.playovertime)) {
        func_56E1();
      }

      foreach(var_04 in level.players) {
        var_04.pers["stats"] = var_04.var_10E53;
      }

      func_E2A9();
      return 0;
    }

    if(!level.var_72B3) {
      var_04 = updateroundendreasontext(param_02);
    }
  }

  return 1;
}

func_6320(param_00, param_01, param_02) {
  if(!scripts\mp\utility::istrue(level.processedwinloss) && scripts\mp\utility::istrue(level.var_72F2) || level.var_72B3) {
    updatewinlossstats(param_00);
  }

  scripts\mp\missions::func_E75D(param_00);
  scripts\mp\intel::updatemissionteamperformancestats();
  func_3E16();
  func_12F23();
  scripts\mp\persistence::writebestscores();
  level notify("stop_leaderboard_stats");
  updateleaderboardstats();
  level.doingbroshot = scripts\mp\broshot::initbroshot(param_00);
  if(!level.doingbroshot) {
    level notify("spawning_intermission");
    foreach(var_04 in level.players) {
      var_04 thread scripts\mp\utility::func_F8A0(0);
      var_04 thread scripts\mp\playerlogic::spawnintermission();
    }
  }

  if(scripts\mp\utility::istrue(param_02) && !scripts\mp\utility::istrue(level.var_C1B2)) {
    scripts\mp\utility::_visionsetnaked(level.var_C1D0, 0);
    visionsetfadetoblack("", 0.75);
  } else {
    scripts\mp\utility::_visionsetnaked("", 0);
    visionsetfadetoblack("", 0.75);
  }

  func_56DA(param_00, param_01);
  scripts\mp\utility::levelflagclear("block_notifies");
  level.preloadcinematicforall = 1;
  if(!level.doingbroshot) {
    setomnvarforallclients("post_game_state", 4);
    func_E761(level.var_D706, 1);
  }

  func_D9AA();
  if(level.doingbroshot) {
    setomnvarforallclients("post_game_state", 6);
    wait(0.1);
    var_06 = scripts\mp\broshot::func_10D73(param_00);
    var_07 = undefined;
    foreach(var_04 in level.players) {
      if(var_04 ishost()) {
        var_07 = var_04;
        break;
      }
    }

    if(isdefined(var_07)) {
      var_07 scripts\engine\utility::waittill_notify_or_timeout("dev_skip_broshot", var_06);
    } else {
      wait(var_06);
    }

    scripts\mp\broshot::endbroshot();
  }

  if(level.teambased) {
    if(param_00 == "axis" || param_00 == "allies") {
      setmatchdata("victor", param_00);
    } else {
      setmatchdata("victor", "none");
    }

    setmatchdata("alliesScore", getteamscore("allies"));
    setmatchdata("axisScore", getteamscore("axis"));
  } else {
    setmatchdata("victor", "none");
  }

  foreach(var_04 in level.players) {
    var_04 setplayerdata("common", "round", "endReasonTextIndex", param_01);
    if(var_04 scripts\mp\utility::rankingenabled()) {
      var_04 scripts\mp\matchdata::logfinalstats();
    }

    if(isalive(var_04) && isdefined(var_04.matchdatalifeindex)) {
      var_04 scripts\mp\matchdata::logxpscoreearnedinlife(var_04.matchdatalifeindex);
    }

    if(level.teambased) {
      if(param_00 == "axis" || param_00 == "allies") {
        if(isdefined(var_04.team)) {
          if(var_04.team == param_00) {
            var_04 logplayerendmatchdatamatchresult(var_04.clientid, "win");
          } else {
            var_04 logplayerendmatchdatamatchresult(var_04.clientid, "loss");
          }
        } else {
          var_04 logplayerendmatchdatamatchresult(var_04.clientid, "none");
        }
      } else if(getteamscore("allies") == getteamscore("axis")) {
        var_04 logplayerendmatchdatamatchresult(var_04.clientid, "draw");
      } else {
        var_04 logplayerendmatchdatamatchresult(var_04.clientid, "none");
      }

      continue;
    }

    if(isplayer(param_00) && param_00.clientid == var_04.clientid) {
      var_04 logplayerendmatchdatamatchresult(var_04.clientid, "win");
      continue;
    }

    var_04 logplayerendmatchdatamatchresult(var_04.clientid, "loss");
  }

  setmatchdata("host", level.var_90AE);
  if(scripts\mp\utility::matchmakinggame()) {
    setmatchdata("playlistVersion", getplaylistversion());
    setmatchdata("playlistID", getplaylistid());
    setmatchdata("isDedicated", isdedicatedserver());
  }

  sendmatchdata();
  foreach(var_04 in level.players) {
    var_04.pers["stats"] = var_04.var_10E53;
  }

  if(!param_02 && !level.var_D701) {
    if(!level.doingbroshot) {
      if(!scripts\mp\utility::wasonlyround()) {
        wait(6);
      } else {
        wait(min(5, 4 + level.var_D701));
      }
    }
  } else {
    wait(min(10, 4 + level.var_D701));
  }

  if(isgamebattlematch()) {
    for (var_0E = getgamebattlematchreportstate(); var_0E != 3 && var_0E != 4; var_0E = getgamebattlematchreportstate()) {
      wait(1);
    }

    setomnvarforallclients("post_game_state", 5);
    wait(5);
  }

  setomnvarforallclients("post_game_state", 1);
  scripts\mp\utility::func_ABF6("post_game_level_event_active");
  setnojipscore(0);
  setnojiptime(0);
  level notify("exitLevel_called");
  exitlevel(0);
}

updateroundendreasontext(param_00) {
  if(!level.teambased) {
    return 1;
  }

  if(scripts\mp\utility::ismoddedroundgame()) {
    if(scripts\mp\utility::hitscorelimit()) {
      return game["end_reason"]["score_limit_reached"];
    }

    if(scripts\mp\utility::hittimelimit()) {
      return game["end_reason"]["time_limit_reached"];
    }
  } else if(scripts\mp\utility::hitroundlimit()) {
    return game["end_reason"]["round_limit_reached"];
  }

  if(scripts\mp\utility::hitwinlimit()) {
    return game["end_reason"]["score_limit_reached"];
  }

  return game["end_reason"]["objective_completed"];
}

estimatedtimetillscorelimit(param_00) {
  if(!scripts\mp\utility::ismoddedroundgame()) {
    var_01 = getscoreperminute(param_00);
    var_02 = getscoreremaining(param_00);
    var_03 = 999999;
    if(var_01) {
      var_03 = var_02 / var_01;
    }

    return var_03;
  }

  var_01 = getscoreperminute(var_03);
  var_02 = getscoreperminute(var_02);
  var_03 = 999999;
  if(var_01) {
    var_03 = var_02 / var_01;
  }

  return var_03;
}

func_42AC(param_00) {
  var_01 = 10;
  var_02 = 20;
  if(level.gametype == "tdef") {
    var_01 = 20;
  }

  if(level.gametype == "dom") {
    var_02 = 20;
  }

  var_03 = level.roundscorelimit;
  var_04 = getteamscore(param_00);
  var_05 = var_03 - var_04;
  if(var_05 <= scripts\engine\utility::ter_op(scripts\mp\utility::istrue(game["finalRound"]), var_02, var_01)) {
    return 1;
  }

  return 0;
}

getscoreperminute(param_00) {
  var_01 = scripts\mp\utility::gettimepassed() / -5536 + 0.0001;
  if(isplayer(self)) {
    var_02 = self.destroynavrepulsor / var_01;
  } else {
    var_02 = getteamscore(var_01) / var_02;
  }

  return var_02;
}

getscoreremaining(param_00) {
  var_01 = level.roundscorelimit;
  if(isplayer(self)) {
    var_02 = var_01 - self.destroynavrepulsor;
  } else {
    var_02 = var_02 - getteamscore(var_01);
  }

  return var_02;
}

getscoreperminuteroundbased(param_00) {
  var_01 = level.roundscorelimit;
  if(!game["switchedsides"]) {
    var_01 = var_01 / 2;
    var_02 = scripts\mp\utility::gettimepassed() / -5536 + 0.0001;
    var_03 = getteamscore(param_00) / var_02;
  } else {
    var_03 = int(var_03 / 2);
    var_02 = scripts\mp\utility::gettimepassed() / -5536 + 0.0001;
    var_04 = getteamscore(var_01);
    if(var_04 >= var_01) {
      var_03 = var_04 - var_01 / var_02;
    } else {
      return 0;
    }
  }

  return var_03;
}

givelastonteamwarning() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::waittillrecoveredhealth(3);
  thread scripts\mp\utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
  foreach(var_01 in level.teamnamelist) {
    if(self.pers["team"] != var_01) {
      thread scripts\mp\utility::teamplayercardsplash("callout_lastenemyalive", self, var_01);
    }
  }

  scripts\mp\music_and_dialog::func_C54B(self);
}

func_D9AA() {
  var_00 = 0;
  foreach(var_02 in level.players) {
    if(!isdefined(var_02)) {
      continue;
    }

    var_02.clientmatchdataid = var_00;
    var_00++;
    if(level.var_DADB && var_02.name.size > level.var_B4B3) {
      var_03 = "";
      for (var_04 = 0; var_04 < level.var_B4B3 - 3; var_04++) {
        var_03 = var_03 + var_02.name[var_04];
      }

      var_03 = var_03 + "...";
    } else {
      var_03 = var_02.name;
    }

    setclientmatchdata("players", var_02.clientmatchdataid, "username", var_03);
    setclientmatchdata("players", var_02.clientmatchdataid, "clanTag", var_02 getclantag());
    setclientmatchdata("players", var_02.clientmatchdataid, "xuidHigh", var_02 _meth_8565());
    setclientmatchdata("players", var_02.clientmatchdataid, "xuidLow", var_02 _meth_8566());
    setclientmatchdata("players", var_02.clientmatchdataid, "isBot", isbot(var_02));
    setclientmatchdata("players", var_02.clientmatchdataid, "uniqueClientId", var_02.clientid);
    var_02 setplayerdata("common", "round", "clientMatchIndex", var_02.clientmatchdataid);
  }

  scripts\mp\scoreboard::func_D9AB();
  sendclientmatchdata();
  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    thread scripts\mp\codcasterclientmatchdata::sendcodcastermatchdata();
  }
}

func_11AF7(param_00, param_01) {
  thread threadedsetweaponstatbyname(param_00, 1, "deaths");
}

func_11AC8(param_00, param_01) {
  if(isdefined(self) && isplayer(self)) {
    if(param_01 != "MOD_FALLING") {
      if(param_01 == "MOD_MELEE" && issubstr(param_00, "tactical")) {
        scripts\mp\matchdata::func_AF94("tactical", "kills", 1);
        scripts\mp\matchdata::func_AF94("tactical", "hits", 1);
        scripts\mp\persistence::func_93F9("tactical", "kills", 1);
        scripts\mp\persistence::func_93F9("tactical", "hits", 1);
        return;
      }

      if(param_01 == "MOD_MELEE" && !scripts\mp\weapons::isriotshield(param_00) && !scripts\mp\weapons::isknifeonly(param_00) && !scripts\mp\weapons::isaxeweapon(param_00)) {
        scripts\mp\matchdata::func_AF94("none", "kills", 1);
        scripts\mp\matchdata::func_AF94("none", "hits", 1);
        scripts\mp\persistence::func_93F9("none", "kills", 1);
        scripts\mp\persistence::func_93F9("none", "hits", 1);
        return;
      }

      thread threadedsetweaponstatbyname(param_00, 1, "kills");
    }

    if(param_01 == "MOD_HEAD_SHOT") {
      thread threadedsetweaponstatbyname(param_00, 1, "headShots");
    }
  }
}

setweaponstat(param_00, param_01, param_02) {
  if(!param_01) {
    return;
  }

  var_03 = scripts\mp\utility::getweapongroup(param_00);
  var_04 = getweaponvariantindex(param_00);
  if(var_03 == "killstreak" || var_03 == "other" && param_00 != "trophy_mp" || var_03 == "other" && param_00 != "player_trophy_system_mp" || var_03 == "other" && param_00 != "super_trophy_mp") {
    return;
  }

  if(scripts\mp\utility::isenvironmentweapon(param_00)) {
    return;
  }

  if(var_03 == "weapon_grenade" || var_03 == "weapon_explosive" || param_00 == "trophy_mp" || param_00 == "adrenaline_mist_mp" || param_00 == "domeshield_mp" || param_00 == "copycat_grenade_mp" || param_00 == "speed_strip_mp" || param_00 == "forcepush_mp" || param_00 == "portal_generator_mp") {
    var_05 = scripts\mp\utility::strip_suffix(param_00, "_mp");
    scripts\mp\persistence::func_93FC(var_05, param_02, param_01);
    scripts\mp\matchdata::func_AFDC(var_05, param_02, param_01, var_04);
    return;
  }

  if(!isdefined(self.trackingweapon)) {
    self.trackingweapon = param_01;
  }

  if(param_01 != self.trackingweapon) {
    scripts\mp\persistence::func_12F5E();
    self.trackingweapon = param_01;
  }

  switch (var_03) {
    case "shots":
      self.trackingweaponshots++;
      break;

    case "hits":
      self.trackingweaponhits++;
      break;

    case "headShots":
      self.trackingweaponheadshots++;
      break;

    case "kills":
      self.trackingweaponkills++;
      break;
  }

  if(var_03 == "deaths") {
    var_06 = undefined;
    var_07 = scripts\mp\utility::getweaponrootname(param_01);
    if(!scripts\mp\utility::iscacprimaryweapon(var_07) && !scripts\mp\utility::iscacsecondaryweapon(var_07)) {
      return;
    }

    var_08 = scripts\mp\utility::getweaponattachmentsbasenames(param_01);
    scripts\mp\persistence::func_93FC(var_07, var_03, param_02);
    scripts\mp\matchdata::func_AFDC(var_07, "deaths", param_02, var_05);
    foreach(var_0A in var_08) {
      scripts\mp\persistence::func_93F9(var_0A, var_03, param_02);
      scripts\mp\matchdata::func_AF94(var_0A, var_03, param_02);
    }
  }
}

setinflictorstat(param_00, param_01, param_02) {
  if(!isdefined(param_01)) {
    return;
  }

  if(!isdefined(param_00)) {
    param_01 setweaponstat(param_02, 1, "hits");
    return;
  }

  if(!isdefined(param_00.playeraffectedarray)) {
    param_00.playeraffectedarray = [];
  }

  var_03 = 1;
  for (var_04 = 0; var_04 < param_00.playeraffectedarray.size; var_04++) {
    if(param_00.playeraffectedarray[var_04] == self) {
      var_03 = 0;
      break;
    }
  }

  if(var_03) {
    param_00.playeraffectedarray[param_00.playeraffectedarray.size] = self;
    param_01 setweaponstat(param_02, 1, "hits");
  }
}

threadedsetweaponstatbyname(param_00, param_01, param_02) {
  self endon("disconnect");
  waittillframeend;
  setweaponstat(param_00, param_01, param_02);
}

func_12F23() {
  foreach(var_01 in level.players) {
    if(!isdefined(var_01)) {
      continue;
    }

    if(var_01 scripts\mp\utility::rankingenabled()) {
      var_02 = getmatchspm(var_01);
      var_03 = var_01 getplayerdata("mp", "globalSPM");
      var_04 = var_01 getplayerdata("mp", "gamesPlayed");
      var_05 = var_01 getplayerdata("mp", "dlcEggStatus");
      if(var_05 > 0) {
        var_04 = int(max(var_04 - var_05, 1));
      }

      var_03 = var_03 * var_04 - 1;
      var_06 = var_02;
      if(var_04 > 0) {
        var_06 = var_03 + var_02 / var_04;
      }

      var_01 setplayerdata("mp", "globalSPM", int(var_06));
      var_07 = getgametypeindex(level.gametype);
      if(var_07 >= 0 && var_07 < level.var_B4A0) {
        var_08 = var_01 getplayerdata("mp", "gameModeScoreHistory", var_07, "index");
        var_01 setplayerdata("mp", "gameModeScoreHistory", var_07, "scores", var_08, int(var_02));
        var_08 = var_08 + 1 % level.var_B4A1;
        var_01 setplayerdata("mp", "gameModeScoreHistory", var_07, "index", var_08);
      }
    }
  }
}

func_3E16() {
  foreach(var_01 in level.players) {
    if(!isdefined(var_01)) {
      continue;
    }

    if(var_01 scripts\mp\utility::rankingenabled()) {
      var_02 = var_01 getplayerdata("common", "round", "kills");
      var_03 = var_01 getplayerdata("common", "round", "deaths");
      var_04 = var_01.pers["summary"]["xp"];
      var_05 = var_01 getplayerdata("mp", "bestKills");
      var_06 = var_01 getplayerdata("mp", "mostDeaths");
      var_07 = var_01 getplayerdata("mp", "mostXp");
      var_08 = var_01 getplayerdata("mp", "bestSPM", "score");
      var_09 = var_01 getplayerdata("mp", "bestKD", "score");
      if(var_02 > var_05) {
        var_01 setplayerdata("mp", "bestKills", var_02);
      }

      if(var_04 > var_07) {
        var_01 setplayerdata("mp", "mostXp", var_04);
      }

      if(var_03 > var_06) {
        var_01 setplayerdata("mp", "mostDeaths", var_03);
      }

      var_0A = var_02;
      if(var_03 > 1) {
        var_0A = var_0A / var_03;
      }

      var_0A = int(var_0A * 1000);
      if(var_0A > var_09) {
        var_01 setplayerdata("mp", "bestKD", "score", var_0A);
        var_01 setplayerdata("mp", "bestKD", "time", getsystemtime());
      }

      var_0B = getmatchspm(var_01);
      if(var_0B > var_08) {
        var_01 setplayerdata("mp", "bestSPM", "score", int(var_0B));
        var_01 setplayerdata("mp", "bestSPM", "time", getsystemtime());
      }

      var_01 func_3E0C();
      var_01 scripts\mp\matchdata::func_AFD7(var_04, "totalXp");
      var_01 scripts\mp\matchdata::func_AFD7(var_01.pers["summary"]["score"], "scoreXp");
      var_01 scripts\mp\matchdata::func_AFD7(var_01.pers["summary"]["challenge"], "challengeXp");
      var_01 scripts\mp\matchdata::func_AFD7(var_01.pers["summary"]["match"], "matchXp");
      var_01 scripts\mp\matchdata::func_AFD7(var_01.pers["summary"]["misc"], "miscXp");
      var_01 scripts\mp\matchdata::func_AFD7(var_01.pers["summary"]["medal"], "medalXp");
      var_01 scripts\mp\matchdata::func_AFD7(var_01.pers["summary"]["bonusXP"], "bonusXp");
    }

    if(isdefined(var_01.pers["confirmed"])) {
      var_01 scripts\mp\matchdata::logkillsconfirmed();
    }

    if(isdefined(var_01.pers["denied"])) {
      var_01 scripts\mp\matchdata::logkillsdenied();
    }
  }
}

updateleaderboardstatscontinuous() {
  level endon("game_ended");
  level endon("stop_leaderboard_stats");
  var_00 = 0;
  for (;;) {
    while (!isdefined(level.players) || level.players.size == 0) {
      scripts\engine\utility::waitframe();
    }

    if(var_00 >= level.players.size) {
      var_00 = 0;
    }

    var_01 = level.players[var_00];
    if(!isdefined(var_01) || isai(var_01)) {
      scripts\engine\utility::waitframe();
    } else {
      if(var_01 scripts\mp\utility::rankingenabled()) {
        var_01 updateplayerleaderboardstats();
      }

      wait(0.1);
    }

    var_00++;
  }
}

updateleaderboardstats() {
  foreach(var_01 in level.players) {
    if(!isdefined(var_01) || isai(var_01)) {
      continue;
    }

    if(var_01 scripts\mp\utility::rankingenabled()) {
      var_01 updateplayerleaderboardstats();
    }
  }
}

updateplayerleaderboardstats() {
  var_00 = undefined;
  if(level.hardcoremode) {
    var_00 = "hc";
  } else {
    var_00 = "";
  }

  var_00 = var_00 + level.gametype;
  var_01 = scripts\engine\utility::ter_op(level.teambased, self.destroynavrepulsor, self.pers["gamemodeScore"]);
  incrementleaderboardstat(var_00 + "Score", var_01);
  var_02 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  incrementleaderboardstat(var_00 + "TimePlayed", var_02);
  incrementleaderboardstat(var_00 + "Kills", self.pers["kills"]);
  incrementleaderboardstat(var_00 + "Deaths", self.pers["deaths"]);
  switch (level.gametype) {
    case "war":
      incrementleaderboardstat(var_00 + "Assists", self.pers["assists"]);
      break;

    case "front":
      incrementleaderboardstat(var_00 + "Assists", self.pers["assists"]);
      break;

    case "dm":
      updateleaderboardstatmaximum(var_00 + "Streak", self.pers["killChains"]);
      break;

    case "dom":
      incrementleaderboardstat(var_00 + "Captures", self.pers["captures"]);
      incrementleaderboardstat(var_00 + "Defends", self.pers["defends"]);
      break;

    case "sd":
      incrementleaderboardstat(var_00 + "Plants", self.pers["plants"]);
      incrementleaderboardstat(var_00 + "Defuses", self.pers["defuses"]);
      break;

    case "conf":
      incrementleaderboardstat(var_00 + "Confirms", self.pers["confirmed"]);
      incrementleaderboardstat(var_00 + "Denies", self.pers["denied"]);
      break;

    case "koth":
      incrementleaderboardstat(var_00 + "ObjTime", self.pers["objTime"]);
      incrementleaderboardstat(var_00 + "Defends", self.pers["defends"]);
      break;

    case "tdef":
      incrementleaderboardstat(var_00 + "ObjTime", self.pers["objTime"]);
      incrementleaderboardstat(var_00 + "Captures", self.pers["defends"]);
      break;

    case "ball":
      incrementleaderboardstat(var_00 + "Throws", self.pers["fieldgoals"]);
      incrementleaderboardstat(var_00 + "Carries", self.pers["touchdowns"]);
      break;

    case "ctf":
      incrementleaderboardstat(var_00 + "Captures", self.pers["captures"]);
      incrementleaderboardstat(var_00 + "Returns", self.pers["returns"]);
      break;

    case "sr":
      incrementleaderboardstat(var_00 + "Plants", self.pers["plants"]);
      incrementleaderboardstat(var_00 + "Rescues", self.pers["rescues"]);
      break;

    case "siege":
      incrementleaderboardstat(var_00 + "Captures", self.pers["captures"]);
      incrementleaderboardstat(var_00 + "Revives", self.pers["rescues"]);
      break;

    case "grind":
      incrementleaderboardstat(var_00 + "Banks", self.pers["confirmed"]);
      incrementleaderboardstat(var_00 + "Denies", self.pers["denied"]);
      break;

    case "infect":
      incrementleaderboardstat(var_00 + "Time", scripts\mp\utility::getpersstat("extrascore0"));
      incrementleaderboardstat(var_00 + "Infected", self.pers["killsAsInfected"]);
      break;

    case "gun":
      incrementleaderboardstat(var_00 + "Stabs", self.pers["stabs"]);
      incrementleaderboardstat(var_00 + "SetBacks", self.pers["setbacks"]);
      break;

    case "grnd":
      incrementleaderboardstat(var_00 + "ObjTime", self.pers["objTime"]);
      incrementleaderboardstat(var_00 + "Defends", self.pers["defends"]);
      break;
  }
}

incrementleaderboardstat(param_00, param_01) {
  if(!isdefined(self.leaderboardstartvalues)) {
    self.leaderboardstartvalues = [];
  }

  if(!isdefined(self.leaderboardstartvalues[param_00])) {
    self.leaderboardstartvalues[param_00] = self getplayerdata("mp", "leaderBoardData", param_00);
  }

  var_02 = int(max(self.leaderboardstartvalues[param_00] + param_01, self.leaderboardstartvalues[param_00]));
  self setplayerdata("mp", "leaderBoardData", param_00, var_02);
}

updateleaderboardstatmaximum(param_00, param_01) {
  var_02 = self getplayerdata("mp", "leaderBoardData", param_00);
  if(param_01 > var_02) {
    self setplayerdata("mp", "leaderBoardData", param_00, param_01);
  }
}

getmatchspm(param_00) {
  var_01 = scripts\engine\utility::ter_op(level.teambased, param_00.destroynavrepulsor, param_00.pers["gamemodeScore"]);
  var_02 = param_00 scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  if(isdefined(var_02) && var_02 > 0) {
    var_03 = var_02 / 60;
    var_01 = var_01 / var_03;
  }

  return var_01;
}

isvalidbestweapon(param_00) {
  var_01 = scripts\mp\utility::getweapongroup(param_00);
  return isdefined(param_00) && param_00 != "" && !scripts\mp\utility::iskillstreakweapon(param_00) && var_01 != "killstreak" && var_01 != "other";
}

func_3E0C() {
  var_00 = scripts\mp\matchdata::func_322A();
  var_01 = "";
  var_02 = -1;
  for (var_03 = 0; var_03 < var_00.size; var_03++) {
    var_04 = var_00[var_03];
    var_04 = scripts\mp\utility::getweaponrootname(var_04);
    if(isvalidbestweapon(var_04)) {
      var_05 = self getplayerdata("mp", "weaponStats", var_04, "kills");
      if(var_05 > var_02) {
        var_01 = var_04;
        var_02 = var_05;
      }
    }
  }

  var_06 = self getplayerdata("mp", "weaponStats", var_01, "shots");
  var_07 = self getplayerdata("mp", "weaponStats", var_01, "headShots");
  var_08 = self getplayerdata("mp", "weaponStats", var_01, "hits");
  var_09 = self getplayerdata("mp", "weaponStats", var_01, "deaths");
  var_0A = 0;
  self setplayerdata("mp", "bestWeapon", "kills", var_02);
  self setplayerdata("mp", "bestWeapon", "shots", var_06);
  self setplayerdata("mp", "bestWeapon", "headShots", var_07);
  self setplayerdata("mp", "bestWeapon", "hits", var_08);
  self setplayerdata("mp", "bestWeapon", "deaths", var_09);
  self setplayerdata("mp", "bestWeaponXP", var_0A);
  var_0B = int(tablelookup("mp\statstable.csv", 4, var_01, 0));
  self setplayerdata("mp", "bestWeaponIndex", var_0B);
}

allow_weapon_func(param_00) {
  self notify("allow_weapon_mp()");
  if(param_00) {
    if(isdefined(self.allowweaponcache) && !self hasweapon(self.allowweaponcache)) {
      scripts\mp\utility::func_1136C(self.lastdroppableweaponobj);
    }

    self.allowweaponcache = undefined;
    return;
  }

  self.allowweaponcache = self getcurrentprimaryweapon();
  thread watchinvalidweaponswitchduringdisableweapon();
}

func_1C74() {
  level.allow_weapon_func = ::allow_weapon_func;
}

watchinvalidweaponswitchduringdisableweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("allow_weapon_mp()");
  for (;;) {
    self waittill("weapon_switch_invalid", var_00);
    self.allowweaponcache = var_00;
  }
}

ismp_init() {
  level.ismp = 1;
}