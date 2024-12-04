/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2783.gsc
***************************************/

func_D446() {
  self endon("death");
  self endon("disconnect");
  self endon("player_trophy_unset");

  if(!isdefined(level._effect["pts_detonate"]))
    level._effect["pts_detonate"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp.vfx");

  if(!isdefined(level._effect["pts_drone_drop"]))
    level._effect["pts_drone_drop"] = loadfx("vfx\iw7\_requests\mp\vfx_pts_drone_drop.vfx");

  for (;;) {
    func_D447();
    wait 40;
  }
}

func_D448() {
  self notify("player_trophy_unset");
  func_D441();
}

func_D447() {
  self endon("player_trophy_end");
  self notify("player_trophy_start");
  self endon("player_trophy_start");
  self setclientomnvar("ui_dodge_charges", 5);

  if(self.loadoutarchetype == "archetype_engineer")
    self setscriptablepartstate("pts_drone", "active");

  thread playertrophy_watchemp();
  thread playertrophy_watchownerdeath();
  func_D449();
}

func_D441() {
  self notify("player_trophy_end");
  self setclientomnvar("ui_dodge_charges", 0);

  if(self.loadoutarchetype == "archetype_engineer")
    self setscriptablepartstate("pts_drone", "off");
}

func_D449() {
  var_00 = scripts\mp\trophy_system::func_12804();

  for (;;) {
    var_01 = func_D444();
    var_02 = [];
    var_2[0] = level.grenades;
    var_2[1] = level.missiles;
    var_2[2] = level.mines;
    var_03 = scripts\engine\utility::array_combine_multiple(var_02);

    foreach(var_05 in var_03) {
      if(!isdefined(var_05)) {
        continue;
      }
      if(scripts\mp\utility\game::istrue(var_5.exploding)) {
        continue;
      }
      if(playertrophy_checkignorelist(var_05)) {
        continue;
      }
      var_06 = var_5.owner;

      if(!isdefined(var_06) && isdefined(var_5.weapon_name) && weaponclass(var_5.weapon_name) == "grenade")
        var_06 = getmissileowner(var_05);

      if(isdefined(var_06) && !scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(self, var_5.owner))) {
        continue;
      }
      if(distancesquared(var_5.origin, var_01) > scripts\mp\trophy_system::trophy_modifiedprotectiondistsqr(var_05, 65536)) {
        continue;
      }
      var_07 = physics_raycast(var_01, var_5.origin, var_00, [self, var_05], 0, "physicsquery_closest");

      if(isdefined(var_07) && var_7.size > 0) {
        continue;
      }
      thread func_D445(var_05);
      thread func_D441();
    }

    scripts\engine\utility::waitframe();
  }
}

func_D445(var_00) {
  scripts\mp\missions::func_D991("ch_trait_personal_trophy");
  scripts\mp\killstreaks\killstreaks::givescorefortrophyblocks();
  var_00 setcandamage(0);
  var_0.exploding = 1;
  var_00 stopsounds();
  scripts\mp\trophy_system::func_12821(var_00);
  scripts\mp\trophy_system::func_12817(var_00, "player_trophy_system_mp", self);
  var_01 = var_0.origin;
  var_02 = var_0.angles;

  if(scripts\mp\weapons::isplantedequipment(var_00))
    var_00 scripts\mp\weapons::deleteexplosive();
  else if(var_00 scripts\mp\domeshield::isdomeshield())
    var_00 thread scripts\mp\domeshield::domeshield_delete();
  else
    var_00 delete();

  radiusdamage(var_01, 128, 70, 10, self, "MOD_EXPLOSIVE", "player_trophy_system_mp");
  thread playertrophy_protectionfx(var_01, var_02);
}

playertrophy_watchemp() {
  self endon("death");
  self endon("disconnect");
  self endon("player_trophy_end");

  while (!scripts\mp\killstreaks\emp_common::isemped())
    scripts\engine\utility::waitframe();

  thread func_D441();
}

playertrophy_watchownerdeath() {
  self endon("player_trophy_end");
  self waittill("death");
  playfx(scripts\engine\utility::getfx("pts_drone_drop"), self gettagorigin("tag_shield_back"));
  thread func_D441();
}

func_D444() {
  var_00 = scripts\mp\utility\game::isinarbitraryup();
  var_01 = scripts\engine\utility::ter_op(var_00, self gettagorigin("tag_shield_back", 1, 1), self gettagorigin("tag_shield_back"));
  var_02 = scripts\engine\utility::ter_op(var_00, self getworldupreferenceangles(), self.angles);
  return var_01 + anglestoup(var_02) * 20;
}

playertrophy_checkignorelist(var_00) {
  var_01 = scripts\mp\trophy_system::trophy_checkignorelist(var_00);

  if(isdefined(var_0.weapon_name) && (issubstr(var_0.weapon_name, "iw7_tacburst") || issubstr(var_0.weapon_name, "power_smoke_drone_mp")))
    var_01 = 1;

  if(!var_01 && isdefined(var_0.weapon_name)) {
    var_02 = scripts\mp\utility\game::getequipmenttype(var_0.weapon_name);

    if(isdefined(var_02) && var_02 != "lethal")
      var_01 = 1;
  }

  if(!var_01 && scripts\mp\weapons::isplantedequipment(var_00))
    var_01 = 1;

  return var_01;
}

playertrophy_modifieddamage(var_00, var_01, var_02, var_03, var_04) {
  if(!isdefined(var_02) || var_02 != "player_trophy_system_mp")
    return var_04;

  if(!isdefined(var_00) || !isdefined(var_01))
    return var_04;

  return scripts\engine\utility::ter_op(var_00 == var_01, 0, var_04);
}

playertrophy_protectionfx(var_00, var_01) {
  self playsound("trophy_detect_projectile");
  playfx(scripts\engine\utility::getfx("pts_detonate"), var_00, anglestoforward(var_01), anglestoup(var_01));
  playloopsound(var_00, "trophy_fire");
}