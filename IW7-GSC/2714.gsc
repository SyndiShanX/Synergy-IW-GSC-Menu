/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2714.gsc
***************************************/

callback_playerdamage_internal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12) {
  if(isdefined(var_01) && var_1.classname == "worldspawn")
    var_01 = undefined;

  if(isdefined(var_01) && isdefined(var_1.gunner))
    var_01 = var_1.gunner;

  if(!scripts\mp\utility\game::gameflag("prematch_done"))
    return "finished";

  var_14 = gettime();
  var_15 = var_2.health;

  if(isplayer(var_02)) {
    var_2.func_AA47 = var_02 getcurrentweapon();
    var_2.func_13905 = var_02 scripts\mp\utility\game::func_9EE8();

    if(var_2.func_13905)
      var_2.func_A98B = gettime();
  }

  if(!level.tactical)
    var_04 = var_04 | level.idflags_no_knockback;

  if(func_B4CA(var_02, var_01, var_06)) {
    return;
  }
  if(var_05 == "MOD_FALLING" && isdefined(var_2.func_115FC) && var_2.func_115FC)
    var_01 = var_2.func_115FD;

  var_16 = 0.0;

  if(var_04 & level.idflags_stun) {
    var_16 = 0.0;
    var_03 = 0;
  }

  var_17 = filterdamage(var_00, var_01, var_02, var_03, var_05, var_06, var_09);

  if(isdefined(var_17))
    return var_17;

  var_18 = scripts\mp\utility\game::attackerishittingteam(var_02, var_01);

  if(var_18) {
    var_03 = handlefriendlyfiredamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_16, var_11, var_12);

    if(var_03 == 0)
      return;
  }

  if(scripts\mp\utility\game::istrue(var_2.spawnprotection)) {
    var_19 = isdefined(var_1.classname) && var_1.classname == "trigger_hurt";

    if(!var_19) {
      handledamagefeedback(var_00, var_01, var_02, 0, var_05, var_06, var_09, var_04, 1, 1);
      return "finished";
    }
  }

  var_20 = scripts\mp\utility\game::getequipmenttype(var_06);

  if(isdefined(var_20)) {
    if(var_20 == "lethal")
      var_03 = lethalequipmentdamagemod(var_00, var_01, var_02, var_03, var_04, var_05, var_06);
    else if(var_20 == "equipment_other") {
      if(var_06 == "bouncingbetty_mp") {
        if(!scripts\mp\weapons::minedamageheightpassed(var_00, var_02))
          var_03 = 0;
        else if(var_02 getstance() == "crouch" || var_02 getstance() == "prone")
          var_03 = int(var_03 / 2);
      }

      if(var_06 == "portal_grenade_mp" && var_03 != 400)
        var_02 thread scripts\mp\equipment\portal_grenade::func_D68E(var_00, var_01);
    }
  }

  var_21 = scripts\mp\utility\game::_meth_8238(var_06);

  if(var_21 == "killstreak") {
    var_03 = killstreakdamagefilter(var_01, var_02, var_03, var_06, var_05);

    if(var_03 == 0) {
      return;
    }
    if(var_06 == "killstreak_jammer_mp")
      return "sWeapon == killstreak_jammer_mp";

    if(isdefined(level.ac130player) && isdefined(var_01) && level.ac130player == var_01)
      level notify("ai_pain", var_02);
  }

  var_03 = modifydamagegeneral(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
  var_03 = handleriotshieldhits(var_00, var_02, var_01, var_03, var_05, var_06, var_07, var_08, var_09, var_04);

  if(isstring(var_03))
    return var_03;

  if(scripts\mp\utility\game::func_9EF0(var_02)) {
    var_03 = var_02 scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_01, var_06, var_05, var_03, var_2.maxhealth, 3, 4, 6, 0);

    if(isdefined(var_01) && isplayer(var_01) && scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01))
      var_03 = 0;
  }

  if(isplayer(var_01))
    var_01 scripts\mp\perks\weaponpassives::func_3E01();

  var_22 = func_3696(var_02, var_01, var_03, var_05, var_06, var_07, var_08, var_09, var_00, 0, var_04);
  var_03 = var_22[0];
  var_23 = var_22[1];
  var_24 = var_22[2];
  var_25 = var_23 != 0 || var_24 != 0;
  var_09 = var_22[3];

  if(isdefined(var_2.forcehitlocation))
    var_09 = var_2.forcehitlocation;

  scripts\mp\perks\perkfunctions::bulletoutlinecheck(var_01, var_02, var_06, var_05);

  if(var_03 >= var_2.health && scripts\engine\utility::string_starts_with(var_06, "iw7_penetrationrail_mp") && var_05 != "MOD_MELEE" || var_03 >= var_2.health && scripts\engine\utility::string_starts_with(var_06, "iw7_nunchucks_mpl") && var_05 == "MOD_MELEE") {
    var_26 = scripts\mp\weapons::impale_endpoint(var_07, var_08);
    var_27 = scripts\mp\weapons::trace_impale(var_07, var_26);

    if(var_27["hittype"] != "hittype_world") {
      var_28 = (var_8[0], var_8[1], var_8[2]);

      if(var_28[2] > -0.3 && var_28[2] < 0.1) {
        var_28 = (var_28[0], var_28[1], 0.1);
        vectornormalize(var_28);
      }

      var_02 _meth_84DC(var_28, 650.0);
    }
  }

  if(isai(self))
    self[[level.bot_funcs["on_damaged"]]](var_01, var_03, var_05, var_06, var_00, var_09);

  if(isplayer(var_01) && (var_06 == "smoke_grenade_mp" || var_06 == "throwingknife_mp" || var_06 == "throwingknifeteleport_mp" || var_06 == "throwingknifesmokewall_mp" || var_06 == "gas_grenade_mp" || var_06 == "throwingreaper_mp"))
    var_01 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_06, 1, "hits");

  if(var_05 == "MOD_FALLING")
    var_02 thread func_612A(var_03);

  if(!isdefined(var_08))
    var_04 = var_04 | level.idflags_no_knockback;

  if(isdefined(var_01) && var_1.classname == "script_origin" && isdefined(var_1.type) && var_1.type == "soft_landing")
    return "soft_landing";

  logattacker(var_02, var_01, var_00, var_06, var_03, var_07, var_08, var_09, var_10, var_05);

  if(isdefined(var_00) && isdefined(var_0.owner) && var_0.owner.team != var_2.team)
    var_2.lastdamagewasfromenemy = 1;
  else
    var_2.lastdamagewasfromenemy = isdefined(var_01) && var_01 != var_02;

  if(var_2.lastdamagewasfromenemy) {
    var_29 = gettime();
    var_1.damagedplayers[var_2.guid] = var_29;
    var_2.lastdamagedtime = var_29;
  }

  var_02 func_12EFD(var_03, var_01, var_09, var_05);

  if(scripts\mp\codcasterclientmatchdata::shouldlogcodcasterclientmatchdata()) {
    if(isplayer(var_01)) {
      var_30 = scripts\mp\codcasterclientmatchdata::getcodcasterplayervalue(var_01, "damageDone");
      scripts\mp\codcasterclientmatchdata::setcodcasterplayervalue(var_01, "damageDone", var_30 + var_03);
    }
  }

  var_02 thread scripts\mp\missions::func_D378(var_00, var_01, var_03, var_05, var_06, var_09);

  if(isdefined(var_01) && var_03 != 0) {
    var_01 notify("victim_damaged", var_02, var_00, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
    var_01 scripts\mp\contractchallenges::contractplayerdamaged(var_03);
  }

  var_31 = var_08;

  if(isdefined(var_04) && var_04 & level.idflags_no_team_protection && var_03 < self.health)
    var_31 = var_2.origin - var_1.origin;

  var_02 finishplayerdamagewrapper(var_00, var_01, var_03, var_04, var_05, var_06, var_07, var_31, var_09, var_10, var_16, var_11, var_12, var_25);

  if(var_03 > 10 && isdefined(var_00) && !var_02 scripts\mp\utility\game::isusingremote() && isplayer(var_02)) {
    var_02 thread scripts\mp\shellshock::bloodeffect(var_0.origin);

    if(isplayer(var_00) && var_05 == "MOD_MELEE") {
      if(isalive(var_02) && !var_02 scripts\mp\utility\game::_hasperk("specialty_stun_resistance")) {
        var_02 thread func_B645(0.75);
        var_2.func_904B = gettime();
      }

      var_00 thread scripts\mp\shellshock::func_2BC3(var_06);
      var_02 playrumbleonentity("defaultweapon_melee");
      var_00 playrumbleonentity("defaultweapon_melee");
    }
  }

  if(isagent(self)) {
    if(scripts\mp\utility\game::func_9EF0(self)) {
      if(var_03 >= self.health) {
        var_03 = self.health - 1;

        if(isdefined(self.owner))
          self.owner notify("player_killstreak_agent_death", self, var_00, var_01, var_03, var_04, var_05, var_06);
      } else {
        self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_00, var_01, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);

        if(self.func_165A == "remote_c8") {
          if(isdefined(self.owner) && isdefined(self.owner.func_4BE1) && self.owner.func_4BE1 == "MANUAL")
            self setclientomnvar("ui_remote_c8_health", self.health / self.maxhealth);
        }
      }
    } else
      self[[scripts\mp\agents\agent_utility::agentfunc("on_damaged_finished")]](var_00, var_01, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
  }

  handledamagefeedback(var_00, var_01, var_02, var_03, var_05, var_06, var_09, var_04, var_23, var_24);
  scripts\mp\gamelogic::sethasdonecombat(var_02, 1);

  if(isdefined(var_01) && var_01 != var_02)
    level.usestartspawns = 0;

  if(isplayer(var_01) && isdefined(var_1.pers["participation"]))
    var_1.pers["participation"]++;
  else if(isplayer(var_01))
    var_1.pers["participation"] = 1;

  if(isdefined(level.matchrecording_logeventmsg) && isplayer(var_02) && isdefined(var_00) && isplayer(var_00) && scripts\engine\utility::isbulletdamage(var_05)) {
    if(var_15 == var_2.maxhealth && var_2.health != self.maxhealth)
      var_2.engagementstarttime = gettime();
  }

  if(allowdamageflash(var_01, var_02, var_06, var_05, var_03))
    var_02 showuidamageflash();

  if(isdefined(var_01) && var_01 scripts\mp\utility\game::_hasperk("specialty_mark_targets") && var_03 > 0)
    var_01 thread scripts\mp\perks\perk_mark_targets::marktarget_run(var_02, var_05);

  return "finished";
}

func_B645(var_00) {
  self endon("death");
  self endon("disconnect");
  var_01 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.sort = 1;
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.foreground = 1;
  var_01 setshader("black", 640, 480);
  thread monitormeleeoverlay(var_01);
  self shellshock("melee_mp", var_00);
  self earthquakeforplayer(0.35, 0.5, self.origin, 100);
  self setclientomnvar("ui_hud_shake", 1);
  var_01 fadeovertime(0.1);
  var_1.alpha = 0.2;
  wait 0.1;
  var_01 fadeovertime(0.3);
  var_1.alpha = 0.4;
  wait 0.3;
  var_01 fadeovertime(0.6);
  var_1.alpha = 0.0;
}

monitormeleeoverlay(var_00) {
  scripts\engine\utility::waittill_any_timeout(2.0, "death", "disconnect");
  var_00 destroy();
}

allowdamageflash(var_00, var_01, var_02, var_03, var_04) {
  if(var_04 == 0)
    return 0;

  if(suppressdamageflash(var_00, var_01, var_02, var_03, var_04))
    return 0;

  return 1;
}

suppressdamageflash(var_00, var_01, var_02, var_03, var_04) {
  if(isdefined(var_02)) {
    switch (var_02) {
      case "super_trophy_mp":
        return scripts\mp\supers\super_supertrophy::func_11286(var_00, var_01, var_02, var_03, var_04);
    }
  }

  return 0;
}

