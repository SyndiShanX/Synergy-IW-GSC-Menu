/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2782.gsc
***************************************/

timeuntilwavespawn(var_00) {
  if(!self.hasspawned)
    return 0;

  var_01 = gettime() + var_00 * 1000;
  var_02 = level.lastwave[self.pers["team"]];
  var_03 = level.wavedelay[self.pers["team"]] * 1000;
  var_04 = (var_01 - var_02) / var_03;
  var_05 = ceil(var_04);
  var_06 = var_02 + var_05 * var_03;

  if(isdefined(self.respawntimerstarttime)) {
    var_07 = (gettime() - self.respawntimerstarttime) / 1000.0;

    if(self.respawntimerstarttime < var_02)
      return 0;
  }

  if(isdefined(self.wavespawnindex))
    var_06 = var_06 + 50 * self.wavespawnindex;

  return (var_06 - gettime()) / 1000;
}

teamkilldelay() {
  var_00 = self.pers["teamkills"];

  if(level.maxallowedteamkills < 0 || var_00 <= level.maxallowedteamkills)
    return 0;

  var_01 = var_00 - level.maxallowedteamkills;
  return scripts\mp\tweakables::gettweakablevalue("team", "teamkillspawndelay") * var_01;
}

timeuntilspawn(var_00) {
  if(level.ingraceperiod && !self.hasspawned || level.gameended)
    return 0;

  var_01 = 0;

  if(self.hasspawned) {
    var_02 = self[[level.onrespawndelay]]();

    if(isdefined(var_02))
      var_01 = var_02;
    else
      var_01 = getdvarfloat("scr_" + level.gametype + "_playerrespawndelay");

    if(var_00 && isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
      var_01 = var_01 + teamkilldelay();

    if(isdefined(self.respawntimerstarttime)) {
      var_03 = (gettime() - self.respawntimerstarttime) / 1000.0;
      var_01 = var_01 - var_03;

      if(var_01 < 0)
        var_01 = 0;
    }

    if(isdefined(self.setspawnpoint))
      var_01 = var_01 + level.tispawndelay;
  }

  var_04 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;

  if(var_04)
    return timeuntilwavespawn(var_01);

  return var_01;
}

mayspawn() {
  if(scripts\mp\utility\game::istrue(level.nukegameover))
    return 0;

  if(scripts\mp\utility\game::getgametypenumlives() || isdefined(level.disablespawning)) {
    if(isdefined(level.disablespawning) && level.disablespawning)
      return 0;

    if(scripts\mp\utility\game::istrue(self.pers["teamKillPunish"]))
      return 0;

    if(self.pers["lives"] <= 0 && scripts\mp\utility\game::gamehasstarted())
      return 0;
    else if(scripts\mp\utility\game::gamehasstarted()) {
      if(level.ingraceperiod && !self.hasspawned)
        return 1;

      if(!level.ingraceperiod && !self.hasspawned && (isdefined(level.allowlatecomers) && !level.allowlatecomers)) {
        if(isdefined(self.siegelatecomer) && !self.siegelatecomer)
          return 1;

        return 0;
      }
    }
  }

  return 1;
}

spawnclient() {
  self endon("becameSpectator");

  if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass)
    self waittill("okToSpawn");

  if(isdefined(self.addtoteam)) {
    scripts\mp\menus::addtoteam(self.addtoteam);
    self.addtoteam = undefined;
  }

  if(!mayspawn()) {
    wait 0.05;
    var_00 = self.origin;
    var_01 = self.angles;
    self notify("attempted_spawn");

    if(scripts\mp\utility\game::istrue(self.pers["teamKillPunish"])) {
      self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
      scripts\mp\utility\game::setlowermessage("friendly_fire", & "MP_FRIENDLY_FIRE_WILL_NOT");

      if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills)
        self.pers["teamKillPunish"] = 0;
    } else if(scripts\mp\utility\game::isroundbased() && game["finalRound"] == 0) {
      if(isdefined(self.tagavailable) && self.tagavailable)
        scripts\mp\utility\game::setlowermessage("spawn_info", game["strings"]["spawn_tag_wait"]);
      else if(level.gametype == "siege")
        scripts\mp\utility\game::setlowermessage("spawn_info", game["strings"]["spawn_point_capture_wait"]);
      else
        scripts\mp\utility\game::setlowermessage("spawn_info", game["strings"]["spawn_next_round"]);

      thread removespawnmessageshortly(3.0);
    }

    if(self.sessionstate != "spectator")
      var_00 = var_00 + (0, 0, 60);

    if(scripts\mp\utility\game::isusingremote()) {
      self.spawningafterremotedeath = 1;
      self.deathposition = self.origin;
      self waittill("stopped_using_remote");
    }

    if(!scripts\mp\utility\game::istrue(level.nukegameover))
      thread spawnspectator(var_00, var_01);

    return;
  }

  if(self.waitingtospawn) {
    return;
  }
  self.waitingtospawn = 1;
  waitandspawnclient();

  if(isdefined(self))
    self.waitingtospawn = 0;
}

waitandspawnclient() {
  self endon("disconnect");
  self endon("end_respawn");
  level endon("game_ended");
  self notify("attempted_spawn");
  var_00 = 0;

  if(scripts\mp\utility\game::istrue(self.pers["teamKillPunish"])) {
    var_01 = teamkilldelay();

    if(var_01 > 0) {
      scripts\mp\utility\game::setlowermessage("friendly_fire", & "MP_FRIENDLY_FIRE_WILL_NOT", var_01, 1, 1);
      thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      var_00 = 1;
      wait(var_01);
      scripts\mp\utility\game::clearlowermessage("friendly_fire");
      self.respawntimerstarttime = gettime();
    }

    self.pers["teamKillPunish"] = 0;
  } else if(teamkilldelay())
    self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);

  if(scripts\mp\utility\game::isusingremote()) {
    self.spawningafterremotedeath = 1;
    self.deathposition = self.origin;
    self waittill("stopped_using_remote");

    if(scripts\mp\utility\game::istrue(level.nukegameover))
      return;
  }

  if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  var_02 = timeuntilspawn(0);
  thread predictabouttospawnplayerovertime(var_02);

  if(scripts\mp\utility\game::isinarbitraryup()) {
    var_03 = self getworldupreferenceangles();
    var_04 = anglestoup(var_03);
    var_05 = var_04 * 60;
  } else
    var_05 = (0, 0, 60);

  if(var_02 > 0) {
    scripts\mp\utility\game::setlowermessage("spawn_info", game["strings"]["waiting_to_spawn"], var_02, 1, 1);

    if(!var_00)
      thread respawn_asspectator(self.origin + var_05, self.angles);

    var_00 = 1;
    scripts\mp\utility\game::waitfortimeornotify(var_02, "force_spawn");

    if(!scripts\mp\utility\game::istrue(self.waitingtoselectclass))
      self notify("stop_wait_safe_spawn_button");
  }

  if(needsbuttontorespawn()) {
    if(!scripts\mp\utility\game::istrue(self.waitingtoselectclass))
      scripts\mp\utility\game::setlowermessage("spawn_info", game["strings"]["press_to_spawn"], undefined, undefined, undefined, undefined, undefined, undefined, 1);

    if(!var_00)
      thread respawn_asspectator(self.origin + var_05, self.angles);

    var_00 = 1;
    waitrespawnbutton();
  }

  waitclassselected();

  if(isbot(self)) {
    if(!scripts\mp\bots\bots::bot_is_ready_to_spawn())
      self waittill("bot_ready_to_spawn");
  }

  self.waitingtospawn = 0;
  scripts\mp\utility\game::clearlowermessage("spawn_info");
  self.wavespawnindex = undefined;
  thread spawnplayer();
}

waitclassselected() {
  while (scripts\mp\utility\game::istrue(self.waitingtoselectclass))
    wait 0.05;
}

needsbuttontorespawn() {
  if(scripts\mp\tweakables::gettweakablevalue("player", "forcerespawn") != 0)
    return 0;

  if(!self.hasspawned)
    return 0;

  var_00 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;

  if(var_00)
    return 0;

  if(self.wantsafespawn)
    return 0;

  return 1;
}

waitrespawnbutton() {
  self endon("disconnect");
  self endon("end_respawn");

  for (;;) {
    if(self usebuttonpressed()) {
      break;
    }
    wait 0.05;
  }
}

removespawnmessageshortly(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  waittillframeend;
  self endon("end_respawn");
  wait(var_00);
  scripts\mp\utility\game::clearlowermessage("spawn_info");
}

laststandrespawnplayer() {
  self laststandrevive();

  if(scripts\mp\utility\game::_hasperk("specialty_finalstand") && !level.diehardmode)
    scripts\mp\utility\game::removeperk("specialty_finalstand");

  if(level.diehardmode)
    self.headicon = "";

  self setstance("crouch");
  self.revived = 1;
  self notify("revive");

  if(isdefined(self.standardmaxhealth))
    self.maxhealth = self.standardmaxhealth;

  self.health = self.maxhealth;
  scripts\engine\utility::allow_usability(1);

  if(game["state"] == "postgame")
    scripts\mp\gamelogic::freezeplayerforroundend();
}

getdeathspawnpoint() {
  var_00 = spawn("script_origin", self.origin);
  var_00 hide();
  var_0.angles = self.angles;
  return var_00;
}

