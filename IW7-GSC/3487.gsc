/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3487.gsc
***************************************/

init() {
  var_00 = getentarray("heli_start", "targetname");
  var_01 = getentarray("heli_loop_start", "targetname");

  if(!var_0.size && !var_1.size) {
    return;
  }
  level.chopper = undefined;
  level.func_8D96 = getentarray("heli_start", "targetname");
  level.heli_loop_nodes = getentarray("heli_loop_start", "targetname");
  level.func_110D1 = scripts\engine\utility::getstructarray("strafe_path", "targetname");
  level.heli_leave_nodes = getentarray("heli_leave", "targetname");
  level.heli_crash_nodes = getentarray("heli_crash_start", "targetname");
  level.func_8D75 = 5;
  level.func_8D73 = 2000;
  level.heli_debug = 0;
  level.func_8D9A = 0.5;
  level.func_8D9F = 1.5;
  level.heli_turretclipsize = 60;
  level.heli_visual_range = 3700;
  level.func_8D98 = 5;
  level.func_8D97 = 0.5;
  level.func_8D74 = 256;
  level.func_8D76 = 0.3;
  level.func_8D2C = 0.3;
  level.func_8D2E = 1000;
  level.func_8D2D = 4096;
  level.heli_angle_offset = 90;
  level.func_8D56 = 0;
  level func_D80F();
  level.chopper_fx["damage"]["light_smoke"] = loadfx("vfx\core\smktrail\smoke_trail_white_heli_emitter");
  level.chopper_fx["damage"]["heavy_smoke"] = loadfx("vfx\core\mp\killstreaks\vfx_helo_damage.vfx");
  level.chopper_fx["damage"]["on_fire"] = loadfx("vfx\core\expl\fire_smoke_trail_l_emitter");
  level.chopper_fx["light"]["left"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["light"]["right"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["light"]["belly"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["light"]["tail"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["explode"]["medium"] = loadfx("vfx\core\expl\aerial_explosion");
  level.chopper_fx["explode"]["large"] = loadfx("vfx\core\expl\helicopter_explosion_secondary_small");
  level.chopper_fx["smoke"]["trail"] = loadfx("vfx\core\smktrail\smoke_trail_white_heli");
  level.chopper_fx["explode"]["death"] = [];
  level.chopper_fx["explode"]["death"]["apache"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["explode"]["air_death"]["apache"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.lightfxfunc["apache"] = ::defaultlightfx;
  level.lightfxfunc["cobra"] = ::defaultlightfx;
  level.chopper_fx["explode"]["death"]["littlebird"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.chopper_fx["explode"]["air_death"]["littlebird"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.lightfxfunc["littlebird"] = ::defaultlightfx;
  level._effect["vehicle_flares"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_warden_em_flares.vfx");
  level.chopper_fx["fire"]["trail"]["medium"] = loadfx("vfx\core\expl\fire_smoke_trail_l_emitter");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("helicopter", ::usehelicopter);
  level.func_8DB6["tracking"][0] = "ac130_fco_moreenemy";
  level.func_8DB6["tracking"][1] = "ac130_fco_getthatguy";
  level.func_8DB6["tracking"][2] = "ac130_fco_guyrunnin";
  level.func_8DB6["tracking"][3] = "ac130_fco_gotarunner";
  level.func_8DB6["tracking"][4] = "ac130_fco_personnelthere";
  level.func_8DB6["tracking"][5] = "ac130_fco_rightthere";
  level.func_8DB6["tracking"][6] = "ac130_fco_tracking";
  level.func_8DB6["locked"][0] = "ac130_fco_lightemup";
  level.func_8DB6["locked"][1] = "ac130_fco_takehimout";
  level.func_8DB6["locked"][2] = "ac130_fco_nailthoseguys";
  level.func_A99A = 0;
  level.heliconfigs = [];
  var_02 = spawnstruct();
  var_2.scorepopup = "destroyed_helicopter";
  var_2.callout = "callout_destroyed_helicopter";
  var_2.samdamagescale = 0.09;
  var_2.enginevfxtag = "tag_engine_left";
  level.heliconfigs["helicopter"] = var_02;
  var_02 = spawnstruct();
  var_2.scorepopup = "destroyed_little_bird";
  var_2.callout = "callout_destroyed_little_bird";
  var_2.samdamagescale = 0.09;
  var_2.enginevfxtag = "tag_engine_left";
  level.heliconfigs["airdrop"] = var_02;
  var_02 = spawnstruct();
  var_2.scorepopup = "destroyed_dronedrop";
  var_2.func_52DA = "dronedrop_destroyed";
  var_2.callout = "callout_destroyed_dronedrop";
  level.heliconfigs["dronedrop"] = var_02;
  var_02 = spawnstruct();
  var_2.scorepopup = "destroyed_pavelow";
  var_2.callout = "callout_destroyed_helicopter_flares";
  var_2.samdamagescale = 0.07;
  var_2.enginevfxtag = "tag_engine_left";
  level.heliconfigs["flares"] = var_02;
  scripts\mp\utility\game::func_DB8D("helicopter");
}

makehelitype(var_00, var_01, var_02) {
  level.chopper_fx["explode"]["death"][var_00] = loadfx(var_01);
  level.lightfxfunc[var_00] = var_02;
}

addairexplosion(var_00, var_01) {
  level.chopper_fx["explode"]["air_death"][var_00] = loadfx(var_01);
}

defaultlightfx() {
  playfxontag(level.chopper_fx["light"]["left"], self, "tag_light_L_wing");
  wait 0.05;
  playfxontag(level.chopper_fx["light"]["right"], self, "tag_light_R_wing");
  wait 0.05;
  playfxontag(level.chopper_fx["light"]["belly"], self, "tag_light_belly");
  wait 0.05;
  playfxontag(level.chopper_fx["light"]["tail"], self, "tag_light_tail");
}

usehelicopter(var_00, var_01) {
  return tryusehelicopter(var_00, "helicopter");
}

tryusehelicopter(var_00, var_01) {
  var_02 = 1;

  if(isdefined(level.chopper))
    var_03 = 1;
  else
    var_03 = 0;

  if(isdefined(level.chopper) && var_03) {
    self iprintlnbold( & "KILLSTREAKS_HELI_IN_QUEUE");

    if(isdefined(var_01) && var_01 != "helicopter")
      var_04 = "helicopter_" + var_01;
    else
      var_04 = "helicopter";

    var_05 = spawn("script_origin", (0, 0, 0));
    var_05 hide();
    var_05 thread deleteonentnotify(self, "disconnect");
    var_5.player = self;
    var_5.lifeid = var_00;
    var_5.helitype = var_01;
    var_5.streakname = var_04;
    scripts\mp\utility\game::func_DB8B("helicopter", var_05);
    var_06 = undefined;

    if(!self hasweapon(scripts\engine\utility::getlastweapon()))
      var_06 = scripts\mp\killstreaks\utility::getfirstprimaryweapon();
    else
      var_06 = scripts\engine\utility::getlastweapon();

    var_07 = scripts\mp\utility\game::getkillstreakweapon("helicopter");
    return 0;
  } else if(scripts\mp\utility\game::currentactivevehiclecount() >= scripts\mp\utility\game::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility\game::maxvehiclesallowed()) {
    self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
    return 0;
  }

  var_02 = 1;
  func_10DA2(var_00, var_01);
  return 1;
}

deleteonentnotify(var_00, var_01) {
  self endon("death");
  var_00 waittill(var_01);
  self delete();
}

func_10DA2(var_00, var_01) {
  scripts\mp\utility\game::incrementfauxvehiclecount();
  var_02 = undefined;

  if(!isdefined(var_01))
    var_01 = "";

  var_03 = "helicopter";
  var_04 = self.pers["team"];
  var_02 = level.func_8D96[randomint(level.func_8D96.size)];
  scripts\mp\matchdata::logkillstreakevent(var_03, self.origin);
  thread func_8D9B(var_00, self, var_02, self.pers["team"], var_01);
}

func_D80F() {
  level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["allies"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
  level.heli_sound["axis"]["hit"] = "cobra_helicopter_hit";
  level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
  level.heli_sound["axis"]["damaged"] = "cobra_helicopter_damaged";
  level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
  level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
  level.heli_sound["axis"]["crash"] = "exp_helicopter_fuel";
  level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

heli_getteamforsoundclip() {
  var_00 = self.team;

  if(level.multiteambased)
    var_00 = "axis";

  return var_00;
}

func_1072E(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnhelicopter(var_00, var_01, var_02, var_03, var_04);

  if(!isdefined(var_05))
    return undefined;

  if(var_04 == "vehicle_battle_hind")
    var_5.func_8DA0 = "cobra";
  else
    var_5.func_8DA0 = level.func_8DA1[var_04];

  var_05 thread[[level.lightfxfunc[var_5.func_8DA0]]]();
  var_05 func_184E();
  var_5.zoffset = (0, 0, var_05 gettagorigin("tag_origin")[2] - var_05 gettagorigin("tag_ground")[2]);
  var_5.attractor = missile_createattractorent(var_05, level.func_8D2E, level.func_8D2D);
  return var_05;
}

func_8DB6(var_00) {
  if(gettime() - level.func_A99A < 6000) {
    return;
  }
  level.func_A99A = gettime();
  var_01 = randomint(level.func_8DB6[var_00].size);
  var_02 = level.func_8DB6[var_00][var_01];
  var_03 = scripts\mp\teams::getteamvoiceprefix(self.team) + var_02;
  self playlocalsound(var_03);
}

updateareanodes(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    var_3.func_1314F = [];
    var_3.func_C056 = 0;
  }

  foreach(var_06 in level.players) {
    if(!isalive(var_06)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    foreach(var_03 in var_00) {
      if(distancesquared(var_6.origin, var_3.origin) > 1048576) {
        continue;
      }
      var_3.func_1314F[var_3.func_1314F.size] = var_06;
    }
  }

  var_10 = var_0[0];

  foreach(var_03 in var_00) {
    var_12 = getent(var_3.target, "targetname");

    foreach(var_06 in var_3.func_1314F) {
      var_3.func_C056 = var_3.func_C056 + 1;

      if(bullettracepassed(var_6.origin + (0, 0, 32), var_12.origin, 0, var_06))
        var_3.func_C056 = var_3.func_C056 + 3;
    }

    if(var_3.func_C056 > var_10.func_C056)
      var_10 = var_03;
  }

  return getent(var_10.target, "targetname");
}

func_8D9B(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_2.origin;
  var_06 = var_2.angles;
  var_07 = "cobra_mp";
  var_08 = "vehicle_battle_hind";
  var_09 = func_1072E(var_01, var_05, var_06, var_07, var_08);

  if(!isdefined(var_09)) {
    return;
  }
  level.chopper = var_09;

  if(var_03 == "allies")
    level.allieschopper = var_09;
  else
    level.axischopper = var_09;

  var_9.helitype = var_04;
  var_9.lifeid = var_00;
  var_9.team = var_03;
  var_9.pers["team"] = var_03;
  var_9.owner = var_01;
  var_09 setotherent(var_01);
  var_9.func_10DCD = var_02;
  var_9.maxhealth = level.func_8D73;
  var_9.func_11568 = level.func_8D9A;
  var_9.primarytarget = undefined;
  var_9.secondarytarget = undefined;
  var_9.attacker = undefined;
  var_9.currentstate = "ok";
  var_09 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_01);
  var_9.empgrenaded = 0;

  if(var_04 == "flares" || var_04 == "minigun")
    var_09 thread scripts\mp\killstreaks\flares::flares_monitor(1);

  var_09 thread heli_leave_on_disconnect(var_01);
  var_09 thread heli_leave_on_changeteams(var_01);
  var_09 thread heli_leave_on_gameended(var_01);
  var_09 thread heli_damage_monitor(var_04);
  var_09 thread heli_watchempdamage();
  var_09 thread heli_watchdeath();
  var_09 thread func_8D49();
  var_09 endon("helicopter_done");
  var_09 endon("crashing");
  var_09 endon("leaving");
  var_09 endon("death");
  var_10 = getentarray("heli_attack_area", "targetname");
  var_11 = undefined;
  var_11 = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
  var_09 heli_fly_simple_path(var_02);
  var_09 thread heli_targeting();
  var_09 thread heli_leave_on_timeout(60.0);
  var_09 thread heli_fly_loop_path(var_11);
}

func_8D49() {
  var_00 = self getentitynumber();
  scripts\engine\utility::waittill_any("death", "crashing", "leaving");
  func_E109(var_00);
  self notify("helicopter_done");
  self notify("helicopter_removed");
  var_01 = undefined;
  var_02 = scripts\mp\utility\game::func_DB94("helicopter");

  if(!isdefined(var_02))
    level.chopper = undefined;
  else {
    var_01 = var_2.player;
    var_03 = var_2.lifeid;
    var_04 = var_2.streakname;
    var_05 = var_2.helitype;
    var_02 delete();

    if(isdefined(var_01) && (var_1.sessionstate == "playing" || var_1.sessionstate == "dead")) {
      var_01 func_10DA2(var_03, var_05);
      return;
    }

    level.chopper = undefined;
  }
}

heli_targeting() {
  self notify("heli_targeting");
  self endon("heli_targeting");
  self endon("death");
  self endon("helicopter_done");

  for (;;) {
    var_00 = [];
    self.primarytarget = undefined;
    self.secondarytarget = undefined;

    foreach(var_02 in level.characters) {
      wait 0.05;

      if(!func_3922(var_02)) {
        continue;
      }
      var_0[var_0.size] = var_02;
    }

    if(var_0.size) {
      for (var_04 = func_7E00(var_00); !isdefined(var_04); var_04 = func_7E00(var_00))
        wait 0.05;

      self.primarytarget = var_04;
      self notify("primary acquired");
    }

    if(isdefined(self.primarytarget)) {
      fireontarget(self.primarytarget);
      continue;
    }

    wait 0.25;
  }
}

func_3922(var_00) {
  var_01 = 1;

  if(!isalive(var_00) || isdefined(var_0.sessionstate) && var_0.sessionstate != "playing")
    return 0;

  if(self.helitype == "remote_mortar") {
    if(var_00 sightconetrace(self.origin, self) < 1)
      return 0;
  }

  if(distance(var_0.origin, self.origin) > level.heli_visual_range)
    return 0;

  if(!self.owner scripts\mp\utility\game::isenemy(var_00))
    return 0;

  if(isdefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5)
    return 0;

  if(var_00 scripts\mp\utility\game::_hasperk("specialty_blindeye"))
    return 0;

  var_02 = self.origin + (0, 0, -160);
  var_03 = anglestoforward(self.angles);
  var_04 = var_02 + 144 * var_03;

  if(var_00 sightconetrace(var_04, self) < level.func_8D97)
    return 0;

  return var_01;
}

func_7E00(var_00) {
  foreach(var_02 in var_00) {
    if(!isdefined(var_02)) {
      continue;
    }
    update_player_threat(var_02);
  }

  var_04 = 0;
  var_05 = undefined;
  var_06 = getentarray("minimap_corner", "targetname");

  foreach(var_02 in var_00) {
    if(!isdefined(var_02)) {
      continue;
    }
    if(var_6.size == 2) {
      var_08 = var_6[0].origin;
      var_09 = var_6[0].origin;

      if(var_6[1].origin[0] > var_9[0])
        var_09 = (var_6[1].origin[0], var_9[1], var_9[2]);
      else
        var_08 = (var_6[1].origin[0], var_8[1], var_8[2]);

      if(var_6[1].origin[1] > var_9[1])
        var_09 = (var_9[0], var_6[1].origin[1], var_9[2]);
      else
        var_08 = (var_8[0], var_6[1].origin[1], var_8[2]);

      if(var_2.origin[0] < var_8[0] || var_2.origin[0] > var_9[0] || var_2.origin[1] < var_8[1] || var_2.origin[1] > var_9[1])
        continue;
    }

    if(var_2.threatlevel < var_04) {
      continue;
    }
    if(!bullettracepassed(var_2.origin + (0, 0, 32), self.origin, 0, self)) {
      wait 0.05;
      continue;
    }

    var_04 = var_2.threatlevel;
    var_05 = var_02;
  }

  return var_05;
}

update_player_threat(var_00) {
  var_0.threatlevel = 0;
  var_01 = distance(var_0.origin, self.origin);
  var_0.threatlevel = var_0.threatlevel + (level.heli_visual_range - var_01) / level.heli_visual_range * 100;

  if(isdefined(self.attacker) && var_00 == self.attacker)
    var_0.threatlevel = var_0.threatlevel + 100;

  if(isplayer(var_00))
    var_0.threatlevel = var_0.threatlevel + var_0.score * 4;

  if(isdefined(var_0.antithreat))
    var_0.threatlevel = var_0.threatlevel - var_0.antithreat;

  if(var_0.threatlevel <= 0)
    var_0.threatlevel = 1;
}

heli_reset() {
  self getplayerspeedbyweapon();
  self getplayerkills();
  self vehicle_setspeed(80, 35);
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
  self setneargoalnotifydist(256);
  self setturningability(0.9);
}

addrecentdamage(var_00) {
  self endon("death");
  self.recentdamageamount = self.recentdamageamount + var_00;
  wait 4.0;
  self.recentdamageamount = self.recentdamageamount - var_00;
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  if(isdefined(var_00)) {
    if(isdefined(self.owner) && var_00 == self.owner && self.streakname == "heli_sniper" || isdefined(var_0.class) && var_0.class == "worldspawn" || var_00 == self)
      return -1;
  }

  var_05 = var_03;
  var_06 = 2;
  var_07 = 3;
  var_08 = 4;

  if(isdefined(self.helitype) && self.helitype == "dronedrop") {
    var_06 = 1;
    var_07 = 1;
    var_08 = 2;
  }

  var_05 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_00, var_01, var_02, var_05, self.maxhealth, var_06, var_07, var_08);
  thread addrecentdamage(var_05);
  self notify("heli_damage_fx");

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_00))
    var_05 = 0;

  return var_05;
}

handledeathdamage(var_00, var_01, var_02, var_03) {
  if(isdefined(var_00)) {
    var_04 = level.heliconfigs[self.streakname];
    var_05 = "";

    if(isdefined(self.streakinfo))
      var_05 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

    var_06 = var_4.callout;

    if(var_05 != "")
      var_06 = var_06 + "_" + var_05;

    var_07 = scripts\mp\damage::onkillstreakkilled(self.streakname, var_00, var_01, var_02, var_03, var_4.scorepopup, var_4.func_52DA, var_06);

    if(var_07) {
      var_00 notify("destroyed_helicopter");
      self.func_A667 = var_00;
    }

    if(var_01 == "heli_pilot_turret_mp")
      var_00 scripts\mp\missions::processchallenge("ch_enemy_down");

    scripts\mp\missions::func_3DE3(var_00, self, var_01);
  }
}

heli_damage_monitor(var_00, var_01, var_02) {
  self endon("crashing");
  self endon("leaving");
  self.streakname = var_00;
  self.recentdamageamount = 0;

  if(!scripts\mp\utility\game::istrue(var_02))
    thread heli_health();

  scripts\mp\damage::monitordamage(self.maxhealth, "helicopter", ::handledeathdamage, ::modifydamage, 1, var_01);
}

heli_watchempdamage() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self.owner endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("emp_damage", var_00, var_01);
    self.empgrenaded = 1;

    if(isdefined(self.mgturretleft))
      self.mgturretleft notify("stop_shooting");

    if(isdefined(self.mgturretright))
      self.mgturretright notify("stop_shooting");

    wait(var_01);
    self.empgrenaded = 0;

    if(isdefined(self.mgturretleft))
      self.mgturretleft notify("turretstatechange");

    if(isdefined(self.mgturretright))
      self.mgturretright notify("turretstatechange");
  }
}

heli_health() {
  self endon("leaving");
  self endon("crashing");
  self.currentstate = "ok";
  self.laststate = "ok";
  self give_fwoosh_perk(3);
  var_00 = 3;
  self give_fwoosh_perk(var_00);
  var_01 = level.heliconfigs[self.streakname];

  for (;;) {
    self waittill("heli_damage_fx");

    if(var_00 > 0 && self.damagetaken >= self.maxhealth) {
      var_00 = 0;
      self give_fwoosh_perk(var_00);
      stopfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, var_1.enginevfxtag);
      self notify("death");
      break;
    } else {
      if(var_00 > 1 && self.damagetaken >= self.maxhealth * 0.66) {
        var_00 = 1;
        self give_fwoosh_perk(var_00);
        self.currentstate = "heavy smoke";
        stopfxontag(level.chopper_fx["damage"]["light_smoke"], self, var_1.enginevfxtag);
        playfxontag(level.chopper_fx["damage"]["heavy_smoke"], self, var_1.enginevfxtag);
        continue;
      }

      if(var_00 > 2 && self.damagetaken >= self.maxhealth * 0.33) {
        var_00 = 2;
        self give_fwoosh_perk(var_00);
        self.currentstate = "light smoke";
        playfxontag(level.chopper_fx["damage"]["light_smoke"], self, var_1.enginevfxtag);
      }
    }
  }
}

heli_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
    thread heli_explode(1);
  else {
    var_00 = level.heliconfigs[self.streakname];
    playfxontag(level.chopper_fx["damage"]["on_fire"], self, var_0.enginevfxtag);
    thread heli_crash();
  }
}

heli_crash() {
  self notify("crashing");
  self getplayerkillstreakcombatmode();
  var_00 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];

  if(isdefined(self.mgturretleft))
    self.mgturretleft notify("stop_shooting");

  if(isdefined(self.mgturretright))
    self.mgturretright notify("stop_shooting");

  thread heli_spin(180);
  thread heli_secondary_explosions();
  heli_fly_simple_path(var_00);
  thread heli_explode();
}

heli_secondary_explosions() {
  var_00 = heli_getteamforsoundclip();
  var_01 = level.heliconfigs[self.streakname];
  playfxontag(level.chopper_fx["explode"]["large"], self, var_1.enginevfxtag);
  self playsound(level.heli_sound[var_00]["hitsecondary"]);
  wait 3.0;

  if(!isdefined(self)) {
    return;
  }
  playfxontag(level.chopper_fx["explode"]["large"], self, var_1.enginevfxtag);
  self playsound(level.heli_sound[var_00]["hitsecondary"]);
}

heli_spin(var_00) {
  self endon("death");
  var_01 = heli_getteamforsoundclip();
  self playsound(level.heli_sound[var_01]["hit"]);
  thread spinsoundshortly();
  self setyawspeed(var_00, var_00, var_00);

  while (isdefined(self)) {
    self settargetyaw(self.angles[1] + var_00 * 0.9);
    wait 1;
  }
}

spinsoundshortly() {
  self endon("death");
  wait 0.25;
  var_00 = heli_getteamforsoundclip();
  self stoploopsound();
  wait 0.05;
  self playloopsound(level.heli_sound[var_00]["spinloop"]);
  wait 0.05;
  self playloopsound(level.heli_sound[var_00]["spinstart"]);
}

heli_explode(var_00) {
  self notify("death");

  if(isdefined(var_00) && isdefined(level.chopper_fx["explode"]["air_death"][self.func_8DA0])) {
    var_01 = self gettagangles("tag_deathfx");
    playfx(level.chopper_fx["explode"]["air_death"][self.func_8DA0], self gettagorigin("tag_deathfx"), anglestoforward(var_01), anglestoup(var_01));
  } else {
    var_02 = self.origin;
    var_03 = self.origin + (0, 0, 1) - self.origin;
    playfx(level.chopper_fx["explode"]["death"][self.func_8DA0], var_02, var_03);
  }

  var_04 = heli_getteamforsoundclip();
  self playsound(level.heli_sound[var_04]["crash"]);
  wait 0.05;

  if(isdefined(self.killcament))
    self.killcament delete();

  scripts\mp\utility\game::decrementfauxvehiclecount();
  self delete();
}

check_owner() {
  if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    thread heli_leave();
    return 0;
  }

  return 1;
}

heli_leave_on_disconnect(var_00) {
  self endon("death");
  self endon("helicopter_done");
  var_00 waittill("disconnect");
  thread heli_leave();
}

heli_leave_on_changeteams(var_00) {
  self endon("death");
  self endon("helicopter_done");

  if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
    return;
  }
  var_00 scripts\engine\utility::waittill_any("joined_team", "joined_spectators");
  thread heli_leave();
}