func_3696(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(isplayer(var_00) && (var_00 _meth_8568() || var_00 _meth_8569()))
    return [0, 0, 0, var_07];

  var_00 notify("damage_begin", var_01);
  var_11 = 0;
  var_12 = 0;

  if(var_00 scripts\mp\utility\game::isjuggernaut()) {
    var_12 = level.func_A4A7;

    if(isdefined(self.isjuggernautmaniac) && self.isjuggernautmaniac)
      var_12 = level.func_A4A6;
  }

  if(scripts\engine\utility::isbulletdamage(var_03)) {
    if(isdefined(var_04) && (scripts\mp\utility\game::iscacprimaryweapon(var_04) || scripts\mp\utility\game::iscacsecondaryweapon(var_04))) {
      if(isbehindmeleevictim(var_01, var_00) && isplayer(var_00))
        level thread scripts\mp\battlechatter_mp::saytoself(var_00, "plr_hit_back", undefined, 0.1);

      if(isdefined(var_1.func_C7E6) && var_1.func_C7E6)
        var_11 = var_11 + var_02 * 0.3;
    }

    if(isdefined(var_04) && issubstr(var_04, "iw7_gauss_mpl")) {
      var_13 = scripts\mp\utility\game::weaponhasattachment(var_04, "barrelrange");
      var_14 = scripts\engine\utility::ter_op(var_13, 2073600, 1440000);
      var_15 = scripts\engine\utility::ter_op(var_13, 5760000, 4000000);

      if(distance2dsquared(var_0.origin, var_1.origin) < var_14 && var_02 >= 70 || distance2dsquared(var_0.origin, var_1.origin) < var_15 && var_02 >= 54 || distance2dsquared(var_0.origin, var_1.origin) >= var_15 && var_02 >= 42)
        var_0.hitbychargedshot = var_01;
    }

    if(isdefined(var_04) && issubstr(var_04, "iw7_ba50cal_mpl_overkill")) {
      if(var_02 >= 200)
        var_0.hitbychargedshot = var_01;
    }

    if(isdefined(var_10) && var_10 & level.idflags_no_team_protection) {
      var_16 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_04);

      if(var_16 != "none" && !scripts\mp\utility\game::issuperweapon(var_16))
        var_02 = var_02 * 0.4;
    }

    if(scripts\mp\utility\game::isfmjdamage(var_04, var_03))
      var_12 = var_12 * level.armorpiercingmod;

    if(isplayer(var_01) && var_01 scripts\mp\utility\game::_hasperk("specialty_paint_pro") && !scripts\mp\utility\game::iskillstreakweapon(var_04)) {
      if(!var_00 scripts\mp\perks\perkfunctions::ispainted())
        var_01 scripts\mp\missions::processchallenge("ch_bulletpaint");

      var_00 thread scripts\mp\perks\perkfunctions::setpainted(var_01);
    }

    if(isplayer(var_01) && (var_01 scripts\mp\utility\game::_hasperk("specialty_bulletdamage") && var_00 scripts\mp\utility\game::_hasperk("specialty_armorvest"))) {} else if(isplayer(var_01) && (var_01 scripts\mp\utility\game::_hasperk("specialty_bulletdamage") || var_01 scripts\mp\utility\game::_hasperk("specialty_moredamage")))
      var_11 = var_11 + var_02 * level.func_3245;
    else if(var_00 scripts\mp\utility\game::_hasperk("specialty_armorvest"))
      var_11 = var_11 - var_02 * level.func_21A3;
    else if(var_00 scripts\mp\utility\game::_hasperk("specialty_headgear") && scripts\mp\utility\game::isheadshot(var_04, var_07, var_03, var_01) && !scripts\mp\utility\game::isfmjdamage(var_04, var_03)) {
      var_11 = var_11 - var_02 * level.func_8C74;
      var_00 notify("headgear_save", var_01, var_03, var_04);
    }

    if(var_00 scripts\mp\utility\game::isjuggernaut()) {
      if(level.hardcoremode && isdefined(var_04) && weaponclass(var_04) == "spread") {
        var_02 = min(var_02, 25) * var_12;
        var_11 = min(var_02, 25) * var_12;
      } else {
        var_02 = var_02 * var_12;
        var_11 = var_11 * var_12;
      }
    }

    if(var_01 scripts\mp\utility\game::_hasperk("passive_sonic") && var_01 issprintsliding())
      var_02 = var_02 * 1.25;

    if(var_01 scripts\mp\utility\game::_hasperk("passive_below_the_belt")) {
      var_17 = undefined;

      switch (var_0.loadoutarchetype) {
        case "archetype_scout":
          var_17 = "torso_stabilizer";
          break;
        default:
          var_17 = "j_crotch";
          break;
      }

      if(isdefined(var_17)) {
        var_18 = var_00 gettagorigin(var_17);
        var_19 = distance(var_18, var_05);
        var_20 = 7.5;

        if(var_19 <= var_20) {
          var_02 = var_02 * 1.35;
          var_01 scripts\mp\utility\game::giveperk("specialty_moredamage");
        }
      }
    }

    if(scripts\mp\weapons::func_A008(var_04))
      var_00 thread scripts\mp\weapons::func_20E4();

    if(isdefined(var_0.func_FC99))
      var_02 = 0;
  } else if(isexplosivedamagemod(var_03)) {
    var_02 = scripts\mp\concussion::func_B92C(var_02, var_01, var_00, var_08, var_04);
    var_02 = scripts\mp\equipment\blackout_grenade::func_B92C(var_02, var_01, var_00, var_08, var_04);
    var_02 = scripts\mp\emp_debuff_mp::func_B92C(var_02, var_01, var_00, var_08, var_04);
    var_02 = scripts\mp\weapons::glprox_modifieddamage(var_02, var_01, var_00, var_08, var_04, var_03, var_05);

    if(var_04 == "proximity_explosive_mp" && isdefined(var_8.origin)) {
      var_21 = var_8.origin[2];
      var_22 = var_0.origin[2] + 24;

      if(var_21 < var_22 && !var_00 isonground())
        var_02 = var_02 * 0.8;
      else if(var_21 >= var_22 && var_00 getstance() == "crouch")
        var_02 = var_02 * 0.9;
      else if(var_21 >= var_22 && var_00 getstance() == "prone")
        var_02 = var_02 * 0.65;
    }

    if(isplayer(var_01)) {
      if(var_01 != var_00 && (var_01 getteamdompoints("specialty_paint", "perk") && var_01 scripts\mp\utility\game::_hasperk("specialty_paint")) && !scripts\mp\utility\game::iskillstreakweapon(var_04))
        var_00 thread scripts\mp\perks\perkfunctions::setpainted(var_01);
    }

    if(isdefined(var_0.func_1177D) && var_0.func_1177D)
      var_11 = var_11 + int(var_02 * level.func_1177E);

    if(isplayer(var_01) && weaponinheritsperks(var_04) && (var_01 scripts\mp\utility\game::_hasperk("specialty_explosivedamage") && var_00 scripts\mp\utility\game::_hasperk("specialty_blastshield"))) {} else if(isplayer(var_01) && weaponinheritsperks(var_04) && !scripts\mp\utility\game::iskillstreakweapon(var_04) && var_01 scripts\mp\utility\game::_hasperk("specialty_explosivedamage"))
      var_11 = var_11 + var_02 * level.func_69FE;
    else if(var_00 scripts\mp\utility\game::_hasperk("specialty_blastshield") && !scripts\mp\utility\game::func_13C9A(var_04, var_07) && !scripts\mp\utility\game::func_9F7E(var_00, var_08, var_04, var_03) && !(var_03 == "MOD_PROJECTILE")) {
      var_23 = scripts\mp\weapons::glprox_modifiedblastshieldconst(level.func_2B68, var_04);
      var_23 = scripts\mp\equipment\ground_pound::groundpound_modifiedblastshieldconst(var_23, var_04);
      var_24 = int(var_02 * var_23);

      if(var_01 != var_00)
        var_24 = clamp(var_24, 0, level.func_2B67);

      var_11 = var_11 - (var_02 - var_24);
    }

    if(var_00 scripts\mp\utility\game::isjuggernaut()) {
      var_11 = var_11 * var_12;

      if(var_02 < 1000)
        var_02 = var_02 * var_12;
    }

    if(isdefined(level.func_ABBF) && !scripts\mp\weapons::func_ABC1())
      var_02 = var_02 * level.allowgroundpound;

    if(isdefined(var_0.func_FC99))
      var_02 = 0;
  } else if(var_03 == "MOD_FALLING") {
    if(isdefined(var_0.func_115FC) && var_0.func_115FC) {
      var_02 = var_0.health + 100;
      var_01 thread scripts\mp\equipment\portal_grenade::func_468B(var_00, var_0.origin);
      var_0.func_115FC = 0;
      var_0.func_115FD = undefined;
      var_0.func_115FE = undefined;
    } else if(var_00 scripts\mp\utility\game::isjuggernaut())
      var_02 = var_02 * var_12;
    else if(scripts\mp\equipment\ground_pound::func_8651(var_00))
      var_02 = 0;
    else {
      var_02 = int(max(33, var_02));

      if(var_02 >= var_0.health)
        var_02 = int(max(0, var_0.health - 1));
    }
  } else if(var_03 == "MOD_MELEE") {
    if(isdefined(var_08) && scripts\mp\utility\game::func_9EF0(var_08) && var_8.func_165A == "remote_c8")
      var_02 = self.health - 1;
    else if(var_00 scripts\mp\utility\game::isjuggernaut()) {
      var_02 = 20;
      var_11 = 0;
    } else if(var_04 == "iw7_reaperblade_mp")
      var_00 thread scripts\mp\supers\super_reaper::func_A668();
    else if(isdefined(var_00 scripts\mp\supers::getcurrentsuperref()) && var_00 scripts\mp\supers::getcurrentsuperref() == "super_reaper" && var_00 scripts\mp\supers::issuperinuse())
      var_02 = int(min(var_02, scripts\mp\supers\super_reaper::func_93D9()));
    else if(scripts\mp\utility\game::func_9E7D(var_08, var_00, var_04, var_03))
      var_02 = var_0.health;
    else if(isbehindmeleevictim(var_01, var_00) && (isdefined(var_08) && !scripts\mp\utility\game::func_9EF0(var_08)))
      var_02 = int(max(var_02, 100));
    else
      var_02 = 70;
  } else if(var_03 == "MOD_IMPACT") {
    if(var_00 scripts\mp\utility\game::isjuggernaut()) {
      switch (var_04) {
        case "semtexproj_mp":
        case "gas_grenade_mp":
        case "gravity_grenade_mp":
        case "sensor_grenade_mp":
        case "smoke_grenadejugg_mp":
        case "flash_grenade_mp":
        case "shard_ball_mp":
        case "mortar_shelljugg_mp":
        case "semtex_mp":
        case "frag_grenade_mp":
        case "concussion_grenade_mp":
        case "smoke_grenade_mp":
        case "splash_grenade_mp":
        case "cluster_grenade_mp":
          var_02 = 5;
          break;
        default:
          if(var_02 < 1000)
            var_02 = 25;

          break;
      }

      var_11 = 0;
    }

    if(isdefined(var_0.func_FC99))
      var_02 = 0;
  } else if(var_03 == "MOD_UNKNOWN" || var_03 == "MOD_MELEE_DOG") {
    if(isagent(var_01) && isdefined(var_1.agent_type) && var_1.agent_type == "dog" && var_00 scripts\mp\utility\game::isjuggernaut()) {
      var_00 shellshock("dog_bite", 2);
      var_02 = var_02 * var_12;
    }
  }

  if(var_00 scripts\mp\utility\game::_hasperk("specialty_combathigh")) {
    if(isdefined(self.damageblockedtotal) && (!level.teambased || isdefined(var_01) && isdefined(var_1.team) && var_0.team != var_1.team)) {
      var_25 = var_02 + var_11;
      var_26 = var_25 - var_25 / 3;
      self.damageblockedtotal = self.damageblockedtotal + var_26;

      if(self.damageblockedtotal >= 101) {
        self notify("combathigh_survived");
        self.damageblockedtotal = undefined;
      }
    }

    if(var_04 != "throwingknife_mp" && var_04 != "throwingknifejugg_mp" && var_04 != "throwingknifeteleport_mp" && var_04 != "throwingreaper_mp" && !(var_04 == "throwingknife_mp" && var_03 == "MOD_IMPACT")) {
      switch (var_03) {
        case "MOD_FALLING":
        case "MOD_MELEE":
          break;
        default:
          var_02 = int(var_02 / 3);
          var_11 = int(var_11 / 3);
          break;
      }
    }
  }

  var_02 = scripts\mp\equipment\charge_mode::chargemode_modifieddamage(var_01, var_00, var_04, var_05, var_02);
  var_02 = scripts\mp\equipment\exploding_drone::explodingdrone_modifieddamage(var_01, var_00, var_04, var_08, var_02);
  var_02 = scripts\mp\supers\super_supertrophy::func_11280(var_01, var_00, var_04, var_02);
  var_02 = scripts\mp\equipment\ground_pound::func_8653(var_01, var_00, var_04, var_08, var_02);
  var_02 = scripts\mp\killstreaks\venom::venommodifieddamage(var_01, var_00, var_04, var_08, var_02);
  var_27 = scripts\mp\playertrophysystem::playertrophy_modifieddamage(var_01, var_00, var_04, var_08, var_02);
  var_27 = scripts\mp\trophy_system::trophy_modifieddamage(var_01, var_00, var_04, var_02, var_11);
  var_02 = var_27[0];
  var_11 = var_27[1];
  var_28 = 0;

  if(var_00 scripts\mp\heavyarmor::hasheavyarmor()) {
    var_27 = scripts\mp\heavyarmor::heavyarmormodifydamage(var_00, var_01, var_02, var_11, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    var_28 = var_27[0] > 0;
    var_02 = var_27[1];
    var_11 = var_27[2];
  }

  var_29 = 0;

  if(scripts\mp\lightarmor::haslightarmor(var_00)) {
    var_27 = scripts\mp\lightarmor::lightarmor_modifydamage(var_00, var_01, var_02, var_11, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    var_29 = var_27[0] > 0;
    var_02 = var_27[1];
    var_11 = var_27[2];
  }

  if(scripts\mp\utility\game::hashealthshield(var_00))
    var_02 = var_00 scripts\mp\utility\game::func_7EF7(var_02);

  if(var_02 <= 1)
    var_02 = int(ceil(clamp(var_02, 0, 1)));
  else
    var_02 = int(var_02 + var_11);

  if(isdefined(var_0.func_FC99)) {
    var_0.func_FC9A = var_02;
    var_02 = 0;
  } else if(var_07 == "shield" && var_00 scripts\mp\utility\game::_hasperk("specialty_rearguard") && (var_03 == "MOD_EXPLOSIVE" || var_03 == "MOD_PROJECTILE_SPLASH" || var_03 == "MOD_PROJECTILE" || isdefined(var_8.weapon_name) && scripts\mp\utility\game::iskillstreakweapon(var_8.weapon_name)))
    var_07 = "none";

  if(isdefined(var_08) && isplayer(var_08) && isdefined(var_01) && isplayer(var_01) && var_01 != var_00)
    thread scripts\mp\perks\weaponpassives::updateweaponpassivesondamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

  return [var_02, var_29, var_28, var_07];
}

func_B4CA(var_00, var_01, var_02) {
  var_03 = 0;

  if(isdefined(var_01) && isdefined(var_00) && isdefined(var_02)) {
    var_04 = getweaponbasename(var_02) == "iw7_mauler_mpr" || issubstr(var_02, "iw7_crdb_mp");
    var_05 = weaponclass(var_02) == "spread";

    if(!var_05 && !var_04)
      return var_03;

    var_06 = "" + gettime();
    var_07 = undefined;

    if(var_01 playerads() > 0.8 && var_01 scripts\mp\utility\game::_hasperk("passive_shotgun_focus"))
      var_07 = 4;
    else if(var_04)
      var_07 = 4;
    else if(var_01 isdualwielding())
      var_07 = 5;
    else if(issubstr(var_02, "iw7_mod2187_mpl"))
      var_07 = 4;
    else if(issubstr(var_02, "iw7_longshot_mp")) {
      var_08 = var_01 playerads() > 0.95;
      var_09 = scripts\mp\weapons::isaltmodeweapon(var_02);

      if(!var_08 && !var_09)
        var_07 = 1;
      else if(var_08 && !var_09)
        var_07 = 4;
      else
        var_07 = 3;
    } else
      var_07 = 3;

    if(!isdefined(var_1.pelletdmg) || !isdefined(var_1.pelletdmg[var_06])) {
      var_1.pelletdmg = undefined;
      var_1.pelletdmg[var_06] = [];
    }

    if(!isdefined(var_1.pelletdmg[var_06][var_0.guid]))
      var_1.pelletdmg[var_06][var_0.guid] = 1;
    else if(var_1.pelletdmg[var_06][var_0.guid] + 1 > var_07)
      var_03 = 1;
    else
      var_1.pelletdmg[var_06][var_0.guid]++;
  }

  return var_03;
}

isbehindmeleevictim(var_00, var_01) {
  var_02 = vectornormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_03 = anglestoforward((0, var_1.angles[1], 0));
  return vectordot(var_02, var_03) > 0.4;
}

func_9D68(var_00, var_01) {
  var_02 = vectornormalize((var_1.origin[0], var_1.origin[1], 0) - (var_0.origin[0], var_0.origin[1], 0));
  var_03 = anglestoforward((0, var_1.angles[1], 0));
  return vectordot(var_02, var_03) > 0.2;
}

killstreakdamagefilter(var_00, var_01, var_02, var_03, var_04) {
  if(var_03 == "hind_bomb_mp" || var_03 == "hind_missile_mp") {
    if(isdefined(var_00) && var_01 == var_00)
      return 0;
  }

  if(var_01 scripts\mp\utility\game::isspawnprotected()) {
    var_05 = int(max(var_1.health / 4, 1));

    if(var_02 >= var_05 && scripts\mp\utility\game::iskillstreakweapon(var_03) && var_04 != "MOD_MELEE")
      var_02 = var_05;
  }

  return var_02;
}

friendlyfire_ignoresdamageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  var_14 = 0;

  if(isdefined(var_06)) {
    switch (var_06) {
      case "none":
        if(isdefined(var_00) && scripts\mp\utility\game::isdronepackage(var_00))
          var_14 = 1;

        break;
      case "iw7_minigun_c8_mp":
      case "iw7_chargeshot_c8_mp":
      case "iw7_c8offhandshield_mp":
        var_15 = undefined;

        if(isdefined(var_01) && scripts\mp\utility\game::func_9F22(var_01))
          var_15 = var_01;
        else if(isdefined(var_00) && scripts\mp\utility\game::func_9F22(var_00))
          var_15 = var_00;

        if(isdefined(var_15) && isdefined(var_15.owner)) {
          if(!isdefined(var_15.owner.func_4BE1))
            var_14 = 1;
          else if(var_15.owner.func_4BE1 != "MANUAL")
            var_14 = 1;
        }

        break;
      case "ball_drone_gun_mp":
      case "jackal_fast_cannon_mp":
      case "jackal_turret_mp":
      case "jackal_cannon_mp":
      case "sentry_shock_mp":
      case "iw7_c8landing_mp":
      case "iw7_c8destruct_mp":
      case "super_trophy_mp":
      case "micro_turret_gun_mp":
      case "player_trophy_system_mp":
      case "trophy_mp":
        var_14 = 1;
        break;
    }
  }

  return var_14;
}

handlefriendlyfiredamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(isdefined(var_00) && !isplayer(var_00)) {
    if(!isdefined(var_01)) {
      if(isdefined(var_0.owner))
        var_01 = var_0.owner;
    } else if(!isplayer(var_01)) {
      if(isdefined(var_0.owner))
        var_01 = var_0.owner;
    }
  }

  if(level.hardcoremode) {
    if(var_01 scripts\mp\utility\game::_hasperk("passive_softcore") && scripts\engine\utility::isbulletdamage(var_05))
      return 0;

    if(isdefined(var_04) && var_04 & level.idflags_no_team_protection && scripts\engine\utility::isbulletdamage(var_05))
      var_03 = int(var_03 * 0.2);
  }

  if(level.friendlyfire != 0) {
    if(scripts\mp\utility\game::istrue(var_2.isdefusing) || scripts\mp\utility\game::istrue(var_2.iscapturingcrate)) {
      var_03 = int(var_03 * 0.5);

      if(var_03 < 1)
        var_03 = 1;

      var_1.lastdamagewasfromenemy = 0;
      damageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
      return 0;
    }
  }

  if(level.friendlyfire == 0 || !isplayer(var_01) && level.friendlyfire != 1 || var_06 == "bomb_site_mp") {
    if(var_06 == "artillery_mp" || var_06 == "stealth_bomb_mp")
      var_02 damageshellshockandrumble(var_00, var_06, var_05, var_03, var_04, var_01);

    return 0;
  } else if(level.friendlyfire == 1) {
    if(var_03 < 1)
      var_03 = 1;

    if(var_02 scripts\mp\utility\game::isjuggernaut()) {
      var_14 = func_3696(var_02, var_01, var_03, var_05, var_06, var_07, var_08, var_09, var_00, 0, var_04);
      var_03 = var_14[0];
      var_15 = var_14[1];
      var_16 = var_14[2];
      var_09 = var_14[3];
    }

    var_2.lastdamagewasfromenemy = 0;
    var_02 finishplayerdamagewrapper(var_00, var_01, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    var_01 handledamagefeedback(var_00, var_01, var_02, var_03, var_05, var_06, var_09, var_04, 0, 0);
    return 0;
  } else if(level.friendlyfire == 2) {
    var_03 = int(var_03 * 0.5);

    if(var_03 < 1)
      var_03 = 1;

    var_1.lastdamagewasfromenemy = 0;

    if(!friendlyfire_ignoresdamageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13))
      damageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);

    return 0;
  } else if(level.friendlyfire == 3) {
    var_03 = int(var_03 * 0.5);

    if(var_03 < 1)
      var_03 = 1;

    var_2.lastdamagewasfromenemy = 0;
    var_1.lastdamagewasfromenemy = 0;
    var_02 finishplayerdamagewrapper(var_00, var_01, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);

    if(!friendlyfire_ignoresdamageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13))
      damageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);

    var_01 handledamagefeedback(var_00, var_01, var_02, var_03, var_05, var_06, var_09, var_04, 0, 0);
    return 0;
  } else if(level.friendlyfire == 4) {
    var_17 = var_1.pers["teamkills"] >= level.maxallowedteamkills;

    if(var_17) {
      if(!friendlyfire_ignoresdamageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13)) {
        var_03 = int(var_03 * 0.5);

        if(var_03 < 1)
          var_03 = 1;

        var_1.lastdamagewasfromenemy = 0;
        damageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
      }

      return 0;
    }
  }

  return var_03;
}

damageattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(scripts\mp\utility\game::isreallyalive(var_01)) {
    var_1.friendlydamage = 1;
    var_01 finishplayerdamagewrapper(var_00, var_01, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    var_1.friendlydamage = undefined;
  }
}

modifydamagegeneral(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(var_05 == "MOD_EXPLOSIVE_BULLET" && var_03 != 1) {
    var_03 = var_03 * getdvarfloat("scr_explBulletMod");
    var_03 = int(var_03);
  }

  if(isdefined(level.modifyplayerdamage))
    var_03 = [
      [level.modifyplayerdamage]
    ](var_02, var_01, var_03, var_05, var_06, var_07, var_08, var_09);

  var_03 = int(var_03 * var_02 scripts\mp\utility\game::getdamagemodifiertotal(var_00, var_01, var_02, var_03, var_05, var_06, var_09));

  if(scripts\mp\utility\game::isheadshot(var_06, var_09, var_05, var_01))
    var_05 = "MOD_HEAD_SHOT";

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(var_05 == "MOD_HEAD_SHOT") {
      if(var_02 scripts\mp\utility\game::isjuggernaut())
        var_03 = 75;
      else
        var_03 = 150;
    }
  }

  return var_03;
}

