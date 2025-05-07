/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2771.gsc
***************************************/

init() {
  if(!func_B4E8()) {
    return;
  }
  level.func_B8CD = [];
  func_DEFF("playerDamaged", ::func_3BF5);
  func_DEFF("playerKilled", ::func_3BFE);
  func_DEFF("playerKilled", ::func_3C01);
  func_DEFF("playerUsedKillstreak", ::func_3C02);
  func_DEFF("playerKillstreakActive", ::func_3C00);
  func_DEFF("playerAssist", ::func_3BF3);
  func_DEFF("roundEnd", ::func_3C04);
  func_DEFF("roundEnd", ::func_3C03);
  func_DEFF("vehicleKilled", ::func_3C09);
  level thread onplayerconnect();
  level thread onroundended();
}

onroundended() {
  level waittill("game_ended");

  foreach(var_01 in level.players) {
    var_1.pers["killstreaksKilledByWeapon"] = var_1.func_A6B3;
    var_1.pers["killsPerWeapon"] = var_1.killsperweapon;
    var_1.pers["shotsLandedLMG"] = var_1.shotslandedlmg;
    var_1.pers["classicKills"] = var_1.classickills;
    var_1.pers["akimboKills"] = var_1.akimbokills;
    var_1.pers["hipfireMagKills"] = var_1.hipfiremagkills;
    var_1.pers["burstFireKills"] = var_1.burstfirekills;
  }
}

getweaponweight(var_00) {
  for (var_01 = 0; var_01 < 3; var_1++) {
    var_02 = self getrankedplayerdata("mp", "weeklyChallengeId", var_01);
    var_03 = tablelookupbyrow("mp\weeklyChallengesTable.csv", var_02, 0);

    if(var_03 == var_00)
      return "ch_weekly_" + var_01;
  }

  return "";
}

func_7E57(var_00) {
  for (var_01 = 0; var_01 < 3; var_1++) {
    var_02 = self getrankedplayerdata("mp", "dailyChallengeId", var_01);
    var_03 = tablelookupbyrow("mp\dailyChallengesTable.csv", var_02, 0);

    if(var_03 == var_00)
      return "ch_daily_" + var_01;
  }

  return "";
}

func_3BF8(var_00) {
  if(!isenumvaluevalid("mp", "Challenge", var_00))
    return 0;

  if(level.func_3C2C[var_00]["type"] == 0)
    return self getrankedplayerdata("mp", "challengeProgress", var_00);
  else if(level.func_3C2C[var_00]["type"] == 1)
    return self getrankedplayerdata("mp", "challengeProgress", func_7E57(var_00));
  else if(level.func_3C2C[var_00]["type"] == 2)
    return self getrankedplayerdata("mp", "challengeProgress", getweaponweight(var_00));
}

func_3BF9(var_00) {
  if(!isenumvaluevalid("mp", "Challenge", var_00))
    return 0;

  if(level.func_3C2C[var_00]["type"] == 0)
    return self getrankedplayerdata("mp", "challengeState", var_00);
  else if(level.func_3C2C[var_00]["type"] == 1)
    return self getrankedplayerdata("mp", "challengeState", func_7E57(var_00));
  else if(level.func_3C2C[var_00]["type"] == 2)
    return self getrankedplayerdata("mp", "challengeState", getweaponweight(var_00));
}

func_3C05(var_00, var_01) {
  if(level.func_3C2C[var_00]["type"] == 0)
    return self setrankedplayerdata("mp", "challengeProgress", var_00, var_01);
  else if(level.func_3C2C[var_00]["type"] == 1)
    return self setrankedplayerdata("mp", "challengeProgress", func_7E57(var_00), var_01);
  else if(level.func_3C2C[var_00]["type"] == 2)
    return self setrankedplayerdata("mp", "challengeProgress", getweaponweight(var_00), var_01);
}

func_3C06(var_00, var_01) {
  if(level.func_3C2C[var_00]["type"] == 0)
    return self setrankedplayerdata("mp", "challengeState", var_00, var_01);
  else if(level.func_3C2C[var_00]["type"] == 1)
    return self setrankedplayerdata("mp", "challengeState", func_7E57(var_00), var_01);
  else if(level.func_3C2C[var_00]["type"] == 2)
    return self setrankedplayerdata("mp", "challengeState", getweaponweight(var_00), var_01);
}

func_3BFA(var_00, var_01) {
  if(level.func_3C2C[var_00]["type"] == 0)
    return func_B029(var_00, var_01);
  else if(level.func_3C2C[var_00]["type"] == 1)
    return int(tablelookup("mp\dailyChallengesTable.csv", 0, var_00, 9 + var_01 * 3));
  else if(level.func_3C2C[var_00]["type"] == 2)
    return int(tablelookup("mp\weeklyChallengesTable.csv", 0, var_00, 9 + var_01 * 3));
}

showchallengesplash(var_00, var_01) {
  var_02 = undefined;
  var_02 = func_3BF9(var_00) - 1;
  var_03 = level.func_3C2C[var_00]["displayParam"];

  if(!isdefined(var_03)) {
    var_03 = func_3BFA(var_00, var_02);

    if(var_03 == 0)
      var_03 = 1;

    var_04 = level.func_3C2C[var_00]["paramScale"];

    if(isdefined(var_04))
      var_03 = int(var_03 / var_04);
  }

  var_05 = undefined;

  if(scripts\mp\utility\game::istrue(var_01))
    var_05 = int(min(var_02, scripts\mp\hud_message::getsplashtablemaxaltdisplays()));
  else {
    var_06 = func_2139(var_00);

    if(scripts\mp\utility\game::istrue(var_06))
      var_05 = 1;
  }

  thread scripts\mp\hud_message::showsplash(var_00, var_03, undefined, var_05);
}

func_B4E8() {
  return level.rankedmatch;
}

func_D3D6() {
  if(!func_B4E8())
    return 0;

  if(level.players.size < 2)
    return 0;

  if(!scripts\mp\utility\game::rankingenabled())
    return 0;

  if(!isplayer(self) || isai(self))
    return 0;

  return 1;
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_00);
    var_0.func_A6B3 = var_0.pers["killstreaksKilledByWeapon"];
    var_00 thread func_989E();

    if(isai(var_00)) {
      continue;
    }
    var_00 thread onplayerspawned();
    var_00 thread func_BA2A();
    var_00 thread func_B9C0();
    var_00 thread func_B9ED();
    var_00 thread func_BA24();
    var_00 thread func_B9BF();
    var_00 thread func_BA08();
    var_00 thread func_B9E9();
    var_00 thread func_B9E6();
    var_00 thread func_BA3B();
    var_00 thread func_B9DA();
    var_00 thread func_BA29();
    var_00 thread func_BA1F();
    var_00 thread func_B9CE();
    var_00 thread func_B9BA();
    var_00 thread func_B9DF();
    var_00 thread awardpostshipadjustedtargets();
    var_00 notifyonplayercommand("hold_breath", "+breath_sprint");
    var_00 notifyonplayercommand("hold_breath", "+melee_breath");
    var_00 notifyonplayercommand("release_breath", "-breath_sprint");
    var_00 notifyonplayercommand("release_breath", "-melee_breath");
    var_00 thread func_B9E0();
    var_00 notifyonplayercommand("jumped", "+goStand");
    var_00 thread func_B9F0();

    if(isdefined(level.func_C978) && issubstr(var_0.name, level.func_C978)) {
      var_00 setrankedplayerdata("mp", "challengeState", "ch_infected", 2);
      var_00 setrankedplayerdata("mp", "challengeProgress", "ch_infected", 1);
      var_00 setrankedplayerdata("mp", "challengeState", "ch_plague", 2);
      var_00 setrankedplayerdata("mp", "challengeProgress", "ch_plague", 1);
    }

    var_00 setrankedplayerdata("common", "round", "weaponsUsed", 0, "none");
    var_00 setrankedplayerdata("common", "round", "weaponsUsed", 1, "none");
    var_00 setrankedplayerdata("common", "round", "weaponsUsed", 2, "none");
    var_00 setrankedplayerdata("common", "round", "weaponXpEarned", 0, 0);
    var_00 setrankedplayerdata("common", "round", "weaponXpEarned", 1, 0);
    var_00 setrankedplayerdata("common", "round", "weaponXpEarned", 2, 0);

    if(randomint(1001) == 1)
      var_00 setrankedplayerdata("mp", "plagued", 1);

    if(var_00 func_3BF9("ch_solar_rig") == 1)
      var_00 thread monitorblackskykills();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for (;;) {
    self waittill("spawned_player");
    self.func_A686 = [];
    self.func_110E5 = 0;
    self.func_D99C = 0;
    self.func_6A06 = [];
    self.func_69F2 = 0;
    self.func_1119A = [];
    self.func_110E6 = [];
    self.sixthsensesource = [];
    self.relaysource = [];
    self.func_13CB9 = [];
    thread func_BA1E();
    thread func_B9B4();
    thread func_BA33();
    thread func_B9D5();
    thread func_BA07();
    thread func_BA0B();
    thread monitoradstime();
    thread func_BA12();
    thread func_B9D4();
    thread func_B9EF();
  }
}

monitorblackskykills() {
  self endon("disconnect");

  for (;;) {
    self waittill("kill_event_buffered", var_00, var_01);

    if(!scripts\mp\utility\game::iskillstreakweapon(var_01)) {
      if(!isdefined(self.pers[self.loadoutarchetype + "_kills"])) {
        self.pers[self.loadoutarchetype + "_kills"] = 1;
        continue;
      }

      self.pers[self.loadoutarchetype + "_kills"]++;

      if(isdefined(self.pers["archetype_assault_kills"]) && self.pers["archetype_assault_kills"] >= 5 && isdefined(self.pers["archetype_heavy_kills"]) && self.pers["archetype_heavy_kills"] >= 5 && isdefined(self.pers["archetype_scout_kills"]) && self.pers["archetype_scout_kills"] >= 5 && isdefined(self.pers["archetype_assassin_kills"]) && self.pers["archetype_assassin_kills"] >= 5 && isdefined(self.pers["archetype_engineer_kills"]) && self.pers["archetype_engineer_kills"] >= 5 && isdefined(self.pers["archetype_sniper_kills"]) && self.pers["archetype_sniper_kills"] >= 5)
        func_D991("ch_uber_camo_rig");
    }
  }
}

monitorweaponpickup(var_00) {
  if(scripts\mp\utility\game::ispickedupweapon(var_00)) {
    if(isdefined(self.func_13CB9) && !isdefined(self.func_13CB9[var_00]))
      self.func_13CB9[var_00] = gettime();
  }
}

awardpostshipadjustedtargets() {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 20.0;
  checkpostshipadjustedchallenge("ch_heavy_ground_pound_kills");
  checkpostshipadjustedchallenge("ch_sniper_ballista_collateral");
  checkpostshipadjustedchallenge("ch_dd_wins");
  checkpostshipadjustedchallenge("ch_siege_wins");
  checkpostshipadjustedchallenge("ch_clutch_revives");
  checkpostshipadjustedchallenge("ch_perk_kills_tacresist");
  var_00 = self getrankedplayerdata("mp", "postShipFlags", 1);

  if(var_00 == 0) {
    runonce_checkpostshiprigprogress();
    self setrankedplayerdata("mp", "postShipFlags", 1, 1);
  }
}

checkpostshipadjustedchallenge(var_00) {
  var_01 = func_7E22(var_00);
  var_02 = func_3BF8(var_00);
  var_03 = level.func_3C2C[var_00]["targetval"].size - 1;

  if(var_01 > var_03) {
    return;
  }
  for (var_04 = level.func_3C2C[var_00]["targetval"][var_01]; var_02 >= var_04; var_04 = level.func_3C2C[var_00]["targetval"][var_01]) {
    func_D991(var_00);
    var_01 = func_7E22(var_00);

    if(var_01 > var_03) {
      break;
    }
  }
}

awardpostshipchallenge(var_00) {
  var_01 = func_7E22(var_00);
  var_02 = level.func_3C2C[var_00]["targetval"].size - 1;

  if(var_01 > var_02) {
    return;
  }
  var_03 = level.func_3C2C[var_00]["targetval"][var_02];

  for (var_04 = level.func_3C2C[var_00]["targetval"][var_01]; var_03 >= var_04; var_04 = level.func_3C2C[var_00]["targetval"][var_01]) {
    func_D991(var_00);
    var_01 = func_7E22(var_00);

    if(var_01 > var_02) {
      break;
    }
  }
}

runonce_checkpostshiprigprogress() {
  var_00 = ["ch_gold_rig_assault_body", "ch_gold_rig_assault_head", "ch_gold_rig_heavy_body", "ch_gold_rig_heavy_head", "ch_gold_rig_scout_body", "ch_gold_rig_scout_head", "ch_gold_rig_assassin_body", "ch_gold_rig_assassin_head", "ch_gold_rig_engineer_body", "ch_gold_rig_engineer_head", "ch_gold_rig_sniper_body", "ch_gold_rig_sniper_head", "ch_diamond_rig_assault", "ch_diamond_rig_heavy", "ch_diamond_rig_scout", "ch_diamond_rig_assassin", "ch_diamond_rig_engineer", "ch_diamond_rig_sniper", "ch_solar_rig"];

  foreach(var_02 in var_00) {
    var_03 = func_3BF9(var_02);

    if(var_03 > 0) {
      thread giverankxpafterwait(var_02, var_03);
      scripts\mp\matchdata::func_AF99(var_02, var_03);
      func_110AE(var_02);
      setturretfov(level.func_3C2C[var_02]["score"][var_03]);
      thread showchallengesplash(var_02);
    }
  }
}

func_BA12() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_00 = 0;

  for (;;) {
    self waittill("scavenger_pickup");
    func_D991("ch_perk_scavenger");

    if(!var_00) {
      var_01 = 0;
      var_02 = 0;
      var_03 = self getweaponslistprimaries();

      foreach(var_05 in var_03) {
        if(!scripts\mp\utility\game::iscacprimaryweapon(var_05) && !scripts\mp\weapons::func_9F54(var_05)) {
          continue;
        }
        var_2++;

        if(self getfractionmaxammo(var_05) < 1.0) {
          break;
        }
        var_1++;
      }

      if(var_02 > 0 && var_01 == var_02) {
        func_D991("ch_scavenger_full_ammo");
        var_00 = 1;
      }
    }
  }
}

func_10DC7() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  thread func_B9E8();
  wait 5.0;
  self notify("stopMonitorKillsAfterAbilityActive");
}

func_B9E8() {
  self endon("stopMonitorKillsAfterAbilityActive");
  self endon("remove_super");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_00 = undefined;

  if(isdefined(scripts\mp\supers::getcurrentsuper()))
    var_00 = scripts\mp\supers::getcurrentsuperref();
  else
    return;

  for (;;) {
    self waittill("kill_event_buffered", var_01, var_02, var_03, var_04);

    switch (var_00) {
      case "super_rewind":
        func_D991("ch_ability_rewind");
        break;
      case "super_teleport":
        func_D991("ch_ability_teleport");
        break;
      case "super_phaseshift":
        func_D991("ch_ability_phase_shift");
        break;
    }
  }
}

func_D98A(var_00) {
  if(var_0.func_250D) {
    switch (var_0.func_24E8) {
      default:
        break;
      case "super_amplify":
        func_D991("ch_ability_amplify");
        break;
      case "super_overdrive":
        func_D991("ch_ability_overdrive");
        break;
      case "super_chargemode":
        func_D991("ch_ability_bull_charge");
        break;
      case "super_armorup":
        func_D991("ch_ability_reactive_armor");
        break;
      case "super_reaper":
        func_D991("ch_ability_reaper");
        break;
    }
  }

  if(scripts\mp\utility\game::istrue(var_0.attackervisionpulsedvictim))
    func_D991("ch_ability_pulsar");

  if(scripts\mp\utility\game::istrue(var_0.attackerhassupertrophyout))
    func_D991("ch_ability_centurion");

  if(isdefined(var_0.sweapon) && var_0.sweapon == "micro_turret_gun_mp")
    func_D991("ch_ability_micro_turret");

  if(isdefined(var_0.modifiers) && isdefined(self.modifiers["super_kill_medal"]) && self.modifiers["super_kill_medal"] == "super_invisible")
    func_D991("ch_ability_active_camo");
}

func_B9C2() {
  self endon("bounceKillCancel");
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("bounceKillVerify");
    func_D991("ch_darkops_bounce");
  }
}

func_BA36() {
  self endon("tripleStopCancel");
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("tripleStopVerify");

    if(self.func_127D0 == 3) {
      func_D991("ch_darkops_slidestop");
      self.func_127D0 = undefined;
      break;
    }
  }
}

