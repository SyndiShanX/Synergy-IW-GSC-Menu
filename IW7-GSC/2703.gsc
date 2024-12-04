/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2703.gsc
***************************************/

initbroshotfx() {
  level._effect["FX_BRO_LIGHT"] = loadfx("vfx\iw7\_requests\mp\broshot\vfx_bs_light_fill.vfx");
  level._effect["vfx_taunt_steel_dragon"] = loadfx("vfx\iw7\_requests\mp\frontend\vfx_taunt_steel_dragon.vfx");
  level._effect["vfx_bombard_antigrav_pre_expl"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_antigrav_pre_expl.vfx");
  level._effect["vfx_bombard_projectile_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_projectile_trail.vfx");
  level._effect["vfx_bombardment_strike_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_bombardment_strike_explosion.vfx");
  level._effect["vfx_tnt_crate_smk"] = loadfx("vfx\iw7\levels\mp_frontend\vfx_tnt_crate_smk.vfx");
}

forceinitbroshot() {
  level.forcebroshot = 1;
  setomnvar("ui_broshot_debug", 1);
  return initbroshot();
}

initbroshot(var_00) {
  level.camera_bro_shot = spawnstruct();
  level.camera_bro_shot.basecam = getent("camera_mp_broshot", "targetname");
  level.camera_bro_shot.char_loc[0] = getent("character_loc_broshot", "targetname");
  level.camera_bro_shot.char_loc[2] = getent("character_loc_broshot_a", "targetname");
  level.camera_bro_shot.char_loc[1] = getent("character_loc_broshot_b", "targetname");
  level.camera_bro_shot.char_loc[3] = getent("character_loc_broshot_c", "targetname");
  level.camera_bro_shot.char_loc[4] = getent("character_loc_broshot_d", "targetname");
  level.camera_bro_shot.char_loc[5] = getent("character_loc_broshot_e", "targetname");

  if((!isdefined(self) || !isdefined(level.camera_bro_shot.basecam) || !isdefined(level.teamlist) || !isdefined(level.teamlist["allies"]) || !isdefined(level.teamlist["axis"]) || level.teamlist["allies"].size == 0 && level.teamlist["axis"].size == 0) && !scripts\mp\utility\game::istrue(level.forcebroshot))
    return 0;

  if(level.teambased && !scripts\mp\utility\game::istrue(level.forcebroshot)) {
    if(!isdefined(var_00)) {
      var_01 = getteamscore("allies");
      var_02 = getteamscore("axis");

      if(var_01 == var_02)
        return 0;
    } else if(var_00 == "tie" || var_00 == "none" || var_00 == "draw")
      return 0;
  } else {
    var_03 = scripts\engine\utility::array_sort_with_func(level.players, ::compare_player_score);

    if(!scripts\mp\utility\game::istrue(level.forcebroshot) && var_3[0].score <= 0)
      return 0;
  }

  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc[0].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[0].angles) * 6.0;
  level.camera_bro_shot.char_loc[2].origin = level.camera_bro_shot.char_loc[2].origin + anglestoleft(level.camera_bro_shot.char_loc[2].angles) * 20.0;
  level.camera_bro_shot.char_loc[1].origin = level.camera_bro_shot.char_loc[1].origin + anglestoleft(level.camera_bro_shot.char_loc[1].angles) * 12.0;
  level.camera_bro_shot.char_loc[4].origin = level.camera_bro_shot.char_loc[4].origin + anglestoleft(level.camera_bro_shot.char_loc[4].angles) * 6.0;
  level.camera_bro_shot.char_loc[3].origin = level.camera_bro_shot.char_loc[3].origin + anglestoright(level.camera_bro_shot.char_loc[3].angles) * 0.0;
  level.camera_bro_shot.char_loc[5].origin = level.camera_bro_shot.char_loc[5].origin + anglestoleft(level.camera_bro_shot.char_loc[5].angles) * 18.0;
  level.camera_bro_shot.char_loc[4].origin = level.camera_bro_shot.char_loc[4].origin + anglestoforward(level.camera_bro_shot.char_loc[4].angles) * -46.0;
  level.camera_bro_shot.char_loc[3].origin = level.camera_bro_shot.char_loc[3].origin + anglestoforward(level.camera_bro_shot.char_loc[3].angles) * -46.0;
  level.camera_bro_shot.char_loc[5].origin = level.camera_bro_shot.char_loc[5].origin + anglestoforward(level.camera_bro_shot.char_loc[5].angles) * -46.0;
  setomnvar("ui_broshot_upside_down", scripts\mp\utility\game::istrue(level.upsidedowntaunts));

  for (var_04 = 3; var_04 < 6; var_4++) {
    if(scripts\mp\utility\game::istrue(level.upsidedowntaunts)) {
      var_05 = level.camera_bro_shot.char_loc[var_04].origin + (0, 0, 25);
      var_06 = (var_5[0], var_5[1], var_5[2] - 100);
    } else {
      var_05 = level.camera_bro_shot.char_loc[var_04].origin;
      var_06 = (var_5[0], var_5[1], var_5[2] + 100);
    }

    var_07 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    var_08 = physics_raycast(var_06, var_05, var_07, undefined, 1, "physicsquery_closest");
    var_09 = isdefined(var_08) && var_8.size > 0;

    if(var_09) {
      var_10 = var_8[0]["position"];
      level.camera_bro_shot.char_loc[var_04].origin = var_10;
    }
  }

  self.mvparray = [];
  return 1;
}

