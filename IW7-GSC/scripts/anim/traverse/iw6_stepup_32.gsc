/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\iw6_stepup_32.gsc
***************************************************/

main() {
  func_B0CC();
}

func_B0CC() {
  var_00 = [];
  var_00["traverseAnim"] = func_7814();
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_00);
    return;
  }

  self waittill("killanimscript");
}

func_7814() {
  return % flood_traverse_stepup_32_v1;
}