/****************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\traverse\jump_across_72.gsc
****************************************************/

main() {
  if(self.type == "dog") {
    scripts\anim\traverse\shared::func_5869("wallhop", 20);
    return;
  }

  self.var_5270 = "stand";
  scripts\anim\utility::func_12E5F();
  self endon("killanimscript");
  self _meth_83C4("nogravity");
  self _meth_83C4("noclip");
  var_00 = self getspectatepoint();
  self orientmode("face angle", var_00.angles[1]);
  self _meth_82E4("jumpanim", % jump_across_72, % body, 1, 0.1, 1);
  self waittillmatch("gravity on", "jumpanim");
  self _meth_83C4("gravity");
  scripts\anim\shared::donotetracks("jumpanim");
}