heli_leave_on_spawned(var_00) {
  self endon("death");
  self endon("helicopter_done");
  var_00 waittill("spawned");
  thread heli_leave();
}

heli_leave_on_gameended(var_00) {
  self endon("death");
  self endon("helicopter_done");
  level waittill("game_ended");
  thread heli_leave();
}

heli_leave_on_timeout(var_00) {
  self endon("death");
  self endon("helicopter_done");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  thread heli_leave();
}

fireontarget(var_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_01 = 15;
  var_02 = 0;
  var_03 = 0;

  foreach(var_05 in level.heli_loop_nodes) {
    var_2++;
    var_03 = var_03 + var_5.origin[2];
  }

  var_07 = var_03 / var_02;
  self notify("newTarget");

  if(isdefined(self.secondarytarget) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth) {
    return;
  }
  if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
    return;
  }
  var_08 = self.primarytarget;
  var_8.antithreat = 0;
  var_09 = self.primarytarget.origin * (1, 1, 0);
  var_10 = self.origin * (0, 0, 1);
  var_11 = var_09 + var_10;
  var_12 = distance2d(self.origin, var_8.origin);

  if(var_12 < 1000)
    var_01 = 600;

  var_13 = anglestoforward(var_8.angles);
  var_13 = var_13 * (1, 1, 0);
  var_14 = var_11 + var_01 * var_13;
  var_15 = var_14 - var_11;
  var_16 = vectortoangles(var_15);
  var_16 = var_16 * (1, 1, 0);
  thread attackgroundtarget(var_08);
  self vehicle_setspeed(80);

  if(distance2d(self.origin, var_14) < 1000)
    var_14 = var_14 * 1.5;

  var_14 = var_14 * (1, 1, 0);
  var_14 = var_14 + (0, 0, var_07);
  _setvehgoalpos(var_14, 1, 1);
  self waittill("near_goal");

  if(!isdefined(var_08) || !isalive(var_08)) {
    return;
  }
  self setlookatent(var_08);
  thread isfacing(10, var_08);
  scripts\engine\utility::waittill_any_timeout(4, "facing");

  if(!isdefined(var_08) || !isalive(var_08)) {
    return;
  }
  self getplayerkillstreakcombatmode();
  var_17 = var_11 + var_01 * anglestoforward(var_16);
  self setmaxpitchroll(40, 30);
  _setvehgoalpos(var_17, 1, 1);
  self setmaxpitchroll(30, 30);

  if(isdefined(var_08) && isalive(var_08)) {
    if(isdefined(var_8.antithreat))
      var_8.antithreat = var_8.antithreat + 100;
    else
      var_8.antithreat = 100;
  }

  scripts\engine\utility::waittill_any_timeout(3, "near_goal");
}

