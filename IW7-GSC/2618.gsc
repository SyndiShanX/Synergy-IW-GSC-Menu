/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2618.gsc
***************************************/

setup_individual_exploder(var_00) {
  var_01 = var_0.targetname;

  if(!isdefined(level.exploders[var_01]))
    level.exploders[var_01] = [];

  var_02 = var_0.targetname;

  if(!isdefined(var_02))
    var_02 = "";

  level.exploders[var_01][level.exploders[var_01].size] = var_00;

  if(exploder_model_starts_hidden(var_00)) {
    var_00 hide();
    return;
  }

  if(exploder_model_is_damaged_model(var_00)) {
    var_00 hide();
    var_00 notsolid();

    if(isdefined(var_0.spawnflags) && var_0.spawnflags & 1) {
      if(isdefined(var_0.script_disconnectpaths))
        var_00 connectpaths();
    }

    return;
  }

  if(exploder_model_is_chunk(var_00)) {
    var_00 hide();
    var_00 notsolid();

    if(isdefined(var_0.spawnflags) && var_0.spawnflags & 1)
      var_00 connectpaths();

    return;
  }
}

setupexploders() {
  scripts\engine\utility::set_createfx_enabled();
  level.exploders = [];
  var_00 = getentarray("script_brushmodel", "classname");
  var_01 = getentarray("script_model", "classname");

  for (var_02 = 0; var_02 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_02];

  foreach(var_04 in var_00) {
    if(isdefined(var_4.script_prefab_exploder))
      var_4.targetname = var_4.script_prefab_exploder;

    if(isdefined(var_4.masked_exploder)) {
      continue;
    }
    if(isdefined(var_4.targetname))
      setup_individual_exploder(var_04);
  }

  var_06 = [];
  var_07 = getentarray("script_brushmodel", "classname");

  for (var_02 = 0; var_02 < var_7.size; var_2++) {
    if(isdefined(var_7[var_02].script_prefab_exploder))
      var_7[var_02].targetname = var_7[var_02].script_prefab_exploder;

    if(isdefined(var_7[var_02].targetname))
      var_6[var_6.size] = var_7[var_02];
  }

  var_07 = getentarray("script_model", "classname");

  for (var_02 = 0; var_02 < var_7.size; var_2++) {
    if(isdefined(var_7[var_02].script_prefab_exploder))
      var_7[var_02].targetname = var_7[var_02].script_prefab_exploder;

    if(isdefined(var_7[var_02].targetname))
      var_6[var_6.size] = var_7[var_02];
  }

  var_07 = getentarray("item_health", "classname");

  for (var_02 = 0; var_02 < var_7.size; var_2++) {
    if(isdefined(var_7[var_02].script_prefab_exploder))
      var_7[var_02].targetname = var_7[var_02].script_prefab_exploder;

    if(isdefined(var_7[var_02].targetname))
      var_6[var_6.size] = var_7[var_02];
  }

  var_07 = level.struct;

  for (var_02 = 0; var_02 < var_7.size; var_2++) {
    if(!isdefined(var_7[var_02])) {
      continue;
    }
    if(isdefined(var_7[var_02].script_prefab_exploder))
      var_7[var_02].targetname = var_7[var_02].script_prefab_exploder;

    if(isdefined(var_7[var_02].targetname)) {
      if(!isdefined(var_7[var_02].angles))
        var_7[var_02].angles = (0, 0, 0);

      var_6[var_6.size] = var_7[var_02];
    }
  }

  if(!isdefined(level.createfxent))
    level.createfxent = [];

  var_08 = [];
  var_8["exploderchunk visible"] = 1;
  var_8["exploderchunk"] = 1;
  var_8["exploder"] = 1;
  thread setup_flag_exploders();

  for (var_02 = 0; var_02 < var_6.size; var_2++) {
    var_09 = var_6[var_02];
    var_04 = scripts\engine\utility::createexploder(var_9.script_fxid);
    var_4.v = [];
    var_4.v["origin"] = var_9.origin;
    var_4.v["angles"] = var_9.angles;
    var_4.v["delay"] = var_9.script_delay;
    var_4.v["delay_post"] = var_9.script_delay_post;
    var_4.v["firefx"] = var_9.script_firefx;
    var_4.v["firefxdelay"] = var_9.script_firefxdelay;
    var_4.v["firefxsound"] = var_9.script_firefxsound;
    var_4.v["earthquake"] = var_9.script_earthquake;
    var_4.v["rumble"] = var_9.script_rumble;
    var_4.v["damage"] = var_9.script_damage;
    var_4.v["damage_radius"] = var_9.script_radius;
    var_4.v["soundalias"] = var_9.script_soundalias;
    var_4.v["repeat"] = var_9.script_repeat;
    var_4.v["delay_min"] = var_9.script_delay_min;
    var_4.v["delay_max"] = var_9.script_delay_max;
    var_4.v["target"] = var_9.target;
    var_4.v["ender"] = var_9.script_ender;
    var_4.v["physics"] = var_9.script_physics;
    var_4.v["type"] = "exploder";

    if(!isdefined(var_9.script_fxid))
      var_4.v["fxid"] = "No FX";
    else
      var_4.v["fxid"] = var_9.script_fxid;

    var_4.v["exploder"] = var_9.targetname;

    if(isdefined(level.createfxexploders)) {
      var_10 = level.createfxexploders[var_4.v["exploder"]];

      if(!isdefined(var_10))
        var_10 = [];

      var_10[var_10.size] = var_04;
      level.createfxexploders[var_4.v["exploder"]] = var_10;
    }

    if(!isdefined(var_4.v["delay"]))
      var_4.v["delay"] = 0;

    if(isdefined(var_9.target)) {
      var_11 = getentarray(var_4.v["target"], "targetname")[0];

      if(isdefined(var_11)) {
        var_12 = var_11.origin;
        var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
      } else {
        var_11 = scripts\engine\utility::get_target_ent(var_4.v["target"]);

        if(isdefined(var_11)) {
          var_12 = var_11.origin;
          var_4.v["angles"] = vectortoangles(var_12 - var_4.v["origin"]);
        }
      }
    }

    if(!isdefined(var_9.code_classname)) {
      var_4.model = var_09;

      if(isdefined(var_4.model.script_modelname))
        precachemodel(var_4.model.script_modelname);
    } else if(var_9.code_classname == "script_brushmodel" || isdefined(var_9.model)) {
      var_4.model = var_09;
      var_4.model.disconnect_paths = var_9.script_disconnectpaths;
    }

    if(isdefined(var_9.targetname) && isdefined(var_8[var_9.targetname]))
      var_4.v["exploder_type"] = var_9.targetname;
    else
      var_4.v["exploder_type"] = "normal";

    if(isdefined(var_9.masked_exploder)) {
      var_4.v["masked_exploder"] = var_9.model;
      var_4.v["masked_exploder_spawnflags"] = var_9.spawnflags;
      var_4.v["masked_exploder_script_disconnectpaths"] = var_9.script_disconnectpaths;
      var_09 delete();
    }

    var_04 scripts\common\createfx::post_entity_creation_function();
  }
}