handleriotshieldhits(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(var_08 != "shield")
    return var_03;

  if(var_01 scripts\mp\utility\game::_hasperk("specialty_rearguard")) {
    var_10 = scripts\engine\utility::ter_op(isdefined(var_00), var_00, var_02);

    if(isdefined(var_10)) {
      if(isplayer(var_10) || scripts\mp\utility\game::func_9EF0(var_10)) {
        if(func_9D68(var_10, var_01)) {
          if(scripts\engine\utility::isbulletdamage(var_04) || var_04 == "MOD_EXPLOSIVE_BULLET")
            var_02 scripts\mp\damagefeedback::updatedamagefeedback("hitlightarmor");
        }
      } else if(isdefined(var_05) && (var_05 == "destructible_car" || scripts\mp\utility\game::iskillstreakweapon(var_05)) || (isexplosivedamagemod(var_04) || var_04 == "MOD_PROJECTILE")) {
        var_1.func_FC96 = var_1.func_FC96 + var_03;

        if(func_9D68(var_10, var_01) && !var_01 scripts\mp\utility\game::_hasperk("specialty_blastshield"))
          return var_03 * 3;
        else
          return var_03;
      }
    }
  }

  var_11 = scripts\mp\utility\game::istrue(var_1.func_9331);

  if(isdefined(var_1.owner)) {
    var_01 = var_1.owner;

    if(var_02 == var_01)
      return "hit shield";
  }

  if(var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET") {
    if(isplayer(var_02)) {
      var_2.func_A93F = var_01;
      var_2.func_A940 = gettime();
    }

    var_01 notify("shield_blocked");

    if(scripts\mp\utility\game::isenvironmentweapon(var_05))
      var_12 = 25;
    else if(var_01 scripts\mp\utility\game::_hasperk("specialty_rearguard") && func_9D68(var_02, var_01))
      var_12 = var_03;
    else {
      var_13 = func_3696(var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_00, 0, var_09);
      var_12 = var_13[0];
      var_14 = var_13[1];
      var_15 = var_13[2];
      var_08 = var_13[3];
    }

    var_1.func_FC96 = var_1.func_FC96 + var_12;
    var_1.func_FC97 = var_1.func_FC97 + var_12;

    if(isplayer(var_02) && isdefined(var_1.rearguardattackers)) {
      var_16 = var_02 getentitynumber();

      if(!isdefined(var_1.rearguardattackers[var_16]))
        var_1.rearguardattackers[var_16] = var_12;
      else
        var_1.rearguardattackers[var_16] = var_1.rearguardattackers[var_16] + var_12;
    }

    if(var_11)
      return "hit shield";

    if(!scripts\mp\utility\game::isenvironmentweapon(var_05) || scripts\engine\utility::cointoss())
      var_1.func_FC95++;

    if(var_1.func_FC95 >= level.riotshieldxpbullets) {
      var_17 = 1.0;

      if(self.recentshieldxp > 4)
        var_17 = 1.0 / self.recentshieldxp;

      var_18 = scripts\mp\rank::getscoreinfovalue("shield_damage");
      var_19 = var_01 getcurrentweapon();
      var_01 thread scripts\mp\utility\game::giveunifiedpoints("shield_damage", var_19, var_18 * var_17);
      var_01 thread giverecentshieldxp();
      var_01 thread scripts\mp\missions::processchallenge("shield_damage", var_1.func_FC97);
      var_01 thread scripts\mp\missions::processchallenge("shield_bullet_hits", var_1.func_FC95);
      var_1.func_FC97 = 0;
      var_1.func_FC95 = 0;
    }
  }

  var_20 = isdefined(var_00) && isdefined(var_0.stuckenemyentity) && var_0.stuckenemyentity == var_01;

  if(var_09 & level.idflags_shield_explosive_impact && !var_01 scripts\mp\utility\game::_hasperk("specialty_rearguard")) {
    var_01 thread scripts\mp\missions::processchallenge("shield_explosive_hits", 1);
    var_08 = "none";

    if(!(var_09 & level.idflags_shield_explosive_impact_huge))
      var_03 = 0;
  } else if(var_09 & level.idflags_shield_explosive_splash) {
    if(scripts\mp\utility\game::func_9F7F(var_01, var_00, var_05, var_04)) {
      var_1.forcehitlocation = "none";
      var_03 = var_1.maxhealth;
    }

    if(!var_01 scripts\mp\utility\game::_hasperk("specialty_rearguard")) {
      var_01 thread scripts\mp\missions::processchallenge("shield_explosive_hits", 1);
      var_08 = "none";
    }
  } else
    return "hit shield";

  if(var_04 == "MOD_MELEE" && scripts\mp\weapons::isriotshield(var_05)) {
    var_21 = 0.0;
    var_01 _meth_83B2(0.0);
  }

  return var_03;
}

filterdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(var_05 == "iw7_reaperblade_mp") {
    var_07 = gettime();

    if(isdefined(var_2.func_A9DA)) {
      if(var_2.func_A9DA + 200 >= var_07)
        return "invalidVictim";
    }

    var_2.func_A9DA = var_07;
  }

  if(!var_03)
    return "!iDamage";

  if(isdefined(level.hostmigrationtimer))
    return "level.hostMigrationTimer";

  var_01 = scripts\mp\utility\game::_validateattacker(var_01);

  if(!isdefined(var_01) && var_04 != "MOD_FALLING")
    return "invalid attacker";

  var_02 = scripts\mp\utility\game::func_143B(var_02);

  if(!isdefined(var_02))
    return "invalidVictim";

  if(game["state"] == "postgame")
    return "game[state] == postgame";

  if(var_2.sessionteam == "spectator")
    return "victim.sessionteam == spectator";

  if(isdefined(var_2.func_389E) && !var_2.func_389E)
    return "!victim.canDoCombat";

  if(isdefined(var_01) && isplayer(var_01) && isdefined(var_1.func_389E) && !var_1.func_389E)
    return "!eAttacker.canDoCombat";

  var_08 = isdefined(var_01) && isdefined(var_00) && isdefined(var_02) && isplayer(var_01) && var_01 == var_00 && var_01 == var_02 && !isdefined(var_0.poison);

  if(var_08)
    return "attackerIsInflictorVictim";

  if(scripts\mp\tweakables::gettweakablevalue("game", "onlyheadshots")) {
    if(var_06 != "head") {
      if(var_04 == "MOD_PISTOL_BULLET" || var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_EXPLOSIVE_BULLET")
        return "getTweakableValue(game, onlyheadshots)";
    }
  }

  var_09 = isdefined(var_01) && !isdefined(var_1.gunner) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");

  if(!level.teambased && var_09 && isdefined(var_1.owner) && var_1.owner == var_02) {
    if(var_04 == "MOD_CRUSH")
      var_02 scripts\mp\utility\game::_suicide();

    return "ffa suicide";
  }

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_02)) {
    if(!isdefined(var_00))
      return "outOfPhase";

    if(!scripts\mp\equipment\phase_shift::isentityphaseshifted(var_00)) {
      if(!isdefined(var_0.classname) || var_0.classname != "trigger_hurt")
        return "outOfPhase";
    }
  } else if(isdefined(var_00) && !scripts\mp\equipment\phase_shift::areentitiesinphase(var_00, var_02))
    return "outOfPhase";
}

logattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isdefined(var_01) && isplayer(var_01))
    addattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

  if(isdefined(var_01) && !isplayer(var_01) && isdefined(var_1.owner) && (!isdefined(var_1.scrambled) || !var_1.scrambled))
    addattacker(var_00, var_1.owner, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  else if(isdefined(var_01) && !isplayer(var_01) && isdefined(var_1.secondowner) && isdefined(var_1.scrambled) && var_1.scrambled)
    addattacker(var_00, var_1.secondowner, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);

  if(isdefined(var_02) && isdefined(var_2.owner)) {
    var_10 = var_2.owner.team != var_0.team || level.friendlyfire == 1;

    if(var_10 && !isdefined(self.attackerdata[var_2.owner.guid]))
      addattacker(var_00, var_2.owner, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  }

  if(isdefined(var_01))
    level.lastlegitimateattacker = var_01;

  if(isdefined(var_01) && isplayer(var_01) && isdefined(var_03))
    var_01 thread scripts\mp\weapons::func_3E1E(var_03, var_00);

  if(isdefined(var_01) && isplayer(var_01) && isdefined(var_03) && var_01 != var_00) {
    var_01 thread scripts\mp\events::damagedplayer(self, var_04, var_03);
    var_0.attackerposition = var_1.origin;
  } else
    var_0.attackerposition = undefined;
}

logattackerkillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(isdefined(var_02) && isplayer(var_02))
    addattackerkillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);

  if(isdefined(var_02) && !isplayer(var_02) && isdefined(var_2.owner) && (!isdefined(var_2.scrambled) || !var_2.scrambled)) {
    var_02 = var_2.owner;
    addattackerkillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
  } else if(isdefined(var_02) && !isplayer(var_02) && isdefined(var_2.secondowner) && isdefined(var_2.scrambled) && var_2.scrambled) {
    var_02 = var_2.secondowner;
    addattackerkillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10);
  }

  if(isdefined(var_02))
    level.lastlegitimateattacker = var_02;

  if(isdefined(var_02) && isplayer(var_02) && isdefined(var_10) && var_02 != var_00)
    var_0.attackerposition = var_2.origin;
  else
    var_0.attackerposition = undefined;
}

loggrenadedata(var_00, var_01, var_02, var_03, var_04, var_05) {
  if((issubstr(var_04, "MOD_EXPLOSIVE") || issubstr(var_04, "MOD_PROJECTILE")) && isdefined(var_00) && isdefined(var_01)) {
    var_2.explosiveinfo = [];
    var_2.explosiveinfo["damageTime"] = gettime();
    var_2.explosiveinfo["damageId"] = var_00 getentitynumber();
    var_2.explosiveinfo["returnToSender"] = 0;
    var_2.explosiveinfo["counterKill"] = 0;
    var_2.explosiveinfo["chainKill"] = 0;
    var_2.explosiveinfo["cookedKill"] = 0;
    var_2.explosiveinfo["throwbackKill"] = 0;
    var_2.explosiveinfo["suicideGrenadeKill"] = 0;
    var_2.explosiveinfo["weapon"] = var_05;
    var_06 = issubstr(var_05, "frag_");

    if(var_01 != var_02) {
      if((issubstr(var_05, "c4_") || issubstr(var_05, "proximity_explosive_") || issubstr(var_05, "claymore_")) && isdefined(var_0.owner)) {
        var_2.explosiveinfo["returnToSender"] = var_0.owner == var_02;
        var_2.explosiveinfo["counterKill"] = isdefined(var_0.wasdamaged);
        var_2.explosiveinfo["chainKill"] = isdefined(var_0.waschained);
        var_2.explosiveinfo["bulletPenetrationKill"] = isdefined(var_0.wasdamagedfrombulletpenetration);
        var_2.explosiveinfo["cookedKill"] = 0;
      }

      if(isdefined(var_1.lastgrenadesuicidetime) && var_1.lastgrenadesuicidetime >= gettime() - 50 && var_06)
        var_2.explosiveinfo["suicideGrenadeKill"] = 1;
    }

    if(var_06) {
      var_2.explosiveinfo["cookedKill"] = isdefined(var_0.iscooked);
      var_2.explosiveinfo["throwbackKill"] = isdefined(var_0.threwback);
    }

    var_2.explosiveinfo["stickKill"] = isdefined(var_0.isstuck) && var_0.isstuck == "enemy";
    var_2.explosiveinfo["stickFriendlyKill"] = isdefined(var_0.isstuck) && var_0.isstuck == "friendly";

    if(isplayer(var_01) && var_01 != self && level.gametype != "aliens")
      updateinflictorstat(var_00, var_01, var_05);
  }

  if(issubstr(var_04, "MOD_IMPACT") && var_05 == "iw6_rgm_mp") {
    if(isplayer(var_01) && var_01 != self && level.gametype != "aliens")
      updateinflictorstat(var_00, var_01, var_05);
  }
}

handledamagefeedback(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  var_10 = isdefined(var_01) && !isdefined(var_1.gunner) && (var_1.classname == "script_vehicle" || var_1.classname == "misc_turret" || var_1.classname == "script_model");

  if(var_10 && isdefined(var_1.gunner))
    var_11 = var_1.gunner;
  else
    var_11 = var_01;

  var_12 = "standard";

  if(isdefined(var_11) && var_11 != var_02 && var_03 + var_08 + var_09 > 0 && (!isdefined(var_06) || var_06 != "shield")) {
    var_13 = !scripts\mp\utility\game::isreallyalive(var_02) || isagent(var_02) && var_03 >= var_2.health;

    if(var_02 scripts\mp\heavyarmor::hasheavyarmor() || var_02 scripts\mp\heavyarmor::hasheavyarmorinvulnerability())
      var_12 = "hitjuggernaut";
    else if(var_07 & level.idflags_stun)
      var_12 = "stun";
    else if(isexplosivedamagemod(var_04) && (isdefined(var_2.func_1177D) && var_2.func_1177D))
      var_12 = "thermobaric_debuff";
    else if(scripts\mp\utility\game::func_9F93(var_05, var_04) && var_02 scripts\mp\utility\game::_hasperk("specialty_stun_resistance"))
      var_12 = "hittacresist";
    else if(isexplosivedamagemod(var_04) && var_02 scripts\mp\utility\game::_hasperk("specialty_blastshield") && !scripts\mp\utility\game::func_13C9A(var_05, var_06) && !scripts\mp\utility\game::func_9F7E(var_02, var_00, var_05, var_04))
      var_12 = "hitblastshield";
    else if(var_02 scripts\mp\utility\game::_hasperk("specialty_combathigh"))
      var_12 = "hitendgame";
    else if(scripts\mp\utility\game::hashealthshield(var_02))
      var_12 = "hitlightarmor";
    else if(var_08 > 0)
      var_12 = "hitlightarmor";
    else if(var_02 scripts\mp\utility\game::isjuggernaut())
      var_12 = "hitjuggernaut";
    else if(var_02 scripts\mp\utility\game::_hasperk("specialty_moreHealth"))
      var_12 = "hitmorehealth";
    else if(var_11 scripts\mp\utility\game::_hasperk("specialty_moredamage")) {
      var_12 = "hitcritical";
      var_11 scripts\mp\utility\game::removeperk("specialty_moredamage");
    } else if(var_02 scripts\mp\utility\game::getdamagemodifiertotal(var_00, var_01, var_02, var_03, var_04, var_05, var_06) < 0.95)
      var_12 = "hitlowdamage";
    else if(var_02 scripts\mp\utility\game::isspawnprotected() && scripts\mp\utility\game::iskillstreakweapon(var_05))
      var_12 = "hitspawnprotection";
    else if(!func_100C1(var_05))
      var_12 = "none";

    var_14 = "high_damage";

    if(var_03 < 20)
      var_14 = "low_damage";

    var_15 = weaponclass(var_05) == "spread" || getweaponbasename(var_05) == "iw7_mauler_mpr" || issubstr(var_05, "iw7_crdb_mp");
    var_16 = !var_15 && scripts\mp\utility\game::isheadshot(var_05, var_06, var_04, var_01);
    var_17 = 1;
    var_18 = var_04 == "MOD_MELEE";
    var_19 = "" + gettime();

    if(!var_18 && var_15 && isdefined(var_11.pelletdmg) && isdefined(var_11.pelletdmg[var_19]) && isdefined(var_11.pelletdmg[var_19][var_2.guid]) && var_11.pelletdmg[var_19][var_2.guid] > 1) {
      if(var_13)
        var_18 = 1;
      else
        var_17 = 0;
    }

    if(var_17)
      var_11 thread scripts\mp\damagefeedback::updatedamagefeedback(var_12, var_13, var_16, var_14, var_18);
  }
}

lethalequipmentdamagemod(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isdefined(var_00) && isdefined(var_0.damagedby))
    var_01 = var_0.damagedby;

  if(scripts\mp\utility\game::func_9F7F(var_02, var_00, var_06, var_05))
    var_03 = var_2.maxhealth;

  if(isdefined(var_05) && var_05 != "MOD_IMPACT") {
    if(var_02 != var_01 && isdefined(var_00) && var_0.classname == "grenade" && var_2.lastspawntime + 3500 > gettime() && isdefined(var_2.lastspawnpoint) && distance(var_0.origin, var_2.lastspawnpoint.origin) < 500)
      var_03 = 0;
  }

  if(var_03 < var_2.health)
    var_02 notify("survived_explosion", var_01);

  loggrenadedata(var_00, var_01, var_02, var_03, var_05, var_06);
  return var_03;
}

func_1177F() {
  self endon("disconnect");
  level endon("game_ended");
  var_00 = gettime() + 5000;
  wait 0.05;
  self.func_1177D = 1;

  for (;;) {
    if(self.health == self.maxhealth) {
      self.func_1177D = 0;
      return;
    }

    if(gettime() >= var_00) {
      self.func_1177D = 0;
      return;
    }

    wait 0.05;
  }
}