predictabouttospawnplayerovertime(var_00) {
  if(!0) {
    return;
  }
  self endon("disconnect");
  self endon("spawned");
  self endon("used_predicted_spawnpoint");
  self notify("predicting_about_to_spawn_player");
  self endon("predicting_about_to_spawn_player");

  if(var_00 <= 0) {
    return;
  }
  if(var_00 > 1.0)
    wait(var_00 - 1.0);

  predictabouttospawnplayer();
  self predictstreampos(self.predictedspawnpoint.origin + (0, 0, 60), self.predictedspawnpoint.angles);
  self.predictedspawnpointtime = gettime();

  for (var_01 = 0; var_01 < 30; var_1++) {
    wait 0.4;
    var_02 = self.predictedspawnpoint;
    predictabouttospawnplayer();

    if(self.predictedspawnpoint != var_02) {
      self predictstreampos(self.predictedspawnpoint.origin + (0, 0, 60), self.predictedspawnpoint.angles);
      self.predictedspawnpointtime = gettime();
    }
  }
}

predictabouttospawnplayer() {
  if(timeuntilspawn(1) > 1.0) {
    self.predictedspawnpoint = getspectatepoint();
    return;
  }

  if(isdefined(self.setspawnpoint)) {
    self.predictedspawnpoint = self.setspawnpoint;
    return;
  }

  var_00 = self[[level.getspawnpoint]]();
  self.predictedspawnpoint = var_00;
}

checkpredictedspawnpointcorrectness(var_00) {
  self notify("used_predicted_spawnpoint");
  self.predictedspawnpoint = undefined;
}

percentage(var_00, var_01) {
  return var_00 + " (" + int(var_00 / var_01 * 100) + "%)";
}

printpredictedspawnpointcorrectness() {}

getspawnorigin(var_00) {
  if(!positionwouldtelefrag(var_0.origin))
    return var_0.origin;

  if(!isdefined(var_0.alternates))
    return var_0.origin;

  foreach(var_02 in var_0.alternates) {
    if(!positionwouldtelefrag(var_02))
      return var_02;
  }

  return var_0.origin;
}

tivalidationcheck() {
  if(!isdefined(self.setspawnpoint))
    return 0;

  var_00 = getentarray("care_package", "targetname");

  foreach(var_02 in var_00) {
    if(distance(var_2.origin, self.setspawnpoint.playerspawnpos) > 64) {
      continue;
    }
    if(isdefined(var_2.owner))
      scripts\mp\hud_message::showsplash("destroyed_insertion", undefined, var_2.owner);

    scripts\mp\perks\perkfunctions::deleteti(self.setspawnpoint);
    return 0;
  }

  var_04 = [];
  var_4[0] = self;
  var_4[1] = self.setspawnpoint;
  var_05 = scripts\engine\trace::create_contents(1, 1, 1, 0, 0, 1, 1);

  if(!scripts\engine\trace::ray_trace_passed(self.setspawnpoint.origin + (0, 0, 60), self.setspawnpoint.origin, var_04, var_05))
    return 0;

  var_06 = self.setspawnpoint.origin + (0, 0, 1);
  var_07 = playerphysicstrace(var_06, self.setspawnpoint.origin + (0, 0, -16));

  if(var_6[2] == var_7[2])
    return 0;

  return 1;
}

spawningclientthisframereset() {
  self notify("spawningClientThisFrameReset");
  self endon("spawningClientThisFrameReset");
  wait 0.05;
  level.numplayerswaitingtospawn--;
}

getplayerassets(var_00, var_01) {
  var_02 = scripts\mp\class::loadout_getclassstruct();
  var_02 = scripts\mp\class::loadout_updateclass(var_02, var_01);
  scripts\mp\class::loadout_updateclassfinalweapons(var_02);
  self.classstruct = var_02;
  self.classset = 1;

  if(var_2.loadoutprimaryfullname != "none")
    var_0.primaryweapon = var_2.loadoutprimaryfullname;

  if(var_2.loadoutsecondaryfullname != "none")
    var_0.secondaryweapon = var_2.loadoutsecondaryfullname;

  var_03 = scripts\mp\teams::getcustomization();

  if(isdefined(var_3["body"]))
    var_0.body = var_3["body"];

  if(isdefined(var_3["head"]))
    var_0.head = var_3["head"];
}

loadplayerassets(var_00, var_01) {
  var_02 = [];

  if(isdefined(var_0.primaryweapon))
    var_2[var_2.size] = var_0.primaryweapon;

  if(isdefined(var_0.secondaryweapon))
    var_2[var_2.size] = var_0.secondaryweapon;

  if(var_2.size > 0)
    self loadweaponsforplayer(var_02, var_01);

  self loadcustomization(var_0.body, var_0.head, var_01);
}

allplayershaveassetsloaded(var_00) {
  var_01 = [];

  if(isdefined(var_0.primaryweapon))
    var_1[var_1.size] = var_0.primaryweapon;

  if(isdefined(var_0.secondaryweapon))
    var_1[var_1.size] = var_0.secondaryweapon;

  if(!self hasloadedviewweapons(var_01))
    return 0;

  if(!self hasloadedcustomizationviewmodels(var_0.body))
    return 0;

  return 1;
}

