/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2758.gsc
***************************************/

init() {
  level.killcam = scripts\mp\tweakables::gettweakablevalue("game", "allowkillcam");
  level.killcammiscitems = [];
  var_00 = 0;

  for (;;) {
    var_01 = tablelookupbyrow("mp\miscKillcamItems.csv", var_00, 0);

    if(!isdefined(var_01) || var_01 == "") {
      break;
    }
    var_01 = int(var_01);
    var_02 = tablelookupbyrow("mp\miscKillcamItems.csv", var_00, 1);

    if(!isdefined(var_02) || var_02 == "") {
      break;
    }
    level.killcammiscitems[var_02] = var_01;
    var_0++;
  }
}

setcinematiccamerastyle(var_00, var_01, var_02) {
  self setclientomnvar("cam_scene_name", var_00);
  self setclientomnvar("cam_scene_lead", var_01);
  self setclientomnvar("cam_scene_support", var_02);
}

func_7F32(var_00, var_01, var_02) {
  if(!isdefined(var_00) || !isdefined(var_01) || var_00 == var_01 && !isagent(var_00))
    return undefined;

  if(scripts\mp\utility\game::istrue(var_1.israllytrap))
    return var_1.killcament;

  switch (var_02) {
    case "hashima_missiles_mp":
    case "sentry_shock_grenade_mp":
    case "jackal_fast_cannon_mp":
    case "sentry_shock_missile_mp":
    case "bombproj_mp":
    case "sentry_shock_mp":
    case "heli_pilot_turret_mp":
    case "iw7_c8landing_mp":
    case "super_trophy_mp":
    case "micro_turret_gun_mp":
    case "bouncingbetty_mp":
    case "player_trophy_system_mp":
    case "trophy_mp":
    case "power_exploding_drone_mp":
    case "trip_mine_mp":
    case "bomb_site_mp":
      return scripts\engine\utility::ter_op(isdefined(var_1.killcament), var_1.killcament, var_01);
    case "remote_tank_projectile_mp":
    case "jackal_turret_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "aamissile_projectile_mp":
    case "jackal_cannon_mp":
      if(isdefined(var_1.vehicle_fired_from) && isdefined(var_1.vehicle_fired_from.killcament))
        return var_1.vehicle_fired_from.killcament;
      else if(isdefined(var_1.vehicle_fired_from))
        return var_1.vehicle_fired_from;

      break;
    case "iw7_minigun_c8_mp":
    case "iw7_chargeshot_c8_mp":
    case "iw7_c8offhandshield_mp":
      if(isdefined(var_00) && isdefined(var_0.func_4BE1) && var_0.func_4BE1 == "MANUAL")
        return undefined;

      break;
    case "ball_drone_projectile_mp":
    case "ball_drone_gun_mp":
      if(isplayer(var_00) && isdefined(var_0.balldrone) && isdefined(var_0.balldrone.turret) && isdefined(var_0.balldrone.turret.killcament))
        return var_0.balldrone.turret.killcament;

      break;
    case "shockproj_mp":
      if(isdefined(var_0.func_B7AA.killcament))
        return var_0.func_B7AA.killcament;

      break;
    case "artillery_mp":
    case "none":
      if(isdefined(var_1.targetname) && var_1.targetname == "care_package" || isdefined(var_1.killcament) && (var_1.classname == "script_brushmodel" || var_1.classname == "trigger_multiple" || var_1.classname == "script_model"))
        return var_1.killcament;

      break;
    case "switch_blade_child_mp":
    case "drone_hive_projectile_mp":
      if(isdefined(var_0.extraeffectkillcam))
        return var_0.extraeffectkillcam;
      else
        return undefined;
    case "remote_turret_mp":
    case "ugv_turret_mp":
    case "remotemissile_projectile_mp":
    case "osprey_player_minigun_mp":
    case "minijackal_assault_mp":
    case "minijackal_strike_mp":
    case "venomproj_mp":
      return undefined;
  }

  if(scripts\engine\utility::isdestructibleweapon(var_02) || scripts\mp\utility\game::isbombsiteweapon(var_02)) {
    if(isdefined(var_1.killcament) && !var_00 scripts\mp\utility\game::func_24ED())
      return var_1.killcament;
    else
      return undefined;
  }

  return var_01;
}