playerkilled_internal(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = getweaponbasename(var_06);

  if(var_12 == "iw7_spas_mpr_focus")
    var_12 = "iw7_spas_mpr";
  else if(var_12 == "iw7_erad_mp_jump_spread")
    var_12 = "iw7_erad_mp";

  if(isdefined(var_12)) {}

  scripts\mp\utility\game::printgameaction("death", var_02);
  var_02 endon("spawned");
  var_02 notify("killed_player");
  var_02 showuidamageflash();
  var_13 = 0;
  self setblurforplayer(0, 0);
  scripts\mp\outline::outlinedisableinternalall(self);
  var_2.func_1519 = 0;
  var_2.perkoutlined = 0;
  var_2.attacker = var_01;

  if(scripts\mp\utility\game::gamehasneutralcrateowner(level.gametype)) {
    if(var_02 != var_01 && var_05 == "MOD_CRUSH") {
      var_00 = var_02;
      var_01 = var_02;
      var_05 = "MOD_SUICIDE";
      var_06 = "none";
      var_08 = "none";
      var_2.attackers = [];
    }
  }

  if(var_06 == "none") {
    if(isdefined(var_00) && isdefined(var_0.func_28AF))
      var_06 = var_0.func_28AF;
  }

  if(isdefined(var_00) && !isplayer(var_00)) {
    if(!isdefined(var_01)) {
      if(isdefined(var_0.owner))
        var_01 = var_0.owner;
    } else if(!isplayer(var_01)) {
      if(isdefined(var_0.owner))
        var_01 = var_0.owner;
    }
  }

  var_01 = scripts\mp\utility\game::_validateattacker(var_01);

  if(isdefined(var_01))
    var_1.assistedsuicide = undefined;

  if(isdefined(var_2.hasriotshieldequipped) && var_2.hasriotshieldequipped)
    var_02 launchshield(var_03, var_05);

  var_02 scripts\mp\utility\game::riotshield_clear();
  scripts\mp\weapons::recordtogglescopestates();

  if(!var_11) {
    if(isdefined(var_2.endgame))
      scripts\mp\utility\game::restorebasevisionset(2);
    else {
      scripts\mp\utility\game::restorebasevisionset(0);
      var_02 thermalvisionoff();
    }
  } else {
    var_2.fauxdeath = 1;
    self notify("death");
  }

  if(game["state"] == "postgame") {
    return;
  }
  scripts\mp\perks::updateactiveperks(var_00, var_01, var_02, var_03, var_05, var_06, var_08, var_07);
  var_14 = 0;

  if(!isplayer(var_00) && isdefined(var_0.primaryweapon))
    var_15 = var_0.primaryweapon;
  else if(isdefined(var_01) && isplayer(var_01) && var_01 getcurrentprimaryweapon() != "none")
    var_15 = var_01 getcurrentprimaryweapon();
  else if(issubstr(var_06, "alt_"))
    var_15 = getsubstr(var_06, 4, var_6.size);
  else
    var_15 = undefined;

  if(isdefined(var_2.uselaststandparams) || isdefined(var_2.laststandparams) && var_05 == "MOD_SUICIDE") {
    var_02 ensurelaststandparamsvalidity();
    var_2.uselaststandparams = undefined;
    var_00 = var_2.laststandparams.einflictor;
    var_01 = var_2.laststandparams.attacker;
    var_03 = var_2.laststandparams.idamage;
    var_05 = var_2.laststandparams.smeansofdeath;
    var_06 = var_2.laststandparams.sweapon;
    var_15 = var_2.laststandparams.sprimaryweapon;
    var_07 = var_2.laststandparams.vdir;
    var_08 = var_2.laststandparams.shitloc;
    var_14 = (gettime() - var_2.laststandparams.laststandstarttime) / 1000;
    var_2.laststandparams = undefined;
    var_01 = scripts\mp\utility\game::_validateattacker(var_01);
  }

  if(!isdefined(var_01) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_01 == var_02) {
    var_16 = undefined;

    if(isdefined(self.attackers) && self.attackers.size > 0) {
      foreach(var_18 in self.attackers) {
        if(!isdefined(scripts\mp\utility\game::_validateattacker(var_18))) {
          continue;
        }
        if(!isdefined(var_2.attackerdata[var_18.guid].damage)) {
          continue;
        }
        if(var_18 == var_02 || level.teambased && var_18.team == var_2.team) {
          continue;
        }
        if(var_2.attackerdata[var_18.guid].lasttimedamaged + 2500 < gettime() && (var_01 != var_02 && (isdefined(var_2.laststand) && var_2.laststand))) {
          continue;
        }
        if(var_2.attackerdata[var_18.guid].damage > 1 && !isdefined(var_16)) {
          var_16 = var_18;
          continue;
        }

        if(isdefined(var_16) && var_2.attackerdata[var_18.guid].damage > var_2.attackerdata[var_16.guid].damage)
          var_16 = var_18;
      }
    }

    if(!isdefined(var_16)) {
      if(isdefined(var_2.debuffedbyplayers) && var_2.debuffedbyplayers.size > 0) {
        var_20 = ["chargemode_mp", "cryo_mine_mp", "concussion_grenade_mp", "super_trophy_mp", "blackout_grenade_mp", "blackhole_grenade_mp", "power_spider_grenade_mp", "emp_grenade_mp"];

        foreach(var_26, var_22 in var_20) {
          var_23 = scripts\mp\gamescore::getdebuffattackersbyweapon(var_02, var_22);

          if(isdefined(var_23) && var_23.size > 0) {
            for (var_24 = var_23.size - 1; var_24 >= 0; var_24--) {
              var_25 = var_23[var_24];

              if(!isdefined(scripts\mp\utility\game::_validateattacker(var_25))) {
                continue;
              }
              if(!scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_25, var_02))) {
                continue;
              }
              var_16 = var_25;

              if(!isdefined(var_2.attackerdata) || !isdefined(var_2.attackerdata[var_16.guid]))
                addattacker(var_02, var_16, undefined, var_22, 0, undefined, undefined, undefined, undefined, "MOD_EXPLOSIVE");

              break;
            }
          }

          if(isdefined(var_16)) {
            break;
          }
        }
      }
    }

    if(isdefined(var_16)) {
      var_01 = var_16;
      var_1.assistedsuicide = 1;
      var_06 = var_2.attackerdata[var_16.guid].weapon;
      var_07 = var_2.attackerdata[var_16.guid].vdir;
      var_08 = var_2.attackerdata[var_16.guid].shitloc;
      var_09 = var_2.attackerdata[var_16.guid].psoffsettime;
      var_05 = var_2.attackerdata[var_16.guid].smeansofdeath;
      var_03 = var_2.attackerdata[var_16.guid].damage;
      var_15 = var_2.attackerdata[var_16.guid].sprimaryweapon;
      var_00 = var_01;
      var_13 = 1;
    }
  }

  scripts\mp\equipment\wrist_rocket::wristrocketcooksuicideexplodecheck(var_00, var_01, var_02, var_05, var_06);

  if(scripts\mp\utility\game::isheadshot(var_06, var_08, var_05, var_01))
    var_05 = "MOD_HEAD_SHOT";
  else if(!isdefined(var_2.nuked)) {
    if(isdefined(level.func_4C4A))
      [[level.func_4C4A]](var_02, var_05, var_00);
    else if(var_05 != "MOD_MELEE")
      var_02 scripts\mp\utility\game::playdeathsound();
  }

  if(isdefined(level.func_4C47))
    [[level.func_4C47]](var_02, var_05, var_00);

  var_27 = isfriendlyfire(var_02, var_01);

  if(isdefined(var_01)) {
    if(var_1.code_classname == "script_vehicle" && isdefined(var_1.owner))
      var_01 = var_1.owner;

    if(var_1.code_classname == "misc_turret" && isdefined(var_1.owner)) {
      if(isdefined(var_1.vehicle))
        var_1.vehicle notify("killedPlayer", var_02);

      var_01 = var_1.owner;
    }

    if(isagent(var_01)) {
      if(isdefined(var_1.agent_type)) {
        if(var_1.agent_type == "dog")
          var_06 = "guard_dog_mp";
        else if(var_1.agent_type == "squadmate")
          var_06 = "agent_support_mp";
      }

      if(isdefined(var_1.owner))
        var_01 = var_1.owner;
    }

    if(var_1.code_classname == "script_model" && isdefined(var_1.owner)) {
      var_01 = var_1.owner;

      if(!isfriendlyfire(var_02, var_01) && var_01 != var_02)
        var_01 notify("crushed_enemy");
    }
  }

  if(var_05 != "MOD_SUICIDE" && (scripts\mp\utility\game::isaigameparticipant(var_02) || scripts\mp\utility\game::isaigameparticipant(var_01)) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["get_attacker_ent"])) {
    var_28 = [
      [level.bot_funcs["get_attacker_ent"]]
    ](var_01, var_00);

    if(isdefined(var_28)) {
      if(scripts\mp\utility\game::isaigameparticipant(var_02))
        var_02 botmemoryevent("death", var_06, var_28.origin, var_2.origin, var_28);

      if(scripts\mp\utility\game::isaigameparticipant(var_01)) {
        var_29 = 1;

        if(var_28.classname == "script_vehicle" && isdefined(var_28.helitype) || var_28.classname == "rocket" || var_28.classname == "misc_turret")
          var_29 = 0;

        if(var_29)
          var_01 botmemoryevent("kill", var_06, var_28.origin, var_2.origin, var_02);
      }
    }
  }

  if(scripts\mp\utility\game::func_9EF0(var_02)) {
    var_2.playerproxyagent scripts\mp\weapons::dropscavengerfordeath(var_01);
    var_2.playerproxyagent[[level.weapondropfunction]](var_01, var_05);
  } else {
    var_02 scripts\mp\weapons::dropscavengerfordeath(var_01, var_05);
    var_02[[level.weapondropfunction]](var_01, var_05);
  }

  if(!var_11) {
    var_02 scripts\mp\utility\game::updatesessionstate("dead");

    if(isplayer(var_01) && var_01 != var_02)
      var_02 setclientomnvar("ui_killcam_killedby_id", var_01 getentitynumber());
  }

  var_30 = isdefined(var_2.fauxdeath) && var_2.fauxdeath && isdefined(var_2.switching_teams) && var_2.switching_teams;

  if(!var_30)
    var_02 scripts\mp\playerlogic::removefromalivecount();

  if(!isdefined(var_2.switching_teams)) {
    var_31 = var_02;

    if(isdefined(var_2.commanding_bot))
      var_31 = var_2.commanding_bot;

    if(!isdefined(level.ignorescoring) && !var_27) {
      var_31 scripts\mp\utility\game::incperstat("deaths", 1, isdefined(level.ignorekdrstats));
      var_31.deaths = var_31 scripts\mp\utility\game::getpersstat("deaths");
      var_31 scripts\mp\utility\game::updatepersratio("kdRatio", "kills", "deaths", level.ignorekdrstats);
      var_31 scripts\mp\persistence::statsetchild("round", "deaths", var_31.deaths, level.ignorekdrstats);
    }
  }

  if(isdefined(var_01) && isplayer(var_01))
    var_01 checkkillsteal(var_02);

  var_32 = var_06;
  var_33 = var_05;

  if(scripts\mp\utility\game::iskillstreakweapon(var_32) || isdefined(var_0.streakinfo)) {
    var_34 = undefined;

    if(var_32 == "minijackal_assault_mp")
      var_34 = 10042;
    else if(isdefined(var_0.streakinfo)) {
      if(isdefined(var_0.streakinfo.variantid) && var_0.streakinfo.variantid > 0)
        var_34 = var_0.streakinfo.variantid;
    }

    if(isdefined(var_34)) {
      var_35 = level.func_110EC.rarity[var_34];
      var_36 = level.func_110EC.func_E76D[var_34];

      if(var_32 != "none") {
        var_32 = var_06 + "+loot" + var_36;
        var_33 = "MOD_SCORESTREAK";
      }

      var_2.killsteakvariantattackerinfo = spawnstruct();
      var_2.killsteakvariantattackerinfo.id = var_34;
      var_2.killsteakvariantattackerinfo.rarity = var_35;
    }
  }

  if(isdefined(var_32) && scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_32) == "iw7_axe_mp" && isdefined(var_01) && var_01 getweaponammoclip(var_32) > 0)
    var_33 = "MOD_IMPACT";

  obituary(var_02, var_01, var_32, var_33);
  var_37 = 0;
  var_38 = 1;
  var_02 scripts\mp\clientmatchdata::logplayerdeath(var_01);
  var_39 = var_2.matchdatalifeindex;

  if(!isdefined(var_39))
    var_39 = level.maxlives - 1;

  var_02 scripts\mp\matchdata::logplayerdeath(var_39, var_01, var_03, var_05, var_06, var_15, var_08);
  var_02 scripts\mp\analyticslog::logevent_path();
  var_02 scripts\mp\analyticslog::logevent_playerdeath(var_01, var_05, var_06);

  if(isplayer(var_01))
    var_01 scripts\mp\analyticslog::logevent_playerkill(var_02, var_05, var_06);

  var_02 updatedeathdetails(self.attackers, self.attackerdata);
  var_02 func_41D5();
  var_2.deathspectatepos = undefined;

  if(var_02 isswitchingteams())
    func_89F1();
  else if(!isplayer(var_01) || isplayer(var_01) && var_05 == "MOD_FALLING" && (!isdefined(var_2.func_115FC) && !var_2.func_115FC)) {
    var_2.deathspectatepos = var_2.origin;
    handleworlddeath(var_01, var_39, var_05, var_08);

    if(isagent(var_01))
      var_37 = 1;
  } else if(var_01 == var_02 || !scripts\mp\utility\game::playersareenemies(var_01, var_02) && scripts\mp\utility\game::isdronepackage(var_00))
    handlesuicidedeath(var_05, var_08);
  else if(var_27) {
    if(!(isdefined(var_2.nuked) || var_06 == "bomb_site_mp"))
      handlefriendlyfiredeath(var_01);
  } else {
    if(var_05 == "MOD_GRENADE" && var_00 == var_01)
      addattacker(var_02, var_01, var_00, var_06, var_03, (0, 0, 0), var_07, var_08, var_09, var_05);

    if(var_01 scripts\mp\utility\game::_hasperk("specialty_chain_reaction")) {
      if(var_05 == "MOD_EXPLOSIVE" || var_05 == "MOD_GRENADE_SPLASH" || var_05 == "MOD_GRENADE")
        var_02 scripts\mp\perks\perkfunctions::func_10D79(var_01);
    }

    if(var_06 == "case_bomb_mp")
      var_01 thread scripts\mp\weapons::func_3B0D(var_02, var_2.origin);

    var_37 = 1;

    if(isai(var_02) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["should_do_killcam"]))
      var_37 = var_02[[level.bot_funcs["should_do_killcam"]]]();

    if(isdefined(level.disable_killcam) && level.disable_killcam)
      var_37 = 0;

    handlenormaldeath(var_39, var_01, var_00, var_06, var_05, var_02, var_04);
    var_02 thread scripts\mp\missions::playerkilled(var_00, var_01, var_03, var_04, var_05, var_06, var_15, var_08, var_1.modifiers);
    var_01 thread scripts\mp\intelchallenges::func_99BA(var_02, var_00, var_06, var_05, var_1.modifiers);
    var_01 thread scripts\mp\contractchallenges::contractkillsimmediate(var_02, var_00, var_06, var_05, var_1.modifiers);
    var_2.pers["cur_death_streak"]++;

    if(isplayer(var_01) && var_02 scripts\mp\utility\game::isjuggernaut()) {
      if(isdefined(var_2.isjuggernautmaniac) && var_2.isjuggernautmaniac) {
        var_01 thread scripts\mp\utility\game::teamplayercardsplash("callout_killed_maniac", var_01);

        if(var_05 == "MOD_MELEE")
          var_01 scripts\mp\missions::processchallenge("ch_thisisaknife");
      } else if(isdefined(var_2.isjuggernautlevelcustom) && var_2.isjuggernautlevelcustom)
        var_01 thread scripts\mp\utility\game::teamplayercardsplash(level.func_B332, var_01);
      else
        var_01 thread scripts\mp\utility\game::teamplayercardsplash("callout_killed_juggernaut", var_01);
    }
  }

  var_40 = 0;
  var_41 = undefined;

  if(isdefined(self.func_D8B0)) {
    var_40 = 1;
    var_41 = self.func_D8B0;
    self.func_D8B0 = undefined;
  }

  if(isplayer(var_01) && var_01 != self && (!level.teambased || level.teambased && self.team != var_1.team)) {
    if(var_40 && isdefined(var_41))
      var_42 = var_41;
    else
      var_42 = self.lastdroppableweaponobj;

    var_42 = scripts\mp\utility\game::func_13CA1(var_42, var_00);
    thread scripts\mp\gamelogic::func_11AF7(var_42, var_05);
    var_01 thread scripts\mp\gamelogic::func_11AC8(var_06, var_05);
  }

  var_02 resetplayervariables();
  var_02 resetplayeromnvarsonspawn();
  var_2.lastattacker = var_01;
  var_2.lastdeathpos = var_2.origin;
  var_2.deathtime = gettime();
  var_2.wantsafespawn = 0;
  var_2.revived = 0;
  var_2.func_EB14 = 0;
  var_2.streaktype = scripts\mp\class::loadout_getplayerstreaktype(var_2.streaktype);

  if(scripts\mp\killstreaks\killstreaks::streaktyperesetsondeath(var_2.streaktype)) {
    if(!level.func_3B1E && !var_02 scripts\mp\utility\game::_hasperk("specialty_support_killstreaks"))
      var_02 scripts\mp\killstreaks\killstreaks::func_E275();
  }

  var_43 = undefined;

  if(var_13 || level.teambased && isdefined(var_1.team) && var_1.team == var_2.team) {
    var_37 = 0;
    var_38 = 0;
  }

  if(var_11) {
    var_37 = 0;
    var_10 = var_02 _meth_8231(var_00, var_05, var_06, var_08, var_07);
  }

  if(isdefined(var_01) && isplayer(var_01) && isdefined(var_05) && isdefined(var_06) && isdefined(var_08) && isdefined(var_07)) {
    var_44 = scripts\mp\utility\game::getweaponrootname(var_06);
    var_45 = var_01 _meth_8519(var_06);

    if(isdefined(var_44) && var_44 == "iw7_rvn" && scripts\mp\utility\game::istrue(var_45) && var_05 == "MOD_MELEE") {
      var_10 = var_02 _meth_8231(var_01, "MOD_EXPLOSIVE", var_06, var_08, var_07);
      var_46 = getweaponvariantindex(var_06);

      if(!isdefined(var_46) || var_46 != 3 && var_46 != 35)
        playloopsound(var_2.origin, "melee_user2_human_default_fatal_npc");
    }
  }

  if(!isdefined(self.nocorpse)) {
    var_2.body = var_02 getplayerweaponrankxp(var_10);

    if(var_02 _meth_84CA())
      var_2.body setscriptablepartstate("chargeModeShieldDrop", "active", 0);

    if(scripts\mp\utility\game::istrue(level.func_DC24)) {
      thread scripts\mp\weapons::throwingknife_detachknivesfromcorpse(var_2.body);
      thread scripts\mp\weapons::axedetachfromcorpse(var_2.body);
    }
  }

  if(!isdefined(self.nocorpse) && isdefined(var_2.body)) {
    var_2.body.targetname = "player_corpse";

    if(scripts\engine\utility::isbulletdamage(var_05) && scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_06) == "iw7_atomizer_mp" || var_06 == "nuke_mp") {
      var_47 = undefined;

      if(var_06 == "nuke_mp")
        var_47 = "ks_nuke_death_npc";

      var_2.body thread scripts\mp\archetypes\archassassin_utility::playbodyfx(var_47);
      var_2.body hide(1);
    }

    enqueueweapononkillcorpsetablefuncs(var_01, var_02, var_00, var_06, var_05);
    var_02 thread callcorpsetablefuncs();

    if(var_11) {
      var_02 playerhide();
      var_02 setsolid(0);
    }

    if(var_02 isonladder() || var_02 ismantling() || !var_02 isonground() || isdefined(var_2.nuked) || isdefined(var_2.customdeath) || scripts\mp\utility\game::isragdollzerog()) {
      var_48 = 0;

      if(var_05 == "MOD_MELEE") {
        if(isdefined(var_2.isplanting) && var_2.isplanting || isdefined(var_2.nuked))
          var_48 = 1;
      }

      if(!var_48 || scripts\mp\utility\game::isragdollzerog()) {
        var_2.body startragdoll(1);
        var_02 notify("start_instant_ragdoll", var_05, var_00);
      }
    }

    if(!isdefined(var_2.switching_teams)) {
      if(isdefined(var_01) && isplayer(var_01) && !var_01 scripts\mp\utility\game::_hasperk("specialty_silentkill"))
        thread scripts\mp\deathicons::func_17C1(var_2.body, var_02, var_2.team, 5.0);
    }

    thread delaystartragdoll(var_2.body, var_08, var_07, var_06, var_00, var_05);
  } else if(isdefined(self.nocorpse)) {
    var_2.body = var_02 getplayerweaponrankxp(var_10);
    var_2.body hide(1);

    if(level.mapname == "mp_neon") {
      thread scripts\mp\weapons::throwingknife_detachknivesfromcorpse(var_2.body);
      thread scripts\mp\weapons::axedetachfromcorpse(var_2.body);
    }
  }

  var_02 thread scripts\mp\supers::handledeath();
  updatecombatrecordkillstats(var_01, var_02, var_05, var_06);
  var_02 thread[[level.onplayerkilled]](var_00, var_01, var_03, var_05, var_06, var_07, var_08, var_09, var_10, var_39);

  if(isai(var_02) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["on_killed"]))
    var_02 thread[[level.bot_funcs["on_killed"]]](var_00, var_01, var_03, var_05, var_06, var_07, var_08, var_09, var_10, var_39);

  if(scripts\mp\utility\game::isgameparticipant(var_01))
    var_49 = var_01 getentitynumber();
  else
    var_49 = -1;

  if(!isdefined(var_43))
    var_43 = var_02 scripts\mp\killcam::func_7F32(var_01, var_00, var_06);

  if(isdefined(level.matchrecording_logeventmsg) && isdefined(var_00) && isplayer(var_00) && scripts\engine\utility::isbulletdamage(var_05)) {
    var_50 = var_0.origin - self.origin;
    var_51 = vectornormalize((var_50[0], var_50[1], 0));
    var_52 = anglestoforward(self.angles);
    var_53 = vectornormalize((var_52[0], var_52[1], 0));
    var_54 = clamp(var_53[0] * var_51[0] + var_53[1] * var_51[1], -1.0, 1.0);
    var_55 = acos(var_54);

    if(!isdefined(self.func_D37E))
      self.func_D37E = [];

    self.func_D37E[self.func_D37E.size] = var_55;
    var_56 = 0.0;

    if(isdefined(self.engagementstarttime))
      var_56 = gettime() - self.engagementstarttime;

    if(!isdefined(self.engagementtimes))
      self.engagementtimes = [];

    self.engagementtimes[self.engagementtimes.size] = var_56;
    self.engagementstarttime = undefined;
  }

  var_57 = -1;
  var_58 = 0;

  if(isdefined(var_43)) {
    var_57 = var_43 getentitynumber();
    var_58 = var_43.birthtime;

    if(!isdefined(var_58))
      var_58 = 0;
  }

  var_59 = var_05 == "MOD_IMPACT" || var_05 == "MOD_HEADSHOT" && isdefined(var_00) || var_05 == "MOD_GRENADE" || isdefined(var_02) && isdefined(var_2.func_1117F) && isdefined(var_00) && var_2.func_1117F == var_00 || var_06 == "throwingknifec4_mp";

  if(!scripts\mp\utility\game::iskillstreakweapon(var_06))
    scripts\mp\killcam::func_F770(var_06, var_05, var_00);

  if(level.recordfinalkillcam && var_38) {
    if((!isdefined(level.disable_killcam) || !level.disable_killcam) && var_05 != "MOD_SUICIDE" && !(!isdefined(var_01) || var_1.classname == "trigger_hurt" || var_1.classname == "worldspawn" || var_01 == var_02))
      scripts\mp\finalkillcam::recordfinalkillcam(5.0, var_02, var_01, var_49, var_00, var_57, var_58, var_59, var_06, var_14, var_09, var_05);
  }

  var_02 setrankedplayerdata("common", "killCamHowKilled", 0);

  switch (var_05) {
    case "MOD_HEAD_SHOT":
      var_02 setrankedplayerdata("common", "killCamHowKilled", 1);
      break;
    default:
      break;
  }

  var_60 = undefined;

  if(var_37) {
    var_02 scripts\mp\killcam::func_D83E(var_00, var_01);

    if(isdefined(var_00) && isagent(var_00)) {
      var_60 = spawnstruct();
      var_60.agent_type = var_0.agent_type;
      var_60.lastspawntime = var_0.lastspawntime;
    }
  }

  if(!var_11) {
    self.respawntimerstarttime = gettime() + 1750;
    var_61 = scripts\mp\playerlogic::timeuntilspawn(1);

    if(var_61 < 1)
      var_61 = 1;

    var_02 thread scripts\mp\playerlogic::predictabouttospawnplayerovertime(var_61);
    wait 1.75;

    if(var_37)
      var_37 = !scripts\mp\finalkillcam::func_10266(0.5);

    var_02 notify("death_delay_finished");
  }

  var_62 = (gettime() - var_2.deathtime) / 1000;
  self.respawntimerstarttime = gettime();
  var_37 = var_37 && !var_02 scripts\mp\battlebuddy::func_3876();

  if(!(isdefined(var_2.cancelkillcam) && var_2.cancelkillcam) && var_37 && level.killcam && game["state"] == "playing" && !var_02 scripts\mp\utility\game::isusingremote() && !level.showingfinalkillcam) {
    var_63 = !(scripts\mp\utility\game::getgametypenumlives() && !var_2.pers["lives"]);
    var_61 = scripts\mp\playerlogic::timeuntilspawn(1);
    var_64 = var_63 && var_61 <= 0;

    if(!var_63) {
      var_61 = -1;
      level notify("player_eliminated", var_02);
    }

    if(!isdefined(var_01))
      var_65 = [];
    else
      var_65 = var_1.pers["loadoutPerks"];

    var_66 = undefined;

    if(isdefined(var_2.killsteakvariantattackerinfo))
      var_66 = var_2.killsteakvariantattackerinfo;

    var_02 scripts\mp\killcam::killcam(var_00, var_60, var_49, var_57, var_58, undefined, var_59, var_06, var_62 + var_14, var_09, var_61, scripts\mp\gamelogic::func_11939(), var_01, var_02, var_05, var_65, var_66);
  }

  if(game["state"] != "playing") {
    if(!level.showingfinalkillcam) {
      var_02 scripts\mp\utility\game::updatesessionstate("dead");
      var_02 scripts\mp\utility\game::clearkillcamstate();
    }

    return;
  }

  var_67 = scripts\mp\utility\game::getgametypenumlives();
  var_68 = self.pers["lives"];

  if(self == var_02 && isdefined(var_2.battlebuddy) && scripts\mp\utility\game::isreallyalive(var_2.battlebuddy) && (!scripts\mp\utility\game::getgametypenumlives() || self.pers["lives"]) && !var_02 scripts\mp\utility\game::isusingremote())
    scripts\mp\battlebuddy::func_136D6();

  if(scripts\mp\utility\game::isvalidclass(var_2.class)) {
    if(isdefined(level.func_1674) && level.func_1674.team == var_2.team)
      var_02 scripts\mp\killstreaks\orbital_deployment::func_10DD3("orbital_deployment", 1);
    else
      var_02 thread scripts\mp\playerlogic::spawnclient();
  }

  var_2.attacker = undefined;
}

