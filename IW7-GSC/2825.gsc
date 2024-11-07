/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2825.gsc
***************************************/

_id_952F() {
  _id_2237();
  _id_CF6C();
  _id_EE1F();
  _id_87EC();
  level._id_A03B = getdvar("player_itemUseRadius");
  level._id_A03A = getdvar("player_itemUseFOV");
  var_0 = getentarray("loot_room_volume", "targetname");

  foreach (var_2 in var_0)
  var_2 thread _id_CF73();
}

_id_2237() {}

_id_489F(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_1 = scripts\engine\utility::_id_8180("loot_weapon_node", "targetname");
  var_2 = scripts\engine\utility::_id_8180("loot_terminal", "targetname");
  var_3 = scripts\engine\utility::_id_8180("locker_node", "targetname");
  var_4 = level._id_D9E5["equip_upgrades"];
  var_4 = var_4 / level._id_21E2;

  if (isdefined(level._id_FCD6) && level._id_FCD6 == 1) {
  var_5 = undefined;
  var_6 = getentarray("loot_room_volume", "targetname");

  if (var_6.size > 1) {
  foreach (var_5 in var_6) {
  if (ispointinvolume(self.origin, var_5))
  break;
  }

  if (isdefined(var_5)) {
  var_9 = var_1;
  var_10 = var_2;
  var_11 = var_3;
  var_1 = [];
  var_2 = [];
  var_3 = [];

  foreach (var_13 in var_9) {
  if (ispointinvolume(var_13.origin, var_5))
  var_1 = scripts\engine\utility::_id_2279(var_1, var_13);
  }

  foreach (var_16 in var_10) {
  if (ispointinvolume(var_16.origin, var_5))
  var_2 = scripts\engine\utility::_id_2279(var_2, var_16);
  }

  foreach (var_19 in var_11) {
  if (ispointinvolume(var_19.origin, var_5))
  var_3 = scripts\engine\utility::_id_2279(var_3, var_19);
  }
  }
  }
  }

  _id_B080(var_3, 0);
  thread _id_B098(var_1);
  thread _id_B095(var_0, var_2, var_4);
}

_id_CF73() {
  for (;;) {
  for (;;) {
  if (level.player istouching(self))
  break;

  wait 0.25;
  }

  _func_1C5("player_itemUseRadius", 100);
  _func_1C5("player_itemUseFOV", 90);

  for (;;) {
  if (!level.player istouching(self))
  break;

  wait 0.25;
  }

  _func_1C5("player_itemUseRadius", level._id_A03B);
  _func_1C5("player_itemUseFOV", level._id_A03A);
  }
}

#using_animtree("player");

_id_CF6C() {
  if (level.script == "sa_assassination") {
  if (isdefined(level._id_21E7))
  level [[level._id_21E7]]();
  } else {
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_arms"]["hack_terminal"] = %vm_gauntlet_armory_hack;
  level._id_EC85["player_arms"]["open_loot_door"] = %door_armory_open_player;
  }
}

#using_animtree("script_model");

_id_EE1F() {
  level._id_EC87["loot_door"] = #animtree;
  level._id_EC87["loot_locker"] = #animtree;
  level._id_EC85["loot_door"]["open_loot_door"] = %door_armory_open_door;
  level._id_EC85["loot_locker"]["open_locker_doors"] = %loot_room_locker_door_open;
}

_id_B098(var_0) {
  var_0 = scripts\engine\utility::_id_22A7(var_0);
  var_1 = spawnstruct();
  var_1._id_BF1B = 8;
  var_1._id_11A2E = var_0.size;
  var_1._id_10310 = var_0.size;
  var_1._id_C053 = var_0;

  for (var_2 = 0; var_2 < var_1._id_11A2E; var_2++) {
  var_1 = _id_B097(var_1);
  var_1._id_10310--;
  }
}

_id_B095(var_0, var_1, var_2) {
  var_3 = var_1.size;
  var_4 = var_2;

  foreach (var_8, var_6 in var_1) {
  var_7 = 1;

  if (var_4 > var_3)
  var_7 = 2;

  if (isdefined(level._id_B092)) {
  level._id_B093 = var_6;
  var_6._id_92B9 = 2;
  } else {
  level._id_B092 = var_6;
  var_6._id_92B9 = 1;
  }

  var_6 thread _id_116DD(var_7, var_0, var_8);
  var_4 = var_4 - var_7;
  }
}