setup_flag_exploders() {
  waittillframeend;
  waittillframeend;
  waittillframeend;
  var_00 = [];

  foreach(var_02 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_03 = var_2.v["flag"];

    if(!isdefined(var_03)) {
      continue;
    }
    if(var_03 == "nil")
      var_2.v["flag"] = undefined;

    var_0[var_03] = 1;
  }

  foreach(var_07, var_06 in var_00)
  thread exploder_flag_wait(var_07);
}

exploder_flag_wait(var_00) {
  if(!scripts\engine\utility::flag_exist(var_00))
    scripts\engine\utility::flag_init(var_00);

  scripts\engine\utility::flag_wait(var_00);

  foreach(var_02 in level.createfxent) {
    if(var_2.v["type"] != "exploder") {
      continue;
    }
    var_03 = var_2.v["flag"];

    if(!isdefined(var_03)) {
      continue;
    }
    if(var_03 != var_00) {
      continue;
    }
    var_02 scripts\engine\utility::activate_individual_exploder();
  }
}

exploder_model_is_damaged_model(var_00) {
  return isdefined(var_0.targetname) && var_0.targetname == "exploder";
}

exploder_model_starts_hidden(var_00) {
  return var_0.model == "fx" && (!isdefined(var_0.targetname) || var_0.targetname != "exploderchunk");
}

exploder_model_is_chunk(var_00) {
  return isdefined(var_0.targetname) && var_0.targetname == "exploderchunk";
}