isswitchingteams() {
  if(isdefined(self.switching_teams))
    return 1;

  return 0;
}

isteamswitchbalanced() {
  var_00 = scripts\mp\teams::countplayers();
  var_0[self.leaving_team]--;
  var_0[self.joining_team]++;
  return var_0[self.joining_team] - var_0[self.leaving_team] < 2;
}

isfriendlyfire(var_00, var_01) {
  if(!level.teambased)
    return 0;

  if(!isdefined(var_01))
    return 0;

  if(!isplayer(var_01) && !isdefined(var_1.team))
    return 0;

  if(var_0.team != var_1.team)
    return 0;

  if(var_00 == var_01)
    return 0;

  return 1;
}

killedself(var_00) {
  if(!isplayer(var_00))
    return 0;

  if(var_00 != self)
    return 0;

  return 1;
}

func_89F1() {
  if(!level.teambased) {
    return;
  }
  if(self.joining_team == "spectator" || !isteamswitchbalanced()) {
    thread scripts\mp\utility\game::giveunifiedpoints("suicide", undefined, undefined, 1, 1);
    scripts\mp\utility\game::incperstat("suicides", 1);
    self.suicides = scripts\mp\utility\game::getpersstat("suicides");
  }

  if(isdefined(level.onteamscore))
    [[level.onteamscore]](self);
}

handleworlddeath(var_00, var_01, var_02, var_03) {
  if(!isdefined(var_00)) {
    return;
  }
  if(!isdefined(var_0.team)) {
    handlesuicidedeath(var_02, var_03);
    return;
  }

  if(level.teambased && var_0.team != self.team || !level.teambased) {
    if(isdefined(level.onnormaldeath) && (isplayer(var_00) || isagent(var_00)) && var_0.team != "spectator") {
      if(!level.gameended)
        [[level.onnormaldeath]](self, var_00, var_01, var_02);
    }
  }
}

handlesuicidedeath(var_00, var_01) {
  thread scripts\mp\utility\game::giveunifiedpoints("suicide");
  scripts\mp\utility\game::incperstat("suicides", 1);
  self.suicides = scripts\mp\utility\game::getpersstat("suicides");
  var_02 = scripts\mp\tweakables::gettweakablevalue("game", "suicidepointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_02);

  if(scripts\mp\weapons::_meth_85BE() && var_00 == "MOD_SUICIDE" && var_01 == "none")
    self.lastgrenadesuicidetime = gettime();

  if(isdefined(level.onsuicidedeath))
    [[level.onsuicidedeath]](self);

  if(isdefined(self.friendlydamage))
    scripts\mp\hud_message::showerrormessage("MP_FRIENDLY_FIRE_WILL_NOT");
}

handlefriendlyfiredeath(var_00) {
  var_00 thread scripts\mp\rank::scoreeventpopup("teamkill");
  var_0.pers["teamkills"] = var_0.pers["teamkills"] + 1.0;
  var_0.teamkillsthisround++;

  if(scripts\mp\tweakables::gettweakablevalue("team", "teamkillpointloss")) {
    var_01 = scripts\mp\rank::getscoreinfovalue("kill");
    scripts\mp\gamescore::_setplayerscore(var_00, scripts\mp\gamescore::_getplayerscore(var_00) - var_01);
  }

  if(level.maxallowedteamkills < 0) {
    return;
  }
  if(level.ingraceperiod) {
    var_02 = 1;
    var_0.pers["teamkills"] = var_0.pers["teamkills"] + level.maxallowedteamkills;
  } else if(var_0.pers["teamkills"] > 1 && scripts\mp\utility\game::gettimepassed() < level._meth_8487 * 1000 + 8000 + var_0.pers["teamkills"] * 1000) {
    var_02 = 1;
    var_0.pers["teamkills"] = var_0.pers["teamkills"] + level.maxallowedteamkills;
  } else
    var_02 = var_00 scripts\mp\playerlogic::teamkilldelay();

  if(var_02 > 0) {
    var_0.pers["teamKillPunish"] = 1;
    var_00 scripts\mp\utility\game::_suicide();
  }
}

handlenormaldeath(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_01 thread scripts\mp\events::func_A651(var_00, self, var_03, var_04, var_06, var_02);

  if(var_04 == "MOD_HEAD_SHOT") {
    var_01 scripts\mp\utility\game::incperstat("headshots", 1);
    var_1.headshots = var_01 scripts\mp\utility\game::getpersstat("headshots");

    if(isdefined(var_1.laststand))
      var_07 = scripts\mp\rank::getscoreinfovalue("kill") * 2;
    else
      var_07 = undefined;

    var_01 playlocalsound("bullet_impact_headshot_plr");
    self playsound("bullet_impact_headshot");
  } else if(isdefined(var_1.laststand))
    var_07 = scripts\mp\rank::getscoreinfovalue("kill") * 2;
  else
    var_07 = undefined;

  var_08 = var_01;

  if(isdefined(var_1.commanding_bot))
    var_08 = var_1.commanding_bot;

  if(!scripts\mp\utility\game::istrue(level.ignorescoring) && !isfriendlyfire(var_05, var_01)) {
    var_08 scripts\mp\utility\game::incperstat("kills", 1, isdefined(level.ignorekdrstats));
    var_8.kills = var_08 scripts\mp\utility\game::getpersstat("kills");
    var_08 scripts\mp\utility\game::updatepersratio("kdRatio", "kills", "deaths", level.ignorekdrstats);
    var_08 scripts\mp\persistence::statsetchild("round", "kills", var_8.kills, level.ignorekdrstats);
  }

  self _meth_83FF();
  var_01 _meth_83FE();
  var_09 = var_1.pers["cur_kill_streak"];

  if(!scripts\mp\utility\game::istrue(level.ignorescoring) && (isalive(var_01) || var_1.streaktype == "support")) {
    if(var_04 == "MOD_MELEE" && !var_01 scripts\mp\utility\game::isjuggernaut() || var_01 scripts\mp\utility\game::func_A679(var_03))
      var_01 registerkill(var_03, var_04, 1);

    if(var_1.pers["cur_kill_streak"] > var_01 scripts\mp\utility\game::getpersstat("longestStreak"))
      var_01 scripts\mp\utility\game::func_F7DF("longestStreak", var_1.pers["cur_kill_streak"]);
  }

  var_1.pers["cur_death_streak"] = 0;

  if(!scripts\mp\utility\game::istrue(level.ignorescoring) && var_1.pers["cur_kill_streak"] > var_01 scripts\mp\persistence::statgetchild("round", "killStreak"))
    var_01 scripts\mp\persistence::statsetchild("round", "killStreak", var_1.pers["cur_kill_streak"]);

  if(!scripts\mp\utility\game::istrue(level.ignorescoring) && var_01 scripts\mp\utility\game::rankingenabled()) {
    if(var_1.pers["cur_kill_streak"] > var_1.kill_streak) {
      var_01 scripts\mp\persistence::func_10E54("killStreak", var_1.pers["cur_kill_streak"]);
      var_1.kill_streak = var_1.pers["cur_kill_streak"];
    }
  }

  if(!scripts\mp\utility\game::iskillstreakweapon(var_03)) {
    var_01 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_03);

    if(var_01 scripts\mp\utility\game::_hasperk("specialty_hardline") && isdefined(var_1.hardlineactive))
      var_01 thread scripts\mp\utility\game::givestreakpointswithtext("assist_hardline", var_03, undefined);
  }

  var_10 = scripts\mp\tweakables::gettweakablevalue("game", "deathpointloss");
  scripts\mp\gamescore::_setplayerscore(self, scripts\mp\gamescore::_getplayerscore(self) - var_10);

  if(isdefined(level.ac130player) && level.ac130player == var_01)
    level notify("ai_killed", self, var_01, var_04, var_03);

  if(isdefined(var_1.odin))
    level notify("odin_killed_player", self);

  level notify("player_got_killstreak_" + var_1.pers["cur_kill_streak"], var_01);
  var_01 notify("got_killstreak", var_1.pers["cur_kill_streak"]);
  var_01 notify("killed_enemy", self, var_03, var_04);

  if(isdefined(level.onnormaldeath) && var_1.pers["team"] != "spectator" && !isdefined(level.ignorescoring))
    [[level.onnormaldeath]](self, var_01, var_00, var_04, var_03);

  level thread scripts\mp\battlechatter_mp::saylocalsounddelayed(var_01, "kill", 0.75);
  var_11 = undefined;

  switch (var_5.loadoutarchetype) {
    case "archetype_assault":
      var_11 = "plr_killfirm_warfighter";
      break;
    case "archetype_assassin":
      var_11 = "plr_killfirm_ftl";
      break;
    case "archetype_heavy":
      var_11 = "plr_killfirm_merc";
      break;
    case "archetype_scout":
      var_11 = "plr_killfirm_c6";
      break;
    case "archetype_engineer":
      var_11 = "plr_killfirm_stryker";
      break;
    case "archetype_sniper":
      var_11 = "plr_killfirm_ghost";
      break;
  }

  if(isdefined(var_11))
    level thread scripts\mp\battlechatter_mp::saytoself(var_01, var_11, "plr_killfirm_generic", 0.75);

  if(isdefined(self.func_A93F) && isdefined(self.func_A940) && self.func_A93F != var_01) {
    if(gettime() - self.func_A940 < 2500)
      self.func_A93F thread scripts\mp\gamescore::processshieldassist(self);
    else if(isalive(self.func_A93F) && gettime() - self.func_A940 < 5000) {
      var_12 = vectornormalize(anglestoforward(self.angles));
      var_13 = vectornormalize(self.func_A93F.origin - self.origin);

      if(vectordot(var_13, var_12) > 0.925)
        self.func_A93F thread scripts\mp\gamescore::processshieldassist(self);
    }
  }

  scripts\mp\gamescore::awardbuffdebuffassists(var_01, self);

  if(isdefined(self.attackers)) {
    foreach(var_15 in self.attackers) {
      if(!isdefined(scripts\mp\utility\game::_validateattacker(var_15))) {
        continue;
      }
      if(var_15 == var_01) {
        continue;
      }
      if(self == var_15) {
        continue;
      }
      if(isdefined(level.assists_disabled)) {
        continue;
      }
      var_16 = undefined;

      if(isdefined(self.attackerdata)) {
        var_17 = self.attackerdata[var_15.guid];

        if(isdefined(var_17))
          var_16 = var_17.weapon;
      }

      var_18 = 0;

      if(self.attackerdata[var_15.guid].damage >= 75)
        var_18 = 1;

      var_15 thread scripts\mp\gamescore::processassist(self, var_16, var_18);

      if(var_15 scripts\mp\utility\game::_hasperk("specialty_boom"))
        var_05 thread scripts\mp\perks\perkfunctions::setboominternal(var_15);
    }
  }

  if(isdefined(self.markedbyboomperk)) {
    foreach(var_15 in level.players) {
      if(var_15.team == self.team) {
        continue;
      }
      if(scripts\engine\utility::array_contains(self.attackers, var_15)) {
        continue;
      }
      if(scripts\mp\utility\game::func_2287(self.markedbyboomperk, var_15 scripts\mp\utility\game::getuniqueid()))
        var_15 thread scripts\mp\gamescore::processassist(self, var_03);
    }
  }

  if(level.teambased) {
    if(isdefined(level.uavmodels[var_1.team]) && level.uavmodels[var_1.team].size > 0) {
      var_22 = [];

      foreach(var_24 in level.uavmodels[var_1.team]) {
        if(isdefined(var_24) && isdefined(var_24.owner) && var_24.owner != var_01 && !scripts\engine\utility::exist_in_array_MAYBE(var_22, var_24.uavtype)) {
          var_25 = undefined;

          if(scripts\mp\killstreaks\utility::func_A69F(var_24.streakinfo, "passive_extra_assist"))
            var_25 = 20;

          var_24.owner thread scripts\mp\utility\game::giveunifiedpoints(var_24.uavtype + "_assist", undefined, var_25);
          var_22[var_22.size] = var_24.uavtype;
          scripts\mp\missions::func_D9BC(var_24.owner, var_24.uavtype);
          var_24.owner scripts\mp\utility\game::bufferednotify("update_uav_assist_buffered");
          var_24.owner combatrecordkillstreakstat(var_24.uavtype);
        }
      }
    }
  }

  if(isdefined(self.func_12AF8))
    self.func_12AF8 = [];
}