attackgroundtarget(var_00) {
  self notify("attackGroundTarget");
  self endon("attackGroundTarget");
  self stoploopsound();
  self.isattacking = 1;
  self setturrettargetent(var_00);
  waitontargetordeath(var_00, 3.0);

  if(!isalive(var_00))
    self.isattacking = 0;
  else {
    var_01 = distance2dsquared(self.origin, var_0.origin);

    if(var_01 < 640000) {
      thread dropbombs(var_00);
      self.isattacking = 0;
      return;
    } else {
      if(checkisfacing(50, var_00) && scripts\engine\utility::cointoss()) {
        thread firemissile(var_00);
        self.isattacking = 0;
        return;
        return;
      }

      var_02 = weaponfiretime("cobra_20mm_mp");
      var_03 = 0;
      var_04 = 0;

      for (var_05 = 0; var_05 < level.heli_turretclipsize; var_5++) {
        if(!isdefined(self)) {
          break;
        }
        if(self.empgrenaded) {
          break;
        }
        if(!isdefined(var_00)) {
          break;
        }
        if(!isalive(var_00)) {
          break;
        }
        if(self.damagetaken >= self.maxhealth) {
          continue;
        }
        if(!checkisfacing(55, var_00)) {
          self stoploopsound();
          var_04 = 0;
          wait(var_02);
          var_5--;
          continue;
        }

        if(var_05 < level.heli_turretclipsize - 1)
          wait(var_02);

        if(!isdefined(var_00) || !isalive(var_00)) {
          break;
        }
        if(!var_04) {
          self playloopsound("weap_hind_20mm_fire_npc");
          var_04 = 1;
        }

        self giveflagassistedcapturepoints("cobra_20mm_mp");
        self fireweapon("tag_flash", var_00);
      }

      if(!isdefined(self)) {
        return;
      }
      self stoploopsound();
      var_04 = 0;
      self.isattacking = 0;
    }
  }
}