spawnplayer(var_00) {
  self endon("disconnect");
  self endon("joined_spectators");
  self notify("spawned");
  self notify("end_respawn");
  self notify("started_spawnPlayer");

  if(!isdefined(var_00))
    var_00 = 0;

  var_01 = undefined;
  self.ti_spawn = 0;
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_hud_shake", 0);
  self.lastkillsplash = undefined;
  self.customdeath = undefined;
  self.killsteakvariantattackerinfo = undefined;
  self.cratemantle = undefined;

  if(!level.ingraceperiod && !self.hasdonecombat) {
    level.numplayerswaitingtospawn++;

    if(level.numplayerswaitingtospawn > 1) {
      self.waitingtospawnamortize = 1;
      wait(0.05 * (level.numplayerswaitingtospawn - 1));
    }

    thread spawningclientthisframereset();
    self.waitingtospawnamortize = 0;
  }

  var_02 = spawnstruct();
  getplayerassets(var_02, self.class);
  loadplayerassets(var_02, 1);

  if(!getomnvar("ui_prematch_period")) {
    if(!allplayershaveassetsloaded(var_02)) {
      var_03 = scripts\mp\tweakables::gettweakablevalue("player", "streamingwaittime");
      var_04 = var_03 * 1000;
      var_05 = gettime() + var_04;
      self.waitingtospawnamortize = 1;
      wait 0.1;

      while (!allplayershaveassetsloaded(var_02)) {
        wait 0.1;

        if(gettime() > var_05) {
          break;
        }
      }

      self.waitingtospawnamortize = 0;
    }
  }

  if(isdefined(self.forcespawnorigin)) {
    var_06 = self.forcespawnorigin;
    self.forcespawnorigin = undefined;

    if(isdefined(self.forcespawnangles)) {
      var_07 = self.forcespawnangles;
      self.forcespawnangles = undefined;
    } else
      var_07 = (0, randomfloatrange(0, 360), 0);
  } else if(isdefined(self.setspawnpoint) && (isdefined(self.setspawnpoint.notti) || tivalidationcheck())) {
    var_01 = self.setspawnpoint;

    if(!isdefined(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("tactical_spawn");

      if(level.multiteambased) {
        foreach(var_09 in level.teamnamelist) {
          if(var_09 != self.team)
            self playsoundtoteam("tactical_spawn", var_09);
        }
      } else if(level.teambased)
        self playsoundtoteam("tactical_spawn", level.otherteam[self.team]);
      else
        self playsound("tactical_spawn");
    }

    foreach(var_12 in level.ugvs) {
      if(distancesquared(var_12.origin, var_1.playerspawnpos) < 1024)
        var_12 notify("damage", 5000, var_12.owner, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, "killstreak_jammer_mp");
    }

    var_06 = self.setspawnpoint.playerspawnpos;
    var_07 = self.setspawnpoint.angles;

    if(isdefined(self.setspawnpoint.enemytrigger))
      self.setspawnpoint.enemytrigger delete();

    self.setspawnpoint delete();
    var_01 = undefined;
  } else if(isdefined(self.isspawningonbattlebuddy) && isdefined(self.battlebuddy)) {
    var_06 = undefined;
    var_07 = undefined;
    var_14 = scripts\mp\battlebuddy::checkbuddyspawn();

    if(var_14.status == 0) {
      var_06 = var_14.origin;
      var_07 = var_14.angles;
    } else {
      var_01 = self[[level.getspawnpoint]]();
      var_06 = var_1.origin;
      var_07 = var_1.angles;
    }

    scripts\mp\battlebuddy::cleanupbuddyspawn();
    self setclientomnvar("cam_scene_name", "battle_spawn");
    self setclientomnvar("cam_scene_lead", self.battlebuddy getentitynumber());
    self setclientomnvar("cam_scene_support", self getentitynumber());
  } else if(isdefined(self.helispawning) && (!isdefined(self.firstspawn) || isdefined(self.firstspawn) && self.firstspawn) && level.prematchperiod > 0 && self.team == "allies") {
    while (!isdefined(level.allieschopper))
      wait 0.1;

    var_06 = level.allieschopper.origin;
    var_07 = level.allieschopper.angles;
    self.firstspawn = 0;
  } else if(isdefined(self.helispawning) && (!isdefined(self.firstspawn) || isdefined(self.firstspawn) && self.firstspawn) && level.prematchperiod > 0 && self.team == "axis") {
    while (!isdefined(level.axischopper))
      wait 0.1;

    var_06 = level.axischopper.origin;
    var_07 = level.axischopper.angles;
    self.firstspawn = 0;
  } else {
    var_01 = self[[level.getspawnpoint]]();
    var_06 = var_1.origin;
    var_07 = var_1.angles;
  }

  setspawnvariables();
  var_15 = self.hasspawned;
  self.fauxdeath = undefined;

  if(!var_00) {
    self.killsthislife = [];
    self.killsthislifeperweapon = [];
    self.func_A6B4 = [];
    scripts\mp\utility\game::updatesessionstate("playing");
    scripts\mp\utility\game::clearkillcamstate();
    self.cancelkillcam = undefined;
    self.maxhealth = scripts\mp\tweakables::gettweakablevalue("player", "maxhealth");
    self.health = self.maxhealth;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.wasti = !isdefined(var_01);
    self.afk = 0;
    self.damagedplayers = [];
    self.killstreakscaler = 1;
    self.objectivescaler = 1;
    self.clampedhealth = undefined;
    self.func_FC96 = 0;
    self.func_FC97 = 0;
    self.func_FC95 = 0;
    self.recentshieldxp = 0;
    self.func_AA43 = undefined;
    self.lifeid = 0;

    if(isdefined(self.pers["deaths"]))
      self.lifeid = self.pers["deaths"];

    scripts\mp\utility\game::cleardamagemodifiers();
    scripts\mp\killcam::clearkillcamomnvars();
    thread monitorwallrun();
  }

  self.movespeedscaler = 1;
  self.inlaststand = 0;
  self.laststand = undefined;
  self.infinalstand = undefined;
  self.inc4death = undefined;

  if(!var_00) {
    self.avoidkillstreakonspawntimer = 4.0;
    var_16 = self.pers["lives"];

    if(var_16 == scripts\mp\utility\game::getgametypenumlives())
      addtolivescount();

    if(var_16)
      self.pers["lives"]--;

    addtoalivecount();

    if(!var_15 || scripts\mp\utility\game::gamehasstarted() || scripts\mp\utility\game::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
      removefromlivescount();

    if(!self.wasaliveatmatchstart) {
      var_17 = 20;

      if(scripts\mp\utility\game::gettimelimit() > 0 && var_17 < scripts\mp\utility\game::gettimelimit() * 60 / 4)
        var_17 = scripts\mp\utility\game::gettimelimit() * 60 / 4;

      if(level.ingraceperiod || scripts\mp\utility\game::gettimepassed() < var_17 * 1000)
        self.wasaliveatmatchstart = 1;
    }
  }

  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(level.console)
    self setclientdvar("cg_fov", "63");

  if(isdefined(var_01)) {
    scripts\mp\spawnlogic::finalizespawnpointchoice(var_01);
    var_06 = getspawnorigin(var_01);
    var_07 = var_1.angles;
  } else if(!isdefined(self.faux_spawn_infected))
    self.lastspawntime = gettime();

  self.spawnpos = var_06;

  if(var_00 && scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    if(self isonground()) {
      self normalizeworldupreferenceangles();
      var_06 = var_06 - (0, 0, 80);
    }

    var_07 = self getworldupreferenceangles();
  }

  self spawn(var_06, var_07);

  if(var_00 && isdefined(self.faux_spawn_stance)) {
    self setstance(self.faux_spawn_stance);
    self.faux_spawn_stance = undefined;
  }

  if(isai(self))
    scripts\mp\utility\game::freezecontrolswrapper(1);

  self motionblurhqenable();
  [
    [level.onspawnplayer]
  ]();

  if(isdefined(var_01))
    checkpredictedspawnpointcorrectness(var_1.origin);

  if(!var_00) {
    if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["player_spawned"]))
      self[[level.bot_funcs["player_spawned"]]]();

    if(!isai(self))
      thread watchforslide();

    if(isdefined(level.matchrecording_logevent))
      [[level.matchrecording_logevent]](self.clientid, self.team, "SPAWN", self.spawnpos[0], self.spawnpos[1], self.spawntime);

    if(!isai(self)) {
      if(!isdefined(self.pers["distTrackingPassed"]))
        thread totaldisttracking(var_06);

      thread stancespamtracking();
    }
  }

  if(!var_00) {
    self.matchdatalifeindex = scripts\mp\matchdata::logplayerlife();
    self.lastmatchdatakillstreakindex = -1;
    thread func_DDED();

    if(self ishost())
      setmatchdata("players", self.clientid, "wasAHost", 1);
  }

  scripts\mp\class::setclass(self.class);

  if(isdefined(level.custom_giveloadout))
    self[[level.custom_giveloadout]](var_00);
  else
    scripts\mp\class::giveloadout(self.team, self.class);

  self _meth_84BE("player_mp");

  if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    if(!isdefined(self.classrefreshed) || !self.classrefreshed) {
      if(isdefined(self.class_num)) {
        self setclientomnvar("ui_loadout_selected", self.class_num);
        self.classrefreshed = 1;
      }
    }
  }

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\game::setthirdpersondof(1);

  if(!scripts\mp\utility\game::gameflag("prematch_done"))
    allowprematchlook(self);
  else
    scripts\mp\utility\game::freezecontrolswrapper(0);

  if(scripts\mp\utility\game::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame") {
    scripts\mp\perks::func_F7C5("ui_spawn_perk_", self.pers["loadoutPerks"]);
    self setclientomnvar("ui_spawn_abilities_show", 1);
  }

  waittillframeend;
  self.spawningafterremotedeath = undefined;
  self notify("spawned_player");
  level notify("player_spawned", self);
  thread setspawnnotifyomnvar();

  if(game["state"] == "postgame")
    scripts\mp\gamelogic::freezeplayerforroundend();

  if(scripts\mp\analyticslog::analyticsspawnlogenabled() && !var_00) {
    if(scripts\mp\analyticslog::analyticsdoesspawndataexist())
      level.spawncount = level.spawncount + 1;
    else
      scripts\mp\analyticslog::analyticsinitspawndata();

    if(scripts\mp\analyticslog::analyticssend_shouldsenddata(level.spawncount)) {
      if(isdefined(level.spawnglobals.spawnpointslist)) {
        scripts\mp\analyticslog::analyticssend_spawnfactors(self, self.spawnpointslist, level.spawncount, var_01);
        scripts\mp\analyticslog::analyticssend_spawntype(var_1.origin, self.team, self.lifeid, level.spawncount);
        scripts\mp\analyticslog::analyticssend_spawnplayerdetails(self, var_1.origin, level.spawncount);
      }
    }

    self.lastspawnpoint = var_01;
  }
}

setspawnnotifyomnvar() {
  self endon("disconnect");
  scripts\engine\utility::waitframe();
  self setclientomnvar("ui_player_spawned_notify", gettime());
}

func_DDED() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(scripts\mp\matchdata::canlogclient(self)) {
    for (;;) {
      var_00 = self.matchdatalifeindex;

      if(!isdefined(var_00))
        var_00 = -1;

      var_01 = scripts\mp\utility\game::func_9EE8();
      var_02 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
      var_03 = var_02 / 1000;
      self _meth_8571(var_03, var_00, var_01);
      wait 2.0;
    }
  }
}

allowprematchlook(var_00) {
  var_00 goal_head_icon(0);
  var_00 scripts\engine\utility::allow_fire(0);
  var_00 scripts\engine\utility::allow_offhand_weapons(0);
  var_00 scripts\engine\utility::allow_jump(0);
  var_0.prematchlook = 1;
}

clearprematchlook(var_00) {
  if(scripts\engine\utility::is_true(var_0.prematchlook)) {
    var_00 goal_head_icon(1);
    var_00 scripts\engine\utility::allow_fire(1);
    var_00 scripts\engine\utility::allow_offhand_weapons(1);
    var_00 scripts\engine\utility::allow_jump(1);
    var_0.prematchlook = undefined;
  }
}

waitforversusmenudone() {
  level endon("prematch_over");
  self endon("versus_menu_done");

  for (;;) {
    self waittill("luinotifyserver", var_00, var_01);

    if(var_00 == "versus_done")
      self notify("versus_menu_done");
  }
}

