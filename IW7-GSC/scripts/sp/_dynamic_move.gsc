/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\_dynamic_move.gsc
****************************************/

func_5F84(param_00) {
  self notify("disable_dynamic_move");
  self endon("disable_dynamic_move");
  if(isdefined(self.var_5F76)) {
    var_01 = squared(self.var_5F76);
  } else if(isdefined(var_01)) {
    var_01 = squared(var_01);
  } else {
    var_01 = squared(300);
  }

  self.var_51E4 = undefined;
  scripts\sp\_utility::func_4145();
  func_F491("sprint_loop", "sprint_super");
  for (;;) {
    var_02 = vectornormalize(level.player.origin - self.origin);
    var_03 = anglestoforward(self.angles);
    var_04 = vectordot(var_03, var_02);
    var_05 = distance2dsquared(level.player.origin, self.origin);
    if(var_04 < 0) {
      if(var_05 > var_01) {
        if(!isdefined(self.demeanoroverride) || isdefined(self.demeanoroverride) && self.demeanoroverride == "sprint") {
          scripts\sp\_utility::func_4145();
          if(isdefined(self.var_51E4)) {
            scripts\sp\_utility::func_51E1(self.var_51E4);
          }
        }
      } else if(!isdefined(self.demeanoroverride) || isdefined(self.demeanoroverride) && self.demeanoroverride != "sprint") {
        self.var_51E4 = self.demeanoroverride;
        scripts\sp\_utility::func_51E1("sprint");
      }
    } else if(!isdefined(self.demeanoroverride) || isdefined(self.demeanoroverride) && self.demeanoroverride != "sprint") {
      self.var_51E4 = self.demeanoroverride;
      scripts\sp\_utility::func_51E1("sprint");
    }

    wait(0.05);
  }
}

func_5557() {
  self notify("disable_dynamic_move");
  if(isdefined(self.var_51E4)) {
    scripts\sp\_utility::func_51E1(self.var_51E4);
  } else {
    scripts\sp\_utility::func_4145();
  }

  self.var_51E4 = undefined;
  scripts\sp\_utility::func_4169("sprint");
}

func_F491(param_00, param_01) {
  if(!scripts\asm\asm::asm_hasalias(param_00, param_01)) {
    return;
  }

  var_02 = scripts\asm\asm::asm_lookupanimfromalias(param_00, param_01);
  scripts\asm\asm::asm_setdemeanoranimoverride("sprint", "move", var_02);
}