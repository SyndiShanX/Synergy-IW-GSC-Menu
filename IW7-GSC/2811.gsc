/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2811.gsc
***************************************/

init() {
  loadweaponranktable();
  var_00 = getdvarint("online_mp_weapon_xpscale", 1);
  addglobalweaponrankxpmultiplier(var_00, "online_mp_weapon_xpscale");
  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_00);

    if(!isai(var_00)) {
      if(var_00 scripts\mp\utility\game::rankingenabled()) {
        var_01 = getdvarint("online_mp_party_weapon_xpscale");
        var_02 = var_00 _meth_85BE() > 1;

        if(var_02)
          var_00 addweaponrankxpmultiplier(var_01, "online_mp_party_weapon_xpscale");
      }
    }
  }
}

loadweaponranktable() {
  level.weaponranktable = spawnstruct();
  level.weaponranktable.rankinfo = [];
  var_00 = 0;

  for (;;) {
    var_01 = int(tablelookuprownum("mp\weaponRankTable.csv", 0, var_00));

    if(!isdefined(var_01) || var_01 < 0) {
      break;
    }
    var_02 = spawnstruct();
    level.weaponranktable.rankinfo[var_00] = var_02;
    var_2.minxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 1));
    var_2.xptonextrank = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 2));
    var_2.maxxp = int(tablelookupbyrow("mp\weaponRankTable.csv", var_00, 3));
    var_0++;
  }

  level.weaponranktable.maxrank = var_00 - 1;
  level.weaponranktable.maxweaponranks = [];
  var_03 = 1;

  for (;;) {
    var_01 = int(tablelookuprownum("mp\statstable.csv", 0, var_03));

    if(!isdefined(var_01) || var_01 < 0) {
      break;
    }
    var_04 = tablelookupbyrow("mp\statstable.csv", var_01, 4);
    var_05 = tablelookupbyrow("mp\statstable.csv", var_01, 42);

    if(!isdefined(var_04) || var_04 == "" || !isdefined(var_05) || var_05 == "") {} else {
      var_05 = int(var_05);
      level.weaponranktable.maxweaponranks[var_04] = var_05;
    }

    var_3++;
  }
}

getplayerweaponrank(var_00) {
  var_01 = getplayerweaponrankxp(var_00);
  var_02 = getweaponrankforxp(var_01);
  return var_02;
}

getplayerweaponrankxp(var_00, var_01) {
  if(!isdefined(var_01))
    var_01 = "all";

  switch (var_01) {
    case "mp":
      var_02 = self getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_00, "mpXP");
      return var_02;
    case "cp":
      var_03 = self getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_00, "cpXP");
      return var_03;
    case "all":
      var_02 = self getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_00, "mpXP");
      var_03 = self getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_00, "cpXP");
      return var_02 + var_03;
  }
}

isplayerweaponatmaxxp(var_00) {
  var_01 = getplayerweaponrankxp(var_00);
  var_02 = getweaponmaxrankxp(var_00);
  return var_01 >= var_02;
}

func_13CCA(var_00) {
  if(!self getteamdompoints("cac", "feature"))
    return 0;

  var_01 = scripts\mp\utility\game::getweaponrootname(var_00);
  return func_13C97(var_01);
}

func_13C97(var_00) {
  if(!isdefined(level.weaponranktable.maxweaponranks[var_00]))
    return 0;

  return level.weaponranktable.maxweaponranks[var_00] > 0;
}

getweaponmaxrankxp(var_00) {
  var_01 = getmaxweaponrankforrootweapon(var_00);
  return getweaponrankinfomaxxp(var_01);
}

getweaponrankforxp(var_00) {
  if(var_00 == 0)
    return 0;

  for (var_01 = getmaxweaponrank() - 1; var_01 >= 0; var_1--) {
    if(var_00 >= getweaponrankinfominxp(var_01))
      return var_01;
  }

  return var_01;
}

func_7FA6(var_00) {
  var_01 = scripts\mp\utility\game::getweaponrootname(var_00);
  return getmaxweaponrankforrootweapon(var_01);
}

getmaxweaponrankforrootweapon(var_00) {
  return level.weaponranktable.maxweaponranks[var_00];
}

getmaxweaponrank() {
  return level.weaponranktable.maxrank;
}

getweaponrankinfominxp(var_00) {
  return level.weaponranktable.rankinfo[var_00].minxp;
}

playlocalsound(var_00) {
  return level.weaponranktable.rankinfo[var_00].xptonextrank;
}