_id_B080(var_0, var_1) {
  var_2 = 0;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
  var_4 = "vault_locker_light_" + var_3 + "_on";
  var_5 = var_0[var_3] _id_AF09(var_4, var_1);
  }

  return var_2;
}

_id_AF09(var_0, var_1) {
  var_2 = getentarray(self._id_0334, "targetname");
  var_3 = [];
  var_4 = [];
  var_5 = undefined;
  var_6 = undefined;

  foreach (var_8 in var_2) {
  if (var_8.classname == "script_model") {
  var_5 = var_8;
  continue;
  }

  if (var_8.classname == "script_brushmodel") {
  var_4 = scripts\engine\utility::_id_2279(var_4, var_8);
  continue;
  }

  if (isdefined(var_8.script_noteworthy) && var_8.script_noteworthy == "loot_locker_volume") {
  var_6 = var_8;
  continue;
  }

  var_3 = scripts\engine\utility::_id_2279(var_3, var_8);
  }

  thread _id_AF0F(var_0, var_3);
  thread _id_AF04(var_0, var_5, var_4);
}

_id_AF04(var_0, var_1, var_2) {
  thread _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, undefined, undefined, 0);
  _id_0E46::_id_9016();
  level.player notify("opening_armory_locker");
  level notify(var_0);
  var_1 thread _id_AF05(var_2);
  _func_178("loot_locker_open", self.origin);
}

