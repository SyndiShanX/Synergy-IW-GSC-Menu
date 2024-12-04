/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2809.gsc
***************************************/

func_69B1() {
  if(isdefined(self.script_delay))
    wait(self.script_delay);

  self playsound(level.scr_sound[self.script_sound]);
}

_beginlocationselection(var_00, var_01, var_02, var_03) {
  self beginlocationselection(var_01, var_02, 0, var_03);
  self.selectinglocation = 1;
  self setblurforplayer(10.3, 0.3);
  thread endselectiononaction("cancel_location");
  thread endselectiononaction("death");
  thread endselectiononaction("disconnect");
  thread endselectiononaction("used");
  thread endselectiononaction("weapon_change");
  self endon("stop_location_selection");
  thread func_6388();
  thread func_6387();

  if(isdefined(var_00) && self.team != "spectator") {
    if(isdefined(self.func_110E9))
      self.func_110E9 destroy();

    if(self issplitscreenplayer()) {
      self.func_110E9 = scripts\mp\hud_util::createfontstring("default", 1.3);
      self.func_110E9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -98);
    } else {
      self.func_110E9 = scripts\mp\hud_util::createfontstring("default", 1.6);
      self.func_110E9 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, -190);
    }

    var_04 = func_7F47(var_00);
    self.func_110E9 give_zap_perk(var_04);
  }
}

func_11079(var_00, var_01) {
  if(!isdefined(var_01))
    var_01 = "generic";

  if(!var_00) {
    self setblurforplayer(0, 0.3);
    self _meth_80DE();
    self.selectinglocation = undefined;

    if(isdefined(self.func_110E9))
      self.func_110E9 destroy();
  }

  self notify("stop_location_selection", var_01);
}

func_6387() {
  self endon("stop_location_selection");

  for (;;) {
    level waittill("emp_update");

    if(!scripts\mp\killstreaks\emp_common::isemped()) {
      continue;
    }
    thread func_11079(0, "emp");
    return;
  }
}

endselectiononaction(var_00) {
  self endon("stop_location_selection");
  self waittill(var_00);
  thread func_11079(var_00 == "disconnect", var_00);
}

func_6388() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  thread func_11079(0, "end_game");
}

func_9D54(var_00) {
  var_01 = tablelookup("mp\attachmentTable.csv", 4, var_00, 0);

  if(isdefined(var_01) && var_01 != "")
    return 1;
  else
    return 0;
}

getattachmenttype(var_00) {
  var_01 = tablelookup("mp\attachmentTable.csv", 4, var_00, 2);
  return var_01;
}

func_2287(var_00, var_01) {
  foreach(var_04, var_03 in var_00) {
    if(var_04 == var_01)
      return 1;
  }

  return 0;
}

_meth_806B() {
  var_00 = self.origin + (0, 0, 10);
  var_01 = 11;
  var_02 = anglestoforward(self.angles);
  var_02 = var_02 * var_01;
  var_3[0] = var_00 + var_02;
  var_3[1] = var_00;
  var_04 = bullettrace(var_3[0], var_3[0] + (0, 0, -18), 0, undefined);

  if(var_4["fraction"] < 1) {
    var_05 = spawnstruct();
    var_5.origin = var_4["position"];
    var_5.angles = func_C706(var_4["normal"]);
    return var_05;
  }

  var_04 = bullettrace(var_3[1], var_3[1] + (0, 0, -18), 0, undefined);

  if(var_4["fraction"] < 1) {
    var_05 = spawnstruct();
    var_5.origin = var_4["position"];
    var_5.angles = func_C706(var_4["normal"]);
    return var_05;
  }

  var_3[2] = var_00 + (16, 16, 0);
  var_3[3] = var_00 + (16, -16, 0);
  var_3[4] = var_00 + (-16, -16, 0);
  var_3[5] = var_00 + (-16, 16, 0);
  var_06 = undefined;
  var_07 = undefined;

  for (var_08 = 0; var_08 < var_3.size; var_8++) {
    var_04 = bullettrace(var_3[var_08], var_3[var_08] + (0, 0, -1000), 0, undefined);

    if(!isdefined(var_06) || var_4["fraction"] < var_06) {
      var_06 = var_4["fraction"];
      var_07 = var_4["position"];
    }
  }

  if(var_06 == 1)
    var_07 = self.origin;

  var_05 = spawnstruct();
  var_5.origin = var_07;
  var_5.angles = func_C706(var_4["normal"]);
  return var_05;
}

func_C706(var_00) {
  var_01 = (var_0[0], var_0[1], 0);
  var_02 = length(var_01);

  if(!var_02)
    return (0, 0, 0);

  var_03 = vectornormalize(var_01);
  var_04 = var_0[2] * -1;
  var_05 = (var_3[0] * var_04, var_3[1] * var_04, var_02);
  var_06 = vectortoangles(var_05);
  return var_06;
}

func_51CD(var_00) {
  var_01 = getentarray(var_00, "classname");

  for (var_02 = 0; var_02 < var_1.size; var_2++)
    var_1[var_02] delete();
}

playsoundonplayers(var_00, var_01, var_02) {
  if(level.splitscreen) {
    if(isdefined(level.players[0]))
      level.players[0] playlocalsound(var_00);
  } else if(isdefined(var_01)) {
    if(isdefined(var_02)) {
      for (var_03 = 0; var_03 < level.players.size; var_3++) {
        var_04 = level.players[var_03];

        if(var_04 issplitscreenplayer() && !var_04 isreloading()) {
          continue;
        }
        if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_01 && !isexcluded(var_04, var_02))
          var_04 playlocalsound(var_00);
      }

      return;
    }

    for (var_03 = 0; var_03 < level.players.size; var_3++) {
      var_04 = level.players[var_03];

      if(var_04 issplitscreenplayer() && !var_04 isreloading()) {
        continue;
      }
      if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_01)
        var_04 playlocalsound(var_00);
    }

    return;
  } else if(isdefined(var_02)) {
    for (var_03 = 0; var_03 < level.players.size; var_3++) {
      if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] isreloading()) {
        continue;
      }
      if(!isexcluded(level.players[var_03], var_02))
        level.players[var_03] playlocalsound(var_00);
    }
  } else {
    for (var_03 = 0; var_03 < level.players.size; var_3++) {
      if(level.players[var_03] issplitscreenplayer() && !level.players[var_03] isreloading()) {
        continue;
      }
      level.players[var_03] playlocalsound(var_00);
    }
  }
}

sortlowermessages() {
  for (var_00 = 1; var_00 < self.lowermessages.size; var_0++) {
    var_01 = self.lowermessages[var_00];
    var_02 = var_1.priority;

    for (var_03 = var_00 - 1; var_03 >= 0 && var_02 > self.lowermessages[var_03].priority; var_3--)
      self.lowermessages[var_03 + 1] = self.lowermessages[var_03];

    self.lowermessages[var_03 + 1] = var_01;
  }
}

addlowermessage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  var_10 = undefined;

  foreach(var_12 in self.lowermessages) {
    if(var_12.name == var_00) {
      if(var_12.text == var_01 && var_12.priority == var_03) {
        return;
      }
      var_10 = var_12;
      break;
    }
  }

  if(!isdefined(var_10)) {
    var_10 = spawnstruct();
    self.lowermessages[self.lowermessages.size] = var_10;
  }

  var_10.name = var_00;
  var_10.text = var_01;
  var_10.time = var_02;
  var_10.addtime = gettime();
  var_10.priority = var_03;
  var_10.showtimer = var_04;
  var_10.shouldfade = var_05;
  var_10.fadetoalpha = var_06;
  var_10.fadetoalphatime = var_07;
  var_10.hidewhenindemo = var_08;
  var_10.hidewheninmenu = var_09;
  sortlowermessages();
}

removelowermessage(var_00) {
  if(isdefined(self.lowermessages)) {
    for (var_01 = self.lowermessages.size; var_01 > 0; var_1--) {
      if(self.lowermessages[var_01 - 1].name != var_00) {
        continue;
      }
      var_02 = self.lowermessages[var_01 - 1];

      for (var_03 = var_01; var_03 < self.lowermessages.size; var_3++) {
        if(isdefined(self.lowermessages[var_03]))
          self.lowermessages[var_03 - 1] = self.lowermessages[var_03];
      }

      self.lowermessages[self.lowermessages.size - 1] = undefined;
    }

    sortlowermessages();
  }
}

getlowermessage() {
  if(!isdefined(self.lowermessages))
    return undefined;

  return self.lowermessages[0];
}

setlowermessage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isdefined(var_03))
    var_03 = 1;

  if(!isdefined(var_02))
    var_02 = 0;

  if(!isdefined(var_04))
    var_04 = 0;

  if(!isdefined(var_05))
    var_05 = 0;

  if(!isdefined(var_06))
    var_06 = 0.85;

  if(!isdefined(var_07))
    var_07 = 3.0;

  if(!isdefined(var_08))
    var_08 = 0;

  if(!isdefined(var_09))
    var_09 = 1;

  addlowermessage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  updatelowermessage();
}

updatelowermessage() {
  if(!isdefined(self)) {
    return;
  }
  var_00 = getlowermessage();

  if(!isdefined(var_00)) {
    if(isdefined(self.lowermessage) && isdefined(self.lowertimer)) {
      self.lowermessage.alpha = 0;
      self.lowertimer.alpha = 0;
    }
  } else {
    self.lowermessage give_zap_perk(var_0.text);
    self.lowermessage.alpha = 0.85;
    self.lowertimer.alpha = 1;
    self.lowermessage.hidewhenindemo = var_0.hidewhenindemo;
    self.lowermessage.hidewheninmenu = var_0.hidewheninmenu;

    if(var_0.shouldfade) {
      self.lowermessage fadeovertime(min(var_0.fadetoalphatime, 60));
      self.lowermessage.alpha = var_0.fadetoalpha;
    }

    if(var_0.time > 0 && var_0.showtimer)
      self.lowertimer settimer(max(var_0.time - (gettime() - var_0.addtime) / 1000, 0.1));
    else {
      if(var_0.time > 0 && !var_0.showtimer) {
        self.lowertimer give_zap_perk("");
        self.lowermessage fadeovertime(min(var_0.time, 60));
        self.lowermessage.alpha = 0;
        thread clearondeath(var_00);
        thread clearafterfade(var_00);
        return;
      }

      self.lowertimer give_zap_perk("");
    }
  }
}

clearondeath(var_00) {
  self notify("message_cleared");
  self endon("message_cleared");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  clearlowermessage(var_0.name);
}

clearafterfade(var_00) {
  wait(var_0.time);
  clearlowermessage(var_0.name);
  self notify("message_cleared");
}

clearlowermessage(var_00) {
  removelowermessage(var_00);
  updatelowermessage();
}

clearlowermessages() {
  for (var_00 = 0; var_00 < self.lowermessages.size; var_0++)
    self.lowermessages[var_00] = undefined;

  if(!isdefined(self.lowermessage)) {
    return;
  }
  updatelowermessage();
}

func_D917(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(var_3.team != var_01) {
      continue;
    }
    var_03 iprintln(var_00);
  }
}

func_D90E(var_00, var_01) {
  for (var_02 = 0; var_02 < level.players.size; var_2++) {
    var_03 = level.players[var_02];

    if(isdefined(var_3.pers["team"]) && var_3.pers["team"] == var_01)
      var_03 iprintlnbold(var_00);
  }
}

func_D90F(var_00, var_01, var_02) {
  for (var_03 = 0; var_03 < level.players.size; var_3++) {
    var_04 = level.players[var_03];

    if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_01)
      var_04 iprintlnbold(var_00, var_02);
  }
}

func_D918(var_00, var_01, var_02) {
  for (var_03 = 0; var_03 < level.players.size; var_3++) {
    var_04 = level.players[var_03];

    if(isdefined(var_4.pers["team"]) && var_4.pers["team"] == var_01)
      var_04 iprintln(var_00, var_02);
  }
}

func_D916(var_00, var_01) {
  var_02 = level.players;

  for (var_03 = 0; var_03 < var_2.size; var_3++) {
    if(isdefined(var_01)) {
      if(isdefined(var_2[var_03].pers["team"]) && var_2[var_03].pers["team"] == var_01)
        var_2[var_03] iprintln(var_00);

      continue;
    }

    var_2[var_03] iprintln(var_00);
  }
}

printandsoundoneveryone(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = isdefined(var_04);
  var_08 = 0;

  if(isdefined(var_05))
    var_08 = 1;

  if(level.splitscreen || !var_07) {
    for (var_09 = 0; var_09 < level.players.size; var_9++) {
      var_10 = level.players[var_09];
      var_11 = var_10.team;

      if(isdefined(var_11)) {
        if(var_11 == var_00 && isdefined(var_02)) {
          var_10 iprintln(var_02, var_06);
          continue;
        }

        if(var_11 == var_01 && isdefined(var_03))
          var_10 iprintln(var_03, var_06);
      }
    }

    if(var_07)
      level.players[0] playlocalsound(var_04);
  } else if(var_08) {
    for (var_09 = 0; var_09 < level.players.size; var_9++) {
      var_10 = level.players[var_09];
      var_11 = var_10.team;

      if(isdefined(var_11)) {
        if(var_11 == var_00) {
          if(isdefined(var_02))
            var_10 iprintln(var_02, var_06);

          var_10 playlocalsound(var_04);
          continue;
        }

        if(var_11 == var_01) {
          if(isdefined(var_03))
            var_10 iprintln(var_03, var_06);

          var_10 playlocalsound(var_05);
        }
      }
    }
  } else {
    for (var_09 = 0; var_09 < level.players.size; var_9++) {
      var_10 = level.players[var_09];
      var_11 = var_10.team;

      if(isdefined(var_11)) {
        if(var_11 == var_00) {
          if(isdefined(var_02))
            var_10 iprintln(var_02, var_06);

          var_10 playlocalsound(var_04);
          continue;
        }

        if(var_11 == var_01) {
          if(isdefined(var_03))
            var_10 iprintln(var_03, var_06);
        }
      }
    }
  }
}

func_D90D(var_00, var_01, var_02) {
  foreach(var_04 in level.players) {
    if(var_4.team != var_00) {
      continue;
    }
    var_04 func_D90C(var_01, var_02);
  }
}

func_D90C(var_00, var_01) {
  self iprintln(var_00);
  self playlocalsound(var_01);
}

func_13A7(var_00) {
  if(level.splitscreen && self getentitynumber() != 0) {
    return;
  }
  self playlocalsound(var_00);
}

dvarintvalue(var_00, var_01, var_02, var_03) {
  var_00 = "scr_" + level.gametype + "_" + var_00;

  if(getdvar(var_00) == "") {
    setdvar(var_00, var_01);
    return var_01;
  }

  var_04 = getdvarint(var_00);

  if(var_04 > var_03)
    var_04 = var_03;
  else if(var_04 < var_02)
    var_04 = var_02;
  else
    return var_04;

  setdvar(var_00, var_04);
  return var_04;
}

dvarfloatvalue(var_00, var_01, var_02, var_03) {
  var_00 = "scr_" + level.gametype + "_" + var_00;

  if(getdvar(var_00) == "") {
    setdvar(var_00, var_01);
    return var_01;
  }

  var_04 = getdvarfloat(var_00);

  if(var_04 > var_03)
    var_04 = var_03;
  else if(var_04 < var_02)
    var_04 = var_02;
  else
    return var_04;

  setdvar(var_00, var_04);
  return var_04;
}

play_sound_on_tag(var_00, var_01) {
  if(isdefined(var_01))
    playloopsound(self gettagorigin(var_01), var_00);
  else
    playloopsound(self.origin, var_00);
}

func_D526(var_00, var_01) {
  if(isdefined(var_01)) {
    playloopsound(var_01, var_00);
    var_02 = lookupsoundlength(var_00) / 1000;
    wait(var_02);
    return;
  } else {
    self playsound(var_00);
    var_02 = lookupsoundlength(var_00) / 1000;
    wait(var_02);
    return;
  }
}

getotherteam(var_00) {
  if(level.multiteambased) {}

  if(var_00 == "allies")
    return "axis";
  else if(var_00 == "axis")
    return "allies";
  else
    return "none";
}

func_1359E(var_00, var_01, var_02, var_03) {
  self endon(var_01);

  if(isdefined(var_02))
    self endon(var_02);

  if(isdefined(var_03))
    self endon(var_03);

  wait(var_00);
}

initpersstat(var_00) {
  if(!isdefined(self.pers[var_00]))
    self.pers[var_00] = 0;
}

getpersstat(var_00) {
  return self.pers[var_00];
}

incperstat(var_00, var_01, var_02) {
  if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers[var_00])) {
    self.pers[var_00] = self.pers[var_00] + var_01;

    if(!isdefined(var_02) || var_02 == 0)
      scripts\mp\persistence::statadd(var_00, var_01);
  }
}

func_F7DF(var_00, var_01) {
  self.pers[var_00] = var_01;
}

updatepersratio(var_00, var_01, var_02, var_03) {
  if(isdefined(var_03) || !rankingenabled()) {
    return;
  }
  var_04 = scripts\mp\persistence::statget(var_01);
  var_05 = scripts\mp\persistence::statget(var_02);

  if(var_05 == 0)
    var_05 = 1;

  scripts\mp\persistence::func_10E54(var_00, int(var_04 * 1000 / var_05));
}

func_12EE9(var_00, var_01, var_02) {
  if(!rankingenabled()) {
    return;
  }
  var_03 = scripts\mp\persistence::statgetbuffered(var_01);
  var_04 = scripts\mp\persistence::statgetbuffered(var_02);

  if(var_04 == 0)
    var_04 = 1;

  scripts\mp\persistence::func_10E55(var_00, int(var_03 * 1000 / var_04));
}

func_13842(var_00) {
  if(level.func_A9F1 == gettime()) {
    if(isdefined(var_00) && var_00) {
      while (level.func_A9F1 == gettime())
        wait 0.05;
    } else {
      wait 0.05;

      if(level.func_A9F1 == gettime()) {
        wait 0.05;

        if(level.func_A9F1 == gettime()) {
          wait 0.05;

          if(level.func_A9F1 == gettime())
            wait 0.05;
        }
      }
    }
  }

  level.func_A9F1 = gettime();
}

waitfortimeornotify(var_00, var_01) {
  self endon(var_01);
  wait(var_00);
}

isexcluded(var_00, var_01) {
  for (var_02 = 0; var_02 < var_1.size; var_2++) {
    if(var_00 == var_1[var_02])
      return 1;
  }

  return 0;
}

leaderdialog(var_00, var_01, var_02, var_03, var_04) {
  if(!isdefined(game["dialog"][var_00])) {
    return;
  }
  if(level.teambased && !isdefined(var_01)) {
    return;
  }
  for (var_05 = 0; var_05 < level.players.size; var_5++) {
    var_06 = level.players[var_05];

    if(isdefined(var_03) && isexcluded(var_06, var_03)) {
      continue;
    }
    if(var_06 issplitscreenplayer() && !var_06 isreloading()) {
      continue;
    }
    if(level.teambased && (!isdefined(var_6.pers["team"]) || var_6.pers["team"] != var_01)) {
      continue;
    }
    var_06 leaderdialogonplayer_internal(var_00, var_02, undefined, var_04);
  }
}

func_98D3() {
  level.func_AA1D["allies"] = 0;
  level.func_AA1D["axis"] = 0;
}

statusdialog(var_00, var_01, var_02) {
  if(istrue(level.gameended)) {
    return;
  }
  var_03 = gettime();

  if(gettime() < level.func_AA1D[var_01] + 5000 && (!isdefined(var_02) || !var_02)) {
    return;
  }
  thread func_5100(var_00, var_01);
  level.func_AA1D[var_01] = gettime();
}

func_5100(var_00, var_01) {
  level endon("game_ended");
  wait 0.1;
  func_13842();
  leaderdialog(var_00, var_01);
}

leaderdialogonplayers(var_00, var_01, var_02, var_03) {
  foreach(var_05 in var_01)
  var_05 leaderdialogonplayer(var_00, var_02, undefined, var_03);
}

leaderdialogonplayer(var_00, var_01, var_02, var_03, var_04) {
  if(!isdefined(game["dialog"][var_00])) {
    return;
  }
  leaderdialogonplayer_internal(var_00, var_01, var_02, var_03, var_04);
}

leaderdialogonplayer_internal(var_00, var_01, var_02, var_03, var_04) {
  if(isdefined(var_04)) {
    var_04 = var_04 * 1000;

    if(gettime() < self.func_AA1D["time"] + var_04 && self.func_AA1D["dialog"] == var_00) {
      return;
    }
    self.func_AA1D["time"] = gettime();
    self.func_AA1D["dialog"] = var_00;
  }

  var_05 = self.pers["team"];

  if(isdefined(var_05) && (var_05 == "axis" || var_05 == "allies")) {
    var_06 = self getrankedplayerdata("common", "mp_announcer_type");

    if(var_06 > 0) {
      var_07 = _tablelookupistringbyrow("mp\announcervoicedata.csv", var_06, 3);
      var_08 = var_07 + "_1mc_" + game["dialog"][var_00];
    } else
      var_08 = game["voice"][var_05] + "1mc_" + game["dialog"][var_00];

    var_08 = tolower(var_08);
    self _meth_8252(var_08, var_00, 2, var_01, var_02, var_03);
  }
}

func_98D4() {
  self.func_AA1D["time"] = 0;
  self.func_AA1D["dialog"] = "";
}

func_D4B7(var_00) {
  var_01 = self.team;
  var_02 = [self];
  var_03 = self getteamvoiceprefix();

  if(isdefined(var_03))
    var_2[var_2.size] = var_03;

  func_C638(var_00 + "_use");

  if(level.teambased) {
    leaderdialog(var_01 + "_friendly_" + var_00 + "_inbound", var_01, undefined, var_02);

    if(func_7F40(var_00))
      leaderdialog(var_01 + "_enemy_" + var_00 + "_inbound", level.otherteam[var_01], undefined, var_02);
  } else if(func_7F40(var_00))
    leaderdialog(var_01 + "_enemy_" + var_00 + "_inbound", undefined, undefined, var_02);
}

playkillstreakdialogonplayer(var_00, var_01, var_02, var_03) {
  if(level.showingfinalkillcam) {
    return;
  }
  var_00 = getbasekillstreakdialog(var_00);

  if(!isdefined(game["dialog"][var_00])) {
    return;
  }
  var_04 = game["dialog"][var_00];

  if(issubstr(var_04, "op_" + var_00) || var_04 == "op_" + var_00)
    func_C638(var_00, var_01, var_02, var_03);
  else
    leaderdialogonplayer(var_00, var_01, var_02, var_03);
}

getbasekillstreakdialog(var_00) {
  var_01 = strtok(var_00, "_");
  var_02 = undefined;

  foreach(var_06, var_04 in var_01) {
    if(!isdefined(var_02))
      var_02 = var_04;
    else
      var_02 = var_02 + var_04;

    var_05 = var_1[var_06 + 1];

    if(isdefined(var_05)) {
      if(var_05 == "rare" || var_05 == "legend" || var_05 == "epic") {
        break;
      } else
        var_02 = var_02 + "_";
    }
  }

  return var_02;
}

