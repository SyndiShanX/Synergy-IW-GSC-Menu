/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\missilelauncher.gsc
******************************************/

func_98D5() {
  self.var_10FA9 = undefined;
  self.var_10FAA = undefined;
  self.var_10FA6 = undefined;
  self.var_10FA7 = undefined;
  thread func_E273();
  level.var_10FAB = [];
}

resetmissilelauncherlocking() {
  if(!isdefined(self.var_10FAE)) {
    return;
  }

  self.var_10FAE = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("stinger_lock_lost");
  self weaponlockfree();
  self stoplocalsound("maaws_reticle_tracking");
  self stoplocalsound("maaws_reticle_locked");
  func_E12E(self.var_10FAA);
  func_98D5();
}

func_E273() {
  self endon("disconnect");
  self notify("ResetStingerLockingOnDeath");
  self endon("ResetStingerLockingOnDeath");
  for (;;) {
    self waittill("death");
    resetmissilelauncherlocking();
  }
}

func_B06A() {
  self endon("stop_javelin_locking_feedback");
  for (;;) {
    if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && isdefined(self.var_10FAA) && self.var_10FAA == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isdefined(level.ac130player) && isdefined(self.var_10FAA) && self.var_10FAA == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playrumbleonentity("ac130_25mm_fire");
    wait(0.6);
  }
}