_id_AF05(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach (var_6 in var_0) {
  if (var_6.script_noteworthy == "left_door") {
  var_2 = var_6;
  continue;
  }

  if (var_6.script_noteworthy == "right_door") {
  var_3 = var_6;
  continue;
  }

  var_4 = var_6;
  }

  var_1 _meth_83D0(#animtree);
  var_2 linkto(var_1, "j_door_r");
  var_3 linkto(var_1, "j_door_l");
  var_1._id_1FBB = "loot_locker";
  var_1 _id_0B06::_id_1F35(var_1, "open_locker_doors");

  if (isdefined(var_4))
  var_4 delete();
}

_id_AF0F(var_0, var_1) {
  if (!isdefined(self._id_0334))
  return;

  var_2 = 0;

  foreach (var_4 in var_1) {
  if (var_2 < 2 && randomint(100) > 25) {
  var_4 _id_0B47::_id_9661(undefined, undefined, 0.1, 0.25, undefined, undefined, undefined, undefined, undefined, var_0, undefined);
  var_2++;
  continue;
  }

  var_4 _id_0B47::_id_9662(undefined, undefined, undefined, undefined, var_0);
  }
}

_id_B097(var_0) {
  var_0 = _id_13C4B(var_0);
  var_1 = level._id_D9E5["weapon_pickups"];
  var_2 = level._id_D9E5["optionalunlocks"];

  if (var_0._id_1067C == 1) {
  var_0 = _id_3E94(var_0);

  if (var_0._id_F1B8 != "none" && _id_0A2F::_id_9B49(var_0._id_F1B8)) {
  var_3 = _id_0A2F::_id_3179(var_0._id_F1B8, "random", undefined, 0, 0, 3);

  if (isdefined(var_3))
  var_0._id_F1B8 = var_0._id_F1B8 + "+" + var_3;

  var_4 = spawn("weapon_" + var_0._id_F1B8, var_0._id_F1B5.origin, 1);
  var_4.angles = var_0._id_F1B5.angles;
  var_4 thread _id_13C65();

  if (getdvarint("progression_on") == 1) {
  var_5 = getweaponbasename(var_0._id_F1B8);

  if (scripts\engine\utility::array_contains(var_2, var_5)) {
  var_4 _id_0B91::_id_9196(4, 1, 0, "new_weapon");
  level._id_D9E5["armoryweapons"][level._id_D9E5["armoryweapons"].size] = var_4;
  }
  }
  }
  }

  return var_0;
}

_id_13C65() {
  self endon("death");
  var_0 = getsubstr(self.classname, 7);
  self waittill("trigger");
  level.player givemaxammo(var_0);
}

_id_116DF() {
  var_0 = randomintrange(0, 2);
  return var_0;
}

_id_13C4B(var_0) {
  var_0._id_1067C = 1;
  return var_0;
}

_id_3E94(var_0, var_1) {
  if (!isdefined(scripts\engine\utility::_id_7CF1()))
  return;

  if (!isdefined(var_1))
  var_1 = 1;

  var_0._id_3850 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = ["none"];

  if (!var_1)
  var_4 = _id_0A2F::_id_D9FA();

  var_4 = scripts\engine\utility::_id_227F(var_4, _id_0A2F::_id_DA0A());
  var_4 = scripts\engine\utility::_id_227F(var_4, _id_0A2F::_id_DA10());

  if (var_0._id_BF1B > 0 && scripts\engine\utility::_id_7CF1() != "rogue" && scripts\engine\utility::_id_7CF1() != "moon_port") {
  var_5 = randomfloatrange(0, 1);

  if (var_0._id_BF1B / 8 >= var_5) {
  if (level._id_D9E5["optionalunlocks"].size > 0) {
  level._id_D9E5["optionalunlocks"] = scripts\engine\utility::_id_22A7(level._id_D9E5["optionalunlocks"]);

  foreach (var_7 in level._id_D9E5["optionalunlocks"]) {
  if (scripts\engine\utility::array_contains(level._id_D9E5["loaded_weapons"], var_7)) {
  var_2 = var_7;
  break;
  }
  }

  if (isdefined(var_2))
  var_3 = _id_13C06(var_2, var_0._id_C053);

  if (isdefined(var_3)) {
  var_0._id_F1B8 = var_2;
  var_0._id_F1B5 = var_3;
  var_0._id_C053 = scripts\engine\utility::array_remove(var_0._id_C053, var_3);
  var_0._id_C053 = scripts\engine\utility::_id_22A7(var_0._id_C053);
  var_0._id_BF1B--;
  return var_0;
  }
  }
  }
  }

  if (!isdefined(var_0._id_3850)) {
  var_0._id_3850 = [];

  foreach (var_10 in level._id_D9E5["loaded_weapons"]) {
  if (!scripts\engine\utility::array_contains(var_4, var_10) && !scripts\engine\utility::array_contains(level._id_D9E5["optionalunlocks"], var_10))
  var_0._id_3850 = scripts\engine\utility::_id_2279(var_0._id_3850, var_10);
  }
  }

  var_0._id_3850 = scripts\engine\utility::_id_22A7(var_0._id_3850);
  var_2 = undefined;
  var_3 = undefined;

  if (!isdefined(var_0._id_845F))
  var_0._id_845F = 0;

  for (var_12 = 0; var_12 < var_0._id_3850.size; var_12++) {
  if (scripts\engine\utility::_id_7CF1() == "rogue") {
  if (var_0._id_10310 < var_0._id_11A2E)
  var_0._id_845F = 1;

  if (var_0._id_845F && randomint(100) > 25) {
  var_3 = undefined;
  var_2 = undefined;
  break;
  }

  var_2 = var_0._id_3850[var_12];

  if (weaponclass(var_2) == "spread") {
  var_3 = _id_13C06(var_2, var_0._id_C053);
  break;
  }
  }
  else if (scripts\engine\utility::_id_7CF1() == "moon_port") {
  var_2 = var_0._id_3850[var_12];

  if (!isdefined(var_0._id_8460))
  var_0._id_8460 = 0;

  if (!isdefined(var_0._id_8461))
  var_0._id_8461 = 0;

  if (var_2 == "iw7_devastator" && var_0._id_8461 < 12) {
  var_3 = _id_13C06(var_2, var_0._id_C053);
  var_0._id_8461++;
  break;
  }
  else if (var_2 == "iw7_mauler" && var_0._id_8460 < 12) {
  var_3 = _id_13C06(var_2, var_0._id_C053);
  var_0._id_8460++;
  break;
  }
  } else {
  var_2 = var_0._id_3850[var_12];
  var_3 = _id_13C06(var_2, var_0._id_C053);
  break;
  }
  }

  if (isdefined(var_3)) {
  var_0._id_F1B8 = var_2;
  var_0._id_F1B5 = var_3;
  var_0._id_C053 = scripts\engine\utility::array_remove(var_0._id_C053, var_3);
  var_0._id_C053 = scripts\engine\utility::_id_22A7(var_0._id_C053);
  }
  else
  var_0._id_F1B8 = "none";

  return var_0;
}

_id_13C06(var_0, var_1) {
  var_2 = scripts\engine\utility::_id_13C07(var_0);
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;

  if (isdefined(level._id_72A6)) {
  if (level._id_72A6 == "silencer")
  var_7 = 1;
  }

  if (var_0 == "iw7_sdflmg")
  var_6 = 0.2;
  else if (var_0 == "iw7_ar57") {
  if (var_7)
  var_2 = "silenced_smg";

  var_6 = 0;
  }
  else if (var_0 == "iw7_crb") {
  if (var_7)
  var_2 = "silenced_smg";

  var_6 = 2.8;
  }
  else if (var_0 == "iw7_devastator")
  var_6 = 0.5;
  else if (var_0 == "iw7_m8")
  var_6 = 0.2;
  else if (var_0 == "iw7_kbs")
  var_6 = 4.8;
  else if (var_0 == "iw7_fmg") {
  if (var_7)
  var_2 = "silenced_smg";

  var_6 = -1;
  }
  else if (var_0 == "iw7_ripper")
  var_6 = -1;
  else if (var_0 == "iw7_ump45") {
  if (var_7)
  var_2 = "silenced_smg";

  var_6 = -4;
  }
  else if (var_0 == "iw7_erad") {
  if (var_7)
  var_2 = "silenced_smg";

  var_6 = 0;
  }
  else if (var_0 == "iw7_fhr") {
  if (var_7)
  var_2 = "silenced_smg";

  var_6 = 1;
  }
  else if (var_0 == "iw7_ake") {
  var_2 = "sniper";
  var_6 = 0.8;
  }
  else if (var_0 == "iw7_m4") {
  var_2 = "sniper";
  var_6 = 0.2;
  }
  else if (var_0 == "iw7_sdfar") {
  var_2 = "large_ar";
  var_6 = -0.6;
  }
  else if (var_0 == "iw7_sonic") {
  var_2 = "large_shotgun";
  var_6 = -3.2;
  }
  else if (var_0 == "iw7_sdfshotty") {
  var_2 = "large_shotgun";
  var_6 = -1.2;
  }
  else if (var_0 == "iw7_mauler")
  var_2 = "extra_large";

  switch (var_2) {
  case "extra_large":
  var_5 = "extra_large";
  break;
  case "sniper":
  var_5 = "large";
  break;
  case "large_shotgun":
  var_5 = "large";
  break;
  case "large_ar":
  var_5 = "large";
  break;
  case "mg":
  var_5 = "large";
  break;
  case "pistol":
  var_5 = "pistol";
  break;
  case "beam":
  var_5 = "large";
  break;
  case "silenced_shotgun":
  var_5 = "large";
  break;
  case "silenced_smg":
  var_5 = "large";
  break;
  }

  if (_id_0A2F::_id_DA40(var_0))
  var_5 = "heavy";

  var_8 = undefined;
  var_9 = undefined;

  if (isdefined(var_5) && var_5 == "extra_large") {
  foreach (var_11 in var_1) {
  var_12 = var_11 _id_0B91::_id_7A97();

  if (var_12.size > 0) {
  foreach (var_14 in var_12) {
  if (isdefined(var_14.script_noteworthy)) {
  var_15 = var_14 _id_0B91::_id_7A97();

  foreach (var_9 in var_15) {
  if (scripts\engine\utility::array_contains(var_1, var_14)) {
  if (scripts\engine\utility::array_contains(var_1, var_9)) {
    if (isdefined(var_9._id_EE79) && var_9._id_EE79 == "extra_large") {
    var_3 = var_9;
    break;
    }
  }
  }
  }
  }
  }
  }

  if (isdefined(var_3))
  break;
  }
  }
  else if (isdefined(var_5) && var_5 == "large") {
  foreach (var_11 in var_1) {
  var_21 = 0;
  var_22 = 0;

  if (isdefined(var_11._id_EE79) && var_11._id_EE79 == "large") {
  var_12 = var_11 _id_0B91::_id_7A97();

  if (var_12.size > 0) {
  foreach (var_14 in var_12) {
  if (!scripts\engine\utility::array_contains(var_1, var_14)) {
  if (isdefined(var_11.script_noteworthy) && var_11.script_noteworthy == "stacked") {
  if (isdefined(var_14._id_EE79) && var_14._id_EE79 == "extra_large")
    var_21 = 1;
  }
  }

  if (!scripts\engine\utility::array_contains(var_1, var_14) && var_0 == "iw7_sdflmg") {
  if (!isdefined(var_11.script_noteworthy)) {
  if (isdefined(var_14._id_EE79) && var_14._id_EE79 == "extra_large")
    var_22 = 1;
  }
  }
  }
  } else {
  if (var_0 == "iw7_smg")
  var_22 = 1;

  if (isdefined(var_11.script_noteworthy) && var_11.script_noteworthy == "stacked")
  var_21 = 1;
  }

  if (!var_21 && !var_22) {
  var_3 = var_11;
  break;
  }
  }
  }
  }
  else if (isdefined(var_5) && var_5 == "heavy") {
  foreach (var_11 in var_1) {
  if (isdefined(var_11._id_EE79) && var_11._id_EE79 == "heavy") {
  var_3 = var_11;
  break;
  }
  }
  }
  else if (isdefined(var_5) && var_5 == "pistol") {
  foreach (var_11 in var_1) {
  if (isdefined(var_11._id_EE79) && var_11._id_EE79 == "pistol") {
  if (isdefined(var_11.script_noteworthy) && var_11.script_noteworthy == "locker_weapon") {
  var_3 = var_11;
  break;
  }
  else
  var_4 = var_11;
  }
  }

  if (!isdefined(var_3))
  var_3 = var_4;
  } else {
  foreach (var_11 in var_1) {
  if (!isdefined(var_11._id_EE79)) {
  if (isdefined(var_11.script_noteworthy) && var_11.script_noteworthy == "locker_weapon") {
  var_3 = var_11;
  break;
  }
  else
  var_4 = var_11;
  }
  }

  if (!isdefined(var_3))
  var_3 = var_4;
  }

  if (isdefined(var_6) && isdefined(var_3))
  var_3.origin = var_3.origin + (0, 0, var_6);

  return var_3;
}

_id_53BE() {
  var_0 = scripts\engine\utility::_id_DC6B(["", "small", "medium", "large"]);
  return var_0;
}

_id_116DD(var_0, var_1, var_2) {
  _id_8835();
  setomnvar("ui_inworld_terminal_hack", 0);

  if (isdefined(self._id_92B9) && self._id_92B9 == 1)
  _id_F3F0("on");
  else
  _id_F3F0("on", 1);

  if (_id_0A2F::_id_DA44(var_1, var_2)) {
  if (isdefined(self._id_92B9) && self._id_92B9 == 1)
  _id_F3F0("hacked");
  else
  _id_F3F0("hacked", 1);

  return;
  }

  var_3 = scripts\engine\utility::_id_107E6(self.origin, self.angles);
  var_3 thread _id_0E46::_id_48C4("tag_origin", undefined, undefined, undefined, undefined, 35, 0);
  var_3 _id_0E46::_id_9016();
  var_4 = undefined;
  var_5 = getent(self._id_0334, "targetname");
  var_4 = var_5 scripts\engine\utility::_id_107E6();
  level.player playsound("armory_terminal_start_use");
  var_6 = var_4 _id_0B1F::_id_FA17("hack_terminal");
  thread _id_8834(var_6);
  var_6 thread _id_116DC("hack_terminal", var_0, var_1);
  var_4 _id_0B06::_id_1F35(var_6, "hack_terminal");
  _id_0A2F::_id_DA4D(var_1, var_2);
  var_6 delete();
  level.player _id_0B1F::_id_5990();
  level.player unlink();
  var_3 delete();
  var_4 delete();
}

_id_9C55(var_0) {
  var_1 = _id_0A2F::_id_D9F8("items");
  return scripts\engine\utility::array_contains(var_1, var_0);
}

_id_116DC(var_0, var_1, var_2) {
  level.player notify("armory_terminal_start");
  var_3 = getanimlength(_id_0B91::_id_7DC1(var_0));
  var_4 = [];
  var_5 = ["frag", "antigrav", "emp", "seeker", "frag", "seeker", "offhandshield", "antigrav", "emp", "hackingdevice", "supportdrone", "coverwall"];
  level.player playsound("armory_terminal_tick");
  wait(var_3 / 2);
  level.player playsound("armory_terminal_tick");
  wait(var_3 / 2);
  level.player playsound("armory_terminal_got_file");

  for (var_6 = 0; var_6 < var_1; var_6++) {
  var_7 = 0;
  var_8 = _id_0A2F::_id_D9F8();

  foreach (var_10 in var_8) {
  var_11 = level.player _meth_84C6("equipmentState", var_10);

  if (!isdefined(var_11))
  continue;

  if (var_11 == "upgrade2") {
  var_7 = var_7 + 2;
  continue;
  }

  if (var_11 == "upgrade1")
  var_7 = var_7 + 1;
  }

  var_13 = var_5[var_7];
  var_14 = level.player _meth_84C6("equipmentState", var_13);
  var_15 = "upgrade1";

  if (isdefined(var_14) && var_14 == "upgrade1")
  var_15 = "upgrade2";

  if (var_13 == "coverwall" && var_15 == "upgrade1") {
  if (level.player._id_4759._id_0019.size > 0)
  level.player thread _id_0B16::_id_B9C4();
  }

  level.player _meth_84C7("equipmentState", var_13, var_15);
  level._id_D9E5["weaponstates"][var_13] = var_15;
  _id_0A2F::_id_82FE(var_13, var_15);
  var_4 = scripts\engine\utility::_id_2279(var_4, var_13);
  }

  level thread terminal_unlocks_ui(var_4, var_1);
  level.player playsound("armory_terminal_finish");
  level.player notify("armory_terminal_finish");
  _id_0A2F::_id_3D6E();
  var_16 = "armory" + var_2;
  _id_0B91::_id_266A(var_16);
}

terminal_unlocks_ui(var_0, var_1) {
  scripts\engine\utility::waitframe();

  if (scripts\engine\utility::_id_6E25("game_saving"))
  wait 0.25;

  thread clearomnvaronautosave("ui_loot_unlocked");
  var_2 = var_0.size;

  for (var_3 = 0; var_3 < var_2; var_3++) {
  var_4 = var_0[var_3];
  setomnvar("ui_loot_unlocked", var_4);
  wait 3.0;

  if (var_3 < var_2 - 1) {
  while (scripts\engine\utility::_id_6E25("game_saving"))
  scripts\engine\utility::waitframe();
  }
  }

  setomnvar("ui_files_acquired", var_1);
  setomnvar("ui_loot_unlocked", "none");
  level notify("ClearOmnvarOnAutoSave_Abort");
}

clearomnvaronautosave(var_0) {
  level endon("ClearOmnvarOnAutoSave_Abort");

  for (;;) {
  level waittill("trying_new_autosave");
  setomnvar(var_0, "none");
  }
}

_id_FA17(var_0) {
  var_1 = _id_0B91::_id_10639("player_arms");
  var_2 = level.player _meth_84C6("currentViewModel");

  if (isdefined(var_2))
  var_1 setmodel(var_2);

  var_1 hide();
  var_3 = [var_1, self];
  thread _id_0B06::_id_1EC3(var_1, var_0);
  var_4 = scripts\engine\utility::_id_107E6(level.player.origin, level.player getplayerangles());
  level.player _meth_823B(var_4, "tag_origin");
  wait 0.05;
  var_5 = 1;
  level.player _meth_823C(var_1, "tag_player", var_5, 0.25, 0.25);
  level.player _id_0B1F::_id_598D();
  wait(var_5);
  level.player _meth_823D(var_1, "tag_player", 0, 5, 5, 5, 5);
  var_1 show();
  var_4 delete();
  return var_1;
}

_id_2246() {}

_id_8835() {
  if (!isdefined(self.angles))
  self.angles = (0, 0, 0);

  self._id_87EB = [];
  var_0 = undefined;

  if (isdefined(self._id_0334))
  var_0 = getent(self._id_0334, "targetname");

  if (isdefined(var_0)) {
  self._id_87EB["fx_tag"] = var_0 scripts\engine\utility::_id_107E6();
  self._id_87EB["fx_tag"].origin = self._id_87EB["fx_tag"].origin + anglestoforward(var_0.angles) * 47.9;
  self._id_87EB["fx_tag"].origin = self._id_87EB["fx_tag"].origin + anglestoup(var_0.angles) * 52;
  }
  else
  self._id_87EB["fx_tag"] = scripts\engine\utility::_id_107E6();

  if (!isdefined(var_0)) {
  self._id_87EB["fx_tag"].origin = self.origin + anglestoforward(self.angles) * -2.0;
  self._id_87EB["fx_tag"].angles = self.angles + (73, 0, 0);
  }
}

_id_87EC() {
  level._effect["vfx_ui_terminal_press"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_press.vfx");
  level._effect["vfx_ui_terminal_off"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_off.vfx");
  level._effect["vfx_ui_terminal_on"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_on.vfx");
  level._effect["vfx_ui_terminal_firmware"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_firmware.vfx");
  level._effect["vfx_ui_terminal_hack"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_hack.vfx");
  level._effect["vfx_ui_terminal_success"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_success.vfx");
  level._effect["vfx_ui_terminal_suit"] = loadfx("vfx/iw7/core/ui/vfx_ui_terminal_suit.vfx");
}

_id_8834(var_0) {
  if (isdefined(self._id_92B9) && self._id_92B9 == 1)
  _id_F3F0("hack");
  else
  _id_F3F0("hack", 1);

  setomnvar("ui_inworld_terminal_wrist_ent", var_0);
  setomnvar("ui_wrist_pc", 7);
  wait 6.0;
  setomnvar("ui_wrist_pc", 0);
}

_id_F3F0(var_0, var_1) {
  if (!isdefined(var_0))
  var_0 = "on";

  var_2 = self._id_87EB["fx_tag"];

  if (isdefined(var_1) && var_1) {
  setomnvar("ui_inworld_terminal_ent_2", var_2);
  setomnvar("ui_inworld_terminal_hack2", 1);
  setomnvar("ui_inworld_terminal_hack2", 0);
  } else {
  setomnvar("ui_inworld_terminal_ent", var_2);
  setomnvar("ui_inworld_terminal_hack", 1);
  setomnvar("ui_inworld_terminal_hack", 0);
  }

  wait 0.3;

  switch (var_0) {
  case "on":
  setomnvar("ui_inworld_terminal_on", 1);

  if (isdefined(var_1) && var_1)
  setomnvar("ui_inworld_terminal_hack2", 0);
  else
  setomnvar("ui_inworld_terminal_hack", 0);

  break;
  case "hacked":
  if (!getomnvar("ui_inworld_terminal_on"))
  setomnvar("ui_inworld_terminal_on", 1);

  if (isdefined(var_1) && var_1)
  setomnvar("ui_inworld_terminal_hack2", 2);
  else
  setomnvar("ui_inworld_terminal_hack", 2);

  break;
  case "hack":
  if (isdefined(var_1) && var_1)
  setomnvar("ui_inworld_terminal_hack2", 1);
  else
  setomnvar("ui_inworld_terminal_hack", 1);

  break;
  case "off":
  setomnvar("ui_inworld_terminal_on", 0);

  if (isdefined(var_1) && var_1)
  setomnvar("ui_inworld_terminal_hack2", 0);
  else
  setomnvar("ui_inworld_terminal_hack", 0);

  break;
  }
}