func_C638(var_00, var_01, var_02, var_03) {
  if(!isdefined(game["dialog"][var_00])) {
    return;
  }
  var_04 = game["dialog"][var_00];
  self _meth_8252(var_04, var_00, 2, var_01, var_02, var_03);
}

func_7FEB() {
  for (var_00 = 0; var_00 < self.leaderdialogqueue.size; var_0++) {
    if(issubstr(self.leaderdialogqueue[var_00], "losing")) {
      if(self.team == "allies") {
        if(issubstr(level.axiscapturing, self.leaderdialogqueue[var_00]))
          return self.leaderdialogqueue[var_00];
        else
          scripts\engine\utility::array_remove(self.leaderdialogqueue, self.leaderdialogqueue[var_00]);
      } else if(issubstr(level.alliescapturing, self.leaderdialogqueue[var_00]))
        return self.leaderdialogqueue[var_00];
      else
        scripts\engine\utility::array_remove(self.leaderdialogqueue, self.leaderdialogqueue[var_00]);

      continue;
    }

    return level.alliescapturing[self.leaderdialogqueue];
  }
}

func_C6E4() {
  self endon("disconnect");
  var_00 = [];
  var_00 = self.leaderdialogqueue;

  for (var_01 = 0; var_01 < self.leaderdialogqueue.size; var_1++) {
    if(issubstr(self.leaderdialogqueue[var_01], "losing")) {
      for (var_02 = var_01; var_02 >= 0; var_2--) {
        if(!issubstr(self.leaderdialogqueue[var_02], "losing") && var_02 != 0) {
          continue;
        }
        if(var_02 != var_01) {
          func_22DB(var_00, self.leaderdialogqueue[var_01], var_02);
          scripts\engine\utility::array_remove(var_00, self.leaderdialogqueue[var_01]);
          break;
        }
      }
    }
  }

  self.leaderdialogqueue = var_00;
}

updatemainmenu() {
  if(self.pers["team"] == "spectator")
    self setclientdvar("g_scriptMainMenu", game["menu_team"]);
  else
    self setclientdvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}

updateobjectivetext() {
  if(self.pers["team"] == "spectator")
    self setclientdvar("cg_objectiveText", "");
  else {
    if(level.roundscorelimit > 0 && !isobjectivebased()) {
      if(isdefined(getobjectivescoretext(self.pers["team"]))) {
        if(level.splitscreen) {
          self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]));
          return;
        }

        self setclientdvar("cg_objectiveText", getobjectivescoretext(self.pers["team"]), level.roundscorelimit);
        return;
        return;
      }

      return;
    }

    if(isdefined(getobjectivetext(self.pers["team"])))
      self setclientdvar("cg_objectiveText", getobjectivetext(self.pers["team"]));
  }
}

setobjectivetext(var_00, var_01) {
  game["strings"]["objective_" + var_00] = var_01;
}

setobjectivescoretext(var_00, var_01) {
  game["strings"]["objective_score_" + var_00] = var_01;
}

setobjectivehinttext(var_00, var_01) {
  game["strings"]["objective_hint_" + var_00] = var_01;
}

getobjectivetext(var_00) {
  return game["strings"]["objective_" + var_00];
}

getobjectivescoretext(var_00) {
  return game["strings"]["objective_score_" + var_00];
}

getobjectivehinttext(var_00) {
  return game["strings"]["objective_hint_" + var_00];
}

gettimepassed() {
  if(!isdefined(level.starttime) || !isdefined(level.func_561F))
    return 0;

  if(level.func_1191F)
    return level.func_1191E - level.starttime - level.func_561F;
  else
    return gettime() - level.starttime - level.func_561F;
}

gettimepassedpercentage() {
  var_00 = gettimelimit();

  if(var_00 == 0)
    return 0;

  return gettimepassed() / (gettimelimit() * 60 * 1000) * 100;
}

getsecondspassed() {
  return gettimepassed() / 1000;
}

getminutespassed() {
  return getsecondspassed() / 60;
}

clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
}

isinkillcam() {
  if(isai(self))
    return 0;

  if(self.spectatekillcam) {
    if(self.forcespectatorclient == -1 && self.killcamentity == -1)
      return 0;
  }

  return self.spectatekillcam;
}

func_F8A0(var_00, var_01) {
  self endon("disconnect");

  if(!isdefined(self.func_6AB3))
    self.func_6AB3 = 0.0;

  if(self.func_6AB3 == var_00) {
    return;
  }
  if(isdefined(var_01))
    wait(var_01);

  self notify("setUIPostGameFade");
  self endon("setUIPostGameFade");

  if(self.func_6AB3 < var_00)
    self.func_6AB3 = clamp(self.func_6AB3 + 0.5 * abs(self.func_6AB3 - var_00), 0.0, 1.0);
  else
    self.func_6AB3 = clamp(self.func_6AB3 - 0.5 * abs(self.func_6AB3 - var_00), 0.0, 1.0);

  self setclientomnvar("ui_post_game_fade", self.func_6AB3);
  wait 0.1;
  self.func_6AB3 = var_00;
  self setclientomnvar("ui_post_game_fade", self.func_6AB3);
}

isvalidclass(var_00) {
  return isdefined(var_00) && var_00 != "";
}

makevehiclesolidcapsule(var_00, var_01, var_02) {
  if(var_00 > var_02)
    return var_02;
  else if(var_00 < var_01)
    return var_01;
  else
    return var_00;
}

func_136EE(var_00) {
  var_01 = gettime();
  var_02 = (gettime() - var_01) / 1000;

  if(var_02 < var_00) {
    wait(var_00 - var_02);
    return var_00;
  } else
    return var_02;
}

registerroundswitchdvar(var_00, var_01, var_02, var_03) {
  registerwatchdvarint("roundswitch", var_01);
  var_00 = "scr_" + var_00 + "_roundswitch";
  level.func_E766 = var_00;
  level.func_E768 = var_02;
  level.func_E767 = var_03;
  level.func_E765 = getdvarint(var_00, var_01);

  if(level.func_E765 < var_02)
    level.func_E765 = var_02;
  else if(level.func_E765 > var_03)
    level.func_E765 = var_03;
}

registerroundlimitdvar(var_00, var_01) {
  registerwatchdvarint("roundlimit", var_01);
}

func_DF03(var_00, var_01) {
  registerwatchdvarint("numTeams", var_01);
}

registerwinlimitdvar(var_00, var_01) {
  registerwatchdvarint("winlimit", var_01);
}

registerwinbytwoenableddvar(var_00, var_01) {
  registerwatchdvarint("winbytwoenabled", var_01);
}

registerwinbytwomaxroundsdvar(var_00, var_01) {
  registerwatchdvarint("winbytwomaxrounds", var_01);
}

registerdogtagsenableddvar(var_00, var_01) {
  registerwatchdvarint("dogtags", var_01);
}

registerscorelimitdvar(var_00, var_01) {
  registerwatchdvarint("scorelimit", var_01);
}

registertimelimitdvar(var_00, var_01) {
  registerwatchdvarfloat("timelimit", var_01);
  setdvar("ui_timelimit", gettimelimit());
}

registerhalftimedvar(var_00, var_01) {
  registerwatchdvarint("halftime", var_01);
  setdvar("ui_halftime", func_7EEF());
}

registernumlivesdvar(var_00, var_01) {
  registerwatchdvarint("numlives", var_01);
}

botgetworldsize(var_00, var_01) {
  return getdvarint(var_00, getdvarint(var_01));
}

_meth_803B(var_00, var_01) {
  return getdvarfloat(var_00, getdvarfloat(var_01));
}

func_F7D3(var_00) {
  setdvar("overtimeTimeLimit", var_00);
}

func_7920(var_00, var_01) {
  var_02 = spawnstruct();
  var_2.isplayer = 1;
  var_2.func_9D26 = 0;
  var_2.entity = var_00;
  var_2.damagecenter = var_01;
  return var_02;
}

func_7922(var_00, var_01) {
  var_02 = spawnstruct();
  var_2.isplayer = 0;
  var_2.func_9D26 = 0;
  var_2.issentry = 1;
  var_2.entity = var_00;
  var_2.damagecenter = var_01;
  return var_02;
}

func_791D(var_00, var_01) {
  var_02 = spawnstruct();
  var_2.isplayer = 0;
  var_2.func_9D26 = 0;
  var_2.entity = var_00;
  var_2.damagecenter = var_01;
  return var_02;
}

func_791F(var_00, var_01) {
  var_02 = spawnstruct();
  var_2.isplayer = 0;
  var_2.func_9D26 = 0;
  var_2.entity = var_00;
  var_2.damagecenter = var_01;
  return var_02;
}

func_7921(var_00) {
  return var_0.origin + (0, 0, 32);
}

getstancecenter() {
  if(self getstance() == "crouch")
    var_00 = self.origin + (0, 0, 24);
  else if(self getstance() == "prone")
    var_00 = self.origin + (0, 0, 10);
  else
    var_00 = self.origin + (0, 0, 32);

  return var_00;
}

func_791E(var_00) {
  return var_0.origin;
}

func_7E8A(var_00) {
  var_01 = getdvar(var_00);

  if(var_01 == "")
    return (0, 0, 0);

  var_02 = strtok(var_01, " ");

  if(var_2.size < 3)
    return (0, 0, 0);

  setdvar("tempR", var_2[0]);
  setdvar("tempG", var_2[1]);
  setdvar("tempB", var_2[2]);
  return (getdvarfloat("tempR"), getdvarfloat("tempG"), getdvarfloat("tempB"));
}

strip_suffix(var_00, var_01) {
  if(var_0.size <= var_1.size)
    return var_00;

  if(getsubstr(var_00, var_0.size - var_1.size, var_0.size) == var_01)
    return getsubstr(var_00, 0, var_0.size - var_1.size);

  return var_00;
}

func_141F(var_00) {
  var_01 = self getweaponslistall();

  foreach(var_03 in var_01) {
    if(var_03 == var_00)
      continue;
    else
      _takeweapon(var_03);
  }
}

_setactionslot(var_00, var_01, var_02) {
  self.saved_actionslotdata[var_00].type = var_01;
  self.saved_actionslotdata[var_00].item = var_02;
  self setactionslot(var_00, var_01, var_02);
}

isfloat(var_00) {
  if(int(var_00) != var_00)
    return 1;

  return 0;
}

registerwatchdvarint(var_00, var_01) {
  var_02 = "scr_" + level.gametype + "_" + var_00;
  level.func_13A08[var_02] = spawnstruct();
  level.func_13A08[var_02].value = getdvarint(var_02, var_01);
  level.func_13A08[var_02].type = "int";
  level.func_13A08[var_02].func_C174 = "update_" + var_00;
}

registerwatchdvarfloat(var_00, var_01) {
  var_02 = "scr_" + level.gametype + "_" + var_00;
  level.func_13A08[var_02] = spawnstruct();
  level.func_13A08[var_02].value = getdvarfloat(var_02, var_01);
  level.func_13A08[var_02].type = "float";
  level.func_13A08[var_02].func_C174 = "update_" + var_00;
}

registerwatchdvar(var_00, var_01) {
  var_02 = "scr_" + level.gametype + "_" + var_00;
  level.func_13A08[var_02] = spawnstruct();
  level.func_13A08[var_02].value = getdvar(var_02, var_01);
  level.func_13A08[var_02].type = "string";
  level.func_13A08[var_02].func_C174 = "update_" + var_00;
}

setoverridewatchdvar(var_00, var_01) {
  var_00 = "scr_" + level.gametype + "_" + var_00;
  level.func_C827[var_00] = var_01;
}

getwatcheddvar(var_00) {
  var_00 = "scr_" + level.gametype + "_" + var_00;

  if(isdefined(level.func_C827) && isdefined(level.func_C827[var_00]))
    return level.func_C827[var_00];

  return level.func_13A08[var_00].value;
}

func_12F5B() {
  while (game["state"] == "playing") {
    var_00 = getarraykeys(level.func_13A08);

    foreach(var_02 in var_00) {
      if(level.func_13A08[var_02].type == "string")
        var_03 = _meth_80A2(var_02, level.func_13A08[var_02].value);
      else if(level.func_13A08[var_02].type == "float")
        var_03 = func_7EBF(var_02, level.func_13A08[var_02].value);
      else
        var_03 = getintproperty(var_02, level.func_13A08[var_02].value);

      if(var_03 != level.func_13A08[var_02].value) {
        level.func_13A08[var_02].value = var_03;
        level notify(level.func_13A08[var_02].func_C174, var_03);
      }
    }

    wait 1.0;
  }
}

isroundbased() {
  if(!level.teambased)
    return 0;

  if(level.winlimit != 1 && level.roundlimit != 1)
    return 1;

  if(level.gametype == "sr" || level.gametype == "sd" || level.gametype == "siege")
    return 1;

  return 0;
}

func_9DF6() {
  if(!level.teambased)
    return 1;

  if(level.roundlimit > 1 && game["roundsPlayed"] == 0)
    return 1;

  if(level.winlimit > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0)
    return 1;

  return 0;
}

nextroundisfinalround() {
  if(level.func_72B3)
    return 1;

  if(!level.teambased)
    return 1;

  if(level.roundlimit > 1 && game["roundsPlayed"] >= level.roundlimit - 1 && !istimetobeatrulegametype())
    return 1;

  if(func_9ECF() && (hitroundlimit() || hitwinlimit())) {
    if(shouldplaywinbytwo() && islastwinbytwo())
      return 1;
    else if(istimetobeatrulegametype()) {
      if(game["overtimeRoundsPlayed"] == 1)
        return 1;
    } else if(!level.playovertime)
      return 1;
  }

  var_00 = level.winlimit > 0 && (getroundswon("allies") == level.winlimit - 1 || getroundswon("axis") == level.winlimit - 1);
  var_01 = abs(getroundswon("allies") - getroundswon("axis"));

  if(var_00 && var_01 == 0) {
    if(func_9ECF())
      return 0;
    else
      return 1;
  }

  return 0;
}

wasonlyround() {
  if(level.playovertime)
    return 0;

  if(!level.teambased)
    return 1;

  if(isdefined(level.onlyroundoverride))
    return 0;

  if(level.winlimit == 1 && hitwinlimit())
    return 1;

  if(level.roundlimit == 1)
    return 1;

  return 0;
}

waslastround() {
  if(level.func_72B3)
    return 1;

  if(wasonlyround())
    return 1;

  if(!level.teambased)
    return 1;

  if(hitroundlimit() || hitwinlimit())
    return !level.playovertime;

  return 0;
}

iswinbytworulegametype() {
  switch (level.gametype) {
    case "siege":
    case "sd":
    case "sr":
      return getdvarint("scr_" + level.gametype + "_winByTwoEnabled", 0) == 1;
  }

  return 0;
}

getmaxwinbytworounds() {
  return getdvarint("scr_" + level.gametype + "_winByTwoMaxRounds", level.winlimit);
}

shouldplaywinbytwo() {
  var_00 = game["roundsWon"]["allies"];
  var_01 = game["roundsWon"]["axis"];
  return iswinbytworulegametype() && abs(var_00 - var_01) < 2 && game["overtimeRoundsPlayed"] < getmaxwinbytworounds();
}

islastwinbytwo() {
  return shouldplaywinbytwo() && game["overtimeRoundsPlayed"] == getmaxwinbytworounds() - 1;
}

istimetobeatrulegametype() {
  switch (level.gametype) {
    case "ball":
    case "ctf":
      return 1;
  }

  return 0;
}

settimetobeat(var_00) {
  if(!istimetobeatrulegametype())
    return 0;

  var_01 = getsecondspassed();
  var_02 = scripts\mp\gamescore::_getteamscore(var_00);

  if(!istimetobeatvalid() || var_01 < game["timeToBeat"] && var_02 >= game["timeToBeatScore"]) {
    if(game["timeToBeatTeam"] != "none" && game["timeToBeatTeam"] != var_00)
      game["timeToBeatOld"] = game["timeToBeat"];

    game["timeToBeat"] = var_01;
    game["timeToBeatTeam"] = var_00;
    game["timeToBeatScore"] = var_02;
    return 1;
  }

  return 0;
}

istimetobeatvalid() {
  return game["timeToBeat"] != 0;
}

forceplaytimetobeat() {
  return isgamebattlematch() && game["timeToBeat"] == 0;
}

func_1005B() {
  return istimetobeatvalid() && game["overtimeRoundsPlayed"] == 1 || forceplaytimetobeat() && game["overtimeRoundsPlayed"] > 1;
}

func_9ECF() {
  if(isgamebattlematch())
    return 1;

  switch (level.gametype) {
    case "ball":
    case "ctf":
      return 1;
    case "dd":
    case "siege":
    case "sd":
    case "sr":
      return iswinbytworulegametype();
  }

  return 0;
}

func_7F9C() {
  if(isgamebattlematch())
    return -1;

  var_00 = 0;

  switch (level.gametype) {
    case "ball":
    case "ctf":
    case "siege":
    case "sd":
    case "sr":
      var_00 = 2;
      break;
    case "dd":
      var_00 = 1;
      break;
  }

  if(isanymlgmatch() && !istimetobeatrulegametype())
    return -1;

  return var_00;
}

getwingamebytype() {
  if(!isdefined(level.wingamebytype)) {
    if(!isroundbased() || !isobjectivebased() || ismoddedroundgame())
      level.wingamebytype = "teamScores";
    else
      level.wingamebytype = "roundsWon";
  }

  return level.wingamebytype;
}

issimultaneouskillenabled() {
  if(!isdefined(level.simultaneouskillenabled))
    level.simultaneouskillenabled = getdvarint("killswitch_simultaneous_deaths", 0) == 0;

  if(isgamebattlematch())
    level.simultaneouskillenabled = 0;

  return level.simultaneouskillenabled;
}

cantiebysimultaneouskill() {
  if(!issimultaneouskillenabled())
    return 0;

  var_00 = 0;

  switch (level.gametype) {
    case "gun":
    case "front":
    case "dm":
    case "war":
      var_00 = 1;
  }

  return var_00;
}

func_1004B() {
  if(!hitroundlimit() && !hitwinlimit())
    return 0;

  if(!func_9ECF())
    return 0;

  var_00 = getwingamebytype();
  var_01 = game[var_00]["allies"];
  var_02 = game[var_00]["axis"];
  var_03 = var_01 == var_02;

  if(var_03 && inovertime()) {
    var_04 = func_7F9C();
    var_03 = scripts\engine\utility::ter_op(var_04 == -1, 1, game["overtimeRoundsPlayed"] < var_04);
  }

  var_05 = shouldplaywinbytwo();
  var_06 = func_1005B();

  if(isgamebattlematch() && istimetobeatrulegametype() && !var_06)
    var_03 = 0;

  return !level.func_72B3 && (var_03 || var_05 || var_06);
}

func_E269() {
  return level.gametype == "ctf" && !inovertime() && getwingamebytype() == "roundsWon";
}

func_38F3() {
  if(!isdefined(level.didhalfscorevoboost))
    level.didhalfscorevoboost = 0;

  if(level.didhalfscorevoboost)
    return 0;

  switch (level.gametype) {
    case "tdef":
    case "koth":
    case "grnd":
    case "grind":
    case "dom":
    case "conf":
    case "front":
    case "dm":
    case "war":
    case "dd":
    case "ball":
      return 1;
    case "mp_zomb":
    case "infect":
    case "gun":
    case "ctf":
    case "siege":
    case "sd":
    case "sr":
      return 0;
    default:
      return 0;
  }
}

hittimelimit() {
  if(getwatcheddvar("timelimit") <= 0)
    return 0;

  var_00 = scripts\mp\gamelogic::gettimeremaining();

  if(var_00 > 0)
    return 0;

  return 1;
}

hitroundlimit() {
  if(level.roundlimit <= 0)
    return 0;

  return game["roundsPlayed"] >= level.roundlimit;
}

hitscorelimit() {
  if(isobjectivebased())
    return 0;

  if(level.roundscorelimit <= 0)
    return 0;

  if(level.teambased) {
    if(game["teamScores"]["allies"] >= level.roundscorelimit || game["teamScores"]["axis"] >= level.roundscorelimit)
      return 1;
  } else {
    for (var_00 = 0; var_00 < level.players.size; var_0++) {
      var_01 = level.players[var_00];

      if(isdefined(var_1.score) && var_1.score >= level.roundscorelimit)
        return 1;
    }
  }

  return 0;
}

hitwinlimit() {
  if(level.winlimit <= 0)
    return 0;

  if(!level.teambased)
    return 1;

  if(getroundswon("allies") >= level.winlimit || getroundswon("axis") >= level.winlimit)
    return 1;

  return 0;
}

getscorelimit() {
  if(isroundbased()) {
    if(level.roundlimit)
      return level.roundlimit;
    else
      return level.winlimit;
  } else
    return level.roundscorelimit;
}

getroundswon(var_00) {
  return game["roundsWon"][var_00];
}

isobjectivebased() {
  return level.objectivebased;
}

gettimelimit() {
  if(inovertime() && (!isdefined(game["inNukeOvertime"]) || !game["inNukeOvertime"])) {
    if(istrue(game["timeToBeat"]))
      return game["timeToBeat"] / 60;
    else {
      var_00 = getdvarfloat("overtimeTimeLimit");

      if(var_00 > 0)
        return var_00;
      else
        return getwatcheddvar("timelimit");
    }
  } else if(isdefined(level.extratime) && level.extratime > 0)
    return getwatcheddvar("timelimit") + level.extratime;
  else
    return getwatcheddvar("timelimit");
}

func_7EEF() {
  if(inovertime())
    return 0;
  else if(isdefined(game["inNukeOvertime"]) && game["inNukeOvertime"])
    return 0;
  else
    return getwatcheddvar("halftime");
}

inovertime() {
  return isdefined(game["status"]) && game["status"] == "overtime";
}

gamehasstarted() {
  if(isdefined(level.gamehasstarted))
    return level.gamehasstarted;

  if(level.teambased)
    return level.hasspawned["axis"] && level.hasspawned["allies"];

  return level.maxplayercount > 1;
}

func_7DEA(var_00) {
  var_01 = (0, 0, 0);

  if(!var_0.size)
    return undefined;

  foreach(var_03 in var_00)
  var_01 = var_01 + var_3.origin;

  var_05 = int(var_1[0] / var_0.size);
  var_06 = int(var_1[1] / var_0.size);
  var_07 = int(var_1[2] / var_0.size);
  var_01 = (var_05, var_06, var_07);
  return var_01;
}

getlivingplayers(var_00) {
  var_01 = [];

  foreach(var_03 in level.players) {
    if(!isalive(var_03)) {
      continue;
    }
    if(level.teambased && isdefined(var_00)) {
      if(var_00 == var_3.pers["team"])
        var_1[var_1.size] = var_03;

      continue;
    }

    var_1[var_1.size] = var_03;
  }

  return var_01;
}

setusingremote(var_00) {
  if(isdefined(self.carryicon))
    self.carryicon.alpha = 0;

  self.usingremote = var_00;
  scripts\engine\utility::allow_offhand_weapons(0);
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self playlocalsound("mp_killstreak_screen_start");
  self notify("using_remote");
}

_meth_80E8() {
  return self.usingremote;
}

