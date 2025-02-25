/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\engine\pipes.gsc
************************************/

main() {
  if(isdefined(level.pipes_init)) {
    return;
  }

  level.pipes_init = 1;
  var_00 = getentarray("pipe_shootable", "targetname");
  if(!var_00.size) {
    return;
  }

  level._pipes = spawnstruct();
  level._pipes.num_pipe_fx = 0;
  var_00 thread precachefx();
  var_00 thread methodsinit();
  thread post_load(var_00);
}

post_load(param_00) {
  waittillframeend;
  if(level.createfx_enabled) {
    return;
  }

  scripts\engine\utility::array_thread(param_00, ::pipesetup);
}

pipesetup() {
  self setcandamage(1);
  self setcanradiusdamage(0);
  self.pipe_fx_array = [];
  var_00 = undefined;
  if(isdefined(self.target)) {
    var_00 = scripts\engine\utility::getstruct(self.target, "targetname");
    self.a = var_00.origin;
    var_01 = anglestoforward(var_00.angles);
    var_01 = var_01 * 128;
    self.b = self.a + var_01;
  } else {
    var_01 = anglestoforward(self.angles);
    var_02 = var_01 * 64;
    self.a = self.origin + var_02;
    var_02 = var_01 * -64;
    self.b = self.origin + var_02;
  }

  thread pipe_wait_loop();
}

pipe_wait_loop() {
  var_00 = (0, 0, 0);
  var_01 = 0;
  var_02 = 4;
  for (;;) {
    self waittill("damage", var_03, var_04, var_05, var_00, var_06);
    if(var_01) {
      if(randomint(100) <= 33) {
        continue;
      }
    }

    var_01 = 1;
    var_07 = pipe_logic(var_05, var_00, var_06, var_04);
    if(var_07) {
      var_02--;
    }

    if(var_02 <= 0) {
      break;
    }
  }

  self setcandamage(0);
}

pipe_logic(param_00, param_01, param_02, param_03) {
  if(level._pipes.num_pipe_fx > 12) {
    return 0;
  }

  if(!isdefined(level._pipes._pipe_methods[param_02])) {
    param_01 = pipe_calc_nofx(param_01, param_02);
  } else {
    param_01 = self[[level._pipes._pipe_methods[param_02]]](param_01, param_02);
  }

  if(!isdefined(param_01)) {
    return 0;
  }

  if(isdefined(param_03.classname) && param_03.classname == "worldspawn") {
    return 0;
  }

  foreach(var_05 in self.pipe_fx_array) {
    if(distancesquared(param_01, var_05.origin) < 25) {
      return 0;
    }
  }

  var_07 = undefined;
  if(isai(param_03)) {
    var_07 = param_03 geteye();
  } else {
    var_07 = param_03.origin;
  }

  var_08 = param_01 - var_07;
  var_09 = bullettrace(var_07, var_07 + 1.5 * var_08, 0, param_03, 0);
  if(isdefined(var_09["normal"]) && isdefined(var_09["entity"]) && var_09["entity"] == self) {
    var_0A = var_09["normal"];
    thread pipefx(param_01, var_0A, param_03);
    return 1;
  }

  return 0;
}

pipefx(param_00, param_01, param_02) {
  var_03 = level._pipes.fx_time[self.script_noteworthy];
  var_04 = level._pipes._pipe_fx_time[self.script_noteworthy];
  var_05 = int(var_04 / var_03);
  var_06 = 30;
  var_07 = "mtl_steam_pipe_hit";
  var_08 = "mtl_steam_pipe_hiss_loop";
  var_09 = "mtl_steam_pipe_hiss_loop_end";
  var_0A = spawn("script_origin", param_00);
  var_0A hide();
  var_0A playsound(var_07);
  var_0A playloopsound(var_08);
  self.pipe_fx_array[self.pipe_fx_array.size] = var_0A;
  if(scripts\engine\utility::issp() || self.script_noteworthy != "steam") {
    thread pipe_damage(param_00, param_01, param_02, var_0A);
  }

  if(self.script_noteworthy == "oil_leak") {
    var_0B = spawn("script_model", param_00);
    var_0B setmodel("tag_origin");
    var_0B.angles = vectortoangles(param_01);
    playfxontag(level._pipes._effect[self.script_noteworthy], var_0B, "tag_origin");
    level._pipes.num_pipe_fx++;
    var_0B rotatepitch(90, var_03, 1, 1);
    wait(var_03);
    stopfxontag(level._pipes._effect[self.script_noteworthy], var_0B, "tag_origin");
    var_05--;
  } else {
    playfx(level._pipes._effect[self.script_noteworthy], param_00, param_01);
    level._pipes.num_pipe_fx++;
    wait(var_03);
    var_05--;
  }

  while (level._pipes.num_pipe_fx <= 12 && var_05 > 0) {
    if(self.script_noteworthy == "oil_leak") {
      var_0B = spawn("script_model", param_00);
      var_0B setmodel("tag_origin");
      var_0B.angles = vectortoangles(param_01);
      playfxontag(level._pipes._effect[self.script_noteworthy], var_0B, "tag_origin");
      level._pipes.num_pipe_fx++;
      var_0B rotatepitch(90, var_03, 1, 1);
      wait(var_03);
      stopfxontag(level._pipes._effect[self.script_noteworthy], var_0B, "tag_origin");
      continue;
    }

    playfx(level._pipes._effect[self.script_noteworthy], param_00, param_01);
    wait(var_03);
    var_05--;
  }

  var_0A playsound(var_09);
  wait(0.5);
  var_0A stoploopsound(var_08);
  var_0A delete();
  self.pipe_fx_array = scripts\engine\utility::array_removeundefined(self.pipe_fx_array);
  level._pipes.num_pipe_fx--;
}