func_F76C(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_5.func_37CC = "unknown";

  if(isdefined(var_01) && isdefined(var_1.agent_type)) {
    if(var_1.agent_type == "dog" || var_1.agent_type == "wolf") {
      setcinematiccamerastyle("killcam_dog", var_00 getentitynumber(), var_03 getentitynumber());
      var_5.func_37CC = "killcam_dog";
    } else if(var_1.agent_type == "remote_c8") {
      setcinematiccamerastyle("killcam_rc8", var_00 getentitynumber(), var_03 getentitynumber());
      var_5.func_37CC = "killcam_rc8";
    } else {
      setcinematiccamerastyle("killcam_agent", var_00 getentitynumber(), var_03 getentitynumber());
      var_5.func_37CC = "killcam_agent";
    }

    return 1;
  } else if(isdefined(var_06) && var_06 == "nuke_mp") {
    setcinematiccamerastyle("killcam_nuke", var_03 getentitynumber(), var_03 getentitynumber());
    var_5.func_37CC = "killcam_nuke";
    return 1;
  } else if(var_04 > 0) {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  } else {
    setcinematiccamerastyle("unknown", -1, -1);
    return 0;
  }

  return 0;
}

func_127CF(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = var_05 + var_06;

  if(isdefined(var_08) && var_09 > var_08) {
    if(var_08 < 2) {
      return;
    }
    if(var_08 - var_05 >= 1)
      var_06 = var_08 - var_05;
    else {
      var_06 = 1;
      var_05 = var_08 - 1;
    }

    var_09 = var_05 + var_06;
  }

  var_10 = var_05 + var_07;

  if(isdefined(var_01) && isdefined(var_1.lastspawntime))
    var_11 = var_1.lastspawntime;
  else {
    var_11 = var_2.lastspawntime;

    if(isdefined(var_2.deathtime)) {
      if(gettime() - var_2.deathtime < var_06 * 1000.0) {
        var_06 = 1.0;
        var_06 = var_06 - 0.05;
        var_09 = var_05 + var_06;
      }
    }
  }

  var_12 = (gettime() - var_11) / 1000.0;

  if(var_10 > var_12 && var_12 > var_07) {
    var_13 = var_12 - var_07;

    if(var_05 > var_13) {
      var_05 = var_13;
      var_09 = var_05 + var_06;
      var_10 = var_05 + var_07;
    }
  }

  var_14 = spawnstruct();
  var_14.func_37F1 = var_05;
  var_14.func_D6F8 = var_06;
  var_14.func_A63E = var_09;
  var_14.killcamoffset = var_10;
  return var_14;
}

func_D83E(var_00, var_01) {
  if(isdefined(var_01) && !isagent(var_01)) {
    if(isdefined(self.class)) {
      var_02 = spawnstruct();
      scripts\mp\playerlogic::getplayerassets(var_02, self.class);
      scripts\mp\playerlogic::loadplayerassets(var_02, 1);
    }

    self gettweakablelastvalue(var_01);
  }
}