func_D998(var_00, var_01, var_02) {
  if(var_0.team != self.team && (var_01 == "drone_hive_projectile_mp" || var_01 == "switch_blade_child_mp")) {
    var_03 = 0;
    var_04 = 0;

    foreach(var_06 in level.players) {
      if(!isdefined(var_6.team)) {
        continue;
      }
      if(!scripts\mp\utility\game::isreallyalive(var_06)) {
        continue;
      }
      if(var_6.team == self.team) {
        var_07 = scripts\mp\domeshield::func_7E80(var_06);

        if(!isdefined(var_07)) {
          continue;
        }
        var_08 = var_7.func_58EF;

        if(!isdefined(var_08)) {
          continue;
        }
        if(var_08 == var_02) {
          if(var_06 == self) {
            var_04 = 1;
            continue;
          }

          var_3++;
        }
      }
    }

    if(var_04 && var_03 > 1)
      func_D991("ch_darkops_chrome");
  }
}

func_D997(var_00) {
  func_D9AF(var_00);
}

func_D996(var_00) {
  if(isdefined(var_0.func_94B7)) {
    if(var_0.func_94B7)
      func_D991("ch_darkops_howthe");
  }

  if(scripts\engine\utility::isbulletdamage(var_0.smeansofdeath) && var_0.func_24E3 == 0 && !scripts\mp\utility\game::iskillstreakweapon(var_0.sweapon)) {
    if(isdefined(self.func_127D0)) {
      self.func_127D0++;
      self notify("tripleStopVerify");
    } else {
      self.func_127D0 = 1;
      thread func_BA36();
    }
  } else {
    self.func_127D0 = undefined;
    self notify("tripleStopCancel");
  }

  if(isdefined(var_0.modifiers["headshot"]) && var_0.func_92BE & level.idflags_no_team_protection) {
    if(isdefined(self.func_2F04))
      self notify("bounceKillVerify");
    else {
      thread func_B9C2();
      self.func_2F04 = 1;
    }
  } else {
    self notify("bounceKillCancel");
    self.func_2F04 = undefined;
  }

  if(isdefined(var_0.func_1337C) && isdefined(var_0.func_1337A) && isdefined(var_0.func_250D) && isdefined(var_0.func_24E8)) {
    if(var_0.func_1337C && var_0.func_250D && var_0.func_1337A == "super_phaseshift" && var_0.func_24E8 == "super_phaseshift")
      func_D991("ch_darkops_phase");
  }

  if(isdefined(var_0.sweapon)) {
    var_01 = scripts\mp\utility\game::getweaponrootname(var_0.sweapon);

    if(var_01 == "iw7_revolver" && scripts\mp\utility\game::weaponhasattachment(var_0.sweapon, "akimbo") && scripts\mp\utility\game::weaponhasattachment(var_0.sweapon, "fastaim") && scripts\mp\weapons::func_13C98(var_0.sweapon))
      func_D991("ch_darkops_no_idea");
  }
}

processrigkillchallengesonkill_delayed(var_00) {
  var_0.attacker func_D991("ch_" + var_0.attackerarchetype + "_kills");

  if(isdefined(var_0.attackerkillsthislife) && func_9EBC(var_0.attackerkillsthislife, 3))
    var_0.attacker func_D991("ch_" + var_0.attackerarchetype + "_3streak");

  if(isdefined(var_0.func_2504)) {
    if(func_9EBC(var_0.func_2504, 2)) {
      var_0.attacker func_D991("ch_" + var_0.attackerarchetype + "_2multikill");

      if(isdefined(var_0.func_2506) && var_0.func_2506 == "specialty_boom")
        var_0.attacker func_D991("ch_assault_ping_2multi");
    }
  }

  if(isdefined(var_0.func_2506) && var_0.func_2506 == "specialty_scavenger_eqp") {
    var_01 = scripts\mp\utility\game::getequipmenttype(var_0.sweapon);

    if(isdefined(var_01) && var_01 == "lethal")
      var_0.attacker func_D991("ch_assault_resupply_lethal_kills");
  }

  if(isdefined(var_0.func_2506) && var_0.func_2506 == "specialty_rugged_eqp") {
    if(scripts\mp\utility\game::istrue(var_0.wasplantedmine))
      var_0.attacker func_D991("ch_engineer_hardened_kill");
  }

  if(isdefined(var_0.sweapon) && var_0.sweapon == "iw7_reaperblade_mp" && isdefined(var_0.func_24F3[var_0.sweapon]) && func_9EBC(var_0.func_24F3[var_0.sweapon], 4))
    var_0.attacker func_D991("ch_scout_reaper_4multi");

  if(isdefined(var_0.func_2506) && var_0.func_2506 == "specialty_ftlslide" && var_0.func_24EF && scripts\mp\utility\game::istrue(var_0.modifiers["slidekill"]))
    var_0.attacker func_D991("ch_assassin_ads_slide_kill");

  if(isdefined(var_0.attackersixthsensesource) && scripts\mp\utility\game::istrue(var_0.attackersixthsensesource[var_0.victimid]))
    var_0.attacker func_D991("ch_assassin_perception_revenge");

  if(isdefined(var_0.attackerrelaysource) && scripts\mp\utility\game::istrue(var_0.attackerrelaysource[var_0.victimid]))
    var_0.attacker func_D991("ch_engineer_relay_kill");

  if(isdefined(var_0.func_2506) && var_0.func_2506 == "specialty_rearguard") {
    if(isdefined(var_0.attackerrearguardattackers) && isdefined(var_0.attackerrearguardattackers[var_0.victimid]))
      var_0.attacker func_D991("ch_sniper_rearguard_kill");
  }
}

func_D9A8(var_00) {
  if(!isdefined(var_0.modifiers["superShutdown"])) {
    return;
  }
  switch (var_0.modifiers["superShutdown"]) {
    case "super_claw":
      func_D991("ch_killjoy_assault_weapon");
      break;
    case "super_steeldragon":
      func_D991("ch_killjoy_armor_weapon");
      break;
    case "super_armmgs":
      func_D991("ch_killjoy_synaptic_weapon");
      break;
    case "super_atomizer":
      func_D991("ch_killjoy_ftl_weapon");
      break;
    case "super_blackholegun":
      func_D991("ch_killjoy_six_weapon");
      break;
    case "super_penetrationrailgun":
      func_D991("ch_killjoy_ghost_weapon");
      break;
    case "super_overdrive":
    case "super_amplify":
      func_D991("ch_killjoy_assault_ability");
      break;
    case "super_armorup":
    case "super_chargemode":
      func_D991("ch_killjoy_armor_ability");
      break;
    case "super_reaper":
    case "super_rewind":
      func_D991("ch_killjoy_synaptic_ability");
      break;
    case "super_phaseshift":
    case "super_teleport":
      func_D991("ch_killjoy_ftl_ability");
      break;
    case "super_visionpulse":
    case "super_invisible":
      func_D991("ch_killjoy_ghost_ability");
      break;
  }
}

func_D995() {
  if(self iswallrunning())
    func_D991("ch_darkops_epic_run");
  else if(self issprintsliding())
    func_D991("ch_darkops_epic_slide");
}

func_D9B1(var_00) {
  if(var_00 getrankedplayerdata("mp", "plagued")) {
    self setrankedplayerdata("mp", "plagued", 1);
    func_D991("ch_darkops_plague");
  }
}

func_D9BE(var_00) {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  if(isdefined(var_0.guid))
    self endon("killedPlayer" + var_0.guid);

  wait 60.0;
  func_D991("ch_darkops_warchief");
}

func_D9AF(var_00) {
  foreach(var_02 in level.players) {
    if(!isdefined(var_2.team)) {
      continue;
    }
    if(var_2.team != var_0.team) {
      if(!isdefined(var_2.func_114ED))
        var_2.func_114ED = [];

      var_2.func_114ED[var_0.guid] = [];
    }
  }
}

func_D9B7(var_00, var_01, var_02) {
  if(!isdefined(self.func_114ED))
    self.func_114ED = [];

  if(self.team == var_0.team) {
    return;
  }
  if(var_0.health - var_02 > 0) {
    if(!isdefined(self.func_114ED[var_0.guid]))
      self.func_114ED[var_0.guid] = [];

    var_03 = getweaponbasename(var_01);

    if(!isdefined(self.func_114ED[var_0.guid][var_03])) {
      self.func_114ED[var_0.guid][var_03] = 1;

      if(self.func_114ED[var_0.guid].size == 4)
        func_D991("ch_darkops_chimp");
    }
  }
}

func_D9BB(var_00) {
  if(!isdefined(var_0.func_2506)) {
    return;
  }
  switch (var_0.func_2506) {
    default:
      break;
    case "specialty_man_at_arms":
      func_D991("ch_trait_man_at_arms");
      break;
    case "specialty_rush":
      func_D991("ch_trait_momentum");
      break;
    case "specialty_afterburner":
      func_D991("ch_trait_rushdown");
      break;
    case "specialty_rearguard":
      func_D991("ch_trait_perch");
      break;
  }

  if(isdefined(var_0.sweapon)) {
    if(var_0.sweapon == "groundpound_mp")
      func_D991("ch_heavy_ground_pound_kills");

    if(var_0.sweapon == "thruster_mp")
      func_D991("ch_scout_afterburner_kill");
  }
}

monitorsuperscoreearned() {
  self endon("disconnect");
  self endon("super_use_finished");
  self endon("death");
  level endon("game_ended");
  self notify("monitorSuperScoreEarned");
  self endon("monitorSuperScoreEarned");

  if(level.gametype == "dm")
    var_00 = self.pers["gamemodeScore"] + 500;
  else
    var_00 = self.score + 500;

  var_01 = 0;

  for (;;) {
    if(level.gametype == "dm")
      var_02 = self.pers["gamemodeScore"];
    else
      var_02 = self.score;

    if(var_02 >= var_00) {
      var_00 = var_00 + 500;
      func_D991("ch_assault_amplify_score");
    }

    scripts\engine\utility::waitframe();
  }
}

func_BA2B() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSuperWeaponKills");
  self endon("monitorSuperWeaponKills");

  for (;;) {
    self waittill("super_weapon_kill", var_00);
    var_01 = int(self.func_112A8 / 3);
    self.func_112A8 = self.func_112A8 % 3;

    while (var_01 > 0) {
      var_1--;
      var_00 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);

      switch (var_00) {
        case "iw7_claw_mp":
          func_D991("ch_super_streak_assault");
          break;
        case "iw7_steeldragon_mp":
          func_D991("ch_super_streak_armor");
          break;
        case "iw7_armmgs_mp":
          func_D991("ch_super_streak_synaptic");
          break;
        case "iw7_atomizer_mp":
          func_D991("ch_super_streak_ftl");
          break;
        case "iw7_blackholegun_mp":
          func_D991("ch_super_streak_six");
          break;
        case "iw7_penetrationrail_mp":
          func_D991("ch_super_streak_ghost");
          break;
      }
    }
  }
}

updatesuperkills(var_00, var_01, var_02) {
  if(!isdefined(var_00) || !isdefined(var_02)) {
    return;
  }
  switch (var_00) {
    case "super_overdrive":
      if(func_9EBC(var_02, 2))
        func_D991("ch_assault_overdrive_2multi");

      break;
    case "super_chargemode":
      if(func_9EBC(var_02, 2))
        func_D991("ch_heavy_bullcharge_multi");

      break;
    case "super_teleport":
      if(var_01 == "MOD_MELEE")
        func_D991("ch_assassin_jump_melee");

      break;
    case "super_invisible":
      if(var_01 == "MOD_MELEE")
        func_D991("ch_sniper_camo_melee");

      break;
    case "super_visionpulse":
      if(func_9EBC(var_02, 2))
        func_D991("ch_sniper_pulsar_2multi");

      break;
  }
}

func_12F33(var_00, var_01) {
  if(!isdefined(self.func_112A8))
    return;
  else
    self.func_112A8++;

  self notify("super_weapon_kill", var_00);
  var_00 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);

  switch (var_00) {
    case "iw7_claw_mp":
      func_D991("ch_super_weapon_assault");
      break;
    case "iw7_steeldragon_mp":
      func_D991("ch_super_weapon_armor");
      break;
    case "iw7_armmgs_mp":
      func_D991("ch_super_weapon_synaptic");
      break;
    case "iw7_atomizer_mp":
      func_D991("ch_super_weapon_ftl");
      break;
    case "iw7_blackholegun_mp":
      func_D991("ch_super_weapon_six");

      if(isdefined(var_01)) {
        if(!isdefined(var_1.kills))
          var_1.kills = 1;
        else
          var_1.kills++;

        if(func_9EBC(var_1.kills, 2))
          func_D991("ch_engineer_bhgun_3multi");
      }

      break;
    case "iw7_penetrationrail_mp":
      func_D991("ch_super_weapon_ghost");
      break;
  }
}

func_BA2A() {
  self endon("disconnect");

  for (;;) {
    self waittill("super_use_started");
    var_00 = scripts\mp\supers::getcurrentsuperref();

    if(isdefined(var_00) && var_00 == "super_phaseshift" && self.health < self.maxhealth)
      func_D991("ch_assassin_damaged_phase_shift");

    if(isdefined(var_00) && var_00 == "super_amplify")
      thread monitorsuperscoreearned();

    self.func_112A8 = 0;
    thread func_BA2B();
    thread func_10DC7();
  }
}

func_B9DF() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("healed");

    if(isdefined(self.trait) && self.trait == "specialty_regenfaster")
      func_D991("ch_heavy_icu_heals");
  }
}

func_BA24() {
  self endon("disconnect");

  for (;;) {
    self waittill("received_earned_killstreak");

    if(func_66B8("specialty_hardline"))
      func_D991("ch_perk_hardline");

    wait 0.05;
  }
}

func_B9BF() {
  self endon("disconnect");

  for (;;) {
    self waittill("survived_explosion", var_00);

    if(isdefined(var_00) && isplayer(var_00) && self == var_00) {
      continue;
    }
    if(self getteamdompoints("specialty_blastshield", "perk") && scripts\mp\utility\game::_hasperk("specialty_blastshield"))
      processchallenge("ch_blastshield");

    scripts\engine\utility::waitframe();
  }
}

func_989E() {
  self.explosiveinfo = [];

  if(!isdefined(self.killsperweapon)) {
    self.killsperweapon = self.pers["killsPerWeapon"];

    if(!isdefined(self.killsperweapon))
      self.killsperweapon = [];
  }

  if(!isdefined(self.shotslandedlmg)) {
    self.shotslandedlmg = self.pers["shotsLandedLMG"];

    if(!isdefined(self.shotslandedlmg))
      self.shotslandedlmg = 0;
  }

  if(!isdefined(self.classickills)) {
    self.classickills = self.pers["classicKills"];

    if(!isdefined(self.classickills))
      self.classickills = 0;
  }

  if(!isdefined(self.akimbokills)) {
    self.akimbokills = self.pers["akimboKills"];

    if(!isdefined(self.akimbokills))
      self.akimbokills = 0;
  }

  if(!isdefined(self.hipfiremagkills)) {
    self.hipfiremagkills = self.pers["hipfireMagKills"];

    if(!isdefined(self.hipfiremagkills))
      self.hipfiremagkills = 0;
  }

  if(!isdefined(self.burstfirekills)) {
    self.burstfirekills = self.pers["burstFireKills"];

    if(!isdefined(self.burstfirekills))
      self.burstfirekills = 0;
  }
}

func_DEFF(var_00, var_01) {
  if(!isdefined(level.func_B8CD[var_00]))
    level.func_B8CD[var_00] = [];

  level.func_B8CD[var_00][level.func_B8CD[var_00].size] = var_01;
}

func_7E22(var_00) {
  if(isdefined(self.func_3C2A[var_00]))
    return self.func_3C2A[var_00];
  else
    return 0;
}

func_3BF3(var_00) {
  var_01 = var_0.player;

  if(isdefined(var_0.sweapon) && scripts\mp\utility\game::iskillstreakweapon(var_0.sweapon))
    var_01 func_D991("ch_lifetime_streak_assists");
}

func_3C02(var_00) {
  var_01 = var_0.player;
  var_01 func_D991("ch_lifetime_streaks_used");
}

func_3C00(var_00) {
  var_01 = var_0.player;
  var_02 = 0;
  var_03 = 0;

  foreach(var_05 in level.func_1655) {
    if(var_5.owner == var_01) {
      if(var_5.streakname == "sentry_shock") {
        var_2++;

        if(var_02 == 2)
          var_01 func_D991("ch_two_sentries");
      }

      continue;
    }

    if(var_5.streakname == "uav" || var_5.streakname == "directional_uav")
      var_03 = 1;
  }

  if(var_03 && var_0.func_A6A7 == "counter_uav")
    var_01 func_D991("ch_counter_other_uav");

  if(var_0.func_A6A7 == "jammer")
    return;
}

