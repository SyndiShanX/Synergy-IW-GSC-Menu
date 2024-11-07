/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2634.gsc
***************************************/

_id_108E8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_7EC5(var_0);

  if (isdefined(var_5)) {
  var_5.connecttime = gettime();
  var_5 _id_F28D(var_5, var_0);
  var_5 _id_F28F(var_5, var_0);
  var_5 _id_10971();

  if (_id_9CB3(var_0))
  var_5 = _id_107CF(var_5, var_0, var_2, var_3);
  else
  var_5 = _id_107B2(var_5, var_2, var_3);

  var_5 _id_F8A9(var_0);
  var_5 _id_F290(var_1);
  var_5 _id_F28E(var_5, var_0);
  var_5 _id_F291(var_5, var_0);
  var_5 _id_184B();
  var_5 _id_1601();
  }

  return var_5;
}

_id_F28D(var_0, var_1) {
  var_0 detachall();

  if (isdefined(level._id_13F58) && level._id_18EE[var_1]["traversal_unit_type"] == "zombie")
  var_0 [[level._id_13F58]](var_1);
  else
  {
  var_0 setmodel(level._id_18EE[var_1]["body_model"]);
  var_2 = strtok(level._id_18EE[var_1]["other_body_parts"], " ");

  foreach (var_4 in var_2)
  var_0 attach(var_4, "", 1);
  }

  var_0 show();
}

_id_9CB3(var_0) {
  return level._id_18EE[var_0]["animclass"] != "";
}

_id_107CF(var_0, var_1, var_2, var_3) {
  var_0._id_C50F = var_0 _id_10972("on_enter_animstate");
  var_0._id_9CB3 = 1;
  var_0 spawnagent(var_2, var_3, level._id_18EE[var_1]["animclass"], 15, 60);
  return var_0;
}

_id_107B2(var_0, var_1, var_2) {
  var_0._id_9CB3 = 0;
  var_0 spawnagent(var_1, var_2);
  return var_0;
}

_id_9B53(var_0) {
  return var_0._id_9CB3;
}

_id_9B5A() {
  return isagent(self) && isdefined(self._id_1096F) && self._id_1096F == "alien";
}

_id_F8A9(var_0) {
  var_1 = level._id_18EE[var_0];

  if (!isdefined(var_1))
  return;

  var_2 = var_1["setup_func"];

  if (!isdefined(var_2))
  return;

  self [[var_2]]();
}

_id_18F3(var_0, var_1, var_2, var_3, var_4) {
  if (_id_9B53(self))
  self _meth_8286(var_0);
  else
  self botsetscriptgoal(var_0, var_1, var_2, var_3, var_4);
}

_id_F28F(var_0, var_1) {
  if (!isdefined(level.agent_funcs[var_1]))
  level.agent_funcs[var_1] = [];

  var_0._id_1096F = level._id_18EE[var_1]["species"];
  _id_23B2("spawn", ::_id_5016);
  _id_23B2("on_damaged", ::_id_5003);
  _id_23B2("on_damaged_finished", ::_id_5004);
  _id_23B2("on_killed", ::_id_5006);
}

_id_23B2(var_0, var_1) {
  var_2 = self.agent_type;

  if (!isdefined(level.agent_funcs[var_2][var_0])) {
  if (!isdefined(level._id_10970[self._id_1096F]) || !isdefined(level._id_10970[self._id_1096F][var_0]))
  level.agent_funcs[var_2][var_0] = var_1;
  else
  level.agent_funcs[var_2][var_0] = level._id_10970[self._id_1096F][var_0];
  }
}

_id_F28E(var_0, var_1) {
  var_0 set_agent_health(level._id_18EE[var_1]["health"]);
}

_id_F291(var_0, var_1) {
  if (!_id_384C(var_0))
  return;

  var_0 _meth_828C(level._id_18EE[var_1]["traversal_unit_type"]);
}

_id_384C(var_0) {
  if (_id_9B53(var_0))
  return 1;

  return 0;
}