checkisfacing(var_00, var_01) {
  self endon("death");
  self endon("leaving");

  if(!isdefined(var_00))
    var_00 = 10;

  var_02 = anglestoforward(self.angles);
  var_03 = var_1.origin - self.origin;
  var_02 = var_02 * (1, 1, 0);
  var_03 = var_03 * (1, 1, 0);
  var_03 = vectornormalize(var_03);
  var_02 = vectornormalize(var_02);
  var_04 = vectordot(var_03, var_02);
  var_05 = cos(var_00);

  if(var_04 >= var_05)
    return 1;
  else
    return 0;
}

isfacing(var_00, var_01) {
  self endon("death");
  self endon("leaving");

  if(!isdefined(var_00))
    var_00 = 10;

  while (isalive(var_01)) {
    var_02 = anglestoforward(self.angles);
    var_03 = var_1.origin - self.origin;
    var_02 = var_02 * (1, 1, 0);
    var_03 = var_03 * (1, 1, 0);
    var_03 = vectornormalize(var_03);
    var_02 = vectornormalize(var_02);
    var_04 = vectordot(var_03, var_02);
    var_05 = cos(var_00);

    if(var_04 >= var_05) {
      self notify("facing");
      break;
    }

    wait 0.1;
  }
}

waitontargetordeath(var_00, var_01) {
  self endon("death");
  self endon("helicopter_done");
  var_00 endon("death");
  var_00 endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout("turret_on_target", var_01);
}