func_3C01(var_00) {
  if(!isdefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  }
  if(!isdefined(var_0.sweapon) || !scripts\mp\utility\game::iskillstreakweapon(var_0.sweapon)) {
    return;
  }
  var_01 = var_0.attacker;
  var_02 = func_7F48(var_0.sweapon);

  switch (var_02) {
    case "sentry_shock":
      var_01 func_D991("ch_scorestreak_kills_sentry");
      break;
    case "ball_drone_backup":
      var_01 func_D991("ch_scorestreak_kills_vulture");
      break;
    case "drone_hive":
      var_01 func_D991("ch_scorestreak_kills_trinity");
      break;
    case "precision_airstrike":
      var_01 func_D991("ch_scorestreak_kills_airstrike");
      break;
    case "minijackal":
      var_01 func_D991("ch_scorestreak_kills_apex");
      break;
    case "thor":
      var_01 func_D991("ch_scorestreak_kills_thor");
      break;
    case "bombardment":
      var_01 func_D991("ch_scorestreak_kills_bombardment");
      break;
    case "remote_c8":
      if(isdefined(var_1.func_4BE1) && var_1.func_4BE1 == "MANUAL")
        var_01 func_D991("ch_rc8_controlled_kills");

      var_01 func_D991("ch_scorestreak_kills_rc8");
      break;
    case "venom":
      var_01 func_D991("ch_scorestreak_kills_scarab");
      break;
    case "jackal":
      var_01 func_D991("ch_scorestreak_kills_warden");
      break;
  }

  var_01 func_D991("ch_lifetime_streak_kills");
}

func_7F48(var_00) {
  if(isdefined(level.killstreakweildweapons[var_00]))
    return level.killstreakweildweapons[var_00];

  return undefined;
}

func_9E4B(var_00) {
  var_01 = 0;

  switch (level.gametype) {
    case "dd":
    case "sd":
    case "sr":
      foreach(var_03 in level.bombzones) {
        var_04 = distancesquared(var_3.trigger.origin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "dom":
      foreach(var_03 in level.objectives) {
        var_04 = distancesquared(var_3.origin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "siege":
      foreach(var_03 in level.flags) {
        var_04 = distancesquared(var_3.origin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "grind":
      foreach(var_03 in level.func_13FC1) {
        var_04 = distancesquared(var_3.origin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "koth":
    case "grnd":
      var_01 = ispointinvolume(var_00, level.zone.gameobject.trigger);
      break;
  }

  return var_01;
}

func_9DBA(var_00) {
  var_01 = 0;

  switch (level.gametype) {
    case "dd":
    case "sd":
    case "sr":
      if(self.team != game["defenders"]) {
        break;
      }
      foreach(var_03 in level.bombzones) {
        var_04 = distancesquared(var_3.trigger.origin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "dom":
      foreach(var_03 in level.domflags) {
        if(self.team != var_03 scripts\mp\gameobjects::getownerteam()) {
          continue;
        }
        var_04 = distancesquared(var_3.curorigin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "siege":
      foreach(var_03 in level.domflags) {
        if(self.team != var_03 scripts\mp\gameobjects::getownerteam()) {
          continue;
        }
        var_04 = distancesquared(var_3.curorigin, var_00);

        if(var_04 < 90000) {
          var_01 = 1;
          break;
        }
      }

      break;
    case "grind":
      break;
    case "koth":
      var_01 = ispointinvolume(self.origin, level.zone.gameobject.trigger) || ispointinvolume(var_00, level.zone.gameobject.trigger);
      break;
  }

  return var_01;
}

func_D9BC(var_00, var_01) {
  switch (var_01) {
    case "uav":
      var_00 func_D991("ch_scorestreak_assists_uav");
      break;
    case "counter_uav":
      var_00 func_D991("ch_scorestreak_assists_cuav");
      break;
    case "directional_uav":
      var_00 func_D991("ch_scorestreak_assists_auav");
      break;
  }

  var_00 func_D991("ch_lifetime_streak_assists");
}

func_3C09(var_00) {
  if(!isdefined(var_0.attacker) || !isplayer(var_0.attacker)) {
    return;
  }
  var_01 = var_0.attacker;
}

func_D98F(var_00) {
  switch (var_00) {
    case "quad_feed":
      func_D991("ch_quad_feed");
      break;
    case "one_shot_two_kills":
      func_D991("ch_collateral");
      break;
    case "first_place_kill":
      func_D991("ch_kill_1st_place");
      break;
    case "gun_butt":
      func_D991("ch_gun_butt");
      break;
    case "backfire":
      func_D991("ch_owner_kill");
      break;
    case "item_impact":
      func_D991("ch_direct_impact");
      break;
  }

  if(var_00 == "longshot" && self.awardsthislife["longshot"] == 1 && isdefined(self.awardsthislife["pointblank"]) || var_00 == "pointblank" && self.awardsthislife["pointblank"] == 1 && isdefined(self.awardsthislife["longshot"]))
    func_D991("ch_longshot_pointblank");
}

func_3BF6(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = self;

  if(isplayer(var_01)) {
    if(isexplosivedamagemod(var_03)) {
      if(var_02 < var_6.health) {
        if(isdefined(var_06)) {
          var_6.func_6A06[var_1.guid] = var_01;

          if(isdefined(var_6.func_69F2)) {
            var_6.func_69F2++;

            if(var_6.func_69F2 == 3)
              var_06 func_D991("ch_blastshield_hits");
          }
        }
      }
    }

    var_01 func_D9B7(var_06, var_04, var_02);
  }
}

func_3BF5(var_00, var_01) {
  var_02 = var_0.attacker;
  var_03 = var_0.victim;

  if(!isdefined(var_02) || !isplayer(var_02) || !isalive(var_02)) {
    return;
  }
  var_01 = var_0.time;

  if(issubstr(var_0.smeansofdeath, "MOD_MELEE")) {
    if(var_3.health > 0)
      var_02 thread func_D9BE(var_03);

    var_02 func_D9B1(var_03);
  }
}

func_3BFF(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!isdefined(var_01) || !isplayer(var_01)) {
    return;
  }
  if(var_05 == "throwingknifec4_mp") {
    if(var_04 == "MOD_IMPACT")
      var_1.func_A949 = gettime();
    else if(var_04 == "MOD_EXPLOSIVE" && isdefined(var_1.func_A949)) {
      var_09 = gettime() - var_1.func_A949;

      if(var_09 <= 50)
        var_01 func_D991("ch_biospike_double");
    }
  }

  if(var_05 == "micro_turret_gun_mp" && isdefined(var_00)) {
    if(!isdefined(var_0.kills))
      var_0.kills = 1;
    else
      var_0.kills++;

    if(func_9EBC(var_0.kills, 2))
      var_01 func_D991("ch_engineer_micro_turret_2multi");
  }

  if(scripts\mp\utility\game::iskillstreakweapon(var_05)) {
    var_10 = func_7F48(var_05);

    if(!isdefined(var_1.func_A6A5))
      var_1.func_A6A5 = [];

    if(isdefined(var_00) && isdefined(var_0.func_1653)) {
      if(!isdefined(var_1.func_A6A5[var_0.func_1653])) {
        var_11 = spawnstruct();
        var_11.func_A6A7 = var_10;
        var_11.kills = 1;
        var_11.func_C2A4 = scripts\engine\utility::ter_op(func_9E4B(var_0.origin), 1, 0);
        var_1.func_A6A5[var_0.func_1653] = var_11;
      } else {
        var_1.func_A6A5[var_0.func_1653].kills++;

        if(func_9E4B(var_0.origin))
          var_1.func_A6A5[var_0.func_1653].func_C2A4++;
      }
    } else {}

    switch (var_10) {
      case "sentry_shock":
        if(func_9EBC(var_1.func_A6A5[var_0.func_1653].func_C2A4, 3))
          var_01 func_D991("ch_sentry_defender");

        if(func_9EBC(var_1.func_A6A5[var_0.func_1653].kills, 5))
          var_01 func_D991("ch_sentry_streak");

        break;
      case "ball_drone_backup":
        break;
      case "drone_hive":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 3 == 0)
          var_01 func_D991("ch_scorestreak_triple_kills");

        break;
      case "precision_airstrike":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 3 == 0)
          var_01 func_D991("ch_scorestreak_triple_kills");

        break;
      case "minijackal":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 3 == 0)
          var_01 func_D991("ch_scorestreak_triple_kills");

        break;
      case "thor":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 3 == 0)
          var_01 func_D991("ch_scorestreak_triple_kills");

        break;
      case "bombardment":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 3 == 0)
          var_01 func_D991("ch_scorestreak_triple_kills");

        break;
      case "remote_c8":
        break;
      case "venom":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 2 == 0)
          var_01 func_D991("ch_scorestreak_double_scarab");

        if(self iswallrunning())
          var_01 func_D991("ch_scarab_wall_kill");

        break;
      case "jackal":
        if(var_1.func_DDC3[var_05] > 0 && var_1.func_DDC3[var_05] % 3 == 0)
          var_01 func_D991("ch_scorestreak_triple_kills");

        break;
    }
  }

  var_01 func_D98B();
  var_01 func_D997(self);
}

func_3BFE(var_00, var_01) {
  var_02 = var_0.attacker;
  var_03 = var_0.victim;

  if(!isdefined(var_02) || !isplayer(var_02)) {
    return;
  }
  var_01 = var_0.time;
  var_02 func_D991("ch_lifetime_kills");

  if(isdefined(var_0.victim) && isdefined(var_0.victim.guid))
    var_02 notify("killedPlayer" + var_0.victim.guid);

  func_D9D8(var_00, var_02);
  func_D9AE(var_00, var_01, var_02, var_03);
  func_D9B9(var_00, var_01, var_02, var_03);
  func_D9B2(var_00, var_01, var_02, var_03);
  func_D9B0(var_00, var_01, var_02, var_03);
  var_02 func_D98A(var_00);
  var_02 func_D9BB(var_00);
  var_02 func_D9A8(var_00);
  var_02 func_D996(var_00);
  var_02 processrigkillchallengesonkill_delayed(var_00);

  if(isdefined(var_0.func_13374)) {
    var_04 = var_0.func_13374[var_2.guid];

    if(scripts\mp\utility\game::istrue(var_4.diddamagewithlethalequipment) && var_0.isbulletdamage)
      var_02 func_D991("ch_lethal_bullet_combo");

    if(scripts\mp\utility\game::istrue(var_4.isprimary) && scripts\mp\utility\game::iscacsecondaryweapon(var_0.sweapon))
      var_02 func_D991("ch_swap_kill");

    if(isdefined(var_0.func_24E0)) {
      if(isdefined(var_0.func_24E0[var_3.guid])) {
        if(!scripts\mp\utility\game::istrue(var_4.didnonmeleedamage))
          var_02 func_D991("ch_hurt_melee_kill");
      }
    }
  }

  if(var_0.func_24F6.size > 0)
    var_02 func_D9B8();

  if(isdefined(var_0.func_24F2[var_3.guid])) {
    var_05 = var_0.func_24F2[var_3.guid];

    if(func_9EBC(var_05, 5))
      var_02 func_D991("ch_repeat_kill");
  }

  if(var_0.func_24E1)
    var_02 func_D991("ch_while_stunned_kill");

  if(var_0.func_13375)
    var_02 func_D991("ch_stun_kill");

  if(scripts\mp\utility\game::istrue(var_0.func_24EA))
    var_02 func_D991("ch_tactical_smoke");

  if(scripts\mp\utility\game::istrue(var_0.func_2501))
    var_02 func_D991("ch_tactical_radar");

  if(func_9E8A(var_0.shitloc))
    var_02 func_D991("ch_lower_body_kill");

  if(scripts\mp\utility\game::istrue(var_0.func_2511))
    var_02 func_D991("ch_pre_adrenaline");

  if(isdefined(var_0.func_13377)) {
    if(var_0.func_13377 == var_02)
      var_02 func_D991("ch_dome_defense");

    if(var_0.func_13377 == var_03)
      var_02 func_D991("ch_dome_assault");
  }

  if(isdefined(var_3.debuffedbyplayers)) {
    var_06 = var_02 getentitynumber();

    if(isdefined(var_0.func_13376["cryo_mine_mp"]) && isdefined(var_0.func_13376["cryo_mine_mp"][var_06]))
      var_02 func_D991("ch_tactical_cryomine");

    if(isdefined(var_0.func_13376["blackout_grenade_mp"]) && isdefined(var_0.func_13376["blackout_grenade_mp"][var_06]))
      var_02 func_D991("ch_tactical_blackout");

    if(isdefined(var_0.func_13376["emp_grenade_mp"]) && isdefined(var_0.func_13376["emp_grenade_mp"][var_06]) || isdefined(var_0.func_13376["concussion_grenade_mp"]) && isdefined(var_0.func_13376["concussion_grenade_mp"][var_06]))
      var_02 func_D991("ch_tactical_concussion");
  }

  if(isdefined(var_0.func_24E9[var_3.guid]))
    var_02 func_D991("ch_blastshield_revenge");

  var_07 = [];

  foreach(var_09 in var_0.func_24FD) {
    var_10 = scripts\mp\perks::_meth_805C(var_09);

    if(isdefined(var_10)) {
      if(!isdefined(var_7[var_10])) {
        var_7[var_10] = 1;
        continue;
      }

      var_7[var_10]++;
    }
  }

  if(isdefined(var_7[1]) && var_7[1] == 2)
    var_02 func_D991("ch_perk_1_combo");

  if(isdefined(var_7[2]) && var_7[2] == 2)
    var_02 func_D991("ch_perk_2_combo");

  if(isdefined(var_7[3]) && var_7[3] == 2)
    var_02 func_D991("ch_perk_3_combo");

  if(scripts\mp\utility\game::iskillstreakweapon(var_0.sweapon) && !allowinteractivecombat(var_02, var_0.sweapon)) {
    return;
  }
  func_D9C8(var_00, var_01, var_02, var_03);

  if(isdefined(var_0.func_24F8) && var_0.time - var_0.func_24F8 < 4500)
    var_02 func_D991("ch_use_gesture");

  if(isdefined(var_3.func_A6AE)) {
    foreach(var_13 in var_3.func_A6AE) {
      if(var_13.owner == var_02) {
        switch (var_13.func_A6A7) {
          case "remote_c8":
            var_02 func_D991("ch_rc8_defense");
            break;
        }
      }
    }
  }
}

func_D98B() {
  if(isdefined(level.func_1655)) {
    foreach(var_01 in level.func_1655) {
      if(var_1.owner == self) {
        switch (var_1.streakname) {
          case "uav":
            func_D991("ch_scorestreak_kills_uav");
            break;
          case "counter_uav":
            func_D991("ch_scorestreak_kills_cuav");
            break;
          case "directional_uav":
            func_D991("ch_scorestreak_kills_auav");
            break;
        }
      }
    }
  }
}

func_D9D8(var_00, var_01) {
  var_02 = scripts\mp\loot::getlootinfoforweapon(var_0.sweapon);

  if(isdefined(var_02) && isdefined(var_2.quality)) {
    switch (var_2.quality) {
      case 4:
        var_01 func_D991("ch_outfitter_epic");
        break;
      case 3:
        var_01 func_D991("ch_outfitter_legendary");
        break;
      case 2:
        var_01 func_D991("ch_outfitter_rare");
        break;
      case 1:
        var_01 func_D991("ch_outfitter_common");
        break;
    }
  }

  if(isdefined(var_0.func_24F3)) {
    var_03 = 0;

    foreach(var_07, var_05 in var_0.func_24F3) {
      var_06 = getweaponvariantindex(var_07);

      if(!isdefined(var_06)) {
        continue;
      }
      var_3++;
    }

    if(func_9EBC(var_03, 3))
      var_01 func_D991("ch_outfitter_variant_triplet");
  }

  if(var_0.sweapon != var_1.primaryweapon && var_0.sweapon != var_1.secondaryweapon) {
    return;
  }
  var_08 = scripts\mp\loot::getlootinfoforweapon(var_1.primaryweapon);
  var_09 = scripts\mp\loot::getlootinfoforweapon(var_1.secondaryweapon);

  if(isdefined(var_08) && isdefined(var_8.quality) && isdefined(var_09) && isdefined(var_9.quality)) {
    if(var_8.quality == var_9.quality) {
      switch (var_8.quality) {
        case 4:
          var_01 func_D991("ch_outfitter_epic_set");
          break;
        case 3:
          var_01 func_D991("ch_outfitter_legendary_set");
          break;
        case 2:
          var_01 func_D991("ch_outfitter_rare_set");
          break;
        case 1:
          var_01 func_D991("ch_outfitter_common_set");
          break;
      }
    }
  }
}

func_D9AE(var_00, var_01, var_02, var_03) {
  if(scripts\mp\utility\game::istrue(var_0.modifiers["wallkill"]))
    var_02 func_D991("ch_wallrun_kill");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["jumpkill"]))
    var_02 func_D991("ch_air_kill");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["slidekill"]))
    var_02 func_D991("ch_slide_kill");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["killonwall"]))
    var_02 func_D991("ch_kill_wallrunner");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["killinair"]))
    var_02 func_D991("ch_kill_jumper");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["clutchkill"]))
    var_02 func_D991("ch_clutch_grenade");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["wallkill"]) && scripts\mp\utility\game::istrue(var_0.modifiers["killonwall"]))
    var_02 func_D991("ch_wall_vs_wall");
}

