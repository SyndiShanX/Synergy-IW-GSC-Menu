/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2781.gsc
***************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_00);

    if(!isai(var_00)) {
      var_0.playercardpatch = var_00 getrankedplayerdata(level.loadoutsgroup, "squadMembers", "patch");
      var_0.playercardpatchbacking = var_00 getrankedplayerdata(level.loadoutsgroup, "squadMembers", "patchbacking");
      var_0.playercardbackground = var_00 getrankedplayerdata(level.loadoutsgroup, "squadMembers", "background");
    }
  }
}