/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\3524.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("team_ammo_refill", ::_id_12908);
}

_id_12908(var_0) {
  var_1 = _id_83AD();

  if (var_1)
  scripts\mp\matchdata::_id_AFC9("team_ammo_refill", self.origin);

  return var_1;
}

_id_83AD() {
  if (level.teambased) {
  foreach (var_1 in level.players) {
  if (var_1.team == self.team)
  var_1 _id_DE4B(1);
  }
  }
  else
  _id_DE4B(1);

  level thread scripts\mp\utility\game::_id_115DE("used_team_ammo_refill", self);
  return 1;
}

_id_DE4B(var_0) {
  var_1 = self _meth_8173();

  if (var_0) {}

  foreach (var_3 in var_1) {
  if (issubstr(var_3, "grenade") || getsubstr(var_3, 0, 2) == "gl") {
  if (!var_0 || self getammocount(var_3) >= 1)
  continue;
  }

  self givemaxammo(var_3);
  }

  self playlocalsound("ammo_crate_use");
}