show_exploder_models_proc(var_00) {
  var_00 = var_00 + "";

  if(isdefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[var_00];

    if(isdefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!exploder_model_starts_hidden(var_3.model) && !exploder_model_is_damaged_model(var_3.model) && !exploder_model_is_chunk(var_3.model))
          var_3.model show();

        if(isdefined(var_3.brush_shown))
          var_3.model show();
      }

      return;
    }
  } else {
    for (var_05 = 0; var_05 < level.createfxent.size; var_5++) {
      var_03 = level.createfxent[var_05];

      if(!isdefined(var_03)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_00) {
        continue;
      }
      if(isdefined(var_3.model)) {
        if(!exploder_model_starts_hidden(var_3.model) && !exploder_model_is_damaged_model(var_3.model) && !exploder_model_is_chunk(var_3.model))
          var_3.model show();

        if(isdefined(var_3.brush_shown))
          var_3.model show();
      }
    }
  }
}

stop_exploder_proc(var_00) {
  var_00 = var_00 + "";

  if(isdefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[var_00];

    if(isdefined(var_01)) {
      foreach(var_03 in var_01) {
        if(!isdefined(var_3.looper)) {
          continue;
        }
        if(isdefined(var_3.loopsound_ent)) {
          var_3.loopsound_ent stoploopsound();
          var_3.loopsound_ent delete();
        }

        var_3.looper delete();
      }

      return;
    }
  } else {
    for (var_05 = 0; var_05 < level.createfxent.size; var_5++) {
      var_03 = level.createfxent[var_05];

      if(!isdefined(var_03)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_00) {
        continue;
      }
      if(!isdefined(var_3.looper)) {
        continue;
      }
      if(isdefined(var_3.loopsound_ent)) {
        var_3.loopsound_ent stoploopsound();
        var_3.loopsound_ent delete();
      }

      var_3.looper delete();
    }
  }
}

get_exploder_array_proc(var_00) {
  var_00 = var_00 + "";
  var_01 = [];

  if(isdefined(level.createfxexploders)) {
    var_02 = level.createfxexploders[var_00];

    if(isdefined(var_02))
      var_01 = var_02;
  } else {
    foreach(var_04 in level.createfxent) {
      if(var_4.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_4.v["exploder"])) {
        continue;
      }
      if(var_4.v["exploder"] + "" != var_00) {
        continue;
      }
      var_1[var_1.size] = var_04;
    }
  }

  return var_01;
}

hide_exploder_models_proc(var_00) {
  var_00 = var_00 + "";

  if(isdefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[var_00];

    if(isdefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isdefined(var_3.model))
          var_3.model hide();
      }

      return;
    }
  } else {
    for (var_05 = 0; var_05 < level.createfxent.size; var_5++) {
      var_03 = level.createfxent[var_05];

      if(!isdefined(var_03)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_00) {
        continue;
      }
      if(isdefined(var_3.model))
        var_3.model hide();
    }
  }
}

delete_exploder_proc(var_00) {
  var_00 = var_00 + "";

  if(isdefined(level.createfxexploders)) {
    var_01 = level.createfxexploders[var_00];

    if(isdefined(var_01)) {
      foreach(var_03 in var_01) {
        if(isdefined(var_3.model))
          var_3.model delete();
      }
    }
  } else {
    for (var_05 = 0; var_05 < level.createfxent.size; var_5++) {
      var_03 = level.createfxent[var_05];

      if(!isdefined(var_03)) {
        continue;
      }
      if(var_3.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_3.v["exploder"])) {
        continue;
      }
      if(var_3.v["exploder"] + "" != var_00) {
        continue;
      }
      if(isdefined(var_3.model))
        var_3.model delete();
    }
  }

  level notify("killexplodertridgers" + var_00);
}

exploder_damage() {
  if(isdefined(self.v["delay"]))
    var_00 = self.v["delay"];
  else
    var_00 = 0;

  if(isdefined(self.v["damage_radius"]))
    var_01 = self.v["damage_radius"];
  else
    var_01 = 128;

  var_02 = self.v["damage"];
  var_03 = self.v["origin"];
  wait(var_00);

  if(isdefined(level.custom_radius_damage_for_exploders))
    [[level.custom_radius_damage_for_exploders]](var_03, var_01, var_02);
  else
    radiusdamage(var_03, var_01, var_02, var_02);
}