killcam(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");

  if(level.showingfinalkillcam) {
    setglobalsoundcontext("atmosphere", "killcam", 0.1);

    foreach(var_18 in level.players) {
      self playlocalsound("final_killcam_in");
      self _meth_82C2("killcam", "mix");
    }
  }

  if(var_02 < 0 || !isdefined(var_12)) {
    return;
  }
  level.func_C23C++;
  var_20 = 0.05 * (level.func_C23C - 1);
  level.func_B4A7 = var_20;

  if(level.func_C23C > 1)
    wait(var_20);

  wait 0.05;
  level.func_C23C--;

  if(getdvar("scr_killcam_time") == "") {
    if(var_07 == "artillery_mp" || var_07 == "stealth_bomb_mp" || var_07 == "warhawk_mortar_mp")
      var_21 = (gettime() - var_04) / 1000 - var_08 - 0.1;
    else if(var_07 == "remote_mortar_missile_mp")
      var_21 = 6.5;
    else if(level.showingfinalkillcam)
      var_21 = 4.0 + level.func_B4A7 - var_20;
    else if(var_07 == "apache_minigun_mp")
      var_21 = 3.0;
    else if(var_07 == "javelin_mp")
      var_21 = 8;
    else if(var_07 == "iw7_niagara_mp")
      var_21 = 5.0;
    else if(issubstr(var_07, "remotemissile_"))
      var_21 = 5;
    else if(isdefined(var_0.sentrytype) && var_0.sentrytype == "multiturret")
      var_21 = 2.0;
    else if(!var_10 || var_10 > 5.0)
      var_21 = 5.0;
    else if(var_07 == "frag_grenade_mp" || var_07 == "frag_grenade_short_mp" || var_07 == "semtex_mp" || var_07 == "semtexproj_mp" || var_07 == "mortar_shell__mp" || var_07 == "cluster_grenade_mp")
      var_21 = 4.25;
    else
      var_21 = 2.5;
  } else
    var_21 = getdvarfloat("scr_killcam_time");

  if(isdefined(var_11)) {
    if(var_21 > var_11)
      var_21 = var_11;

    if(var_21 < 0.05)
      var_21 = 0.05;
  }

  if(getdvar("scr_killcam_posttime") == "") {
    if(isdefined(var_00) && var_00 == var_12)
      var_22 = 3.5;
    else
      var_22 = 2;
  } else {
    var_22 = getdvarfloat("scr_killcam_posttime");

    if(var_22 < 0.05)
      var_22 = 0.05;
  }

  if(var_02 < 0 || !isdefined(var_12)) {
    return;
  }
  var_23 = func_127CF(var_00, var_01, var_12, var_13, var_03, var_21, var_22, var_08, var_11);

  if(!isdefined(var_23)) {
    return;
  }
  self setclientomnvar("ui_killcam_end_milliseconds", 0);

  if(level.showingfinalkillcam)
    self setclientomnvar("post_game_state", 3);

  if(isplayer(var_12)) {
    self setclientomnvar("ui_killcam_killedby_id", var_12 getentitynumber());
    self setclientomnvar("ui_killcam_victim_id", var_13 getentitynumber());
    self gettweakablelastvalue(var_12);
  }

  if(scripts\mp\utility\game::iskillstreakweapon(var_07))
    func_F76E(var_07, var_16);
  else
    scripts\mp\perks::func_F7C5("ui_killcam_killedby_perk", var_15);

  var_24 = getdvarint("scr_player_forcerespawn");

  if(var_10 && !level.gameended || isdefined(self) && isdefined(self.battlebuddy) && !level.gameended || var_24 == 0 && !level.gameended)
    self setclientomnvar("ui_killcam_text", "skip");
  else if(!level.gameended)
    self setclientomnvar("ui_killcam_text", "respawn");
  else
    self setclientomnvar("ui_killcam_text", "none");

  var_25 = gettime();
  self notify("begin_killcam", var_25);
  scripts\mp\utility\game::updatesessionstate("spectator");
  self.spectatekillcam = 1;

  if(isagent(var_12) || isagent(var_00)) {
    var_02 = var_13 getentitynumber();
    var_09 = var_09 - 25;
  }

  self.forcespectatorclient = var_02;
  self.killcamentity = -1;
  var_26 = func_F76C(var_00, var_01, var_02, var_13, var_03, var_23, var_07);

  if(!var_26)
    thread func_F76B(var_03, var_23.killcamoffset, var_04, var_05, var_06);

  self.archivetime = var_23.killcamoffset;
  self.func_A63E = var_23.func_A63E;
  self.psoffsettime = var_09;
  self allowspectateteam("allies", 1);
  self allowspectateteam("axis", 1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);

  if(level.multiteambased) {
    foreach(var_28 in level.teamnamelist)
    self allowspectateteam(var_28, 1);
  }

  thread func_6315();
  wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  if(self.archivetime < var_23.killcamoffset) {
    var_30 = var_23.killcamoffset - self.archivetime;

    if(game["truncated_killcams"] < 32)
      game["truncated_killcams"]++;
  }

  var_23.func_37F1 = self.archivetime - 0.05 - var_08;
  var_23.func_A63E = var_23.func_37F1 + var_23.func_D6F8;
  self.func_A63E = var_23.func_A63E;

  if(var_23.func_37F1 <= 0) {
    scripts\mp\utility\game::updatesessionstate("dead");
    scripts\mp\utility\game::clearkillcamstate();
    self notify("killcam_ended");
    return;
  }

  var_31 = level.showingfinalkillcam;
  self setclientomnvar("ui_killcam_end_milliseconds", int(var_23.func_A63E * 1000) + gettime());

  if(var_31)
    self setclientomnvar("ui_killcam_victim_or_attacker", 1);

  if(var_31)
    thread scripts\mp\finalkillcam::func_5854(var_23, self.killcamentity, var_12, var_13, var_14);

  self.killcam = 1;

  if(isdefined(self.battlebuddy) && !level.gameended)
    self.func_28CD = gettime();

  thread func_10855();

  if(!level.showingfinalkillcam)
    thread func_13715(var_10);
  else
    self notify("showing_final_killcam");

  thread func_635D();
  waittillkillcamover();

  if(level.showingfinalkillcam) {
    thread scripts\mp\playerlogic::spawnendofgame();
    return;
  }

  thread func_A639(1);
}

