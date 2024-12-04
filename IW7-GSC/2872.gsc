/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2872.gsc
************************/

func_9606() {
  scripts\engine\utility::array_thread(getentarray("window_poster", "targetname"), ::func_13D55);
}

func_13D55() {
  var_00 = getglass(self.target);
  if(!isdefined(var_00)) {
    return;
  }

  level waittillmatch(var_00, "glass_destroyed");
  self delete();
}