activate_individual_exploder_proc() {
  if(isdefined(self.v["firefx"]))
    thread fire_effect();

  if(isdefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
    thread cannon_effect();
  else if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
    thread sound_effect();

  if(isdefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
    thread effect_loopsound();

  if(isdefined(self.v["damage"]))
    thread exploder_damage();

  if(isdefined(self.v["earthquake"]))
    thread exploder_earthquake();

  if(isdefined(self.v["rumble"]))
    thread exploder_rumble();

  if(self.v["exploder_type"] == "exploder")
    thread brush_show();
  else if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
    thread brush_throw();
  else
    thread brush_delete();
}

brush_delete() {
  var_00 = self.v["exploder"];

  if(isdefined(self.v["delay"]))
    wait(self.v["delay"]);
  else
    wait 0.05;

  if(!isdefined(self.model)) {
    return;
  }
  if(isdefined(self.model.classname)) {
    if(!_isstruct(self.model) && isdefined(self.model.classname)) {
      if(scripts\engine\utility::issp() && self.model.spawnflags & 1)
        self.model call[[level.func["connectPaths"]]]();
    }
  }

  if(level.createfx_enabled) {
    if(isdefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    self.model hide();
    self.model notsolid();
    wait 3;
    self.exploded = undefined;
    self.model show();
    self.model solid();
    return;
  }

  if(!isdefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
    self.v["exploder"] = undefined;

  waittillframeend;

  if(isdefined(self.model) && !_isstruct(self.model) && isdefined(self.model.classname))
    self.model delete();
}

brush_throw() {
  if(isdefined(self.v["delay"]))
    wait(self.v["delay"]);

  var_00 = undefined;

  if(isdefined(self.v["target"]))
    var_00 = scripts\engine\utility::get_target_ent(self.v["target"]);

  if(!isdefined(var_00)) {
    self.model delete();
    return;
  }

  self.model show();

  if(isdefined(self.v["delay_post"]))
    wait(self.v["delay_post"]);

  var_01 = self.v["origin"];
  var_02 = self.v["angles"];
  var_03 = var_0.origin;
  var_04 = isdefined(self.v["physics"]);

  if(var_04) {
    var_05 = undefined;

    if(isdefined(var_0.target))
      var_05 = var_00 scripts\engine\utility::get_target_ent();

    if(isdefined(var_05)) {
      var_06 = var_0.origin;
      var_07 = vectornormalize(var_5.origin - var_0.origin);
    } else {
      var_06 = self.model.origin;
      var_07 = vectornormalize(var_03 - self.model.origin);
    }

    var_07 = var_07 * self.v["physics"];
    self.model physicslaunchserver(var_06, var_07);
    return;
  } else {
    var_07 = var_03 - self.model.origin;
    self.model rotatevelocity(var_07, 12);
    self.model movegravity(var_07, 12);
  }

  if(level.createfx_enabled) {
    if(isdefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;
    self.v["origin"] = var_01;
    self.v["angles"] = var_02;
    self.model hide();
    return;
  }

  self.v["exploder"] = undefined;
  wait 6;
  self.model delete();
}

brush_show() {
  if(isdefined(self.v["delay"]))
    wait(self.v["delay"]);

  if(!isdefined(self.model.script_modelname)) {
    self.model show();
    self.model solid();
  } else {
    var_00 = self.model scripts\engine\utility::spawn_tag_origin();

    if(isdefined(self.model.script_linkname))
      var_0.script_linkname = self.model.script_linkname;

    var_00 setmodel(self.model.script_modelname);
    var_00 show();
  }

  self.brush_shown = 1;

  if(scripts\engine\utility::issp() && !isdefined(self.model.script_modelname) && self.model.spawnflags & 1) {
    if(!isdefined(self.model.disconnect_paths))
      self.model call[[level.func["connectPaths"]]]();
    else
      self.model call[[level.func["disconnectPaths"]]]();
  }

  if(level.createfx_enabled) {
    if(isdefined(self.exploded)) {
      return;
    }
    self.exploded = 1;
    wait 3;
    self.exploded = undefined;

    if(!isdefined(self.model.script_modelname)) {
      self.model hide();
      self.model notsolid();
    }
  }
}

exploder_rumble() {
  if(!scripts\engine\utility::issp()) {
    return;
  }
  exploder_delay();
  level.player playrumbleonentity(self.v["rumble"]);
}

exploder_delay() {
  if(!isdefined(self.v["delay"]))
    self.v["delay"] = 0;

  var_00 = self.v["delay"];
  var_01 = self.v["delay"] + 0.001;

  if(isdefined(self.v["delay_min"]))
    var_00 = self.v["delay_min"];

  if(isdefined(self.v["delay_max"]))
    var_01 = self.v["delay_max"];

  if(var_00 > 0)
    wait(randomfloatrange(var_00, var_01));
}

effect_loopsound() {
  if(isdefined(self.loopsound_ent)) {
    self.loopsound_ent stoploopsound();
    self.loopsound_ent delete();
  }

  var_00 = self.v["origin"];
  var_01 = self.v["loopsound"];
  exploder_delay();
  self.loopsound_ent = scripts\engine\utility::play_loopsound_in_space(var_01, var_00);
}

sound_effect() {
  effect_soundalias();
}

effect_soundalias() {
  var_00 = self.v["origin"];
  var_01 = self.v["soundalias"];
  exploder_delay();
  scripts\engine\utility::play_sound_in_space(var_01, var_00);
}

exploder_earthquake() {
  exploder_delay();
  scripts\engine\utility::do_earthquake(self.v["earthquake"], self.v["origin"]);
}

exploder_playsound() {
  if(!isdefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  scripts\engine\utility::play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect() {
  var_00 = self.v["forward"];
  var_01 = self.v["up"];
  var_02 = undefined;
  var_03 = self.v["firefxsound"];
  var_04 = self.v["origin"];
  var_05 = self.v["firefx"];
  var_06 = self.v["ender"];

  if(!isdefined(var_06))
    var_06 = "createfx_effectStopper";

  var_07 = 0.5;

  if(isdefined(self.v["firefxdelay"]))
    var_07 = self.v["firefxdelay"];

  exploder_delay();

  if(isdefined(var_03))
    scripts\engine\utility::loop_fx_sound(var_03, var_04, 1, var_06);

  playfx(level._effect[var_05], self.v["origin"], var_00, var_01);
}

cannon_effect() {
  if(isdefined(self.v["repeat"])) {
    thread exploder_playsound();

    for (var_00 = 0; var_00 < self.v["repeat"]; var_0++) {
      playfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      exploder_delay();
    }

    return;
  }

  exploder_delay();

  if(isdefined(self.looper))
    self.looper delete();

  self.looper = spawnfx(scripts\engine\utility::getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerfx(self.looper);
  exploder_playsound();
}

activate_exploder(var_00, var_01, var_02) {
  var_00 = var_00 + "";
  level notify("exploding_" + var_00);
  var_03 = 0;

  if(isdefined(level.createfxexploders) && !level.createfx_enabled) {
    var_04 = level.createfxexploders[var_00];

    if(isdefined(var_04)) {
      foreach(var_06 in var_04) {
        var_06 scripts\engine\utility::activate_individual_exploder();
        var_03 = 1;
      }
    }
  } else {
    for (var_08 = 0; var_08 < level.createfxent.size; var_8++) {
      var_06 = level.createfxent[var_08];

      if(!isdefined(var_06)) {
        continue;
      }
      if(var_6.v["type"] != "exploder") {
        continue;
      }
      if(!isdefined(var_6.v["exploder"])) {
        continue;
      }
      if(var_6.v["exploder"] + "" != var_00) {
        continue;
      }
      var_06 scripts\engine\utility::activate_individual_exploder();
      var_03 = 1;
    }
  }

  if(!shouldrunserversideeffects() && !var_03)
    activate_clientside_exploder(var_00, var_01, var_02);
}

activate_clientside_exploder(var_00, var_01, var_02) {
  if(!is_valid_clientside_exploder_name(var_00)) {
    return;
  }
  var_03 = int(var_00);
  activateclientexploder(var_03, var_01, var_02);
}

is_valid_clientside_exploder_name(var_00) {
  if(!isdefined(var_00))
    return 0;

  var_01 = var_00;

  if(isstring(var_00)) {
    var_01 = int(var_00);

    if(var_01 == 0 && var_00 != "0")
      return 0;
  }

  return var_01 >= 0;
}

shouldrunserversideeffects() {
  if(scripts\engine\utility::issp())
    return 1;

  if(!isdefined(level.createfx_enabled))
    scripts\engine\utility::set_createfx_enabled();

  if(level.createfx_enabled)
    return 1;
  else
    return getdvar("clientSideEffects") != "1";
}

exploder_before_load(var_00, var_01, var_02) {
  waittillframeend;
  waittillframeend;
  activate_exploder(var_00, var_01, var_02);
}

exploder_after_load(var_00, var_01, var_02) {
  activate_exploder(var_00, var_01, var_02);
}