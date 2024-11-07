/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\3402.gsc
***************************************/

_id_375A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if (!_id_100AA(var_2, var_1, var_5, var_3))
  return;

  if (var_4 == "MOD_SUICIDE") {
  if (isdefined(level._id_C7E9[var_5]))
  level thread [[level._id_C7E9[var_5]]](var_12, var_5);
  }

  var_13 = isdefined(var_4) && (var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE_SPLASH");
  var_14 = isdefined(var_4) && var_4 == "MOD_EXPLOSIVE_BULLET";
  var_15 = _id_9E06(self, var_1);
  var_16 = _id_0A77::_id_9BFB();
  var_17 = _id_0A77::_id_8BBE("perk_machine_boom");
  var_18 = isdefined(var_1);
  var_19 = var_18 && isdefined(var_1._id_1096F) && var_1._id_1096F == "zombie";
  var_20 = var_18 && isdefined(var_1._id_1096F) && var_1._id_1096F == "zombie_grey";
  var_21 = var_18 && isdefined(var_1.agent_type) && var_1.agent_type == "zombie_brute";
  var_22 = var_18 && var_1 == self;
  var_23 = (var_22 || !var_18) && var_4 == "MOD_SUICIDE";

  if (var_18) {
  if (var_1 == self) {
  if (issubstr(var_5, "iw7_harpoon2_zm") || issubstr(var_5, "iw7_harpoon1_zm") || issubstr(var_5, "iw7_acid_rain_projectile_zm"))
  var_2 = 0;

  if (var_13) {
  var_24 = self getstance();

  if (var_17)
  var_2 = 0;
  else if (isdefined(self.has_fortified_passive) && self.has_fortified_passive && (self _meth_81BE() || (var_24 == "crouch" || var_24 == "prone") && self isonground()))
  var_2 = 0;
  else
  var_2 = _id_79A8(var_0, var_1, var_2, var_3, var_4, var_5);
  }

  switch (var_5) {
  case "zmb_fireworksprojectile_mp":
  case "zmb_imsprojectile_mp":
  case "iw7_armageddonmeteor_mp":
  var_2 = 0;
  break;
  case "iw7_stunbolt_zm":
  case "iw7_bluebolts_zm":
  case "blackhole_grenade_zm":
  case "blackhole_grenade_mp":
  var_2 = 25;
  break;
  default:
  break;
  }
  }
  else if (var_15) {
  if (var_16) {
  if (_id_0A77::_id_9CA6()) {
  if (isplayer(var_1) && isdefined(var_8) && var_8 != "shield") {
  if (isdefined(var_0))
  var_1 _meth_80B0(var_2, var_1.origin - (0, 0, 50), var_1, var_0, var_4);
  else
  var_1 _meth_80B0(var_2, var_1.origin, var_1);
  }

  var_2 = 0;
  }
  }
  else
  var_2 = 0;
  }
  else if (var_19) {
  if (var_4 != "MOD_EXPLOSIVE" && var_12 _id_0A77::_id_9BA0("burned_out")) {
  if (!scripts\engine\utility::_id_9CEE(var_1._id_9B81)) {
  var_12 _id_0A77::_id_C151("burned_out");
  var_1 thread _id_0A77::_id_4D0D(var_1, var_12, 3, int(var_1.maxhealth + 1000), var_4, "incendiary_ammo_mp", undefined, "burning");
  var_1.faf_burned_out = 1;
  }
  }

  var_25 = gettime();

  if (!isdefined(self._id_A92D) || var_25 - self._id_A92D > 20)
  self._id_A92D = var_25;
  else
  return;

  var_26 = 500;

  if (getdvarint("zom_damage_shield_duration") != 0)
  var_26 = getdvarint("zom_damage_shield_duration");

  if (isdefined(var_1._id_A8A2[self._id_134FD])) {
  var_27 = var_1._id_A8A2[self._id_134FD];

  if (var_27 + var_26 > gettime())
  var_2 = 0;
  else
  var_1._id_A8A2[self._id_134FD] = gettime();
  }
  else
  var_1._id_A8A2[self._id_134FD] = gettime();
  }
  else if (var_20)
  var_2 = _id_791A(var_0, var_1, var_2, var_3, var_4, var_5);

  if (var_14) {
  var_24 = self getstance();

  if (var_17)
  var_2 = 0;
  else if (isdefined(self.has_fortified_passive) && self.has_fortified_passive && (self _meth_81BE() || (var_24 == "crouch" || var_24 == "prone") && self isonground()))
  var_2 = 0;
  else if (!var_16 || var_1 == self && var_8 == "none")
  var_2 = 0;
  }
  }
  else if (var_17 && var_4 == "MOD_SUICIDE") {
  if (var_5 == "frag_grenade_zm" || var_5 == "cluster_grenade_zm")
  var_2 = 0;
  } else {
  var_24 = self getstance();

  if (isdefined(self.has_fortified_passive) && self.has_fortified_passive && (self _meth_81BE() || (var_24 == "crouch" || var_24 == "prone") && self isonground())) {
  if (var_5 == "frag_grenade_zm" || var_5 == "cluster_grenade_zm")
  var_2 = 0;
  }
  }

  if (var_4 == "MOD_FALLING") {
  if (_id_0A77::_id_12D6("specialty_falldamage"))
  var_2 = 0;
  else if (var_2 > 10) {
  if (var_2 > self.health * 0.15)
  var_2 = int(self.health * 0.15);
  }
  else
  var_2 = 0;
  }

  var_28 = 0.0;

  if (var_18 && var_1 _id_0A77::_id_9D20() && scripts\engine\utility::_id_9CEE(self._id_AD2D)) {
  if (self.health - var_2 < 1)
  var_2 = self.health - 1;
  }

  if (var_19 || var_20 || var_21 || var_22 && !var_23)
  var_2 = int(var_2 * var_12 _id_0A77::_id_7E5C());

  if (isdefined(self._id_AD2C))
  var_2 = int(max(self.maxhealth / 2.75, var_2));

  if (var_12 _id_0A77::_id_9BA0("secret_service") && isalive(var_1)) {
  var_29 = !isdefined(var_1.agent_type) || var_19 || !var_20 || !var_21 || scripts\engine\utility::_id_9CEE(var_1._id_9CDD) || !scripts\engine\utility::_id_9CEE(var_1._id_6622);
  var_30 = isdefined(var_1.agent_type) && (var_19 && (!var_20 || !var_21 || scripts\engine\utility::_id_9CEE(var_1._id_9CDD) || !scripts\engine\utility::_id_9CEE(var_1._id_6622)));
  var_30 = 0;

  if (isdefined(var_1.agent_type) && (var_1.agent_type == "karatemaster" || var_20 || var_21 || scripts\engine\utility::_id_9CEE(var_1._id_9CDD) || !scripts\engine\utility::_id_9CEE(var_1._id_6622)))
  var_30 = 0;
  else if (var_1 _id_0A77::agentisfnfimmune())
  var_30 = 0;
  else
  var_30 = 1;

  if (var_30) {
  var_1 thread _id_0A75::_id_1299C(var_12);
  var_12 _id_0A77::_id_C151("secret_service");
  }
  }

  var_2 = int(var_2);

  if (!var_15 || var_16) {
  _id_6CE1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_28, var_10, var_11);
  self notify("player_damaged");
  }

  _id_0A54::_id_12E04("personal", "damage_taken", var_2);

  if (var_2 <= 0)
  return;

  thread _id_0A77::_id_D222(var_1);
  thread _id_CDBE(self);
  self playlocalsound("zmb_player_impact_hit");
  thread _id_0A77::_id_D220();

  if (isdefined(var_1)) {
  thread _id_0A58::_id_13F0C();

  if (isagent(var_1)) {
  if (!isdefined(var_1._id_4CE9))
  var_1._id_4CE9 = 0;
  else
  var_1._id_4CE9 = var_1._id_4CE9 + var_2;

  self._id_DDB9 = var_1;

  if (isdefined(level._id_4B4A))
  self [[level._id_4C6E]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
  }
}

_id_CDBE(var_0) {
  var_0 notify("play_pain_photo");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("play_pain_photo");

  if (_id_0A5B::_id_D0EF(var_0))
  return;

  _id_0D5B::_id_F53F(var_0, "damaged");
  wait 4;
  _id_0D5B::_id_F53F(var_0, "healthy");
}

_id_50F9(var_0) {
  self endon("death");
  var_0 endon("death");
  wait 0.05;
  self _meth_80B0(2, self.origin, var_0, undefined, "MOD_MELEE");
}

_id_79A8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (!isdefined(var_5))
  return var_2;

  var_6 = getweaponbasename(var_5);

  if (!isdefined(var_6))
  return var_2;

  switch (var_6) {
  case "iw7_chargeshot_zm":
  case "throwingknifec4_mp":
  case "semtex_zm":
  case "frag_grenade_zm":
  var_7 = var_2 / 1200;
  var_2 = var_7 * 100;
  break;
  case "iw7_blackholegun_mp":
  case "c4_zm":
  var_7 = var_2 / 2000;
  var_2 = var_7 * 100;
  break;
  case "iw7_glprox_zm":
  case "cluster_grenade_zm":
  var_7 = var_2 / 800;
  var_2 = var_7 * 100;
  break;
  case "iw7_g18_zml":
  case "iw7_g18_zmr":
  case "iw7_g18_zm":
  if (_id_0A6B::_id_7D62(var_6) <= 2) {
  var_7 = var_2 / 1800;
  var_2 = var_7 * 100;
  break;
  }
  else
  var_2 = 0;

  break;
  case "iw7_armageddonmeteor_mp":
  var_2 = 0;
  break;
  case "iw7_stunbolt_zm":
  case "iw7_bluebolts_zm":
  var_2 = var_2 * 0.33;
  var_2 = min(80, var_2);
  break;
  case "iw7_shredderdummy_zm":
  case "iw7_facemelterdummy_zm":
  case "iw7_dischorddummy_zm":
  case "iw7_headcutterdummy_zm":
  case "iw7_headcutter3_zm":
  case "iw7_headcutter2_zm":
  case "iw7_headcutter_zm_pap1":
  case "iw7_headcutter_zm":
  case "iw7_facemelter_zm_pap1":
  case "iw7_facemelter_zm":
  case "iw7_dischord_zm_pap1":
  case "iw7_dischord_zm":
  case "iw7_shredder_zm_pap1":
  case "iw7_shredder_zm":
  var_2 = 0;
  break;
  case "iw7_headcuttershards_mp":
  var_2 = 0;
  break;
  case "splash_grenade_zm":
  case "splash_grenade_mp":
  var_2 = min(10, var_2);
  break;
  default:
  break;
  }

  return min(80, var_2);
}

