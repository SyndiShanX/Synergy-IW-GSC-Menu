/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3951.gsc
***************************************/

registerscriptedagent() {
  scripts\aitypes\bt_util::init();
  func_03A9::func_DEE8();
  func_0F37::func_2371();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");

  if(!isdefined(level.agent_definition))
    level waittill("scripted_agents_initialized");

  if(!isdefined(level.species_funcs))
    level.species_funcs = [];

  level.species_funcs["the_hoff"] = [];
  level.agent_definition["the_hoff"]["setup_func"] = ::setupagent;
  level.agent_definition["the_hoff"]["setup_model_func"] = ::func_FACE;
}

setupagent() {
  self.accuracy = 0.5;
  self.noattackeraccuracymod = 0;
  self.sharpturnnotifydist = 48;
  self.last_enemy_sight_time = 0;
  self.desiredenemydistmax = 500;
  self.desiredenemydistmin = 400;
  self.maxtimetostrafewithoutlos = 3000;
  self.strafeifwithindist = self.desiredenemydistmax + 100;
  self.maxsightdistsqrd = 67108864;
  self.backawayenemydist = self.desiredenemydistmin - 100;
  self.meleerangesq = 9216;
  self.meleechargedist = 45;
  self.meleechargedistvsplayer = 45;
  self.meleechargedistreloadmultiplier = 1.2;
  self.maxzdiff = 50;
  self.meleeactorboundsradius = 32;
  self.meleemindamage = 300;
  self.meleemaxdamage = 450;
  self.footstepdetectdist = 1000;
  self.footstepdetectdistwalk = 1000;
  self.footstepdetectdistsprint = 1000;
  self.func_1A44 = 50;
  func_FAFE();
  thread scriptedgoalwaitforarrival();
  thread func_899D();
}

func_FAFE() {
  self.func_3402 = ::func_11562;
  self.func_3404 = [::func_11562, ::func_11559, ::func_1156F, ::func_1157B, ::func_11570];
  self.func_3403 = [0, 47, 21, 21, 11];
}

func_899D() {
  self endon("death");

  for (;;) {
    self waittill("enemy");

    for (;;) {
      if(isdefined(self.enemy))
        self.func_6571 = gettime() + 1000;
      else if(isdefined(self.func_6571)) {
        if(gettime() > self.func_6571) {
          self.func_6571 = undefined;
          break;
        }
      }

      wait 0.25;
    }
  }
}

func_11570() {
  var_00 = 70;
  var_01 = 15;

  if(isdefined(self.enemy.func_18F4)) {
    var_00 = self.enemy.func_18F4;
    var_01 = self.enemy.func_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.25, 0.35);
  var_03 = var_01 * 0.5;
  var_04 = var_03 * -1;
  var_05 = randomfloatrange(var_04, var_03);
  var_06 = anglestoright(self.angles);
  var_07 = (var_6[0] * var_05, var_6[1] * var_05, var_02);
  var_08 = self.enemy.origin + var_07;
  return var_08;
}

func_1157B() {
  var_00 = 70;
  var_01 = 15;

  if(isdefined(self.enemy.func_18F4)) {
    var_00 = self.enemy.func_18F4;
    var_01 = self.enemy.func_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * 0.75;
  var_04 = anglestoright(self.angles);
  var_05 = (var_4[0] * var_03, var_4[1] * var_03, var_02);
  var_06 = self.enemy.origin + var_05;
  return var_06;
}

func_1156F() {
  var_00 = 70;
  var_01 = 15;

  if(isdefined(self.enemy.func_18F4)) {
    var_00 = self.enemy.func_18F4;
    var_01 = self.enemy.func_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * -0.75;
  var_04 = anglestoright(self.angles);
  var_05 = (var_4[0] * var_03, var_4[1] * var_03, var_02);
  var_06 = self.enemy.origin + var_05;
  return var_06;
}

func_11559() {
  var_00 = 70;
  var_01 = 15;

  if(isdefined(self.enemy.func_18F4)) {
    var_00 = self.enemy.func_18F4;
    var_01 = self.enemy.func_18F9;
  }

  var_02 = var_00 * randomfloatrange(0.65, 0.75);
  var_03 = var_01 * 0.5;
  var_04 = var_03 * -1;
  var_05 = randomfloatrange(var_04, var_03);
  var_06 = anglestoright(self.angles);
  var_07 = (var_6[0] * var_05, var_6[1] * var_05, var_02);
  var_08 = self.enemy.origin + var_07;
  return var_08;
}

func_11562() {
  var_00 = self.enemy gettagorigin("j_head");
  return var_00;
}

scriptedgoalwaitforarrival() {
  self endon("death");

  for (;;) {
    self waittill("goal_reached");

    if(isdefined(self.func_EF7D))
      var_00 = self.func_EF7D;
    else if(isdefined(self.func_EF7A))
      var_00 = self.func_EF7A.origin;
    else if(isdefined(self.func_EF7C))
      var_00 = self.func_EF7C.origin;
    else
      continue;

    var_01 = 16;

    if(isdefined(self.func_EF7E))
      var_01 = self.func_EF7E * self.func_EF7E;

    if(distance2dsquared(self.origin, var_00) <= var_01) {
      self.func_EF7D = undefined;
      self.func_EF7C = undefined;

      if(!isdefined(self.func_EF7B))
        self.func_EF7A = undefined;

      self notify("scriptedGoal_reached");
    }
  }
}

func_F834(var_00, var_01) {
  if(!isdefined(var_01))
    var_01 = 0;

  self.func_EF79 = var_01;
  self.func_EF73 = var_00;
}

func_F835(var_00, var_01) {
  self.func_EF7A = undefined;
  self.func_EF7B = undefined;
  self.func_EF7C = undefined;
  self.func_EF7D = var_00;
  self.func_EF7E = var_01;
}

func_F833(var_00, var_01) {
  self.func_EF7D = undefined;
  self.func_EF7A = undefined;
  self.func_EF7B = undefined;
  self.func_EF7C = var_00;
  self.func_EF7E = var_01;
}

func_F832(var_00, var_01, var_02) {
  self.func_EF7D = undefined;
  self.func_EF7C = undefined;
  self.func_EF7A = var_00;
  self.func_EF7E = var_01;

  if(isdefined(var_02) && var_02)
    self.func_EF7B = var_02;
  else
    self.func_EF7B = undefined;
}

func_41D9() {
  if(isdefined(self.func_EF7D) || isdefined(self.func_EF7A) || isdefined(self.func_EF7C)) {
    self.func_EF7D = undefined;
    self.func_EF7A = undefined;
    self.func_EF7B = undefined;
    self.func_EF7C = undefined;
    self clearpath();
  }
}

func_FACE(var_00) {
  self setmodel("body_zmb_hero_dj_agent");
}