getweaponrankinfomaxxp(var_00) {
  return level.weaponranktable.rankinfo[var_00].maxxp;
}

_meth_8394(var_00, var_01, var_02) {
  if(isai(self) || !isplayer(self) || !isdefined(var_02) || var_02 == 0 || !scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_03 = scripts\mp\utility\game::getweaponrootname(var_00);

  if(!self getteamdompoints(var_03, "weapon")) {
    return;
  }
  if(!func_13C97(var_03)) {
    return;
  }
  var_04 = remapscoreeventforweapon(var_01);

  if(var_04 != var_01) {
    var_01 = var_04;
    var_02 = scripts\mp\rank::getscoreinfovalue(var_01);
  }

  if(var_02 < 0) {
    return;
  }
  var_05 = var_02;
  var_02 = var_02 * _meth_8233();
  var_02 = int(var_02);

  if(var_02 > getweaponmaxrankxp(var_03)) {
    return;
  }
  var_06 = getplayerweaponrankxp(var_03, "mp");
  var_07 = getplayerweaponrankxp(var_03, "cp");
  var_08 = var_06 + var_07;
  var_09 = getweaponrankforxp(var_08);
  var_10 = getweaponmaxrankxp(var_03);
  var_11 = var_10 - var_07;
  var_12 = var_06 + var_02;

  if(var_12 > var_11)
    var_12 = var_11;

  var_13 = var_12 + var_07;
  var_14 = getmaxweaponrankforrootweapon(var_03);
  var_15 = self getrankedplayerdata("common", "sharedProgression", "weaponLevel", var_03, "prestige");
  var_16 = int(min(getweaponrankforxp(var_13), var_14));
  scripts\mp\analyticslog::logevent_givempweaponxp(var_00, var_15, var_16, var_02, var_01);
  self setrankedplayerdata("common", "sharedProgression", "weaponLevel", var_03, "mpXP", var_12);
  var_17 = getweaponvariantindex(var_00);
  scripts\mp\matchdata::func_AFDC(var_03, "xp", var_02, var_17);

  if(var_09 < var_16) {
    scripts\mp\hud_message::showsplash("ranked_up_weapon_" + var_03, var_16 + 1);
    var_18 = "weapon_rank_up_0_4";

    if(var_16 >= 15)
      var_18 = "weapon_rank_up_15_plus";
    else if(var_16 >= 10)
      var_18 = "weapon_rank_up_10_14";
    else if(var_16 >= 5)
      var_18 = "weapon_rank_up_5_9";

    var_19 = scripts\mp\rank::getscoreinfovalue(var_18);
    scripts\mp\rank::giverankxp(var_18, var_19);
  }
}

remapscoreeventforweapon(var_00) {
  switch (var_00) {
    case "kill":
      var_00 = "kill_weapon";
      break;
    case "challenge":
      var_00 = "weapon_challenge";
      break;
  }

  return var_00;
}

addglobalweaponrankxpmultiplier(var_00, var_01) {
  level addweaponrankxpmultiplier(var_00, var_01);
}

getglobalweaponrankxpmultiplier() {
  return level getweaponrankxpmultiplier();
}

addweaponrankxpmultiplier(var_00, var_01) {
  if(!isdefined(self.weaponrankxpmultipliers))
    self.weaponrankxpmultipliers = [];

  if(isdefined(self.weaponrankxpmultipliers[var_01]))
    self.weaponrankxpmultipliers[var_01] = max(self.weaponrankxpmultipliers[var_01], var_00);
  else
    self.weaponrankxpmultipliers[var_01] = var_00;
}

getweaponrankxpmultiplier() {
  if(!isdefined(self.weaponrankxpmultipliers))
    return 1.0;

  var_00 = 1.0;

  foreach(var_02 in self.weaponrankxpmultipliers) {
    if(!isdefined(var_02)) {
      continue;
    }
    var_00 = var_00 * var_02;
  }

  return var_00;
}

removeglobalweaponrankxpmultiplier(var_00) {
  level removeweaponrankxpmultiplier(var_00);
}

removeweaponrankxpmultiplier(var_00) {
  if(!isdefined(self.weaponrankxpmultipliers)) {
    return;
  }
  if(!isdefined(self.weaponrankxpmultipliers[var_00])) {
    return;
  }
  self.rankxpmultipliers[var_00] = undefined;
}

_meth_8233() {
  var_00 = getweaponrankxpmultiplier();
  var_01 = getglobalweaponrankxpmultiplier();
  return var_00 * var_01;
}