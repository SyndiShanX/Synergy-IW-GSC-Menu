/*****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\iw6_jumpdown_40.gsc
*****************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5867(7, 0.7);
    return;
  }

  func_91D4();
}

func_91D4() {
  var_00 = [];
  var_00["traverseAnim"] = % traverse_jumpdown_40_iw6;
  if(getdvarint("ai_iw7", 0) == 0) {
    scripts\anim\traverse\shared::func_5AC3(var_00);
    return;
  }

  self waittill("killanimscript");
}