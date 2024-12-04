/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2874.gsc
***************************************/

global_fx(var_00, var_01, var_02, var_03, var_04) {
  init();
  level.global_fx[var_00] = var_03;
  var_05 = scripts\sp\utility::_meth_8181(var_00, "targetname");

  if(!isdefined(var_05)) {
    return;
  }
  if(!var_5.size) {
    return;
  }
  if(!isdefined(var_03))
    var_03 = var_01;

  if(!isdefined(var_02))
    var_02 = randomfloatrange(-20, -15);

  foreach(var_07 in var_05) {
    if(!isdefined(level._effect[var_03]))
      level._effect[var_03] = loadfx(var_01);

    if(!isdefined(var_7.angles))
      var_7.angles = (0, 0, 0);

    var_08 = scripts\engine\utility::createoneshoteffect(var_03);
    var_8.v["origin"] = var_7.origin;
    var_8.v["angles"] = var_7.angles;
    var_8.v["fxid"] = var_03;
    var_8.v["delay"] = var_02;

    if(isdefined(var_04))
      var_8.v["soundalias"] = var_04;

    if(!isdefined(var_7.script_noteworthy)) {
      continue;
    }
    var_09 = var_7.script_noteworthy;

    if(!isdefined(level.func_12C7[var_09]))
      level.func_12C7[var_09] = [];

    level.func_12C7[var_09][level.func_12C7[var_09].size] = var_08;
  }
}

init() {
  if(!scripts\engine\utility::add_init_script("global_FX", ::init)) {
    return;
  }
  if(!isdefined(level._effect))
    level._effect = [];

  if(!isdefined(level.global_fx))
    level.global_fx = [];

  level.func_12C7 = [];
}