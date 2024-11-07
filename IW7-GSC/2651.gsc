/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2651.gsc
***************************************/

_id_373E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_500F(var_9);
}

_id_500F(var_0) {
  var_1 = _id_7682(self);

  if (var_1 && isdefined(level.endgame) && isdefined(level._id_62D1))
  level thread [[level.endgame]]("axis", level._id_62D1["kia"]);

  if (_id_D0EF(self))
  _id_72A1(var_0);
  else
  _id_5D2B(var_0, var_1);
}

_id_72A1(var_0) {
  if (_id_0A77::_id_9F02() || level._id_C552)
  self setorigin(var_0.origin);

  self._id_2B6A = var_0;
  self notify("force_bleed_out");
}

_id_5D2B(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("last_stand", _id_0A77::getvalidtakeweapon());
  var_2 = _id_0A77::_id_8BBE("perk_machine_revive");
  _id_6610();
  _id_6612();
  level._id_AA0B++;
  _id_6616();

  if ((_id_0A77::_id_9F02() || level._id_C552) && _id_8C50()) {
  if (_id_0A77::_id_9BA0("self_revive") || scripts\engine\utility::_id_9CEE(level.the_hoff_revive))
  _id_13701(var_0, var_1, var_2);
  else
  _id_13703(var_0, var_1);
  }
  else if (_id_4F33())
  _id_13703(var_0, var_1);
  else if (_id_B4DC(var_1, var_0)) {
  var_3 = _id_13701(var_0, var_1);

  if (!var_3)
  _id_13703(var_0, var_1);
  }
  else
  _id_13703(var_0, var_1);

  self notify("revive");
  level notify("revive_success", self);
  _id_6956();
  _id_6952();
  _id_6951();
}

_id_6616() {
  self._id_98F3 = 1;
  self.health = 1;
  scripts\engine\utility::_id_1C6E(0);
  self notify("healthRegeneration");
}

_id_6956() {
  self _meth_81DC();
  self setstance("stand");
  self._id_98F3 = 0;
  self.health = _id_7EF4();
  _id_0A77::_id_7298();
}

_id_7EF4() {
  return int(self.maxhealth);
}

_id_6612() {
  _id_0A54::_id_12E38(_id_0A54::_id_7CE6(), "num_players_enter_laststand");
  var_0 = ["iw7_gunless_zm"];

  if (isdefined(level._id_17D7))
  var_0 = scripts\engine\utility::_id_227F(var_0, level._id_17D7);

  if (isdefined(self.former_mule_weapon))
  var_0[var_0.size] = self.former_mule_weapon;

  var_1 = [];

  foreach (var_3 in self getweaponslistprimaries()) {
  if (!_id_0A77::_id_9F7C(var_3, "alt_"))
  var_1[var_1.size] = var_3;
  }

  self._id_B0A1 = var_1;
  _id_0A77::_id_110AA(var_0, 1);
  self._id_AA45 = _id_6613(var_0, 1);
  self._id_2B6A = undefined;
  self.saved_last_stand_pistol = self._id_A913;
  self._id_D7CE = self getweaponslistprimaries()[1];
  self._id_D7D0 = self getweaponammostock(self._id_D7CE);
  self._id_D7CF = self getweaponammoclip(self._id_D7CE);
  self._id_2A85 = 0;
  _id_3D89();
  thread _id_C553();
  _id_0A63::_id_11445(_id_78F8(self), 1, "laststand");
  _id_0A63::_id_666A("downs", 1);
  _id_0A63::increment_player_career_downs(self);
  _id_0A4B::_id_93C1();
  _id_0A4D::_id_12D9C("no_laststand");
  self _meth_8442();
}