func_9EFE(var_00) {
  if(weaponclass(var_00) == "non-player")
    return 0;

  if(weaponclass(var_00) == "turret")
    return 0;

  if(weaponinventorytype(var_00) == "primary" || weaponinventorytype(var_00) == "altmode")
    return 1;

  return 0;
}

callback_playerkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  playerkilled_internal(var_00, var_01, self, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, 0);
}

func_DB98(var_00) {
  var_01 = 5;

  if(!isdefined(level.func_FCA4))
    level.func_FCA4 = [];

  if(level.func_FCA4.size >= var_01) {
    var_02 = level.func_FCA4.size - 1;
    level.func_FCA4[0] delete();

    for (var_03 = 0; var_03 < var_02; var_3++)
      level.func_FCA4[var_03] = level.func_FCA4[var_03 + 1];

    level.func_FCA4[var_02] = undefined;
  }

  level.func_FCA4[level.func_FCA4.size] = var_00;
}

launchshield(var_00, var_01) {
  if(isdefined(self.hasriotshieldequipped) && self.hasriotshieldequipped) {
    if(isdefined(self.riotshieldmodel))
      scripts\mp\utility\game::riotshield_detach(1);
    else if(isdefined(self.riotshieldmodelstowed))
      scripts\mp\utility\game::riotshield_detach(0);
  }
}

func_3E0D() {
  if(level.diehardmode != 1)
    return 0;

  if(!scripts\mp\utility\game::getgametypenumlives())
    return 0;

  if(level.livescount[self.team] > 0)
    return 0;

  foreach(var_01 in level.players) {
    if(!isalive(var_01)) {
      continue;
    }
    if(var_1.team != self.team) {
      continue;
    }
    if(var_01 == self) {
      continue;
    }
    if(!var_1.inlaststand)
      return 0;
  }

  foreach(var_01 in level.players) {
    if(!isalive(var_01)) {
      continue;
    }
    if(var_1.team != self.team) {
      continue;
    }
    if(var_1.inlaststand && var_01 != self)
      var_01 func_AA07(0);
  }

  return 1;
}

checkkillsteal(var_00) {
  if(scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  var_01 = 0;
  var_02 = undefined;

  if(isdefined(var_0.attackerdata) && var_0.attackerdata.size > 1) {
    foreach(var_04 in var_0.attackerdata) {
      if(var_4.damage > var_01) {
        var_01 = var_4.damage;
        var_02 = var_4.attackerent;
      }
    }
  }
}

resetplayervariables() {
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  scripts\mp\gameobjects::detachusemodels();
}

resetplayeromnvarsonspawn() {
  self setclientomnvar("ui_carrying_bomb", 0);
  self setclientomnvar("ui_objective_state", 0);
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_light_armor", 0);
  self setclientomnvar("ui_juiced_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self setclientomnvar("ui_edge_glow", 0);
}

hitlocdebug(var_00, var_01, var_02, var_03, var_04) {
  var_05 = [];
  var_5[0] = 2;
  var_5[1] = 3;
  var_5[2] = 5;
  var_5[3] = 7;

  if(!getdvarint("scr_hitloc_debug")) {
    return;
  }
  if(!isdefined(var_0.hitlocinited)) {
    for (var_06 = 0; var_06 < 6; var_6++)
      var_00 setclientdvar("ui_hitloc_" + var_06, "");

    var_0.hitlocinited = 1;
  }

  if(level.splitscreen || !isplayer(var_00)) {
    return;
  }
  var_07 = 6;

  if(!isdefined(var_0.damageinfo)) {
    var_0.damageinfo = [];

    for (var_06 = 0; var_06 < var_07; var_6++) {
      var_0.damageinfo[var_06] = spawnstruct();
      var_0.damageinfo[var_06].damage = 0;
      var_0.damageinfo[var_06].hitloc = "";
      var_0.damageinfo[var_06].bp = 0;
      var_0.damageinfo[var_06].jugg = 0;
      var_0.damageinfo[var_06].colorindex = 0;
    }

    var_0.damageinfocolorindex = 0;
    var_0.damageinfovictim = undefined;
  }

  for (var_06 = var_07 - 1; var_06 > 0; var_6--) {
    var_0.damageinfo[var_06].damage = var_0.damageinfo[var_06 - 1].damage;
    var_0.damageinfo[var_06].hitloc = var_0.damageinfo[var_06 - 1].hitloc;
    var_0.damageinfo[var_06].bp = var_0.damageinfo[var_06 - 1].bp;
    var_0.damageinfo[var_06].jugg = var_0.damageinfo[var_06 - 1].jugg;
    var_0.damageinfo[var_06].colorindex = var_0.damageinfo[var_06 - 1].colorindex;
  }

  var_0.damageinfo[0].damage = var_02;
  var_0.damageinfo[0].hitloc = var_03;
  var_0.damageinfo[0].bp = var_04 & level.idflags_penetration;
  var_0.damageinfo[0].jugg = var_01 scripts\mp\utility\game::isjuggernaut();

  if(isdefined(var_0.damageinfovictim) && var_0.damageinfovictim != var_01) {
    var_0.damageinfocolorindex++;

    if(var_0.damageinfocolorindex == var_5.size)
      var_0.damageinfocolorindex = 0;
  }

  var_0.damageinfovictim = var_01;
  var_0.damageinfo[0].colorindex = var_0.damageinfocolorindex;

  for (var_06 = 0; var_06 < var_07; var_6++) {
    var_08 = "^" + var_5[var_0.damageinfo[var_06].colorindex];

    if(var_0.damageinfo[var_06].hitloc != "") {
      var_09 = var_08 + var_0.damageinfo[var_06].hitloc;

      if(var_0.damageinfo[var_06].bp)
        var_09 = var_09 + " (BP)";

      if(var_0.damageinfo[var_06].jugg)
        var_09 = var_09 + " (Jugg)";

      var_00 setclientdvar("ui_hitloc_" + var_06, var_09);
    }

    var_00 setclientdvar("ui_hitloc_damage_" + var_06, var_08 + var_0.damageinfo[var_06].damage);
  }
}

giverecentshieldxp() {
  self endon("death");
  self endon("disconnect");
  self notify("giveRecentShieldXP");
  self endon("giveRecentShieldXP");
  self.recentshieldxp++;
  wait 20.0;
  self.recentshieldxp = 0;
}

updateinflictorstat(var_00, var_01, var_02) {
  if(!isdefined(var_00) || !isdefined(var_0.alreadyhit) || !var_0.alreadyhit || !scripts\mp\utility\game::issinglehitweapon(var_02))
    scripts\mp\gamelogic::setinflictorstat(var_00, var_01, var_02);

  if(isdefined(var_00))
    var_0.alreadyhit = 1;
}

func_100C1(var_00) {
  switch (var_00) {
    case "stealth_bomb_mp":
    case "artillery_mp":
      return 0;
  }

  return 1;
}

addattacker(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(!isdefined(var_0.attackerdata))
    var_0.attackerdata = [];

  if(!isdefined(var_0.attackerdata[var_1.guid])) {
    var_0.attackers[var_1.guid] = var_01;
    var_0.attackerdata[var_1.guid] = spawnstruct();
    var_0.attackerdata[var_1.guid].damage = 0;
    var_0.attackerdata[var_1.guid].attackerent = var_01;
    var_0.attackerdata[var_1.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_1.guid].hits = 1;
  } else
    var_0.attackerdata[var_1.guid].hits++;

  if(scripts\mp\utility\game::iscacprimaryweapon(var_03) && !scripts\mp\utility\game::iscacsecondaryweapon(var_03))
    var_0.attackerdata[var_1.guid].isprimary = 1;

  if(isdefined(var_09) && var_09 != "MOD_MELEE")
    var_0.attackerdata[var_1.guid].didnonmeleedamage = 1;

  var_10 = scripts\mp\utility\game::getequipmenttype(var_03);

  if(isdefined(var_10)) {
    if(var_10 == "lethal") {
      var_0.attackerdata[var_1.guid].diddamagewithlethalequipment = 1;
      var_01 scripts\mp\contractchallenges::contractequipmentdamagedplayer(var_00, var_03, var_02);
    }

    if(var_10 == "tactical") {
      var_0.attackerdata[var_1.guid].diddamagewithtacticalequipment = 1;
      var_01 scripts\mp\contractchallenges::contractequipmentdamagedplayer(var_00, var_03, var_02);
    }
  }

  var_0.attackerdata[var_1.guid].damage = var_0.attackerdata[var_1.guid].damage + var_04;
  var_0.attackerdata[var_1.guid].weapon = var_03;
  var_0.attackerdata[var_1.guid].vpoint = var_05;
  var_0.attackerdata[var_1.guid].vdir = var_06;
  var_0.attackerdata[var_1.guid].shitloc = var_07;
  var_0.attackerdata[var_1.guid].psoffsettime = var_08;
  var_0.attackerdata[var_1.guid].smeansofdeath = var_09;
  var_0.attackerdata[var_1.guid].attackerent = var_01;
  var_0.attackerdata[var_1.guid].lasttimedamaged = gettime();

  if(isdefined(var_02) && !isplayer(var_02) && isdefined(var_2.primaryweapon))
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_2.primaryweapon;
  else if(isdefined(var_01) && isplayer(var_01) && var_01 getcurrentprimaryweapon() != "none")
    var_0.attackerdata[var_1.guid].sprimaryweapon = var_01 getcurrentprimaryweapon();
  else
    var_0.attackerdata[var_1.guid].sprimaryweapon = undefined;
}

addattackerkillstreak(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10) {
  if(!isdefined(var_0.attackerdata))
    var_0.attackerdata = [];

  if(!isdefined(var_0.attackerdata[var_2.guid])) {
    var_0.attackers[var_2.guid] = var_02;
    var_0.attackerdata[var_2.guid] = spawnstruct();
    var_0.attackerdata[var_2.guid].damage = 0;
    var_0.attackerdata[var_2.guid].attackerent = var_02;
    var_0.attackerdata[var_2.guid].firsttimedamaged = gettime();
    var_0.attackerdata[var_2.guid].hits = 1;
  }

  var_0.attackerdata[var_2.guid].damage = var_0.attackerdata[var_2.guid].damage + var_01;
  var_0.attackerdata[var_2.guid].weapon = var_10;
  var_0.attackerdata[var_2.guid].vpoint = var_04;
  var_0.attackerdata[var_2.guid].vdir = var_03;
  var_0.attackerdata[var_2.guid].partname = var_08;
  var_0.attackerdata[var_2.guid].smeansofdeath = var_05;
  var_0.attackerdata[var_2.guid].attackerent = var_02;
  var_0.attackerdata[var_2.guid].lasttimedamaged = gettime();

  if(isdefined(var_02) && isplayer(var_02) && var_02 getcurrentprimaryweapon() != "none")
    var_0.attackerdata[var_2.guid].sprimaryweapon = var_02 getcurrentprimaryweapon();
  else
    var_0.attackerdata[var_2.guid].sprimaryweapon = undefined;
}

resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
}

removeoldattackersovertime() {
  self endon("damage");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isdefined(self.attackers)) {
    return;
  }
  for (;;) {
    var_00 = gettime();

    foreach(var_03, var_02 in self.attackers) {
      if(isdefined(var_02) && var_00 - self.attackerdata[var_03].lasttimedamaged < 2000) {
        continue;
      }
      self.attackers[var_03] = undefined;
      self.attackerdata[var_03] = undefined;
    }

    scripts\engine\utility::waitframe();
  }
}

callback_playerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  var_12 = callback_playerdamage_internal(var_00, var_01, self, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
}

finishplayerdamagewrapper(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(!isdefined(var_10))
    var_10 = 0.0;

  if(scripts\mp\utility\game::isusingremote() && var_02 >= self.health && !(var_03 & level.idflags_stun) && allowfauxdeath()) {
    if(!isdefined(var_07))
      var_07 = (0, 0, 0);

    if(!isdefined(var_01))
      var_01 = self;

    if(!isdefined(var_00))
      var_00 = var_01;

    playerkilled_internal(var_00, var_01, self, var_02, var_03, var_04, var_05, var_07, var_08, var_09, 0, 1);
  } else {
    if(!callback_killingblow(var_00, var_01, var_02 - var_02 * var_10, var_03, var_04, var_05, var_06, var_07, var_08, var_09)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    if(isplayer(self)) {
      if(!isdefined(var_12))
        var_12 = "";

      if(!isdefined(var_13))
        var_13 = 0;

      self finishplayerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    }
  }

  if(var_04 == "MOD_EXPLOSIVE_BULLET")
    self shellshock("damage_mp", getdvarfloat("scr_csmode"));

  damageshellshockandrumble(var_00, var_05, var_04, var_02, var_03, var_01);
}

callback_playerimpaled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  thread scripts\mp\weapons::impale(var_00, self, var_01, var_02, var_03, var_04, var_05, var_06, var_07);
}

allowfauxdeath() {
  if(!isdefined(level.allowfauxdeath))
    level.allowfauxdeath = 1;

  return level.allowfauxdeath;
}