firemissile(var_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(level.func_DADB)
    var_01 = 1;
  else
    var_01 = 2;

  for (var_02 = 0; var_02 < var_01; var_2++) {
    if(!isdefined(var_00)) {
      return;
    }
    if(scripts\engine\utility::cointoss()) {
      var_03 = scripts\mp\utility\game::_magicbullet("hind_missile_mp", self gettagorigin("tag_missile_right") - (0, 0, 64), var_0.origin, self.owner);
      var_3.vehicle_fired_from = self;
    } else {
      var_03 = scripts\mp\utility\game::_magicbullet("hind_missile_mp", self gettagorigin("tag_missile_left") - (0, 0, 64), var_0.origin, self.owner);
      var_3.vehicle_fired_from = self;
    }

    var_03 missile_settargetent(var_00);
    var_3.owner = self;
    var_03 missile_setflightmodedirect();
    wait(0.5 / var_01);
  }
}

dropbombs(var_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(!isdefined(var_00)) {
    return;
  }
  for (var_01 = 0; var_01 < randomintrange(2, 5); var_1++) {
    if(scripts\engine\utility::cointoss()) {
      var_02 = scripts\mp\utility\game::_magicbullet("hind_bomb_mp", self gettagorigin("tag_missile_left") - (0, 0, 45), var_0.origin, self.owner);
      var_2.vehicle_fired_from = self;
    } else {
      var_02 = scripts\mp\utility\game::_magicbullet("hind_bomb_mp", self gettagorigin("tag_missile_right") - (0, 0, 45), var_0.origin, self.owner);
      var_2.vehicle_fired_from = self;
    }

    wait(randomfloatrange(0.35, 0.65));
  }
}