func_10D73(var_00) {
  if(!isdefined(var_00))
    var_00 = self;

  level.broshotrunning = 1;
  cleanupequipment();
  cleanupgamemodes();
  var_01 = spawnstruct();

  if(scripts\mp\utility\game::istrue(level.upsidedowntaunts)) {
    var_1.origin = level.camera_bro_shot.char_loc[0].origin + (30, -15, -95);
    var_1.angles = level.camera_bro_shot.basecam.angles + (162, 180, 0);
  } else {
    var_1.origin = level.camera_bro_shot.char_loc[0].origin;
    var_1.angles = level.camera_bro_shot.basecam.angles;
  }

  foreach(var_03 in level.players) {
    var_03 scripts\mp\playerlogic::respawn_asspectator(var_1.origin, var_1.angles);
    var_03 scripts\mp\gamelogic::freezeplayerforroundend();
    var_03 playerhide();
  }

  removeallcorpses();
  level.func_1623 = var_01;
  level.camera_anchor = spawn("script_model", var_1.origin);
  level.camera_anchor setmodel("tag_origin");
  level.camera_anchor.angles = var_1.angles;
  thread spawnfilllight();

  if(scripts\mp\utility\game::istrue(level.forcebroshot)) {
    if(level.teamlist["allies"].size > 1)
      level.topplayers = scripts\engine\utility::array_sort_with_func(level.teamlist["allies"], ::compare_player_score);
    else {
      level.topplayers = [];
      level.topplayers[0] = self;
    }
  } else if(level.teambased) {
    if(!isdefined(var_00)) {
      var_05 = getteamscore("allies");
      var_06 = getteamscore("axis");
      var_07 = scripts\engine\utility::ter_op(var_05 >= var_06, "allies", "axis");
    } else
      var_07 = var_00;

    level.topplayers = scripts\engine\utility::array_sort_with_func(level.teamlist[var_07], ::compare_player_score);
  } else
    level.topplayers = level.placement["all"];

  level.supergunout = [];
  level.interruptabletaunts = [];
  level.firsttaunttracker = [];

  foreach(var_03 in level.players)
  var_03 hideeffectsforbroshot();

  for (var_10 = 0; var_10 < 6; var_10++) {
    if(!isdefined(level.topplayers[var_10])) {
      break;
    }
    if(!isdefined(level.topplayers[var_10].loadoutarchetype)) {
      continue;
    }
    self.mvparray[var_10] = spawnstruct();

    if(level.gametype == "infect") {
      if(isbot(level.topplayers[var_10]))
        var_11 = level.topplayers[var_10].loadoutarchetype;
      else
        var_11 = level.topplayers[var_10] scripts\mp\class::cac_getcharacterarchetype();
    } else
      var_11 = level.topplayers[var_10].loadoutarchetype;

    var_12 = tablelookuprownum("mp\battleRigTable.csv", 1, var_11);

    if(isbot(level.topplayers[var_10]) || isdefined(level.topplayers[var_10].lastarchetypeinfo)) {
      var_13 = level.topplayers[var_10] getcustomizationbody();
      var_14 = level.topplayers[var_10] getcustomizationhead();
      var_15 = tablelookuprownum("mp\cac\heads.csv", 1, var_14);
      var_16 = tablelookuprownum("mp\cac\bodies.csv", 1, var_13);

      if(isdefined(level.topplayers[var_10].lastarchetypeinfo))
        var_12 = tablelookuprownum("mp\battleRigTable.csv", 1, level.topplayers[var_10].lastarchetypeinfo.archetype);
    } else {
      var_16 = level.topplayers[var_10] scripts\mp\teams::getplayermodelindex();
      var_15 = level.topplayers[var_10] scripts\mp\teams::getplayerheadmodel();
    }

    self.mvparray[var_10].rigindex = var_12;
    self.mvparray[var_10].bodyindex = var_16;
    self.mvparray[var_10].headindex = var_15;
    self.mvparray[var_10].weaponname = getdisplayweapon(level.topplayers[var_10]);
    self.mvparray[var_10].clantag = level.topplayers[var_10] getclantag();
    self.mvparray[var_10].name = level.topplayers[var_10].name;
    self.mvparray[var_10].xuid = level.topplayers[var_10] getxuid();
    self.mvparray[var_10].podiumindex = var_10;
    self.mvparray[var_10].clientnum = level.topplayers[var_10] getentitynumber();
    level.topplayers[var_10] setguntypeforui(var_10);
    level.topplayers[var_10].bro = makebrowinner(var_10, level.camera_bro_shot.char_loc[var_10]);
  }

  foreach(var_03 in level.players) {
    var_03 setsoundsubmix("mp_broshot");
    var_03 setsolid(0);
    var_03 dontinterpolate();

    if(isbot(var_03)) {
      continue;
    }
    var_03 cameralinkto(level.camera_anchor, "tag_origin", 1);
    var_03 thread scripts\mp\utility\game::func_F8A0(0.0);
    scripts\mp\utility\game::_visionsetnaked("", 0);

    if(!scripts\mp\utility\game::istrue(level.forcebroshot))
      var_03 thread fadetoblack(1.5);
  }

  level.camera_anchor scriptmodelplayanimdeltamotion("iw7_mp_brodium_cam");
  thread tauntinputlisten(level.topplayers);
  level thread onplayerconnect();
  startpodium(-1, self.mvparray);
  return 13.5;
}