spawnspectatormapcam(var_00) {
  var_01 = 6;
  self endon("disconnect");

  if(isai(self)) {
    return;
  }
  if(level.splitscreen || self issplitscreenplayer())
    self setclientdvars("cg_fovscale", "0.65");
  else
    self setclientdvars("cg_fovscale", "1");

  self setclientomnvar("ui_mapshot_camera", 1);
  self lerpfovbypreset("mapflyover");
  var_02 = scripts\engine\utility::getstructarray("camera_intro", "targetname");

  if(var_2.size == 0) {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  var_03 = undefined;
  var_04 = undefined;
  setspawnvariables();
  scripts\mp\utility\game::clearlowermessage("spawn_info");
  scripts\mp\utility\game::updatesessionstate("spectator");
  self.pers["team"] = "spectator";
  self.team = "spectator";
  scripts\mp\utility\game::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonconnect();
  self allowspectateteam("allies", 0);
  self allowspectateteam("axis", 0);
  self allowspectateteam("freelook", 0);
  self allowspectateteam("none", 0);

  if(isdefined(var_02) && var_2.size > 1) {
    var_05 = randomintrange(0, var_2.size - 1);
    var_03 = var_2[var_05];
  } else if(isdefined(var_02))
    var_03 = var_2[0];
  else {}

  var_3.fil = 1;
  scripts\mp\utility\game::freezecontrolswrapper(1);
  self setspectatedefaults(var_3.origin, var_3.angles);
  self spawn(var_3.origin, var_3.angles);
  checkpredictedspawnpointcorrectness(var_3.origin);
  var_06 = spawn("script_model", var_3.origin);
  var_06 setmodel("tag_origin");
  var_6.angles = var_3.angles;
  thread waitforversusmenudone();

  if(isdefined(var_00) && var_00 == 99)
    var_07 = "debug";
  else if(scripts\mp\utility\game::gameflag("prematch_done"))
    var_07 = "prematch_over";
  else if(self.versusdone)
    var_07 = "versus_menu_done";
  else
    var_07 = scripts\engine\utility::waittill_any_timeout(2, "versus_menu_done", "prematch_over");

  if(var_07 == "timeout") {
    if(scripts\mp\utility\game::gameflag("prematch_done"))
      var_07 = "prematch_over";
    else
      var_07 = "versus_menu_done";
  }

  if(var_07 == "prematch_over") {
    self visionsetfadetoblackforplayer("", 0.75);
    return;
  }

  if(self issplitscreenplayer() && self isreloading()) {
    var_08 = self getteamvoiceprefix();
    var_08 notify("versus_menu_done");
    wait 0.05;
  }

  self cameralinkto(var_06, "tag_origin");
  var_09 = scripts\mp\utility\game::getmapname();
  self notify("mapCamera_start");

  switch (var_09) {
    case "mp_parkour":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_parkour", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_frontier":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_frontier", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_fallen":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_fallen", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_proto":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_proto", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_metropolis":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_metropolis", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_dome_iw":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_dome_iw", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_breakneck":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_breakneck", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_desert":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_desert", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_divide":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_divide", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_quarry":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_quarry", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_skyway":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_skyway", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_rivet":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rivet", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_riot":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_riot", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_dome_dusk":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_dome_iw", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_geneva":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_geneva", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_renaissance2":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_geneva", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_afghan":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_afghan", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_neon":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_neon", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_prime":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_prime", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_flip":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_flip", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_mansion":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_mansion", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_marsoasis":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_marsoasis", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_junk":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_junk", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_turista2":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_marsoasis", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_overflow":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_overflow", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_permafrost2":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_overflow", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_nova":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_nova", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_paris":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_paris", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_pixel":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_pixel", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_hawkwar":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_hawkwar", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_rally":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rally", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_carnage2":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_rally", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_depot":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_depot", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    case "mp_codphish":
      var_06 scriptmodelplayanimdeltamotion("iw7_mp_intro_camera_codphish", 1);
      self visionsetfadetoblackforplayer("", 0.75);
      self playlocalsound("mp_camera_intro_whoosh");
      wait(var_01 - 0.25);
      return;
    default:
      break;
  }

  wait 0.25;
  self visionsetfadetoblackforplayer("", 0.75);
  self playlocalsound("mp_camera_intro_whoosh");
  var_10 = var_03;
  var_04 = scripts\engine\utility::getstruct(var_3.target, "targetname");
  var_11 = 0;

  for (;;) {
    if(isdefined(var_10.speedadjust)) {
      var_12 = 1 / var_10.speedadjust;
      var_13 = var_12 * distance(var_10.origin, var_4.origin);
    } else
      var_13 = distance(var_10.origin, var_4.origin);

    var_11 = var_11 + var_13;
    var_10.distancetotarg = var_13;
    var_10 = var_04;

    if(isdefined(var_10.target)) {
      var_04 = scripts\engine\utility::getstruct(var_10.target, "targetname");
      continue;
    }

    break;
  }

  var_10.eol = 1;
  var_10 = var_03;
  var_04 = scripts\engine\utility::getstruct(var_3.target, "targetname");

  for (;;) {
    var_14 = var_10.distancetotarg / var_11;
    var_15 = var_14 * var_01;

    if(isdefined(var_4.eol))
      var_16 = var_15 / 2;
    else
      var_16 = 0;

    if(isdefined(var_10.fil))
      var_17 = var_15 / 2;
    else
      var_17 = 0;

    var_06 moveto(var_4.origin, var_15, var_17, var_16);
    var_06 rotateto(var_4.angles, var_15, var_17, var_16);

    if(isdefined(var_4.eol)) {
      var_18 = int(var_15 / 2);
      wait(var_18);
      wait(var_18);
    } else
      wait(var_15);

    var_10 = var_04;

    if(isdefined(var_10.target)) {
      var_04 = scripts\engine\utility::getstruct(var_10.target, "targetname");
      continue;
    }

    break;
  }

  scripts\mp\utility\game::freezecontrolswrapper(0);
  self.startcament = var_06;
  self setclientomnvar("ui_mapshot_camera", 0);
}

spawnspectator(var_00, var_01) {
  self notify("spawned");
  self notify("end_respawn");
  self notify("joined_spectators");

  if(isdefined(self.deathspectatepos)) {
    var_00 = self.deathspectatepos;
    var_01 = vectortoangles(self.origin - self.deathspectatepos);
  }

  if(isdefined(self.startcament) && !isdefined(var_00)) {
    var_00 = self.startcament.origin;
    var_01 = self.startcament.angles;
    self.startcament delete();
  }

  in_spawnspectator(var_00, var_01);
}

respawn_asspectator(var_00, var_01) {
  if(isdefined(self.deathspectatepos)) {
    var_00 = self.deathspectatepos;
    var_01 = vectortoangles(self.origin - self.deathspectatepos);
  }

  in_spawnspectator(var_00, var_01);
}

in_spawnspectator(var_00, var_01) {
  setspawnvariables();
  var_02 = self.pers["team"];

  if(isdefined(var_02) && var_02 == "spectator" && !level.gameended)
    scripts\mp\utility\game::clearlowermessage("spawn_info");

  scripts\mp\utility\game::updatesessionstate("spectator");
  scripts\mp\utility\game::clearkillcamstate();
  self.friendlydamage = undefined;
  resetuidvarsonconnect();
  scripts\mp\spectating::setspectatepermissions();
  onspawnspectator(var_00, var_01);

  if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

getplayerfromclientnum(var_00) {
  if(var_00 < 0)
    return undefined;

  for (var_01 = 0; var_01 < level.players.size; var_1++) {
    if(level.players[var_01] getentitynumber() == var_00)
      return level.players[var_01];
  }

  return undefined;
}

onspawnspectator(var_00, var_01) {
  if(isdefined(var_00) && isdefined(var_01)) {
    self setspectatedefaults(var_00, var_01);
    self spawn(var_00, var_01);
    checkpredictedspawnpointcorrectness(var_00);
    return;
  }

  var_02 = getspectatepoint();
  var_03 = 8;

  if(isdefined(level.camerapos) && level.camerapos.size) {
    for (var_04 = 0; var_04 < level.camerahighestindex + 1 && var_04 < var_03; var_4++) {
      if(!isdefined(level.camerapos[var_04]) || !isdefined(level.cameraang[var_04])) {
        continue;
      }
      self setmlgcameradefaults(var_04, level.camerapos[var_04], level.cameraang[var_04]);
      level.cameramapobjs[var_04].origin = level.camerapos[var_04];
      level.numbermapobjs[var_04].origin = level.camerapos[var_04];
      level.cameramapobjs[var_04].angles = level.cameraang[var_04];
      level.numbermapobjs[var_04].angles = level.cameraang[var_04];
    }
  } else {
    for (var_04 = 0; var_04 < var_03; var_4++)
      self setmlgcameradefaults(var_04, var_2.origin, var_2.angles);
  }

  self setspectatedefaults(var_2.origin, var_2.angles);
  self spawn(var_2.origin, var_2.angles);
  checkpredictedspawnpointcorrectness(var_2.origin);
}

getspectatepoint() {
  var_00 = getentarray("mp_global_intermission", "classname");
  var_01 = scripts\mp\spawnlogic::getspawnpoint_random(var_00);
  return var_01;
}

spawnintermission() {
  self endon("disconnect");
  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  scripts\mp\utility\game::clearlowermessages();
  scripts\mp\utility\game::freezecontrolswrapper(1);
  self setclientdvar("cg_everyoneHearsEveryone", 1);

  if(isdefined(level.finalkillcam_winner) && level.finalkillcam_winner != "none" && isdefined(level.match_end_delay) && scripts\mp\utility\game::waslastround() && !scripts\mp\utility\game::istrue(level.doingbroshot))
    wait(level.match_end_delay);

  if(!scripts\mp\utility\game::istrue(level.doingbroshot))
    scripts\mp\utility\game::updatesessionstate("intermission");

  scripts\mp\utility\game::clearkillcamstate();
  self.friendlydamage = undefined;
  var_00 = getentarray("mp_global_intermission", "classname");
  var_00 = scripts\mp\spawnscoring::checkdynamicspawns(var_00);
  var_01 = var_0[0];

  if(!isdefined(level.custom_ending)) {
    self spawn(var_1.origin, var_1.angles);
    checkpredictedspawnpointcorrectness(var_1.origin);
    self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  } else
    level notify("scoreboard_displaying");

  scripts\mp\utility\game::freezecontrolswrapper(1);
}

spawnendofgame() {
  if(1) {
    if(isdefined(level.custom_ending) && scripts\mp\utility\game::waslastround())
      level notify("start_custom_ending");

    if(!self.controlsfrozen)
      scripts\mp\utility\game::freezecontrolswrapper(1);

    if(scripts\mp\utility\game::istrue(level.doingbroshot)) {
      self notify("spawned");
      scripts\mp\utility\game::clearkillcamstate();
    } else {
      spawnspectator();
      scripts\mp\utility\game::freezecontrolswrapper(1);
    }

    return;
  }

  self notify("spawned");
  self notify("end_respawn");
  setspawnvariables();
  scripts\mp\utility\game::clearlowermessages();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  scripts\mp\utility\game::updatesessionstate("dead");
  scripts\mp\utility\game::clearkillcamstate();
  self.friendlydamage = undefined;
  var_00 = getspectatepoint();
  spawnspectator(var_0.origin, var_0.angles);
  checkpredictedspawnpointcorrectness(var_0.origin);
  scripts\mp\utility\game::freezecontrolswrapper(1);
  self setdepthoffield(0, 0, 512, 512, 4, 0);
}

setspawnvariables() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self.deathposition = undefined;
}

notifyconnecting() {
  waittillframeend;

  if(isdefined(self))
    level notify("connecting", self);
}

callback_playerdisconnect(var_00) {
  if(!isdefined(self.connected)) {
    return;
  }
  if(scripts\mp\utility\game::isroundbased())
    setmatchdata("players", self.clientid, "playerQuitRoundNumber", game["roundsPlayed"]);

  if(level.teambased) {
    if(isdefined(self.team)) {
      if(self.team == "allies") {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", getteamscore("allies"));
        setmatchdata("players", self.clientid, "playerQuitOppposingTeamScore", getteamscore("axis"));
      } else if(self.team == "axis") {
        setmatchdata("players", self.clientid, "playerQuitTeamScore", getteamscore("axis"));
        setmatchdata("players", self.clientid, "playerQuitOppposingTeamScore", getteamscore("allies"));
      }
    }
  }

  setmatchdata("players", self.clientid, "utcDisconnectTimeSeconds", getsystemtime());
  setmatchdata("players", self.clientid, "disconnectReason", var_00);
  self logplayerendmatchdatamatchresult(self.clientid, var_00);
  var_01 = _getmatchdata("commonMatchData", "playerCountLeft");
  var_1++;
  setmatchdata("commonMatchData", "playerCountLeft", var_01);

  if(scripts\mp\utility\game::rankingenabled())
    scripts\mp\matchdata::logfinalstats();

  if(scripts\mp\utility\game::iscontrollingproxyagent())
    self restorecontrolagent();

  scripts\mp\matchdata::logplayerdata();

  if(isdefined(self.pers["confirmed"]))
    scripts\mp\matchdata::logkillsconfirmed();

  if(isdefined(self.pers["denied"]))
    scripts\mp\matchdata::logkillsdenied();

  removeplayerondisconnect();
  scripts\mp\spawnlogic::removefromparticipantsarray();
  scripts\mp\spawnlogic::removefromcharactersarray();
  var_02 = self getentitynumber();

  if(!level.teambased)
    game["roundsWon"][self.guid] = undefined;

  if(level.splitscreen) {
    var_03 = level.players;

    if(var_3.size <= 1)
      level thread scripts\mp\gamelogic::forceend();
  }

  if(isdefined(self.kills) && isdefined(self.deaths)) {
    if(120 < self.timeplayed["total"]) {
      var_04 = (self.kills - self.deaths) / (self.timeplayed["total"] / 60);
      setplayerteamrank(self, self.clientid, var_04);
    }
  } else {}

  var_05 = self getentitynumber();
  var_06 = self.guid;
  logprint("Q;" + var_06 + ";" + var_05 + ";" + self.name + "\\n");
  thread scripts\mp\events::disconnected();

  if(level.gameended)
    scripts\mp\gamescore::removedisconnectedplayerfromplacement();

  if(isdefined(self.team))
    removefromteamcount();

  if(self.sessionstate == "playing" && !(isdefined(self.fauxdeath) && self.fauxdeath))
    removefromalivecount(1);
  else if(self.sessionstate == "spectator" || self.sessionstate == "dead")
    level thread scripts\mp\gamelogic::updategameevents();
}

removeplayerondisconnect() {
  var_00 = 0;

  for (var_01 = 0; var_01 < level.players.size; var_1++) {
    if(level.players[var_01] == self) {
      for (var_00 = 1; var_01 < level.players.size - 1; var_1++)
        level.players[var_01] = level.players[var_01 + 1];

      level.players[var_01] = undefined;
      break;
    }
  }
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovscale", "0.75");
    setdvar("r_materialBloomHQScriptMasterEnable", 0);
  } else
    self setclientdvars("cg_fovscale", "1");
}