func_F770(var_00, var_01, var_02) {
  var_03 = getweaponbasename(var_00);

  if(!isdefined(var_03) || var_03 == "none")
    clearkillcamattachmentomnvars();
  else {
    var_04 = scripts\mp\utility\game::getequipmenttype(var_03);

    if(isdefined(scripts\mp\supers::func_7F0D(var_03)))
      func_F772(var_03);
    else if(isdefined(var_04) && (var_04 == "lethal" || var_04 == "tactical"))
      func_F771(var_03);
    else {
      if(isdefined(level.killcammiscitems[var_03])) {
        func_F76F(level.killcammiscitems[var_03]);
        return;
      }

      func_F773(var_00, var_02);
    }
  }
}

waittillkillcamover() {
  self endon("abort_killcam");

  if(level.showingfinalkillcam)
    thread scripts\mp\utility\game::func_F8A0(1.0, self.func_A63E - 0.5);

  wait(self.func_A63E - 0.05);

  if(level.showingfinalkillcam) {
    setglobalsoundcontext("atmosphere", "", 0.5);
    self playlocalsound("final_killcam_out");
    self clearclienttriggeraudiozone(4);
  }
}

func_F76B(var_00, var_01, var_02, var_03, var_04) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_05 = gettime() - var_01 * 1000;

  if(var_02 > var_05) {
    wait 0.05;
    var_01 = self.archivetime;
    var_05 = gettime() - var_01 * 1000;

    if(var_02 > var_05)
      wait((var_02 - var_05) / 1000);
  }

  self.killcamentity = var_00;

  if(isdefined(var_03))
    self.killcamentitylookat = var_03;

  if(isdefined(var_04))
    self _meth_85C4(var_04);
}

func_13715(var_00) {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");

    if(scripts\mp\killstreaks\orbital_deployment::func_D39C("orbital_deployment"))
      thread func_1CA0(var_00);

    self waittill("kc_respawn");
    self.cancelkillcam = 1;

    if(var_00 <= 0)
      scripts\mp\utility\game::clearlowermessage("kc_info");

    self notify("abort_killcam");
  }
}

func_1CA0(var_00) {
  self notifyonplayercommand("orbital_deployment_action", "+attack");
  self notifyonplayercommand("orbital_deployment_action", "+attack_akimbo_accessible");
  self setclientomnvar("ui_orbital_deployment_killcam_text", 1);
  var_01 = scripts\engine\utility::waittill_any_return("orbital_deployment_action", "spawned_player");

  if(var_01 == "spawned_player") {
    self setclientomnvar("ui_orbital_deployment_killcam_text", 0);
    return;
  }

  self.cancelkillcam = 1;

  if(var_00 <= 0)
    scripts\mp\utility\game::clearlowermessage("kc_info");

  self notify("abort_killcam");
  self waittill("spawned_player");
  self setclientomnvar("ui_orbital_deployment_killcam_text", 0);
  var_02 = scripts\mp\killstreaks\killstreaks::missile_settargetpos("orbital_deployment");

  if(isdefined(var_02)) {
    var_03 = scripts\mp\killstreaks\killstreaks::func_7F45(var_02);
    var_3.func_98F2 = 1;
    scripts\mp\killstreaks\killstreaks::func_A69A(var_03);
  }
}

func_635D() {
  self endon("disconnect");
  self endon("killcam_ended");

  for (;;) {
    if(self.archivetime <= 0) {
      break;
    }
    wait 0.05;
  }

  self notify("abort_killcam");
}

func_10855() {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  thread func_A639(0);
}

func_6315() {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  thread func_A639(1);
}