callback_playerlaststand(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = spawnstruct();
  var_9.einflictor = var_00;
  var_9.attacker = var_01;
  var_9.idamage = var_02;
  var_9.attackerposition = var_1.origin;

  if(var_01 == self)
    var_9.smeansofdeath = "MOD_SUICIDE";
  else
    var_9.smeansofdeath = var_03;

  var_9.sweapon = var_04;

  if(isdefined(var_01) && isplayer(var_01) && var_01 getcurrentprimaryweapon() != "none")
    var_9.sprimaryweapon = var_01 getcurrentprimaryweapon();
  else
    var_9.sprimaryweapon = undefined;

  var_9.vdir = var_05;
  var_9.shitloc = var_06;
  var_9.laststandstarttime = gettime();
  var_10 = maydolaststand(var_04, var_03, var_06);

  if(isdefined(self.endgame))
    var_10 = 0;

  if(level.teambased && isdefined(var_1.team) && var_1.team == self.team)
    var_10 = 0;

  if(level.diehardmode) {
    if(level.teamcount[self.team] <= 1)
      var_10 = 0;
    else if(scripts\mp\utility\game::isteaminlaststand()) {
      var_10 = 0;
      scripts\mp\utility\game::func_A6C7(self.team);
    }
  }

  if(!var_10) {
    self.laststandparams = var_09;
    self.uselaststandparams = 1;
    scripts\mp\utility\game::_suicide();
  } else {
    self.inlaststand = 1;
    var_11 = spawnstruct();

    if(scripts\mp\utility\game::_hasperk("specialty_finalstand")) {
      var_11.func_119A8 = game["strings"]["final_stand"];
      var_11.func_92AE = "specialty_finalstand";
    } else if(scripts\mp\utility\game::_hasperk("specialty_c4death")) {
      var_11.func_119A8 = game["strings"]["c4_death"];
      var_11.func_92AE = "specialty_c4death";
    } else {
      var_11.func_119A8 = game["strings"]["last_stand"];
      var_11.func_92AE = "specialty_finalstand";
    }

    var_11.glowcolor = (1, 0, 0);
    var_11.sound = "mp_last_stand";
    var_11.func_5F36 = 2.0;
    self.health = 1;
    var_12 = "frag_grenade_mp";

    if(isdefined(level.ac130player) && isdefined(var_01) && level.ac130player == var_01)
      level notify("ai_crawling", self);

    if(scripts\mp\utility\game::_hasperk("specialty_finalstand")) {
      self.laststandparams = var_09;
      self.infinalstand = 1;
      var_13 = self _meth_8174();

      foreach(var_15 in var_13)
      scripts\mp\utility\game::_takeweapon(var_15);

      scripts\engine\utility::allow_usability(0);
      thread func_626F();
      thread func_AA11(20, 1);
    } else if(scripts\mp\utility\game::_hasperk("specialty_c4death")) {
      self.func_D8B0 = self.lastdroppableweaponobj;
      self.laststandparams = var_09;
      self takeallweapons();
      self giveweapon("c4death_mp", 0, 0);
      scripts\mp\utility\game::_switchtoweapon("c4death_mp");
      scripts\engine\utility::allow_usability(0);
      self.inc4death = 1;
      thread func_AA11(20, 0);
      thread func_53D3();
      thread func_53D2();
    } else {
      if(level.diehardmode) {
        var_01 thread scripts\mp\utility\game::giveunifiedpoints("kill", var_04);
        self.laststandparams = var_09;
        scripts\engine\utility::allow_weapon(0);
        thread func_AA11(20, 0);
        scripts\engine\utility::allow_usability(0);
        return;
      }

      self.laststandparams = var_09;
      var_17 = undefined;
      var_18 = self getweaponslistprimaries();

      foreach(var_15 in var_18) {
        if(scripts\mp\weapons::func_9F54(var_15))
          var_17 = var_15;
      }

      if(!isdefined(var_17)) {
        var_17 = "iw6_p226_mp";
        scripts\mp\utility\game::_giveweapon(var_17);
      }

      self givemaxammo(var_17);
      self getraidspawnpoint();
      scripts\engine\utility::allow_usability(0);

      if(!scripts\mp\utility\game::_hasperk("specialty_laststandoffhand"))
        self getquadrant();

      scripts\mp\utility\game::_switchtoweapon(var_17);
      thread func_AA11(10, 0);
    }
  }
}

func_54C8(var_00) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  wait(var_00);
  self.uselaststandparams = 1;
  scripts\mp\utility\game::_suicide();
}

func_53D3() {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("detonate");
  self.uselaststandparams = 1;
  func_3345();
}

func_53D2() {
  self endon("detonate");
  self endon("disconnect");
  self endon("joined_team");
  level endon("game_ended");
  self waittill("death");
  func_3345();
}

func_3345() {
  self playsound("detpack_explo_default");
  radiusdamage(self.origin, 312, 100, 100, self);

  if(isalive(self))
    scripts\mp\utility\game::_suicide();
}

func_626F() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility\game::freezecontrolswrapper(1);
  wait 0.3;
  scripts\mp\utility\game::freezecontrolswrapper(0);
}

func_AA11(var_00, var_01) {
  self endon("death");
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  level notify("player_last_stand");
  thread func_AA16();
  self.laststand = 1;

  if(!var_01 && (!isdefined(self.inc4death) || !self.inc4death)) {
    thread func_AA05();
    scripts\mp\utility\game::setlowermessage("last_stand", & "PLATFORM_COWARDS_WAY_OUT", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    thread func_AA09();
  }

  if(level.diehardmode == 1 && level.diehardmode != 2) {
    var_02 = spawn("script_model", self.origin);
    var_02 setmodel("tag_origin");
    var_02 setcursorhint("HINT_NOICON");
    var_02 sethintstring( & "PLATFORM_REVIVE");
    var_02 revivesetup(self);
    var_02 endon("death");
    var_03 = newteamhudelem(self.team);
    var_03 setshader("waypoint_revive", 8, 8);
    var_03 setwaypoint(1, 1);
    var_03 settargetent(self);
    var_03 thread func_5321(var_02);
    var_3.color = (0.33, 0.75, 0.24);
    scripts\mp\utility\game::playdeathsound();

    if(var_01) {
      wait(var_00);

      if(self.infinalstand)
        thread func_AA07(var_01, var_02);
    }

    return;
  } else if(level.diehardmode == 2) {
    thread func_AA09();
    var_02 = spawn("script_model", self.origin);
    var_02 setmodel("tag_origin");
    var_02 setcursorhint("HINT_NOICON");
    var_02 sethintstring( & "PLATFORM_REVIVE");
    var_02 revivesetup(self);
    var_02 endon("death");
    var_03 = newteamhudelem(self.team);
    var_03 setshader("waypoint_revive", 8, 8);
    var_03 setwaypoint(1, 1);
    var_03 settargetent(self);
    var_03 thread func_5321(var_02);
    var_3.color = (0.33, 0.75, 0.24);
    scripts\mp\utility\game::playdeathsound();

    if(var_01) {
      wait(var_00);

      if(self.infinalstand)
        thread func_AA07(var_01, var_02);
    }

    wait(var_00 / 3);
    var_3.color = (1, 0.64, 0);

    while (var_2.inuse)
      wait 0.05;

    scripts\mp\utility\game::playdeathsound();
    wait(var_00 / 3);
    var_3.color = (1, 0, 0);

    while (var_2.inuse)
      wait 0.05;

    scripts\mp\utility\game::playdeathsound();
    wait(var_00 / 3);

    while (var_2.inuse)
      wait 0.05;

    wait 0.05;
    thread func_AA07(var_01);
    return;
  }

  thread func_AA09();
  wait(var_00);
  thread func_AA07(var_01);
}

func_B4A2(var_00, var_01) {
  self endon("stop_maxHealthOverlay");
  self endon("revive");
  self endon("death");

  for (;;) {
    self.health = self.health - 1;
    self.maxhealth = var_00;
    wait 0.05;
    self.maxhealth = 50;
    self.health = self.health + 1;
    wait 0.5;
  }
}

func_AA07(var_00, var_01) {
  if(var_00) {
    self.laststand = undefined;
    self.infinalstand = 0;
    self notify("revive");
    scripts\mp\utility\game::clearlowermessage("last_stand");
    scripts\mp\playerlogic::laststandrespawnplayer();

    if(isdefined(var_01))
      var_01 delete();
  } else {
    self.uselaststandparams = 1;
    self.func_2A8A = 0;
    scripts\mp\utility\game::_suicide();
  }
}

func_AA05() {
  self endon("death");
  self endon("disconnect");
  self endon("game_ended");
  self endon("revive");

  for (;;) {
    if(self usebuttonpressed()) {
      var_00 = gettime();

      while (self usebuttonpressed()) {
        wait 0.05;

        if(gettime() - var_00 > 700) {
          break;
        }
      }

      if(gettime() - var_00 > 700) {
        break;
      }
    }

    wait 0.05;
  }

  thread func_AA07(0);
}

func_AA09() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("revive");

  while (!level.gameended) {
    self.health = 2;
    wait 0.05;
    self.health = 1;
    wait 0.5;
  }

  self.health = self.maxhealth;
}

func_AA16() {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  self waittill("death");
  scripts\mp\utility\game::clearlowermessage("last_stand");
  self.laststand = undefined;
}

maydolaststand(var_00, var_01, var_02) {
  if(var_01 == "MOD_TRIGGER_HURT")
    return 0;

  if(var_01 != "MOD_PISTOL_BULLET" && var_01 != "MOD_RIFLE_BULLET" && var_01 != "MOD_FALLING" && var_01 != "MOD_EXPLOSIVE_BULLET")
    return 0;

  if(var_01 == "MOD_IMPACT" && scripts\mp\weapons::func_9FA9(var_00))
    return 0;

  if(var_01 == "MOD_IMPACT" && (var_00 == "m79_mp" || issubstr(var_00, "gl_")))
    return 0;

  if(scripts\mp\utility\game::isheadshot(var_00, var_02, var_01))
    return 0;

  if(scripts\mp\utility\game::isusingremote())
    return 0;

  return 1;
}

ensurelaststandparamsvalidity() {
  if(!isdefined(self.laststandparams.attacker))
    self.laststandparams.attacker = self;
}

gethitlocheight(var_00) {
  switch (var_00) {
    case "neck":
    case "helmet":
    case "head":
      return 60;
    case "left_hand":
    case "right_hand":
    case "left_arm_lower":
    case "right_arm_lower":
    case "left_arm_upper":
    case "right_arm_upper":
    case "torso_upper":
    case "gun":
      return 48;
    case "torso_lower":
      return 40;
    case "right_leg_upper":
    case "left_leg_upper":
      return 32;
    case "right_leg_lower":
    case "left_leg_lower":
      return 10;
    case "right_foot":
    case "left_foot":
      return 5;
  }

  return 48;
}

delaystartragdoll(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(isdefined(var_00)) {
    var_06 = var_00 _meth_8112();

    if(animhasnotetrack(var_06, "ignore_ragdoll"))
      return;
  }

  if(isdefined(level.noragdollents) && level.noragdollents.size) {
    foreach(var_08 in level.noragdollents) {
      if(distancesquared(var_0.origin, var_8.origin) < 65536)
        return;
    }
  }

  wait 0.2;

  if(!isdefined(var_00)) {
    return;
  }
  if(var_00 _meth_81B7()) {
    return;
  }
  var_06 = var_00 _meth_8112();
  var_10 = 0.35;

  if(animhasnotetrack(var_06, "start_ragdoll")) {
    var_11 = getnotetracktimes(var_06, "start_ragdoll");

    if(isdefined(var_11))
      var_10 = var_11[0];
  }

  var_12 = var_10 * getanimlength(var_06);
  wait(var_12);

  if(isdefined(var_00))
    var_00 startragdoll();
}

func_7FCA() {
  var_00 = "";
  var_01 = 0;
  var_02 = getarraykeys(self.killedby);

  for (var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];

    if(self.killedby[var_04] <= var_01) {
      continue;
    }
    var_01 = self.killedby[var_04];
    var_05 = var_04;
  }

  return var_00;
}

func_7FC9() {
  var_00 = "";
  var_01 = 0;
  var_02 = getarraykeys(self.func_A653);

  for (var_03 = 0; var_03 < var_2.size; var_3++) {
    var_04 = var_2[var_03];

    if(self.func_A653[var_04] <= var_01) {
      continue;
    }
    var_01 = self.func_A653[var_04];
    var_00 = var_04;
  }

  return var_00;
}

damageshellshockandrumble(var_00, var_01, var_02, var_03, var_04, var_05) {
  thread scripts\mp\weapons::onweapondamage(var_00, var_01, var_02, var_03, var_05);

  if(!isai(self) && scripts\engine\utility::getdamagetype(var_02) != "bullet")
    self playrumbleonentity("damage_heavy");
}

revivesetup(var_00) {
  var_01 = var_0.team;
  self linkto(var_00, "tag_origin");
  self.owner = var_00;
  self.inuse = 0;
  self makeusable();
  updateusablebyteam(var_01);
  thread trackteamchanges(var_01);
  thread revivetriggerthink(var_01);
  thread deleteotpreview();
}

deleteotpreview() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("death", "disconnect");
  self delete();
}

updateusablebyteam(var_00) {
  foreach(var_02 in level.players) {
    if(var_00 == var_2.team && var_02 != self.owner) {
      self enableplayeruse(var_02);
      continue;
    }

    self disableplayeruse(var_02);
  }
}

trackteamchanges(var_00) {
  self endon("death");

  for (;;) {
    level waittill("joined_team");
    updateusablebyteam(var_00);
  }
}

func_11AF5(var_00) {
  self endon("death");

  for (;;) {
    level waittill("player_last_stand");
    updateusablebyteam(var_00);
  }
}

revivetriggerthink(var_00) {
  self endon("death");
  level endon("game_ended");

  for (;;) {
    self waittill("trigger", var_01);
    self.owner.func_2A8A = 1;

    if(isdefined(var_1.func_2A8A) && var_1.func_2A8A) {
      self.owner.func_2A8A = 0;
      continue;
    }

    self makeunusable();
    self.owner scripts\mp\utility\game::freezecontrolswrapper(1);
    var_02 = useholdthink(var_01);
    self.owner.func_2A8A = 0;

    if(!isalive(self.owner)) {
      self delete();
      return;
    }

    self.owner scripts\mp\utility\game::freezecontrolswrapper(0);

    if(var_02) {
      var_01 thread scripts\mp\hud_message::showsplash("reviver", scripts\mp\rank::getscoreinfovalue("reviver"));
      var_01 thread scripts\mp\utility\game::giveunifiedpoints("reviver");
      self.owner.laststand = undefined;
      self.owner scripts\mp\utility\game::clearlowermessage("last_stand");
      self.owner.movespeedscaler = 1;

      if(self.owner scripts\mp\utility\game::_hasperk("specialty_lightweight"))
        self.owner.movespeedscaler = scripts\mp\utility\game::lightweightscalar();

      self.owner scripts\engine\utility::allow_weapon(1);
      self.owner.maxhealth = 100;
      self.owner scripts\mp\weapons::updatemovespeedscale();
      self.owner scripts\mp\playerlogic::laststandrespawnplayer();
      self.owner scripts\mp\utility\game::giveperk("specialty_pistoldeath");
      self.owner.func_2A8A = 0;
      self delete();
      return;
    }

    self makeusable();
    updateusablebyteam(var_00);
  }
}

useholdthink(var_00, var_01) {
  var_02 = 3000;
  var_03 = spawn("script_origin", self.origin);
  var_03 hide();
  var_00 getweaponvariantattachments(var_03);
  var_00 getweaponrootname();
  var_00 scripts\engine\utility::allow_weapon(0);
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;

  if(isdefined(var_01))
    self.usetime = var_01;
  else
    self.usetime = var_02;

  var_04 = useholdthinkloop(var_00);
  self.inuse = 0;
  var_03 delete();

  if(isdefined(var_00) && scripts\mp\utility\game::isreallyalive(var_00)) {
    var_00 unlink();
    var_00 scripts\engine\utility::allow_weapon(1);
  }

  if(isdefined(var_04) && var_04) {
    self.owner thread scripts\mp\hud_message::showsplash("revived", undefined, var_00);
    self.owner.inlaststand = 0;
    return 1;
  }

  return 0;
}

useholdthinkloop(var_00) {
  level endon("game_ended");
  self.owner endon("death");
  self.owner endon("disconnect");

  while (scripts\mp\utility\game::isreallyalive(var_00) && var_00 usebuttonpressed() && self.curprogress < self.usetime && (!isdefined(var_0.laststand) || !var_0.laststand)) {
    self.curprogress = self.curprogress + 50 * self.userate;
    self.userate = 1;
    var_00 scripts\mp\gameobjects::updateuiprogress(self, 1);
    self.owner scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;
      var_00 scripts\mp\gameobjects::updateuiprogress(self, 0);
      self.owner scripts\mp\gameobjects::updateuiprogress(self, 0);
      return scripts\mp\utility\game::isreallyalive(var_00);
    }

    wait 0.05;
  }

  var_00 scripts\mp\gameobjects::updateuiprogress(self, 0);
  self.owner scripts\mp\gameobjects::updateuiprogress(self, 0);
  return 0;
}

callback_killingblow(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {
  if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && var_02 >= self.health && isdefined(self.combathigh) && self.combathigh == "specialty_endgame") {
    scripts\mp\utility\game::giveperk("specialty_endgame");
    return 0;
  }

  return 1;
}

func_612A(var_00) {
  physicsexplosionsphere(self.origin, 64, 64, 1);
  var_01 = [];

  for (var_02 = 0; var_02 < 360; var_02 = var_02 + 30) {
    var_03 = cos(var_02) * 16;
    var_04 = sin(var_02) * 16;
    var_05 = bullettrace(self.origin + (var_03, var_04, 4), self.origin + (var_03, var_04, -6), 1, self);

    if(isdefined(var_5["entity"]) && isdefined(var_5["entity"].targetname) && (var_5["entity"].targetname == "destructible_vehicle" || var_5["entity"].targetname == "destructible_toy"))
      var_1[var_1.size] = var_5["entity"];
  }

  if(var_1.size) {
    var_06 = spawn("script_origin", self.origin);
    var_06 hide();
    var_6.type = "soft_landing";
    var_6.func_5379 = var_01;
    radiusdamage(self.origin, 64, 100, 100, var_06);
    wait 0.1;
    var_06 delete();
  }
}