func_D9B9(var_00, var_01, var_02, var_03) {
  if(isdefined(var_0.func_24E4)) {
    if(func_9EBC(var_0.func_24E4, 5))
      var_02 func_D991("ch_bloodthirsty");

    if(func_9EBC(var_0.func_24E4, 10))
      var_02 func_D991("ch_merciless");

    if(func_9EBC(var_0.func_24E4, 15))
      var_02 func_D991("ch_ruthless");
  }
}

func_D9B2(var_00, var_01, var_02, var_03) {
  if(isdefined(var_0.func_2504)) {
    if(func_9EBC(var_0.func_2504, 2))
      var_02 func_D991("ch_double_kill");

    if(func_9EBC(var_0.func_2504, 3))
      var_02 func_D991("ch_triple_kill");

    if(func_9EBC(var_0.func_2504, 4))
      var_02 func_D991("ch_quad_kill");
  }
}

func_D9B0(var_00, var_01, var_02, var_03) {
  foreach(var_05 in var_0.func_24FD) {
    switch (var_05) {
      case "specialty_expanded_minimap":
        var_02 func_D991("ch_perk_kills_awareness");
        break;
      case "specialty_blastshield":
        var_02 func_D991("ch_perk_kills_blastshield");
        break;
      case "specialty_dexterity":
        var_02 func_D991("ch_perk_kills_dexterity");

        if(isdefined(var_0.func_24FA) && gettime() - var_0.func_24FA < 5000 || isdefined(var_0.func_24FC) && gettime() - var_0.func_24FC < 5000)
          var_02 func_D991("ch_dexterity_actions");

        break;
      case "specialty_ghost":
        if(scripts\mp\utility\game::istrue(var_0.func_13384))
          var_02 func_D991("ch_perk_kills_ghost");

        if(scripts\mp\utility\game::istrue(var_0.modifiers["backstab"]))
          var_02 func_D991("ch_ghost_backstab");

        break;
      case "specialty_momentum":
        if(var_0.smeansofdeath == "MOD_MELEE" && var_0.func_24FE > 1.0)
          var_02 func_D991("ch_momentum_melee");

        break;
      case "specialty_tracker":
        var_02 func_D991("ch_perk_kills_tracker");

        if(var_0.smeansofdeath == "MOD_MELEE")
          var_02 func_D991("ch_tracker_melee");

        break;
      case "specialty_stun_resistance":
        if(isdefined(var_0.func_250C[var_3.guid]))
          var_02 func_D991("ch_perk_kills_tacresist");

        break;
      case "specialty_coldblooded":
        if(scripts\mp\utility\game::weaponhasattachment(var_0.func_13385, "thermal") || scripts\mp\utility\game::istrue(var_0.func_1337D) || scripts\mp\utility\game::istrue(var_0.func_1337B))
          var_02 func_D991("ch_perk_kills_coldblooded");

        if(scripts\mp\utility\game::getweapongroup(var_0.sweapon) == "weapon_sniper")
          var_02 func_D991("ch_coldblood_sniper");

        break;
      case "specialty_sprintfire":
        if(var_0.func_24F1 && var_0.isbulletdamage)
          var_02 func_D991("ch_perk_kills_gungho");

        if(isdefined(var_0.func_24F5) && func_9EBC(var_0.func_24F5, 2))
          var_02 func_D991("ch_gungho_double_kill");

        break;
      case "specialty_bullet_outline":
        var_02 func_D991("ch_perk_kills_pinpoint");
        var_06 = undefined;

        if(isdefined(var_0.func_13374[var_2.guid]))
          var_06 = var_0.func_13374[var_2.guid].firsttimedamaged;

        if(isdefined(var_06)) {
          var_07 = undefined;

          if(isdefined(var_0.func_24E0[var_3.guid]))
            var_07 = var_0.func_24E0[var_3.guid].firsttimedamaged;

          if(isdefined(var_07) && var_07 < var_06)
            var_02 func_D991("ch_pinpoint_counter_kill");
        }

        break;
      case "specialty_marksman":
        if(scripts\mp\utility\game::istrue(var_0.modifiers["longshot"]))
          var_02 func_D991("ch_marksman_longshot");

        if(var_0.func_24EF && isdefined(var_0.func_24F9) && gettime() < var_0.func_24F9 + 3000)
          var_02 func_D991("ch_marksman_flinch");

        break;
      case "specialty_empimmune":
        var_02 func_D991("ch_perk_kills_hardwired");
        break;
      case "specialty_quieter":
        var_02 func_D991("ch_perk_kills_deadsilence");

        if(var_0.smeansofdeath == "MOD_MELEE")
          var_02 func_D991("ch_deadsilence_melee");

        break;
    }
  }
}

func_D9C8(var_00, var_01, var_02, var_03) {
  if(var_0.sweapon == "none") {
    if(isdefined(var_0.victim.explosiveinfo) && isdefined(var_0.victim.explosiveinfo["weapon"]))
      var_0.sweapon = var_0.victim.explosiveinfo["weapon"];
    else
      return;
  }

  if(var_0.attacker scripts\mp\utility\game::ispickedupweapon(var_0.sweapon)) {
    var_02 func_D991("ch_pickup_kills");
    var_04 = scripts\mp\loot::getlootinfoforweapon(var_0.sweapon);

    if(isdefined(var_04) && isdefined(var_4.quality) && var_4.quality == 4)
      var_02 func_D991("ch_outfitter_thief");

    if(isdefined(var_0.func_2512) && isdefined(var_0.func_2512[var_0.sweapon]) && gettime() - var_0.func_2512[var_0.sweapon] < 10000)
      var_02 func_D991("ch_quick_pickup_kill");
  }

  var_05 = scripts\mp\utility\game::getweaponrootname(var_0.sweapon);
  var_06 = scripts\mp\utility\game::getweapongroup(var_0.sweapon);

  if(var_0.smeansofdeath == "MOD_PISTOL_BULLET" || var_0.smeansofdeath == "MOD_RIFLE_BULLET" || var_0.smeansofdeath == "MOD_HEAD_SHOT")
    func_D990(var_00, var_02, var_01, var_06, var_05);
  else if(isexplosivedamagemod(var_0.smeansofdeath))
    func_D99E(var_00, var_02, var_01, var_06, var_05);
  else if(issubstr(var_0.smeansofdeath, "MOD_MELEE") && !scripts\mp\weapons::isriotshield(var_0.sweapon))
    func_D9AC(var_00, var_02, var_01, var_06, var_05);
  else if(scripts\mp\weapons::isriotshield(var_0.sweapon))
    func_D9B3(var_00, var_02, var_01, var_06, var_05);
  else if(issubstr(var_0.smeansofdeath, "MOD_IMPACT")) {
    if(var_05 == "iw7_axe")
      var_02 processweaponchallenge_axethrow(var_05, var_00);

    func_D9A0(var_00, var_02, var_01, var_06, var_05);
  }

  if(var_06 == "weapon_projectile")
    var_02 func_D9CE(var_05, var_00);

  var_07 = scripts\mp\utility\game::getequipmenttype(var_0.sweapon);

  if(isdefined(var_07)) {
    if(var_07 == "lethal")
      func_D9A9(var_00, var_02, var_01, var_06, var_05);
  }

  if(scripts\mp\utility\game::isclassicweapon(var_0.sweapon) && var_0.smeansofdeath != "MOD_MELEE") {
    if(!isdefined(var_2.classickills))
      var_2.classickills = 1;
    else
      var_2.classickills++;
  }

  if(scripts\mp\utility\game::isburstfireweapon(var_0.sweapon) && var_0.smeansofdeath != "MOD_MELEE") {
    if(!isdefined(var_2.burstfirekills))
      var_2.burstfirekills = 1;
    else
      var_2.burstfirekills++;
  }

  if(!scripts\mp\utility\game::istrue(var_2.func_D99C)) {
    var_08 = 0;
    var_09 = 0;
    var_10 = 0;

    foreach(var_13, var_12 in var_0.func_24F3) {
      var_08 = var_08 || scripts\mp\utility\game::iscacprimaryweapon(var_13);
      var_09 = var_09 || scripts\mp\utility\game::iscacsecondaryweapon(var_13);
      var_07 = scripts\mp\utility\game::getequipmenttype(var_13);
      var_10 = var_10 || isdefined(var_07) && var_07 == "lethal";
    }

    if(var_08 && var_09 && var_10) {
      var_02 func_D991("ch_3_kill_types");
      var_2.func_D99C = 1;
    }
  }
}

func_D990(var_00, var_01, var_02, var_03, var_04) {
  if(scripts\mp\utility\game::iskillstreakweapon(var_0.sweapon) || scripts\mp\utility\game::isenvironmentweapon(var_0.sweapon)) {
    return;
  }
  switch (var_03) {
    case "weapon_smg":
      var_01 func_D9D1(var_04, var_00);
      break;
    case "weapon_assault":
      var_01 func_D9C9(var_04, var_00);
      break;
    case "weapon_shotgun":
      var_01 func_D9D0(var_04, var_00);
      break;
    case "weapon_dmr":
      var_01 func_D9CA(var_04, var_00);
      break;
    case "weapon_sniper":
      if(var_04 == "iw7_m1c")
        var_01 func_D9C9(var_04, var_00);
      else
        var_01 func_D9D2(var_04, var_00);

      break;
    case "weapon_pistol":
      var_01 func_D9CD(var_04, var_00);
      break;
    case "weapon_lmg":
      var_01 func_D9CB(var_04, var_00);
      break;
    default:
      break;
  }

  if(scripts\mp\utility\game::istrue(_weaponusesenergybullets(var_0.sweapon)))
    var_01 func_D991("ch_lifetime_energy_kills");

  if(scripts\mp\utility\game::istrue(var_0.modifiers["headshot"]))
    var_01 func_D991("ch_lifetime_headshots");

  if(var_0.func_24E3 == 0) {
    var_05 = weaponclipsize(var_0.sweapon);

    if(var_05 >= 10)
      var_01 func_D991("ch_last_bullet_kill");
  }

  var_06 = scripts\mp\utility\game::getweaponrootname(var_0.sweapon);
  var_07 = issubstr(var_0.sweapon, "alt_");
  var_08 = getweaponvariantindex(var_0.sweapon);
  var_09 = var_06 == "iw7_fmg" && var_07 || var_06 == "iw7_ump45" && isdefined(var_08) && (var_08 == 3 || var_08 == 35) || var_06 == "iw7_minilmg" && isdefined(var_08) && (var_08 == 3 || var_08 == 35);

  if(var_09) {
    if(!isdefined(var_1.akimbokills))
      var_1.akimbokills = 1;
    else
      var_1.akimbokills++;
  }

  func_D98E(var_00, var_01, var_02, var_03, var_04);
}

func_D98E(var_00, var_01, var_02, var_03, var_04) {
  if(scripts\mp\utility\game::issuperweapon(var_0.sweapon))
    return 0;

  if(getweaponcamoname(var_0.sweapon) != "camo0")
    var_01 func_D991("ch_outfitter_camo");

  if(var_03 == "weapon_sniper" && !scripts\mp\weapons::func_13C98(var_0.sweapon))
    var_01 func_D9C3(var_04, "noscope", var_00);

  var_05 = 0;
  var_06 = 0;
  var_07 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0.sweapon);

  foreach(var_09 in var_07) {
    if(scripts\mp\utility\game::func_248E(var_09)) {
      var_01 func_D991("ch_outfitter_charm");

      if(var_09 == "cos_026" || var_09 == "cos_007" || var_09 == "cos_006")
        var_05 = 1;
    }

    if(!scripts\mp\weapons::func_9F3C(var_04, var_09)) {
      continue;
    }
    switch (var_09) {
      case "oscope":
      case "vzscope":
      case "elo":
      case "phase":
      case "reflex":
      case "hybrid":
      case "acog":
      case "thermal":
        var_01 func_D9C3(var_04, var_09, var_00);
        var_01 func_D991("ch_attach_rof");
        var_06 = 1;
        break;
      case "smart":
        var_01 func_D991("ch_attach_rof");
        var_06 = 1;
        break;
      case "xmags":
        if(func_9EBC(var_0.func_24F4, 2))
          var_01 func_D991("ch_xmags_two_kills");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "xmagse":
        if(func_9EBC(var_0.func_24F4, 2))
          var_01 func_D991("ch_xmags_two_kills");

        var_01 func_D991("ch_attach_xmags");
        break;
      case "fastaim":
        if(gettime() - var_0.func_24F7 < 3000)
          var_01 func_D991("ch_fastaim_ads_kill");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "stock":
        if(var_0.func_24EF && var_0.func_250A >= 50)
          var_01 func_D991("ch_stock_ads_kill");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "cpu":
        if(var_0.func_24EF && !var_0.func_24EB)
          var_01 func_D991("ch_cpu_ads_kill");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "akimbo":
        if(!var_0.func_2500)
          var_01 func_D991("ch_akimbo_jump_kill");

        var_01 func_D991("ch_attach_" + var_09);

        if(!isdefined(var_1.akimbokills))
          var_1.akimbokills = 1;
        else
          var_1.akimbokills++;

        break;
      case "fmj":
        if(var_0.func_92BE & level.idflags_penetration)
          var_01 func_D991("ch_fmj_penetrate");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "highcal":
        if(isdefined(var_0.modifiers["headshot"]))
          var_01 func_D991("ch_highcal_headshots");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "barrelrange":
        if(isdefined(var_0.modifiers["longshot"]))
          var_01 func_D991("ch_barrelrange_longshots");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "hipaim":
        if(isdefined(var_0.modifiers["hipfire"]))
          var_01 func_D991("ch_hipaim_hipfire");

        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "overclock":
      case "rof":
      case "silencer":
      case "grip":
      case "firetypeauto":
        var_01 func_D991("ch_attach_" + var_09);
        break;
      case "reflect":
        var_01 func_D991("ch_attach_ricochet");
        break;
      default:
        break;
    }
  }

  if(var_05) {
    var_03 = scripts\mp\utility\game::getweapongroup(var_0.sweapon);

    if(var_03 == "weapon_assault" && scripts\mp\utility\game::istrue(_weaponusesenergybullets(var_0.sweapon)))
      var_01 func_D991("ch_rvn_unlock");

    if(var_03 == "weapon_pistol" && var_06 == 1)
      var_01 func_D991("ch_udm_unlock");
  }

  if(scripts\mp\utility\game::func_13C91(var_0.sweapon))
    var_01 func_D9BF(var_04, "firetypeburst");

  if(scripts\mp\utility\game::func_13C94(var_04))
    var_01 func_D9BF(var_04, "silencer");

  if(scripts\mp\utility\game::func_13C93(var_04))
    var_01 func_D9BF(var_04, "grip");

  if(scripts\mp\utility\game::func_13C92(var_04))
    var_01 func_D9BF(var_04, "fmj");

  if(var_01 scripts\mp\utility\game::func_9EE8() && scripts\mp\utility\game::func_13C95(var_0.sweapon))
    var_01 func_D9BF(var_04, "tracker");
}

func_D99E(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0.sweapon);

  foreach(var_07 in var_05) {
    switch (var_07) {
      case "gl":
        if(scripts\mp\utility\game::isstrstart(var_0.sweapon, "alt_"))
          var_01 func_D9BF(var_04, var_07);

        break;
    }
  }

  if(isdefined(var_0.func_94B6)) {
    if(var_0.func_94B6 == "power_explodingDrone") {
      if(isdefined(var_0.func_94B3) && isdefined(var_0.func_94B5)) {
        if(var_0.func_94B3 == var_01) {
          if(var_0.func_94B5 == var_01)
            var_01 func_D991("ch_explodingdrone_combo");
        }
      }
    } else if(var_0.func_94B6 == "power_tripMine") {
      if(isdefined(var_0.func_94B3) && isdefined(var_0.func_94B5)) {
        if(var_0.func_94B3 == var_01) {
          if(var_0.func_94B5 == var_01)
            var_01 func_D991("ch_tripmine_explode");
          else if(var_0.func_94B5 == var_0.victim)
            var_01 func_D991("ch_enemy_equip_kill");
        }
      }
    }
  }
}

func_D9AC(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0.sweapon);

  foreach(var_07 in var_05) {
    switch (var_07) {
      case "tactical":
        var_01 func_D9BF(var_04, var_07);
        break;
    }
  }

  if(var_0.func_13380 == "crouch" || var_0.func_13380 == "prone")
    var_01 func_D991("ch_melee_crouch_prone");

  if(var_03 == "weapon_melee") {
    if(var_04 == "iw7_axe")
      var_01 processweaponchallenge_axemelee(var_04, var_00);
    else
      var_01 func_D9CC(var_04, var_00);
  }
}

func_D9B3(var_00, var_01, var_02, var_03, var_04) {
  if(issubstr(var_0.smeansofdeath, "MOD_MELEE"))
    var_01 func_D9CF(var_04, var_00);

  var_05 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0.sweapon);

  foreach(var_07 in var_05) {
    switch (var_07) {
      case "rshieldspikes":
      case "rshieldscrambler":
      case "rshieldradar":
        var_01 func_D9BF(var_04, var_07);
        break;
    }
  }
}