initclientdvars() {
  setdvar("cg_drawCrosshair", 1);
  setdvar("cg_drawCrosshairNames", 1);

  if(level.hardcoremode) {
    setdvar("cg_drawCrosshair", 0);
    setdvar("cg_drawCrosshairNames", 1);
  }

  if(isdefined(level.alwaysdrawfriendlynames) && level.alwaysdrawfriendlynames)
    setdvar("cg_drawFriendlyNamesAlways", 1);
  else
    setdvar("cg_drawFriendlyNamesAlways", 0);

  self setclientdvars("cg_drawSpectatorMessages", 1);
  initclientdvarssplitscreenspecific();

  if(scripts\mp\utility\game::getgametypenumlives())
    self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
  else
    self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);

  if(level.teambased)
    self setclientdvars("cg_everyonehearseveryone", 0);

  self setclientdvar("ui_altscene", 0);

  if(getdvarint("scr_hitloc_debug")) {
    for (var_00 = 0; var_00 < 6; var_0++)
      self setclientdvar("ui_hitloc_" + var_00, "");

    self.hitlocinited = 1;
  }
}

getlowestavailableclientid() {
  var_00 = 0;

  for (var_01 = 0; var_01 < 30; var_1++) {
    foreach(var_03 in level.players) {
      if(!isdefined(var_03)) {
        continue;
      }
      if(var_3.clientid == var_01) {
        var_00 = 1;
        break;
      }

      var_00 = 0;
    }

    if(!var_00)
      return var_01;
  }
}

setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for (var_00 = 1; var_00 <= 4; var_0++) {
    self.saved_actionslotdata[var_00] = spawnstruct();
    self.saved_actionslotdata[var_00].type = "";
    self.saved_actionslotdata[var_00].item = undefined;
  }

  if(!level.console) {
    for (var_00 = 5; var_00 <= 8; var_0++) {
      self.saved_actionslotdata[var_00] = spawnstruct();
      self.saved_actionslotdata[var_00].type = "";
      self.saved_actionslotdata[var_00].item = undefined;
    }
  }
}

connect_validateplayerteam() {
  if(!isdefined(self)) {
    return;
  }
  if(self.sessionteam == "none" && scripts\mp\utility\game::matchmakinggame() && level.teambased && !isdefined(self.pers["isBot"]) && !self ismlgspectator() && level.gametype != "infect") {
    bbprint("mp_invalid_team_error", "player_xuid %s isHost %i", self getxuid(), self ishost());
    wait 1.5;
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INVALIDTEAM");
  }
}

queueconnectednotify() {
  for (;;) {
    if(!isdefined(level.players_waiting_for_callback)) {
      wait 0.05;
      continue;
    }

    break;
  }

  for (;;) {
    for (var_00 = 0; var_00 < level.players_waiting_for_callback.size; var_0++) {
      var_01 = level.players_waiting_for_callback[var_00];

      if(isdefined(var_01)) {
        level notify("connected", var_01);
        var_01 notify("connected_continue");
        level.players_waiting_for_callback[var_00] = undefined;
        break;
      }
    }

    var_02 = scripts\mp\utility\game::cleanarray(level.players_waiting_for_callback);
    level.players_waiting_for_callback = var_02;
    wait 0.05;
  }
}

watchforversusdone() {
  self endon("disconnect");
  self.versusdone = 0;

  for (;;) {
    self waittill("luinotifyserver", var_00, var_01);

    if(var_00 == "versus_done") {
      self.versusdone = 1;
      return;
    }
  }
}

monitorplayersegments(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  createplayersegmentstats(var_00);

  for (;;) {
    var_00 waittill("spawned_player");
    recordsegmentdata(var_00);
  }
}

createplayersegmentstats(var_00) {
  var_0.segments = [];
  var_0.segments["distanceTotal"] = 0;
  var_0.segments["movingTotal"] = 0;
  var_0.segments["movementUpdateCount"] = 0;
}

recordsegmentdata(var_00) {
  var_00 endon("death");

  while (!scripts\mp\utility\game::gameflag("prematch_done"))
    wait 0.5;

  wait 4;
  var_0.savedsegmentposition = var_0.origin;
  var_0.positionptm = var_0.origin;

  for (;;) {
    wait 1;

    if(var_00 scripts\mp\utility\game::isusingremote()) {
      var_00 waittill("stopped_using_remote");
      var_0.savedsegmentposition = var_0.origin;
      var_0.positionptm = var_0.origin;
      continue;
    }

    var_0.segments["movementUpdateCount"]++;
    var_0.segments["distanceTotal"] = var_0.segments["distanceTotal"] + distance2d(var_0.savedsegmentposition, var_0.origin);
    var_0.savedsegmentposition = var_0.origin;

    if(var_0.segments["movementUpdateCount"] % 5 == 0) {
      var_01 = distance2d(var_0.positionptm, var_0.origin);
      var_0.positionptm = var_0.origin;

      if(var_01 > 16)
        var_0.segments["movingTotal"]++;
    }
  }
}