_id_3D89() {
  if (!isdefined(self._id_4643))
  return;

  if (_id_0A77::_id_9BA0("just_a_flesh_wound"))
  return;

  var_0 = undefined;

  if (isdefined(self._id_AA45) && !scripts\engine\utility::_id_693B(self._id_4643, self._id_AA45))
  self._id_4643 = scripts\engine\utility::_id_2279(self._id_4643, self._id_AA45);

  foreach (var_2 in self._id_4643) {
  if (_id_0A6B::_id_8BD1(var_2, "doubletap")) {
  var_3 = strtok(var_2, "+");
  var_0 = var_3[0];

  for (var_4 = 1; var_4 < var_3.size; var_4++) {
  if (issubstr(var_3[var_4], "doubletap"))
  continue;

  var_0 = var_0 + ("+" + var_3[var_4]);
  }

  if (scripts\engine\utility::array_contains(self._id_4643, var_2)) {
  self._id_4643 = scripts\engine\utility::array_remove(self._id_4643, var_2);
  self._id_4643[self._id_4643.size] = var_0;
  }

  if (issubstr(self._id_464B, var_3[0]))
  self._id_464B = var_0;

  var_5 = getarraykeys(self._id_4648);
  var_6 = getarraykeys(self._id_464A);

  foreach (var_8 in var_5) {
  if (issubstr(var_8, var_3[0])) {
  if (var_0 != var_8) {
  self._id_4648[var_0] = self._id_4648[var_8];
  self._id_4648[var_8] = undefined;
  }
  }
  }

  foreach (var_11 in var_6) {
  if (issubstr(var_11, var_3[0])) {
  if (var_0 != var_11) {
  self._id_464A[var_0] = self._id_464A[var_11];
  self._id_464A[var_11] = undefined;
  }
  }
  }

  if (issubstr(self._id_AA45, var_3[0]))
  self._id_AA45 = var_0;

  if (issubstr(self._id_D7CE, var_3[0]))
  self._id_D7CE = var_0;
  }
  }
}

_id_6613(var_0, var_1) {
  var_2 = _id_0A77::getvalidtakeweapon(var_0);

  if (isdefined(self._id_D7AB))
  var_2 = self._id_D7AB;

  var_3 = 0;

  if (var_2 == "none")
  var_3 = 1;
  else if (scripts\engine\utility::array_contains(var_0, var_2))
  var_3 = 1;
  else if (scripts\engine\utility::array_contains(var_0, getweaponbasename(var_2)))
  var_3 = 1;
  else if (scripts\engine\utility::_id_9CEE(var_1) && _id_0A77::_id_9C42(var_2, 1))
  var_3 = 1;

  if (_id_0A77::_id_9C8F(var_2))
  var_3 = 0;

  if (var_3)
  return _id_3E88(var_0, var_1, 1);
  else
  return var_2;
}

_id_3E88(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < self._id_4643.size; var_3++) {
  if (self._id_4643[var_3] == "none")
  continue;
  else if (scripts\engine\utility::array_contains(var_0, self._id_4643[var_3]))
  continue;
  else if (scripts\engine\utility::array_contains(var_0, getweaponbasename(self._id_4643[var_3])))
  continue;
  else if (scripts\engine\utility::_id_9CEE(var_1) && _id_0A77::_id_9C42(self._id_4643[var_3], var_2))
  continue;
  else
  return self._id_4643[var_3];
  }
}

_id_6952() {
  self._id_8C4C = 1;
  self._id_4D69 = gettime() + 3000;
  var_0 = [];
  _id_0A77::_id_E2D5(var_0);

  if (isdefined(self._id_D7D0))
  self setweaponammostock(self._id_D7CE, self._id_D7D0);

  if (isdefined(self._id_D7CF))
  self setweaponammoclip(self._id_D7CE, self._id_D7CF);

  self setspawnweapon(self._id_AA45, 1);
  give_fists_if_no_real_weapon(self);
  self._id_2B6A = undefined;
  self._id_D7AB = undefined;
  self._id_D7AC = undefined;
  self._id_D7AD = undefined;
  self.former_mule_weapon = undefined;
  _id_0A4B::_id_93C7();
  _id_0A4F::_id_F446(self, 0);
  _id_12ED5();
  self _meth_82BE("player_damaged", 2, 0);
}

_id_6610() {
  if (isdefined(level._id_A9FD))
  [[level._id_A9FD]](self);

  if (isdefined(level._id_A9FE))
  [[level._id_A9FE]](self);
}

_id_6951() {
  if (isdefined(level._id_A9FF))
  [[level._id_A9FF]](self);
}

_id_13701(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  if (_id_F1E6())
  return _id_F1E5(self);

  var_3 = 35;

  if (_id_0A77::_id_9BA0("coagulant")) {
  var_3 = 60;
  _id_0A77::_id_C151("coagulant");
  }

  if (_id_0A77::_id_9F02() || level._id_C552) {
  if (_id_0A77::_id_8BBE("perk_machine_revive") && !isdefined(level.the_hoff_revive)) {
  wait 5;
  return 1;
  }
  }
  else
  var_2 = undefined;

  if (!var_1) {
  thread _id_CF17(var_3);

  if (_id_0A77::_id_9F02() || level._id_C552) {
  _id_1143C(self, 1);

  if (scripts\engine\utility::_id_9CEE(level.the_hoff_revive))
  _id_F44B(self, 35);
  else
  _id_F44B(self, 5);
  }
  else
  _id_F44B(self, var_3);
  }

  if (_id_0A77::_id_9F02() || level._id_C552 && !isdefined(level.the_hoff_revive))
  return _id_13626(var_0, var_1);
  else
  return _id_13679(self, self.origin, undefined, undefined, 1, _id_7B22(), (0.33, 0.75, 0.24), var_3, 0, var_1, 1, var_2);
}

