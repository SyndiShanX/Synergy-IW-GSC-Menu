/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc3\bt_action_api.gsc
**************************************************/

setupbtaction(param_00, param_01, param_02, param_03) {
  var_04 = spawnstruct();
  var_04.fnbegin = param_01;
  var_04.fntick = param_02;
  var_04.fnend = param_03;
  if(!isdefined(self.actions)) {
    self.actions = [];
  }

  self.actions[param_00] = var_04;
}

setdesiredaction(param_00, param_01) {
  if(isdefined(param_01) && !isdefined(self.actions[param_01])) {
    return 0;
  }

  var_02 = getcurrentdesiredaction(param_00);
  self.desiredaction = param_01;
  if(isdefined(var_02) && var_02 != param_01) {
    self notify("newaction");
  }

  return 1;
}

getcurrentdesiredaction(param_00) {
  if(!isdefined(self.var_3135.instancedata[param_00])) {
    return undefined;
  }

  return self.var_3135.instancedata[param_00].currentaction;
}

doaction_begin(param_00) {
  self.var_3135.instancedata[param_00] = spawnstruct();
  self.var_3135.instancedata[param_00].currentaction = self.desiredaction;
  var_01 = self.actions[self.desiredaction].fnbegin;
  self.desiredaction = undefined;
  if(isdefined(var_01)) {
    [
      [var_01]
    ](param_00);
  }
}

doaction_tick(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  var_02 = self.actions[var_01].fntick;
  if(isdefined(var_02)) {
    var_03 = [
      [var_02]
    ](param_00);
    if(!isdefined(self.desiredaction)) {
      if(isdefined(var_03)) {
        return var_03;
      }

      return level.failure;
    }
  }

  if(isdefined(self.desiredaction)) {
    doaction_end(param_00);
    doaction_begin(param_00);
    return level.running;
  }

  return level.failure;
}

doaction_end(param_00) {
  var_01 = getcurrentdesiredaction(param_00);
  var_02 = self.actions[var_01].fnend;
  if(isdefined(var_02)) {
    [
      [var_02]
    ](param_00);
  }

  scripts\aitypes\dlc3\bt_state_api::btstate_endstates(param_00);
  self.var_3135.instancedata[param_00] = undefined;
}