func_D9A0(var_00, var_01, var_02, var_03, var_04) {
  var_05 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0.sweapon);

  foreach(var_07 in var_05) {
    switch (var_07) {
      case "gl":
        if(scripts\mp\utility\game::isstrstart(var_0.sweapon, "alt_"))
          var_01 func_D9BF(var_04, var_07);

        break;
    }
  }
}

func_D9A9(var_00, var_01, var_02, var_03, var_04) {
  var_05 = level.func_D7A4[var_0.sweapon];

  switch (var_05) {
    case "power_splashGrenade":
      var_01 func_D991("ch_lethal_splash");
      break;
    case "power_clusterGrenade":
      var_01 func_D991("ch_lethal_cluster");
      break;
    case "power_tripMine":
      var_01 func_D991("ch_lethal_tripmine");
      break;
    case "power_splitGrenade":
      var_01 func_D991("ch_lethal_split");
      break;
    case "power_explodingDrone":
      var_01 func_D991("ch_lethal_explodingdrone");
      break;
    case "power_blackholeGrenade":
      var_01 func_D991("ch_lethal_blackhole");
      break;
    case "power_wristRocket":
      var_01 func_D991("ch_lethal_armlauncher");
      break;
    case "power_spiderGrenade":
      var_01 func_D991("ch_lethal_spider");
      break;
    case "power_c4":
      var_01 func_D991("ch_lethal_c4");
      break;
    case "power_bioSpike":
      var_01 func_D991("ch_lethal_biospike");
      break;
    case "power_throwingKnife":
      break;
    default:
  }

  if(isdefined(var_0.func_94B4) && var_0.func_94B4 == "friendly")
    var_01 func_D991("ch_stick_teammate");
}

func_3C03(var_00) {
  if(!isdefined(game["uniquePlayerCount"]) || game["uniquePlayerCount"] < 3) {
    return;
  }
  var_01 = var_0.player;

  if(var_1.wasaliveatmatchstart) {
    var_02 = var_1.pers["kills"];
    var_03 = var_1.pers["deaths"];
    var_04 = var_1.pers["score"];
    var_05 = 1000000;

    if(var_03 > 0)
      var_05 = var_02 / var_03;

    var_1.pers["kdratio"] = var_05;

    if(var_05 >= 5.0 && var_02 >= 5.0)
      var_01 processchallenge("ch_starplayer");

    if(var_03 == 0 && scripts\mp\utility\game::gettimepassed() > 300000)
      var_01 processchallenge("ch_flawless");

    if(var_1.score > 0) {
      var_06 = scripts\mp\utility\game::roundup(var_1.score / 100);
      var_01 func_D991("ch_lifetime_score", var_06);

      switch (level.gametype) {
        case "dm":
          if(var_0.func_CBFC < 3)
            var_01 func_D991("ch_ffa_wins");

          break;
        case "sotf_ffa":
          if(var_0.func_CBFC < 3)
            var_01 processchallenge("ch_hunted_victor");

          break;
      }
    }
  }

  var_01 checkvrunlockchallenge();
  var_01 checkmp28unlockchallenge();
  var_01 checkminilmgunlockchallenge();
  var_01 checkba50calunlockchallenge();
  var_01 checkmod2187unlockchallenge();
  var_01 checklongshotunlockchallenge();
  var_01 checkgaussunlockchallenge();
  var_01 checkmustangunlockchallenge();
  var_01 checktacburstunlockchallenge();
  var_01 checkatlasunlockchallenge();
}

func_3C04(var_00) {
  if(!var_0.func_13D8A) {
    return;
  }
  if(!isdefined(game["uniquePlayerCount"]) || game["uniquePlayerCount"] < 3) {
    return;
  }
  var_01 = var_0.player;

  if(var_1.wasaliveatmatchstart) {
    var_01 func_D991("ch_global_wins");

    if(level.tactical)
      var_01 func_D991("ch_ctf_wins");

    if(var_0.func_CBFC == 0)
      var_01 func_D991("ch_first_place");

    if(var_0.func_CBFC <= 2)
      var_01 func_D991("ch_top3");

    switch (level.gametype) {
      case "war":
        var_01 func_D991("ch_war_wins");
        break;
      case "sd":
        var_01 func_D991("ch_sd_sr_wins");
        break;
      case "dom":
        var_01 func_D991("ch_dom_wins");
        break;
      case "conf":
        var_01 func_D991("ch_kc_grind_wins");
        break;
      case "sr":
        var_01 func_D991("ch_sd_sr_wins");
        break;
      case "grind":
        var_01 func_D991("ch_kc_grind_wins");
        break;
      case "ball":
        var_01 func_D991("ch_ball_wins");
        break;
      case "infect":
        break;
      case "aliens":
        break;
      case "gun":
        break;
      case "grnd":
        break;
      case "siege":
        var_01 func_D991("ch_siege_wins");
        break;
      case "koth":
        var_01 func_D991("ch_koth_wins");
        break;
      case "mp_zomb":
        break;
      case "ctf":
        break;
      case "dd":
        var_01 func_D991("ch_dd_wins");
        break;
      case "tdef":
        var_01 func_D991("ch_tdef_wins");
        break;
      case "front":
        var_01 func_D991("ch_war_wins");
        break;
      default:
        break;
    }

    var_02 = getdvarint("scr_playlist_type", 0);

    if(var_02 == 1) {
      var_01 processchallenge("ch_bromance");

      if(!level.console)
        var_01 processchallenge("ch_tactician");
    } else if(var_02 == 2)
      var_01 processchallenge("ch_tactician");

    if(level.hardcoremode)
      var_01 processchallenge("ch_hardcore_extreme");
  }

  var_01 checkcrdbunlockchallenge();
}

checkvrunlockchallenge() {
  if(func_2139("ch_vr_unlock")) {
    return;
  }
  if(isdefined(self.killsperweapon)) {
    var_00 = [];

    foreach(var_04, var_02 in self.killsperweapon) {
      if(var_02 > 0 && (scripts\mp\utility\game::iscacprimaryweapon(var_04) || scripts\mp\utility\game::iscacsecondaryweapon(var_04))) {
        var_03 = scripts\mp\utility\game::getweaponrootname(var_04);
        var_0[var_03] = 1;

        if(var_0.size >= 6) {
          func_D991("ch_vr_unlock");
          return;
        }
      }
    }
  }
}

checkcrdbunlockchallenge() {
  if(func_2139("ch_crdb_unlock")) {
    return;
  }
  if(isdefined(self.killsperweapon)) {
    var_00 = 0;

    foreach(var_03, var_02 in self.killsperweapon) {
      if(scripts\mp\utility\game::getweaponrootname(var_03) == "iw7_vr")
        var_00 = var_00 + var_02;

      if(var_00 > 0) {
        func_D991("ch_crdb_unlock");
        return;
      }
    }
  }
}

checkminilmgunlockchallenge() {
  if(func_2139("ch_minilmg_unlock")) {
    return;
  }
  if(isdefined(self.shotslandedlmg) && self.shotslandedlmg >= 50)
    func_D991("ch_minilmg_unlock");
}

checkmp28unlockchallenge() {
  if(func_2139("ch_mp28_unlock")) {
    return;
  }
  if(isdefined(self.classickills) && self.classickills >= 10)
    func_D991("ch_mp28_unlock");
}

checkba50calunlockchallenge() {
  if(func_2139("ch_ba50cal_unlock")) {
    return;
  }
  if(isdefined(self.pers["oneShotKills"]) && self.pers["oneShotKills"] >= 5)
    func_D991("ch_ba50cal_unlock");
}

checkmod2187unlockchallenge() {
  if(func_2139("ch_mod2187_unlock")) {
    return;
  }
  if(isdefined(self.akimbokills) && self.akimbokills >= 10)
    func_D991("ch_mod2187_unlock");
}

checklongshotunlockchallenge() {
  if(func_2139("ch_longshot_unlock")) {
    return;
  }
  var_00 = 0;
  var_01 = 0;

  foreach(var_05, var_03 in self.killsperweapon) {
    if(var_03 > 0 && (scripts\mp\utility\game::iscacprimaryweapon(var_05) || scripts\mp\utility\game::iscacsecondaryweapon(var_05))) {
      var_04 = scripts\mp\utility\game::getweaponrootname(var_05);

      if(var_04 == "iw7_ba50cal")
        var_00 = 1;

      if(var_04 == "iw7_mod2187")
        var_01 = 1;
    }
  }

  if(var_00 && var_01)
    func_D991("ch_longshot_unlock");
}

checkgaussunlockchallenge() {
  if(func_2139("ch_gauss_unlock")) {
    return;
  }
  if(isdefined(self.hipfiremagkills) && self.hipfiremagkills >= 5)
    func_D991("ch_gauss_unlock");
}

checkmustangunlockchallenge() {
  if(func_2139("ch_mag_unlock")) {
    return;
  }
  var_00 = 1;
  var_01 = 0;

  foreach(var_05, var_03 in self.killsperweapon) {
    if(!scripts\mp\utility\game::iscacprimaryweapon(var_05) && !scripts\mp\utility\game::iscacsecondaryweapon(var_05)) {
      continue;
    }
    var_04 = scripts\mp\utility\game::getweapongroup(var_05);

    if(var_04 != "weapon_pistol") {
      var_00 = 0;
      break;
    } else
      var_01 = var_01 + var_03;
  }

  if(var_00 && var_01 >= 5)
    func_D991("ch_mag_unlock");
}

checktacburstunlockchallenge() {
  if(func_2139("ch_tacburst_unlock")) {
    return;
  }
  if(isdefined(self.burstfirekills) && self.burstfirekills >= 10)
    func_D991("ch_tacburst_unlock");
}

checkatlasunlockchallenge() {
  if(func_2139("ch_unsalmg_unlock")) {
    return;
  }
  if(isdefined(self.killsperweapon)) {
    var_00 = 0;

    foreach(var_03, var_02 in self.killsperweapon) {
      if(scripts\mp\utility\game::getweaponrootname(var_03) == "iw7_tacburst")
        var_00 = var_00 + var_02;

      if(var_00 >= 10) {
        func_D991("ch_unsalmg_unlock");
        return;
      }
    }
  }
}

func_D378(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!func_B4E8()) {
    return;
  }
  if(!isplayer(self)) {
    return;
  }
  self endon("disconnect");

  if(isdefined(var_01))
    var_01 endon("disconnect");

  func_3BF6(var_00, var_01, var_02, var_03, var_04, var_05);
  wait 0.05;
  scripts\mp\utility\game::func_13842();
  var_06 = spawnstruct();
  var_6.victim = self;
  var_6.einflictor = var_00;
  var_6.attacker = var_01;
  var_6.idamage = var_02;
  var_6.smeansofdeath = var_03;
  var_6.sweapon = var_04;
  var_6.shitloc = var_05;
  func_5914("playerDamaged", var_06);
}

playerkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!func_B4E8()) {
    return;
  }
  if(!isdefined(var_01)) {
    return;
  }
  if(isdefined(var_1.func_A686))
    var_1.func_A686++;

  if(isplayer(var_01) && var_01 issprinting()) {
    if(!isdefined(var_1.func_A687))
      var_1.func_A687 = 1;
    else
      var_1.func_A687++;
  }

  func_3BFF(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08);
  self endon("disconnect");
  var_01 endon("disconnect");
  var_09 = spawnstruct();
  var_9.victim = self;
  var_9.victimid = self getentitynumber();
  var_9.einflictor = var_00;
  var_9.attacker = var_01;
  var_9.idamage = var_02;
  var_9.func_92BE = var_03;
  var_9.smeansofdeath = var_04;
  var_9.sweapon = var_05;
  var_9.sprimaryweapon = var_06;
  var_9.shitloc = var_07;
  var_9.time = gettime();
  var_9.modifiers = var_08;
  var_9.isbulletdamage = scripts\engine\utility::isbulletdamage(var_04);

  if(isdefined(var_05) && issubstr(var_05, "_hybrid")) {
    if(var_01 getcurrentweapon() == var_05)
      var_9.func_9272 = var_01 _meth_812E(var_05);
    else
      var_9.func_9272 = 0;
  }

  var_9.victimonground = var_9.victim isonground();

  if(isplayer(var_01)) {
    var_1.killsthislife[var_1.killsthislife.size] = var_09;

    if(isdefined(var_1.killsthislifeperweapon[var_9.sweapon]))
      var_1.killsthislifeperweapon[var_9.sweapon]++;
    else
      var_1.killsthislifeperweapon[var_9.sweapon] = 1;

    if(!scripts\mp\utility\game::iskillstreakweapon(var_9.sweapon)) {
      if(isdefined(var_1.killsperweapon[var_9.sweapon]))
        var_1.killsperweapon[var_9.sweapon]++;
      else
        var_1.killsperweapon[var_9.sweapon] = 1;
    }

    var_9.func_24EC = isdefined(var_9.attacker.laststand);
    var_9.func_2500 = var_9.attacker isonground();
    var_9.func_250B = var_9.attacker getstance();
    var_9.func_24E4 = var_1.pers["cur_kill_streak"];
    var_9.func_2504 = var_1.func_DDC2;
    var_9.func_2505 = var_1.func_DDC3;
    var_9.attackerarchetype = getsubstr(var_1.loadoutarchetype, 10, var_1.loadoutarchetype.size);
    var_9.attackerkillsthislife = var_1.killsthislife.size;
    var_9.func_24F3 = var_1.killsthislifeperweapon;
    var_9.func_24E3 = var_01 getweaponammoclip(var_05);
    var_9.func_24EB = var_1.func_9074;
    var_9.func_24F8 = var_1.func_A960;
    var_9.func_2503 = var_1.pers["primaryWeapon"];
    var_9.func_2509 = var_1.pers["secondaryWeapon"];
    var_9.func_24F6 = var_1.func_A6B4;
    var_9.func_24F2 = var_1.func_A653;
    var_9.func_24E1 = var_01 scripts\mp\weapons::isstunnedorblinded();
    var_9.func_24E0 = var_1.attackerdata;
    var_9.func_2512 = var_1.func_13CB9;
    var_9.func_24EA = var_1.hasactivesmokegrenade;
    var_9.func_2501 = var_1.personalradaractive;
    var_9.func_2511 = var_1.usedadrenalineatfullhp;
    var_9.func_24F4 = var_1.func_A686;
    var_9.func_24EF = var_01 scripts\mp\utility\game::func_9EE8();
    var_9.func_24F7 = var_1.func_A932;
    var_9.func_250A = length(var_01 getvelocity());
    var_9.func_24FD = var_1.pers["loadoutPerks"];
    var_9.func_24FA = var_1.func_A9DD;
    var_9.func_24FC = var_1.func_A9D3;
    var_9.func_24F9 = var_1.func_A98B;
    var_9.func_24FE = scripts\engine\utility::ter_op(isdefined(var_1.movespeedscaler), var_1.movespeedscaler, 1.0);
    var_9.func_24E9 = var_1.func_6A06;
    var_9.func_250C = var_1.func_1119A;
    var_9.func_24F5 = var_1.func_A687;
    var_9.func_24F1 = var_01 issprinting();
    var_9.func_24E8 = var_01 scripts\mp\supers::getcurrentsuperref();
    var_9.func_250D = var_01 scripts\mp\supers::issuperinuse();
    var_9.func_2506 = var_1.trait;
    var_9.attackersixthsensesource = var_1.sixthsensesource;
    var_9.attackerrelaysource = var_1.relaysource;
    var_9.attackerrearguardattackers = var_1.rearguardattackers;
    var_9.func_2510 = var_1.tookweaponfrom;
    var_9.func_24EE = var_01 getweaponslistall();
    var_9.attackerhassupertrophyout = isdefined(var_1.supertrophies) && var_1.supertrophies.size > 0;
    var_9.attackervisionpulsedvictim = var_01 scripts\mp\supers\super_visionpulse::func_9EF9(var_9.victim);

    if(isdefined(var_1.func_6A06))
      var_1.func_6A06[self.guid] = undefined;

    if(isdefined(var_1.func_1119A))
      var_1.func_1119A[self.guid] = undefined;
  } else {
    var_9.func_24EC = 0;
    var_9.func_2500 = 0;
    var_9.func_250B = "stand";
    var_9.func_24E4 = 0;
    var_9.func_2505 = 0;
    var_9.func_24F3 = [];
    var_9.func_24F2 = [];
    var_9.func_24E1 = 0;
    var_9.func_24E0 = [];
    var_9.func_2512 = [];
    var_9.func_24F4 = 0;
    var_9.func_24FD = [];
    var_9.func_24F5 = 0;
    var_9.func_24F1 = 0;
    var_9.func_24E8 = "";
    var_9.func_250D = 0;
  }

  if(isdefined(var_00)) {
    var_9.func_94B4 = var_0.isstuck;
    var_9.func_94B5 = var_0.owner;
    var_9.func_94B6 = var_0.power;
    var_9.func_94B3 = var_0.damagedby;
    var_9.func_94B7 = var_0.waschained;
    var_9.wasplantedmine = var_0.planted;
  }

  var_9.func_13374 = self.attackerdata;
  var_9.func_13375 = scripts\mp\weapons::isstunnedorblinded();
  var_9.func_13380 = self getstance();
  var_9.func_13376 = self.debuffedbyplayers;
  var_9.func_13384 = scripts\mp\killstreaks\utility::func_9FB9(self.team);
  var_9.func_13385 = self.func_EB6C;
  var_9.func_1337D = func_66B8("specialty_tracker");
  var_9.func_1337B = func_66B8("specialty_sixth_sense");
  var_9.func_13379 = func_66B8("specialty_quieter");
  var_9.func_1337A = var_9.victim scripts\mp\supers::getcurrentsuperref();
  var_9.func_1337C = var_9.victim scripts\mp\supers::issuperinuse();
  var_10 = var_9.victim scripts\mp\supers::getcurrentsuper();

  if(isdefined(var_10))
    var_9.func_13381 = var_10.func_A986;

  var_11 = scripts\mp\domeshield::func_7E80(self);

  if(isdefined(var_11))
    var_9.func_13377 = var_11.owner;

  func_1369C(var_09);
  var_9.attacker notify("playerKilledChallengesProcessed");
}

