/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\c6\c6_agent.gsc
*********************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  lib_03A9::func_DEE8();
  lib_0F37::func_2371();
  if(level.gametype != "zombie") {
    lib_09FD::func_3353();
  }

  func_9812();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isdefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  if(!isdefined(level.species_funcs)) {
    level.species_funcs = [];
  }

  level.species_funcs["c6"] = [];
  level.agent_definition["c6"]["setup_func"] = ::setupagent;
}

setupagent() {
  self.accuracy = 0.5;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 360;
  self.desiredenemydistmin = 340;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.backawayenemydist = self.desiredenemydistmin - 100;
  self.fastcrawlanimscale = 12;
  self.forcefastcrawldist = 340;
  self.fastcrawlmaxhealth = 40;
  self.dismemberchargeexplodedistsq = 2500;
  self.explosionradius = 75;
  self.explosiondamagemin = 30;
  self.explosiondamagemax = 50;
  self.meleerangesq = 9216;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 250;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 30;
  self.meleemaxdamage = 45;
  self.footstepdetectdist = 600;
  self.footstepdetectdistwalk = 600;
  self.footstepdetectdistsprint = 600;
  self.var_1A44 = 50;
  func_FAFE();
  thread scriptedgoalwaitforarrival();
  thread func_899D();
}

func_FAFE() {
  self.var_3402 = ::func_11562;
  self.var_3404 = [::func_11562, ::func_11559, ::func_1156F, ::func_1157B, ::func_11570];
  self.var_3403 = [15, 40, 17, 17, 11];
}

func_899D() {
  self endon("death");
  for (;;) {
    self waittill("enemy");
    for (;;) {
      if(isdefined(self.isnodeoccupied)) {
        self.var_6571 = gettime() + 1000;
      } else if(isdefined(self.var_6571)) {
        if(gettime() > self.var_6571) {
          self.var_6571 = undefined;
          break;
        }
      }

      wait(0.25);
    }
  }
}

func_11570() {
  var_00 = 70;
  var_01 = 15;
  if(isdefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.25, 0.35);
  var_03 = var_01 * 0.5;
  var_04 = var_03 * -1;
  var_05 = randomfloatrange(var_04, var_03);
  var_06 = anglestoright(self.angles);
  var_07 = (var_06[0] * var_05, var_06[1] * var_05, var_02);
  var_08 = self.isnodeoccupied.origin + var_07;
  return var_08;
}