hideeffectsforbroshot() {
  if(self.sessionteam == "spectator") {
    return;
  }
  if(!isdefined(self.loadoutarchetype)) {
    return;
  }
  self setscriptablepartstate("cloak", "offImmediate", 1);
  self setscriptablepartstate("jet_pack", "off", 1);
  self setscriptablepartstate("teamColorPins", "off", 1);
  self setscriptablepartstate("armorUpMaterial", "offImmediate", 1);
  self setscriptablepartstate("armorUp", "neutral", 1);
  self setscriptablepartstate("light_armor", "neutral", 1);
  self setscriptablepartstate("adrenaline", "neutral", 1);
  self setscriptablepartstate("adrenalineHeal", "neutral", 1);
  self setscriptablepartstate("pts_drone", "off", 1);
}

spawnfilllight() {
  scripts\engine\utility::waitframe();
  playfxontag(scripts\engine\utility::getfx("FX_BRO_LIGHT"), level.camera_anchor, "tag_origin");
}

fadetoblack(var_00) {
  wait 12.0;
  scripts\mp\utility\game::_visionsetnaked("", 0);

  foreach(var_02 in level.players) {
    if(isbot(var_02)) {
      continue;
    }
    var_02 visionsetfadetoblackforplayer("bw", var_00);
  }
}