pipe_damage(param_00, param_01, param_02, param_03) {
  if(!allow_pipe_damage()) {
    return;
  }

  param_03 endon("death");
  var_04 = param_03.origin + vectornormalize(param_01) * 40;
  var_05 = level._pipes._dmg[self.script_noteworthy];
  for (;;) {
    if(!isdefined(self.damageowner)) {
      self radiusdamage(var_04, 36, var_05, var_05 * 0.75, undefined, "MOD_TRIGGER_HURT");
    } else {
      self radiusdamage(var_04, 36, var_05, var_05 * 0.75, param_02, "MOD_TRIGGER_HURT");
    }

    wait(0.4);
  }
}

allow_pipe_damage() {
  if(!scripts\engine\utility::issp()) {
    return 0;
  }

  if(!isdefined(level.pipesdamage)) {
    return 1;
  }

  return level.pipesdamage;
}

methodsinit() {
  level._pipes._pipe_methods = [];
  level._pipes._pipe_methods["MOD_UNKNOWN"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PISTOL_BULLET"] = ::pipe_calc_ballistic;
  level._pipes._pipe_methods["MOD_RIFLE_BULLET"] = ::pipe_calc_ballistic;
  level._pipes._pipe_methods["MOD_GRENADE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_GRENADE_SPLASH"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PROJECTILE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_PROJECTILE_SPLASH"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_TRIGGER_HURT"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_EXPLOSIVE"] = ::pipe_calc_splash;
  level._pipes._pipe_methods["MOD_EXPLOSIVE_BULLET"] = ::pipe_calc_splash;
}

pipe_calc_ballistic(param_00, param_01) {
  return param_00;
}

pipe_calc_splash(param_00, param_01) {
  var_02 = vectornormalize(vectorfromlinetopoint(self.a, self.b, param_00));
  param_00 = pointonsegmentnearesttopoint(self.a, self.b, param_00);
  return param_00 + var_02 * 4;
}

pipe_calc_nofx(param_00, param_01) {
  return undefined;
}

precachefx() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  foreach(var_06 in self) {
    if(var_06.script_noteworthy == "water") {
      var_06.script_noteworthy = "steam";
    }

    if(var_06.script_noteworthy == "steam") {
      var_06 willneverchange();
      var_00 = 1;
      continue;
    }

    if(var_06.script_noteworthy == "fire") {
      var_06 willneverchange();
      var_01 = 1;
      continue;
    }

    if(var_06.script_noteworthy == "steam_small") {
      var_06 willneverchange();
      var_02 = 1;
      continue;
    }

    if(var_06.script_noteworthy == "oil_leak") {
      var_06 willneverchange();
      var_03 = 1;
      continue;
    }

    if(var_06.script_noteworthy == "oil_cap") {
      var_06 willneverchange();
      var_04 = 1;
      continue;
    }
  }

  if(var_00) {
    level._pipes._effect["steam"] = loadfx("vfx\core\impacts\pipe_steam");
    level._pipes._sound["steam_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["steam_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["steam_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["steam"] = 3;
    level._pipes._dmg["steam"] = 5;
    level._pipes._pipe_fx_time["steam"] = 25;
  }

  if(var_02) {
    level._pipes._effect["steam_small"] = loadfx("vfx\core\impacts\pipe_steam_small");
    level._pipes._sound["steam_small_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["steam_small_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["steam_small_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["steam_small"] = 3;
    level._pipes._dmg["steam_small"] = 5;
    level._pipes._pipe_fx_time["steam_small"] = 25;
  }

  if(var_01) {
    level._pipes._effect["fire"] = loadfx("vfx\core\impacts\pipe_fire");
    level._pipes._sound["fire_hit"] = "mtl_gas_pipe_hit";
    level._pipes._sound["fire_loop"] = "mtl_gas_pipe_flame_loop";
    level._pipes._sound["fire_end"] = "mtl_gas_pipe_flame_end";
    level._pipes.fx_time["fire"] = 3;
    level._pipes._dmg["fire"] = 5;
    level._pipes._pipe_fx_time["fire"] = 25;
  }

  if(var_03) {
    level._pipes._effect["oil_leak"] = loadfx("vfx\core\impacts\pipe_oil_barrel_spill");
    level._pipes._sound["oil_leak_hit"] = "mtl_oil_barrel_hit";
    level._pipes._sound["oil_leak_loop"] = "mtl_oil_barrel_hiss_loop";
    level._pipes._sound["oil_leak_end"] = "mtl_oil_barrel_hiss_loop_end";
    level._pipes.fx_time["oil_leak"] = 6;
    level._pipes._pipe_fx_time["oil_leak"] = 6;
    level._pipes._dmg["oil_leak"] = 5;
  }

  if(var_04) {
    level._pipes._effect["oil_cap"] = loadfx("vfx\core\impacts\pipe_oil_barrel_squirt");
    level._pipes._sound["oil_cap_hit"] = "mtl_steam_pipe_hit";
    level._pipes._sound["oil_cap_loop"] = "mtl_steam_pipe_hiss_loop";
    level._pipes._sound["oil_cap_end"] = "mtl_steam_pipe_hiss_loop_end";
    level._pipes.fx_time["oil_cap"] = 3;
    level._pipes._dmg["oil_cap"] = 5;
    level._pipes._pipe_fx_time["oil_cap"] = 5;
  }
}