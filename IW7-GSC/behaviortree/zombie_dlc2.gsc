/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: behaviortree\zombie_dlc2.gsc
****************************************/

zombie_dlc2fn0(param_00) {
  return lib_0A09::func_5AEA(param_00, 200);
}

func_2AD0() {
  if(isdefined(level.var_119E["zombie_dlc2"])) {
    return;
  }

  var_00 = spawnstruct();
  var_00.var_1581 = [];
  var_00.var_1581[0] = ::lib_0C2B::func_98E5;
  var_00.var_1581[1] = ::scripts\aitypes\zombie_dlc2\behaviors::checkscripteddlc2;
  var_00.var_1581[2] = ::lib_0C2B::func_10004;
  var_00.var_1581[3] = ::lib_0C2B::func_6627;
  var_00.var_1581[4] = ::lib_0C2B::func_6628;
  var_00.var_1581[5] = ::lib_0C2B::func_6629;
  var_00.var_1581[6] = ::zombie_dlc2fn0;
  var_00.var_1581[7] = ::lib_0A09::func_FAF6;
  var_00.var_1581[8] = ::lib_0C2B::func_102D4;
  var_00.var_1581[9] = ::lib_0C2B::func_3E4F;
  var_00.var_1581[10] = ::lib_0C2B::func_3E29;
  var_00.var_1581[11] = ::scripts\aitypes\zombie_dlc2\behaviors::chaseenemydlc2;
  var_00.var_1581[12] = ::scripts\aitypes\zombie_dlc2\behaviors::seekenemydlc2;
  var_00.var_1581[13] = ::lib_0C2B::notargetfound;
  level.var_119E["zombie_dlc2"] = var_00;
}

func_DEE8() {
  func_2AD0();
  btregistertree("zombie_dlc2");
}