getoriginoffsets(var_00) {
  var_01 = self.origin;
  var_02 = var_0.origin;
  var_03 = 0;
  var_04 = 40;
  var_05 = (0, 0, -196);

  for (var_06 = bullettrace(var_01 + var_05, var_02 + var_05, 0, self); distancesquared(var_6["position"], var_02 + var_05) > 10 && var_03 < var_04; var_06 = bullettrace(var_01 + var_05, var_02 + var_05, 0, self)) {
    if(var_1[2] < var_2[2])
      var_01 = var_01 + (0, 0, 128);
    else if(var_1[2] > var_2[2])
      var_02 = var_02 + (0, 0, 128);
    else {
      var_01 = var_01 + (0, 0, 128);
      var_02 = var_02 + (0, 0, 128);
    }

    var_3++;
  }

  var_07 = [];
  var_7["start"] = var_01;
  var_7["end"] = var_02;
  return var_07;
}

traveltonode(var_00) {
  var_01 = getoriginoffsets(var_00);

  if(var_1["start"] != self.origin) {
    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1["start"] + (0, 0, 30), 0);
    self setgoalyaw(var_0.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }

  if(var_1["end"] != var_0.origin) {
    if(isdefined(var_0.script_airspeed) && isdefined(var_0.script_accel)) {
      var_02 = var_0.script_airspeed;
      var_03 = var_0.script_accel;
    } else {
      var_02 = 30 + randomint(20);
      var_03 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1["end"] + (0, 0, 30), 0);
    self setgoalyaw(var_0.angles[1] + level.heli_angle_offset);
    self waittill("goal");
  }
}

_setvehgoalpos(var_00, var_01, var_02) {
  if(!isdefined(var_01))
    var_01 = 0;

  var_02 = 0;

  if(var_02)
    thread _setvehgoalposadheretomesh(var_00, var_01);
  else
    self setvehgoalpos(var_00, var_01);
}