cleanupequipment() {
  self notify("bro_shot_start");
  scripts\mp\weapons::deleteallgrenades();
  var_00 = getweaponarray();

  if(isdefined(var_00)) {
    foreach(var_02 in var_00)
    var_02 delete();
  }
}

cleanupgamemodes() {
  if(isdefined(level.teamflags)) {
    if(isdefined(level.teamflags[game["attackers"]]) && isdefined(level.teamflags[game["attackers"]].visuals)) {
      for (var_00 = 0; var_00 < level.teamflags[game["attackers"]].visuals.size; var_0++)
        level.teamflags[game["attackers"]].visuals[var_00] hide();
    }

    if(isdefined(level.teamflags[game["defenders"]]) && isdefined(level.teamflags[game["defenders"]].visuals)) {
      for (var_00 = 0; var_00 < level.teamflags[game["defenders"]].visuals.size; var_0++)
        level.teamflags[game["defenders"]].visuals[var_00] hide();
    }
  }

  if((level.gametype == "dom" || level.gametype == "siege") && isdefined(level.domflags)) {
    foreach(var_02 in level.domflags) {
      if(isdefined(var_02)) {
        var_2.scriptable setscriptablepartstate("flag", "off");
        var_2.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if(level.gametype == "grind" && isdefined(level.func_13FC1)) {
    foreach(var_05 in level.func_13FC1) {
      if(isdefined(var_05) && isdefined(var_5.scriptable)) {
        var_5.scriptable setscriptablepartstate("flag", "off");
        var_5.scriptable setscriptablepartstate("pulse", "off");
      }
    }
  }

  if((level.gametype == "sr" || level.gametype == "dd" | level.gametype == "sd") && isdefined(level.bombzones)) {
    foreach(var_08 in level.bombzones) {
      if(isdefined(var_08) && isdefined(var_8.visuals)) {
        for (var_09 = 0; var_09 < var_8.visuals.size; var_9++) {
          if(isdefined(var_8.visuals[var_09]))
            var_8.visuals[var_09] hide();
        }
      }
    }
  }

  if(level.gametype == "front" && isdefined(level.zones)) {
    foreach(var_05 in level.zones) {
      if(isdefined(var_05) && isdefined(var_5.visuals)) {
        for (var_09 = 0; var_09 < var_5.visuals.size; var_9++)
          var_5.visuals[var_09] hide();
      }
    }
  }

  if(scripts\mp\utility\game::istrue(level.dogtagsenabled)) {
    if(isdefined(level.dogtags)) {
      foreach(var_14 in level.dogtags) {
        if(isdefined(var_14) && isdefined(var_14.visuals)) {
          for (var_09 = 0; var_09 < var_14.visuals.size; var_9++)
            var_14.visuals[var_09] hide();
        }
      }
    }
  }

  if(isdefined(level.balls)) {
    foreach(var_17 in level.balls)
    var_17.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
  }

  if((level.gametype == "koth" || level.gametype == "grnd") && isdefined(level.zones)) {
    foreach(var_05 in level.zones) {
      if(isdefined(var_05) && isdefined(var_5.useobj) && isdefined(var_5.useobj.chevrons)) {
        foreach(var_21 in var_5.useobj.chevrons) {
          for (var_09 = 0; var_09 < var_21.numchevrons; var_9++)
            var_21 setscriptablepartstate("chevron_" + var_09, "off");
        }
      }
    }
  }
}

tauntinputlisten(var_00) {
  wait 3.0;

  for (var_01 = 0; var_01 < 3; var_1++) {
    if(!isdefined(var_0[var_01]) || isbot(var_0[var_01])) {
      continue;
    }
    var_0[var_01] thread listenfortauntinput(var_01);
  }
}

getdisplayweapon(var_00) {
  var_01 = var_0.lastdroppableweaponobj;

  if(!issubstr(var_01, var_0.pers["primaryWeapon"]) && !issubstr(var_01, var_0.pers["secondaryWeapon"]))
    var_01 = var_0.spawnweaponobj;

  if(issubstr(var_01, "iw7_fists_mp") || issubstr(var_01, "iw7_knife") || issubstr(var_01, "iw7_axe"))
    var_01 = var_0.pers["secondaryWeapon"];

  if(issubstr(var_01, "nunchucks") || issubstr(var_01, "katana"))
    var_01 = "iw7_fists_mp";

  return var_01;
}

camera_move_helper(var_00, var_01, var_02, var_03) {
  self predictstreampos(var_0.origin);
  wait(var_02);
  level.camera_anchor scriptmodelclearanim();
  var_04 = distance(level.camera_anchor.origin, var_0.origin);
  var_05 = var_04 / var_01;

  if(var_05 < 0.05)
    var_05 = 0.05;

  level.camera_anchor.move_target = var_00;
  level.camera_anchor moveto(var_0.origin, var_05);
  level.camera_anchor rotateto(var_0.angles, var_05);

  if(isdefined(var_03)) {
    wait(var_05 - var_03);
    thread scripts\mp\utility\game::func_F8A0(var_03);
  }
}

endbroshot() {
  level.broshotrunning = undefined;
  self notify("broshot_done");

  foreach(var_01 in level.players)
  var_01 clearsoundsubmix();
}

makebrowinner(var_00, var_01) {
  var_02 = spawn("script_character", var_1.origin, 0, 0, var_00);
  var_2.angles = var_1.angles;

  if(scripts\mp\utility\game::istrue(level.nukegameover) && var_00 == 0)
    playfx(scripts\engine\utility::getfx("mons_screen_ash"), var_1.origin);

  return var_02;
}

listenfortauntinput(var_00) {
  if(!isai(self) && scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("bro_action_1", "+actionslot 1");
    self notifyonplayercommand("bro_action_2", "+actionslot 2");
    self notifyonplayercommand("bro_action_3", "+actionslot 3");
    self notifyonplayercommand("bro_action_4", "+actionslot 4");
  } else {
    self notifyonplayercommand("bro_action_1", "+actionslot 3");
    self notifyonplayercommand("bro_action_2", "+actionslot 4");
    self notifyonplayercommand("bro_action_3", "+actionslot 5");
    self notifyonplayercommand("bro_action_4", "+actionslot 6");
  }

  for (;;) {
    thread listenfortaunt(var_00, 1);
    thread listenfortaunt(var_00, 2);
    thread listenfortaunt(var_00, 3);
    thread listenfortaunt(var_00, 4);
    self waittill("taunt_end");
  }
}

listenfortaunt(var_00, var_01) {
  self endon("taunt_start");
  self endon("broshot_done");

  for (;;) {
    self waittill("bro_action_" + var_01);
    thread dotaunt(var_00, var_01);
    wait 0.05;
  }
}

dotaunt(var_00, var_01) {
  self notify("taunt_start");
  self endon("broshot_done");

  if(isdefined(self.changedarchetypeinfo)) {
    var_02 = level.archetypeids[self.changedarchetypeinfo.archetype];

    if(level.rankedmatch)
      var_03 = self getrankedplayerdata("rankedloadouts", "squadMembers", "archetypePreferences", var_02, "taunts", var_01 - 1);
    else
      var_03 = self getrankedplayerdata("privateloadouts", "squadMembers", "archetypePreferences", var_02, "taunts", var_01 - 1);
  } else if(level.rankedmatch)
    var_03 = self getrankedplayerdata("rankedloadouts", "squadMembers", "taunts", var_01 - 1);
  else
    var_03 = self getrankedplayerdata("privateloadouts", "squadMembers", "taunts", var_01 - 1);

  if(isdefined(level.overridebroslot))
    var_00 = level.overridebroslot - 1;

  if(isdefined(level.overridetaunt))
    var_03 = tablelookup("mp\cac\taunts.csv", 0, level.overridetaunt, 1);

  var_04 = tablelookuprownum("mp\cac\taunts.csv", 1, var_03);
  var_05 = tablelookup("mp\cac\taunts.csv", 0, var_04, 5);

  if(var_05 == "") {
    return;
  }
  var_06 = tablelookup("mp\cac\taunts.csv", 0, var_04, 19);
  var_07 = tablelookup("mp\cac\taunts.csv", 0, var_04, 20);
  var_08 = tablelookup("mp\cac\taunts.csv", 0, var_04, 21);
  var_09 = tablelookup("mp\cac\taunts.csv", 0, var_04, 12) == "Y";
  var_10 = tablelookup("mp\cac\taunts.csv", 0, var_04, 9);
  var_11 = "ui_broshot_anim_" + var_00;

  if(isdefined(level.interruptabletaunts[var_00]) && level.interruptabletaunts[var_00] == var_10) {
    self notify("taunt_end");
    return;
  }

  var_12 = getdisplayweapon(self) == "none" || getdisplayweapon(self) == "iw7_fists_mp";

  if(!isdefined(level.firsttaunttracker[var_11]) && !var_12) {
    if(!(var_09 && isdefined(level.supergunout[var_11]))) {
      level.firsttaunttracker[var_11] = 1;
      putgunaway(var_11);
    }

    if(!var_09)
      level.supergunout[var_11] = undefined;
  }

  if(var_09 && !isdefined(level.supergunout[var_11])) {
    level.firsttaunttracker[var_11] = undefined;
    takesupergunout(var_11, var_05);
    level.supergunout[var_11] = 1;
  }

  var_13 = tablelookup("mp\cac\taunts.csv", 0, var_04, 17);
  var_14 = tablelookup("mp\cac\taunts.csv", 0, var_04, 18);

  if(var_00 > 0 && var_13 != "" && var_14 != "") {
    if(var_00 == 1)
      var_10 = var_13;
    else if(var_00 == 2)
      var_10 = var_14;
  }

  scripts\mp\broshot_utilities::processepictaunt(var_10, var_00, 1);
  var_15 = "ui_broshot_anim_" + var_00;
  setomnvar(var_15, var_04);
  var_16 = float(var_08) / 30.0;
  var_17 = var_16;

  if(var_06 != "")
    var_17 = var_17 * float(var_06);

  level.interruptabletaunts[var_00] = var_10;
  thread interruptblocker(var_00, var_16);
  wait(var_17);
  level.taunts_done = 1;
  self notify("taunt_end");
}

interruptblocker(var_00, var_01) {
  self notify("combo_started_" + var_00);
  self endon("combo_started_" + var_00);
  wait(var_01);
  level.interruptabletaunts[var_00] = undefined;
}

getaltgunanimstring() {
  var_00 = getdisplayweapon(self);

  if(issubstr(var_00, "iw7_nrg") || issubstr(var_00, "iw7_udm45") || issubstr(var_00, "iw7_ump45_mpr_akimbo"))
    return "_alt";

  return "";
}

getgunanimstring() {
  var_00 = getdisplayweapon(self);

  if(issubstr(var_00, "minilmg_mpl"))
    return "augfury";

  if(issubstr(var_00, "akimbo"))
    return "akimbo";

  if(issubstr(var_00, "mp28"))
    return "mp28";

  if(issubstr(var_00, "chargeshot") || issubstr(var_00, "glprox") || issubstr(var_00, "venom"))
    return "assault_rifle";

  if(issubstr(var_00, "knife"))
    return "knife";

  if(issubstr(var_00, "axe"))
    return "axe";

  var_01 = scripts\mp\utility\game::getweapongroup(var_00);

  switch (var_01) {
    case "weapon_melee":
      return "melee";
    case "weapon_pistol":
      return "pistol";
    case "weapon_beam":
    case "weapon_smg":
      return "smg";
    case "weapon_assault":
      return "assault_rifle";
    case "weapon_lmg":
      return "lmg";
    case "weapon_rail":
    case "weapon_dmr":
    case "weapon_sniper":
      return "sniper";
    case "weapon_shotgun":
      return "shotgun";
    case "weapon_projectile":
      return "launcher";
    default:
      return "akimbo";
  }
}

getgunanimindex() {
  var_00 = getdisplayweapon(self);
  var_01 = scripts\mp\utility\game::getweapongroup(var_00);

  if(issubstr(var_00, "minilmg_mpl"))
    return 11;

  if(issubstr(var_00, "mp28"))
    return 12;

  if(issubstr(var_00, "akimbo") && !issubstr(var_00, "akimbofmg") && !issubstr(var_00, "mod_akimboshotgun")) {
    if(issubstr(var_00, "iw7_nrg") || issubstr(var_00, "iw7_udm45") || issubstr(var_00, "iw7_ump45_mpr_akimbo"))
      return 13;

    return 8;
  }

  if(issubstr(var_00, "chargeshot") || issubstr(var_00, "glprox") || issubstr(var_00, "venom"))
    return 2;

  if(issubstr(var_00, "knife"))
    return 9;

  if(issubstr(var_00, "axe"))
    return 10;

  if(issubstr(var_00, "nunchuk") || issubstr(var_00, "katana"))
    return 7;

  switch (var_01) {
    case "weapon_pistol":
      return 0;
    case "weapon_beam":
    case "weapon_smg":
      return 1;
    case "weapon_assault":
      return 2;
    case "weapon_lmg":
      return 3;
    case "weapon_rail":
    case "weapon_dmr":
    case "weapon_sniper":
      return 4;
    case "weapon_shotgun":
      return 5;
    case "weapon_projectile":
      return 6;
    case "weapon_melee":
    default:
      return 7;
  }
}

setguntypeforui(var_00) {
  var_01 = "ui_broshot_weapon_type_" + var_00;
  setomnvar(var_01, getgunanimindex());
}

putgunaway(var_00) {
  var_01 = getgunanimstring();
  var_02 = var_01 + "_put_away" + getaltgunanimstring();
  var_03 = tablelookuprownum("mp\cac\taunts.csv", 1, var_02);
  setomnvar(var_00, -1);
  var_04 = getgunputawayduration(var_01);
  wait(var_04);
}

takesupergunout(var_00, var_01) {
  var_02 = getrigtransstringfromref(var_01) + "transout_0";
  var_03 = tablelookuprownum("mp\cac\taunts.csv", 1, var_02);
  setomnvar(var_00, var_03 + 30000);
  var_04 = getrigsupertakeoutdurationfromref(var_01);
  wait(var_04);
}

getrigtransstringfromref(var_00) {
  var_01 = "";

  switch (var_00) {
    case "archetype_assault":
    default:
      var_01 = "war_";
      break;
    case "archetype_heavy":
      var_01 = "heavy_";
      break;
    case "archetype_scout":
      var_01 = "c6_";
      break;
    case "archetype_assassin":
      var_01 = "ftl_";
      break;
    case "archetype_engineer":
      var_01 = "stryker_";
      break;
    case "archetype_sniper":
      var_01 = "ghost_";
      break;
  }

  return var_01;
}

getgunputawayduration(var_00) {
  var_01 = 0.0;

  switch (var_00) {
    case "akimbo":
    default:
      var_01 = 1.067;
      break;
    case "launcher":
      var_01 = 1.567;
      break;
    case "lmg":
      var_01 = 1.333;
      break;
    case "pistol":
      var_01 = 2.233;
      break;
    case "shotgun":
      var_01 = 1.233;
      break;
    case "mp28":
    case "smg":
      var_01 = 1.2;
      break;
    case "sniper":
      var_01 = 1.367;
      break;
    case "assault_rifle":
      var_01 = 1.233;
      break;
    case "melee":
      var_01 = 1.233;
      break;
  }

  return var_01 - 0.2;
}

getrigsupertakeoutdurationfromref(var_00) {
  var_01 = 0.0;

  switch (var_00) {
    case "archetype_assault":
    default:
      var_01 = 1.733;
      break;
    case "archetype_heavy":
      var_01 = 1.4;
      break;
    case "archetype_scout":
      var_01 = 0.67;
      break;
    case "archetype_assassin":
      var_01 = 1.133;
      break;
    case "archetype_engineer":
      var_01 = 1.733;
      break;
    case "archetype_sniper":
      var_01 = 1.3;
      break;
  }

  return var_01 - 0.2;
}

getrigsuperputawaydurationfromref(var_00) {
  var_01 = 0.0;

  switch (var_00) {
    case "archetype_assault":
    default:
      var_01 = 1.267;
      break;
    case "archetype_heavy":
      var_01 = 1.5;
      break;
    case "archetype_scout":
      var_01 = 0.67;
      break;
    case "archetype_assassin":
      var_01 = 1.0;
      break;
    case "archetype_engineer":
      var_01 = 1.3;
      break;
    case "archetype_sniper":
      var_01 = 1.167;
      break;
  }

  return var_01 - 0.2;
}

compare_player_score(var_00, var_01) {
  return var_0.score >= var_1.score;
}

onplayerconnect() {
  self endon("broshot_done");

  for (;;) {
    level waittill("connected", var_00);

    if(!isai(var_00))
      thread startlatejoinpodium(var_00);
  }
}

startlatejoinpodium(var_00) {
  var_00 endon("disconnect");
  wait 0.25;
  var_00 cameralinkto(level.camera_anchor, "tag_origin", 1);
  var_01 = var_00 getentitynumber();
  startpodium(var_01, self.mvparray);
}

changetestrig(var_00, var_01) {
  level.overriderig = var_00;
  var_02 = var_01 - 1;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;

  switch (var_00) {
    case 1:
    default:
      var_03 = 4;
      var_04 = 18;
      var_05 = 6;
      break;
    case 2:
      var_03 = 12;
      var_04 = 5;
      var_05 = 1;
      break;
    case 3:
      var_03 = 28;
      var_04 = 1;
      var_05 = 2;
      break;
    case 4:
      var_03 = 57;
      var_04 = 28;
      var_05 = 3;
      break;
    case 5:
      var_03 = 45;
      var_04 = 39;
      var_05 = 4;
      break;
    case 6:
      var_03 = 27;
      var_04 = 31;
      var_05 = 5;
      break;
  }

  self.mvparray = [];
  var_06 = max(var_01, level.topplayers.size);

  for (var_07 = 0; var_07 < var_06; var_7++) {
    self.mvparray[var_07] = spawnstruct();
    self.mvparray[var_07].rigindex = var_05;
    self.mvparray[var_07].bodyindex = var_04;
    self.mvparray[var_07].headindex = var_03;
    self.mvparray[var_07].weaponname = getdisplayweapon(level.players[0]);
    self.mvparray[var_07].clantag = level.players[0] getclantag();
    self.mvparray[var_07].name = level.players[0].name;
    self.mvparray[var_07].xuid = level.players[0] getxuid();
    self.mvparray[var_07].podiumindex = var_01;
    self.mvparray[var_07].clientnum = level.players[0] getentitynumber();

    if(!isdefined(level.topplayers[var_07])) {
      self.topplayers[var_07] = spawnstruct();
      level.topplayers[var_07].bro = makebrowinner(var_07, level.camera_bro_shot.char_loc[var_07]);
    }
  }

  for (var_07 = 0; var_07 < var_06; var_7++)
    level.topplayers[var_07] setguntypeforui(var_07);

  wait 0.05;
  startpodium(-1, self.mvparray);
}

changetesttaunt(var_00) {
  level.overridetaunt = var_00;
}

changetestslot(var_00) {
  level.overridebroslot = var_00;

  if(!isdefined(level.topplayers[var_00 - 1])) {
    var_01 = 0;

    if(isdefined(level.overriderig))
      var_01 = level.overriderig;

    changetestrig(var_01, var_00);
  }
}