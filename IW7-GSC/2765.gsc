/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2765.gsc
***************************************/

init() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];
  var_00 = 0;

  for (;;) {
    var_01 = tablelookupbyrow("mp\loot\iw7_weapon_loot_master.csv", var_00, 0);

    if(!isdefined(var_01) || var_01 == "") {
      break;
    }
    var_01 = int(var_01);
    var_02 = tablelookupbyrow("mp\loot\iw7_weapon_loot_master.csv", var_00, 1);
    level.lootweaponrefs[var_01] = var_02;
    var_0++;
  }
}

getpassivesforweapon(var_00) {
  if(isplayer(self) && weaponhasprestigenuke(var_00))
    return ["passive_nuke"];

  var_01 = getlootinfoforweapon(var_00);

  if(isdefined(var_01))
    return var_1.passives;

  return undefined;
}

getlootinfoforweapon(var_00) {
  var_01 = getweaponvariantindex(var_00);

  if(!isdefined(var_01))
    return undefined;

  var_02 = scripts\mp\utility\game::getweaponrootname(var_00);

  if(isdefined(level.lootweaponcache[var_02]) && isdefined(level.lootweaponcache[var_02][var_01])) {
    var_03 = level.lootweaponcache[var_02][var_01];
    return var_03;
  }

  var_03 = cachelootweaponweaponinfo(var_00, var_02, var_01);

  if(isdefined(var_03))
    return var_03;

  return undefined;
}

getweaponassetfromrootweapon(var_00, var_01) {
  var_02 = "mp\loot\weapon\" + var_00 + ".csv ";
  var_03 = tablelookup(var_02, 0, var_01, 3);
  return var_03;
}

lookupvariantref(var_00, var_01) {
  var_02 = "mp\loot\weapon\" + var_00 + ".csv ";
  var_03 = tablelookup(var_02, 0, var_01, 1);
  return var_03;
}

isweaponitem(var_00) {
  return var_00 >= 1 && var_00 <= 9999;
}

iskillstreakitem(var_00) {
  return var_00 >= 10000 && var_00 <= 19999;
}

ispoweritem(var_00) {
  return var_00 >= 20000 && var_00 <= 29999;
}

isconsumableitem(var_00) {
  return var_00 >= 30000 && var_00 <= 39999;
}

iscosmeticitem(var_00) {
  return var_00 >= 40000 && var_00 <= 49999;
}

cachelootweaponweaponinfo(var_00, var_01, var_02) {
  if(!isdefined(level.lootweaponcache[var_01]))
    level.lootweaponcache[var_01] = [];

  var_03 = getweaponloottable(var_00);
  var_04 = readweaponinfofromtable(var_03, var_02);
  level.lootweaponcache[var_01][var_02] = var_04;
  return var_04;
}

readweaponinfofromtable(var_00, var_01) {
  var_02 = tablelookuprownum(var_00, 0, var_01);
  var_03 = spawnstruct();
  var_3.ref = tablelookupbyrow(var_00, var_02, 1);
  var_3.weaponasset = tablelookupbyrow(var_00, var_02, 1);
  var_3.passives = [];

  for (var_04 = 0; var_04 < 3; var_4++) {
    var_05 = tablelookupbyrow(var_00, var_02, 5 + var_04);

    if(isdefined(var_05) && var_05 != "")
      var_3.passives[var_3.passives.size] = var_05;
  }

  var_3.quality = int(tablelookupbyrow(var_00, var_02, 4));
  var_3.variantid = var_01;
  return var_03;
}

getweaponqualitybyid(var_00, var_01) {
  if(!isdefined(var_01) || var_01 < 0)
    return 0;

  var_02 = getweaponloottable(var_00);
  var_03 = int(tablelookup(var_02, 0, var_01, 4));
  return var_03;
}

getlootweaponref(var_00) {
  return level.lootweaponrefs[var_00];
}

weaponhasprestigenuke(var_00) {
  var_01 = scripts\mp\utility\game::getweaponrootname(var_00);
  var_02 = var_01 + "_nuke";

  if(isdefined(level.prestigeextras[var_02]))
    return self getteamdompoints(var_02, "prestigeExtras", 1);

  return 0;
}