killstreakdamaged(var_00, var_01, var_02, var_03, var_04) {
  if(!isdefined(var_2.func_A6AE))
    var_2.func_A6AE = [];

  if(isdefined(self.func_1653)) {
    if(!isdefined(var_2.func_A6AE[self.func_1653])) {
      var_05 = spawnstruct();
      var_5.owner = self.owner;
      var_5.func_A6A7 = var_00;
      var_5.func_4D71 = var_04;
      var_2.func_A6AE[self.func_1653] = var_05;
    } else
      var_2.func_A6AE[self.func_1653].func_4D71 = var_2.func_A6AE[self.func_1653].func_4D71 + var_04;
  } else {}
}

killstreakkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  if(!func_B4E8()) {
    return;
  }
  if(isdefined(var_04) && isplayer(var_04) && (!isdefined(var_01) || var_04 != var_01) && isdefined(var_07)) {
    var_09 = scripts\mp\utility\game::getweaponrootname(var_07);

    if(!isdefined(var_4.func_A6B3))
      var_4.func_A6B3 = [];

    if(!isdefined(var_4.func_A6B3[var_09]))
      var_4.func_A6B3[var_09] = 1;
    else
      var_4.func_A6B3[var_09]++;

    if(var_04 func_66B8("specialty_engineer"))
      var_04 func_D991("ch_perk_kills_engineer");

    if(var_4.killsthislife.size > 0)
      var_04 func_D9B8();

    if(scripts\mp\killstreaks\utility::func_9D28(var_00)) {
      if(var_04 func_66B8("specialty_blindeye"))
        var_04 func_D991("ch_perk_kills_blindeye");
    }

    var_10 = var_07;
    var_11 = scripts\mp\utility\game::iskillstreakweapon(var_10);
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = scripts\mp\utility\game::issuperweapon(var_10);
    var_16 = scripts\engine\utility::isbulletdamage(var_06);

    if(var_11) {
      switch (func_7F48(var_10)) {
        case "jackal":
        case "bombardment":
        case "precision_airstrike":
        case "thor":
        case "minijackal":
        case "drone_hive":
          var_12 = 1;
          break;
      }
    }

    switch (var_00) {
      case "precision_airstrike":
      case "drone_hive":
        var_13 = 1;
        break;
      case "directional_uav":
      case "counter_uav":
      case "uav":
        var_04 func_D991("ch_destroy_uav");
        var_13 = 1;
        break;
      case "minijackal":
        var_04 func_D991("ch_destroy_apex");
        var_13 = 1;
        break;
      case "thor":
        if(var_16)
          var_04 func_D991("ch_thor_bullet_kill");

        var_13 = 1;
        break;
      case "bombardment":
        var_13 = 1;
        break;
      case "jackal":
        if(var_16)
          var_04 func_D991("ch_armada_warden_bullet_kill");

        var_13 = 1;
        break;
      case "dronedrop":
        var_04 func_D991("ch_destroy_dronepackage");
        var_13 = 1;
        break;
      case "sentry_shock":
        var_04 func_D991("ch_destroy_sentry");
        var_14 = 1;
        break;
      case "ball_drone_backup":
        var_04 func_D991("ch_destroy_vulture");
        var_14 = 1;
        break;
      case "remote_c8":
        var_04 func_D991("ch_kill_rc8");
        var_14 = 1;
        break;
      case "venom":
        var_04 func_D991("ch_destroy_scarab");
        var_14 = 1;
        break;
    }

    if(var_13)
      var_04 func_D991("ch_destroy_aerial");

    if(var_12 && var_13)
      var_04 func_D991("ch_scorestreak_air_to_air");

    if(var_12 && var_14)
      var_04 func_D991("ch_scorestreak_air_to_ground");

    if(var_15)
      var_04 func_D991("ch_super_scorestreak_kill");

    var_04 func_D9D4(var_09, var_00, var_02);
    var_4.func_A9A8 = gettime();
  }
}

func_D9D4(var_00, var_01, var_02) {
  var_03 = scripts\mp\utility\game::getweapongroup(var_00);

  switch (var_03) {
    case "weapon_projectile":
      func_D9D3(var_00, var_01, var_02);
      break;
  }
}

func_D9D3(var_00, var_01, var_02) {
  switch (var_00) {
    case "iw7_glprox":
      func_D9D6(var_00, var_01, var_02);
      break;
    case "iw7_chargeshot":
      func_D9D5(var_00, var_01, var_02);
      break;
    case "iw7_lockon":
      func_D9D7(var_00, var_01, var_02);
      break;
  }
}

setweaponammostock(var_00, var_01) {
  if(isdefined(self.attackers)) {
    foreach(var_03 in self.attackers) {
      if(self.attackerdata[var_3.guid].damage >= 100) {
        if(!isdefined(scripts\mp\utility\game::_validateattacker(var_03))) {
          continue;
        }
        if(isdefined(self.owner) && self.owner == var_03) {
          continue;
        }
        if(isdefined(self.owner.team) && scripts\mp\utility\game::func_9E05(self.owner.team, var_03)) {
          continue;
        }
        if(var_03 == var_01) {
          continue;
        }
        var_03 thread scripts\mp\utility\game::giveunifiedpoints("vehicle_destroyed_assist");
      }
    }
  }
}

func_1369C(var_00) {
  if(isdefined(var_0.attacker))
    var_0.attacker endon("disconnect");

  self.func_D9A6 = 1;
  wait 0.05;
  scripts\mp\utility\game::func_13842();
  func_5914("playerKilled", var_00);
  self.func_D9A6 = undefined;
}

func_D366(var_00) {
  var_01 = spawnstruct();
  var_1.player = self;
  var_1.victim = var_00;
  var_02 = var_0.attackerdata[self.guid];

  if(isdefined(var_02))
    var_1.sweapon = var_2.weapon;

  func_5914("playerAssist", var_01);
}

func_13079(var_00) {
  self endon("disconnect");
  wait 0.05;
  scripts\mp\utility\game::func_13842();
  var_01 = spawnstruct();
  var_1.player = self;
  var_1.func_A6A7 = var_00;
  func_5914("playerUsedKillstreak", var_01);
}

func_A691(var_00) {
  self endon("disconnect");
  wait 0.05;
  scripts\mp\utility\game::func_13842();
  var_01 = spawnstruct();
  var_1.player = self.owner;
  var_1.func_A6A7 = var_00;
  func_5914("playerKillstreakActive", var_01);
}

func_E75B() {
  func_5914("roundBegin");
}

func_E75D(var_00) {
  var_01 = spawnstruct();

  if(level.teambased) {
    var_02 = "allies";

    for (var_03 = 0; var_03 < level.placement[var_02].size; var_3++) {
      var_1.player = level.placement[var_02][var_03];
      var_1.func_13D8A = var_02 == var_00;
      var_1.func_CBFC = var_03;
      func_5914("roundEnd", var_01);
      var_1.player scripts\mp\contractchallenges::contractmatchend(var_01);
    }

    var_02 = "axis";

    for (var_03 = 0; var_03 < level.placement[var_02].size; var_3++) {
      var_1.player = level.placement[var_02][var_03];
      var_1.func_13D8A = var_02 == var_00;
      var_1.func_CBFC = var_03;
      func_5914("roundEnd", var_01);
      var_1.player scripts\mp\contractchallenges::contractmatchend(var_01);
    }
  } else {
    for (var_03 = 0; var_03 < level.placement["all"].size; var_3++) {
      var_1.player = level.placement["all"][var_03];
      var_1.func_13D8A = isdefined(var_00) && isplayer(var_00) && var_1.player == var_00;
      var_1.func_CBFC = var_03;
      func_5914("roundEnd", var_01);
      var_1.player scripts\mp\contractchallenges::contractmatchend(var_01);
    }
  }
}

func_5914(var_00, var_01) {
  if(!func_B4E8()) {
    return;
  }
  if(isdefined(var_01)) {
    var_02 = var_1.player;

    if(!isdefined(var_02))
      var_02 = var_1.attacker;

    if(isdefined(var_02) && isai(var_02))
      return;
  }

  if(getdvarint("disable_challenges") > 0) {
    return;
  }
  if(!isdefined(level.func_B8CD[var_00])) {
    return;
  }
  if(isdefined(var_01)) {
    for (var_03 = 0; var_03 < level.func_B8CD[var_00].size; var_3++)
      thread[[level.func_B8CD[var_00][var_03]]](var_01);
  } else {
    for (var_03 = 0; var_03 < level.func_B8CD[var_00].size; var_3++)
      thread[[level.func_B8CD[var_00][var_03]]]();
  }
}

func_BA1E() {
  level endon("game_ended");
  self endon("spawned_player");
  self endon("death");
  self endon("disconnect");
  self.func_10ABF = 0;

  for (;;) {
    self waittill("sprint_begin");
    self.func_A9F8 = gettime();
    thread func_BA17();
    thread func_BA18();
  }
}

func_BA1F() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self.func_A687 = 0;
    scripts\engine\utility::waittill_any("sprint_end", "death");
  }
}

func_BA18() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitorSingleSprintMomentumTime()");
  self endon("monitorSingleSprintMomentumTime()");
  self waittill("momentum_max_speed");
  var_00 = gettime();
  self waittill("momentum_reset");

  if(gettime() > var_00 + 5000)
    func_D991("ch_momentum_time");
}

func_B9BA() {
  if(level.gametype != "tdef") {
    return;
  }
  level endon("game_ended");
  self endon("disconnect");
  self.func_6DE0 = 0;

  for (;;) {
    self waittill("ball_grab");
    self.func_6DE0 = 1;
    self waittill("ball_dropped");
    self.func_6DE0 = 0;
  }
}

func_27FA() {
  if(scripts\mp\utility\game::istrue(self.func_6DE0))
    func_D991("ch_keep_away");
}

func_BA17() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitorSingleSprintDistance()");
  self endon("monitorSingleSprintDistance()");
  var_00 = 0.0;
  var_01 = gettime();

  for (;;) {
    var_02 = self.origin;
    var_03 = scripts\engine\utility::waittill_any_timeout(0.1, "sprint_end", "death");
    var_04 = distance(self.origin, var_02);
    var_00 = var_00 + var_04;

    if(var_03 != "timeout" || !self issprinting()) {
      break;
    }
  }

  var_05 = gettime() - var_01;
  var_06 = int(var_05 * 0.35);
  var_00 = int(min(var_00, var_06) / 12);
  func_D991("ch_sprint", var_00);
}

func_B9B4() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_00 = self isonground() && !self iswallrunning();
  var_01 = 0;

  for (;;) {
    if(scripts\mp\utility\game::istrue(level.hostmigration))
      level waittill("host_migration_end");

    if(self isonground() && !self iswallrunning())
      var_00 = 1;
    else {
      if(var_00)
        var_01 = 0;
      else
        var_01 = var_01 + 0.05;

      if(var_01 >= 20) {
        func_D991("ch_stay_in_air");
        return;
      }

      var_00 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

func_BA33() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for (;;) {
    self waittill("used_cosmetic_gesture");
    self.func_A960 = gettime();
  }
}

func_B9D5() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for (;;) {
    self waittill("killed_exploding_drone", var_00);

    if(isdefined(var_00) && var_00 != self)
      func_D991("ch_destroy_explodingdrone");
  }
}

func_BA07() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_00 = [];

  for (;;) {
    self waittill("power_activated", var_01, var_02);

    if(!isdefined(var_0[var_02]))
      var_0[var_02] = 1;
    else
      var_0[var_02]++;

    if(var_02 == "secondary") {
      func_D991("ch_tactical_uses");

      if(func_9EBC(var_0[var_02], 2))
        func_D991("ch_tactical_two_uses");
    }
  }
}

lastmansd() {
  if(!func_B4E8()) {
    return;
  }
  if(!self.wasaliveatmatchstart) {
    return;
  }
  if(self.teamkillsthisround > 0) {
    return;
  }
  processchallenge("ch_lastmanstanding");
}

func_B9C0() {
  self endon("disconnect");

  for (;;) {
    var_00 = scripts\engine\utility::waittill_any_return("bomb_planted", "bomb_defused");

    if(!isdefined(var_00)) {
      continue;
    }
    if(var_00 == "bomb_planted") {
      processchallenge("ch_saboteur");
      continue;
    }

    if(var_00 == "bomb_defused")
      processchallenge("ch_hero");
  }
}

func_B9ED() {
  for (;;) {
    self waittill("spawned_player");
    thread func_112E0();
  }
}

func_112E0() {
  self endon("death");
  self endon("disconnect");
  wait 300;

  if(isdefined(self))
    processchallenge("ch_survivalist");
}

func_B9EF() {
  self endon("death");
  self endon("disconnect");
  self.func_AF2C = [];

  for (;;) {
    self waittill("missile_fire", var_00, var_01);

    if(!isdefined(var_01)) {
      continue;
    }
    var_02 = scripts\mp\utility\game::getweaponrootname(var_01);

    if(var_02 == "iw7_lockon") {
      self.func_AF2C[self.func_AF2C.size] = var_00;

      if(isdefined(self.func_10FAA) && isdefined(self.func_10FA9) && self.func_10FA9 == 2)
        var_0.func_C83D = self.func_10FAA;
    }
  }
}

processchallenge(var_00, var_01, var_02) {}

func_D991(var_00, var_01, var_02) {
  if(!func_D3D6()) {
    return;
  }
  if(!isdefined(var_01))
    var_01 = 1;

  if(!func_8C49(var_00)) {
    if(getdvarint("debug_challenges")) {}

    return;
  }

  if(!func_9D84(var_00)) {
    return;
  }
  var_03 = func_7E22(var_00);

  if(func_2139(var_00)) {
    return;
  }
  var_04 = func_3BF8(var_00);
  var_05 = level.func_3C2C[var_00]["targetval"][var_03];

  if(isdefined(var_02) && var_02)
    var_06 = var_01;
  else
    var_06 = var_04 + var_01;

  var_07 = 0;

  if(var_06 >= var_05) {
    var_08 = 1;
    var_07 = var_06 - var_05;
    var_06 = var_05;
  } else
    var_08 = 0;

  if(var_04 < var_06)
    func_3C05(var_00, var_06);

  if(var_08) {
    thread giverankxpafterwait(var_00, var_03);
    scripts\mp\matchdata::func_AF99(var_00, var_03);
    func_110AE(var_00);
    setturretfov(level.func_3C2C[var_00]["score"][var_03]);
    var_3++;
    func_3C06(var_00, var_03);
    self.func_3C2A[var_00] = var_03;

    if(func_2139(var_00)) {
      thread showchallengesplash(var_00, challengesplasheseachtier(var_00));
      processmasterchallenge(var_00);

      switch (var_00) {
        case "ch_iw7_knife_gold":
        case "ch_iw7_lockon_gold":
        case "ch_iw7_chargeshot_gold":
        case "ch_iw7_glprox_gold":
        case "ch_iw7_emc_gold":
        case "ch_iw7_g18_gold":
        case "ch_iw7_revolver_gold":
        case "ch_iw7_nrg_gold":
          thread func_D991("ch_diamond_melee");
          break;
      }
    } else {
      if(givesmasterprogresseachtier(var_00))
        processmasterchallenge(var_00);

      if(challengesplasheseachtier(var_00))
        thread showchallengesplash(var_00, 1);
    }
  }
}

processmasterchallenge(var_00) {
  var_01 = level.func_3C2C[var_00]["master"];

  if(isdefined(var_01))
    thread func_D991(var_01);
}

func_110AE(var_00) {
  if(!isdefined(self.func_3C30))
    self.func_3C30 = [];

  var_01 = 0;

  foreach(var_03 in self.func_3C30) {
    if(var_03 == var_00)
      var_01 = 1;
  }

  if(!var_01)
    self.func_3C30[self.func_3C30.size] = var_00;
}