freezecontrolswrapper(var_00, var_01) {
  if(!isdefined(self.pers)) {
    return;
  }
  if(!isdefined(self.pers["controllerFreezeStack"]))
    self.pers["controllerFreezeStack"] = 0;

  if(var_00)
    self.pers["controllerFreezeStack"]++;
  else if(scripts\engine\utility::is_true(var_01))
    self.pers["controllerFreezeStack"] = 0;
  else
    self.pers["controllerFreezeStack"]--;

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self getroundswon(0);
    self.controlsfrozen = 0;
  } else {
    self getroundswon(1);
    self.controlsfrozen = 1;
  }
}

clearusingremote(var_00) {
  if(isdefined(self.carryicon))
    self.carryicon.alpha = 1;

  self.usingremote = undefined;

  if(!isdefined(var_00)) {
    scripts\engine\utility::allow_offhand_weapons(1);
    freezecontrolswrapper(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self playlocalsound("mp_killstreak_screen_end");
  self notify("stopped_using_remote");
}

isusingremote() {
  return isdefined(self.usingremote);
}

istryingtousekillstreak() {
  return isdefined(self.tryingtousekillstreak);
}

func_DB8D(var_00) {
  if(!isdefined(level.func_DB95))
    level.func_DB95 = [];

  level.func_DB95[var_00] = [];
}

func_DB8B(var_00, var_01) {
  level.func_DB95[var_00][level.func_DB95[var_00].size] = var_01;
}

func_DB94(var_00) {
  var_01 = undefined;
  var_02 = [];

  foreach(var_04 in level.func_DB95[var_00]) {
    if(!isdefined(var_04)) {
      continue;
    }
    if(!isdefined(var_01)) {
      var_01 = var_04;
      continue;
    }

    var_2[var_2.size] = var_04;
  }

  level.func_DB95[var_00] = var_02;
  return var_01;
}

_giveweapon(var_00, var_01, var_02, var_03) {
  if(!isdefined(var_01))
    var_01 = -1;

  if(!isdefined(var_03))
    var_03 = 0;

  if(issubstr(var_00, "_akimbo") || isdefined(var_02) && var_02 == 1)
    self giveweapon(var_00, var_01, 1, -1, var_03);
  else
    self giveweapon(var_00, var_01, 0, -1, var_03);
}

_switchtoweapon(var_00) {
  func_4F5B("___ SwitchToWeapon() - " + var_00);
  self switchtoweapon(var_00);
}

_switchtoweaponimmediate(var_00) {
  func_4F5B("___ SwitchToWeaponImmediate() - " + var_00);
  self switchtoweaponimmediate(var_00);
}

_takeweapon(var_00) {
  if(self _meth_856D() == var_00)
    self _meth_8570(var_00);

  self giveuponsuppressiontime(var_00);
}

takeweaponwhensafe(var_00) {
  self endon("death");
  self endon("disconnect");

  for (;;) {
    if(!iscurrentweapon(var_00)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  _takeweapon(var_00);
}

perksenabled() {
  return level.allowperks;
}

_hasperk(var_00) {
  return isdefined(self.perks) && isdefined(self.perks[var_00]);
}

giveperk(var_00) {
  scripts\mp\perks::_setperk(var_00);
  scripts\mp\perks::_setextraperks(var_00);
}

removeperk(var_00) {
  scripts\mp\perks::_unsetperk(var_00);
  scripts\mp\perks::func_142F(var_00);
}

blockperkfunction(var_00) {
  if(!isdefined(self.perksblocked[var_00]))
    self.perksblocked[var_00] = 1;
  else
    self.perksblocked[var_00]++;

  if(self.perksblocked[var_00] == 1 && _hasperk(var_00)) {
    scripts\mp\perks::func_1431(var_00);

    foreach(var_06, var_02 in level.extraperkmap) {
      if(var_00 == var_06) {
        foreach(var_04 in var_02) {
          if(!isdefined(self.perksblocked[var_04]))
            self.perksblocked[var_04] = 1;
          else
            self.perksblocked[var_04]++;

          if(self.perksblocked[var_04] == 1)
            scripts\mp\perks::func_1431(var_04);
        }

        break;
      }
    }
  }
}

unblockperkfunction(var_00) {
  self.perksblocked[var_00]--;

  if(self.perksblocked[var_00] == 0) {
    self.perksblocked[var_00] = undefined;

    if(_hasperk(var_00)) {
      scripts\mp\perks::func_13D2(var_00);

      foreach(var_06, var_02 in level.extraperkmap) {
        if(var_00 == var_06) {
          foreach(var_04 in var_02) {
            self.perksblocked[var_04]--;

            if(self.perksblocked[var_04] == 0) {
              scripts\mp\perks::func_13D2(var_04);
              self.perksblocked[var_04] = undefined;
            }
          }

          break;
        }
      }
    }
  }
}

quicksort(var_00, var_01) {
  return func_DBA1(var_00, 0, var_0.size - 1, var_01);
}

func_DBA1(var_00, var_01, var_02, var_03) {
  var_04 = var_01;
  var_05 = var_02;

  if(!isdefined(var_03))
    var_03 = ::func_DBA0;

  if(var_02 - var_01 >= 1) {
    var_06 = var_0[var_01];

    while (var_05 > var_04) {
      while ([
          [var_03]
        ](var_0[var_04], var_06) && var_04 <= var_02 && var_05 > var_04)
        var_4++;

      while (![
          [var_03]
        ](var_0[var_05], var_06) && var_05 >= var_01 && var_05 >= var_04)
        var_5--;

      if(var_05 > var_04)
        var_00 = func_11304(var_00, var_04, var_05);
    }

    var_00 = func_11304(var_00, var_01, var_05);
    var_00 = func_DBA1(var_00, var_01, var_05 - 1, var_03);
    var_00 = func_DBA1(var_00, var_05 + 1, var_02, var_03);
  } else
    return var_00;

  return var_00;
}

func_DBA0(var_00, var_01) {
  return var_00 <= var_01;
}

func_11304(var_00, var_01, var_02) {
  var_03 = var_0[var_01];
  var_0[var_01] = var_0[var_02];
  var_0[var_02] = var_03;
  return var_00;
}

_suicide() {
  if(isusingremote() && !isdefined(self.fauxdeath))
    thread scripts\mp\damage::playerkilled_internal(self, self, self, 10000, 0, "MOD_SUICIDE", "none", (0, 0, 0), "none", 0, 1116, 1);
  else if(!isusingremote() && !isdefined(self.fauxdeath))
    self suicide();
}

isreallyalive(var_00) {
  if(isalive(var_00) && !isdefined(var_0.fauxdeath))
    return 1;

  return 0;
}

waittill_any_timeout_pause_on_death_and_prematch(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = spawnstruct();

  if(isdefined(var_01))
    thread scripts\engine\utility::waittill_string_no_endon_death(var_01, var_06);

  if(isdefined(var_02))
    thread scripts\engine\utility::waittill_string_no_endon_death(var_02, var_06);

  if(isdefined(var_03))
    thread scripts\engine\utility::waittill_string_no_endon_death(var_03, var_06);

  if(isdefined(var_04))
    thread scripts\engine\utility::waittill_string_no_endon_death(var_04, var_06);

  if(isdefined(var_05))
    thread scripts\engine\utility::waittill_string_no_endon_death(var_05, var_06);

  var_06 thread func_1429(var_00, self);
  var_06 waittill("returned", var_07);
  var_06 notify("die");
  return var_07;
}

func_1429(var_00, var_01) {
  self endon("die");

  for (var_02 = 0.05; var_00 > 0; var_00 = var_00 - var_02) {
    if(isplayer(var_01) && !isreallyalive(var_01))
      var_01 waittill("spawned_player");

    if(getomnvar("ui_prematch_period"))
      level waittill("prematch_over");

    wait(var_02);
  }

  self notify("returned", "timeout");
}

playdeathsound() {
  var_00 = randomintrange(1, 8);
  var_01 = "generic";

  if(isfemale())
    var_01 = "female";

  if(func_9D48("archetype_scout"))
    self playsound("c6_death_vox");
  else if(self.team == "axis")
    self playsound(var_01 + "_death_russian_" + var_00);
  else
    self playsound(var_01 + "_death_american_" + var_00);
}

rankingenabled() {
  if(!isplayer(self))
    return 0;

  return level.rankedmatch && !self.usingonlinedataoffline;
}

func_D957() {
  return level.onlinegame && getdvarint("xblive_privatematch");
}

lobbyteamselectenabled() {
  return getdvarint("systemlink") || func_D957() && getdvarint("lobby_team_select", 0);
}

matchmakinggame() {
  return level.onlinegame && !getdvarint("xblive_privatematch");
}

setaltsceneobj(var_00, var_01, var_02, var_03) {}

func_6383(var_00) {
  self endon("altscene");
  var_00 waittill("death");
  self notify("end_altScene");
}

getgametypenumlives() {
  return getwatcheddvar("numlives");
}

setturretminimapvisible(var_00) {
  self.combathigh = var_00;
}

func_22DB(var_00, var_01, var_02) {
  if(var_0.size != 0) {
    for (var_03 = var_0.size; var_03 >= var_02; var_3--)
      var_0[var_03 + 1] = var_0[var_03];
  }

  var_0[var_02] = var_01;
}

_meth_80A2(var_00, var_01) {
  var_02 = var_01;
  var_02 = getdvar(var_00, var_01);
  return var_02;
}

getintproperty(var_00, var_01) {
  var_02 = var_01;
  var_02 = getdvarint(var_00, var_01);
  return var_02;
}

func_7EBF(var_00, var_01) {
  var_02 = var_01;
  var_02 = getdvarfloat(var_00, var_01);
  return var_02;
}

func_A679(var_00) {
  if(var_00 == "venomxgun_mp" || var_00 == "venomxproj_mp")
    return 1;

  if(_hasperk("specialty_explosivebullets"))
    return 0;

  if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
    return 0;

  var_01 = self.pers["killstreaks"];

  if(isdefined(level.killstreakweildweapons[var_00]) && isdefined(self.streaktype) && self.streaktype != "support") {
    for (var_02 = 1; var_02 < 4; var_2++) {
      if(isdefined(var_1[var_02]) && isdefined(var_1[var_02].streakname) && var_1[var_02].streakname == level.killstreakweildweapons[var_00] && isdefined(var_1[var_02].lifeid) && var_1[var_02].lifeid == self.pers["deaths"])
        return streakstate(level.killstreakweildweapons[var_00]);
    }

    return 0;
  }

  return !iskillstreakweapon(var_00);
}

streakstate(var_00) {
  var_01 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_00);
  var_02 = scripts\mp\killstreaks\killstreaks::func_7FEE();
  var_03 = scripts\mp\killstreaks\killstreaks::getstreakcost(var_02);
  return var_01 < var_03;
}

func_9D48(var_00) {
  return isdefined(self.loadoutarchetype) && var_00 == self.loadoutarchetype;
}

isjuggernaut() {
  if(isdefined(self.isjuggernaut) && self.isjuggernaut == 1)
    return 1;

  if(isdefined(self.isjuggernautdef) && self.isjuggernautdef == 1)
    return 1;

  if(isdefined(self.isjuggernautgl) && self.isjuggernautgl == 1)
    return 1;

  if(isdefined(self.isjuggernautrecon) && self.isjuggernautrecon == 1)
    return 1;

  if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac == 1)
    return 1;

  if(isdefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom == 1)
    return 1;

  return 0;
}

_meth_8238(var_00) {
  if(!isdefined(var_00))
    return 0;

  if(isrc8weapon(var_00))
    return "killstreak";

  if(iscacprimaryweapon(var_00))
    return "primary";

  if(iscacsecondaryweapon(var_00))
    return "secondary";

  if(iskillstreakweapon(var_00))
    return "killstreak";

  if(scripts\mp\powers::func_9F0A(var_00))
    return "power";

  if(issuperweapon(var_00))
    return "super";

  if(func_9E0D(var_00))
    return "gamemode";

  if(isstrstart(var_00, "destructible_"))
    return "destructible";

  var_01 = getequipmenttype(var_00);

  if(isdefined(var_01))
    return var_01;

  if(var_00 == "none")
    return "worldspawn";

  if(var_00 == "bomb_site_mp")
    return var_00;

  if(isstrstart(var_00, "spaceship_"))
    return "spaceship";
}

getequipmenttype(var_00) {
  switch (var_00) {
    case "throwingknife_mp":
    case "wristrocket_proj_mp":
    case "power_exploding_drone_mp":
    case "split_grenade_mp":
    case "trip_mine_mp":
    case "power_spider_grenade_mp":
    case "wristrocket_mp":
    case "splash_grenade_mp":
    case "blackhole_grenade_mp":
    case "throwingknifec4_mp":
    case "cluster_grenade_mp":
    case "c4_mp":
      var_01 = "lethal";
      break;
    case "flare_mp":
    case "deployable_cover_mp":
    case "blackout_grenade_mp":
    case "trophy_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
    case "domeshield_mp":
    case "cryo_mine_mp":
      var_01 = "tactical";
      break;
    case "groundpound_mp":
    case "player_trophy_system_mp":
      var_01 = "trait";
      break;
    case "kineticpulse_emp_mp":
    case "kineticpulse_concuss_mp":
    case "kineticpulse_mp":
    case "super_trophy_mp":
    case "blackhat_mp":
    case "coneflash_mp":
    case "distortionfield_grenade_mp":
    case "fear_grenade_mp":
    case "virus_grenade_mp":
    case "ammo_box_mp":
    case "sonic_sensor_mp":
    case "transponder_mp":
    case "portal_generator_mp":
    case "forcepush_mp":
    case "speed_strip_mp":
    case "copycat_grenade_mp":
    case "adrenaline_mist_mp":
    case "proxy_bomb_mp":
    case "gas_grenade_mp":
    case "bulletstorm_device_mp":
    case "proto_ricochet_device_mp":
    case "emp_grenade_mp":
    case "mobile_radar_mp":
    case "motion_sensor_mp":
    case "gravity_grenade_mp":
    case "sensor_grenade_mp":
    case "smoke_grenadejugg_mp":
    case "flash_grenade_mp":
    case "chargemode_mp":
    case "phaseslash_grenade_mp":
    case "power_attack_drone_mp":
    case "armorup_mp":
    case "eng_drone_gun_mp":
    case "portal_grenade_mp":
    case "micro_turret_gun_mp":
    case "pulse_grenade_mp":
    case "thruster_mp":
    case "battleslide_mp":
    case "mortarmount_mp":
    case "shard_ball_mp":
    case "case_bomb_mp":
    case "disc_marker_mp":
    case "frag_grenade_short_mp":
    case "mortar_shelljugg_mp":
    case "proximity_explosive_mp":
    case "bouncingbetty_mp":
    case "throwingreaper_mp":
    case "throwingknifehack_mp":
    case "throwingknifesiphon_mp":
    case "throwingknifesmokewall_mp":
    case "throwingknifeteleport_mp":
    case "claymore_mp":
    case "semtex_mp":
    case "frag_grenade_mp":
      var_01 = "equipment_other";
      break;
    default:
      var_01 = undefined;
      break;
  }

  return var_01;
}

func_9F93(var_00, var_01) {
  if(!isdefined(var_00))
    return 0;

  if(!isdefined(var_01) || var_01 == "MOD_IMPACT")
    return 0;

  switch (var_00) {
    case "blackout_grenade_mp":
    case "concussion_grenade_mp":
    case "smoke_grenade_mp":
    case "cryo_mine_mp":
      return 1;
    case "deployable_cover_mp":
    case "trophy_mp":
    case "domeshield_mp":
      return 0;
    default:
      return 0;
  }
}

func_24ED() {
  if(!isdefined(self))
    return 0;

  if(isdefined(level.ac130player) && self == level.ac130player)
    return 1;

  if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && self == level.chopper.gunner)
    return 1;

  if(isdefined(level.reminder_reaction_pointat) && isdefined(level.reminder_reaction_pointat.owner) && self == level.reminder_reaction_pointat.owner)
    return 1;

  if(isdefined(self.using_remote_turret) && self.using_remote_turret)
    return 1;

  if(isdefined(self.using_remote_tank) && self.using_remote_tank)
    return 1;
  else if(isdefined(self.using_remote_a10))
    return 1;

  return 0;
}

isenvironmentweapon(var_00) {
  if(!isdefined(var_00))
    return 0;

  if(var_00 == "turret_minigun_mp")
    return 1;

  return 0;
}

isjuggernautweapon(var_00) {
  if(!isdefined(var_00))
    return 0;

  switch (var_00) {
    case "throwingknifejugg_mp":
    case "iw6_riotshieldjugg_mp":
    case "iw6_p226jugg_mp":
    case "iw6_magnumjugg_mp":
    case "iw6_minigunjugg_mp":
    case "smoke_grenadejugg_mp":
    case "mortar_shelljugg_mp":
    case "iw6_axe_mp":
      return 1;
  }

  return 0;
}

issuperweapon(var_00) {
  if(!isdefined(var_00))
    return 0;

  var_00 = getweaponrootname(var_00);

  if(isdefined(level.superweapons) && isdefined(level.superweapons[var_00]))
    return 1;

  return 0;
}

issuperdamagesource(var_00) {
  if(issuperweapon(var_00))
    return 1;

  if(var_00 == "chargemode_mp")
    return 1;

  if(var_00 == "micro_turret_gun_mp")
    return 1;

  if(var_00 == "super_trophy_mp")
    return 1;

  return 0;
}

func_9E0D(var_00) {
  if(isbombsiteweapon(var_00))
    return 1;

  switch (var_00) {
    case "iw7_tdefball_mp":
    case "iw7_uplinkball_mp":
      return 1;
    default:
      return 0;
  }

  return 0;
}

isrc8weapon(var_00) {
  if(!isdefined(var_00))
    return 0;

  switch (var_00) {
    case "iw7_minigun_c8_mp":
    case "iw7_chargeshot_c8_mp":
    case "iw7_c8offhandshield_mp":
    case "iw7_c8landing_mp":
    case "iw7_c8shutdown_mp":
    case "iw7_c8destruct_mp":
      return 1;
    default:
      return 0;
  }

  return 0;
}

getweapongroup(var_00) {
  if(var_00 == "none" || var_00 == "alt_none")
    return "other";

  var_01 = getweaponrootname(var_00);
  var_02 = weapongroupmap(var_01);

  if(!isdefined(var_02)) {
    if(issuperweapon(var_00))
      var_02 = "super";
    else if(isenvironmentweapon(var_00))
      var_02 = "weapon_mg";
    else if(iskillstreakweapon(var_00))
      var_02 = "killstreak";
    else if(func_9E0D(var_00))
      var_02 = "gamemode";
    else
      var_02 = "other";
  }

  return var_02;
}

getweaponattachmentarrayfromstats(var_00) {
  var_00 = getweaponrootname(var_00);

  if(!isdefined(level.weaponattachments))
    level.weaponattachments = [];

  if(!isdefined(level.weaponattachments[var_00])) {
    var_01 = [];

    for (var_02 = 0; var_02 <= 19; var_2++) {
      var_03 = tablelookup("mp\statsTable.csv", 4, var_00, 10 + var_02);

      if(var_03 == "") {
        break;
      }
      var_1[var_1.size] = var_03;
    }

    level.weaponattachments[var_00] = var_01;
  }

  return level.weaponattachments[var_00];
}

getweaponbarsize(var_00, var_01) {
  var_02 = getweaponattachmentarrayfromstats(var_00);
  var_03 = [];

  foreach(var_05 in var_02) {
    if(getattachmenttype(var_05) == var_01)
      var_3[var_3.size] = var_05;
  }

  return var_03;
}

getweaponattachmentfromstats(var_00, var_01) {
  var_00 = getweaponrootname(var_00);
  return tablelookup("mp\statsTable.csv", 4, var_00, 10 + var_01);
}

attachmentscompatible(var_00, var_01) {
  if(func_248E(var_00) && func_248E(var_01))
    return 0;

  var_00 = attachmentmap_tobase(var_00);
  var_01 = attachmentmap_tobase(var_01);
  var_02 = 1;

  if(var_00 == var_01)
    var_02 = 0;
  else if(isdefined(level.attachmentmap_conflicts)) {
    var_03 = scripts\engine\utility::alphabetize([var_00, var_01]);
    var_02 = !isdefined(level.attachmentmap_conflicts[var_3[0] + "_" + var_3[1]]);
  } else if(var_00 != "none" && var_01 != "none") {
    var_04 = tablelookuprownum("mp\attachmentcombos.csv", 0, var_01);

    if(tablelookup("mp\attachmentcombos.csv", 0, var_00, var_04) == "no")
      var_02 = 0;
  }

  return var_02;
}

getweaponrootname(var_00) {
  var_01 = strtok(var_00, "_");

  if(var_1[0] == "iw6" || var_1[0] == "iw7") {
    var_00 = var_1[0] + "_" + var_1[1];

    if(var_1[1] == "chargeshot" && isdefined(var_1[2]) && var_1[2] == "c8")
      var_00 = var_1[0] + "_" + var_1[1] + "_" + var_1[2];
  } else if(var_1[0] == "alt")
    var_00 = var_1[1] + "_" + var_1[2];

  return var_00;
}

getweaponbasedsmokegrenadecount(var_00) {
  if(var_00 != "none")
    var_00 = getweaponbasename(var_00);

  return var_00;
}

func_E0CF(var_00) {
  if(scripts\mp\weapons::isaltmodeweapon(var_00))
    var_00 = getsubstr(var_00, 4);

  return var_00;
}

isclassicweapon(var_00) {
  var_01 = getweaponrootname(var_00);

  if(var_01 == "iw7_g18c" || var_01 == "iw7_ump45c" || var_01 == "iw7_cheytacc" || var_01 == "iw7_m1c" || var_01 == "iw7_spasc" || var_01 == "iw7_arclassic")
    return 1;
  else
    return 0;
}

isburstfireweapon(var_00) {
  var_01 = getweaponrootname(var_00);

  if(var_01 == "iw7_rvn" || var_01 == "iw7_cheytac" || var_01 == "iw7_tacburst")
    return 1;

  var_02 = getweaponvariantindex(var_00);

  if(isdefined(var_02)) {
    if(var_01 == "iw7_sdfar" && var_02 != 3 && var_02 != 35)
      return 1;

    if(var_01 == "iw7_revolver" && var_02 != 3 && var_02 != 35)
      return 1;

    if(var_01 == "iw7_gauss" && (var_02 == 1 || var_02 == 33 || var_02 == 2 || var_02 == 34 || var_02 == 3 || var_02 == 35))
      return 1;

    if(var_01 == "iw7_sonic" && (var_02 == 4 || var_02 == 36))
      return 1;

    if(var_01 == "iw7_m8" && (var_02 == 4 || var_02 == 36))
      return 1;

    if(var_01 == "iw7_emc" && (var_02 == 3 || var_02 == 35))
      return 1;
  } else if(var_01 == "iw7_sdfar" || var_01 == "iw7_revolver")
    return 1;

  return 0;
}

getbaseperkname(var_00) {
  if(isendstr(var_00, "_ks"))
    var_00 = getsubstr(var_00, 0, var_0.size - 3);

  return var_00;
}

getvalidextraammoweapons() {
  var_00 = [];
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    var_04 = weaponclass(var_03);

    if(!iskillstreakweapon(var_03) && var_04 != "grenade" && var_04 != "rocketlauncher" && self getweaponammostock(var_03) != 0)
      var_0[var_0.size] = var_03;
  }

  return var_00;
}