_setvehgoalposadheretomesh(var_00, var_01) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_02 = var_00;

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    if(scripts\engine\utility::distance_2d_squared(self.origin, var_02) < 65536) {
      self setvehgoalpos(var_02, var_01);
      break;
    }

    var_03 = vectortoangles(var_02 - self.origin);
    var_04 = anglestoforward(var_03);
    var_05 = self.origin + var_04 * (1, 1, 0) * 250;
    var_06 = (0, 0, 2500);
    var_07 = var_05 + (scripts\mp\utility\game::gethelipilotmeshoffset() + var_06);
    var_08 = var_05 + (scripts\mp\utility\game::gethelipilotmeshoffset() - var_06);
    var_09 = bullettrace(var_07, var_08, 0, self, 0, 0, 1);
    var_10 = var_09;

    if(isdefined(var_9["entity"]) && var_9["entity"] == self && var_9["normal"][2] > 0.1) {
      var_11 = var_9["position"][2] - 4400;
      var_12 = var_11 - self.origin[2];

      if(var_12 > 256) {
        var_9["position"] = var_9["position"] * (1, 1, 0);
        var_9["position"] = var_9["position"] + (0, 0, self.origin[2] + 256);
      } else if(var_12 < -256) {
        var_9["position"] = var_9["position"] * (1, 1, 0);
        var_9["position"] = var_9["position"] + (0, 0, self.origin[2] - 256);
      }

      var_10 = var_9["position"] - scripts\mp\utility\game::gethelipilotmeshoffset() + (0, 0, 600);
    } else
      var_10 = var_02;

    self setvehgoalpos(var_10, 0);
    wait 0.15;
  }
}

heli_fly_simple_path(var_00) {
  self endon("death");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  var_01 = var_00;

  while (isdefined(var_1.target)) {
    var_02 = getent(var_1.target, "targetname");

    if(isdefined(var_1.script_airspeed) && isdefined(var_1.script_accel)) {
      var_03 = var_1.script_airspeed;
      var_04 = var_1.script_accel;
    } else {
      var_03 = 30 + randomint(20);
      var_04 = 15 + randomint(15);
    }

    if(isdefined(self.isattacking) && self.isattacking) {
      wait 0.05;
      continue;
    }

    if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.05;
      continue;
    }

    self vehicle_setspeed(75, 35);

    if(!isdefined(var_2.target)) {
      _setvehgoalpos(var_2.origin + self.zoffset, 1);
      self waittill("near_goal");
    } else {
      _setvehgoalpos(var_2.origin + self.zoffset, 0);
      self waittill("near_goal");
      self setgoalyaw(var_2.angles[1]);
      self waittillmatch("goal");
    }

    var_01 = var_02;
  }
}

heli_fly_loop_path(var_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self notify("flying");
  self endon("flying");
  heli_reset();
  thread heli_loop_speed_control(var_00);
  var_01 = var_00;

  while (isdefined(var_1.target)) {
    var_02 = getent(var_1.target, "targetname");

    if(isdefined(self.isperformingmaneuver) && self.isperformingmaneuver) {
      wait 0.25;
      continue;
    }

    if(isdefined(self.isattacking) && self.isattacking) {
      wait 0.1;
      continue;
    }

    if(isdefined(var_1.script_airspeed) && isdefined(var_1.script_accel)) {
      self.desired_speed = var_1.script_airspeed;
      self.desired_accel = var_1.script_accel;
    } else {
      self.desired_speed = 30 + randomint(20);
      self.desired_accel = 15 + randomint(15);
    }

    if(self.helitype == "flares") {
      self.desired_speed = self.desired_speed * 0.5;
      self.desired_accel = self.desired_accel * 0.5;
    }

    if(isdefined(var_2.script_delay) && isdefined(self.primarytarget) && !heli_is_threatened()) {
      _setvehgoalpos(var_2.origin + self.zoffset, 1, 1);
      self waittill("near_goal");
      wait(var_2.script_delay);
    } else {
      _setvehgoalpos(var_2.origin + self.zoffset, 0, 1);
      self waittill("near_goal");
      self setgoalyaw(var_2.angles[1]);
      self waittillmatch("goal");
    }

    var_01 = var_02;
  }
}

heli_loop_speed_control(var_00) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  if(isdefined(var_0.script_airspeed) && isdefined(var_0.script_accel)) {
    self.desired_speed = var_0.script_airspeed;
    self.desired_accel = var_0.script_accel;
  } else {
    self.desired_speed = 30 + randomint(20);
    self.desired_accel = 15 + randomint(15);
  }

  var_01 = 0;
  var_02 = 0;

  for (;;) {
    var_03 = self.desired_speed;
    var_04 = self.desired_accel;

    if(isdefined(self.isattacking) && self.isattacking) {
      wait 0.05;
      continue;
    }

    if(self.helitype != "flares" && isdefined(self.primarytarget) && !heli_is_threatened())
      var_03 = var_03 * 0.25;

    if(var_01 != var_03 || var_02 != var_04) {
      self vehicle_setspeed(75, 35);
      var_01 = var_03;
      var_02 = var_04;
    }

    wait 0.05;
  }
}

heli_is_threatened() {
  if(self.recentdamageamount > 50)
    return 1;

  if(self.currentstate == "heavy smoke")
    return 1;

  return 0;
}

func_8D55(var_00) {
  self notify("flying");
  self endon("flying");
  self endon("death");
  self endon("crashing");
  self endon("leaving");

  for (;;) {
    if(isdefined(self.isattacking) && self.isattacking) {
      wait 0.05;
      continue;
    }

    var_01 = get_best_area_attack_node(var_00);
    traveltonode(var_01);

    if(isdefined(var_1.script_airspeed) && isdefined(var_1.script_accel)) {
      var_02 = var_1.script_airspeed;
      var_03 = var_1.script_accel;
    } else {
      var_02 = 30 + randomint(20);
      var_03 = 15 + randomint(15);
    }

    self vehicle_setspeed(75, 35);
    _setvehgoalpos(var_1.origin + self.zoffset, 1);
    self setgoalyaw(var_1.angles[1] + level.heli_angle_offset);

    if(level.func_8D56 != 0) {
      self waittill("near_goal");
      wait(level.func_8D56);
      continue;
    }

    if(!isdefined(var_1.script_delay)) {
      self waittill("near_goal");
      wait(5 + randomint(5));
      continue;
    }

    self waittillmatch("goal");
    wait(var_1.script_delay);
  }
}