_id_13703(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  wait 0.5;
  self notify("death");
  scripts\engine\utility::waitframe();
  _id_DDE2(var_0);

  if (isdefined(self._id_2B6A)) {
  var_0 = self._id_2B6A;
  self._id_2B6A = undefined;
  }

  if (_id_9C2D(var_0)) {
  var_2 = scripts\engine\utility::_id_5D14(var_0.origin, 32, -64) + (0, 0, 5);
  var_3 = var_0.angles;
  } else {
  var_2 = self.origin;
  var_3 = self.angles;
  }

  _id_4164(self);
  self._id_1097A = 1;

  foreach (var_5 in level.players) {
  if (var_5 == self)
  continue;

  var_6 = var_5 _id_0A63::_id_7B8B();
  var_7 = int(var_6 * 0.1);
  var_5 _id_0A63::_id_11445(var_7, 1, "bleedoutPenalty");
  }

  var_9 = _id_13679(self, var_2, undefined, undefined, 0, _id_7C95(), (1, 0, 0), undefined, 1, var_1, 0);
  _id_100C2(self);
  self._id_1097A = undefined;
  _id_0A77::updatesessionstate("playing");
  self._id_72E2 = var_2;
  self._id_72E0 = var_3;

  if (isdefined(level._id_D869))
  [[level._id_D869]](self);

  _id_0A55::_id_108F2();
}

_id_DDE2(var_0) {
  _id_0A63::_id_666A("deaths", 1);
  _id_0A4D::_id_12D9C("no_bleedout");

  if (!_id_9C2D(var_0)) {
  _id_0A54::_id_12E38(_id_0A54::_id_7CE6(), "num_players_bleed_out");
  _id_0A4B::_id_93BE();
  }
}

_id_13626(var_0, var_1) {
  if (var_1) {
  level waittill("forever");
  _id_4164(self);
  return 0;
  }

  if (_id_9C2D(var_0))
  self setorigin(var_0.origin);
  else
  wait 5;

  _id_4164(self);
  return 1;
}