riotshield_hasweapon() {
  var_00 = 0;
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(scripts\mp\weapons::isriotshield(var_03)) {
      var_00 = 1;
      break;
    }
  }

  return var_00;
}

riotshield_hastwo() {
  var_00 = 0;
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(scripts\mp\weapons::isriotshield(var_03))
      var_0++;

    if(var_00 == 2) {
      break;
    }
  }

  return var_00 == 2;
}

riotshield_attach(var_00, var_01) {
  var_02 = undefined;

  if(var_00) {
    self.riotshieldmodel = var_01;
    var_02 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = var_01;
    var_02 = "tag_shield_back";
  }

  self attachshieldmodel(var_01, var_02);
  self.hasriotshield = riotshield_hasweapon();
}

riotshield_detach(var_00) {
  var_01 = undefined;
  var_02 = undefined;

  if(var_00) {
    var_01 = self.riotshieldmodel;
    var_02 = "tag_weapon_right";
  } else {
    var_01 = self.riotshieldmodelstowed;
    var_02 = "tag_shield_back";
  }

  self detachshieldmodel(var_01, var_02);

  if(var_00)
    self.riotshieldmodel = undefined;
  else
    self.riotshieldmodelstowed = undefined;

  self.hasriotshield = riotshield_hasweapon();
}

riotshield_move(var_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;

  if(var_00) {
    var_03 = self.riotshieldmodel;
    var_01 = "tag_weapon_right";
    var_02 = "tag_shield_back";
  } else {
    var_03 = self.riotshieldmodelstowed;
    var_01 = "tag_shield_back";
    var_02 = "tag_weapon_right";
  }

  self moveshieldmodel(var_03, var_01, var_02);

  if(var_00) {
    self.riotshieldmodelstowed = var_03;
    self.riotshieldmodel = undefined;
  } else {
    self.riotshieldmodel = var_03;
    self.riotshieldmodelstowed = undefined;
  }
}

riotshield_clear() {
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
  self.riotshieldmodelstowed = undefined;
  self.riotshieldmodel = undefined;
}

riotshield_getmodel() {
  return scripts\engine\utility::ter_op(isjuggernaut(), "weapon_riot_shield_jug_iw6", "weapon_riot_shield_iw6");
}

func_C793(var_00, var_01, var_02, var_03, var_04) {
  var_05 = level.players;
  var_06 = scripts\mp\outline::func_C78A(var_01);
  var_07 = scripts\mp\outline::func_C7A9(var_04);
  return scripts\mp\outline::outlineenableinternal(var_00, var_06, var_05, var_02, var_03, var_07, "ALL");
}

outlineenableforteam(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = getteamarray(var_02, 0);
  var_07 = scripts\mp\outline::func_C78A(var_01);
  var_08 = scripts\mp\outline::func_C7A9(var_05);
  return scripts\mp\outline::outlineenableinternal(var_00, var_07, var_06, var_03, var_04, var_08, "TEAM", var_02);
}

outlineenableforplayer(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = scripts\mp\outline::func_C78A(var_01);
  var_07 = scripts\mp\outline::func_C7A9(var_05);

  if(isagent(var_02))
    return scripts\mp\outline::outlinegenerateuniqueid();

  return scripts\mp\outline::outlineenableinternal(var_00, var_06, [var_02], var_03, var_04, var_07, "ENTITY");
}

outlinedisable(var_00, var_01) {
  scripts\mp\outline::outlinedisableinternal(var_00, var_01);
}

func_C7AA(var_00) {
  scripts\mp\outline::func_C7AB(var_00);
}

func_98AA() {
  level.func_C7A1 = [];
  level.func_C7A2 = 0;
}

func_180C(var_00, var_01) {
  var_02 = spawnstruct();
  var_2.position = var_00;
  var_2.radius = var_01;
  var_03 = level.func_C7A2;
  level.func_C7A1[var_03] = var_02;
  level.func_C7A2++;
  return var_03;
}

func_E14A(var_00) {
  level.func_C7A1[var_00] = undefined;
}

func_C7A0(var_00, var_01) {
  foreach(var_03 in level.func_C7A1) {
    if(!isdefined(var_03) || !isdefined(var_3.position) || !isdefined(var_3.radius)) {
      continue;
    }
    if(scripts\engine\utility::segmentvssphere(var_00, var_01, var_3.position, var_3.radius))
      return 1;
  }

  return 0;
}

playsoundinspace(var_00, var_01) {
  playloopsound(var_01, var_00);
}

func_ACDD(var_00, var_01) {
  var_02 = 1;

  for (var_03 = 0; var_03 < var_01; var_3++)
    var_02 = var_02 * 10;

  var_04 = var_00 * var_02;
  var_04 = int(var_04);
  var_04 = var_04 / var_02;
  return var_04;
}

func_E75C(var_00, var_01, var_02) {
  if(!isdefined(var_02))
    var_02 = "nearest";

  var_03 = 1;

  for (var_04 = 0; var_04 < var_01; var_4++)
    var_03 = var_03 * 10;

  var_05 = var_00 * var_03;

  if(var_02 == "up")
    var_06 = ceil(var_05);
  else if(var_02 == "down")
    var_06 = floor(var_05);
  else
    var_06 = var_05 + 0.5;

  var_05 = int(var_06);
  var_05 = var_05 / var_03;
  return var_05;
}

func_D38F(var_00) {
  foreach(var_02 in level.players) {
    if(var_2.clientid == var_00)
      return var_02;
  }

  return undefined;
}

func_1114F(var_00) {
  var_01 = strtok(var_00, ".");
  var_02 = int(var_1[0]);

  if(isdefined(var_1[1])) {
    var_03 = 1;

    for (var_04 = 0; var_04 < var_1[1].size; var_4++)
      var_03 = var_03 * 0.1;

    var_02 = var_02 + int(var_1[1]) * var_03;
  }

  return var_02;
}

setselfusable(var_00) {
  self makeusable();

  foreach(var_02 in level.players) {
    if(var_02 != var_00) {
      self disableplayeruse(var_02);
      continue;
    }

    self enableplayeruse(var_02);
  }
}

func_F63C() {
  foreach(var_01 in level.players)
  self disableplayeruse(var_01);
}

func_B2B4(var_00) {
  self makeusable();
  thread func_1438(var_00);
}

func_1438(var_00) {
  self endon("death");

  for (;;) {
    foreach(var_02 in level.players) {
      if(var_2.team == var_00) {
        self enableplayeruse(var_02);
        continue;
      }

      self disableplayeruse(var_02);
    }

    level waittill("joined_team");
  }
}

makeenemyusable(var_00) {
  self makeusable();
  thread func_1437(var_00);
}

func_1437(var_00) {
  self endon("death");
  var_01 = var_0.team;

  for (;;) {
    if(level.teambased) {
      foreach(var_03 in level.players) {
        if(var_3.team != var_01) {
          self enableplayeruse(var_03);
          continue;
        }

        self disableplayeruse(var_03);
      }
    } else {
      foreach(var_03 in level.players) {
        if(var_03 != var_00) {
          self enableplayeruse(var_03);
          continue;
        }

        self disableplayeruse(var_03);
      }
    }

    level waittill("joined_team");
  }
}

initgameflags() {
  if(!isdefined(game["flags"]))
    game["flags"] = [];
}

gameflaginit(var_00, var_01) {
  game["flags"][var_00] = var_01;
}

gameflag(var_00) {
  return game["flags"][var_00];
}

gameflagset(var_00) {
  game["flags"][var_00] = 1;
  level notify(var_00);
}

gameflagclear(var_00) {
  game["flags"][var_00] = 0;
}

gameflagwait(var_00) {
  while (!gameflag(var_00))
    level waittill(var_00);
}

func_9F0D(var_00) {
  if(var_00 == "MOD_RIFLE_BULLET" || var_00 == "MOD_PISTOL_BULLET")
    return 1;

  return 0;
}

isfmjdamage(var_00, var_01) {
  var_02 = 0;

  if(isdefined(var_01) && scripts\engine\utility::isbulletdamage(var_01)) {
    var_03 = getweaponattachmentsbasenames(var_00);

    foreach(var_05 in var_03) {
      if(var_05 == "fmj" || var_05 == "reflect") {
        var_02 = 1;
        break;
      }
    }
  }

  return var_02;
}

initlevelflags() {
  if(!isdefined(level.levelflags))
    level.levelflags = [];
}

levelflaginit(var_00, var_01) {
  level.levelflags[var_00] = var_01;
}

levelflag(var_00) {
  return level.levelflags[var_00];
}

func_ABF4(var_00) {
  level.levelflags[var_00] = 1;
  level notify(var_00);
}

levelflagclear(var_00) {
  level.levelflags[var_00] = 0;
  level notify(var_00);
}

func_ABF5(var_00) {
  while (!levelflag(var_00))
    level waittill(var_00);
}

func_ABF6(var_00) {
  while (levelflag(var_00))
    level waittill(var_00);
}

iskillstreakdenied() {
  return scripts\mp\killstreaks\emp_common::isemped() || isairdenied();
}

isairdenied() {
  if(self.team == "spectator")
    return 0;

  if(level.teambased)
    return level.teamairdenied[self.team];
  else
    return isdefined(level.airdeniedplayer) && level.airdeniedplayer != self;
}

func_9EBB() {
  if(self.team == "spectator")
    return 0;

  return isdefined(self.nuked);
}

getplayerforguid(var_00) {
  foreach(var_02 in level.players) {
    if(var_2.guid == var_00)
      return var_02;
  }

  return undefined;
}

teamplayercardsplash(var_00, var_01, var_02, var_03) {
  if(level.hardcoremode) {
    return;
  }
  foreach(var_05 in level.players) {
    if(var_05 ismlgspectator()) {
      var_06 = var_05 getspectatingplayer();

      if(isdefined(var_06) && isdefined(var_02) && var_6.team != var_02)
        continue;
    } else {
      if(isdefined(var_02) && var_5.team != var_02) {
        continue;
      }
      if(!isplayer(var_05))
        continue;
    }

    var_05 thread scripts\mp\hud_message::showsplash(var_00, var_03, var_01);
  }
}

ispickedupweapon(var_00) {
  if(iscacprimaryweapon(var_00) || iscacsecondaryweapon(var_00)) {
    if(issubstr(var_00, "alt_"))
      var_00 = getsubstr(var_00, 4, var_0.size);

    var_01 = isdefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var_00;
    var_02 = isdefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var_00;

    if(!var_01 && !var_02)
      return 1;
  }

  return 0;
}

iscacprimaryweapon(var_00) {
  switch (getweapongroup(var_00)) {
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_dmr":
    case "weapon_sniper":
    case "weapon_riot":
    case "weapon_assault":
    case "weapon_smg":
      return 1;
    default:
      return 0;
  }
}

iscacsecondaryweapon(var_00) {
  switch (getweapongroup(var_00)) {
    case "weapon_melee":
    case "weapon_rail":
    case "weapon_beam":
    case "weapon_machine_pistol":
    case "weapon_pistol":
    case "weapon_projectile":
      return 1;
    default:
      return 0;
  }
}

iscacmeleeweapon(var_00) {
  return getweapongroup(var_00) == "weapon_melee";
}

getlastlivingplayer(var_00) {
  var_01 = undefined;

  foreach(var_03 in level.players) {
    if(isdefined(var_00) && var_3.team != var_00) {
      continue;
    }
    if(!isreallyalive(var_03) && !var_03 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(isdefined(var_3.switching_teams) && var_3.switching_teams) {
      continue;
    }
    var_01 = var_03;
  }

  return var_01;
}

getpotentiallivingplayers() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(!isreallyalive(var_02) && !var_02 scripts\mp\playerlogic::mayspawn()) {
      continue;
    }
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      if(var_02 ismlgspectator())
        continue;
    }

    var_0[var_0.size] = var_02;
  }

  return var_00;
}

waittillrecoveredhealth(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  var_02 = 0;

  if(!isdefined(var_01))
    var_01 = 0.05;

  if(!isdefined(var_00))
    var_00 = 0;

  for (;;) {
    if(self.health != self.maxhealth)
      var_02 = 0;
    else
      var_02 = var_02 + var_01;

    wait(var_01);

    if(self.health == self.maxhealth && var_02 >= var_00) {
      break;
    }
  }

  return;
}

enableweaponlaser() {
  if(!isdefined(self.weaponlasercalls))
    self.weaponlasercalls = 0;

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

attachmentmap_tounique(var_00, var_01) {
  var_02 = getweaponrootname(var_01);

  if(var_02 != var_01) {
    var_03 = getweaponbasename(var_01);

    if(isdefined(level.attachmentmap_basetounique[var_03]) && isdefined(level.attachmentmap_uniquetobase[var_00]) && isdefined(level.attachmentmap_basetounique[var_03][level.attachmentmap_uniquetobase[var_00]])) {
      var_04 = level.attachmentmap_uniquetobase[var_00];
      return level.attachmentmap_basetounique[var_03][var_04];
    } else if(isdefined(level.attachmentmap_basetounique[var_03]) && isdefined(level.attachmentmap_basetounique[var_03][var_00]))
      return level.attachmentmap_basetounique[var_03][var_00];
    else {
      var_05 = strtok(var_03, "_");

      if(var_5.size > 3) {
        var_06 = var_5[0] + "_" + var_5[1] + "_" + var_5[2];

        if(isdefined(level.attachmentmap_basetounique[var_06]) && isdefined(level.attachmentmap_basetounique[var_06][var_00]))
          return level.attachmentmap_basetounique[var_06][var_00];
      }
    }
  }

  if(isdefined(level.attachmentmap_basetounique[var_02]) && isdefined(level.attachmentmap_basetounique[var_02][var_00]))
    return level.attachmentmap_basetounique[var_02][var_00];
  else {
    var_07 = weapongroupmap(var_02);

    if(isdefined(level.attachmentmap_basetounique[var_07]) && isdefined(level.attachmentmap_basetounique[var_07][var_00]))
      return level.attachmentmap_basetounique[var_07][var_00];
  }

  return var_00;
}

attachmentperkmap(var_00) {
  if(isdefined(level.attachmentmap_attachtoperk[var_00]))
    return level.attachmentmap_attachtoperk[var_00];

  return undefined;
}

func_13C75(var_00) {
  if(isdefined(level.weaponmapdata[var_00]) && isdefined(level.weaponmapdata[var_00].func_23B0))
    var_00 = level.weaponmapdata[var_00].func_23B0;

  return var_00;
}

func_13CB4(var_00) {
  if(isdefined(level.weaponmapdata[var_00]) && isdefined(level.weaponmapdata[var_00].perk))
    return level.weaponmapdata[var_00].perk;

  return undefined;
}

weapongroupmap(var_00) {
  if(isdefined(level.weaponmapdata[var_00]) && isdefined(level.weaponmapdata[var_00].group))
    return level.weaponmapdata[var_00].group;

  return undefined;
}

func_13CAC(var_00) {
  if(isdefined(level.weaponmapdata[var_00]) && isdefined(level.weaponmapdata[var_00].number))
    return level.weaponmapdata[var_00].number;
}

weaponattachdefaultmap(var_00) {
  if(isdefined(level.weaponmapdata[var_00]) && isdefined(level.weaponmapdata[var_00].attachdefaults))
    return level.weaponmapdata[var_00].attachdefaults;

  return undefined;
}

func_13C86(var_00) {
  return isdefined(level.weaponmapdata[var_00]);
}

weaponattachremoveextraattachments(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(isdefined(level.attachmentextralist[var_03])) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_01;
}

func_9D55(var_00, var_01) {
  var_02 = strtok(var_00, "_");
  return func_9D56(var_02, var_01);
}

func_9D56(var_00, var_01) {
  var_02 = 0;

  if(var_0.size && isdefined(var_01)) {
    var_03 = 0;

    if(var_0[0] == "alt")
      var_03 = 1;

    if(var_0.size >= 3 + var_03 && (var_0[var_03] == "iw6" || var_0[var_03] == "iw7")) {
      if(weaponclass(var_0[var_03] + "_" + var_0[var_03 + 1] + "_" + var_0[var_03 + 2]) == "sniper")
        var_02 = var_0[var_03 + 1] + "scope" == var_01;
    }
  }

  return var_02;
}

getweaponattachmentsbasenames(var_00) {
  if(var_00 != "none") {
    var_01 = getweaponattachments(var_00);

    foreach(var_04, var_03 in var_01)
    var_1[var_04] = attachmentmap_tobase(var_03);

    return var_01;
  }

  return [];
}

getattachmentlistbasenames() {
  var_00 = [];
  var_01 = 0;

  for (var_02 = tablelookup("mp\attachmentTable.csv", 0, var_01, 5); var_02 != ""; var_02 = tablelookup("mp\attachmentTable.csv", 0, var_01, 5)) {
    var_03 = tablelookup("mp\attachmentTable.csv", 0, var_01, 2);

    if(var_03 != "none" && !scripts\engine\utility::array_contains(var_00, var_02))
      var_0[var_0.size] = var_02;

    var_1++;
  }

  return var_00;
}

attachmentmap_tobase(var_00) {
  if(isdefined(level.attachmentmap_uniquetobase[var_00]))
    var_00 = level.attachmentmap_uniquetobase[var_00];

  return var_00;
}

attachmentmap_toextra(var_00) {
  var_01 = undefined;

  if(isdefined(level.attachmentmap_uniquetoextra[var_00]))
    var_01 = level.attachmentmap_uniquetoextra[var_00];

  return var_01;
}

func_13CA1(var_00, var_01, var_02) {
  if(isdefined(var_00)) {
    switch (var_00) {
      case "domeshield_plant_mp":
        var_00 = "domeshield_mp";
        break;
      case "power_exploding_drone_transform_mp":
        var_00 = "power_exploding_drone_mp";
        break;
      case "semtexproj_mp":
        var_00 = "iw6_mk32_mp";
        break;
      case "iw6_semtexshards_mp":
        var_00 = "venomproj_mp";
        break;
      case "globproj_mp":
        var_00 = "splash_grenade_mp";
        break;
      case "niagara_mini_mp":
        var_00 = "iw7_niagara_mp";
        break;
      case "wristrocket_proj_mp":
        var_00 = "wristrocket_mp";
        break;
      case "split_grenade_mini_mp":
        var_00 = "split_grenade_mp";
        break;
      case "destructible_toy":
        if(isdefined(var_01)) {
          if(isdefined(var_1.weapon_name))
            var_00 = var_1.weapon_name;
          else
            var_00 = "destructible_car";

          if(!istrue(var_02))
            var_00 = func_13CA1(var_00, var_01, 1);
        }

        break;
      case "iw7_spas_mpr_focus":
        var_00 = "iw7_spas_mpr";
        break;
      case "iw7_erad_mp_jump_spread":
        var_00 = "iw7_erad_mp";
        break;
      case "gltacburst":
        var_00 = "alt_iw7_tacburst_mp";
        break;
      case "gltacburst_big":
        var_00 = "alt_iw7_tacburst_mpl";
        break;
      default:
        var_03 = self;

        if(var_00 != "alt_none" && getweaponrootname(var_00) == "iw7_axe") {
          if(isdefined(var_01)) {
            var_03 = var_01;

            if(!isplayer(var_01) && isdefined(var_1.owner))
              var_03 = var_1.owner;

            if(isdefined(var_1.classname) && var_1.classname != "grenade" && var_03 getweaponammoclip(var_00) == 0)
              var_00 = "iw7_fists_mp";
          }
        }

        break;
    }
  }

  return var_00;
}

func_249F(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(func_2490(var_03))
      var_1[var_1.size] = var_03;
  }

  return var_01;
}

func_2490(var_00) {
  if(func_248F(var_00))
    return 0;

  if(func_248E(var_00))
    return 0;

  switch (var_00) {
    case "tacburst_big":
    case "glsmoke_slow":
    case "glsmoke":
    case "shotgunlongshot":
    case "meleervn":
    case "axefists":
    case "arripper":
    case "arm8":
    case "gltacburst":
    case "scope":
      return 0;
  }

  return 1;
}

func_13C94(var_00) {
  return 0;
}

func_13C9B(var_00) {
  if(func_13C91(var_00))
    return 1;
  else
    return weaponhasattachment(var_00, "firetypeburst");
}

func_13C9C(var_00) {
  var_01 = getweaponrootname(var_00);
  return var_01 == "iw7_spas" || var_01 == "iw7_spasc" || var_01 == "iw7_sonic";
}

func_13C91(var_00) {
  var_01 = getweaponrootname(var_00);

  if(var_01 == "iw7_sdfar") {
    var_02 = getweaponattachmentsbasenames(var_00);

    foreach(var_04 in var_02) {
      if(var_04 == "firetypeauto" || var_04 == "firetypesingle")
        return 0;
    }

    return 1;
  } else
    return 0;
}

func_13C93(var_00) {
  return var_00 == "iw6_g28";
}

func_13C92(var_00) {
  return var_00 == "iw6_cbjms";
}

func_13C95(var_00) {
  var_01 = getweaponrootname(var_00);

  if(var_01 == "iw6_dlcweap03") {
    var_02 = getweaponattachments(var_00);

    foreach(var_04 in var_02) {
      if(isstrstart(var_04, "dlcweap03"))
        return 1;
    }
  }

  return 0;
}

weaponhasattachment(var_00, var_01) {
  var_02 = getweaponattachmentsbasenames(var_00);

  foreach(var_04 in var_02) {
    if(var_04 == var_01)
      return 1;
  }

  return 0;
}

func_9EE8() {
  return self playerads() > 0.5;
}

touchingbadtrigger() {
  var_00 = getentarray("trigger_hurt", "classname");

  foreach(var_02 in var_00) {
    if(self istouching(var_02))
      return 1;
  }

  var_04 = getentarray("radiation", "targetname");

  foreach(var_02 in var_04) {
    if(self istouching(var_02))
      return 1;
  }

  return 0;
}

func_11A44() {
  if(istrue(self.allowedintrigger))
    return 0;

  foreach(var_01 in level.func_C7B3) {
    if(self istouching(var_01))
      return 1;
  }

  return 0;
}