_id_791A(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (isdefined(var_4)) {
  switch (var_4) {
  case "MOD_EXPLOSIVE":
  return var_2;
  case "MOD_PROJECTILE_SPLASH":
  case "MOD_PROJECTILE":
  return min(80, var_2);
  case "MOD_UNKNOWN":
  return var_2;
  default:
  return var_2;
  }
  }

  return var_2;
}

_id_100B8(var_0) {
  var_1 = 20;

  if (var_0 == 0)
  return 0;
  else
  return self._id_8C4C && var_0 > self.health && var_0 < self.health + var_1;
}

_id_13119(var_0) {
  var_1 = 0.2;
  var_2 = self.maxhealth * var_1;
  return _id_0A77::isusingremote() && (var_0 > self.health || self.health - var_0 <= var_2);
}

_id_1109B() {
  self notify("stop_using_remote");
}

_id_1309B(var_0) {
  self.health = var_0 + 1;
  self._id_8C4C = 0;
}

_id_100AA(var_0, var_1, var_2, var_3) {
  if (isdefined(var_2) && (var_2 == "zmb_imsprojectile_mp" || var_2 == "zmb_fireworksprojectile_mp") || var_2 == "zmb_robotprojectile_mp")
  return 0;

  if (isdefined(var_2) && var_2 == "bolasprayprojhome_mp")
  return 0;

  if (isdefined(var_3) && (var_3 == 256 || var_3 == 258))
  return 0;

  if (isdefined(self._id_98F3) && self._id_98F3)
  return 0;

  if (gettime() < self._id_4D69)
  return 0;

  if (isdefined(self._id_1516))
  return 0;

  if (isdefined(var_1) && isdefined(var_1._id_9C48))
  return 0;

  if (scripts\engine\utility::_id_9CEE(self._id_9C54))
  return 0;

  if (isdefined(self._id_9BE1))
  return 0;

  if (isdefined(self._id_AD2B))
  return 0;

  return 1;
}