giverankxpafterwait(var_00, var_01) {
  self endon("disconnect");

  if(!level.gameended)
    wait 0.25;

  var_02 = "challenge";
  var_03 = undefined;

  if(func_9FFC(var_00))
    var_03 = scripts\mp\utility\game::func_13C75(_meth_8222(var_00));

  var_04 = level.func_3C2C[var_00]["reward"][var_01];
  var_05 = "bonus_challenge_xp";

  if(isdefined(level.prestigeextras[var_05])) {
    if(self getteamdompoints(var_05, "prestigeExtras", 1))
      var_04 = int(var_04 * 1.25);
  }

  scripts\mp\rank::giverankxp(var_02, var_04, var_03);
}

setturretfov(var_00) {
  var_01 = self getrankedplayerdata("mp", "challengeScore");
  self setrankedplayerdata("mp", "challengeScore", var_01 + var_00);
}

func_12E71() {
  self.func_3C2A = [];
  self endon("disconnect");

  if(!func_B4E8()) {
    return;
  }
  var_00 = 0;

  foreach(var_05, var_02 in level.func_3C2C) {
    var_0++;

    if(var_00 % 20 == 0)
      wait 0.05;

    self.func_3C2A[var_05] = 0;
    var_03 = var_2["index"];
    var_04 = func_3BF9(var_05);
    self.func_3C2A[var_05] = var_04;
  }
}

func_7E20(var_00) {
  return tablelookup("mp\allChallengesTable.csv", 0, var_00, 6);
}

func_7E21(var_00) {
  var_01 = tablelookup("mp\allChallengesTable.csv", 0, var_00, 7);

  if(isdefined(var_01) && var_01 == "")
    return undefined;

  return var_01;
}

func_B029(var_00, var_01) {
  return int(tablelookup("mp\allChallengesTable.csv", 0, var_00, 10 + var_01 * 3));
}

func_9F27(var_00) {
  if(!isdefined(var_00))
    return 0;

  var_01 = func_7E20(var_00);

  switch (var_01) {
    case "all_optics":
    case "oscope":
    case "vzscope":
    case "elo":
    case "phase":
    case "reflex":
    case "hybrid":
    case "acog":
    case "noscope":
    case "thermal":
      return 1;
  }

  return 0;
}

isrigcustomizationchallenge(var_00) {
  if(!isdefined(var_00))
    return 0;

  var_01 = func_7E20(var_00);

  if(var_01 == "rig_customization")
    return 1;

  return 0;
}

func_9FFC(var_00) {
  if(!isdefined(var_00))
    return 0;

  var_01 = func_7E20(var_00);

  if(isdefined(var_01)) {
    if(scripts\mp\utility\game::func_13C86(var_01))
      return 1;
  }

  return 0;
}

challengesplasheseachtier(var_00) {
  return func_9FFC(var_00) || isweaponclasschallenge(var_00) || func_9F27(var_00) || isrigcustomizationchallenge(var_00);
}

givesmasterprogresseachtier(var_00) {
  return func_9FFC(var_00) || isweaponclasschallenge(var_00) || func_9F27(var_00) || isrigcustomizationchallenge(var_00);
}

isweaponclasschallenge(var_00) {
  if(!isdefined(var_00))
    return 0;

  var_01 = func_7E20(var_00);

  if(isdefined(var_01)) {
    switch (var_01) {
      case "weapon_all":
      case "weapon_melee":
      case "weapon_pistol":
      case "weapon_projectile":
      case "weapon_shotgun":
      case "weapon_lmg":
      case "weapon_sniper":
      case "weapon_assault":
      case "weapon_smg":
        return 1;
    }
  }

  return 0;
}

_meth_8222(var_00) {
  return func_7E20(var_00);
}

getentitynumber(var_00) {
  return func_7E20(var_00);
}

func_3C27(var_00, var_01, var_02) {
  var_03 = tablelookup(var_00, 0, var_01, 10 + var_02 * 3);
  return int(var_03);
}

func_3C20(var_00, var_01, var_02) {
  var_03 = tablelookup(var_00, 0, var_01, 11 + var_02 * 3);
  return int(var_03);
}

func_3C25(var_00, var_01, var_02) {
  var_03 = tablelookup(var_00, 0, var_01, 12 + var_02 * 3);
  return int(var_03);
}

func_3C18(var_00, var_01) {
  var_02 = tablelookup(var_00, 0, var_01, 8);
  return scripts\engine\utility::ter_op(var_02 == "", undefined, int(var_02));
}

func_3C1C(var_00, var_01) {
  var_02 = tablelookup(var_00, 0, var_01, 9);
  return scripts\engine\utility::ter_op(var_02 == "", undefined, int(var_02));
}

func_31D8(var_00, var_01) {
  var_02 = 0;
  var_03 = 0;
  level.func_3C2D = [];
  var_02 = 0;

  for (;;) {
    var_04 = tablelookupbyrow(var_00, var_02, 0);

    if(var_04 == "") {
      break;
    }
    var_05 = func_7E21(var_04);
    level.func_3C2C[var_04] = [];
    level.func_3C2C[var_04]["index"] = var_02;
    level.func_3C2C[var_04]["type"] = var_01;
    level.func_3C2C[var_04]["targetval"] = [];
    level.func_3C2C[var_04]["reward"] = [];
    level.func_3C2C[var_04]["score"] = [];
    level.func_3C2C[var_04]["filter"] = func_7E20(var_04);
    level.func_3C2C[var_04]["master"] = var_05;

    for (var_06 = 0; var_06 < 8; var_6++) {
      var_07 = func_3C27(var_00, var_04, var_06);

      if(var_07 == 0) {
        break;
      }
      var_08 = func_3C20(var_00, var_04, var_06);
      var_09 = func_3C25(var_00, var_04, var_06);
      level.func_3C2C[var_04]["targetval"][var_06] = var_07;
      level.func_3C2C[var_04]["reward"][var_06] = var_08;
      level.func_3C2C[var_04]["score"][var_06] = var_09;
      var_03 = var_03 + var_08;
    }

    var_10 = func_3C18(var_00, var_04);
    level.func_3C2C[var_04]["displayParam"] = var_10;
    var_11 = func_3C1C(var_00, var_04);
    level.func_3C2C[var_04]["paramScale"] = var_11;

    if(isdefined(var_05)) {
      if(!isdefined(level.func_3C2D[var_05]))
        level.func_3C2D[var_05] = [];

      level.func_3C2D[var_05][level.func_3C2D[var_05].size] = var_04;
    }

    var_2++;
  }

  return int(var_03);
}

validatemasterchallenges() {
  level endon("game_ended");
  wait 1.0;

  foreach(var_06, var_01 in level.func_3C2D) {
    var_02 = 0;

    foreach(var_01 in var_01) {
      if(givesmasterprogresseachtier(var_01)) {
        var_02 = var_02 + level.func_3C2C[var_01]["targetval"].size;
        continue;
      }

      var_02 = var_02 + 1;
    }

    var_05 = level.func_3C2C[var_06]["targetval"][0];
  }
}

func_31D7() {
  level.func_3C2C = [];
  var_00 = 0;
  var_00 = var_00 + func_31D8("mp\allChallengesTable.csv", 0);
}

func_BA08() {
  self endon("disconnect");
  level endon("game_end");

  for (;;) {
    if(!func_B4E8()) {
      return;
    }
    self waittill("process", var_00);
    processchallenge(var_00);
  }
}

func_B9E9() {
  self endon("disconnect");
  level endon("game_end");

  for (;;) {
    self waittill("got_killstreak", var_00);

    if(!isdefined(var_00)) {
      continue;
    }
    if(var_00 == 10 && self.func_A6AB.size == 0) {
      processchallenge("ch_theloner");
      continue;
    }

    if(var_00 == 9) {
      if(isdefined(self.func_A6AB[7]) && isdefined(self.func_A6AB[8]) && isdefined(self.func_A6AB[9]))
        processchallenge("ch_6fears7");
    }
  }
}

func_B9E6() {
  self endon("disconnect");
  level endon("game_end");

  for (;;) {
    self waittill("destroyed_killstreak", var_00);

    if(self getteamdompoints("specialty_blindeye", "perk") && scripts\mp\utility\game::_hasperk("specialty_blindeye"))
      processchallenge("ch_blindeye");
  }
}

func_D39B() {
  var_00 = self getweaponslistprimaries();

  foreach(var_02 in var_00) {
    if(self getweaponammoclip(var_02)) {
      if(!scripts\mp\weapons::isriotshield(var_02) && !scripts\mp\weapons::isknifeonly(var_02))
        return 1;
    }

    var_03 = weaponaltweaponname(var_02);

    if(!isdefined(var_03) || var_03 == "none") {
      continue;
    }
    if(self getweaponammoclip(var_03))
      return 1;
  }

  return 0;
}

monitoradstime() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  var_00 = scripts\mp\utility\game::func_9EE8();
  self.func_A932 = 0;

  for (;;) {
    if(scripts\mp\utility\game::func_9EE8()) {
      if(!var_00) {
        self.func_A932 = gettime();
        var_00 = 1;
      }
    } else
      var_00 = 0;

    wait 0.05;
  }
}

func_B9E0() {
  self endon("disconnect");
  self.func_9074 = 0;

  for (;;) {
    self waittill("hold_breath");
    self.func_9074 = 1;
    self waittill("release_breath");
    self.func_9074 = 0;
  }
}

func_B9F0() {
  self endon("disconnect");
  self.func_B315 = 0;

  for (;;) {
    self waittill("jumped");
    var_00 = self getcurrentweapon();
    scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 1);
    var_01 = self getcurrentweapon();

    if(var_01 == "none")
      self.func_B315 = 1;
    else
      self.func_B315 = 0;

    if(self.func_B315) {
      if(self getteamdompoints("specialty_fastmantle", "perk") && scripts\mp\utility\game::_hasperk("specialty_fastmantle"))
        processchallenge("ch_fastmantle");

      scripts\engine\utility::waittill_notify_or_timeout("weapon_change", 1);
      var_01 = self getcurrentweapon();

      if(var_01 == var_00)
        self.func_B315 = 0;
    }
  }
}

func_BA3B() {
  self endon("disconnect");
  var_00 = self getcurrentweapon();

  for (;;) {
    self waittill("weapon_change", var_01);

    if(var_01 == "none") {
      continue;
    }
    if(var_01 == var_00) {
      continue;
    }
    if(scripts\mp\utility\game::iskillstreakweapon(var_01)) {
      continue;
    }
    if(var_01 == "briefcase_bomb_mp" || var_01 == "briefcase_bomb_defuse_mp") {
      continue;
    }
    var_02 = weaponinventorytype(var_01);

    if(var_02 != "primary") {
      continue;
    }
    self.func_A9D3 = gettime();
  }
}

func_B9DA() {
  self endon("disconnect");

  for (;;) {
    self waittill("flashbang", var_00, var_01, var_02, var_03);

    if(self == var_03) {
      continue;
    }
    self.func_A98A = gettime();
  }
}

func_B9F4() {
  self endon("disconnect");

  for (;;) {
    self waittill("triggeredExpl", var_00);
    thread func_136A2();
  }
}

func_136A2() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait(level.delayminetime + 2);
  processchallenge("ch_delaymine");
}

func_10061(var_00) {
  return self getteamdompoints(var_00, "perk") && scripts\mp\utility\game::_hasperk(var_00);
}

func_D9BF(var_00, var_01) {
  processchallenge("ch_" + var_01);
}

processfinalkillchallenges(var_00, var_01) {
  if(!func_B4E8() || isai(var_00)) {
    return;
  }
  var_00 processchallenge("ch_theedge");

  if(!isai(var_01))
    var_01 processchallenge("ch_starryeyed");

  if(isdefined(var_00) && isdefined(var_0.modifiers) && isdefined(var_0.modifiers["revenge"]))
    var_00 processchallenge("ch_moneyshot");

  if(isdefined(var_01) && isdefined(var_1.explosiveinfo) && isdefined(var_1.explosiveinfo["stickKill"]) && var_1.explosiveinfo["stickKill"])
    var_00 processchallenge("ch_stickman");

  if(isdefined(var_1.attackerdata[var_0.guid]) && isdefined(var_1.attackerdata[var_0.guid].smeansofdeath) && isdefined(var_1.attackerdata[var_0.guid].weapon) && issubstr(var_1.attackerdata[var_0.guid].smeansofdeath, "MOD_MELEE") && scripts\mp\weapons::isriotshield(var_1.attackerdata[var_0.guid].weapon))
    var_00 processchallenge("ch_owned");

  var_02 = var_0.team;

  if(!level.teambased)
    var_02 = "none";

  var_00 func_D991("ch_final_killcam");
}

func_D9C3(var_00, var_01, var_02) {
  if(scripts\mp\utility\game::func_9EE8()) {
    func_D991("ch_" + var_01 + "_kills");

    if(isdefined(var_2.modifiers["headshot"]))
      func_D991("ch_" + var_01 + "_headshots");

    if(isdefined(var_2.modifiers["longshot"]))
      func_D991("ch_" + var_01 + "_longshots");

    if(var_2.func_2504 % 2 == 0)
      func_D991("ch_" + var_01 + "_double_kills");
  }

  if(var_2.func_24E4 > 0 && var_2.func_24E4 % 3 == 0)
    func_D991("ch_" + var_01 + "_streak");
}

func_D9C9(var_00, var_01) {
  func_D991("ch_lifetime_ar_kills");
  func_D991("ch_" + var_00);
  func_3DF9(var_01, "headshot", var_00);
  func_3DF9(var_01, "longshot", var_00);
  func_3E59(var_00, var_1.sweapon);
  func_3DEF(var_00, var_1.sweapon, 0);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);
}

func_D9D1(var_00, var_01) {
  func_D991("ch_lifetime_smg_kills");
  func_D991("ch_" + var_00);
  func_3DF9(var_01, "hipfire", var_00);
  func_3DF9(var_01, "pointblank", var_00);
  func_3DF9(var_01, "sliding", var_00);
  func_3DEF(var_00, var_1.sweapon, 0);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);
}

func_D9CB(var_00, var_01) {
  func_D991("ch_lifetime_lmg_kills");
  func_D991("ch_" + var_00);
  func_3DF9(var_01, "headshot", var_00);

  if(isdefined(var_1.modifiers["hipfire"]))
    func_D991("ch_" + var_00 + "_penetrate");

  func_3E25(var_01, var_00, var_1.sweapon);
  func_3DEF(var_00, var_1.sweapon, 6);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);
}

func_D9CA(var_00, var_01) {
  func_D991("ch_" + var_00);

  if(var_1.func_250B == "crouch")
    processchallenge("ch_" + var_00 + "_crouch");

  func_3DFA(var_01, "defender", var_00);
  func_3DFA(var_01, "longshot", var_00);
  func_3DFA(var_01, "headshot", var_00);
  func_3DFA(var_01, "pointblank", var_00);
  func_3DF8(var_00);
}

func_D9D2(var_00, var_01) {
  func_D991("ch_lifetime_sniper_kills");
  func_D991("ch_" + var_00);
  func_3DF9(var_01, "headshot", var_00);
  func_3DF9(var_01, "longshot", var_00);

  if(var_1.func_24EB)
    func_D991("ch_" + var_00 + "_holdbreath");

  func_3DEF(var_00, var_1.sweapon, 6);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);

  if(scripts\mp\utility\game::istrue(var_1.modifiers["pointblank"]))
    func_D991("ch_point_blank_sniper");
}

func_D9D0(var_00, var_01) {
  func_D991("ch_lifetime_shotgun_kills");
  func_D991("ch_" + var_00);
  func_3DF9(var_01, "hipfire", var_00);
  func_3DF9(var_01, "pointblank", var_00);
  func_3DF9(var_01, "sliding", var_00);
  func_3DEF(var_00, var_1.sweapon, 0);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);
}

func_D9CF(var_00, var_01) {
  func_D991("ch_" + var_00);
}

func_D9CD(var_00, var_01) {
  func_D991("ch_lifetime_pistol_kills");
  func_D991("ch_" + var_00);
  func_3DF9(var_01, "headshot", var_00);
  func_3DF9(var_01, "pointblank", var_00);

  if(!func_3E17(var_01))
    func_D991("ch_" + var_00 + "_pistol_only");

  func_3DEF(var_00, var_1.sweapon, 5);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);
  var_02 = scripts\mp\utility\game::getweaponrootname(var_1.sweapon);

  if(var_02 == "iw7_mag" && isdefined(var_1.modifiers["hipfire"])) {
    if(!isdefined(self.hipfiremagkills))
      self.hipfiremagkills = 1;
    else
      self.hipfiremagkills++;
  }
}

func_D9CE(var_00, var_01) {
  switch (var_00) {
    case "iw7_glprox":
      func_D9C6(var_00, var_01);
      break;
    case "iw7_chargeshot":
      func_D9C5(var_00, var_01);
      break;
    case "iw7_lockon":
      func_D9C7(var_00, var_01);
      break;
  }
}