_id_10971() {
  if (isdefined(level._id_10970[self._id_1096F]) && isdefined(level._id_10970[self._id_1096F]["pre_spawn_init"]))
  self [[level._id_10970[self._id_1096F]["pre_spawn_init"]]]();
}

_id_7EC5(var_0) {
  var_1 = undefined;

  if (isdefined(level.agentarray)) {
  foreach (var_3 in level.agentarray) {
  if (!isdefined(var_3._id_9D25) || !var_3._id_9D25) {
  if (isdefined(var_3._id_136FD) && var_3._id_136FD)
  continue;

  var_1 = var_3;
  var_1.agent_type = var_0;
  var_1 _id_97C2();
  break;
  }
  }
  }

  return var_1;
}

_id_97C2() {
  self.pers = [];
  self._id_8BE2 = 0;
  self._id_9D25 = 0;
  self._id_10916 = 0;
  self.entity_number = self getentitynumber();
  self._id_18F2 = 0;
  self detachall();
  _id_98BB();
}

_id_98BB() {
  self.class = undefined;
  self._id_BCF6 = undefined;
  self._id_26B9 = undefined;
  self.guid = undefined;
  self.name = undefined;
  self._id_EB6A = undefined;
  self._id_CA5B = undefined;
  self._id_13CA0 = undefined;
  self._id_C2AD = undefined;
  self._id_0291 = undefined;
  self.sessionstate = undefined;
  self._id_55E6 = undefined;
  self._id_55E9 = undefined;
  self._id_55D9 = undefined;
  self._id_55E4 = 1;
  self._id_C026 = undefined;
  self._id_0184 = 0;
  self._id_0180 = 0;
  self._id_116D4 = undefined;
  self._id_441A = undefined;
  self._id_4B82 = undefined;
  self._id_5793 = undefined;
  self._id_37FD = 0;
  self._id_24CA = undefined;
  self._id_6622 = 0;
  self._id_B36E = undefined;
  self._id_126A3 = undefined;
  self._id_8C35 = 0;
  self._id_54CB = 0;
  self._id_9E0C = undefined;
  self._id_6F73 = undefined;
  self._id_28E0 = undefined;
  self._id_FF78 = undefined;
  self._id_9CDD = undefined;
  self._id_9CA2 = undefined;
  self._id_9B96 = undefined;
}

_id_F290(var_0, var_1) {
  self.team = var_0;
  self._id_0020 = var_0;
  self.pers["team"] = var_0;
  self.owner = var_1;
  self _meth_831F(var_1);
  self _meth_82DD(var_1);
}

_id_184B() {
  for (var_0 = 0; var_0 < level._id_3CB5.size; var_0++) {
  if (level._id_3CB5[var_0] == self)
  return;
  }

  level._id_3CB5[level._id_3CB5.size] = self;
}

agentfunc(var_0) {
  return level.agent_funcs[self.agent_type][var_0];
}

_id_10972(var_0) {
  return level._id_10970[self._id_1096F][var_0];
}

_id_1313C(var_0) {
  if (isagent(var_0) && (!isdefined(var_0._id_9D25) || !var_0._id_9D25))
  return undefined;

  if (isagent(var_0) && !isdefined(var_0.classname))
  return undefined;

  return var_0;
}

set_agent_health(var_0) {
  self.agenthealth = var_0;
  self.health = var_0;
  self.maxhealth = var_0;
}

_id_5016(var_0, var_1, var_2) {
  var_3 = _id_108E8("soldier", "axis", var_0, var_1);

  if (!isdefined(var_3))
  return undefined;

  var_3 botsetscriptgoal(var_3.origin, 0, "hunt");
  var_3 botsetstance("stand");
  var_3 takeallweapons();

  if (isdefined(var_2))
  var_3 giveweapon(var_2);
  else
  var_3 giveweapon("iw6_dlcweap02_mp");

  var_3 botsetdifficultysetting("maxInaccuracy", 4.5);
  var_3 botsetdifficultysetting("minInaccuracy", 2.25);
  return var_3;
}