get_best_area_attack_node(var_00) {
  return updateareanodes(var_00);
}

heli_leave(var_00) {
  self notify("leaving");
  self getplayerkillstreakcombatmode();

  if(isdefined(self.helitype) && self.helitype == "osprey" && isdefined(self.func_C96C)) {
    _setvehgoalpos(self.func_C96C, 1);
    scripts\engine\utility::waittill_any_timeout(5, "goal");
  }

  if(!isdefined(var_00)) {
    var_01 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
    var_00 = var_1.origin;
  }

  var_02 = spawn("script_origin", var_00);

  if(isdefined(var_02)) {
    self setlookatent(var_02);
    var_02 thread wait_and_delete(3.0);
  }

  var_03 = (var_00 - self.origin) * 2000;
  heli_reset();
  self vehicle_setspeed(180, 45);
  _setvehgoalpos(var_03, 1);
  scripts\engine\utility::waittill_any_timeout(12, "goal");
  self notify("gone");
  self notify("death");
  wait 0.05;

  if(isdefined(self.killcament))
    self.killcament delete();

  scripts\mp\utility\game::decrementfauxvehiclecount();
  self delete();
}

wait_and_delete(var_00) {
  self endon("death");
  level endon("game_ended");
  wait(var_00);
  self delete();
}

debug_print3d(var_00, var_01, var_02, var_03, var_04) {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_text(var_00, var_01, var_02, var_03, var_04);
}

debug_print3d_simple(var_00, var_01, var_02, var_03) {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0) {
    if(isdefined(var_03))
      thread draw_text(var_00, (0.8, 0.8, 0.8), var_01, var_02, var_03);
    else
      thread draw_text(var_00, (0.8, 0.8, 0.8), var_01, var_02, 0);
  }
}

debug_line(var_00, var_01, var_02, var_03) {
  if(isdefined(level.heli_debug) && level.heli_debug == 1.0 && !isdefined(var_03))
    thread draw_line(var_00, var_01, var_02);
  else if(isdefined(level.heli_debug) && level.heli_debug == 1.0)
    thread draw_line(var_00, var_01, var_02, var_03);
}

draw_text(var_00, var_01, var_02, var_03, var_04) {
  if(var_04 == 0) {
    while (isdefined(var_02))
      wait 0.05;
  } else {
    for (var_05 = 0; var_05 < var_04; var_5++) {
      if(!isdefined(var_02)) {
        break;
      }
      wait 0.05;
    }
  }
}

draw_line(var_00, var_01, var_02, var_03) {
  if(isdefined(var_03)) {
    for (var_04 = 0; var_04 < var_03; var_4++)
      wait 0.05;
  } else {
    for (;;)
      wait 0.05;
  }
}

func_184E() {
  level.helis[self getentitynumber()] = self;
}

func_E109(var_00) {
  level.helis[var_00] = undefined;
}

addtolittlebirdlist(var_00) {
  if(isdefined(var_00) && var_00 == "lbSniper")
    level.lbsniper = self;

  level.littlebirds[self getentitynumber()] = self;
}

func_E111(var_00) {
  var_01 = self getentitynumber();
  self waittill("death");

  if(isdefined(var_00) && var_00 == "lbSniper")
    level.lbsniper = undefined;

  level.littlebirds[var_01] = undefined;
}

exceededmaxlittlebirds(var_00) {
  if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && var_00 == "littlebird_flock")
    return 1;
  else
    return 0;
}

func_C9D8() {
  self endon("death");
  self endon("disconnect");
  self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
  wait 3.5;
  self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}

lbonkilled() {
  self endon("gone");

  if(!isdefined(self)) {
    return;
  }
  self notify("crashing");

  if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
    scripts\engine\utility::waitframe();
  else {
    self vehicle_setspeed(25, 5);
    thread lbspin(randomintrange(180, 220));
    wait(randomfloatrange(1.0, 2.0));
  }

  lbexplode();
}

lbspin(var_00) {
  self endon("explode");
  playfxontag(level.chopper_fx["explode"]["medium"], self, "tail_rotor_jnt");
  thread trail_fx(level.chopper_fx["smoke"]["trail"], "tail_rotor_jnt", "stop tail smoke");
  self setyawspeed(var_00, var_00, var_00);

  while (isdefined(self)) {
    self settargetyaw(self.angles[1] + var_00 * 0.9);
    wait 1;
  }
}

lbexplode() {
  var_00 = self.origin + (0, 0, 1) - self.origin;
  var_01 = self gettagangles("tag_deathfx");
  playfx(level.chopper_fx["explode"]["air_death"]["littlebird"], self gettagorigin("tag_deathfx"), anglestoforward(var_01), anglestoup(var_01));
  self playsound("exp_helicopter_fuel");
  self notify("explode");
  removelittlebird();
}

trail_fx(var_00, var_01, var_02) {
  self notify(var_02);
  self endon(var_02);
  self endon("death");

  for (;;) {
    playfxontag(var_00, self, var_01);
    wait 0.05;
  }
}

removelittlebird() {
  if(isdefined(self.mgturretleft)) {
    if(isdefined(self.mgturretleft.killcament))
      self.mgturretleft.killcament delete();

    self.mgturretleft delete();
  }

  if(isdefined(self.mgturretright)) {
    if(isdefined(self.mgturretright.killcament))
      self.mgturretright.killcament delete();

    self.mgturretright delete();
  }

  if(isdefined(self.marker))
    self.marker delete();

  if(isdefined(level.heli_pilot[self.team]) && level.heli_pilot[self.team] == self)
    level.heli_pilot[self.team] = undefined;

  scripts\mp\utility\game::decrementfauxvehiclecount();
  self delete();
}