_id_F29B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if (isdefined(var_1)) {
  if (var_1 == "xm25_mp" && var_0 == "MOD_IMPACT")
  var_2 = 95;

  if (var_1 == "spider_beam_mp")
  var_2 = var_2 * 15;

  if (var_1 == "alienthrowingknife_mp" && var_0 == "MOD_IMPACT") {
  if (_id_0A4F::_id_381F(var_3, 0, var_4, var_0, var_1, var_5, var_6, var_7, var_8, var_9))
  var_2 = 20000;
  else if (_id_0A4A::_id_77D7(self) != "elite")
  var_2 = 500;
  }
  }

  return var_2;
}

_id_12DA8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if (isdefined(var_1) && isdefined(var_1.owner))
  _id_0A4A::_id_110A4(var_1.owner, var_2 * 0.75);
  else if (isdefined(var_1) && isdefined(var_1._id_CA80) && var_1._id_CA80 == 1)
  _id_0A4A::_id_110A4(var_1.owner, var_2);
  else
  _id_0A4A::_id_110A4(var_1, var_2);

  if (isdefined(var_1) && isdefined(var_5))
  level thread _id_12E52(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);

  _id_12D87(var_1, var_2, var_4);
}

_id_12E52(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if (scripts\engine\utility::_id_9CEE(self._id_54CB))
  return;

  if (!isdefined(level._id_4B4A))
  return;

  if (isdefined(var_1) && isplayer(var_1)) {
  var_11 = self [[level._id_4C44]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9, var_10);

  if (!scripts\engine\utility::_id_9CEE(var_11))
  return;
  }
}