_id_5003(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self;

  if (_id_9BEA(var_12, var_0))
  return;

  var_2 = _id_0A4F::_id_F29B(var_4, var_5, var_2, var_1, var_3, var_6, var_7, var_8, var_9, var_0);

  if (isplayer(var_1) && !_id_0A77::_id_9CEB(var_0, var_5)) {
  var_2 = _id_0A4F::_id_EB9D(var_1, var_2, var_4, var_5);
  var_2 = _id_0A4F::_id_EB9F(var_1, var_2, var_4, var_5, var_8);
  }

  var_2 = _id_E54A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  var_2 = _id_0A4F::_id_EB9E(var_1, var_2);
  var_2 = int(var_2);
  _id_D96E(var_1, var_2, var_4);
  _id_D96D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  _id_D96B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_12);
  var_12 [[level.agent_funcs[var_12.agent_type]["on_damaged_finished"]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

_id_E54A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_10._id_E54C = undefined;

  if (var_8 == "shield") {
  var_10._id_E54C = 1;
  var_2 = 0;
  }

  return var_2;
}

_id_D96E(var_0, var_1, var_2) {
  if (isdefined(level._id_12D84))
  [[level._id_12D84]](var_0, var_1, var_2);
}

_id_5004(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  var_13 = _id_0A77::_id_9CEB(var_0, var_5);

  if (isdefined(var_1)) {
  if (isplayer(var_1) || isdefined(var_1.owner) && isplayer(var_1.owner)) {
  if (!var_13)
  var_1 _id_0A4F::_id_3D9D(self, var_5, var_4);
  }
  }

  return 1;
}

_id_9BEA(var_0, var_1) {
  if (isdefined(var_1)) {
  if (isdefined(var_1.team) && var_1.team == var_0.team)
  return 1;

  if (isdefined(var_1.owner) && isdefined(var_1.owner.team) && var_1.owner.team == var_0.team)
  return 1;
  }

  return 0;
}

_id_5006(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_C4B3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  deactivateagent();
}

_id_8008(var_0) {
  if (!isdefined(var_0))
  var_0 = "all";

  var_1 = _id_7D95(var_0);
  return var_1.size;
}

_id_7D95(var_0) {
  var_1 = [];

  if (!isdefined(level.agentarray))
  return var_1;

  foreach (var_3 in level.agentarray) {
  if (isdefined(var_3._id_9D25) && var_3._id_9D25) {
  if (var_0 == "all" || var_3.agent_type == var_0)
  var_1[var_1.size] = var_3;
  }
  }

  return var_1;
}

_id_7DB0(var_0) {
  var_1 = [];

  foreach (var_3 in level.agentarray) {
  if (isalive(var_3) && isdefined(var_3.team) && var_3.team == var_0)
  var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_7D94(var_0) {
  var_1 = [];

  if (!isdefined(level.agentarray))
  return var_1;

  foreach (var_3 in level.agentarray) {
  if (isdefined(var_3._id_9D25) && var_3._id_9D25) {
  if (var_3._id_1096F == var_0)
  var_1[var_1.size] = var_3;
  }
  }

  return var_1;
}

_id_7DAF() {
  var_0 = [];

  foreach (var_2 in level.agentarray) {
  if (isalive(var_2))
  var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_1601() {
  self._id_9D25 = 1;
}

_id_C4B3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if (scripts\engine\utility::_id_9CEE(self.hasriotshieldequipped)) {
  _id_0A77::launchshield(var_2, var_3);

  if (!var_9) {
  var_10 = self dropitem(self getcurrentweapon());

  if (isdefined(var_10)) {
  var_10 thread deletepickupafterawhile();
  var_10.owner = self;
  var_10._id_C83A = var_1;
  var_10 makeunusable();
  }
  }
  }

  if (isdefined(self._id_C026))
  return;

  var_11 = self;
  self._id_2C09 = self cloneagent(var_8);

  if (_id_FF32(self))
  _id_5793(self._id_2C09);
  else
  thread _id_5124(self._id_2C09, var_6, var_5, var_4, var_0, var_3);

  _id_D97C(var_1, var_11, var_6, var_4, var_3);

  if (isdefined(level._id_12DC7))
  [[level._id_12DC7]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_FF32(var_0) {
  return scripts\engine\utility::_id_9CEE(var_0._id_5793);
}

_id_5793(var_0) {
  if (isdefined(var_0))
  var_0 startragdoll();
}

_id_5124(var_0, var_1, var_2, var_3, var_4, var_5) {
  if (isdefined(var_0)) {
  var_6 = var_0 _meth_8112();

  if (animhasnotetrack(var_6, "ignore_ragdoll"))
  return;
  }

  if (isdefined(level._id_C08A) && level._id_C08A.size) {
  foreach (var_8 in level._id_C08A) {
  if (distancesquared(var_0.origin, var_8.origin) < 65536)
  return;
  }
  }

  wait 0.2;

  if (!isdefined(var_0))
  return;

  if (var_0 _meth_81B7())
  return;

  var_6 = var_0 _meth_8112();
  var_10 = 0.35;

  if (animhasnotetrack(var_6, "start_ragdoll")) {
  var_11 = getnotetracktimes(var_6, "start_ragdoll");

  if (isdefined(var_11))
  var_10 = var_11[0];
  }

  var_12 = var_10 * getanimlength(var_6);
  wait(var_12);

  if (isdefined(var_0))
  var_0 startragdoll();
}

deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if (!isdefined(self))
  return;

  self delete();
}

_id_179E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_E08D(var_3);
  var_7 = _id_108E8(var_6, var_0, var_1, var_2);

  if (isdefined(var_7))
  var_7 thread [[var_7 _id_10972("spawn")]](var_1, var_2, var_3, var_4, var_5);

  return var_7;
}

_id_E08D(var_0) {
  var_1 = strtok(var_0, " ");

  if (isdefined(var_1) && var_1.size == 2)
  return var_1[1];
  else
  return var_0;
}

_id_D96D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  _id_0A4F::_id_12DA8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_D96B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if (!scripts\engine\utility::_id_9D74(var_4)) {
  if (_id_0A77::_id_9CEB(var_0, var_5))
  return;

  var_11 = gettime();

  if (isdefined(var_1._id_BF85) && var_1._id_BF85 > var_11)
  return;
  else
  var_1._id_BF85 = var_11 + 250;
  }

  var_12 = "standard";
  var_13 = undefined;

  if (var_10.health <= var_2)
  var_13 = 1;

  var_14 = _id_0A77::isheadshot(var_5, var_8, var_4, var_1);

  if (var_14)
  var_12 = "hitcritical";

  var_15 = scripts\engine\utility::_id_9D74(var_4);
  var_16 = var_14 && var_1 _id_0A77::_id_9BA0("sharp_shooter_upgrade");
  var_17 = var_15 && var_1 _id_0A77::_id_9BA0("bonus_damage_on_last_bullets");
  var_18 = var_15 && var_1 _id_0A77::_id_9BA0("damage_booster_upgrade");
  var_19 = scripts\engine\utility::_id_9CEE(var_1._id_98F3);
  var_20 = !var_19 && var_14 && var_15 && var_1 _id_0A77::_id_9BA0("headshot_explosion");
  var_21 = !_id_0A77::isreallyalive(var_10) || isagent(var_10) && var_2 >= var_10.health;
  var_22 = var_4 == "MOD_EXPLOSIVE_BULLET" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH";
  var_23 = var_4 == "MOD_MELEE";

  if (_id_0A4F::_id_A010(var_5))
  var_12 = "special_weapon";
  else if (var_16 || var_17 || var_18 || var_20)
  var_12 = "card_boosted";
  else if (issubstr(var_5, "arkyellow") && var_4 == "MOD_EXPLOSIVE_BULLET" && var_8 == "none")
  var_12 = "yellow_arcane_cp";
  else if (isplayer(var_1) && var_1 _id_0A77::_id_8BBE("perk_machine_boom") && var_22)
  var_12 = "high_damage";
  else if (isplayer(var_1) && var_1 _id_0A77::_id_8BBE("perk_machine_smack") && var_23)
  var_12 = "high_damage";
  else if (isplayer(var_1) && var_1 _id_0A77::_id_8BBE("perk_machine_rat_a_tat") && var_15)
  var_12 = "high_damage";
  else if (isplayer(var_1) && scripts\engine\utility::_id_9CEE(var_1.deadeye_charge) && var_15)
  var_12 = "dewdrops_cp";
  else if (scripts\engine\utility::_id_9CEE(level._id_9925))
  var_12 = "high_damage";
  else if (var_5 == "incendiary_ammo_mp")
  var_12 = "red_arcane_cp";
  else if (var_5 == "stun_ammo_mp")
  var_12 = "blue_arcane_cp";
  else if (var_5 == "slayer_ammo_mp")
  var_12 = "pink_arcane_cp";

  if (isdefined(var_1)) {
  if (isdefined(var_1.owner))
  var_1.owner thread _id_0A4F::updatedamagefeedback(var_12, var_13, var_2, var_10._id_E54C);
  else
  var_1 thread _id_0A4F::updatedamagefeedback(var_12, var_13, var_2, var_10._id_E54C);
  }
}

_id_D97C(var_0, var_1, var_2, var_3, var_4) {
  _id_0A65::_id_82A2(var_0, var_2);
  var_5 = _id_77D7(var_1);
  var_6 = _id_0A77::_id_7844(var_0);

  if (isdefined(var_6)) {
  _id_0A63::_id_DDE9(var_3, var_2, var_4, var_6);

  if (isdefined(level._id_B07A) && isdefined(var_5))
  [[level._id_B07A]](var_5, self.origin, var_0);
  }
}

_id_77FD() {
  var_0 = _id_7DB0("axis");
  var_1 = [];

  if (isdefined(level._id_5755))
  var_1 = [[level._id_5755]]();

  var_0 = scripts\engine\utility::_id_227F(var_0, var_1);
  return var_0;
}

_id_77D7(var_0) {
  return var_0.agent_type;
}

_id_110A4(var_0, var_1) {
  var_0 = _id_0A77::_id_7844(var_0);

  if (!isdefined(var_0))
  return;

  if (!isdefined(self._id_24DA))
  self._id_24DA = [];

  foreach (var_3 in self._id_24DA) {
  if (var_3.player == var_0) {
  var_3.damage = var_3.damage + var_1;
  return;
  }
  }

  var_5 = spawnstruct();
  var_5.player = var_0;
  var_5.damage = var_1;
  self._id_24DA[self._id_24DA.size] = var_5;
}

deactivateagent() {
  if (_id_0A77::_id_9E0E(self))
  _id_0A77::_id_E113();

  _id_0A77::_id_E106();
  _id_0A77::_id_E119();
  self._id_9D25 = 0;
  self._id_8BE2 = 0;
  self._id_B36A = undefined;
  self._id_BB9C = undefined;
  self.owner = undefined;
  self.connecttime = undefined;
  self._id_136FD = undefined;
  self._id_9B81 = undefined;
  self._id_9BC9 = undefined;
  self._id_1118F = undefined;
  self._id_BDF5 = undefined;

  foreach (var_1 in level._id_3CB5) {
  if (isdefined(var_1.attackers)) {
  foreach (var_4, var_3 in var_1.attackers) {
  if (var_3 == self)
  var_1.attackers[var_4] = undefined;
  }
  }
  }

  if (isdefined(self._id_8C98))
  self._id_8C98 = undefined;

  scripts\mp\mp_agent::deactivateagent();
  self notify("disconnect");
}