writesegmentdata(var_00) {
  var_00 endon("disconnect");

  if(var_0.segments["movementUpdateCount"] < 30) {
    return;
  }
  var_01 = var_0.segments["movingTotal"] / (var_0.segments["movementUpdateCount"] / 5) * 100;
  var_02 = var_0.segments["distanceTotal"] / var_0.segments["movementUpdateCount"];
  setmatchdata("players", var_0.clientid, "averageSpeedDuringMatch", var_02);
  setmatchdata("players", var_0.clientid, "percentageOfTimeMoving", var_01);
}

callback_playerconnect() {
  thread notifyconnecting();
  thread watchforversusdone();
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";
  self.connecttime = undefined;
  self visionsetfadetoblackforplayer("bw", 0);
  level.players_waiting_for_callback[level.players_waiting_for_callback.size] = self;
  self waittill("connected_continue");
  self.connected = 1;
  self setclientomnvar("ui_scoreboard_freeze", 0);

  if(self ishost())
    level.player = self;

  if(!level.splitscreen && !isdefined(self.pers["score"]))
    iprintln( & "MP_CONNECTED", self);

  self.usingonlinedataoffline = self isusingonlinedataoffline();
  initclientdvars();
  initplayerstats();

  if(getdvar("r_reflectionProbeGenerate") == "1")
    level waittill("eternity");

  self.guid = scripts\mp\utility\game::getuniqueid();
  var_00 = 0;
  var_01 = 0;

  if(!isdefined(self.pers["clientid"])) {
    for (var_02 = 0; var_02 < 30; var_2++) {
      var_03 = _getmatchdata("players", var_02, "playerID", "xuid");

      if(var_03 == self.guid) {
        self.pers["clientid"] = var_02;
        var_01 = 1;
        var_04 = _getmatchdata("commonMatchData", "playerCountReconnected");
        var_4++;
        setmatchdata("commonMatchData", "playerCountReconnected", var_04);
        setmatchdata("players", var_02, "utcReconnectTimeSeconds", getsystemtime());
        break;
      }
    }

    if(!var_01) {
      if(game["clientid"] >= 30)
        self.pers["clientid"] = getlowestavailableclientid();
      else
        self.pers["clientid"] = game["clientid"];

      if(game["clientid"] < 30)
        game["clientid"]++;
    }

    var_00 = 1;
    self.pers["matchdataWeaponStats"] = [];
    self.pers["matchdataScoreEventCounts"] = [];
    self.pers["xpAtLastDeath"] = 0;
    self.pers["scoreAtLastDeath"] = 0;
    self _meth_8596(self.pers["clientid"]);
    setmatchdata("players", self.pers["clientid"], "joinType", self getjointype());
    setmatchdata("players", self.pers["clientid"], "isTrialVersion", self istrialversion());
  }

  if(var_00) {
    scripts\mp\persistence::statsetchildbuffered("round", "timePlayed", 0, 1);
    self setrankedplayerdata("common", "round", "timePlayed", 0);
    self setrankedplayerdata("common", "round", "totalXp", 0);
    self setrankedplayerdata("common", "aarUnlockCount", 0);

    if(!isdefined(game["uniquePlayerCount"]))
      game["uniquePlayerCount"] = 1;
    else
      game["uniquePlayerCount"]++;
  }

  self.clientid = self.pers["clientid"];
  self.pers["teamKillPunish"] = 0;
  logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\\n");
  self logstatmatchguid();
  var_05 = _getmatchdata("commonMatchData", "playerCount");

  if(game["clientid"] <= 30 && game["clientid"] != var_05) {
    if(!isai(self) && scripts\mp\utility\game::matchmakinggame())
      self geyser_erupt(self.clientid);

    if(var_00 && !var_01) {
      var_5++;
      setmatchdata("commonMatchData", "playerCount", var_05);
    }

    setmatchdata("players", self.clientid, "playerID", "xuid", scripts\mp\utility\game::getuniqueid());
    setmatchdata("players", self.clientid, "gamertag", self.name);
    setmatchdata("players", self.clientid, "skill", self getskill());
    setmatchclientip(self, self.clientid);

    if(var_00 && !var_01)
      setmatchdata("players", self.clientid, "utcConnectTimeSeconds", getsystemtime());

    if(scripts\mp\utility\game::rankingenabled())
      scripts\mp\matchdata::loginitialspawnposition();

    if(isdefined(self.pers["isBot"]) && self.pers["isBot"] || isai(self)) {
      var_06 = 1;
      setmatchdata("players", self.clientid, "isBot", 1);
    } else
      var_06 = 0;

    if(scripts\mp\utility\game::matchmakinggame() && scripts\mp\utility\game::allowteamassignment() && !var_06)
      setmatchdata("players", self.clientid, "team", self.sessionteam);

    if(var_00 && isdefined(level.matchrecording_logeventplayername))
      [[level.matchrecording_logeventplayername]](self.clientid, self.team, self.name);
  }

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  self.leaderdialogqueue = [];
  self.leaderdialoglocqueue = [];
  self.leaderdialogactive = "";
  self.leaderdialoggroups = [];
  self.leaderdialoggroup = "";

  if(!isdefined(self.pers["cur_kill_streak"]))
    self.pers["cur_kill_streak"] = 0;

  if(!isdefined(self.pers["cur_death_streak"]))
    self.pers["cur_death_streak"] = 0;

  if(!isdefined(self.pers["cur_kill_streak_for_nuke"]))
    self.pers["cur_kill_streak_for_nuke"] = 0;

  if(scripts\mp\utility\game::rankingenabled())
    self.kill_streak = scripts\mp\persistence::statget("killStreak");

  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.wasaliveatmatchstart = 0;
  self.movespeedscaler = 1;
  self.killstreakscaler = 1;
  self.objectivescaler = 1;
  self.firstspawn = 1;
  self.lifeid = 0;

  if(isdefined(self.pers["deaths"]))
    self.lifeid = self.pers["deaths"];

  setupsavedactionslots();
  level thread monitorplayersegments(self);
  resetuiomnvarscommon();
  waittillframeend;
  level.players[level.players.size] = self;
  scripts\mp\spawnlogic::addtoparticipantsarray();
  scripts\mp\spawnlogic::addtocharactersarray();

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    self visionsetfadetoblackforplayer("", 0.25);
    spawnintermission();
  } else {
    if(var_00 && (scripts\mp\utility\game::gettimepassed() >= 60000 || game["roundsPlayed"] > 0))
      self.joinedinprogress = 1;

    if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["think"]))
      self thread[[level.bot_funcs["think"]]]();

    level endon("game_ended");

    if(isdefined(level.hostmigrationtimer))
      thread scripts\mp\hostmigration::hostmigrationtimerthink();

    if(isdefined(level.onplayerconnectaudioinit))
      [[level.onplayerconnectaudioinit]]();

    if(!isdefined(self.pers["team"])) {
      var_10 = scripts\mp\utility\game::gettimepassed() / 1000 + 6;

      if(var_10 < level.prematchperiod) {
        spawnspectatormapcam();
        self lerpfovbypreset("default");
        self setclientomnvar("ui_mapshot_camera", 0);
        initclientdvarssplitscreenspecific();
        self.pers["team"] = "";
        self.team = "free";
      } else
        self visionsetfadetoblackforplayer("", 0.5);

      connect_validateplayerteam();

      if(self ismlgspectator()) {
        thread scripts\mp\menus::setspectator();
        return;
      }

      if((scripts\mp\utility\game::matchmakinggame() || scripts\mp\utility\game::lobbyteamselectenabled() || isgamebattlematch()) && self.sessionteam != "none") {
        thread spawnspectator();
        thread scripts\mp\menus::setteam(self.sessionteam);

        if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self))
          self setclientomnvar("ui_options_menu", 2);

        if(!isgamebattlematch())
          thread kickifdontspawn();

        return;
        return;
      }

      if(!scripts\mp\utility\game::matchmakinggame() && scripts\mp\utility\game::allowteamassignment()) {
        scripts\mp\menus::menuspectator();
        self setclientomnvar("ui_options_menu", 1);
        return;
      }

      thread spawnspectator();
      scripts\mp\menus::autoassign();

      if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self))
        self setclientomnvar("ui_options_menu", 2);

      if(scripts\mp\utility\game::matchmakinggame())
        thread kickifdontspawn();

      return;
      return;
      return;
      return;
    } else {
      self visionsetfadetoblackforplayer("", 0.5);
      connect_validateplayerteam();
      var_11 = self.pers["team"];

      if(scripts\mp\utility\game::matchmakinggame() && !isdefined(self.pers["isBot"]) && !self ismlgspectator() && getdvarint("team_consistency_fix"))
        var_11 = self.sessionteam;

      scripts\mp\menus::addtoteam(var_11, 1);

      if(self ismlgspectator()) {
        thread spawnspectator();
        return;
      }

      if(scripts\mp\utility\game::isvalidclass(self.pers["class"])) {
        thread spawnclient();
        return;
      }

      thread spawnspectator();

      if(self.pers["team"] == "spectator") {
        if(scripts\mp\utility\game::allowteamassignment()) {
          scripts\mp\menus::beginteamchoice();
          return;
        }

        self[[level.autoassign]]();
        return;
        return;
      }

      scripts\mp\menus::beginclasschoice();
    }
  }
}