_id_13679(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _id_B2AE(var_0, var_1, var_2, var_3, var_4);

  if (var_8)
  thread _id_661D(var_0, var_1, var_12);

  if (var_9) {
  level waittill("forever");
  return 0;
  } else {
  var_13 = var_12;

  if (var_8)
  var_13 = _id_B2B0(var_0, var_12);

  if (var_10)
  var_13 _id_B2AF(var_13, var_0, var_6, var_7);

  var_0._id_E4A9 = var_12;
  var_0._id_E4AB = var_13;

  if (isdefined(level.wait_to_be_revived_func)) {
  var_14 = [[level.wait_to_be_revived_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if (isdefined(var_14))
  return var_14;
  }

  if (var_10)
  var_12 thread _id_AA1A(var_0, var_5);

  if (isdefined(var_7))
  var_14 = var_12 _id_0A77::_id_1372C(var_7, var_12, "revive_success", var_0, "force_bleed_out", var_0, "revive_success", var_0, "challenge_complete_revive");
  else
  var_14 = var_12 _id_0A77::_id_1372D(var_12, "revive_success", var_0, "challenge_complete_revive");

  if (var_14 == "timeout" && _id_9B79(var_0))
  var_14 = var_12 scripts\engine\utility::_id_13734("revive_success", "revive_fail");

  if (var_14 == "revive_success" || var_14 == "challenge_complete_revive")
  return 1;
  else
  return 0;
  }
}

_id_AA1A(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  for (;;) {
  self makeusable();
  self waittill("trigger", var_2);
  self makeunusable();

  if (!var_2 isonground())
  continue;

  if (var_2 _meth_81AE())
  continue;

  if (!isplayer(var_2) && !scripts\engine\utility::_id_9CEE(var_2._id_3842))
  continue;

  var_3 = _id_80F0(var_2, var_0);
  var_4 = int(var_1 / var_3);
  var_5 = _id_7C12(var_0, var_2, self.origin, var_4);

  if (var_5) {
  if (isdefined(var_2._id_134FD)) {
  if (var_0._id_134FD == "p4_" && soundexists(var_2._id_134FD + "respawn_laststand_valleygirl")) {
  var_2 thread _id_0A6A::_id_12885("respawn_laststand_valleygirl", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
  var_0 thread _id_0A6A::_id_12885("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  }
  else if (var_0._id_134FD == "p1_" && soundexists(var_2._id_134FD + "respawn_laststand_aj")) {
  var_2 thread _id_0A6A::_id_12885("respawn_laststand_aj", "zmb_comment_vo", "medium", 10, 0, 0, 0, 50);
  var_0 thread _id_0A6A::_id_12885("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  }
  else if (level.script == "cp_town") {
  if (var_2._id_134FD == "p1_")
  var_0 thread _id_0A6A::_id_12885("respawn_laststand_sally", "town_comment_vo");
  }
  else
  var_0 thread _id_0A6A::_id_12885("respawn_laststand", "zmb_comment_vo", "medium", 10, 0, 0, 1, 50);
  }

  if (var_0 _id_0A77::_id_9BA0("faster_revive_upgrade"))
  var_0 _id_0A77::_id_C151("faster_revive_upgrade");

  var_2 playlocalsound("revive_teammate");
  _id_DDEA(var_2, var_0);
  var_2 notify("revive_teammate", var_0);

  if (isplayer(var_2) && scripts\engine\utility::_id_9CEE(var_2.can_give_revive_xp)) {
  var_2.can_give_revive_xp = 0;
  var_2 _id_0A63::_id_831D(int(250), 1);
  }

  break;
  } else {
  self notify("revive_fail");
  continue;
  }
  }

  _id_4164(var_0);
  self notify("revive_success");
}

_id_80F0(var_0, var_1) {
  if (scripts\engine\utility::_id_9CEE(var_0._id_3842))
  return 2;

  var_2 = var_0 _id_0CFC::_id_CA41();

  if (var_1 _id_0A77::_id_9BA0("faster_revive_upgrade"))
  var_2 = var_2 * 2;

  return var_2;
}

_id_B529(var_0, var_1) {
  _id_992F(var_1);
  _id_DDEA(var_0, var_1);
}

_id_DDEA(var_0, var_1) {
  if (isplayer(var_0)) {
  var_0 _id_0A5E::_id_D9AD("mt_reviver");
  var_0 _id_0A63::increment_player_career_revives(var_0);
  var_0 _id_0A5E::_id_D9AD("mt_revives");
  var_0 _id_0A63::_id_666A("revives", 1);
  var_1 thread _id_0A57::showsplash("revived", undefined, var_0);

  if (isdefined(level._id_E4A4))
  [[level._id_E4A4]](var_0);
  }
}

_id_B2AE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 0, 20);
  var_1 = scripts\engine\utility::_id_5D14(var_1 + var_5, 32, -64);
  var_6 = spawn("script_model", var_1);
  var_6 setcursorhint("HINT_NOICON");
  var_6 sethintstring(&"PLATFORM_REVIVE");
  var_6.owner = var_0;
  var_6._id_9B04 = 0;
  var_6._id_0336 = "revive_trigger";

  if (isdefined(var_2))
  var_6 setmodel(var_2);

  if (isdefined(var_3))
  var_6 scriptmodelplayanim(var_3);

  if (var_4)
  var_6 linkto(var_0, "tag_origin", var_5, (0, 0, 0));

  var_6 thread _id_4110(var_0);
  return var_6;
}

_id_B2B0(var_0, var_1) {
  var_2 = (0, 0, 30);
  var_3 = spawn("script_model", var_1.origin + var_2);
  var_3 thread _id_4110(var_0);
  return var_3;
}

_id_B4DC(var_0, var_1) {
  if (_id_0A77::_id_9F02() || level._id_C552)
  return _id_10400(var_0, var_1);
  else
  return _id_4628(var_1);
}

_id_10400(var_0, var_1) {
  if (var_0 && _id_9C2D(var_1))
  return 0;

  return 1;
}

_id_4628(var_0) {
  if (_id_9C2D(var_0))
  return 0;

  return 1;
}

_id_C553() {
  if (scripts\engine\utility::_id_9CEE(self._id_9D81))
  wait 0.5;

  var_0 = _id_7A72();

  if (self hasweapon(var_0))
  self _meth_83B8(var_0);

  _id_0A77::_id_12C6(var_0, _id_0A77::_id_7D72(self, var_0), 0, 1);
  var_1 = ["iw7_knife_zm", "iw7_knife_zm_hoff", "iw7_knife_zm_jock", "iw7_knife_zm_vgirl", "iw7_knife_zm_rapper", "iw7_knife_zm_nerd", "iw7_knife_zm_schoolgirl", "iw7_knife_zm_scientist", "iw7_knife_zm_soldier", "iw7_knife_zm_rebel", "iw7_knife_zm_elvira", "iw7_knife_zm_disco"];
  var_2 = _id_3868(self);

  if (var_2)
  var_1[var_1.size] = var_0;

  _id_1420(var_1);
  var_3 = _id_7B40();

  if (var_2) {
  var_4 = self getammocount(var_0);
  var_5 = weaponclipsize(var_0);
  self setweaponammostock(var_0, var_5 * var_3);
  self setweaponammoclip(var_0, var_5);
  self _meth_83B6(var_0);
  }
}

_id_7B40() {
  return 2;
}

_id_7A72() {
  if (isdefined(self._id_A913))
  return self._id_A913;

  var_0 = self._id_501C;
  var_1 = self getweaponslistprimaries()[0];

  if (_id_0A77::_id_7DF7(var_0) == _id_0A77::_id_7DF7(var_1))
  return var_1;
  else
  return var_0;
}

_id_3868(var_0) {
  if (isdefined(level._id_3869))
  return [[level._id_3869]](var_0);
  else
  return 1;
}

_id_4110(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("death", "disconnect", "revive");
  self delete();
}

_id_E026(var_0, var_1) {
  if (!isdefined(var_1))
  return;

  var_1._id_E49F = scripts\engine\utility::array_remove(var_1._id_E49F, var_0);
}

_id_500D() {
  _id_970D(self);
}

_id_9730(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 5.0;
  var_1 = _id_7A71();
}

_id_82E0(var_0, var_1) {
  if (!isdefined(var_1))
  var_1 = 1;

  var_2 = var_0 _id_7A71() + var_1;
  _id_F44A(var_0, var_2);
}

_id_1143C(var_0, var_1) {
  if (!isdefined(var_1))
  var_1 = 1;

  var_2 = var_0 _id_7A71() - var_1;
  _id_F44A(var_0, max(var_2, 0));
}

_id_7682(var_0) {
  if (var_0 _id_F1E6())
  return 0;

  if ((_id_0A77::_id_9F02() || level._id_C552) && (var_0 _id_0A77::_id_8BBE("perk_machine_revive") || scripts\engine\utility::_id_9CEE(level.the_hoff_revive)))
  return 0;

  if (_id_0A77::_id_9F02() || level._id_C552)
  return _id_103FF(var_0);
  else
  return _id_4624(var_0);
}

_id_103FF(var_0) {
  if (_id_D0EF(var_0))
  return 0;

  return var_0 _id_7A71() == 0;
}

_id_4624(var_0) {
  return _id_68BE(var_0);
}

_id_68BE(var_0) {
  foreach (var_2 in level.players) {
  if (var_2 == var_0)
  continue;

  if (!_id_D0EF(var_2))
  return 0;
  }

  return 1;
}

_id_7C12(var_0, var_1, var_2, var_3) {
  var_4 = _id_4A2D(var_2);
  var_4 thread _id_4110(var_0);
  var_5 = _id_E4A6(var_0, var_1, var_4, var_3);
  return var_5;
}

_id_4A2D(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1._id_4B30 = 0;
  var_1._id_130EE = 0;
  var_1._id_130C7 = 8000;
  var_1._id_9B04 = 0;
  return var_1;
}

_id_CF17(var_0) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");
  _id_0A77::_id_CF16();
  wait(var_0 / 3);
  _id_0A77::_id_CF16();
  wait(var_0 / 3);
  thread _id_0A6A::_id_12885("laststand_bleedout", "zmb_comment_vo", "low", 10, 0, 0, 1, 100);
  _id_0A77::_id_CF16();
}

_id_661D(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("game_ended");

  if (isdefined(var_0._id_3AF5))
  var_0._id_3AF5 destroy();

  var_0._id_8B69 = 0;
  _id_660A();
  _id_37C0(var_0, var_1, var_2);
  _id_6943();
}

_id_37C0(var_0, var_1, var_2) {
  var_2 endon("revive_success");
  var_3 = (0, 0, 30);
  var_4 = (0, 0, 100);
  var_5 = (0, 0, 400);
  var_6 = 2.0;
  var_7 = 0.6;
  var_8 = 0.6;
  var_9 = var_1 + var_3;
  var_10 = bullettrace(var_9, var_9 + var_4, 0, var_0);
  var_11 = var_10["position"];
  var_10 = bullettrace(var_11, var_11 + var_5, 0, var_0);
  var_12 = var_10["position"];
  var_13 = spawn("script_model", var_11);
  var_13 setmodel("tag_origin");
  var_13.angles = vectortoangles((0, 0, -1));
  var_13 thread _id_4110(var_0);
  var_0 cameralinkto(var_13, "tag_origin");
  var_13 moveto(var_12, var_6, var_7, var_8);
  var_13 waittill("movedone");
  var_13 delete();
  var_0 _id_6609(var_0);
}

_id_6609(var_0) {
  _id_8E6C(var_0);

  if (isdefined(level._id_CF91))
  var_0 [[level._id_CF91]](var_0);
  else
  var_0 _id_0A55::_id_662C();
}

_id_660A() {
  self playerhide();
  self _meth_80F9(1);
  self.zoom_out_camera = 1;
}

_id_6943() {
  self cameraunlink();
  self _meth_80F9(0);
  self.zoom_out_camera = undefined;
}

_id_E4A6(var_0, var_1, var_2, var_3) {
  if (isdefined(var_1._id_134FD)) {
  if (var_0._id_134FD == "p1_" && soundexists(var_1._id_134FD + "reviving_valleygirl"))
  var_1 thread _id_0A6A::_id_12885("reviving_valleygirl", "zmb_comment_vo");
  else if (var_0._id_134FD == "p1_" && soundexists(var_1._id_134FD + "reviving_sally"))
  var_1 thread _id_0A6A::_id_12885("reviving_sally", "zmb_comment_vo");
  else
  var_1 thread _id_0A6A::_id_12885("reviving", "zmb_comment_vo");
  }

  _id_661A(var_0, var_1, var_2, var_3);

  if (!isdefined(level._id_1176A) || isdefined(level._id_1176A) && var_1 != level._id_1176A)
  _id_CDE3(var_1, var_0);

  thread _id_135D1(var_0, var_1, var_2, var_1 _id_0A77::getvalidtakeweapon());
  var_0._id_E4AD = var_1;
  var_4 = 0;
  var_5 = 0;
  _id_621E(var_0, var_1);

  if (isplayer(var_1))
  var_0 notify("reviving");

  while (_id_FF85(var_1)) {
  if (var_4 >= var_3) {
  var_5 = 1;
  break;
  }

  var_6 = var_4 / var_3;
  _id_12E15(var_0, var_1, var_6);
  var_4 = var_4 + 50;
  scripts\engine\utility::waitframe();
  }

  _id_555D(var_0, var_1);
  var_2 notify("use_hold_think_complete");
  var_2 waittill("exit_use_hold_think_complete");
  return var_5;
}

_id_CDE3(var_0, var_1) {
  var_0 giveweapon("iw7_gunless_zm");
  var_0 _meth_83B5("iw7_gunless_zm");
  var_0 _meth_800F(0);
  var_0 _meth_80AB();
  var_0 _meth_846F(get_revive_gesture(var_0), var_1);
}

_id_11038(var_0, var_1) {
  var_0 _meth_83B8("iw7_gunless_zm");
  var_0 enableweaponswitch();
  var_0 _meth_83B5(var_1);
  var_0 _meth_800F(1);
  var_0 _meth_8442(get_revive_gesture(var_0));
}

get_revive_gesture(var_0) {
  if (isdefined(var_0.revive_gesture))
  return var_0.revive_gesture;
  else
  return "ges_zombies_revive_nerd";
}

_id_12E15(var_0, var_1, var_2) {
  foreach (var_4 in level.players) {
  if (var_4 == var_0 || var_4 == var_1) {
  var_4 setclientomnvar("ui_securing_progress", var_2);
  continue;
  }

  var_4 setclientomnvar("zm_revive_bar_" + var_0._id_E4A3 + "_progress", var_2);
  }
}

_id_661A(var_0, var_1, var_2, var_3) {
  var_0 setclientomnvar("ui_securing", 4);
  var_1 setclientomnvar("ui_securing", 3);
  var_0._id_2A85 = 1;

  if (isplayer(var_1)) {
  var_1 _meth_823A(var_2);
  var_1 _meth_8234();
  var_1 _id_0D15::_id_D728();
  var_1 thread _id_CDDC(var_1);
  }

  var_1._id_9F28 = 1;
}

_id_135D1(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::_id_1372B(var_2, "use_hold_think_complete", var_0, "disconnect", var_0, "revive_success", var_0, "force_bleed_out", var_1, "challenge_complete", var_0, "death");

  if (_id_0A77::isreallyalive(var_0)) {
  var_0._id_2A85 = 0;
  var_0 setclientomnvar("ui_securing", 0);
  }

  var_1._id_9F28 = 0;

  if (isplayer(var_1)) {
  var_1 _id_11038(var_1, var_3);
  var_1 setclientomnvar("ui_securing", 0);
  var_1 _id_0D15::_id_D72E();
  var_1 unlink();
  var_1 notify("stop_revive");
  }

  var_2 notify("exit_use_hold_think_complete");
}

_id_CDDC(var_0) {
  var_0 endon("disconnect");
  var_0 endon("stop_playing_revive_anim");
  var_0 _meth_84D3("power_active_cp", "gesture015");
}

_id_FF85(var_0) {
  if (scripts\engine\utility::_id_9CEE(var_0._id_3842))
  return 1;

  return !level._id_7669 && _id_0A77::isreallyalive(var_0) && var_0 usebuttonpressed() && !_id_D0EF(var_0);
}

_id_1420(var_0) {
  var_1 = self _meth_8173();

  foreach (var_3 in var_1) {
  if (scripts\engine\utility::array_contains(var_0, var_3))
  continue;
  else
  self _meth_83B8(var_3);
  }
}

_id_9C2D(var_0) {
  return isdefined(var_0);
}

_id_F44A(var_0, var_1) {
  var_1 = int(var_1);
  var_0 setrankedplayerdata("cp", "alienSession", "last_stand_count", var_1);
}

_id_F44B(var_0, var_1) {
  var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", gettime() + var_1 * 1000);
}

_id_4164(var_0) {
  var_0 setclientomnvar("zm_ui_laststand_end_milliseconds", 0);
}

_id_992F(var_0) {
  var_0 notify("revive_success");

  if (isdefined(var_0._id_E4A9))
  var_0._id_E4A9 notify("revive_success");

  if (_id_9B79(var_0))
  _id_555D(var_0, var_0._id_E4AD);

  _id_4164(var_0);
}

_id_F579(var_0, var_1) {
  if (isdefined(var_0))
  level._id_C092 = var_0;

  if (isdefined(var_1))
  level._id_1097D = var_1;
}

_id_7B22() {
  if (isdefined(level._id_C092))
  return level._id_C092;
  else
  return 5000;
}

_id_7C95() {
  if (isdefined(level._id_1097D))
  return level._id_1097D;
  else
  return 6000;
}

_id_12ED5() {
  self [[level._id_BC70]]();
}

_id_78F8(var_0) {
  if (isdefined(level._id_A9FB))
  return [[level._id_A9FB]](var_0);

  return 500;
}

_id_B2AF(var_0, var_1, var_2, var_3) {
  _id_FA27(var_0);
  var_0._id_4BA5 = var_2;
  var_0 thread _id_E4AC(var_0);
  var_4 = undefined;

  foreach (var_6 in level.players) {
  if (var_6 == var_1)
  continue;

  var_4 = _id_100F6(var_0, var_6);
  _id_177C(var_0, var_4);
  }

  if (isdefined(var_3))
  var_0 thread _id_E49B(var_3);

  return var_4;
}

_id_100F6(var_0, var_1) {
  var_2 = newclienthudelem(var_1);
  var_2 setshader("waypoint_alien_revive", 8, 8);
  var_2 setwaypoint(1, 1);
  var_2 _meth_8346(var_0);
  var_2.alpha = _id_7C11(var_1);
  var_2._id_00B9 = var_0._id_4BA5;
  _id_1774(var_1, var_2);
  var_2 thread _id_E4AA(var_0, var_1);
  return var_2;
}

_id_E4AC(var_0) {
  var_0 waittill("death");
  _id_E02A(var_0);
}

_id_E4AA(var_0, var_1) {
  _id_0A77::_id_1372D(var_0, "death", var_1, "disconnect");
  _id_E026(self, var_1);

  if (isdefined(self))
  self destroy();
}

_id_E49B(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0 / 3);
  _id_F578(self, (1, 0.941, 0));
  wait(var_0 / 3);
  _id_F578(self, (0.929, 0.231, 0.141));
}

_id_F578(var_0, var_1) {
  var_0._id_4BA5 = var_1;
  var_0._id_E49F = scripts\engine\utility::_id_22BC(var_0._id_E49F);

  foreach (var_3 in var_0._id_E49F)
  var_3._id_00B9 = var_1;
}

_id_9654() {
  level._id_E49C = [];
  level._id_D407 = [];
  level thread _id_E49E();
}

_id_177D(var_0) {
  level._id_E49C[level._id_E49C.size] = var_0;
}

_id_E02A(var_0) {
  level._id_E49C = scripts\engine\utility::array_remove(level._id_E49C, var_0);
  level._id_E49C = scripts\engine\utility::_id_22BC(level._id_E49C);
}

_id_E49E() {
  level endon("game_ended");

  for (;;) {
  level waittill("connected", var_0);

  foreach (var_2 in level._id_E49C)
  _id_100F6(var_2, var_0);

  foreach (var_5 in level._id_D407) {
  if (isdefined(var_5))
  var_0 setclientomnvar("zm_revive_bar_" + var_5._id_E4A3 + "_target", var_5);
  }
  }
}

_id_FA27(var_0) {
  var_0._id_E49F = [];
  _id_177D(var_0);
}

_id_177C(var_0, var_1) {
  var_0._id_E49F[var_0._id_E49F.size] = var_1;
}

_id_970D(var_0) {
  var_0._id_E49F = [];
}

_id_1774(var_0, var_1) {
  var_0._id_E49F[var_0._id_E49F.size] = var_1;
}

_id_E028(var_0, var_1) {
  var_0._id_E49F = scripts\engine\utility::array_remove(var_0._id_E49F, var_1);
}

_id_7C11(var_0) {
  if (isdefined(level._id_E49D))
  return [[level._id_E49D]](var_0);
  else
  return 1;
}

_id_100C2(var_0) {
  foreach (var_2 in var_0._id_E49F)
  var_2.alpha = 1;
}

_id_8E6C(var_0) {
  foreach (var_2 in var_0._id_E49F)
  var_2.alpha = 0;
}

_id_621E(var_0, var_1) {
  var_2 = _id_1775(var_0);
  var_3 = "zm_revive_bar_" + var_2 + "_target";

  foreach (var_5 in level.players) {
  if (var_5 == var_0 || var_5 == var_1)
  continue;

  var_5 setclientomnvar(var_3, var_0);
  }
}

_id_555D(var_0, var_1) {
  var_2 = "zm_revive_bar_" + var_0._id_E4A3 + "_target";
  _id_E029(var_0);

  foreach (var_4 in level.players) {
  if (var_4 == var_0 || var_4 == var_1)
  continue;

  var_4 setclientomnvar(var_2, undefined);
  }
}

_id_F1E6() {
  return isdefined(self._id_F1E5) && self._id_F1E5 > 0;
}

_id_1775(var_0) {
  for (var_1 = 0; var_1 < 2; var_1++) {
  if (!isdefined(level._id_D407[var_1])) {
  level._id_D407[var_1] = var_0;
  var_2 = var_1 + 1;
  var_0._id_E4A3 = var_2;
  return var_2;
  }
  }
}

_id_E029(var_0) {
  for (var_1 = 0; var_1 < 2; var_1++) {
  if (isdefined(level._id_D407[var_1]) && level._id_D407[var_1] == var_0) {
  level._id_D407[var_1] = undefined;
  var_0._id_E4A3 = undefined;
  return;
  }
  }
}

_id_4F33() {
  return 0;
}

_id_8C50() {
  return scripts\engine\utility::_id_9CEE(self._id_8C45);
}

_id_7A71() {
  return self getrankedplayerdata("cp", "alienSession", "last_stand_count");
}

_id_9B79(var_0) {
  return scripts\engine\utility::_id_9CEE(var_0._id_2A85);
}

_id_D0EF(var_0) {
  return var_0._id_98F3;
}

_id_6235(var_0) {
  if (!isdefined(var_0._id_F1E5))
  var_0._id_F1E5 = 0;

  var_0._id_F1E5++;
}

_id_557F(var_0) {
  var_0._id_F1E5--;
}

_id_F1E5(var_0) {
  var_0 scripts\engine\utility::_id_13736(3, "revive_success");
  return 1;
}

give_fists_if_no_real_weapon(var_0) {
  if (has_no_real_weapon(var_0)) {
  self giveweapon("iw7_fists_zm");
  self _meth_83B6("iw7_fists_zm");
  self setspawnweapon("iw7_fists_zm", 1);
  }
}

has_no_real_weapon(var_0) {
  var_1 = var_0 _meth_8173();

  foreach (var_3 in var_1) {
  if (var_3 == "super_default_zm")
  continue;

  if (issubstr(var_3, "knife"))
  continue;

  if (var_3 == "iw7_fists_zm")
  continue;

  return 0;
  }

  return 1;
}