touchingballallowedtrigger() {
  if(!istrue(level.ballallowedtriggers.size))
    return 0;

  self.allowedintrigger = 0;

  foreach(var_01 in level.ballallowedtriggers) {
    if(self istouching(var_01)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

touchingplayerallowedtrigger() {
  if(!istrue(level.playerallowedtriggers.size))
    return 0;

  self.allowedintrigger = 0;

  foreach(var_01 in level.playerallowedtriggers) {
    if(self istouching(var_01)) {
      self.allowedintrigger = 1;
      return 1;
    }
  }

  return 0;
}

setthirdpersondof(var_00) {
  if(var_00)
    self setdepthoffield(0, 110, 512, 4096, 6, 1.8);
  else
    self setdepthoffield(0, 0, 512, 512, 4, 0);
}

func_A6C9(var_00, var_01, var_02) {
  var_03 = spawn("trigger_radius", var_00, 0, var_01, var_02);

  for (;;) {
    var_03 waittill("trigger", var_04);

    if(!isplayer(var_04)) {
      continue;
    }
    var_04 suicide();
  }
}

func_6CB9(var_00, var_01, var_02) {
  var_03 = cos(var_02);
  var_04 = anglestoforward(var_0.angles);
  var_05 = var_1.origin - var_0.origin;
  var_04 = var_04 * (1, 1, 0);
  var_05 = var_05 * (1, 1, 0);
  var_05 = vectornormalize(var_05);
  var_04 = vectornormalize(var_04);
  var_06 = vectordot(var_05, var_04);

  if(var_06 >= var_03)
    return 1;
  else
    return 0;
}

func_5B75(var_00, var_01, var_02, var_03, var_04) {
  var_05 = int(var_03 * 20);

  for (var_06 = 0; var_06 < var_05; var_6++)
    wait 0.05;
}

drawline(var_00, var_01, var_02, var_03) {
  var_04 = int(var_02 * 20);

  for (var_05 = 0; var_05 < var_04; var_5++)
    wait 0.05;
}

drawsphere(var_00, var_01, var_02, var_03) {
  var_04 = int(var_02 * 20);

  for (var_05 = 0; var_05 < var_04; var_5++)
    wait 0.05;
}

setrecoilscale(var_00, var_01) {
  if(!isdefined(var_00))
    var_00 = 0;

  if(!isdefined(self.recoilscale))
    self.recoilscale = var_00;
  else
    self.recoilscale = self.recoilscale + var_00;

  if(isdefined(var_01)) {
    if(isdefined(self.recoilscale) && var_01 < self.recoilscale)
      var_01 = self.recoilscale;

    var_02 = 100 - var_01;
  } else
    var_02 = 100 - self.recoilscale;

  if(var_02 < 0)
    var_02 = 0;

  if(var_02 > 100)
    var_02 = 100;

  if(var_02 == 100) {
    self getweaponrankforxp();
    return;
  }

  self getweaponrankinfomaxxp(var_02);
}

cleanarray(var_00) {
  var_01 = [];

  foreach(var_04, var_03 in var_00) {
    if(!isdefined(var_03)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_04];
  }

  return var_01;
}

notusableforjoiningplayers(var_00) {
  self notify("notusablejoiningplayers");
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("death");
  self endon("notusablejoiningplayers");
  self endon("makeExplosiveUnusable");

  for (;;) {
    level waittill("player_spawned", var_01);

    if(isdefined(var_01) && var_01 != var_00)
      self disableplayeruse(var_01);
  }
}

isstrstart(var_00, var_01) {
  return getsubstr(var_00, 0, var_1.size) == var_01;
}

func_55AC() {
  level.func_A6AF = 1;
}

func_625E() {
  level.func_A6AF = undefined;
}

func_1314A(var_00, var_01) {
  if(isdefined(level.func_A6AF) && level.func_A6AF)
    return 0;

  if((!self isonground() || self iswallrunning()) && (func_9F2C(var_00) || func_9D82(var_00) || func_9FB7(var_00) || func_9E90(var_00))) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");
    return 0;
  }

  if(isusingremote())
    return 0;

  if(isdefined(self.selectinglocation))
    return 0;

  if(scripts\mp\killstreaks\emp_common::isemped()) {
    if(func_9E64(var_00)) {
      if(!(isdefined(var_01) && var_01))
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_WHEN_JAMMED");

      return 0;
    }
  }

  if(isairdenied()) {
    if(isflyingkillstreak(var_00) && var_00 != "air_superiority") {
      if(!(isdefined(var_01) && var_01))
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_WHEN_AA");

      return 0;
    }
  }

  if(self isusingturret() && (func_9F2C(var_00) || func_9D82(var_00) || func_9FB7(var_00))) {
    if(!(isdefined(var_01) && var_01))
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_USING_TURRET");

    return 0;
  }

  if(isdefined(self.laststand) && !_hasperk("specialty_finalstand")) {
    if(!isdefined(level.func_1C99) || !level.func_1C99 || var_00 != "agent") {
      if(!(isdefined(var_01) && var_01))
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE_IN_LASTSTAND");

      return 0;
    }
  }

  if(!scripts\engine\utility::isweaponallowed())
    return 0;

  if(isdefined(level.func_3FD9) && isflyingkillstreak(var_00)) {
    if(!(isdefined(var_01) && var_01))
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_CIVILIAN_AIR_TRAFFIC");

    return 0;
  }

  if(isdefined(var_00) && var_00 == "sentry_shock" && isinarbitraryup()) {
    if(!(isdefined(var_01) && var_01))
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_UNAVAILABLE");

    return 0;
  }

  return 1;
}

func_9F2C(var_00) {
  switch (var_00) {
    case "venom":
    case "thor":
    case "minijackal":
    case "drone_hive":
      return 1;
    default:
      return 0;
  }
}

func_9E90(var_00) {
  switch (var_00) {
    case "bombardment":
    case "precision_airstrike":
      return 1;
    default:
      return 0;
  }
}

func_9EF0(var_00) {
  if(!isdefined(var_0.func_165A))
    return 0;

  switch (var_0.func_165A) {
    case "remote_c8":
    case "spiderbot":
      return 1;
    default:
      return 0;
  }
}

func_9D82(var_00) {
  switch (var_00) {
    case "ims":
    case "deployable_exp_ammo":
    case "deployable_grenades":
    case "deployable_ammo":
    case "deployable_vest":
      return 1;
    default:
      return 0;
  }
}

func_9FBA(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "directional_uav":
    case "counter_uav":
    case "uav":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9D35(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "precision_airstrike":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9E7F(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "airdrop":
    case "dronedrop":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9E2D(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "jammer":
    case "jackal":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9F67(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "minijackal":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9D61(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "ball_drone_backup":
    case "venom":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9FB7(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "super_trophy":
    case "sentry_shock":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9F0F(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "bombardment":
    case "thor":
    case "drone_hive":
      var_01 = 1;
      break;
  }

  return var_01;
}

func_9D80(var_00) {
  return isdefined(var_00) && isdefined(var_0.id) && var_0.id == "care_package";
}

func_10060(var_00) {
  switch (var_00) {
    case "dronedrop":
    case "directional_uav":
    case "counter_uav":
    case "uav":
      return 0;
    default:
      return 1;
  }
}

func_9E64(var_00) {
  switch (var_00) {
    case "fleet_swarm":
    case "zerosub_level_killstreak":
    case "dome_seekers":
    case "guard_dog":
    case "recon_agent":
    case "deployable_ammo":
    case "deployable_vest":
    case "spiderbot":
    case "precision_airstrike":
    case "minijackal":
    case "agent":
      return 0;
    default:
      return 1;
  }
}

func_9E65(var_00) {
  return func_9E64(var_00) && !isflyingkillstreak(var_00);
}

func_9E6A(var_00) {
  switch (var_00) {
    case "bombardment":
      return 0;
    default:
      return 1;
  }
}

isflyingkillstreak(var_00) {
  switch (var_00) {
    case "orbital_deployment":
    case "ac130":
    case "ca_a10_strafe":
    case "vanguard":
    case "odin_assault":
    case "odin_support":
    case "heli_pilot":
    case "airdrop_juggernaut_maniac":
    case "airdrop_assault":
    case "heli_sniper":
    case "airdrop_juggernaut_recon":
    case "airdrop_juggernaut":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "fleet_swarm":
    case "airdrop":
    case "precision_airstrike":
    case "thor":
    case "drone_hive":
    case "air_superiority":
      return 1;
    default:
      return 0;
  }
}

func_7F4D(var_00) {
  return tablelookuprownum("mp\killstreakTable.csv", 1, var_00);
}

getkillstreakindex(var_00) {
  var_01 = tablelookup("mp\killstreakTable.csv", 1, var_00, 0);

  if(var_01 == "")
    var_02 = -1;
  else
    var_02 = int(var_01);

  return var_02;
}

func_7F4B(var_00) {
  return tablelookup("mp\killstreakTable.csv", 0, var_00, 1);
}

func_7F4C(var_00) {
  return tablelookup("mp\killstreakTable.csv", 12, var_00, 1);
}

func_7F47(var_00) {
  return tablelookupistring("mp\killstreakTable.csv", 1, var_00, 2);
}

func_7F38(var_00) {
  return tablelookupistring("mp\killstreakTable.csv", 1, var_00, 3);
}

func_7F46(var_00) {
  var_01 = scripts\engine\utility::ter_op(_hasperk("specialty_support_killstreaks"), 5, 4);
  return tablelookup("mp\killstreakTable.csv", 1, var_00, var_01);
}

getenemyinfo(var_00) {
  var_01 = strtok(var_00, "_");
  return var_1[1];
}

func_7F3C(var_00) {
  return tablelookupistring("mp\killstreakTable.csv", 1, var_00, 6);
}

func_7F51(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 7);
}

func_7F3B(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 8);
}

func_7F34(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 9);
}

func_7F3E(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 10);
}

func_7F40(var_00) {
  return int(tablelookup("mp\killstreakTable.csv", 1, var_00, 11));
}

getkillstreakweapon(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 12);
}

func_7F4E(var_00) {
  return int(tablelookup("mp\killstreakTable.csv", 1, var_00, 13));
}

func_7F43(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 14);
}

getkillstreakoverheadicon(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 15);
}

func_7F39(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 16);
}

func_7F53(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 17);
}

func_7F4F(var_00) {
  return tablelookup("mp\killstreakTable.csv", 1, var_00, 18);
}

currentactivevehiclecount(var_00) {
  if(!isdefined(var_00))
    var_00 = 0;

  var_01 = var_00;

  if(isdefined(level.helis))
    var_01 = var_01 + level.helis.size;

  if(isdefined(level.littlebirds))
    var_01 = var_01 + level.littlebirds.size;

  if(isdefined(level.ugvs))
    var_01 = var_01 + level.ugvs.size;

  return var_01;
}

maxvehiclesallowed() {
  return 8;
}

fauxvehiclecount() {
  return level.fauxvehiclecount;
}

incrementfauxvehiclecount(var_00) {
  if(!isdefined(var_00))
    level.fauxvehiclecount++;
  else
    level.fauxvehiclecount = level.fauxvehiclecount + var_00;
}

decrementfauxvehiclecount(var_00) {
  if(!isdefined(var_00))
    level.fauxvehiclecount--;
  else
    level.fauxvehiclecount = level.fauxvehiclecount - var_00;

  if(level.fauxvehiclecount < 0)
    level.fauxvehiclecount = 0;
}

lightweightscalar() {
  return 1.06;
}

allowteamassignment() {
  if(level.gametype == "gun" || level.gametype == "infect")
    return 0;

  if(!isdefined(self.pers["isBot"])) {
    if(isgamebattlematch())
      return 0;

    if(getdvarint("com_codcasterEnabled", 0) > 0)
      return 1;
  }

  if(getdvarint("scr_skipclasschoice", 0) > 0 || skiploadout())
    return 0;

  if(level.gametype == "cranked" || level.gametype == "mp_zomb")
    return level.teambased;

  var_00 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 4));
  return var_00;
}

allowclasschoice() {
  if(getdvarint("scr_skipclasschoice", 0) > 0 || skiploadout())
    return 0;

  var_00 = int(tablelookup("mp\gametypesTable.csv", 0, level.gametype, 5));
  return var_00;
}

skiploadout() {
  return istrue(level.aonrules);
}

showfakeloadout() {
  return 0;
}

func_F6FF(var_00, var_01) {
  var_02 = getweaponrootname(var_00);
  var_03 = [];

  if(var_02 != "iw7_knife")
    var_03 = getweaponattachments(var_00);

  if(isdefined(var_02))
    var_04 = tablelookuprownum("mp\statsTable.csv", 4, var_02);
  else {}

  for (var_05 = 0; var_05 < 3; var_5++) {
    var_06 = -1;

    if(isdefined(var_3[var_05])) {
      if(!func_9D55(var_00, var_3[var_05]))
        var_06 = tablelookuprownum("mp\attachmentTable.csv", 4, var_3[var_05]);
    }
  }
}

setcommonrulesfrommatchdata(var_00) {
  var_01 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_" + level.gametype + "_timeLimit", var_01);
  registertimelimitdvar(level.gametype, var_01);
  var_02 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_" + level.gametype + "_scoreLimit", var_02);
  registerscorelimitdvar(level.gametype, var_02);
  var_03 = getmatchrulesdata("commonOption", "winLimit");
  setdynamicdvar("scr_" + level.gametype + "_winLimit", var_03);
  registerwinlimitdvar(level.gametype, var_03);
  var_04 = getmatchrulesdata("commonOption", "roundLimit");
  setdynamicdvar("scr_" + level.gametype + "_roundLimit", var_04);
  registerroundlimitdvar(level.gametype, var_04);
  var_05 = getmatchrulesdata("commonOption", "roundSwitch");
  setdynamicdvar("scr_" + level.gametype + "_roundSwitch", var_05);
  registerroundswitchdvar(level.gametype, var_05, 0, 9);
  var_06 = getmatchrulesdata("commonOption", "winByTwoEnabled");
  setdynamicdvar("scr_" + level.gametype + "_winByTwoEnabled", var_06);
  registerwinbytwoenableddvar(level.gametype, var_06);
  var_07 = getmatchrulesdata("commonOption", "winByTwoMaxRounds");
  setdynamicdvar("scr_" + level.gametype + "_winByTwoMaxRounds", var_07);
  registerwinbytwomaxroundsdvar(level.gametype, var_07);
  var_08 = getmatchrulesdata("commonOption", "dogTags");
  setdynamicdvar("scr_" + level.gametype + "_dogTags", var_08);
  registerdogtagsenableddvar(level.gametype, var_08);
  var_09 = getmatchrulesdata("commonOption", "spawnProtectionTimer");
  setdynamicdvar("scr_" + level.gametype + "_spawnProtectionTimer", var_09);
  var_10 = getmatchrulesdata("commonOption", "numLives");
  setdynamicdvar("scr_" + level.gametype + "_numLives", var_10);
  registernumlivesdvar(level.gametype, var_10);
  setdynamicdvar("scr_player_maxhealth", getmatchrulesdata("commonOption", "maxHealth"));
  setdynamicdvar("scr_player_healthregentime", getmatchrulesdata("commonOption", "healthRegen"));
  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = 0;
  setdynamicdvar("scr_game_spectatetype", getmatchrulesdata("commonOption", "spectateModeAllowed"));
  setdynamicdvar("scr_game_allowkillcam", getmatchrulesdata("commonOption", "showKillcam"));
  setdvar("camera_allow3rdspectate", getmatchrulesdata("commonOption", "spectate3rdAllowed"));
  setdvar("lobby_team_select", getmatchrulesdata("commonOption", "teamAssignmentAllowed"));
  setdynamicdvar("scr_game_forceuav", getmatchrulesdata("commonOption", "radarAlwaysOn"));
  setdynamicdvar("scr_" + level.gametype + "_playerrespawndelay", getmatchrulesdata("commonOption", "respawnDelay"));
  setdynamicdvar("scr_" + level.gametype + "_waverespawndelay", getmatchrulesdata("commonOption", "waveRespawnDelay"));
  setdynamicdvar("scr_player_forcerespawn", getmatchrulesdata("commonOption", "forceRespawn"));
  level.func_B409 = getmatchrulesdata("commonOption", "allowCustomClasses");
  level.supportintel = getmatchrulesdata("commonOption", "allowIntel");
  setdynamicdvar("scr_" + level.gametype + "_allowKillstreaks", getmatchrulesdata("commonOption", "allowKillstreaks"));
  setdynamicdvar("scr_" + level.gametype + "_allowPerks", getmatchrulesdata("commonOption", "allowPerks"));
  setdynamicdvar("scr_" + level.gametype + "_allowSupers", getmatchrulesdata("commonOption", "allowSupers"));
  setdynamicdvar("scr_" + level.gametype + "_ffPunishLimit", getmatchrulesdata("commonOption", "ffPunishLimit"));
  setdynamicdvar("scr_" + level.gametype + "_doubleJump", getmatchrulesdata("commonOption", "doubleJumpEnabled"));
  setdynamicdvar("scr_" + level.gametype + "_wallRun", getmatchrulesdata("commonOption", "wallRunEnabled"));
  setdynamicdvar("scr_game_casualScoreStreaks", getmatchrulesdata("commonOption", "casualScoreStreaks"));
  setdynamicdvar("scr_game_superFastChargeRate", getmatchrulesdata("commonOption", "superFastChargeRate"));
  setdynamicdvar("scr_game_superPointsMod", getmatchrulesdata("commonOption", "superPointsMod"));
  setdynamicdvar("scr_game_spawnProtectionTimer", getmatchrulesdata("commonOption", "spawnProtectionTimer"));
  level.crankedbombtimer = getmatchrulesdata("commonOption", "crankedBombTimer");
  setdynamicdvar("scr_" + level.gametype + "_crankedBombTimer", level.crankedbombtimer);
  func_DEE9(level.gametype, level.crankedbombtimer);
  setdynamicdvar("scr_game_tacticalmode", getmatchrulesdata("commonOption", "tacticalMode"));
  setdynamicdvar("scr_game_cwltuning", getmatchrulesdata("commonOption", "bulletBounce"));
  setdynamicdvar("scr_game_onlyheadshots", getmatchrulesdata("commonOption", "headshotsOnly"));

  if(!isdefined(var_00))
    setdynamicdvar("scr_team_fftype", getmatchrulesdata("commonOption", "friendlyFire"));

  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));
  setdynamicdvar("scr_" + level.gametype + "_pointsPerKill", getmatchrulesdata("commonOption", "pointsPerKill"));
  setdynamicdvar("scr_" + level.gametype + "_pointsPerDeath", getmatchrulesdata("commonOption", "pointsPerDeath"));
  setdynamicdvar("scr_" + level.gametype + "_pointsHeadshotBonus", getmatchrulesdata("commonOption", "pointsHeadshotBonus"));
  setdynamicdvar("scr_devRemoveDomFlag", "");
  setdynamicdvar("scr_devPlaceDomFlag", "");

  if(func_D957() || getdvarint("systemlink"))
    setdvar("com_codcasterEnabled", getmatchrulesdata("commonOption", "codcasterEnabled"));
}

func_DEE9(var_00, var_01) {
  registerwatchdvarint("crankedBombTimer", var_01);
}

func_F6A7() {}

func_B2AC(var_00) {
  leaderdialogonplayer(var_00);
  setcrankedplayerbombtimer("kill");
  self.cranked = 1;
  giveperk("specialty_fastreload");
  giveperk("specialty_quickdraw");
  giveperk("specialty_fastoffhand");
  giveperk("specialty_fastsprintrecovery");
  giveperk("specialty_marathon");
  giveperk("specialty_quickswap");
  giveperk("specialty_stalker");
  giveperk("specialty_sprintfire");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

oncranked(var_00, var_01, var_02) {
  if(isdefined(var_00))
    var_00 cleanupcrankedplayertimer();

  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);

  if(isdefined(var_1.cranked)) {
    var_03 = "kill_cranked";
    var_01 thread func_C4DD(var_03);
  } else if(isreallyalive(var_01)) {
    var_01 func_B2AC("begin_cranked");
    var_01 thread scripts\mp\rank::scoreeventpopup("begin_cranked");
  }

  var_01 playsoundtoplayer("mp_bodycount_tick_positive", var_01);

  if(isdefined(var_00) && isdefined(var_0.attackers) && !isdefined(level.assists_disabled)) {
    foreach(var_05 in var_0.attackers) {
      if(!isdefined(_validateattacker(var_05))) {
        continue;
      }
      if(var_05 == var_01) {
        continue;
      }
      if(var_00 == var_05) {
        continue;
      }
      if(!isdefined(var_5.cranked)) {
        continue;
      }
      var_05 thread func_C4DC("assist_cranked");
      var_05 thread scripts\mp\rank::scoreeventpopup("assist_cranked");
      var_05 playsoundtoplayer("mp_bodycount_tick_positive", var_05);
    }
  }
}

cleanupcrankedplayertimer() {
  self notify("stop_cranked");
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
}

func_C4DD(var_00) {
  level endon("game_ended");
  self endon("disconnect");

  while (!isdefined(self.pers))
    wait 0.05;

  setcrankedplayerbombtimer("kill");
}

func_C4DC(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  setcrankedplayerbombtimer("assist");
}

setcrankedplayerbombtimer(var_00) {
  var_01 = level.crankedbombtimer;
  var_02 = 0;

  if(level.gametype == "conf" || level.gametype == "grind")
    var_02 = 1;

  if(isdefined(var_02) && var_02) {
    if(isdefined(self.cranked) && self.cranked && isdefined(self.cranked_end_time))
      var_01 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
    else
      var_01 = int(var_01 * 0.5);
  }

  if(var_00 == "assist" && !var_02)
    var_01 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));

  var_03 = var_01 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_03);
  self.cranked_end_time = var_03;
  thread func_139E3();
  thread func_139E0(var_01);
  thread func_139E1();
}

func_139E3() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("stop_cranked");
  level waittill("host_migration_begin");
  var_00 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(self.cranked_end_time + var_00 < 5)
    self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);

  if(var_00 > 0)
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_00);
  else
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
}

func_139E1() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death");
  self endon("disconnect");
  self endon("stop_cranked");

  for (;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }

    wait 0.1;
  }
}

func_139E0(var_00) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_cranked");
  var_01 = 5;
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(var_00 - var_01 - 1);
  scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);

  while (var_01 > 0) {
    self playsoundtoplayer("mp_cranked_countdown", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
    var_1--;
  }

  if(isdefined(self) && isreallyalive(self) && level.gametype != "tdef") {
    self playsound("frag_grenade_explode");
    playfx(level.mine_explode, self.origin + (0, 0, 32));
    _suicide();
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  }
}

reinitializematchrulesonmigration() {
  for (;;) {
    level waittill("host_migration_begin");
    [
      [level.initializematchrules]
    ]();
  }
}

reinitializethermal(var_00) {
  self endon("disconnect");

  if(isdefined(var_00))
    var_00 endon("death");

  for (;;) {
    level waittill("host_migration_begin");

    if(isdefined(self.lastvisionsetthermal))
      self visionsetthermalforplayer(self.lastvisionsetthermal, 0);
  }
}