func_1157B() {
  var_00 = 70;
  var_01 = 15;
  if(isdefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * 0.75;
  var_04 = anglestoright(self.angles);
  var_05 = (var_04[0] * var_03, var_04[1] * var_03, var_02);
  var_06 = self.isnodeoccupied.origin + var_05;
  return var_06;
}

func_1156F() {
  var_00 = 70;
  var_01 = 15;
  if(isdefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * -0.75;
  var_04 = anglestoright(self.angles);
  var_05 = (var_04[0] * var_03, var_04[1] * var_03, var_02);
  var_06 = self.isnodeoccupied.origin + var_05;
  return var_06;
}

func_11559() {
  var_00 = 70;
  var_01 = 15;
  if(isdefined(self.isnodeoccupied.var_18F4)) {
    var_00 = self.isnodeoccupied.var_18F4;
    var_01 = self.isnodeoccupied.var_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * 0.5;
  var_04 = var_03 * -1;
  var_05 = randomfloatrange(var_04, var_03);
  var_06 = anglestoright(self.angles);
  var_07 = (var_06[0] * var_05, var_06[1] * var_05, var_02);
  var_08 = self.isnodeoccupied.origin + var_07;
  return var_08;
}

func_11562() {
  var_00 = self.isnodeoccupied gettagorigin("j_head");
  return var_00;
}

func_2475() {
  if(isdefined(self.var_2AB4) && self.var_2AB4 == 0) {
    return;
  }

  self.voice = "american";
  self give_explosive_touch_on_revived("cloth");
  self attach("robot_c6_armor");
  var_00 = [];
  var_00["tag_armor_head_ri"] = 165;
  var_00["tag_armor_head_le"] = 165;
  var_00["tag_armor_head_front"] = 165;
  var_00["tag_armor_forearm_le"] = 120;
  var_00["tag_armor_bicep_le"] = 120;
  var_00["tag_armor_forearm_ri"] = 120;
  var_00["tag_armor_bicep_ri"] = 120;
  var_00["tag_armor_chest_upper_le"] = 165;
  var_00["tag_armor_chest_upper_ri"] = 165;
  var_00["tag_armor_back_upper"] = 165;
  var_00["tag_armor_chest_stomach"] = 165;
  var_00["tag_armor_back_lower"] = 165;
  var_00["tag_armor_leg_thigh_front_le"] = 120;
  var_00["tag_armor_leg_thigh_back_le"] = 120;
  var_00["tag_armor_leg_thigh_front_ri"] = 120;
  var_00["tag_armor_leg_thigh_back_ri"] = 120;
  var_00["tag_armor_kneepad_behind_le"] = 50;
  var_00["tag_armor_kneepad_down_le"] = 50;
  var_00["tag_armor_kneepad_upper_le"] = 50;
  var_00["tag_armor_kneepad_behind_ri"] = 50;
  var_00["tag_armor_kneepad_down_ri"] = 50;
  var_00["tag_armor_kneepad_upper_ri"] = 50;
  self.var_2AB4 = 1;
}

setupdestructibleparts() {
  self.var_2AB5 = 1;
}

func_17CC(param_00, param_01) {
  if(!isdefined(level.var_85DF)) {
    anim.var_85DF = [];
    anim.var_85E1 = [];
  }

  var_02 = level.var_85DF.size;
  level.var_85DF[var_02] = param_00;
  level.var_85E1[var_02] = param_01;
}

func_9812() {
  func_17CC(0, (41.5391, 7.28883, 72.2128));
  func_17CC(1, (34.8849, -4.77048, 74.0488));
}

scriptedgoalwaitforarrival() {
  self endon("death");
  for (;;) {
    self waittill("goal_reached");
    if(isdefined(self.var_EF7D)) {
      var_00 = self.var_EF7D;
    } else if(isdefined(self.var_EF7A)) {
      var_00 = self.var_EF7A.origin;
    } else if(isdefined(self.var_EF7C)) {
      var_00 = self.var_EF7C.origin;
    } else {
      continue;
    }

    var_01 = 16;
    if(isdefined(self.var_EF7E)) {
      var_01 = self.var_EF7E * self.var_EF7E;
    }

    if(distance2dsquared(self.origin, var_00) <= var_01) {
      self.var_EF7D = undefined;
      self.var_EF7C = undefined;
      if(!isdefined(self.var_EF7B)) {
        self.var_EF7A = undefined;
      }

      self notify("scriptedGoal_reached");
    }
  }
}

func_F834(param_00, param_01) {
  if(!isdefined(param_01)) {
    param_01 = 0;
  }

  self.var_EF79 = param_01;
  self.var_EF73 = param_00;
}

func_F835(param_00, param_01) {
  self.var_EF7A = undefined;
  self.var_EF7B = undefined;
  self.var_EF7C = undefined;
  self.var_EF7D = param_00;
  self.var_EF7E = param_01;
}

func_F833(param_00, param_01) {
  self.var_EF7D = undefined;
  self.var_EF7A = undefined;
  self.var_EF7B = undefined;
  self.var_EF7C = param_00;
  self.var_EF7E = param_01;
}

func_F832(param_00, param_01, param_02) {
  self.var_EF7D = undefined;
  self.var_EF7C = undefined;
  self.var_EF7A = param_00;
  self.var_EF7E = param_01;
  if(isdefined(param_02) && param_02) {
    self.var_EF7B = param_02;
    return;
  }

  self.var_EF7B = undefined;
}

func_41D9() {
  if(isdefined(self.var_EF7D) || isdefined(self.var_EF7A) || isdefined(self.var_EF7C)) {
    self.var_EF7D = undefined;
    self.var_EF7A = undefined;
    self.var_EF7B = undefined;
    self.var_EF7C = undefined;
    self clearpath();
  }
}