callback_playermigrated() {
  if(isdefined(self.connected) && self.connected) {
    scripts\mp\utility\game::updateobjectivetext();
    scripts\mp\utility\game::updatemainmenu();
  }

  if(self ishost())
    initclientdvarssplitscreenspecific();

  var_00 = 0;

  foreach(var_02 in level.players) {
    if(!isdefined(var_2.pers["isBot"]) || var_2.pers["isBot"] == 0)
      var_0++;
  }

  if(!isdefined(self.pers["isBot"]) || self.pers["isBot"] == 0) {
    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_00 * 2 / 3)
      level notify("hostmigration_enoughplayers");
  }
}

addlevelstoexperience(var_00, var_01) {
  var_02 = scripts\mp\rank::getrankforxp(var_00);
  var_03 = scripts\mp\rank::getrankinfominxp(var_02);
  var_04 = scripts\mp\rank::getrankinfomaxxp(var_02);
  var_02 = var_02 + (var_00 - var_03) / (var_04 - var_03);
  var_02 = var_02 + var_01;

  if(var_02 < 0) {
    var_02 = 0;
    var_05 = 0.0;
  } else if(var_02 >= level.maxrank + 1.0) {
    var_02 = level.maxrank;
    var_05 = 1.0;
  } else {
    var_05 = var_02 - floor(var_02);
    var_02 = int(floor(var_02));
  }

  var_03 = scripts\mp\rank::getrankinfominxp(var_02);
  var_04 = scripts\mp\rank::getrankinfomaxxp(var_02);
  return int(var_05 * (var_04 - var_03)) + var_03;
}

forcespawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  wait 60.0;

  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  if(!scripts\mp\utility\game::isvalidclass(self.pers["class"])) {
    self.pers["class"] = "CLASS_CUSTOM1";
    self.class = self.pers["class"];
  }

  thread spawnclient();
}

kickifdontspawn() {
  self endon("death");
  self endon("disconnect");
  self endon("spawned");
  self endon("attempted_spawn");
  var_00 = getdvarfloat("scr_kick_time", 90);
  var_01 = getdvarfloat("scr_kick_mintime", 45);
  var_02 = getdvarfloat("scr_kick_hosttime", 120);
  var_03 = gettime();

  if(self ishost())
    kickwait(var_02);
  else
    kickwait(var_00);

  var_04 = (gettime() - var_03) / 1000;

  if(var_04 < var_00 - 0.1 && var_04 < var_01) {
    return;
  }
  if(self.hasspawned) {
    return;
  }
  if(self.pers["team"] == "spectator") {
    return;
  }
  kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE", 1);
  level thread scripts\mp\gamelogic::updategameevents();
}

kickwait(var_00) {
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
}

monitorvotekick() {
  level endon("game_ended");
  self endon("disconnect");

  for (self.votestokick = 0; self.votestokick < 2; self.votestokick++)
    self waittill("voteToKick");

  kick(self getentitynumber(), "EXE_PLAYERKICKED_TEAMKILLS");
}

fakevote() {
  wait 1.0;
  self notify("voteToKick");
  wait 3.0;
  self notify("voteToKick");
  wait 2.0;
  self notify("voteToKick");
}

totaldisttracking(var_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("distFromSpawnTracking");
  self endon("distFromSpawnTracking");

  if(!scripts\mp\utility\game::gameflag("prematch_done"))
    scripts\mp\utility\game::gameflagwait("prematch_done");

  var_01 = var_00;

  for (;;) {
    scripts\engine\utility::waittill_notify_or_timeout("death", 5.0);

    if(!isdefined(self.pers["totalDistTraveledSQ"]))
      self.pers["totalDistTraveledSQ"] = 0;

    self.pers["totalDistTraveledSQ"] = self.pers["totalDistTraveledSQ"] + distancesquared(var_01, self.origin);
    var_01 = self.origin;

    if(self.pers["totalDistTraveledSQ"] > 90000)
      self.pers["distTrackingPassed"] = 1;
  }
}

stancespamtracking() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  self notify("stanceSpamTracking");
  self endon("stanceSpamTracking");

  if(!scripts\mp\utility\game::gameflag("prematch_done"))
    scripts\mp\utility\game::gameflagwait("prematch_done");

  var_00 = undefined;

  for (;;) {
    var_01 = self getstance();

    if(isdefined(var_00) && var_00 != var_01) {
      if(!isdefined(self.pers["stanceTracking"])) {
        self.pers["stanceTracking"] = [];
        self.pers["stanceTracking"]["prone"] = 0;
        self.pers["stanceTracking"]["crouch"] = 0;
        self.pers["stanceTracking"]["stand"] = 0;
      }

      if(var_01 == "prone" || var_01 == "crouch" || var_01 == "stand")
        self.pers["stanceTracking"][var_01]++;
    }

    var_00 = var_01;
    scripts\engine\utility::waitframe();
  }
}

initplayerstats() {
  scripts\mp\persistence::initbufferedstats();

  if(!isdefined(self.pers["deaths"])) {
    scripts\mp\utility\game::initpersstat("deaths");
    scripts\mp\persistence::statsetchild("round", "deaths", 0);
  }

  self.deaths = scripts\mp\utility\game::getpersstat("deaths");

  if(!isdefined(self.pers["score"])) {
    scripts\mp\utility\game::initpersstat("score");
    scripts\mp\persistence::statsetchild("round", "score", 0);
  }

  self.score = scripts\mp\utility\game::getpersstat("score");

  if(!isdefined(self.pers["suicides"]))
    scripts\mp\utility\game::initpersstat("suicides");

  self.suicides = scripts\mp\utility\game::getpersstat("suicides");

  if(!isdefined(self.pers["kills"])) {
    scripts\mp\utility\game::initpersstat("kills");
    scripts\mp\persistence::statsetchild("round", "kills", 0);
  }

  self.kills = scripts\mp\utility\game::getpersstat("kills");

  if(!isdefined(self.pers["headshots"]))
    scripts\mp\utility\game::initpersstat("headshots");

  self.headshots = scripts\mp\utility\game::getpersstat("headshots");

  if(!isdefined(self.pers["assists"])) {
    scripts\mp\utility\game::initpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", 0);
  }

  self.assists = scripts\mp\utility\game::getpersstat("assists");

  if(!isdefined(self.pers["captures"])) {
    scripts\mp\utility\game::initpersstat("captures");
    scripts\mp\persistence::statsetchild("round", "captures", 0);
  }

  self.captures = scripts\mp\utility\game::getpersstat("captures");

  if(!isdefined(self.pers["returns"])) {
    scripts\mp\utility\game::initpersstat("returns");
    scripts\mp\persistence::statsetchild("round", "returns", 0);
  }

  self.returns = scripts\mp\utility\game::getpersstat("returns");

  if(!isdefined(self.pers["defends"])) {
    scripts\mp\utility\game::initpersstat("defends");
    scripts\mp\persistence::statsetchild("round", "defends", 0);
  }

  self.defends = scripts\mp\utility\game::getpersstat("defends");

  if(!isdefined(self.pers["plants"])) {
    scripts\mp\utility\game::initpersstat("plants");
    scripts\mp\persistence::statsetchild("round", "plants", 0);
  }

  self.plants = scripts\mp\utility\game::getpersstat("plants");

  if(!isdefined(self.pers["defuses"])) {
    scripts\mp\utility\game::initpersstat("defuses");
    scripts\mp\persistence::statsetchild("round", "defuses", 0);
  }

  self.defuses = scripts\mp\utility\game::getpersstat("defuses");

  if(!isdefined(self.pers["destructions"])) {
    scripts\mp\utility\game::initpersstat("destructions");
    scripts\mp\persistence::statsetchild("round", "destructions", 0);
  }

  self.destructions = scripts\mp\utility\game::getpersstat("destructions");

  if(!isdefined(self.pers["confirmed"])) {
    scripts\mp\utility\game::initpersstat("confirmed");
    scripts\mp\persistence::statsetchild("round", "confirmed", 0);
  }

  self.confirmed = scripts\mp\utility\game::getpersstat("confirmed");

  if(!isdefined(self.pers["denied"])) {
    scripts\mp\utility\game::initpersstat("denied");
    scripts\mp\persistence::statsetchild("round", "denied", 0);
  }

  self.denied = scripts\mp\utility\game::getpersstat("denied");

  if(!isdefined(self.pers["rescues"])) {
    scripts\mp\utility\game::initpersstat("rescues");
    scripts\mp\persistence::statsetchild("round", "rescues", 0);
  }

  self.rescues = scripts\mp\utility\game::getpersstat("rescues");

  if(!isdefined(self.pers["touchdowns"])) {
    scripts\mp\utility\game::initpersstat("touchdowns");
    scripts\mp\persistence::statsetchild("round", "touchdowns", 0);
  }

  self.touchdowns = scripts\mp\utility\game::getpersstat("touchdowns");

  if(!isdefined(self.pers["fieldgoals"])) {
    scripts\mp\utility\game::initpersstat("fieldgoals");
    scripts\mp\persistence::statsetchild("round", "fieldgoals", 0);
  }

  self.fieldgoals = scripts\mp\utility\game::getpersstat("fieldgoals");

  if(!isdefined(self.pers["killChains"])) {
    scripts\mp\utility\game::initpersstat("killChains");
    scripts\mp\persistence::statsetchild("round", "killChains", 0);
  }

  self.killchains = scripts\mp\utility\game::getpersstat("killChains");

  if(!isdefined(self.pers["killsAsSurvivor"])) {
    scripts\mp\utility\game::initpersstat("killsAsSurvivor");
    scripts\mp\persistence::statsetchild("round", "killsAsSurvivor", 0);
  }

  self.killsassurvivor = scripts\mp\utility\game::getpersstat("killsAsSurvivor");

  if(!isdefined(self.pers["killsAsInfected"])) {
    scripts\mp\utility\game::initpersstat("killsAsInfected");
    scripts\mp\persistence::statsetchild("round", "killsAsInfected", 0);
  }

  self.killsasinfected = scripts\mp\utility\game::getpersstat("killsAsInfected");

  if(!isdefined(self.pers["teamkills"]))
    scripts\mp\utility\game::initpersstat("teamkills");

  if(!isdefined(self.pers["extrascore0"]))
    scripts\mp\utility\game::initpersstat("extrascore0");

  if(!isdefined(self.pers["extrascore1"]))
    scripts\mp\utility\game::initpersstat("extrascore1");

  if(!isdefined(self.pers["stabs"])) {
    scripts\mp\utility\game::initpersstat("stabs");
    scripts\mp\persistence::statsetchild("round", "stabs", 0);
  }

  self.stabs = scripts\mp\utility\game::getpersstat("stabs");

  if(!isdefined(self.pers["setbacks"])) {
    scripts\mp\utility\game::initpersstat("setbacks");
    scripts\mp\persistence::statsetchild("round", "setbacks", 0);
  }

  self.setbacks = scripts\mp\utility\game::getpersstat("setbacks");

  if(!isdefined(self.pers["objTime"])) {
    scripts\mp\utility\game::initpersstat("objTime");
    scripts\mp\persistence::statsetchild("round", "objTime", 0);
  }

  self.objstruct = scripts\mp\utility\game::getpersstat("objTime");

  if(!isdefined(self.pers["gamemodeScore"])) {
    scripts\mp\utility\game::initpersstat("gamemodeScore");
    scripts\mp\persistence::statsetchild("round", "gamemodeScore", 0);
  }

  if(!isdefined(self.pers["supersEarned"]))
    scripts\mp\utility\game::initpersstat("supersEarned");

  if(!isdefined(self.pers["wardenKSCount"]))
    scripts\mp\utility\game::initpersstat("wardenKSCount");

  if(!isdefined(self.pers["teamKillPunish"]))
    self.pers["teamKillPunish"] = 0;

  scripts\mp\utility\game::initpersstat("longestStreak");
  self.pers["lives"] = scripts\mp\utility\game::getgametypenumlives();
  scripts\mp\persistence::statsetchild("round", "killStreak", 0);
  scripts\mp\persistence::statsetchild("round", "loss", 0);
  scripts\mp\persistence::statsetchild("round", "win", 0);
  scripts\mp\persistence::statsetchild("round", "scoreboardType", "none");
}