func_D9C6(var_00, var_01) {
  func_D991("ch_iw7_glprox");

  if(var_1.smeansofdeath == "MOD_IMPACT" || var_1.smeansofdeath == "MOD_GRENADE")
    func_D991("ch_iw7_glprox_direct");

  func_3E2B(var_1.sweapon, var_01, var_00, 2);

  if(!func_3E17(var_01))
    func_D991("ch_iw7_glprox_no_primary");

  if(isdefined(var_1.victim)) {
    if(distancesquared(var_1.victim.origin, self.origin) > 1440000)
      func_D991("ch_iw7_glprox_long_range");
  }

  func_3DFE(var_1.sweapon, var_01, var_00, 3);
}

func_D9D6(var_00, var_01, var_02) {
  func_D991("ch_iw7_glprox_kill_streak");
}

func_D9C5(var_00, var_01) {
  func_D991("ch_iw7_chargeshot_kill");
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3E4D(var_00);
}

func_D9D5(var_00, var_01, var_02) {
  func_D991("ch_iw7_chargeshot");
  func_D991("ch_iw7_chargeshot_kill_streak_points", scripts\mp\killstreaks\killstreaks::getstreakcost(var_01));

  if(isdefined(self.func_A9A8) && gettime() - self.func_A9A8 < 10000)
    func_D991("ch_iw7_chargeshot_streak_double");

  if(isdefined(self.func_A6B3) && isdefined(self.func_A6B3[var_00]) && func_9EBC(self.func_A6B3[var_00], 3))
    func_D991("ch_iw7_chargeshot_kill_3_streaks");

  func_3E4D(var_00);
}

func_D9C7(var_00, var_01) {
  func_D991("ch_iw7_lockon_kill");
  func_3E4D(var_00);
}

func_D9D7(var_00, var_01, var_02) {
  func_D991("ch_iw7_lockon");
  func_D991("ch_iw7_lockon_kill_streak_points", scripts\mp\killstreaks\killstreaks::getstreakcost(var_01));
  var_03 = undefined;
  var_04 = 0;

  foreach(var_06 in self.func_AF2C) {
    if(isdefined(var_06)) {
      var_07 = distancesquared(var_6.origin, var_2.origin);

      if(!isdefined(var_03) || var_04 > var_07) {
        var_03 = var_06;
        var_04 = var_07;
      }
    }
  }

  if(isdefined(var_03) && !isdefined(var_3.func_C83D))
    func_D991("ch_iw7_lockon_no_lock_on");

  if(isdefined(self.func_A9A8) && gettime() - self.func_A9A8 < 10000)
    func_D991("ch_iw7_lockon_streak_double");

  if(isdefined(self.func_A6B3) && isdefined(self.func_A6B3[var_00]) && func_9EBC(self.func_A6B3[var_00], 3))
    func_D991("ch_iw7_lockon_kill_3_streaks");

  func_3E4D(var_00);
}

func_D9CC(var_00, var_01) {
  func_D991("ch_" + var_00);

  if(isdefined(var_1.modifiers["backstab"]))
    func_D991("ch_" + var_00 + "_backstab");
  else
    func_D991("ch_" + var_00 + "_frontstab");

  if(!func_3E17(var_01))
    func_D991("ch_" + var_00 + "_melee_only");

  func_3DF9(var_01, "sliding", var_00);
  func_3E2B(var_1.sweapon, var_01, var_00, 2);
  func_3DFE(var_1.sweapon, var_01, var_00, 3);
}

processweaponchallenge_axemelee(var_00, var_01) {
  var_02 = "alt_" + var_1.sweapon;
  func_D991("ch_iw7_axe");

  if(isdefined(var_1.modifiers["backstab"]))
    func_D991("ch_" + var_00 + "_backstab");

  checkaxecombochallenge(var_01, var_1.sweapon, var_02);
  checkaxemultikillchallenge(var_01, var_1.sweapon, var_02);
  checkaxeconsecutivechallenge(var_01, var_1.sweapon, var_02);
}

processweaponchallenge_axethrow(var_00, var_01) {
  var_02 = scripts\mp\utility\game::func_E0CF(var_1.sweapon);
  func_D991("ch_iw7_axe_frontstab");

  if(isdefined(var_1.modifiers["backstab"]))
    func_D991("ch_" + var_00 + "_backstab");

  var_03 = var_1.func_24F3[var_1.sweapon];

  if(isdefined(var_03) && func_9EBC(var_03, 2))
    func_D991("ch_iw7_axe_melee_only");

  checkaxecombochallenge(var_01, var_02, var_1.sweapon);
  checkaxemultikillchallenge(var_01, var_02, var_1.sweapon);
  checkaxeconsecutivechallenge(var_01, var_02, var_1.sweapon);
}

checkaxecombochallenge(var_00, var_01, var_02) {
  var_03 = var_0.func_24F3[var_01];
  var_04 = var_0.func_24F3[var_02];

  if(var_0.sweapon == var_01) {
    var_05 = isdefined(var_03) && var_03 == 1;
    var_06 = isdefined(var_04) && var_04 > 0;

    if(var_05 && var_06) {
      func_D991("ch_iw7_axe_sliding");
      return;
    }
  } else if(var_0.sweapon == var_02) {
    var_07 = isdefined(var_04) && var_04 == 1;
    var_08 = isdefined(var_03) && var_03 > 0;

    if(var_07 && var_08) {
      func_D991("ch_iw7_axe_sliding");
      return;
    }
  } else {}
}

checkaxemultikillchallenge(var_00, var_01, var_02) {
  var_03 = 0;

  if(isdefined(var_0.func_2505[var_01]))
    var_03 = var_03 + var_0.func_2505[var_01];

  if(isdefined(var_0.func_2505[var_02]))
    var_03 = var_03 + var_0.func_2505[var_02];

  if(isdefined(var_03) && func_9EBC(var_03, 2))
    func_D991("ch_iw7_axe_2multikill");
}

checkaxeconsecutivechallenge(var_00, var_01, var_02) {
  var_03 = 0;

  if(isdefined(var_0.func_24F3[var_01]))
    var_03 = var_03 + var_0.func_24F3[var_01];

  if(isdefined(var_0.func_24F3[var_02]))
    var_03 = var_03 + var_0.func_24F3[var_02];

  if(isdefined(var_03) && func_9EBC(var_03, 3))
    func_D991("ch_iw7_axe_3streak");
}

func_3DF9(var_00, var_01, var_02) {
  if(isdefined(var_0.modifiers[var_01]))
    func_D991("ch_" + var_02 + "_" + var_01);
}

func_3DFA(var_00, var_01, var_02) {
  if(isdefined(var_0.modifiers[var_01]))
    processchallenge("ch_" + var_02 + "_" + var_01);
}

func_3DF8(var_00) {
  if(self _meth_81AA())
    processchallenge("ch_" + var_00 + "_leaning");
}

func_3E32(var_00, var_01) {
  if(var_0.func_92BE & level.idflags_penetration)
    processchallenge("ch_" + var_01 + "_penetrate");
}

func_3E31(var_00, var_01) {
  if(var_0.func_92BE & level.idflags_penetration)
    func_D991("ch_" + var_01 + "_penetrate");
}

func_3DFE(var_00, var_01, var_02, var_03) {
  var_04 = var_1.func_24F3[var_00];

  if(isdefined(var_04) && func_9EBC(var_04, var_03))
    func_D991("ch_" + var_02 + "_" + var_03 + "streak");
}

func_3E5F() {
  var_00 = self getcurrentweapon();

  if(scripts\mp\weapons::isriotshield(var_00))
    return 1;
  else {
    var_01 = scripts\engine\utility::getlastweapon();
    return scripts\mp\weapons::isriotshield(var_01);
  }
}

func_3DE3(var_00, var_01, var_02) {
  if(isdefined(var_02)) {
    if(isdefined(level.func_C321) && isdefined(level.func_C321["odin_assault"]) && (var_02 == level.func_C321["odin_assault"].weapon["large_rod"].projectile || var_02 == level.func_C321["odin_assault"].weapon["small_rod"].projectile)) {
      var_00 processchallenge("ch_shooting_star");
      return 1;
    } else if(var_02 == "aamissile_projectile_mp")
      var_00 processchallenge("ch_air_superiority");
  }

  var_00 processchallenge("ch_clearskies");
  return 0;
}

func_3DFF(var_00, var_01) {
  if(!isai(var_00)) {
    var_02 = var_00 scripts\mp\teams::getplayermodelindex();
    var_03 = var_00 scripts\mp\teams::getplayermodelname(var_02);
    return var_03 == var_01;
  }

  return 0;
}

func_3E59(var_00, var_01) {
  if(scripts\mp\utility\game::istrue(self.modifiers["ads"])) {
    var_02 = getweaponattachments(var_01);

    foreach(var_04 in var_02) {
      var_05 = scripts\mp\weapons::func_248C(var_04);

      if(var_05 == "rail") {
        var_06 = scripts\mp\utility\game::attachmentmap_tobase(var_04);

        if(scripts\mp\weapons::func_9F3C(var_00, var_06)) {
          func_D991("ch_" + var_00 + "_optic");
          break;
        }
      }
    }
  }
}

func_3E2B(var_00, var_01, var_02, var_03) {
  if(isdefined(var_1.func_2505[var_00])) {
    var_04 = var_1.func_2505[var_00];

    if(isdefined(var_04) && func_9EBC(var_04, var_03))
      func_D991("ch_" + var_02 + "_" + var_03 + "multikill");
  }
}

func_3DEF(var_00, var_01, var_02) {
  var_03 = 0;

  foreach(var_05 in getweaponattachments(var_01)) {
    var_06 = scripts\mp\utility\game::attachmentmap_tobase(var_05);

    if(scripts\mp\weapons::func_9F3C(var_00, var_06))
      var_3++;
  }

  if(var_03 == var_02)
    func_D991("ch_" + var_00 + "_" + var_02 + "attachments");
}

func_3E25(var_00, var_01, var_02) {
  if(!isdefined(var_0.func_24E3)) {
    return;
  }
  var_03 = var_0.func_24E3;
  var_04 = weaponclipsize(var_02);

  if(var_03 <= var_04 * 0.15)
    func_D991("ch_" + var_01 + "_lastshots");
}

func_3E17(var_00) {
  if(isdefined(var_0.func_24EE)) {
    foreach(var_02 in var_0.func_24EE) {
      if(scripts\mp\utility\game::iscacprimaryweapon(var_02))
        return 1;
    }
  }

  return 0;
}

func_3E4D(var_00) {
  if(isdefined(self.killsthislife) && isdefined(self.func_A6B4)) {
    if(self.killsthislife.size > 0 && self.func_A6B4.size > 0 && !scripts\mp\utility\game::istrue(self.func_110E6[var_00])) {
      func_D991("ch_" + var_00 + "_combo");
      self.func_110E6[var_00] = 1;
    }
  }
}

func_D994(var_00, var_01) {
  foreach(var_03 in level.players) {
    if(var_3.team == var_01)
      var_03 processchallenge(var_00);
  }
}

func_9D84(var_00) {
  var_01 = level.func_3C2C[var_00]["filter"];

  if(!isdefined(var_01))
    return 1;

  return self getteamdompoints(var_01, "challenge") && self getteamdompoints(var_00, "challenge");
}

func_8C49(var_00) {
  return isdefined(level.func_3C2C) && isdefined(level.func_3C2C[var_00]);
}

allowinteractivecombat(var_00, var_01) {
  return 0;
}

func_3E2D(var_00, var_01) {
  var_02 = self.pers[var_00];
  return func_9EBC(var_02, var_01);
}

func_9EBC(var_00, var_01) {
  return var_00 > 0 && var_00 % var_01 == 0;
}

func_8C0E() {
  if(isdefined(self.pers["loadoutPerks"]))
    return self.pers["loadoutPerks"].size == 0;

  return 1;
}

func_9D83(var_00) {
  if(!func_D3D6())
    return 0;

  if(func_2139(var_00))
    return 0;

  return 1;
}

func_2139(var_00) {
  if(self.func_3C2A[var_00] >= level.func_3C2C[var_00]["targetval"].size)
    return 1;

  return 0;
}

func_D9B8() {
  if(scripts\mp\utility\game::istrue(self.func_110E5)) {
    return;
  }
  func_D991("ch_streak_player_kill");
  self.func_110E5 = 1;
}

func_9E8A(var_00) {
  switch (var_00) {
    case "right_foot":
    case "right_leg_lower":
    case "right_leg_upper":
    case "left_foot":
    case "left_leg_lower":
    case "left_leg_upper":
      return 1;
  }

  return 0;
}

func_D3A8(var_00, var_01) {
  if(!isdefined(var_01)) {
    return;
  }
  var_02 = scripts\engine\utility::ter_op(isplayer(var_01), var_01, var_1.owner);

  if(!isdefined(var_02) || !isplayer(var_02)) {
    return;
  }
  if(isdefined(var_0.debuffedbyplayers) && isdefined(var_0.debuffedbyplayers["cryo_mine_mp"]) && var_0.debuffedbyplayers["cryo_mine_mp"].size > 0)
    var_02 func_D991("ch_plasma_cryo_combo");
}

minedestroyed(var_00, var_01, var_02) {
  if(!isdefined(var_01) || !isplayer(var_01)) {
    return;
  }
  if(isdefined(var_0.weapon_name) && var_0.weapon_name == "c4_mp") {
    if(var_0.owner != var_01 && !scripts\mp\utility\game::istrue(var_0.planted) && scripts\engine\utility::isbulletdamage(var_02))
      var_01 func_D991("ch_c4_air_kill");
  }
}

func_2AEA(var_00, var_01, var_02) {
  if(var_0.disttravelled >= 1300)
    var_01 func_D991("ch_biospike_longrange");
}

func_BA0B() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self.func_A686 = 0;

  for (;;) {
    self waittill("reload");
    self.func_A9DD = gettime();
    self.func_A686 = 0;
  }
}

func_C5A8(var_00) {
  if(!func_B4E8()) {
    return;
  }
  if(isdefined(self.consecutivehitsperweapon) && isdefined(self.consecutivehitsperweapon[var_00])) {
    if(func_9EBC(self.consecutivehitsperweapon[var_00], 5) && scripts\mp\utility\game::weaponhasattachment(var_00, "grip"))
      func_D991("ch_grip_accuracy");
  }
}

func_BA29() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("super_earned");

    if(!scripts\mp\utility\game::gameflag("prematch_done")) {
      continue;
    }
    if(func_66B8("specialty_overclock")) {
      func_D991("ch_perk_overclock");

      if(self.pers["supersEarned"] % 5 == 0)
        func_D991("ch_overclock_unlocked");
    }
  }
}

func_66B8(var_00) {
  if(!scripts\mp\utility\game::_hasperk(var_00) || !scripts\mp\perks::func_9EDF(var_00))
    return 0;

  return 1;
}

resistedstun(var_00) {
  if(!isdefined(var_00) || !isplayer(var_00)) {
    return;
  }
  self.func_1119A[var_0.guid] = 1;
}

func_B9D4() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  for (;;) {
    self waittill("destroyed_equipment");
    func_D991("ch_destroy_items");

    if(func_66B8("specialty_engineer"))
      func_D991("ch_perk_kills_engineer");
  }
}

func_127BC() {
  func_D991("ch_engineer_explosion_delay");
}

func_B9CE() {
  level endon("game_ended");
  self endon("disconnect");

  for (;;) {
    self waittill("earned_award_buffered", var_00);
    var_01 = 0;
    var_02 = 0;
    var_03 = 0;
    var_04 = 0;
    var_05 = 0;

    switch (var_00) {
      case "mode_ctf_kill_with_flag":
      case "mode_uplink_kill_with_ball":
      case "mode_sd_defuse_save":
      case "mode_x_assault":
        var_01 = 1;
        break;
      case "mode_sd_plant_save":
      case "mode_x_defend":
        var_02 = 1;
        break;
      case "mode_ctf_kill_carrier":
      case "mode_uplink_kill_carrier":
        var_02 = 1;
        var_04 = 1;
        break;
      case "mode_siege_secure":
      case "mode_ctf_cap":
      case "mode_uplink_fieldgoal":
      case "mode_uplink_dunk":
      case "mode_hp_secure":
      case "mode_dom_secure":
      case "mode_dom_secure_neutral":
      case "mode_dom_secure_b":
      case "mode_sd_detonate":
        var_03 = 1;
        break;
      case "mode_sd_defuse":
      case "mode_sd_last_defuse":
        var_03 = 1;
        var_05 = 1;
        break;
    }

    if(var_01)
      func_D991("ch_kill_defenders");

    if(var_02)
      func_D991("ch_kill_attackers");

    if(var_03)
      func_D991("ch_objectives");

    if(var_05)
      func_D991("ch_defuse");

    if(var_04)
      func_D991("ch_kill_carrier");
  }
}