func_9DF9(var_00, var_01) {
  var_02 = anglestoforward(var_0.angles);
  var_02 = (var_2[0], var_2[1], 0);
  var_02 = vectornormalize(var_02);
  var_03 = var_0.origin - var_1.origin;
  var_03 = (var_3[0], var_3[1], 0);
  var_03 = vectornormalize(var_03);
  var_04 = vectordot(var_02, var_03);

  if(var_04 > 0)
    return 1;
  else
    return 0;
}

func_5321(var_00) {
  var_00 waittill("death");
  self destroy();
}

gamemodemodifyplayerdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(isdefined(var_01) && isplayer(var_01) && isalive(var_01)) {
    if(level.matchrules_damagemultiplier)
      var_02 = var_02 * level.matchrules_damagemultiplier;

    if(level.matchrules_vampirism)
      var_1.health = int(min(float(var_1.maxhealth), float(var_1.health + 20)));

    if(level.tactical) {
      var_08 = weaponclass(var_04);

      if(var_08 == "sniper" || var_08 == "spread" || issubstr(var_04, "iw7_udm45_mpl"))
        var_02 = var_02 * 0.7;

      switch (var_07) {
        case "neck":
        case "helmet":
        case "head":
          if(var_08 != "spread")
            var_02 = var_02 * 2;

          break;
        case "torso_upper":
          break;
        case "left_hand":
        case "right_hand":
        case "left_arm_lower":
        case "right_arm_lower":
        case "left_arm_upper":
        case "right_arm_upper":
        case "gun":
          break;
        case "torso_lower":
          break;
        case "right_leg_upper":
        case "left_leg_upper":
          break;
        case "right_foot":
        case "right_leg_lower":
        case "left_foot":
        case "left_leg_lower":
          break;
      }
    }
  }

  return var_02;
}

registerkill(var_00, var_01, var_02) {
  var_03 = scripts\mp\utility\game::iskillstreakweapon(var_00) && !(var_01 == "MOD_MELEE");

  if(!var_03)
    self.pers["cur_kill_streak_for_nuke"]++;

  self.pers["cur_kill_streak"]++;

  if(var_02)
    self notify("kill_streak_increased");

  var_04 = 25;

  if(scripts\mp\utility\game::_hasperk("specialty_hardline"))
    var_4--;

  if(!var_03 && self.pers["cur_kill_streak_for_nuke"] == var_04 && !scripts\mp\utility\game::isanymlgmatch()) {
    if(!isdefined(level.supportnuke) || level.supportnuke)
      suicide(var_04);
  }
}

suicide(var_00) {}

monitordamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  self endon("death");
  level endon("game_ended");

  if(!isdefined(var_05))
    var_05 = 0;

  self setcandamage(1);
  self.health = 999999;
  self.maxhealth = var_00;

  if(!isdefined(self.damagetaken) || scripts\mp\utility\game::istrue(var_06))
    self.damagetaken = 0;

  if(!isdefined(var_04))
    var_04 = 0;

  var_07 = 1;

  while (var_07) {
    self waittill("damage", var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21);
    var_17 = scripts\mp\utility\game::func_13CA1(var_17, var_21);

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_09)) {
      continue;
    }
    if(var_05)
      self playrumbleonentity("damage_light");

    if(var_04)
      logattackerkillstreak(self, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17);

    if(isdefined(self.helitype) && self.helitype == "littlebird") {
      if(!isdefined(self.attackers))
        self.attackers = [];

      var_22 = "";

      if(isdefined(var_09) && isplayer(var_09))
        var_22 = var_09 scripts\mp\utility\game::getuniqueid();

      if(isdefined(self.attackers[var_22]))
        self.attackers[var_22] = self.attackers[var_22] + var_08;
      else
        self.attackers[var_22] = var_08;
    }

    var_07 = monitordamageoneshot(var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_01, var_02, var_03, var_04);
  }
}

monitordamageoneshot(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13) {
  if(!isdefined(self))
    return 0;

  if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01))
    return 0;

  if(isdefined(var_01) && isdefined(var_1.owner))
    var_01 = var_1.owner;

  if(isdefined(var_01) && !scripts\mp\utility\game::isgameparticipant(var_01))
    return 1;

  if(isdefined(var_01) && !scripts\mp\weapons::friendlyfirecheck(self.owner, var_01))
    return 1;

  if(isdefined(var_09) && scripts\mp\weapons::isballweapon(var_09))
    return 1;

  var_14 = var_00;

  if(scripts\mp\weapons::func_66AA(var_09, var_04))
    return 1;

  if(isdefined(var_09)) {
    if(!isdefined(var_12))
      var_12 = ::modifydamage;

    var_14 = self[[var_12]](var_01, var_09, var_04, var_00, var_08);
  }

  if(var_14 <= 0)
    return 1;

  self.wasdamaged = 1;
  self.damagetaken = self.damagetaken + var_14;

  if(isdefined(var_08) && var_08 & level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isdefined(var_08) && var_08 & level.idflags_no_team_protection)
    self.wasdamagedfrombulletricochet = 1;

  if(var_13)
    scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_09, self, var_04);

  if(isdefined(var_01)) {
    if(isplayer(var_01))
      var_01 scripts\mp\damagefeedback::updatedamagefeedback(var_10);
  }

  if(self.damagetaken >= self.maxhealth) {
    self thread[[var_11]](var_01, var_09, var_04, var_00);
    return 0;
  }

  return 1;
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  if(isdefined(var_04) && (var_04 && level.idflags_no_team_protection))
    var_05 = 0.6 * var_03;
  else
    var_05 = var_03;

  var_05 = handleempdamage(var_01, var_02, var_05);
  var_05 = handlemissiledamage(var_01, var_02, var_05);
  var_05 = handlegrenadedamage(var_01, var_02, var_05);
  var_05 = handleapdamage(var_01, var_02, var_05);
  return var_05;
}

handlemissiledamage(var_00, var_01, var_02) {
  var_00 = scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00);
  var_03 = var_02;

  switch (var_00) {
    case "maverick_projectile_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "aamissile_projectile_mp":
    case "iw7_chargeshot_mp":
    case "iw7_lockon_mp":
    case "drone_hive_projectile_mp":
    case "bomb_site_mp":
      self.largeprojectiledamage = 1;
      var_03 = self.maxhealth + 1;
      break;
    case "remote_tank_projectile_mp":
    case "hind_missile_mp":
    case "hind_bomb_mp":
    case "switch_blade_child_mp":
      self.largeprojectiledamage = 0;
      var_03 = self.maxhealth + 1;
      break;
    case "a10_30mm_turret_mp":
    case "heli_pilot_turret_mp":
      self.largeprojectiledamage = 0;
      var_03 = var_03 * 2;
      break;
    case "sam_projectile_mp":
      self.largeprojectiledamage = 1;
      var_03 = var_02;
      break;
  }

  return var_03;
}

handlegrenadedamage(var_00, var_01, var_02) {
  if(isexplosivedamagemod(var_01)) {
    switch (var_00) {
      case "iw6_rgm_mp":
      case "proximity_explosive_mp":
      case "c4_mp":
        var_02 = var_02 * 3;
        break;
      case "iw6_mk32_mp":
      case "semtexproj_mp":
      case "bouncingbetty_mp":
      case "semtex_mp":
      case "frag_grenade_mp":
        var_02 = var_02 * 4;
        break;
      default:
        if(scripts\mp\utility\game::isstrstart(var_00, "alt_"))
          var_02 = var_02 * 3;

        break;
    }
  }

  return var_02;
}

handlemeleedamage(var_00, var_01, var_02) {
  if(var_01 == "MOD_MELEE")
    return self.maxhealth + 1;

  return var_02;
}

handleempdamage(var_00, var_01, var_02) {
  return var_02;
}

handleapdamage(var_00, var_01, var_02, var_03) {
  var_04 = 1.0;
  var_05 = level.armorpiercingmod - 1;

  if(scripts\mp\utility\game::isfmjdamage(var_00, var_01))
    var_04 = var_04 + var_05;

  var_06 = level.armorpiercingmodks - 1;

  if(isdefined(var_03) && var_03 scripts\mp\utility\game::_hasperk("specialty_armorpiercingks") && isdefined(self.streakname) && scripts\mp\weapons::isprimaryweapon(var_00) && scripts\engine\utility::isbulletdamage(var_01))
    var_04 = var_04 + var_06;

  return var_02 * var_04;
}

handleshotgundamage(var_00, var_01, var_02) {
  if(!isdefined(var_00))
    return var_02;

  if(var_00 == "none")
    return var_02;

  if(scripts\mp\utility\game::getweaponbasedsmokegrenadecount(var_00) == "iw7_claw_mp")
    return var_02;

  if(weaponclass(var_00) != "spread")
    return var_02;

  return int(min(150, var_02));
}

onkillstreakdamaged(var_00, var_01, var_02, var_03) {
  var_04 = undefined;

  if(isdefined(var_01) && isdefined(self.owner)) {
    if(isdefined(var_1.owner) && isplayer(var_1.owner))
      var_01 = var_1.owner;

    if(isplayer(var_01) && self.owner scripts\mp\utility\game::isenemy(var_01))
      var_04 = var_01;
  }

  if(isdefined(var_04))
    thread scripts\mp\missions::killstreakdamaged(var_00, self.owner, var_04, var_02, var_03);
}

onkillstreakkilled(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {
  var_09 = 0;
  var_10 = undefined;

  if(isdefined(var_01) && isdefined(self.owner)) {
    if(isdefined(var_1.owner) && isplayer(var_1.owner))
      var_01 = var_1.owner;

    if(self.owner scripts\mp\utility\game::isenemy(var_01))
      var_10 = var_01;
  }

  if(isdefined(var_10)) {
    var_10 notify("destroyed_killstreak", var_02);

    if(isdefined(var_07))
      thread scripts\mp\utility\game::teamplayercardsplash(var_07, var_10);

    scripts\mp\missions::setweaponammostock(self, var_10);
    thread scripts\mp\events::killedkillstreak(var_00, var_10);
    thread scripts\mp\missions::killstreakkilled(var_00, self.owner, self, undefined, var_10, var_04, var_03, var_02, var_05);
    var_09 = 1;
  }

  if(isdefined(self.owner) && isdefined(var_06))
    self.owner scripts\mp\utility\game::playkillstreakdialogonplayer(var_06, undefined, undefined, self.origin);

  if(!scripts\mp\utility\game::istrue(var_08))
    self notify("death");

  return var_09;
}

func_12EFD(var_00, var_01, var_02, var_03) {
  if(!isdefined(self.func_DDBE))
    self.func_DDBE = [];

  if(self.health >= self.maxhealth)
    func_41D5();

  var_04 = undefined;

  if(self.func_DDBE.size < 4) {
    var_04 = spawnstruct();
    self.func_DDBE[self.func_DDBE.size] = var_04;
  } else {
    for (var_05 = 0; var_05 < 3; var_5++)
      self.func_DDBE[var_05] = self.func_DDBE[var_05 + 1];

    var_04 = spawnstruct();
    self.func_DDBE[self.func_DDBE.size - 1] = var_04;
  }

  if(var_03 == "MOD_MELEE" && var_02 == "head")
    var_02 = "torso_upper";

  var_4.damage = int(min(var_00, self.health));
  var_4.attacker = var_01;
  var_4.location = var_02;
}

func_41D5() {
  self.func_DDBE = [];
}

updatedeathdetails(var_00, var_01) {
  var_02 = 0;

  if(isdefined(var_00) && isdefined(var_01)) {
    foreach(var_06, var_04 in var_00) {
      if(!isplayer(var_04)) {
        continue;
      }
      var_05 = var_04 getentitynumber();
      self setclientomnvar("ui_death_details_attacker_" + var_02, var_05);
      self setclientomnvar("ui_death_details_hits_" + var_02, int(min(var_1[var_06].hits, 10)));
      var_2++;

      if(var_02 >= 4) {
        break;
      }
    }
  }

  for (var_07 = var_02; var_07 < 4; var_7++)
    self setclientomnvar("ui_death_details_attacker_" + var_07, -1);
}

getindexfromhitloc(var_00) {
  switch (var_00) {
    case "torso_upper":
      return 0;
    case "torso_lower":
      return 1;
    case "helmet":
      return 2;
    case "head":
      return 3;
    case "neck":
      return 4;
    case "left_arm_upper":
      return 5;
    case "left_arm_lower":
      return 6;
    case "left_hand":
      return 7;
    case "right_arm_upper":
      return 8;
    case "right_arm_lower":
      return 9;
    case "right_hand":
      return 10;
    case "left_leg_upper":
      return 11;
    case "left_leg_lower":
      return 12;
    case "left_foot":
      return 13;
    case "right_leg_upper":
      return 14;
    case "right_leg_lower":
      return 15;
    case "right_foot":
      return 16;
    case "gun":
      return 17;
    case "none":
      return 18;
  }

  return 0;
}

showuidamageflash() {
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

updatecombatrecordkillstats(var_00, var_01, var_02, var_03) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  if(isdefined(var_00) && isplayer(var_00)) {
    var_00 combatrecordarchetypekill(var_0.loadoutarchetype);

    if(isdefined(var_03)) {
      var_04 = scripts\mp\utility\game::getequipmenttype(var_03);

      if(isdefined(var_04) && var_04 == "lethal") {
        var_05 = scripts\mp\powers::func_D737(var_03);
        var_00 combatrecordlethalkill(var_05);
      } else {
        var_06 = scripts\mp\missions::func_7F48(var_03);

        if(isdefined(var_06)) {
          if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_06))
            var_00 combatrecordkillstreakstat(var_06);
        }

        if(scripts\mp\utility\game::istrue(var_0.personalradaractive))
          var_00 combatrecordtacticalstat("power_periphVis");

        if(scripts\mp\utility\game::istrue(var_0.func_8BC2))
          var_00 combatrecordtacticalstat("power_adrenaline");
      }
    }
  }

  if(isdefined(var_01) && isplayer(var_01))
    var_01 combatrecordarchetypedeath(var_1.loadoutarchetype);
}

combatrecordarchetypekill(var_00) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_01 = self getrankedplayerdata("mp", "archetypeStats", var_00, "kills");
  self setrankedplayerdata("mp", "archetypeStats", var_00, "kills", var_01 + 1);
}

combatrecordarchetypedeath(var_00) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_01 = self getrankedplayerdata("mp", "archetypeStats", var_00, "deaths");
  self setrankedplayerdata("mp", "archetypeStats", var_00, "deaths", var_01 + 1);
}

combatrecordlethalkill(var_00) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_01 = self getrankedplayerdata("mp", "lethalStats", var_00, "kills");
  self setrankedplayerdata("mp", "lethalStats", var_00, "kills", var_01 + 1);
}

combatrecordtacticalstat(var_00, var_01) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  if(!isdefined(var_01))
    var_01 = 1;

  var_02 = self getrankedplayerdata("mp", "tacticalStats", var_00, "extraStat1");
  self setrankedplayerdata("mp", "tacticalStats", var_00, "extraStat1", var_02 + var_01);
}

combatrecordkillstreakstat(var_00) {
  if(!scripts\mp\utility\game::canrecordcombatrecordstats()) {
    return;
  }
  var_01 = scripts\mp\utility\game::getstreakrecordtype(var_00);

  if(!isdefined(var_01)) {
    return;
  }
  var_02 = self getrankedplayerdata("mp", var_01, var_00, "extraStat1");
  self setrankedplayerdata("mp", var_01, var_00, "extraStat1", var_02 + 1);
}

enqueuecorpsetablefunc(var_00, var_01) {
  if(!isdefined(self.corpsetablefuncs)) {
    self.corpsetablefuncs = [];
    self.corpsetablefunccounts = [];
  }

  if(!isdefined(self.corpsetablefuncs[var_00])) {
    self.corpsetablefuncs[var_00] = var_01;
    self.corpsetablefunccounts[var_00] = 0;
  }

  self.corpsetablefunccounts[var_00]++;
}

dequeuecorpsetablefunc(var_00) {
  if(!isdefined(self.corpsetablefuncs)) {
    return;
  }
  if(!isdefined(self.corpsetablefuncs[var_00])) {
    return;
  }
  self.corpsetablefunccounts[var_00]--;

  if(self.corpsetablefunccounts[var_00] <= 0) {
    self.corpsetablefuncs[var_00] = undefined;
    self.corpsetablefunccounts[var_00] = undefined;
  }
}

callcorpsetablefuncs() {
  if(!isdefined(self.corpsetablefuncs)) {
    return;
  }
  var_00 = self.body;

  foreach(var_02 in self.corpsetablefuncs)
  self thread[[var_02]](var_00);

  thread clearcorpsetablefuncs();
}

clearcorpsetablefuncs() {
  self notify("clearCorpsetableFuncs");
  self.corpsetablefuncs = undefined;
  self.corpsetablefunccounts = undefined;
}

enqueueweapononkillcorpsetablefuncs(var_00, var_01, var_02, var_03, var_04) {
  if(scripts\mp\weapons::isprimaryweapon(var_03)) {
    var_05 = scripts\mp\utility\game::getweaponrootname(var_03);
    var_06 = getweaponvariantindex(var_03);
    var_07 = var_00 _meth_8519(var_03);

    if(var_05 == "iw7_rvn" && scripts\mp\utility\game::istrue(var_07) && var_04 == "MOD_MELEE")
      var_01 thread enqueuecorpsetablefunc("passive_melee_cone_expl", scripts\mp\perks\weaponpassives::meleeconeexplodevictimcorpsefx);
  }
}