_id_12D87(var_0, var_1, var_2) {
  if (isdefined(level._id_12D87))
  [[level._id_12D87]](var_0, var_1, var_2);
  else
  _id_12E01(var_0, var_1, var_2);
}

_id_12E01(var_0, var_1, var_2) {
  if (!isdefined(var_0))
  return;

  if (isdefined(var_0.classname) && var_0.classname == "script_vehicle")
  return;

  if (var_2 == "MOD_TRIGGER_HURT")
  return;

  _id_0A54::_id_12E38(_id_0A54::_id_7CE6(), "damage_done_on_alien", var_1);

  if (isplayer(var_0))
  var_0 _id_0A54::_id_12E04("personal", "damage_done_on_alien", var_1);
  else if (isdefined(var_0.owner))
  var_0.owner _id_0A54::_id_12E04("personal", "damage_done_on_alien", var_1);
}

_id_2189(var_0, var_1, var_2) {
  return 1.0;
}

_id_11193(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if (isdefined(self._id_11192))
  return 0;

  var_7 = gettime();

  if (isdefined(self._id_A918) && !isdefined(var_5)) {
  if (var_7 < self._id_A918)
  return;
  }

  self._id_A918 = var_7 + 500;
  var_8 = 0;
  var_9 = 0;
  var_10 = 4;

  if (!isdefined(var_4))
  var_4 = 256;

  var_11 = _id_0A4A::_id_7DB0("axis");
  var_12 = scripts\engine\utility::_id_782F(var_1.origin, var_11, undefined, var_10, var_4, 1);

  if (scripts\engine\utility::array_contains(var_12, var_1))
  var_12 = scripts\engine\utility::array_remove(var_12, var_1);

  if (var_12.size >= 1) {
  if (!isdefined(self._id_11192))
  self._id_11192 = spawnstruct();

  if (scripts\engine\utility::_id_9CEE(var_5))
  var_2 = int(var_2);
  else
  var_2 = int(var_2 * 0.5);

  var_13 = ["j_crotch", "j_hip_le", "j_hip_ri"];
  var_0 = var_1 gettagorigin(scripts\engine\utility::_id_DC6B(var_13));

  foreach (var_15 in var_12) {
  if (isdefined(var_15) && var_15 != var_1 && isalive(var_15) && !scripts\engine\utility::_id_9CEE(var_15._id_11196)) {
  var_8 = 1;

  if (scripts\engine\utility::_id_9CEE(var_5))
  var_15.shockmelee = 1;

  var_15 _id_1118C(self, var_2, var_3, var_0);
  var_9++;

  if (var_9 >= var_10)
  break;
  }
  }

  wait 0.05;
  self._id_11192 = undefined;
  }

  if (scripts\engine\utility::_id_9CEE(var_5)) {
  _id_0A77::_id_C151("shock_melee_upgrade");
  var_1.shockmelee = 1;
  }

  if (isdefined(var_6))
  self notify(var_6);

  return var_8;
}