getmatchrulesspecialclass(var_00, var_01) {
  var_02 = [];
  var_2["loadoutPrimaryAttachment2"] = "none";
  var_2["loadoutSecondaryAttachment2"] = "none";
  var_03 = [];
  var_2["loadoutPrimary"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 0, "weapon");
  var_2["loadoutPrimaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 0, "attachment", 0);
  var_2["loadoutPrimaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 0, "attachment", 1);
  var_2["loadoutPrimaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 0, "camo");
  var_2["loadoutPrimaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 0, "reticle");
  var_2["loadoutSecondary"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 1, "weapon");
  var_2["loadoutSecondaryAttachment"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 1, "attachment", 0);
  var_2["loadoutSecondaryAttachment2"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 1, "attachment", 1);
  var_2["loadoutSecondaryCamo"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 1, "camo");
  var_2["loadoutSecondaryReticle"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "weaponSetups", 1, "reticle");
  var_2["loadoutPerks"] = var_03;
  var_2["loadoutKillstreak1"] = scripts\mp\class::recipe_getkillstreak(var_00, var_01, 0);
  var_2["loadoutKillstreak2"] = scripts\mp\class::recipe_getkillstreak(var_00, var_01, 1);
  var_2["loadoutKillstreak3"] = scripts\mp\class::recipe_getkillstreak(var_00, var_01, 2);
  var_2["loadoutJuggernaut"] = getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "juggernaut");
  return var_02;
}

func_DDD9(var_00) {
  level endon("game_ended");
  self endon("disconnect");

  if(level.ingraceperiod && !self.hasdonecombat)
    self waittill("giveLoadout");
  else
    self waittill("spawned_player");

  if(var_00) {
    self notify("lost_juggernaut");
    wait 0.5;
  }

  if(!isdefined(self.isjuiced)) {
    self.movespeedscaler = 0.7;
    scripts\mp\weapons::updatemovespeedscale();
  }

  self.func_A4AA = 0.7;
  self disableweaponpickup();

  if(!getdvarint("camera_thirdPerson"))
    self setclientomnvar("ui_juggernaut", 1);

  thread scripts\mp\killstreaks\juggernaut::func_A4A9();

  if(level.gametype != "jugg" || isdefined(level.matchrules_switchteamdisabled) && level.matchrules_switchteamdisabled)
    self setperk("specialty_radarjuggernaut", 1);

  if(isdefined(self.func_9E61) && self.func_9E61)
    self makeportableradar(self);

  level notify("juggernaut_equipped", self);
  thread scripts\mp\killstreaks\juggernaut::func_A4AC();
}

updatesessionstate(var_00, var_01) {
  switch (var_00) {
    case "intermission":
    case "playing":
      var_01 = "";
      break;
    case "dead":
    case "spectator":
      if(istrue(level.doingbroshot))
        var_01 = "";
      else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable))
          var_01 = "hud_status_dogtag";
        else
          var_01 = "hud_status_dead";
      } else
        var_01 = "hud_status_dead";

      break;
  }

  if(!isdefined(var_01))
    var_01 = "";

  self.sessionstate = var_00;
  self.statusicon = var_01;
  self setclientomnvar("ui_session_state", var_00);
}

getclassindex(var_00) {
  return level.classmap[var_00];
}

isteaminlaststand() {
  var_00 = getlivingplayers(self.team);

  foreach(var_02 in var_00) {
    if(var_02 != self && (!isdefined(var_2.laststand) || !var_2.laststand))
      return 0;
  }

  return 1;
}

func_A6C7(var_00) {
  var_01 = getlivingplayers(var_00);

  foreach(var_03 in var_01) {
    if(isdefined(var_3.laststand) && var_3.laststand)
      var_03 thread scripts\mp\damage::func_54C8(randomintrange(1, 3));
  }
}

func_1136C(var_00, var_01) {
  if(!isdefined(var_01))
    var_01 = 0;

  if(!isai(self)) {
    if(isdefined(var_00) && issuperweapon(var_00))
      var_00 = undefined;

    if(!isdefined(var_00)) {
      var_00 = scripts\engine\utility::getlastweapon();

      if(!self hasweapon(var_00))
        var_00 = scripts\mp\killstreaks\utility::getfirstprimaryweapon();

      func_1136C(var_00, var_01);
    }

    if(var_01)
      _switchtoweaponimmediate(var_00);
    else
      _switchtoweapon(var_00);
  } else
    _switchtoweapon("none");
}

isaiteamparticipant(var_00) {
  if(isagent(var_00) && var_0.agent_teamparticipant == 1)
    return 1;

  if(isbot(var_00))
    return 1;

  return 0;
}

isteamparticipant(var_00) {
  if(isaiteamparticipant(var_00))
    return 1;

  if(isplayer(var_00))
    return 1;

  return 0;
}

isaigameparticipant(var_00) {
  if(isagent(var_00) && isdefined(var_0.agent_gameparticipant) && var_0.agent_gameparticipant == 1)
    return 1;

  if(isbot(var_00))
    return 1;

  return 0;
}

isgameparticipant(var_00) {
  if(isaigameparticipant(var_00))
    return 1;

  if(isplayer(var_00))
    return 1;

  return 0;
}

isoffhandweaponreadytothrow(var_00) {
  var_01 = 0;

  if(level.teambased) {
    switch (var_00) {
      case "axis":
        var_01 = 1;
        break;
      case "allies":
        var_01 = 2;
        break;
    }
  }

  return var_01;
}

getteamarray(var_00, var_01) {
  var_02 = [];

  if(!isdefined(var_01) || var_01) {
    foreach(var_04 in level.characters) {
      if(isdefined(var_4.team) && var_4.team == var_00)
        var_2[var_2.size] = var_04;
    }
  } else {
    foreach(var_04 in level.players) {
      if(isdefined(var_4.team) && var_4.team == var_00)
        var_2[var_2.size] = var_04;
    }
  }

  return var_02;
}

isheadshot(var_00, var_01, var_02, var_03) {
  if(isdefined(var_03)) {
    if(isdefined(var_3.owner)) {
      if(var_3.code_classname == "script_vehicle")
        return 0;

      if(var_3.code_classname == "misc_turret")
        return 0;

      if(var_3.code_classname == "script_model")
        return 0;
    }

    if(isdefined(var_3.agent_type)) {
      if(var_3.agent_type == "dog" || var_3.agent_type == "alien")
        return 0;
    }
  }

  if(var_02 == "MOD_EXPLOSIVE")
    return 0;

  return (var_01 == "head" || var_01 == "helmet") && var_02 != "MOD_MELEE" && var_02 != "MOD_IMPACT" && var_02 != "MOD_SCARAB" && var_02 != "MOD_CRUSH" && !isenvironmentweapon(var_00);
}

func_9E7D(var_00, var_01, var_02, var_03) {
  if(var_03 != "MOD_MELEE")
    return 0;

  if(!isdefined(var_01) || !isplayer(var_01))
    return 0;

  if(var_01 scripts\mp\heavyarmor::hasheavyarmor())
    return 0;

  if(var_00 _hasperk("passive_meleekill") || var_00 _hasperk("passive_meleekill_silent"))
    return 1;

  if(scripts\mp\weapons::isknifeonly(var_02))
    return 1;

  if(scripts\mp\weapons::isballweapon(var_02))
    return 1;

  if(scripts\mp\weapons::isaxeweapon(var_02) && var_00 getweaponammoclip(var_02) > 0)
    return 1;

  if(var_00 _meth_8519(var_02) && getweaponrootname(var_02) == "iw7_rvn")
    return 1;

  if(issubstr(var_02, "iw7_katana_mp") || issubstr(var_02, "iw7_nunchucks_mp"))
    return 1;

  return 0;
}

attackerishittingteam(var_00, var_01) {
  if(isdefined(var_01) && isdefined(var_1.owner))
    var_01 = var_1.owner;

  if(!level.teambased)
    return 0;
  else if(!isdefined(var_01) || !isdefined(var_00))
    return 0;
  else if(!isdefined(var_0.team) || !isdefined(var_1.team))
    return 0;
  else if(var_00 == var_01)
    return 0;
  else if(level.gametype == "infect" && var_0.pers["team"] == var_1.team && isdefined(var_1.teamchangedthisframe))
    return 0;
  else if(level.gametype == "infect" && var_0.pers["team"] != var_1.team && isdefined(var_1.teamchangedthisframe))
    return 1;
  else if(isdefined(var_1.scrambled) && var_1.scrambled)
    return 0;
  else if(func_9EF6(var_00, var_01))
    return 0;
  else if(isagent(var_00) && isdefined(var_0.owner) && var_0.owner == var_01)
    return 0;
  else if(var_0.team == var_1.team)
    return 1;
  else
    return 0;
}

func_F401(var_00) {
  if(!(isdefined(self.high_priority_for) && scripts\engine\utility::array_contains(self.high_priority_for, var_00))) {
    self.high_priority_for = scripts\engine\utility::array_add(self.high_priority_for, var_00);
    var_00 notify("calculate_new_level_targets");
  }
}

func_1758(var_00, var_01) {
  if(isdefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.use_time = var_01;
    var_0.bot_interaction_type = "use";
    [
      [level.bot_funcs["bots_add_to_level_targets"]]
    ](var_00);
  }
}

func_E016(var_00) {
  if(isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_00);
}

func_1757(var_00) {
  if(isdefined(level.bot_funcs["bots_add_to_level_targets"])) {
    var_0.bot_interaction_type = "damage";
    [
      [level.bot_funcs["bots_add_to_level_targets"]]
    ](var_00);
  }
}

func_E015(var_00) {
  if(isdefined(level.bot_funcs["bots_remove_from_level_targets"]))
    [[level.bot_funcs["bots_remove_from_level_targets"]]](var_00);
}

notify_enemy_bots_bomb_used(var_00) {
  if(isdefined(level.bot_funcs["notify_enemy_bots_bomb_used"]))
    self[[level.bot_funcs["notify_enemy_bots_bomb_used"]]](var_00);
}

get_rank_xp_for_bot() {
  if(isdefined(level.bot_funcs["bot_get_rank_xp"]))
    return self[[level.bot_funcs["bot_get_rank_xp"]]]();
}

bot_israndom() {
  return self botisrandomized();
}

isassaultkillstreak(var_00) {
  switch (var_00) {
    case "uplink":
    case "vanguard":
    case "odin_assault":
    case "heli_pilot":
    case "airdrop_juggernaut_maniac":
    case "airdrop_assault":
    case "airdrop_juggernaut":
    case "airdrop_sentry_minigun":
    case "helicopter":
    case "guard_dog":
    case "ball_drone_backup":
    case "directional_uav":
    case "uav":
    case "ims":
    case "minijackal":
    case "drone_hive":
    case "sentry":
      return 1;
    default:
      return 0;
  }
}

func_9F25(var_00) {
  switch (var_00) {
    case "uav_3dping":
    case "aa_launcher":
    case "uplink_support":
    case "ball_drone_radar":
    case "sam_turret":
    case "uplink":
    case "orbital_deployment":
    case "odin_support":
    case "heli_sniper":
    case "airdrop_juggernaut_recon":
    case "recon_agent":
    case "ball_drone_backup":
    case "jammer":
    case "deployable_ammo":
    case "deployable_vest":
    case "air_superiority":
      return 1;
    default:
      return 0;
  }
}

issupportkillstreak(var_00) {
  switch (var_00) {
    case "deployable_adrenaline_mist":
    case "deployable_speed_strip":
    case "uav_3dping":
    case "aa_launcher":
    case "uplink_support":
    case "ball_drone_radar":
    case "sam_turret":
    case "odin_support":
    case "heli_sniper":
    case "airdrop_juggernaut_recon":
    case "recon_agent":
    case "jammer":
    case "deployable_ammo":
    case "deployable_vest":
    case "sentry_shock":
    case "air_superiority":
      return 1;
    default:
      return 0;
  }
}

isspecialistkillstreak(var_00) {
  switch (var_00) {
    case "specialty_chain_reaction_ks":
    case "specialty_deadeye_ks":
    case "specialty_boom_ks":
    case "specialty_twoprimaries_ks":
    case "specialty_hardline_ks":
    case "specialty_gambler_ks":
    case "specialty_explosivedamage_ks":
    case "specialty_extra_attachment_ks":
    case "specialty_extra_deadly_ks":
    case "specialty_extra_equipment_ks":
    case "specialty_extraammo_ks":
    case "specialty_gunsmith_ks":
    case "specialty_blastshield_ks":
    case "specialty_stun_resistance_ks":
    case "specialty_sharp_focus_ks":
    case "specialty_regenfaster_ks":
    case "specialty_falldamage_ks":
    case "specialty_comexp_ks":
    case "specialty_selectivehearing_ks":
    case "specialty_detectexplosive_ks":
    case "specialty_scavenger_ks":
    case "specialty_paint_ks":
    case "specialty_incog_ks":
    case "specialty_quieter_ks":
    case "specialty_gpsjammer_ks":
    case "specialty_blindeye_ks":
    case "specialty_silentkill_ks":
    case "specialty_sprintreload_ks":
    case "specialty_quickdraw_ks":
    case "specialty_bulletaccuracy_ks":
    case "specialty_pitcher_ks":
    case "specialty_quickswap_ks":
    case "specialty_reducedsway_ks":
    case "specialty_stalker_ks":
    case "specialty_marathon_ks":
    case "specialty_lightweight_ks":
    case "specialty_fastreload_ks":
    case "specialty_fastsprintrecovery_ks":
      return 1;
    default:
      return 0;
  }
}

bot_is_fireteam_mode() {
  var_00 = botautoconnectenabled() == 2;

  if(var_00) {
    if(!level.teambased || level.gametype != "war" && level.gametype != "dom")
      return 0;

    return 1;
  }

  return 0;
}

func_F305() {
  if(!scripts\engine\utility::add_init_script("platform", ::func_F305)) {
    return;
  }
  if(!isdefined(level.console))
    level.console = getdvar("consoleGame") == "true";
  else {}

  if(!isdefined(level.func_13E0F))
    level.func_13E0F = getdvar("xenonGame") == "true";
  else {}

  if(!isdefined(level.func_DADB))
    level.func_DADB = getdvar("ps3Game") == "true";
  else {}

  if(!isdefined(level.func_13E0E))
    level.func_13E0E = getdvar("xb3Game") == "true";
  else {}

  if(!isdefined(level.func_DADC))
    level.func_DADC = getdvar("ps4Game") == "true";
  else {}
}

func_9BEE() {
  if(level.func_13E0E || level.func_DADC || !level.console)
    return 1;
  else
    return 0;
}

func_F6DB(var_00, var_01, var_02) {
  if(!isdefined(level.console) || !isdefined(level.func_13E0E) || !isdefined(level.func_DADC))
    func_F305();

  if(func_9BEE())
    setdvar(var_00, var_02);
  else
    setdvar(var_00, var_01);
}

func_9FE7(var_00, var_01, var_02) {
  return isdefined(var_2.team) && var_2.team == var_01;
}

func_9FD8(var_00, var_01, var_02) {
  return isdefined(var_2.owner) && (!isdefined(var_00) || var_2.owner != var_00);
}

gethelipilotmeshoffset() {
  return (0, 0, 5000);
}

gethelipilottraceoffset() {
  return (0, 0, 2500);
}

func_7F78() {
  var_00 = [];

  if(isdefined(self.script_linkto)) {
    var_01 = strtok(self.script_linkto, " ");

    for (var_02 = 0; var_02 < var_1.size; var_2++) {
      var_03 = getnode(var_1[var_02], "script_linkname");

      if(isdefined(var_03))
        var_0[var_0.size] = var_03;
    }
  }

  return var_00;
}

get_players_watching(var_00, var_01) {
  if(!isdefined(var_00))
    var_00 = 0;

  if(!isdefined(var_01))
    var_01 = 0;

  var_02 = self getentitynumber();
  var_03 = [];

  foreach(var_05 in level.players) {
    if(var_05 == self) {
      continue;
    }
    var_06 = 0;

    if(!var_01) {
      if(isdefined(var_5.team) && (var_5.team == "spectator" || var_5.sessionstate == "spectator")) {
        var_07 = var_05 getspectatingplayer();

        if(isdefined(var_07) && var_07 == self)
          var_06 = 1;
      }

      if(var_5.forcespectatorclient == var_02)
        var_06 = 1;
    }

    if(!var_00) {
      if(var_5.killcamentity == var_02)
        var_06 = 1;
    }

    if(var_06)
      var_3[var_3.size] = var_05;
  }

  return var_03;
}

set_visionset_for_watching_players(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = get_players_watching(var_04, var_05);

  foreach(var_08 in var_06) {
    var_08 notify("changing_watching_visionset");

    if(isdefined(var_03) && var_03)
      var_08 visionsetmissilecamforplayer(var_00, var_01);
    else
      var_08 visionsetnakedforplayer(var_00, var_01);

    if(var_00 != "" && isdefined(var_02)) {
      var_08 thread reset_visionset_on_team_change(self, var_01 + var_02);
      var_08 thread reset_visionset_on_disconnect(self);

      if(var_08 isinkillcam())
        var_08 thread reset_visionset_on_spawn();
    }
  }
}

reset_visionset_on_spawn() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0.0);
}

reset_visionset_on_team_change(var_00, var_01) {
  self endon("changing_watching_visionset");
  var_02 = gettime();
  var_03 = self.team;

  while (gettime() - var_02 < var_01 * 1000) {
    if(self.team != var_03 || !scripts\engine\utility::array_contains(var_00 get_players_watching(), self)) {
      self visionsetnakedforplayer("", 0.0);
      self notify("changing_visionset");
      break;
    }

    wait 0.05;
  }
}

reset_visionset_on_disconnect(var_00) {
  self endon("changing_watching_visionset");
  var_00 waittill("disconnect");
  self visionsetnakedforplayer("", 0.0);
}

_validateattacker(var_00) {
  if(isagent(var_00) && (!isdefined(var_0.isactive) || !var_0.isactive))
    return undefined;

  if(isagent(var_00) && !isdefined(var_0.classname))
    return undefined;

  return var_00;
}

func_143B(var_00) {
  if(!isreallyalive(var_00))
    return undefined;

  return var_00;
}

_magicbullet(var_00, var_01, var_02, var_03, var_04) {
  var_05 = magicbullet(var_00, var_01, var_02, var_03, var_04);

  if(isdefined(var_05) && isdefined(var_03))
    var_05 setotherent(var_03);

  return var_05;
}

_launchgrenade(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = self launchgrenade(var_00, var_01, var_02, var_03, var_05);

  if(!isdefined(var_04))
    var_6.notthrown = 1;
  else
    var_6.notthrown = var_04;

  var_06 setotherent(self);
  return var_06;
}

func_1377B() {
  for (;;) {
    self waittill("grenade_fire", var_00, var_01, var_02, var_03);

    if(!func_85E0(var_00)) {
      continue;
    }
    _meth_85C6(var_00, var_01, var_02, var_03);
    self notify("grenade_throw");
    return var_00;
  }
}

func_85E0(var_00) {
  return !isdefined(var_0.notthrown) || !var_0.notthrown;
}

_meth_85C7() {
  return self _meth_854D() != "none";
}

func_7EE5() {
  var_00 = self _meth_854D();

  if(isdefined(self.gestureweapon) && var_00 == self.gestureweapon)
    var_00 = "none";

  return var_00;
}

_meth_85C6(var_00, var_01, var_02, var_03) {
  if(!isdefined(var_0.weapon_name))
    var_0.weapon_name = var_01;

  if(!isdefined(var_0.owner))
    var_0.owner = self;

  if(!isdefined(var_0.team))
    var_0.team = self.team;

  if(!isdefined(var_0.tickpercent))
    var_0.tickpercent = var_02;

  if(!isdefined(var_0.ticks) && isdefined(var_0.tickpercent))
    var_0.ticks = roundup(4 * var_02);

  var_04 = scripts\mp\powers::func_D737(var_01);

  if(isdefined(var_04)) {
    var_0.power = var_04;
    var_0.func_9F07 = 1;
  }

  var_0.threwback = isdefined(var_03);
}

waittill_missile_fire() {
  self waittill("missile_fire", var_00, var_01);

  if(isdefined(var_00)) {
    if(!isdefined(var_0.weapon_name))
      var_0.weapon_name = getweaponbasedsmokegrenadecount(var_01);

    if(!isdefined(var_0.owner))
      var_0.owner = self;

    if(!isdefined(var_0.team))
      var_0.team = self.team;
  }

  return var_00;
}

_setnameplatematerial(var_00, var_01) {
  if(!isdefined(self.func_BE4C)) {
    self.func_BE4C = [];
    self.func_D8B9 = [];
  } else {
    self.func_D8B9[0] = self.func_BE4C[0];
    self.func_D8B9[1] = self.func_BE4C[1];
  }

  self.func_BE4C[0] = var_00;
  self.func_BE4C[1] = var_01;
  self _meth_8315(var_00, var_01);
}

func_13B6() {
  if(isdefined(self.func_D8B9))
    self _meth_8315(self.func_D8B9[0], self.func_D8B9[1]);
  else
    self _meth_8315("", "");

  self.func_BE4C = undefined;
  self.func_D8B9 = undefined;
}

isplayeroutsideofanybombsite(var_00) {
  if(isdefined(level.bombzones)) {
    foreach(var_02 in level.bombzones) {
      if(self istouching(var_2.noweapondropallowedtrigger))
        return 0;
    }
  }

  return 1;
}

func_13C9A(var_00, var_01) {
  if(issuperweapon(var_00))
    return 1;

  var_00 = getweaponbasedsmokegrenadecount(var_00);

  if(var_00 == "heli_pilot_turret_mp" || var_00 == "bomb_site_mp" || var_00 == "sentry_shock_mp" || var_00 == "portal_grenade_mp" || var_00 == "blackout_grenade_mp" || var_00 == "concussion_grenade_mp" || var_00 == "cryo_mine_mp" || var_00 == "fear_grenade_mp" || var_00 == "chargemode_mp" || var_00 == "emp_grenade_mp" || var_00 == "minijackal_strike_mp" || var_00 == "bombproj_mp" || var_00 == "iw7_blackholegun_mp" || var_00 == "iw7_cheytac_mpr_projectile" || var_00 == "artillery_mp" || var_00 == "groundpound_mp" || var_00 == "drone_hive_projectile_mp" || var_00 == "swtich_blade_child_mp" || var_00 == "thorproj_mp" || var_00 == "thorproj_zoomed_mp" || var_00 == "thorproj_tracking_mp")
    return 1;

  if(var_00 == "iw7_revolver_mpr_explosive" && isdefined(var_01) && var_01 != "none")
    return 1;

  return 0;
}

func_9F7E(var_00, var_01, var_02, var_03) {
  if(!isdefined(var_01))
    return 0;

  if(!isdefined(var_1.stuckenemyentity))
    return 0;

  if(var_1.stuckenemyentity != var_00)
    return 0;

  return 1;
}

func_9F7F(var_00, var_01, var_02, var_03) {
  if(!func_9F7E(var_00, var_01, var_02, var_03))
    return 0;

  return 1;
}

restorebasevisionset(var_00) {
  self visionsetnakedforplayer("", var_00);
}

playplayerandnpcsounds(var_00, var_01, var_02) {
  var_00 playlocalsound(var_01);
  var_00 playsoundtoteam(var_02, "allies", var_00);
  var_00 playsoundtoteam(var_02, "axis", var_00);
}

isenemy(var_00) {
  if(level.teambased)
    return isplayeronenemyteam(var_00);
  else
    return isplayerffaenemy(var_00);
}

isplayeronenemyteam(var_00) {
  return var_0.team != self.team;
}

isplayerffaenemy(var_00) {
  if(isdefined(var_0.owner))
    return var_0.owner != self;
  else
    return var_00 != self;
}

setextrascore0(var_00) {
  self.extrascore0 = var_00;
  func_F7DF("extrascore0", var_00);
}

setextrascore1(var_00) {
  self.extrascore1 = var_00;
  func_F7DF("extrascore1", var_00);
}