clearkillcamomnvars() {
  clearkillcamkilledbyitemomnvars();
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_id", -1);
  self setclientomnvar("ui_killcam_victim_id", -1);
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  clearkillcamattachmentomnvars();

  for (var_00 = 0; var_00 < 6; var_0++)
    self setclientomnvar("ui_killcam_killedby_perk" + var_00, -1);
}

func_A639(var_00) {
  clearkillcamomnvars();

  if(level.showingfinalkillcam)
    setomnvarforallclients("post_game_state", 1);

  self.killcam = undefined;
  var_01 = level.showingfinalkillcam;

  if(!var_01)
    setcinematiccamerastyle("unknown", -1, -1);

  if(!level.gameended)
    scripts\mp\utility\game::clearlowermessage("kc_info");

  thread scripts\mp\spectating::setspectatepermissions();
  self notify("killcam_ended");

  if(!var_00) {
    return;
  }
  scripts\mp\utility\game::updatesessionstate("dead");
  scripts\mp\utility\game::clearkillcamstate();
}

clearlootweaponomnvars() {
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
}

clearkillcamkilledbyitemomnvars() {
  self setclientomnvar("ui_killcam_killedby_item_type", -1);
  self setclientomnvar("ui_killcam_killedby_item_id", -1);
}

setkillcamkilledbyitemomnvars(var_00, var_01) {
  self setclientomnvar("ui_killcam_killedby_item_type", var_00);
  self setclientomnvar("ui_killcam_killedby_item_id", var_01);
}

func_F773(var_00, var_01) {
  var_00 = scripts\mp\utility\game::func_13CA1(var_00, var_01);
  var_02 = scripts\mp\utility\game::getweaponrootname(var_00);
  var_03 = tablelookuprownum("mp\statsTable.csv", 4, var_02);

  if(!isdefined(var_03) || var_03 < 0) {
    setkillcamkilledbyitemomnvars(-1, -1);
    return;
  }

  var_04 = scripts\mp\loot::getlootinfoforweapon(var_00);

  if(isdefined(var_04)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_4.variantid);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_4.quality - 1);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  }

  self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify", gettime());
  setkillcamkilledbyitemomnvars(0, var_03);

  if(var_02 != "iw7_knife") {
    var_05 = getweaponattachments(var_00);

    if(!isdefined(var_05))
      var_05 = [];

    var_06 = 0;

    for (var_07 = 0; var_07 < var_5.size; var_7++) {
      var_08 = var_5[var_07];
      var_09 = scripts\mp\utility\game::attachmentmap_tobase(var_08);

      if(scripts\mp\weapons::func_9F3C(var_02, var_09)) {
        if(var_06 >= 6) {
          break;
        }
        var_10 = tablelookuprownum("mp\attachmentTable.csv", 4, var_08);
        self setclientomnvar("ui_killcam_killedby_attachment" + (var_06 + 1), var_10);
        var_6++;
      }
    }

    for (var_07 = var_06; var_07 < 6; var_7++)
      self setclientomnvar("ui_killcam_killedby_attachment" + (var_07 + 1), -1);
  }
}

func_F772(var_00) {
  var_01 = scripts\mp\supers::func_7F0D(var_00);
  setkillcamkilledbyitemomnvars(2, var_01);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

func_F76E(var_00, var_01) {
  var_02 = scripts\mp\utility\game::getkillstreakindex(level.killstreakweildweapons[var_00]);

  if(isdefined(var_01)) {
    var_02 = var_1.id;
    var_03 = var_1.rarity;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_02);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_03 - 1);
  } else {
    setkillcamkilledbyitemomnvars(1, var_02);
    clearlootweaponomnvars();
  }

  clearkillcamattachmentomnvars();
}

func_F771(var_00) {
  var_01 = level.func_D7A4[var_00];
  var_02 = level.powers[var_01].id;
  setkillcamkilledbyitemomnvars(3, var_02);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

func_F76F(var_00) {
  setkillcamkilledbyitemomnvars(4, var_00);
  clearlootweaponomnvars();
  clearkillcamattachmentomnvars();
}

clearkillcamattachmentomnvars() {
  for (var_00 = 0; var_00 < 6; var_0++)
    self setclientomnvar("ui_killcam_killedby_attachment" + (var_00 + 1), -1);
}