_id_1118C(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_4 = undefined;

  if (!isdefined(self) || !isalive(self))
  return;

  var_5 = ["j_crotch", "j_hip_le", "j_hip_ri", "j_shoulder_le", "j_shoulder_ri", "j_chest"];
  var_4 = self gettagorigin(scripts\engine\utility::_id_DC6B(var_5));

  if (isdefined(var_4)) {
  playfxbetweenpoints(level._effect["blue_ark_beam"], var_3, vectortoangles(var_3 - var_4), var_4);
  wait 0.05;

  if (isdefined(self) && var_2 == "MOD_MELEE")
  self playsound("zombie_fence_shock");

  wait 0.05;
  var_6 = int(var_1);
  scripts\common\fx::_id_D484(level._effect["stun_shock"], var_4);

  if (isdefined(self))
  thread _id_1118E(var_0, var_2, var_6, "stun_ammo_mp");
  }
}

_id_1118E(var_0, var_1, var_2, var_3) {
  self endon("death");

  if (isdefined(var_2))
  var_4 = var_2;
  else
  var_4 = 100;

  if (isdefined(var_3))
  var_5 = var_3;
  else
  var_5 = "iw7_stunbolt_zm";

  if (!_id_0C75::_id_9F87()) {
  self._id_11196 = 1;
  thread _id_0D53::_id_20E6(self);
  self._id_11190 = gettime() + 1500;
  }

  thread _id_E093(1);

  if (isdefined(var_0))
  self _meth_80B0(var_4, self.origin, var_0, var_0, var_1, var_5);
  else
  self _meth_80B0(var_4, self.origin, undefined, undefined, var_1, var_5);
}

_id_E093(var_0) {
  self endon("death");
  wait(var_0);

  if (!_id_0A77::_id_FF18(self))
  return;

  self._id_11196 = undefined;
}

monitordamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level endon("game_ended");

  if (!isdefined(var_5))
  var_5 = 0;

  self setcandamage(1);
  self.health = 999999;
  self.maxhealth = var_0;
  self._id_00E1 = 0;

  if (!isdefined(var_4))
  var_4 = 0;

  for (var_6 = 1; var_6; var_6 = monitordamageoneshot(var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_1, var_2, var_3, var_4)) {
  self waittill("damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);

  if (var_5)
  self playrumbleonentity("damage_light");

  if (isdefined(self.helitype) && self.helitype == "littlebird") {
  if (!isdefined(self.attackers))
  self.attackers = [];

  var_17 = "";

  if (isdefined(var_8) && isplayer(var_8))
  var_17 = var_8 _id_0A77::_id_81EC();

  if (isdefined(self.attackers[var_17]))
  self.attackers[var_17] = self.attackers[var_17] + var_7;
  else
  self.attackers[var_17] = var_7;
  }
  }
}

monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if (!isdefined(self))
  return 0;

  if (isdefined(var_1) && !_id_0A77::_id_9E0E(var_1) && !isdefined(var_1._id_1C9F))
  return 1;

  return 1;
}

_id_9E06(var_0, var_1) {
  if (!level.teambased)
  return 0;

  if (!isdefined(var_1))
  return 0;

  if (!isplayer(var_1) && !isdefined(var_1.team))
  return 0;

  if (var_0.team != var_1.team)
  return 0;

  if (var_0 == var_1)
  return 0;

  return 1;
}

_id_6CE1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if (!_id_374A(var_0, var_1, var_2 - var_2 * var_10, var_3, var_4, var_5, var_6, var_7, var_8, var_9))
  return;

  if (!isalive(self))
  return;

  if (isplayer(self))
  self _meth_80EA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

  _id_4D67(var_0, var_5, var_4, var_2, var_3, var_1);
}

_id_374A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if (isdefined(self._id_A970) && self._id_A970 && var_2 >= self.health && isdefined(self._id_4402) && self._id_4402 == "specialty_endgame") {
  _id_0A77::giveperk("specialty_endgame");
  return 0;
  }

  return 1;
}

_id_4D67(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_C5CB(var_0, var_1, var_2, var_3, var_5);

  if (!isai(self))
  self playrumbleonentity("damage_heavy");
}

_id_C5CB(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("disconnect");

  switch (var_1) {
  default:
  if (_id_1CA7(var_1) && !isai(var_4))
  _id_0A6B::_id_FC6A(var_2, var_3);

  break;
  }
}

_id_1CA7(var_0) {
  if (isdefined(var_0)) {
  switch (var_0) {
  case "iw7_zapper_grey":
  return 0;
  }
  }

  return 1;
}