func_1C9B() {
  if(level.gametype == "infect")
    return 0;

  return 1;
}

getuniqueid() {
  if(isdefined(self.pers["guid"]))
    return self.pers["guid"];

  var_00 = self _meth_812C();

  if(var_00 == "0000000000000000") {
    if(isdefined(level.guidgen))
      level.guidgen++;
    else
      level.guidgen = 1;

    var_00 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_00;
  return self.pers["guid"];
}

_meth_80BF() {
  var_00 = scripts\engine\utility::array_removeundefined(level.players);

  for (;;) {
    if(!var_0.size) {
      return;
    }
    var_01 = randomintrange(0, var_0.size);
    var_02 = var_0[var_01];

    if(!isreallyalive(var_02) || var_2.sessionstate != "playing") {
      var_00 = scripts\engine\utility::array_remove(var_00, var_02);
      continue;
    }

    return var_02;
  }
}

getmapname() {
  if(!isdefined(level.mapname))
    level.mapname = getdvar("mapname");

  return level.mapname;
}

issinglehitweapon(var_00) {
  var_00 = getweaponbasedsmokegrenadecount(var_00);

  switch (var_00) {
    case "iw7_chargeshot_mp":
    case "iw7_lockon_mp":
      return 1;
    default:
      return 0;
  }
}

gamehasneutralcrateowner(var_00) {
  switch (var_00) {
    case "sotf_ffa":
    case "sotf":
      return 1;
    default:
      return 0;
  }
}

func_22B1(var_00, var_01) {
  var_02 = [];

  foreach(var_05, var_04 in var_00) {
    if(var_04 != var_01)
      var_2[var_05] = var_04;
  }

  return var_02;
}

array_remove_index(var_00, var_01) {
  var_02 = [];

  for (var_03 = 0; var_03 < var_0.size; var_3++) {
    if(var_03 == var_01) {
      continue;
    }
    var_2[var_2.size] = var_0[var_03];
  }

  return var_02;
}

isanymlgmatch() {
  if(getdvarint("xblive_competitionmatch") || getdvarint("scr_game_cwltuning"))
    return 1;

  return 0;
}

ismlgsystemlink() {
  if(getdvarint("systemlink") && (getdvarint("xblive_competitionmatch") || getdvarint("scr_game_cwltuning")))
    return 1;

  return 0;
}

ismlgprivatematch() {
  if(func_D957() && (getdvarint("xblive_competitionmatch") || getdvarint("scr_game_cwltuning")))
    return 1;

  return 0;
}

ismlgmatch() {
  if(ismlgsystemlink() || ismlgprivatematch())
    return 1;

  return 0;
}

setmlgannouncement(var_00, var_01, var_02, var_03) {
  if(var_01 == "axis")
    var_00 = var_00 + 2000;
  else if(var_01 == "allies")
    var_00 = var_00 + 1000;

  if(isdefined(var_02))
    var_00 = var_00 + (var_02 + 1) * 10000;

  if(isdefined(var_03)) {
    if(isnumber(var_03))
      var_00 = var_00 + (var_03 + 1) * 1000000;
    else
      scripts\engine\utility::error("mlg announcement extra data supports numbers only. Invalid extra data: " + var_03);
  }

  setomnvar("ui_mlg_announcement", var_00);
}

ismoddedroundgame() {
  if(level.gametype == "ball" || level.gametype == "dom" || level.gametype == "front" || level.gametype == "ctf")
    return 1;

  return 0;
}

isusingdefaultclass(var_00, var_01) {
  var_02 = 0;

  if(isdefined(var_01)) {
    if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "inUse"))
      var_02 = 1;
  } else {
    for (var_01 = 0; var_01 < 6; var_1++) {
      if(isusingmatchrulesdata() && getmatchrulesdatawithteamandindex("defaultClasses", var_00, var_01, "class", "inUse")) {
        var_02 = 1;
        break;
      }
    }
  }

  return var_02;
}

func_3899(var_00) {
  var_01 = 1;

  if(isdefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom && (isdefined(self.func_3938) && !self[[self.func_3938]](var_00)))
    var_01 = 0;

  return var_01;
}

func_D911() {
  if(isdefined(self.func_A699))
    [[self.func_A699]]();
}

func_F5C6(var_00, var_01, var_02, var_03) {
  var_04 = self energy_getrestorerate(var_00);
  self.func_116D0 = 1;
  self goalflag(var_00, var_01);

  if(!isdefined(var_03) || !var_03)
    wait(var_02);
  else {
    var_05 = self energy_getmax(var_00);

    for (;;) {
      if(self goal_position(var_00) >= var_05) {
        break;
      }
      wait 0.05;
    }
  }

  self goalflag(var_00, var_04);
  self.func_116D0 = 0;
}

func_F5C5(var_00, var_01, var_02, var_03) {
  var_04 = self energy_getresttimems(var_00);
  self.func_116D1 = 1;
  self goal_type(var_00, var_01);

  if(!isdefined(var_03) || !var_03)
    wait(var_02);
  else {
    var_05 = self energy_getmax(var_00);

    for (;;) {
      if(self goal_position(var_00) >= var_05) {
        break;
      }
      wait 0.05;
    }
  }

  self goal_type(var_00, var_04);
  self.func_116D1 = 0;
}

func_13AF(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(!isdefined(var_07))
    var_07 = 0;

  self radiusdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
}

delayentdelete(var_00) {
  self endon("death");
  wait(var_00);

  if(isdefined(self))
    self delete();
}

hashealthshield(var_00) {
  return isdefined(var_00) && isdefined(var_0.func_8CC8);
}

func_7EF7(var_00) {
  return int(var_00 * self.func_8CC9);
}

func_F741(var_00) {
  self.func_8CC8 = 1;

  if(!isdefined(self.func_8CC9))
    self.func_8CC9 = 1;

  var_00 = int(clamp(var_00, 0, 100));
  var_01 = (100 - var_00) / 100;

  if(var_01 < self.func_8CC9)
    self.func_8CC9 = var_01;
}

clearhealthshield() {
  self.func_8CC8 = undefined;
  self.func_8CC9 = undefined;
}

func_108CB(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnfx(scripts\engine\utility::getfx(var_02), var_01);
  triggerfx(var_05);

  foreach(var_07 in level.players) {
    var_08 = scripts\mp\damage::isfriendlyfire(var_00, var_07);

    if(var_07 == var_00 && isdefined(var_04))
      var_08 = var_04;

    if(!var_08)
      var_05 hidefromplayer(var_07);
  }

  var_10 = spawnfx(scripts\engine\utility::getfx(var_03), var_01);
  triggerfx(var_10);

  foreach(var_07 in level.players) {
    var_08 = scripts\mp\damage::isfriendlyfire(var_00, var_07);

    if(var_07 == var_00 && isdefined(var_04))
      var_08 = var_04;

    if(var_08)
      var_10 hidefromplayer(var_07);
  }

  var_13 = [];
  var_13[0] = var_05;
  var_13[1] = var_10;
  return var_13;
}

func_D486(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  foreach(var_09 in level.players) {
    if(!isdefined(var_09)) {
      continue;
    }
    if(isdefined(var_07) && scripts\engine\utility::array_contains(var_07, var_09)) {
      continue;
    }
    if(isdefined(var_05) && scripts\engine\utility::array_contains(var_05, var_09))
      var_10 = 1;
    else if(isdefined(var_06) && scripts\engine\utility::array_contains(var_06, var_09))
      var_10 = 0;
    else
      var_10 = func_9E05(var_02, var_09);

    if(var_10) {
      playfxontagforclients(var_03, var_00, var_01, var_09);
      continue;
    }

    playfxontagforclients(var_04, var_00, var_01, var_09);
  }
}

func_11071(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  foreach(var_09 in level.players) {
    if(!isdefined(var_09)) {
      continue;
    }
    if(isdefined(var_07) && scripts\engine\utility::array_contains(var_07, var_09)) {
      continue;
    }
    if(isdefined(var_05) && scripts\engine\utility::array_contains(var_05, var_09))
      var_10 = 1;
    else if(isdefined(var_06) && scripts\engine\utility::array_contains(var_06, var_09))
      var_10 = 0;
    else
      var_10 = func_9E05(var_02, var_09);

    if(var_10) {
      _stopfxontagforclients(var_03, var_00, var_01, var_09);
      continue;
    }

    _stopfxontagforclients(var_04, var_00, var_01, var_09);
  }
}

playteamfxforclient(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = undefined;

  if(self.team != var_00)
    var_06 = spawnfxforclient(scripts\engine\utility::getfx(var_03), var_01, self);
  else
    var_06 = spawnfxforclient(scripts\engine\utility::getfx(var_02), var_01, self);

  if(isdefined(var_06))
    triggerfx(var_06);

  var_06 thread delayentdelete(var_04);

  if(isdefined(var_05) && var_05)
    var_06 thread deleteonplayerdeathdisconnect(self);

  return var_06;
}

deleteonplayerdeathdisconnect(var_00) {
  self endon("death");
  var_00 scripts\engine\utility::waittill_any("death", "disconnect");
  self delete();
}

getmatchrulesdatawithteamandindex(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(var_01 == "axis")
    var_02 = var_02 + 6;

  if(isdefined(var_06))
    return getmatchrulesdata(var_00, var_02, var_03, var_04, var_05, var_06);
  else if(isdefined(var_05))
    return getmatchrulesdata(var_00, var_02, var_03, var_04, var_05);
  else
    return getmatchrulesdata(var_00, var_02, var_03, var_04);
}

func_7D91(var_00, var_01) {
  return var_00 * 5 + var_01;
}

clearscrambler(var_00, var_01, var_02, var_03) {
  var_04 = ["physicscontents_player"];
  return func_7E9B(var_00, var_01, var_02, var_03, physics_createcontents(var_04));
}

getplayersinradiusview(var_00, var_01, var_02, var_03) {
  var_04 = ["physicscontents_player"];
  var_05 = [];
  var_06 = func_7E9B(var_00, var_01, var_02, var_03, physics_createcontents(var_04));

  foreach(var_08 in var_06) {
    var_09 = undefined;
    var_10 = [var_08 gettagorigin("j_head"), var_08 gettagorigin("j_mainroot"), var_08 gettagorigin("tag_origin")];

    for (var_11 = 0; var_11 < var_10.size; var_11++) {
      if(!scripts\engine\trace::ray_trace_passed(var_00, var_10[var_11], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }
      if(!isdefined(var_09)) {
        var_5[var_5.size] = spawnstruct();
        var_5[var_5.size - 1].player = var_08;
        var_5[var_5.size - 1].visiblelocations = [];
        var_09 = 1;
      }

      var_5[var_5.size - 1].visiblelocations[var_5[var_5.size - 1].visiblelocations.size] = var_10[var_11];
    }
  }

  return var_05;
}

botpredictseepoint(var_00, var_01, var_02, var_03) {
  return func_7E9B(var_00, var_01, var_02, var_03, scripts\engine\trace::create_character_contents());
}

func_7E9B(var_00, var_01, var_02, var_03, var_04) {
  if(var_01 <= 0)
    return [];

  var_05 = undefined;

  if(isdefined(var_03)) {
    if(isarray(var_03))
      var_05 = var_03;
    else
      var_05 = [var_03];
  }

  var_06 = physics_querypoint(var_00, var_01, var_04, var_05, "physicsquery_all");
  var_07 = [];

  if(!isdefined(var_02)) {
    foreach(var_09 in var_06) {
      var_10 = var_9["entity"];
      var_7[var_7.size] = var_10;
    }
  } else {
    foreach(var_09 in var_06) {
      var_10 = var_9["entity"];

      if(isdefined(var_10.team) && var_10.team == var_02)
        var_7[var_7.size] = var_10;
    }
  }

  return var_07;
}

roundup(var_00) {
  if(var_00 - int(var_00) >= 0.5)
    return int(var_00 + 1);
  else
    return int(var_00);
}

func_9E05(var_00, var_01) {
  if(!level.teambased)
    return 0;

  if(!isplayer(var_01) && !isdefined(var_1.team))
    return 0;

  if(var_00 != var_1.team)
    return 0;

  return 1;
}

playersareenemies(var_00, var_01) {
  if(!isdefined(var_00) || !isdefined(var_01))
    return undefined;

  if(!isdefined(var_0.team) || !isdefined(var_1.team))
    return undefined;

  if(level.teambased)
    return var_0.team != var_1.team;
  else
    return var_00 != var_01;
}

istrue(var_00) {
  return isdefined(var_00) && var_00;
}

adddamagemodifier(var_00, var_01, var_02, var_03) {
  if(!isdefined(var_02))
    var_02 = 1;

  if(var_02) {
    if(!isdefined(self.additivedamagemodifiers))
      self.additivedamagemodifiers = [];

    self.additivedamagemodifiers[var_00] = var_01;

    if(isdefined(var_03)) {
      if(!isdefined(self.func_17DE))
        self.func_17DE = [];

      self.func_17DE[var_00] = var_03;
    }
  } else {
    if(!isdefined(self.multiplicativedamagemodifiers))
      self.multiplicativedamagemodifiers = [];

    self.multiplicativedamagemodifiers[var_00] = var_01;

    if(isdefined(var_03)) {
      if(!isdefined(self.func_BDC7))
        self.func_BDC7 = [];

      self.func_BDC7[var_00] = var_03;
    }
  }
}

removedamagemodifier(var_00, var_01) {
  if(!isdefined(var_01))
    var_01 = 1;

  if(var_01) {
    if(!isdefined(self.additivedamagemodifiers)) {
      return;
    }
    self.additivedamagemodifiers[var_00] = undefined;

    if(!isdefined(self.func_17DE)) {
      return;
    }
    self.func_17DE[var_00] = undefined;
  } else {
    if(!isdefined(self.multiplicativedamagemodifiers)) {
      return;
    }
    self.multiplicativedamagemodifiers[var_00] = undefined;

    if(!isdefined(self.func_BDC7)) {
      return;
    }
    self.func_BDC7[var_00] = undefined;
  }
}

getdamagemodifiertotal(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = 1.0;

  if(isdefined(self.additivedamagemodifiers)) {
    foreach(var_11, var_09 in self.additivedamagemodifiers) {
      var_10 = 0;

      if(isdefined(self.func_17DE) && isdefined(self.func_17DE[var_11]))
        var_10 = [
          [self.func_17DE[var_11]]
        ](var_00, var_01, var_02, var_03, var_04, var_05, var_06);

      if(!var_10)
        var_07 = var_07 + (var_09 - 1.0);
    }
  }

  var_12 = 1.0;

  if(isdefined(self.multiplicativedamagemodifiers)) {
    foreach(var_11, var_09 in self.multiplicativedamagemodifiers) {
      var_10 = 0;

      if(isdefined(self.func_BDC7) && isdefined(self.func_BDC7[var_11]))
        var_10 = [
          [self.func_BDC7[var_11]]
        ](var_00, var_01, var_02, var_03, var_04, var_05, var_06);

      if(!var_10)
        var_12 = var_12 * var_09;
    }
  }

  return var_07 * var_12;
}

cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.func_17DE = [];
  self.func_BDC7 = [];
}

_enablecollisionnotifies(var_00) {
  if(!isdefined(self.enabledcollisionnotifies))
    self.enabledcollisionnotifies = 0;

  if(var_00) {
    if(self.enabledcollisionnotifies == 0)
      self enablecollisionnotifies(1);

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1)
      self enablecollisionnotifies(0);

    self.enabledcollisionnotifies--;
  }
}

func_1C4A(var_00) {
  if(self.loadoutarchetype != "archetype_heavy") {
    return;
  }
  if(var_00) {
    if(!isdefined(self.func_55CB))
      self.func_55CB = 0;

    self.func_55CB--;

    if(!self.func_55CB)
      self allowgroundpound(1);
  } else {
    if(!isdefined(self.func_55CB))
      self.func_55CB = 0;

    self.func_55CB++;
    self allowgroundpound(0);
  }
}

func_1C41(var_00) {
  if(self.loadoutarchetype != "archetype_scout") {
    return;
  }
  if(var_00) {
    if(!isdefined(self.func_55C4))
      self.func_55C4 = 0;

    self.func_55C4--;

    if(!self.func_55C4)
      self allowdodge(1);
  } else {
    if(!isdefined(self.func_55C4))
      self.func_55C4 = 0;

    self.func_55C4++;
    self allowdodge(0);
  }
}

func_1C47(var_00) {
  if(var_00) {
    if(!isdefined(self.func_55C9))
      self.func_55C9 = 0;
    else
      self.func_55C9--;

    if(!self.func_55C9) {
      if(scripts\engine\utility::is_player_gamepad_enabled())
        _setactionslot(3, "taunt");
      else
        _setactionslot(7, "taunt");
    }
  } else {
    if(!isdefined(self.func_55C9))
      self.func_55C9 = 0;

    self.func_55C9++;

    if(scripts\engine\utility::is_player_gamepad_enabled())
      _setactionslot(3, "");
    else
      _setactionslot(7, "");
  }
}

func_13A1E(var_00, var_01, var_02, var_03, var_04) {
  self endon("disconnect");
  self endon("end_entities_in_radius");
  level endon("game_ended");

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    var_05 = undefined;

    if(var_04)
      var_05 = clearscrambler(self.origin, var_00);
    else
      var_05 = func_7E9B(self.origin, var_00);

    if(var_5.size > 0) {
      if(!var_03)
        self notify(var_01, var_05);
      else {
        var_06 = [];

        foreach(var_08 in var_05) {
          var_09 = self getorigin();
          var_10 = scripts\engine\utility::ter_op(var_04, var_08 geteye(), var_8.origin);
          var_11 = physics_createcontents(["physicscontents_solid", "physicscontents_structural", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_canshootclip"]);
          var_12 = physics_raycast(var_09, var_10, var_11, undefined, 0, "physicsquery_closest");

          if(var_12.size <= 0)
            var_6[var_6.size] = var_08;
        }

        self notify(var_01, var_06);
      }
    }

    wait(var_02);
  }
}

func_3880() {
  self notify("end_entities_in_radius");
}

isleft2d(var_00, var_01, var_02) {
  var_03 = (var_0[0], var_0[1], 0);
  var_04 = (var_2[0], var_2[1], 0);
  var_05 = var_04 - var_03;
  var_06 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

radiusplayerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isdefined(var_09))
    var_09 = 0;

  var_10 = scripts\engine\trace::create_character_contents();
  var_11 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0);
  var_12 = [];

  foreach(var_14 in level.characters) {
    if(!isdefined(var_14)) {
      continue;
    }
    if(!isreallyalive(var_14)) {
      var_12[var_12.size] = var_14;
      continue;
    }

    if(var_09 && var_14 == var_05) {
      var_12[var_12.size] = var_14;
      continue;
    }

    if(level.teambased && var_14.team == var_5.team)
      var_12[var_12.size] = var_14;
  }

  var_16 = physics_querypoint(var_5.origin, var_02, var_10, var_12, "physicsquery_all");

  if(isdefined(var_16) && var_16.size > 0) {
    for (var_17 = 0; var_17 < var_16.size; var_17++) {
      var_18 = var_16[var_17]["entity"];
      var_19 = var_16[var_17]["distance"];
      var_20 = var_16[var_17]["position"];
      var_21 = physics_raycast(var_00, var_20, var_11, undefined, 0, "physicsquery_closest");

      if(isdefined(var_21) && var_21.size > 0) {
        continue;
      }
      var_22 = max(var_19, var_01) / var_02;
      var_23 = var_03 + (var_04 - var_03) * var_22;
      var_18 getrandomarmkillstreak(var_23, var_00, var_05, var_06, var_07, var_08);
    }
  }
}

func_9EAF(var_00) {
  var_01 = 0;

  switch (var_00) {
    case "orbital_deployment":
      return 1;
  }

  return var_01;
}

func_1824(var_00, var_01, var_02) {
  func_50A5(var_00, var_02);

  if(isdefined(var_02))
    self.func_EC52[var_00][var_02] = self.func_EC52[var_00][var_02] + var_01;
  else
    self.func_EC51[var_00] = self.func_EC51[var_00] + var_01;
}

func_E165(var_00, var_01, var_02) {
  func_50A5(var_00, var_02);

  if(isdefined(var_02))
    self.func_EC52[var_00][var_02] = self.func_EC52[var_00][var_02] - var_01;
  else
    self.func_EC51[var_00] = self.func_EC51[var_00] - var_01;
}

_meth_8101(var_00, var_01) {
  func_50A5(var_00, var_01);

  if(isdefined(var_01))
    return self.func_EC52[var_00][var_01];
  else
    return self.func_EC51[var_00];
}

func_50A5(var_00, var_01) {
  if(!isdefined(self.func_EC52))
    self.func_EC52 = [];

  if(!isdefined(self.func_EC51))
    self.func_EC51 = [];

  if(isdefined(var_01)) {
    if(!isdefined(self.func_EC52[var_00]))
      self.func_EC52[var_00] = [];

    if(!isdefined(self.func_EC52[var_00][var_01]))
      self.func_EC52[var_00][var_01] = 1;
  } else if(!isdefined(self.func_EC51[var_00]))
    self.func_EC51[var_00] = 1;
}

func_DE39(var_00) {
  foreach(var_03, var_02 in self.powers)
  func_DE38(var_03, var_00);
}

func_DE38(var_00, var_01) {
  var_02 = self.powers[var_00];
  var_03 = level.powers[var_00];
  var_04 = var_3.cooldowntime;
  var_05 = var_2.func_4617;

  if(!isdefined(var_04) || !isdefined(var_05) || var_05 <= 0 || var_05 >= var_04) {
    return;
  }
  var_05 = var_05 + var_01;

  if(var_05 >= var_04)
    var_05 = var_04;

  scripts\mp\powers::func_D74F(var_00, var_05);
}

pointvscone(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = var_00 - var_01;
  var_09 = vectordot(var_08, var_02);
  var_10 = vectordot(var_08, var_03);

  if(var_09 > var_04)
    return 0;

  if(var_09 < var_05)
    return 0;

  if(isdefined(var_07)) {
    if(abs(var_10) > var_07)
      return 0;
  }

  if(scripts\engine\utility::anglebetweenvectors(var_02, var_08) > var_06)
    return 0;

  return 1;
}

func_D64A(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_04 - var_02;
  var_06 = vectordot(var_05, var_03);

  if(var_06 < 0 || var_06 > var_01)
    return 0;

  var_05 = var_05 - var_06 * var_03;
  var_07 = lengthsquared(var_05);

  if(var_07 > var_00)
    return 0;

  return 1;
}

func_1319B(var_00, var_01) {
  var_02 = vectorcross(var_00, var_01);
  var_01 = vectorcross(var_02, var_00);
  var_03 = _axistoangles(var_00, var_02, var_01);
  return var_03;
}

func_9EF6(var_00, var_01) {
  var_02 = 0;

  if(isagent(var_00) && isdefined(var_0.agent_type) && var_0.agent_type == "playerProxy") {
    if(var_0.owner == var_01)
      var_02 = 1;
  }

  return var_02;
}