addtoteamcount() {
  level.teamcount[self.team]++;

  if(!isdefined(level.teamlist))
    level.teamlist = [];

  if(!isdefined(level.teamlist[self.team]))
    level.teamlist[self.team] = [];

  level.teamlist[self.team][level.teamlist[self.team].size] = self;
  scripts\mp\gamelogic::updategameevents();
}

removefromteamcount() {
  level.teamcount[self.team]--;

  if(isdefined(level.teamlist) && isdefined(level.teamlist[self.team])) {
    var_00 = [];

    foreach(var_02 in level.teamlist[self.team]) {
      if(!isdefined(var_02) || var_02 == self) {
        continue;
      }
      var_0[var_0.size] = var_02;
    }

    level.teamlist[self.team] = var_00;
  }
}

addtoalivecount() {
  var_00 = self.team;

  if(!(isdefined(self.alreadyaddedtoalivecount) && self.alreadyaddedtoalivecount)) {
    level.hasspawned[var_00]++;
    incrementalivecount(var_00);
  }

  self.alreadyaddedtoalivecount = undefined;

  if(level.alivecount["allies"] + level.alivecount["axis"] > level.maxplayercount)
    level.maxplayercount = level.alivecount["allies"] + level.alivecount["axis"];
}

incrementalivecount(var_00, var_01) {
  level.alivecount[var_00]++;

  if(!isdefined(level.alive_players))
    level.alive_players = [];

  if(!isdefined(level.alive_players[var_00]))
    level.alive_players[var_00] = [];

  level.alive_players[var_00] = scripts\engine\utility::array_add(level.alive_players[var_00], self);

  if(scripts\mp\utility\game::istrue(var_01) && (var_00 == "allies" || var_00 == "axis")) {
    var_02 = level.otherteam[var_00];

    foreach(var_04 in level.players) {
      if(var_4.team == var_00) {
        var_04 playsoundtoplayer("mp_bodycount_tick_positive", var_04);
        continue;
      }

      if(var_4.team == var_02)
        var_04 playsoundtoplayer("mp_bodycount_tick_negative", var_04);
    }
  }

  scripts\mp\gamelogic::updategameevents();
}

removefromalivecount(var_00) {
  var_01 = self.pers["lives"];
  var_02 = scripts\mp\utility\game::getgametypenumlives() != 0 && var_01 == 0;
  var_03 = self.team;

  if(isdefined(self.switching_teams) && self.switching_teams && isdefined(self.joining_team) && self.joining_team == self.team)
    var_03 = self.leaving_team;

  if(isdefined(var_00))
    removeallfromlivescount();
  else if(isdefined(self.switching_teams) && (!level.ingraceperiod || self.hasdonecombat)) {
    if(var_01)
      self.pers["lives"]--;
  }

  decrementalivecount(var_03, var_02);
}

decrementalivecount(var_00, var_01) {
  level.alivecount[var_00]--;

  for (var_02 = 0; var_02 < level.alive_players[var_00].size; var_2++) {
    if(level.alive_players[var_00][var_02] == self) {
      level.alive_players[var_00][var_02] = level.alive_players[var_00][level.alive_players[var_00].size - 1];
      level.alive_players[var_00][level.alive_players[var_00].size - 1] = undefined;
      break;
    }
  }

  if(scripts\mp\utility\game::istrue(var_01) && (var_00 == "allies" || var_00 == "axis")) {
    var_03 = level.otherteam[var_00];

    foreach(var_05 in level.players) {
      if(var_5.team == var_00) {
        var_05 playsoundtoplayer("mp_bodycount_tick_negative", var_05);
        continue;
      }

      if(var_5.team == var_03)
        var_05 playsoundtoplayer("mp_bodycount_tick_positive", var_05);
    }
  }

  scripts\mp\gamelogic::updategameevents();
}

addtolivescount() {
  level.livescount[self.team] = level.livescount[self.team] + self.pers["lives"];
}

removefromlivescount() {
  level.livescount[self.team]--;
  level.livescount[self.team] = int(max(0, level.livescount[self.team]));
}

removeallfromlivescount() {
  level.livescount[self.team] = level.livescount[self.team] - self.pers["lives"];
  level.livescount[self.team] = int(max(0, level.livescount[self.team]));
}

resetuiomnvarscommon() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_juiced_end_milliseconds", 0);
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
}

resetuidvarsonconnect() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_juiced_end_milliseconds", 0);
  self setclientdvar("ui_eyes_on_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
}

monitorwallrun() {
  self endon("death");
  self endon("disconnect");

  for (;;) {
    if(self iswallrunning())
      self.func_AA43 = gettime();

    wait 0.05;
  }
}

watchforslide() {
  self endon("death");
  self endon("disconnect");

  for (;;)
    self waittill("sprint_slide_begin");
}

func_13B76() {
  self endon("death");
  self endon("disconnect");
  self.func_11563 = [];

  for (;;) {
    var_00 = (self.origin[0], self.origin[1], self.origin[2] + 64);
    var_01 = self getplayerangles();
    var_02 = anglestoforward(var_01);
    var_03 = var_00 + var_02 * 10000;
    var_04 = bullettrace(var_00, var_03, 1, self, 0, 0, 0, 0, 0);
    var_05 = var_4["entity"];

    if(isdefined(var_05) && isplayer(var_05) && var_5.team != self.team && scripts\mp\equipment\phase_shift::areentitiesinphase(self, var_05)) {
      if(isdefined(var_05))
        func_12F36("ui_target_health", var_5.health);

      if(isdefined(var_05))
        func_12F36("ui_target_max_health", var_5.maxhealth);

      if(isdefined(var_05))
        func_12F36("ui_target_entity_num", var_05 getentitynumber());
    } else
      func_12F36("ui_target_entity_num", -1);

    wait 0.1;
  }
}

func_12F36(var_00, var_01) {
  scripts\engine\utility::waitframe();

  if(!isdefined(self)) {
    return;
  }
  if(!isdefined(var_01)) {
    return;
  }
  if(!isdefined(self.func_11563[var_00]) || var_01 != self.func_11563[var_00]) {
    self setclientomnvar(var_00, var_01);
    self.func_11563[var_00] = var_01;
  }
}