func_B069() {
  self endon("stop_javelin_locked_feedback");
  for (;;) {
    if(isdefined(level.chopper) && isdefined(level.chopper.gunner) && isdefined(self.var_10FAA) && self.var_10FAA == level.chopper.gunner) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    if(isdefined(level.ac130player) && isdefined(self.var_10FAA) && self.var_10FAA == level.ac130.planemodel) {
      level.ac130player playlocalsound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_locked");
    self playrumbleonentity("ac130_25mm_fire");
    wait(0.25);
  }
}

softsighttest(param_00) {
  var_01 = 500;
  if(param_00 stingtargstruct_isinlos()) {
    self.var_10FA7 = 0;
    return 1;
  }

  if(self.var_10FA7 == 0) {
    self.var_10FA7 = gettime();
  }

  var_02 = gettime() - self.var_10FA7;
  if(var_02 >= var_01) {
    resetmissilelauncherlocking();
    return 0;
  }

  return 1;
}

func_10FAD() {
  if(!isplayer(self)) {
    return;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  func_98D5();
  for (;;) {
    wait(0.05);
    if(self getweaponrankinfominxp() < 0.95) {
      resetmissilelauncherlocking();
      continue;
    }

    var_00 = scripts\mp\utility::getweaponbasedsmokegrenadecount(self getcurrentweapon());
    if(var_00 != "iw7_lockon_mp") {
      resetmissilelauncherlocking();
      continue;
    }

    self.var_10FAE = 1;
    if(!isdefined(self.var_10FA9)) {
      self.var_10FA9 = 0;
    }

    if(self.var_10FA9 == 0) {
      var_01 = scripts\mp\weapons::func_AF2B(0);
      if(var_01.size == 0) {
        continue;
      }

      var_01 = sortbydistance(var_01, self.origin);
      var_02 = undefined;
      var_03 = 0;
      foreach(var_05 in var_01) {
        if(!isdefined(var_05)) {
          continue;
        }

        var_02 = stingtargstruct_create(self, var_05);
        var_02 stingtargstruct_getoffsets();
        var_02 stingtargstruct_getorigins();
        var_02 stingtargstruct_getinreticle();
        if(var_02 stingtargstruct_isinreticle()) {
          var_03 = 1;
          break;
        }
      }

      if(!var_03) {
        continue;
      }

      var_02 stingtargstruct_getinlos();
      if(!var_02 stingtargstruct_isinlos()) {
        continue;
      }

      self.var_10FAA = var_02.target;
      self.var_10FA6 = gettime();
      self.var_10FA9 = 1;
      self.var_10FA7 = 0;
      func_17D0(self.var_10FAA);
      thread func_B06A();
    }

    if(self.var_10FA9 == 1) {
      if(!isdefined(self.var_10FAA)) {
        resetmissilelauncherlocking();
        continue;
      }

      var_02 = stingtargstruct_create(self, self.var_10FAA);
      var_02 stingtargstruct_getoffsets();
      var_02 stingtargstruct_getorigins();
      var_02 stingtargstruct_getinreticle();
      if(!var_02 stingtargstruct_isinreticle()) {
        resetmissilelauncherlocking();
        continue;
      }

      var_02 stingtargstruct_getinlos();
      if(!softsighttest(var_02)) {
        continue;
      }

      var_07 = gettime() - self.var_10FA6;
      if(scripts\mp\utility::_hasperk("specialty_fasterlockon")) {
        if(var_07 < 375) {
          continue;
        }
      } else if(var_07 < 750) {
        continue;
      }

      self notify("stop_javelin_locking_feedback");
      thread func_B069();
      var_08 = undefined;
      stinger_finalizelock(var_02);
      self.var_10FA9 = 2;
    }

    if(self.var_10FA9 == 2) {
      if(!isdefined(self.var_10FAA)) {
        resetmissilelauncherlocking();
        continue;
      }

      var_02 = stingtargstruct_create(self, self.var_10FAA);
      var_02 stingtargstruct_getoffsets();
      var_02 stingtargstruct_getorigins();
      var_02 stingtargstruct_getinreticle();
      var_02 stingtargstruct_getinlos();
      if(!softsighttest(var_02)) {
        continue;
      } else {
        stinger_finalizelock(var_02);
      }

      if(!var_02 stingtargstruct_isinreticle()) {
        resetmissilelauncherlocking();
        continue;
      }
    }
  }
}

stinger_finalizelock(param_00) {
  var_01 = undefined;
  if(isdefined(param_00.inlosid)) {
    var_01 = param_00.offsets[param_00.inlosid];
    var_01 = (var_01[1], -1 * var_01[0], var_01[2]);
  } else {
    var_01 = (0, 0, 0);
  }

  self _meth_8402(self.var_10FAA, var_01);
}

func_17D0(param_00) {
  if(!isdefined(param_00)) {
    return;
  }

  var_01 = param_00;
  if(isdefined(param_00.triggerportableradarping) && !scripts\mp\utility::func_9EF0(param_00)) {
    var_01 = param_00.triggerportableradarping;
  }

  var_01 setclientomnvar("ui_killstreak_missile_warn", 1);
}

func_E12E(param_00) {
  if(!isdefined(param_00)) {
    return;
  }

  var_01 = param_00;
  if(isdefined(param_00.triggerportableradarping) && !scripts\mp\utility::func_9EF0(param_00)) {
    var_01 = param_00.triggerportableradarping;
  }

  var_01 setclientomnvar("ui_killstreak_missile_warn", 0);
}

stingtargstruct_create(param_00, param_01) {
  var_02 = spawnstruct();
  var_02.player = param_00;
  var_02.target = param_01;
  var_02.offsets = [];
  var_02.origins = [];
  var_02.inreticledistssqr = [];
  var_02.inreticlesortedids = [];
  var_02.inlosid = undefined;
  var_02.useoldlosverification = 1;
  return var_02;
}

stingtargstruct_getoffsets() {
  self.offsets = [];
  if(scripts\mp\utility::isjackal(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 125);
    self.offsets[self.offsets.size] = (0, 250, 125);
    self.offsets[self.offsets.size] = (0, -425, 125);
    self.offsets[self.offsets.size] = (-250, -215, 140);
    self.offsets[self.offsets.size] = (250, -215, 140);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::func_9F8C(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 30);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::ismicroturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 15);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  if(scripts\mp\utility::func_9F22(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 70);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

stingtargstruct_getorigins() {
  var_00 = self.target.origin;
  var_01 = self.target.angles;
  var_02 = anglestoforward(var_01);
  var_03 = anglestoright(var_01);
  var_04 = anglestoup(var_01);
  for (var_05 = 0; var_05 < self.offsets.size; var_05++) {
    var_06 = self.offsets[var_05];
    self.origins[var_05] = var_00 + var_03 * var_06[0] + var_02 * var_06[1] + var_04 * var_06[2];
  }
}

stingtargstruct_getinreticle() {
  foreach(var_01 in self.origins) {
    for (var_02 = 0; var_02 < self.origins.size; var_02++) {
      var_03 = self.player _meth_840B(self.origins[var_02], 65);
      if(isdefined(var_03)) {
        var_04 = length2dsquared(var_03);
        if(var_04 <= 7225) {
          self.inreticlesortedids[self.inreticlesortedids.size] = var_02;
          self.inreticledistssqr[var_02] = var_04;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for (var_02 = 0; var_02 < self.inreticlesortedids.size; var_02++) {
      for (var_06 = var_02 + 1; var_06 < self.inreticlesortedids.size; var_06++) {
        var_07 = self.inreticlesortedids[var_02];
        var_08 = self.inreticlesortedids[var_06];
        var_09 = self.inreticledistssqr[var_07];
        var_0A = self.inreticledistssqr[var_08];
        if(var_0A < var_09) {
          var_0B = var_07;
          self.inreticlesortedids[var_02] = var_08;
          self.inreticlesortedids[var_06] = var_0B;
        }
      }
    }
  }
}

stingtargstruct_getinlos() {
  var_00 = self.player geteye();
  var_01 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_sky", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  var_02 = [self.player, self.target];
  var_03 = self.target getlinkedchildren();
  if(isdefined(var_03) && var_03.size > 0) {
    var_02 = scripts\engine\utility::array_combine(var_02, var_03);
  }

  if(!self.useoldlosverification) {
    for (var_04 = 0; var_04 < self.inreticlesortedids.size; var_04++) {
      var_05 = self.inreticlesortedids[var_04];
      var_06 = self.origins[var_05];
      var_07 = physics_raycast(var_00, var_06, var_01, var_02, 0, "physicsquery_closest", 1);
      if(!isdefined(var_07) || var_07.size == 0) {
        self.inlosid = var_05;
        return;
      }
    }

    return;
  }

  var_08 = scripts\common\trace::ray_trace(var_00, self.origins[0], var_02, var_01, 0);
  if(var_08["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_09 = self.target getpointinbounds(1, 0, 0);
  var_08 = scripts\common\trace::ray_trace(var_00, var_09, var_02, var_01, 0);
  if(var_08["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  var_0A = self.target getpointinbounds(-1, 0, 0);
  var_08 = scripts\common\trace::ray_trace(var_00, var_0A, var_02, var_01, 0);
  if(var_08["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }
}

stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

stingtargstruct_isinlos() {
  return isdefined(self.inlosid);
}