givestreakpointswithtext(var_00, var_01, var_02) {
  if(isdefined(level.ignorescoring)) {
    return;
  }
  if(isdefined(var_02))
    var_03 = var_02;
  else
    var_03 = scripts\mp\rank::getscoreinfovalue(var_00);

  var_03 = func_B93D(var_00, var_03, var_01);
  scripts\mp\killstreaks\killstreaks::_meth_83A7(var_00, var_03);
  displayscoreeventpoints(var_03, var_00);

  if(var_00 == "assist_hardline")
    scripts\mp\missions::func_D991("ch_hardline_extra_score", var_03);
}

giveunifiedpoints(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isdefined(level.ignorescoring) && !issubstr(var_00, "assist")) {
    return;
  }
  if(isdefined(var_02))
    var_06 = var_02;
  else
    var_06 = scripts\mp\rank::getscoreinfovalue(var_00);

  var_06 = func_B93D(var_00, var_06, var_01);
  scripts\mp\gamescore::giveplayerscore(var_00, var_06);
  scripts\mp\killstreaks\killstreaks::_meth_83A7(var_00, var_06);

  if(!istrue(var_05))
    thread scripts\mp\rank::giverankxp(var_00, var_06, var_01);

  if(shouldgivesuperpoints(var_00) && var_06 > 0)
    scripts\mp\supers::stopshellshock(var_06);

  if(!istrue(var_04))
    displayscoreeventpoints(var_06, var_00);
}

displayscoreeventpoints(var_00, var_01) {
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    foreach(var_03 in level.players) {
      if(var_03 ismlgspectator()) {
        var_04 = var_03 getspectatingplayer();

        if(isdefined(var_04)) {
          var_05 = var_04 getentitynumber();
          var_06 = self getentitynumber();

          if(var_05 == var_06) {
            var_03 thread scripts\mp\rank::scorepointspopup(var_00);
            var_03 thread scripts\mp\rank::scoreeventpopup(var_01);
          }
        }
      }
    }
  }

  if(!isdefined(level.func_10269)) {
    var_08 = 0;

    if(issimultaneouskillenabled())
      var_08 = var_01 == "kill";

    thread scripts\mp\rank::scorepointspopup(var_00, var_08);
  }

  thread scripts\mp\rank::scoreeventpopup(var_01);
}

func_B93D(var_00, var_01, var_02) {
  var_03 = var_01;

  switch (var_00) {
    case "damage":
      return 0;
    default:
      break;
  }

  var_04 = 0;
  var_04 = var_04 + scripts\mp\supers\super_amplify::func_1E58(var_03);
  var_05 = _meth_8101(var_00, var_02);
  var_05 = var_05 - 1;
  var_04 = var_04 + var_03 * var_05;
  var_01 = var_01 + var_04;

  if(isdefined(level.modifyunifiedpointscallback))
    var_01 = [
      [level.modifyunifiedpointscallback]
    ](var_01, var_00, self, var_02);

  return int(var_01);
}

shouldgivesuperpoints(var_00) {
  switch (var_00) {
    case "super_pack":
    case "scorestreak_pack":
    case "battery_pack":
      return 0;
    case "medal_mode_sd_last_defuse_score":
    case "medal_mode_sd_defuse_score":
    case "plant":
      return !isanymlgmatch();
    default:
      return 1;
  }
}

func_248F(var_00) {
  if(isdefined(var_00) && scripts\engine\utility::string_starts_with(var_00, "mod_"))
    return 1;

  return 0;
}

func_248E(var_00) {
  return isdefined(var_00) && scripts\engine\utility::string_starts_with(var_00, "cos_");
}

_hudoutlineviewmodeldisable() {
  if(!isreallyalive(self)) {
    return;
  }
  self _meth_8192();
}

_hudoutlineviewmodelenable(var_00, var_01, var_02) {
  if(!isdefined(var_01))
    var_01 = 0;

  if(!isdefined(var_02))
    var_02 = 0;

  if(!isplayer(self)) {}

  if(!var_01 && !isreallyalive(self)) {}

  if(var_01 && !isreallyalive(self)) {
    thread func_91AE(var_00);
    return;
  }

  self gettag(var_00, var_02);
}

func_91AE(var_00) {
  level endon("game_ended");
  self waittill("spawned");

  if(!isdefined(self)) {
    return;
  }
  if(!isreallyalive(self)) {
    return;
  }
  if(!isplayer(self)) {
    return;
  }
  self gettag(var_00);
}

func_627A(var_00, var_01) {
  if(var_00) {
    _physics_setgravityragdollscalar(var_01);
    level.func_DC24 = 1;
  } else {
    _physics_setgravityragdollscalar(1.0);
    level.func_DC24 = undefined;
  }
}

isragdollzerog() {
  return istrue(level.func_DC24);
}

isbombsiteweapon(var_00) {
  if(!isdefined(var_00))
    return 0;

  switch (var_00) {
    case "briefcase_bomb_mp":
    case "bomb_site_mp":
      return 1;
  }

  return 0;
}

isgesture(var_00) {
  if(issubstr(var_00, "ges_plyr"))
    return 1;
  else if(issubstr(var_00, "devilhorns_mp"))
    return 1;
  else
    return 0;
}

iskillstreakweapon(var_00) {
  if(!isdefined(var_00))
    return 0;

  if(var_00 == "none")
    return 0;

  if(scripts\engine\utility::isdestructibleweapon(var_00))
    return 0;

  if(isbombsiteweapon(var_00))
    return 0;

  if(isgesture(var_00))
    return 0;

  if(issubstr(var_00, "killstreak"))
    return 1;

  if(issubstr(var_00, "remote_tank_projectile"))
    return 1;

  if(issubstr(var_00, "minijackal_"))
    return 1;

  if(isdefined(level.killstreakweildweapons) && isdefined(level.killstreakweildweapons[var_00]))
    return 1;

  var_00 = func_1717(var_00);

  if(scripts\engine\utility::isairdropmarker(var_00))
    return 1;

  var_01 = weaponinventorytype(var_00);

  if(isdefined(var_01) && var_01 == "exclusive")
    return 1;

  return 0;
}

func_1717(var_00) {
  if(issubstr(var_00, "iw7") || issubstr(var_00, "iw6")) {
    var_01 = getweaponrootname(var_00);
    var_00 = func_13C75(var_01);

    if(var_00 == var_01)
      var_00 = var_00 + "_mp";
  } else {
    var_02 = strtok(var_00, "_");

    if(!scripts\engine\utility::string_starts_with(var_2[var_2.size - 1], "mp"))
      var_00 = var_00 + "_mp";
  }

  return var_00;
}

placeequipmentfailed(var_00, var_01, var_02, var_03) {
  self playlocalsound("scavenger_pack_pickup");

  if(istrue(var_01)) {
    var_04 = undefined;

    if(isdefined(var_03))
      var_04 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_02, self, anglestoforward(var_03), anglestoup(var_03));
    else
      var_04 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_02, self);

    triggerfx(var_04);
    thread placeequipmentfailedcleanup(var_04);
  }

  switch (var_00) {
    case "micro_turret_mp":
    case "shard_ball_mp":
    case "deployable_cover_mp":
    case "trophy_mp":
    case "domeshield_mp":
    case "cryo_mine_mp":
    case "trip_mine_mp":
    case "blackhole_grenade_mp":
      if(isplayer(self) && isreallyalive(self)) {
        self iprintlnbold("Placement Failed");
        return;
      }
  }
}

func_CC18() {
  level._effect["placeEquipmentFailed"] = loadfx("vfx\core\mp\killstreaks\vfx_ballistic_vest_death");
}

placeequipmentfailedcleanup(var_00) {
  wait 2;
  var_00 delete();
}

bufferednotify(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  thread bufferednotify_internal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
}

bufferednotify_internal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  self endon("disconnect");
  level endon("game_ended");
  var_09 = "bufferedNotify_" + var_00;
  self notify(var_09);
  self endon(var_09);

  if(!isdefined(self.bufferednotifications))
    self.bufferednotifications = [];

  if(!isdefined(self.bufferednotifications[var_00]))
    self.bufferednotifications[var_00] = [];

  var_10 = spawnstruct();
  var_10.func_C8E5 = var_01;
  var_10.func_C8E6 = var_02;
  var_10.func_C8E7 = var_03;
  var_10.func_C8E8 = var_04;
  var_10.func_C8E9 = var_05;
  var_10.func_C8EA = var_06;
  var_10.func_C8EB = var_07;
  var_10.func_C8EC = var_08;
  self.bufferednotifications[var_00][self.bufferednotifications[var_00].size] = var_10;
  waittillframeend;

  while (self.bufferednotifications[var_00].size > 0) {
    var_10 = self.bufferednotifications[var_00][0];
    self notify(var_00, var_10.func_C8E5, var_10.func_C8E6, var_10.func_C8E7, var_10.func_C8E8, var_10.func_C8E9, var_10.func_C8EA, var_10.func_C8EB, var_10.func_C8EC);
    self.bufferednotifications[var_00] = array_remove_index(self.bufferednotifications[var_00], 0);
    wait 0.05;
  }
}

aiclearanim() {
  if(level.rankedmatch)
    return "mp";

  return "mp_private";
}

clearalltextafterhudelem() {
  if(level.rankedmatch)
    return "rankedloadouts";

  return "privateloadouts";
}

func_F7F1() {
  level.func_10E59 = aiclearanim();
  level.loadoutsgroup = clearalltextafterhudelem();
}

func_F751() {
  self.func_9331 = 1;
}

func_41BA() {
  self.func_9331 = undefined;
}

notifyafterframeend(var_00, var_01) {
  self waittill(var_00);
  waittillframeend;
  self notify(var_01);
}

func_7F9B() {
  return 3;
}

getmaxoutofboundscooldown() {
  return 3;
}

getcurrentmonitoredweaponswitchweapon() {
  validatelistener();
  var_00 = self _meth_856D();

  if(!isdefined(var_00) || var_00 == "none")
    return undefined;

  return var_00;
}

isanymonitoredweaponswitchinprogress() {
  return isdefined(getcurrentmonitoredweaponswitchweapon());
}

isreliablyswitchingtoweapon(var_00) {
  var_01 = getcurrentmonitoredweaponswitchweapon();
  return isdefined(var_01) && var_01 == var_00 && !iscurrentweapon(var_00);
}

func_391B(var_00) {
  if(!self hasweapon(var_00))
    return 0;

  var_01 = getcurrentmonitoredweaponswitchweapon();

  if(isdefined(var_01)) {
    var_02 = 0;

    if(var_00 == "briefcase_bomb_mp" || var_00 == "briefcase_bomb_defuse_mp" || var_00 == "iw7_uplinkball_mp" || var_00 == "iw7_tdefball_mp")
      var_02 = 1;
    else if(weaponinventorytype(var_01) == "primary")
      var_02 = 1;

    if(!var_02)
      return 0;
  }

  if(iscurrentweapon(var_00))
    return 0;

  return 1;
}

func_1529(var_00) {
  func_4F5B("+++ ABORT - " + var_00);

  if(self _meth_856D() == var_00)
    self _meth_8570(var_00);

  _takeweapon(var_00);
  return;
}

_visionsetnaked(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(!isdefined(var_03)) {
      continue;
    }
    if(isai(var_03)) {
      continue;
    }
    var_03 visionsetnakedforplayer(var_00, var_01);
  }

  return;
}

func_11383(var_00, var_01) {
  self endon("disconnect");
  self endon("death");
  func_4F5B(">>> BEGIN switchToWeaponReliable() - " + var_00);

  if(!func_391B(var_00)) {
    func_4F5B(">>> FAIL (early) switchToWeaponReliable() - " + var_00);
    return 0;
  }

  if(isanymonitoredweaponswitchinprogress())
    self _meth_8570(getcurrentmonitoredweaponswitchweapon());

  self _meth_856F(var_00);

  if(istrue(var_01))
    _switchtoweaponimmediate(var_00);

  for (;;) {
    if(iscurrentweapon(var_00)) {
      validatelistener();
      func_4F5B(">>> SUCCESS switchToWeaponReliable() - " + var_00);
      return 1;
    }

    if(!self _meth_856E(var_00) || !self hasweapon(var_00)) {
      func_4F5B(">>> FAIL switchToWeaponReliable() - " + var_00);
      return 0;
    }

    scripts\engine\utility::waitframe();
  }
}

validatelistener() {
  var_00 = self getcurrentweapon();

  if(self _meth_856E(var_00))
    self _meth_8570(var_00);
}

forcethirdpersonwhenfollowing(var_00) {
  self endon("death");
  self endon("disconnect");

  if(!self hasweapon(var_00)) {
    return;
  }
  if(!iscurrentweapon(var_00)) {
    _takeweapon(var_00);
    return;
  }

  while (isanymonitoredweaponswitchinprogress())
    scripts\engine\utility::waitframe();

  if(!iscurrentweapon(var_00)) {
    _takeweapon(var_00);
    return;
  }

  var_01 = undefined;

  if(isbot(self))
    var_01 = 1;

  var_02 = func_11383(self.lastdroppableweaponobj, var_01);
  _takeweapon(var_00);
  self notify("bomb_allow_offhands");

  if(!var_02)
    func_72ED();
}

func_72ED(var_00) {
  self endon("death");
  self endon("disconnect");

  while (self getcurrentweapon() == "none") {
    if(self isswitchingweapon() || isanymonitoredweaponswitchinprogress()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_01 = var_00;

    if(!isdefined(var_01) || !self hasweapon(var_01)) {
      if(!isdefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj == "none") {
        break;
      }
      var_01 = self.lastdroppableweaponobj;
    }

    var_02 = getcurrentprimaryweaponsminusalt();

    if(isdefined(var_01) && getweaponbasedsmokegrenadecount(var_01) == "iw7_axe_mp" && self getweaponammoclip(var_01) == 0 && var_2.size == 1)
      var_01 = "iw7_fists_mp";

    func_11383(var_01);
    scripts\engine\utility::waitframe();
  }
}

iscurrentweapon(var_00) {
  var_01 = self getcurrentweapon();

  if(isstrstart(var_00, "alt_"))
    var_00 = getsubstr(var_00, 4);

  if(isstrstart(var_01, "alt_"))
    var_01 = getsubstr(var_01, 4);

  return var_01 == var_00;
}

func_9F72(var_00) {
  return istrue(var_0.func_9F72);
}

func_9F22(var_00) {
  if(!isdefined(var_0.func_165A))
    return 0;

  return var_0.func_165A == "remote_c8";
}

func_9F8C(var_00) {
  var_01 = var_00 getentitynumber();

  if(!isdefined(level.supertrophy))
    return 0;

  if(!isdefined(level.supertrophy.trophies))
    return 0;

  if(!isdefined(level.supertrophy.trophies[var_01]))
    return 0;

  return level.supertrophy.trophies[var_01] == var_00;
}

ismicroturret(var_00) {
  var_01 = var_00 getentitynumber();

  if(!isdefined(level.microturrets))
    return 0;

  if(!isdefined(level.microturrets[var_01]))
    return 0;

  return level.microturrets[var_01] == var_00;
}

isjackal(var_00) {
  if(!isdefined(var_0.streakinfo))
    return 0;

  if(!isdefined(var_0.streakinfo.streakname))
    return 0;

  return var_0.streakinfo.streakname == "jackal";
}

isturret(var_00) {
  return isdefined(var_0.classname) && var_0.classname == "misc_turret";
}

isdronepackage(var_00) {
  return isdefined(var_0.cratetype);
}

_enableignoreme() {
  if(!isdefined(self.enabledignoreme))
    self.enabledignoreme = 0;

  if(self.enabledignoreme == 0)
    self.ignoreme = 1;

  self.enabledignoreme++;
}

_disableignoreme() {
  if(self.enabledignoreme == 1)
    self.ignoreme = 0;

  self.enabledignoreme--;
}

_resetenableignoreme() {
  self.enabledignoreme = undefined;
  self.ignoreme = 0;
}

func_1254() {
  if(!isdefined(self.enabledequipdeployvfx))
    self.enabledequipdeployvfx = 0;

  if(self.enabledequipdeployvfx == 0)
    self getrankinfolevel(1);

  self.enabledequipdeployvfx++;
}

func_11DB() {
  if(self.enabledequipdeployvfx == 1)
    self getrankinfolevel(0);

  self.enabledequipdeployvfx--;
}

func_8EC6() {
  if(!isdefined(self.func_12B1F))
    self.func_8EC7 = 0;

  if(self.func_8EC7 == 0)
    self setclientomnvar("ui_hide_hud", 1);

  self.func_8EC7++;
}

func_8EC4() {
  if(self.func_8EC7 == 1)
    self setclientomnvar("ui_hide_hud", 0);

  self.func_8EC7--;
}

func_8ECD() {
  if(!isdefined(self.func_8ECE))
    self.func_8ECE = 0;

  if(self.func_8ECE == 0)
    self setclientomnvar("ui_hide_minimap", 1);

  self.func_8ECE++;
}

func_8ECC() {
  if(self.func_8ECE == 1)
    self setclientomnvar("ui_hide_minimap", 0);

  self.func_8ECE--;
}

func_4F5B(var_00) {}

iscontrollingproxyagent() {
  var_00 = 0;

  if(isdefined(self.playerproxyagent) && isalive(self.playerproxyagent))
    var_00 = 1;

  return var_00;
}

register_physics_collisions() {
  self endon("death");
  self endon("stop_phys_sounds");

  for (;;) {
    self waittill("collision", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
    level notify("physSnd", self, var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
  }
}

global_physics_sound_monitor() {
  level notify("physics_monitor");
  level endon("physics_monitor");

  for (;;) {
    level waittill("physSnd", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);

    if(isdefined(var_00) && isdefined(var_0.phys_sound_func))
      level thread[[var_0.phys_sound_func]](var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  }
}

register_physics_collision_func(var_00, var_01) {
  var_0.phys_sound_func = var_01;
}

func_9FAE(var_00) {
  return istrue(var_0.func_1D44);
}

istouchingboundsnullify(var_00) {
  var_01 = 0;

  if(isdefined(level.outofboundstriggerpatches) && level.outofboundstriggerpatches.size > 0) {
    foreach(var_03 in level.outofboundstriggerpatches) {
      if(isplayer(var_00) && var_00 istouching(var_03)) {
        if(isdefined(var_3.targetname) && var_3.targetname == "apex_unoutofbounds") {
          break;
        }
        var_01 = 1;
        break;
      } else if(!isplayer(var_00) && var_00 istouching(var_03)) {
        var_01 = 1;
        break;
      }
    }
  }

  return var_01;
}

printgameaction(var_00, var_01) {
  if(getdvarint("scr_suppress_game_actions", 0) == 1) {
    return;
  }
  var_02 = "";

  if(isdefined(var_01))
    var_02 = "[" + var_01 getentitynumber() + ":" + var_1.name + "] ";
}

delaysetclientomnvar(var_00, var_01, var_02) {
  self endon("disconnect");
  wait(var_00);
  self setclientomnvar(var_01, var_02);
}

isfemale() {
  return self.gender == "female";
}

canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && level.gametype != "infect" && (!isdefined(level.aonrules) || level.aonrules == 0);
}

getstreakrecordtype(var_00) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_00))
    return "lethalScorestreakStats";

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var_00))
    return "supportScorestreakStats";

  return undefined;
}

getlowestclientnum(var_00, var_01) {
  var_02 = undefined;

  foreach(var_04 in var_00) {
    if(var_4.team != "spectator" && (!var_01 || isreallyalive(var_04))) {
      if(!isdefined(var_02) || var_04 getentitynumber() < var_02)
        var_02 = var_04 getentitynumber();
    }
  }

  return var_02;
}

isspawnprotected() {
  return gettime() < self.spawntime + level.killstreakspawnshielddelayms;
}

getcurrentprimaryweaponsminusalt() {
  var_00 = [];
  var_01 = self getweaponslistprimaries();

  foreach(var_03 in var_01) {
    if(!issubstr(var_03, "alt_"))
      var_0[var_0.size] = var_03;
  }

  return var_00;
}

initarbitraryuptriggers() {
  if(isdefined(level.arbitraryuptriggers)) {
    return;
  }
  level.arbitraryuptriggers = [];
  level.arbitraryuptriggersstructs = [];

  if(getmapname() == "mp_junk") {
    var_00 = getentarray("mag_up", "targetname");

    if(!isdefined(var_00) || var_0.size == 0) {
      return;
    }
    level.arbitraryuptriggers = var_00;

    foreach(var_02 in var_00) {
      var_03 = var_02 getentitynumber();
      var_04 = spawnstruct();
      var_4.trigger = var_02;
      var_4.func_2857 = undefined;
      var_4.entsinside = [];

      if(isdefined(var_2.target)) {
        var_4.func_2857 = getent(var_2.target, "targetname");
        var_4.blinkloc = var_4.func_2857.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[var_03] = var_04;
      thread watcharbitraryuptriggerenter(var_04);
      thread watcharbitraryuptriggerexit(var_04);
    }
  }
}

watcharbitraryuptriggerenter(var_00) {
  for (;;) {
    var_0.trigger waittill("trigger", var_01);

    if(!isdefined(var_01)) {
      continue;
    }
    if(!shouldaddtoarbitraryuptrigger(var_00, var_01)) {
      continue;
    }
    var_02 = var_01 getentitynumber();
    var_0.entsinside[var_02] = var_01;
    var_1.arbitraryuptriggerstruct = var_00;
  }
}

watcharbitraryuptriggerexit(var_00) {
  for (;;) {
    foreach(var_02 in var_0.entsinside) {
      if(!isdefined(var_02)) {
        continue;
      }
      if(!shouldremovefromarbitraryuptrigger(var_00, var_02)) {
        continue;
      }
      var_03 = var_02 getentitynumber();
      var_0.entsinside[var_03] = undefined;

      if(isdefined(var_2.arbitraryuptriggerstruct) && var_2.arbitraryuptriggerstruct == var_00)
        var_2.arbitraryuptriggerstruct = undefined;
    }

    scripts\engine\utility::waitframe();
  }
}

shouldaddtoarbitraryuptrigger(var_00, var_01) {
  if(!isplayer(var_01))
    return 0;

  var_02 = var_01 getentitynumber();

  if(isdefined(var_0.entsinside[var_02]))
    return 0;

  return 1;
}

shouldremovefromarbitraryuptrigger(var_00, var_01) {
  if(!var_01 istouching(var_0.trigger))
    return 1;

  return 0;
}

getarbitraryuptrigger() {
  if(!isdefined(self.arbitraryuptriggerstruct))
    return undefined;

  return self.arbitraryuptriggerstruct.trigger;
}

getarbitraryuptriggerbase() {
  if(!isdefined(self.arbitraryuptriggerstruct))
    return undefined;

  return self.arbitraryuptriggerstruct.func_2857;
}

getarbitraryuptriggerblinkloc() {
  if(!isdefined(self.arbitraryuptriggerstruct))
    return undefined;

  return self.arbitraryuptriggerstruct.blinkloc;
}

isinarbitraryup() {
  if(isplayer(self)) {
    if(self getworldupreferenceangles() != (0, 0, 0))
      return 1;
  }

  return 0;
}

isprojectiledamage(var_00) {
  var_01 = "MOD_PROJECTILE MOD_IMPACT MOD_GRENADE MOD_HEAD_SHOT";

  if(issubstr(var_01, var_00))
    return 1;

  return 0;
}