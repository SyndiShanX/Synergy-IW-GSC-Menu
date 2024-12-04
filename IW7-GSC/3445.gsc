/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3445.gsc
***************************************/

init() {
  init_template_table();
  init_class_table();
  init_perktable();
  init_bot_weap_statstable();
  init_bot_attachmenttable();
  init_bot_camotable();
  init_bot_archetypes();
  level.bot_loadouts_initialized = 1;
}

init_class_table() {
  var_00 = "mp\botClassTable.csv";
  level.botloadoutsets = [];
  var_01 = bot_loadout_fields();
  var_02 = 0;

  for (;;) {
    var_2++;
    var_03 = tablelookup(var_00, 0, "botArchetype", var_02);
    var_04 = tablelookup(var_00, 0, "botPersonalities", var_02);
    var_05 = tablelookup(var_00, 0, "botDifficulties", var_02);

    if(!isdefined(var_03) || var_03 == "") {
      break;
    }
    if(!isdefined(var_04) || var_04 == "") {
      break;
    }
    if(!isdefined(var_05) || var_05 == "") {
      break;
    }
    var_06 = [];

    foreach(var_08 in var_01)
    var_6[var_08] = tablelookup(var_00, 0, var_08, var_02);

    var_10 = strtok(var_03, "|");
    var_11 = strtok(var_04, "| ");
    var_12 = strtok(var_05, "| ");

    foreach(var_14 in var_10) {
      var_14 = "archetype_" + var_14;
      var_6["loadoutArchetype"] = var_14;

      foreach(var_16 in var_11) {
        foreach(var_18 in var_12) {
          var_19 = bot_loadout_set(var_14, var_16, var_18, 1);
          var_20 = spawnstruct();
          var_20.loadoutvalues = var_06;
          var_19.loadouts[var_19.loadouts.size] = var_20;
        }
      }
    }
  }
}

init_template_table() {
  var_00 = "mp\botTemplateTable.csv";
  level.botloadouttemplates = [];
  var_01 = bot_loadout_fields();
  var_02 = 0;

  for (;;) {
    var_2++;
    var_03 = tablelookup(var_00, 0, "template_", var_02);

    if(!isdefined(var_03) || var_03 == "") {
      break;
    }
    var_04 = "template_" + var_03;
    level.botloadouttemplates[var_04] = [];

    foreach(var_06 in var_01) {
      var_07 = tablelookup(var_00, 0, var_06, var_02);

      if(isdefined(var_07) && var_07 != "")
        level.botloadouttemplates[var_04][var_06] = var_07;
    }
  }
}

init_bot_archetypes() {
  level.botarchetypes = [];
  level.botarchetypes["cqb"] = ["archetype_assault", "archetype_scout", "archetype_assassin", "archetype_heavy", "archetype_engineer"];
  level.botarchetypes["run_and_gun"] = ["archetype_assault", "archetype_scout", "archetype_heavy", "archetype_engineer"];
  level.botarchetypes["camper"] = ["archetype_assassin", "archetype_heavy", "archetype_sniper"];
  level.botarchetypes["default"] = ["archetype_assault"];
}

bot_loadout_item_allowed(var_00, var_01, var_02) {
  if(!isusingmatchrulesdata())
    return 1;

  if(!getmatchrulesdata("commonOption", "allowCustomClasses"))
    return 1;

  if(var_01 == "specialty_null")
    return 1;

  if(var_01 == "none")
    return 1;

  if(var_00 == "equipment") {
    if(getmatchrulesdata("commonOption", "perkRestricted", var_01))
      return 0;

    var_00 = "weapon";
  }

  var_03 = var_00 + "Restricted";
  var_04 = var_00 + "ClassRestricted";
  var_05 = "";

  switch (var_00) {
    case "weapon":
      var_05 = scripts\mp\utility\game::getweapongroup(var_01);
      break;
    case "attachment":
      var_05 = scripts\mp\utility\game::getattachmenttype(var_01);
      break;
    case "killstreak":
      var_05 = var_02;
      break;
    case "perk":
      var_05 = "ability_" + level.bot_perktypes[var_01];
      break;
    default:
      return 0;
  }

  if(getmatchrulesdata("commonOption", var_03, var_01))
    return 0;

  if(getmatchrulesdata("commonOption", var_04, var_05))
    return 0;

  return 1;
}

bot_loadout_choose_fallback_primary(var_00) {
  var_01 = "none";
  var_02 = ["veteran", "hardened", "regular", "recruit"];
  var_02 = scripts\engine\utility::array_randomize(var_02);

  foreach(var_04 in var_02) {
    var_01 = bot_loadout_choose_from_statstable("weap_statstable", var_00, "loadoutPrimary", self.botarchetype, self.personality, var_04);

    if(var_01 != "none")
      return var_01;
  }

  if(isdefined(level.bot_personality_list)) {
    var_06 = scripts\engine\utility::array_randomize(level.bot_personality_list);

    foreach(var_08 in var_06) {
      foreach(var_04 in var_02) {
        var_01 = bot_loadout_choose_from_statstable("weap_statstable", var_00, "loadoutPrimary", var_0["loadoutArchetype"], var_08, var_04);

        if(var_01 != "none") {
          self.bot_fallback_personality = var_08;
          return var_01;
        }
      }
    }
  }

  if(isusingmatchrulesdata()) {
    for (var_12 = 0; var_12 < 6 && (!isdefined(var_01) || var_01 == "none" || var_01 == ""); var_12++) {
      if(scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", self.team, var_12, "class", "inUse")) {
        var_01 = scripts\mp\utility\game::getmatchrulesdatawithteamandindex("defaultClasses", self.team, var_12, "class", "weaponSetups", 0, "weapon");

        if(var_01 != "none") {
          self.bot_fallback_personality = "weapon";
          return var_01;
        }
      }
    }
  }

  self.bot_fallback_personality = "weapon";
  return level.bot_fallback_weapon;
}

bot_pick_personality_from_weapon(var_00) {
  if(isdefined(var_00)) {
    var_01 = level.bot_weap_personality[var_00];

    if(isdefined(var_01)) {
      var_02 = strtok(var_01, "| ");

      if(var_2.size > 0)
        scripts\mp\bots\bots_util::bot_set_personality(scripts\engine\utility::random(var_02));
    }
  }
}

bot_loadout_fields() {
  var_00 = [];
  var_0[var_0.size] = "loadoutPrimary";
  var_0[var_0.size] = "loadoutPrimaryAttachment";
  var_0[var_0.size] = "loadoutPrimaryAttachment2";
  var_0[var_0.size] = "loadoutPrimaryCamo";
  var_0[var_0.size] = "loadoutPrimaryReticle";
  var_0[var_0.size] = "loadoutSecondary";
  var_0[var_0.size] = "loadoutSecondaryAttachment";
  var_0[var_0.size] = "loadoutSecondaryAttachment2";
  var_0[var_0.size] = "loadoutSecondaryCamo";
  var_0[var_0.size] = "loadoutSecondaryReticle";
  var_0[var_0.size] = "loadoutStreakType";
  var_0[var_0.size] = "loadoutStreak1";
  var_0[var_0.size] = "loadoutStreak2";
  var_0[var_0.size] = "loadoutStreak3";
  var_0[var_0.size] = "loadoutPowerPrimary";
  var_0[var_0.size] = "loadoutPowerSecondary";
  var_0[var_0.size] = "loadoutPerk1";
  var_0[var_0.size] = "loadoutPerk2";
  var_0[var_0.size] = "loadoutPerk3";
  return var_00;
}

bot_loadout_set(var_00, var_01, var_02, var_03) {
  var_04 = bot_loadout_make_index(var_00, var_01, var_02);

  if(!isdefined(level.botloadoutsets))
    level.botloadoutsets = [];

  if(!isdefined(level.botloadoutsets[var_04]) && var_03) {
    level.botloadoutsets[var_04] = spawnstruct();
    level.botloadoutsets[var_04].loadouts = [];
  }

  if(isdefined(level.botloadoutsets[var_04]))
    return level.botloadoutsets[var_04];
}

bot_loadout_pick(var_00, var_01, var_02) {
  var_03 = bot_loadout_set(var_00, var_01, var_02, 0);

  if(isdefined(var_03) && isdefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    var_04 = randomint(var_3.loadouts.size);
    return var_3.loadouts[var_04].loadoutvalues;
  }
}

bot_validate_weapon(var_00, var_01, var_02, var_03) {
  var_04 = scripts\mp\utility\game::getweaponattachmentarrayfromstats(var_00);

  if(isdefined(var_01) && var_01 != "none" && !bot_loadout_item_allowed("attachment", var_01))
    return 0;

  if(isdefined(var_02) && var_02 != "none" && !bot_loadout_item_allowed("attachment", var_02))
    return 0;

  if(isdefined(var_03) && var_03 != "none" && !bot_loadout_item_allowed("attachment", var_03))
    return 0;

  if(var_01 != "none" && !scripts\engine\utility::array_contains(var_04, var_01))
    return 0;

  if(var_02 != "none" && !scripts\engine\utility::array_contains(var_04, var_02))
    return 0;

  if(isdefined(var_03) && var_03 != "none" && !scripts\engine\utility::array_contains(var_04, var_03))
    return 0;

  if((var_01 == "none" || var_02 == "none") && (!isdefined(var_03) || var_03 == "none"))
    return 1;

  if(!isdefined(level.bot_invalid_attachment_combos)) {
    level.bot_invalid_attachment_combos = [];
    level.allowable_double_attachments = [];
    var_05 = "mp\attachmentcombos.csv";
    var_06 = 0;

    for (;;) {
      var_6++;
      var_07 = tablelookupbyrow(var_05, 0, var_06);

      if(var_07 == "") {
        break;
      }
      var_08 = 0;

      for (;;) {
        var_8++;
        var_09 = tablelookupbyrow(var_05, var_08, 0);

        if(var_09 == "") {
          break;
        }
        if(var_09 == var_07) {
          if(tablelookupbyrow(var_05, var_08, var_06) != "no")
            level.allowable_double_attachments[var_09] = 1;

          continue;
        }

        if(tablelookupbyrow(var_05, var_08, var_06) == "no")
          level.bot_invalid_attachment_combos[var_07][var_09] = 1;
      }
    }
  }

  if(var_01 == var_02 && !isdefined(level.allowable_double_attachments[var_01]))
    return 0;

  if(isdefined(var_03)) {
    if(var_02 == var_03 && !isdefined(level.allowable_double_attachments[var_02]))
      return 0;

    if(var_01 == var_03 && !isdefined(level.allowable_double_attachments[var_01]))
      return 0;

    if(var_03 != "none" && var_01 == var_03 && var_02 == var_03)
      return 0;

    if(isdefined(level.bot_invalid_attachment_combos[var_02]) && isdefined(level.bot_invalid_attachment_combos[var_02][var_03]))
      return 0;

    if(isdefined(level.bot_invalid_attachment_combos[var_01]) && isdefined(level.bot_invalid_attachment_combos[var_01][var_03]))
      return 0;
  }

  return !(isdefined(level.bot_invalid_attachment_combos[var_01]) && isdefined(level.bot_invalid_attachment_combos[var_01][var_02]));
}

bot_validate_reticle(var_00, var_01, var_02) {
  if(isdefined(var_1[var_00 + "Attachment"]) && isdefined(level.bot_attachment_reticle[var_1[var_00 + "Attachment"]]))
    return 1;

  if(isdefined(var_1[var_00 + "Attachment2"]) && isdefined(level.bot_attachment_reticle[var_1[var_00 + "Attachment2"]]))
    return 1;

  if(isdefined(var_1[var_00 + "Attachment3"]) && isdefined(level.bot_attachment_reticle[var_1[var_00 + "Attachment3"]]))
    return 1;

  return 0;
}

bot_perk_cost(var_00) {
  return level.perktable_costs[var_00];
}

perktable_add(var_00, var_01) {
  if(bot_perk_cost(var_00) > 0) {
    var_02 = [];
    var_2["type"] = var_01;
    var_2["name"] = var_00;
    level.bot_perktable[level.bot_perktable.size] = var_02;
    level.bot_perktypes[var_00] = var_01;
  }
}

init_perktable() {
  level.perktable_costs = [];
  var_00 = 1;

  for (;;) {
    var_01 = tablelookupbyrow("mp\perktable.csv", var_00, 1);

    if(var_01 == "") {
      break;
    }
    level.perktable_costs[var_01] = int(tablelookupbyrow("mp\perktable.csv", var_00, 10));
    var_0++;
  }

  level.perktable_costs["none"] = 0;
  level.perktable_costs["specialty_null"] = 0;
  level.bot_perktable = [];
  level.bot_perktypes = [];
  var_00 = 1;

  for (var_02 = "ability_null"; isdefined(var_02) && var_02 != ""; var_02 = tablelookupbyrow("mp\cacabilitytable.csv", var_00, 1)) {
    var_02 = getsubstr(var_02, 8);

    for (var_03 = 4; var_03 <= 13; var_3++) {
      var_01 = tablelookupbyrow("mp\cacabilitytable.csv", var_00, var_03);

      if(var_01 != "")
        perktable_add(var_01, var_02);
    }

    var_0++;
  }
}

init_bot_weap_statstable() {
  var_00 = "mp\statstable.csv";
  var_01 = 4;
  var_02 = 38;
  var_03 = 39;
  var_04 = 40;
  level.bot_weap_statstable = [];
  level.bot_weap_personality = [];
  var_05 = 1;

  for (;;) {
    var_06 = tablelookupbyrow(var_00, var_05, var_01);

    if(var_06 == "specialty_null") {
      break;
    }
    var_07 = tablelookupbyrow(var_00, var_05, var_02);
    var_08 = tablelookupbyrow(var_00, var_05, var_04);
    var_09 = tablelookupbyrow(var_00, var_05, var_03);

    if(var_06 != "" && var_09 != "")
      level.bot_weap_personality[var_06] = var_09;

    if(var_08 != "" && var_06 != "" && var_09 != "" && var_07 != "") {
      var_10 = "loadoutPrimary";

      if(scripts\mp\utility\game::iscacsecondaryweapon(var_06))
        var_10 = "loadoutSecondary";
      else if(!scripts\mp\utility\game::iscacprimaryweapon(var_06)) {
        var_5++;
        continue;
      }

      if(!isdefined(level.bot_weap_statstable[var_10]))
        level.bot_weap_statstable[var_10] = [];

      var_11 = strtok(var_07, "|");
      var_12 = strtok(var_09, "| ");
      var_13 = strtok(var_08, "| ");

      foreach(var_15 in var_11) {
        var_15 = "archetype_" + var_15;

        foreach(var_17 in var_12) {
          foreach(var_19 in var_13) {
            var_20 = bot_loadout_make_index(var_15, var_17, var_19);

            if(!isdefined(level.bot_weap_statstable[var_10][var_20]))
              level.bot_weap_statstable[var_10][var_20] = [];

            var_21 = level.bot_weap_statstable[var_10][var_20].size;
            level.bot_weap_statstable[var_10][var_20][var_21] = var_06;
          }
        }
      }
    }

    var_5++;
  }
}

bot_loadout_choose_from_statstable(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = "specialty_null";

  if(var_02 == "loadoutPrimary")
    var_06 = "iw7_ar57";
  else if(var_02 == "loadoutSecondary")
    var_06 = "iw7_revolver";

  if(var_04 == "default")
    var_04 = "run_and_gun";

  if(var_02 == "loadoutSecondary" && scripts\engine\utility::array_contains(var_01, "specialty_twoprimaries"))
    var_02 = "loadoutPrimary";

  if(!isdefined(level.bot_weap_statstable))
    return var_06;

  if(!isdefined(level.bot_weap_statstable[var_02]))
    return var_06;

  var_07 = bot_loadout_make_index(var_03, var_04, var_05);

  if(!isdefined(level.bot_weap_statstable[var_02][var_07]))
    return var_06;

  var_06 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_02][var_07], var_00, var_01, var_02);
  return var_06;
}

bot_loadout_choose_from_perktable(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = "specialty_null";

  if(!isdefined(level.bot_perktable))
    return var_06;

  if(!isdefined(level.bot_perktable_groups))
    level.bot_perktable_groups = [];

  if(!isdefined(level.bot_perktable_groups[var_00])) {
    var_07 = strtok(var_00, "_");
    var_7[0] = "";
    var_08 = 0;

    if(scripts\engine\utility::array_contains(var_07, "any"))
      var_08 = 1;

    var_09 = [];

    foreach(var_11 in level.bot_perktable) {
      if(var_08 || scripts\engine\utility::array_contains(var_07, var_11["type"]))
        var_9[var_9.size] = var_11["name"];
    }

    level.bot_perktable_groups[var_00] = var_09;
  }

  if(level.bot_perktable_groups[var_00].size > 0)
    var_06 = bot_loadout_choose_from_set(level.bot_perktable_groups[var_00], var_01, var_02, var_03);

  return var_06;
}

bot_validate_perk(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = var_04 - var_03 + 1;

  if(isdefined(var_05))
    var_06 = var_05;

  var_07 = 0;
  var_08 = int(getsubstr(var_01, 11));

  if(var_00 == "specialty_twoprimaries")
    return 0;

  if(var_00 == "specialty_extra_attachment")
    return 0;

  if(!bot_loadout_item_allowed("perk", var_00))
    return 0;

  for (var_09 = var_08 - 1; var_09 > 0; var_9--) {
    var_10 = "loadoutPerk" + var_09;

    if(var_2[var_10] == "none" || var_2[var_10] == "specialty_null") {
      continue;
    }
    if(var_00 == var_2[var_10])
      return 0;

    if(var_09 >= var_03 && var_09 <= var_04)
      var_07 = var_07 + bot_perk_cost(var_2[var_10]);
  }

  if(var_07 + bot_perk_cost(var_00) > var_06)
    return 0;

  return 1;
}

bot_loadout_choose_from_default_class(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_06 = int(getsubstr(var_00, 5, 6)) - 1;

  switch (var_03) {
    case "loadoutPrimary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_06, 0);
    case "loadoutPrimaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 0, 0);
    case "loadoutPrimaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 0, 1);
    case "loadoutPrimaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_06, 0);
    case "loadoutPrimaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_06, 0);
    case "loadoutSecondary":
      return scripts\mp\class::table_getweapon(level.classtablename, var_06, 1);
    case "loadoutSecondaryAttachment":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 1, 0);
    case "loadoutSecondaryAttachment2":
      return scripts\mp\class::table_getweaponattachment(level.classtablename, var_06, 1, 1);
    case "loadoutSecondaryCamo":
      return scripts\mp\class::table_getweaponcamo(level.classtablename, var_06, 1);
    case "loadoutSecondaryReticle":
      return scripts\mp\class::table_getweaponreticle(level.classtablename, var_06, 1);
    case "loadoutStreak1":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_06, 0);
    case "loadoutStreak2":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_06, 1);
    case "loadoutStreak3":
      return scripts\mp\class::table_getkillstreak(level.classtablename, var_06, 2);
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_07 = int(getsubstr(var_03, 11));
      var_08 = scripts\mp\class::table_getperk(level.classtablename, var_06, var_07);

      if(var_08 == "")
        return "specialty_null";

      var_09 = int(getsubstr(var_08, 0, 1));
      var_10 = int(getsubstr(var_08, 1, 2));
      var_11 = tablelookupbyrow("mp\cacabilitytable.csv", var_09 + 1, var_10 + 3);
      return var_11;
  }

  return var_00;
}

init_bot_attachmenttable() {
  var_00 = "mp\attachmenttable.csv";
  var_01 = 5;
  var_02 = 19;
  var_03 = 11;
  level.bot_attachmenttable = [];
  level.bot_attachment_reticle = [];
  var_04 = 1;

  for (;;) {
    var_05 = tablelookupbyrow(var_00, var_04, var_01);

    if(var_05 == "done") {
      break;
    }
    var_06 = tablelookupbyrow(var_00, var_04, var_02);

    if(var_05 != "" && var_06 != "") {
      var_07 = tablelookupbyrow(var_00, var_04, var_03);

      if(var_07 == "TRUE")
        level.bot_attachment_reticle[var_05] = 1;

      var_08 = strtok(var_06, "| ");

      foreach(var_10 in var_08) {
        if(!isdefined(level.bot_attachmenttable[var_10]))
          level.bot_attachmenttable[var_10] = [];

        if(!scripts\engine\utility::array_contains(level.bot_attachmenttable[var_10], var_05)) {
          var_11 = level.bot_attachmenttable[var_10].size;
          level.bot_attachmenttable[var_10][var_11] = var_05;
        }
      }
    }

    var_4++;
  }
}

bot_loadout_choose_from_attachmenttable(var_00, var_01, var_02, var_03, var_04) {
  var_05 = "none";

  if(!isdefined(level.bot_attachmenttable))
    return var_05;

  if(!isdefined(level.bot_attachmenttable[var_04]))
    return var_05;

  var_05 = bot_loadout_choose_from_set(level.bot_attachmenttable[var_04], var_00, var_01, var_02);
  return var_05;
}

init_bot_camotable() {
  var_00 = "mp\camotable.csv";
  level.func_2D1E = [];
  var_01 = 0;

  for (;;) {
    var_02 = tablelookupbyrow(var_00, var_01, scripts\engine\utility::getcamotablecolumnindex("ref"));

    if(!isdefined(var_02) || var_02 == "") {
      break;
    }
    var_03 = tablelookupbyrow(var_00, var_01, scripts\engine\utility::getcamotablecolumnindex("bot_valid"));

    if(isdefined(var_03) && int(var_03))
      level.func_2D1E[level.func_2D1E.size] = var_02;

    var_1++;
  }
}

bot_loadout_choose_from_camotable(var_00, var_01, var_02, var_03, var_04) {
  var_05 = "none";
  return var_05;
}

bot_loadout_perk_slots(var_00) {
  var_01 = 8;

  if(isdefined(var_0["loadoutPrimary"]) && var_0["loadoutPrimary"] == "none")
    var_01 = var_01 + 1;

  if(isdefined(var_0["loadoutSecondary"]) && var_0["loadoutSecondary"] == "none")
    var_01 = var_01 + 1;

  if(isdefined(var_0["loadoutPowerPrimary"]) && var_0["loadoutPowerPrimary"] == "none")
    var_01 = var_01 + 1;

  if(isdefined(var_0["loadoutPowerSecondary"]) && var_0["loadoutPowerSecondary"] == "none")
    var_01 = var_01 + 1;

  return var_01;
}

bot_loadout_valid_choice(var_00, var_01, var_02, var_03) {
  var_04 = 1;

  switch (var_02) {
    case "loadoutPrimary":
      var_04 = bot_loadout_item_allowed("weapon", var_03);
      break;
    case "loadoutPowerSecondary":
    case "loadoutPowerPrimary":
      var_04 = bot_loadout_item_allowed("equipment", var_03);
      break;
    case "loadoutPrimaryAttachment":
      var_04 = bot_validate_weapon(var_1["loadoutPrimary"], var_03, "none");
      break;
    case "loadoutPrimaryAttachment2":
      var_04 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_03);
      break;
    case "loadoutPrimaryAttachment3":
      var_04 = bot_validate_weapon(var_1["loadoutPrimary"], var_1["loadoutPrimaryAttachment"], var_1["loadoutPrimaryAttachment2"], var_03);
      break;
    case "loadoutPrimaryReticle":
      var_04 = bot_validate_reticle("loadoutPrimary", var_01, var_03);
      break;
    case "loadoutPrimaryCamo":
      var_04 = !isdefined(self.botloadoutfavoritecamo) || var_03 == self.botloadoutfavoritecamo;
      break;
    case "loadoutSecondary":
      var_04 = var_03 != var_1["loadoutPrimary"];
      var_04 = var_04 && bot_loadout_item_allowed("weapon", var_03);
      break;
    case "loadoutSecondaryAttachment":
      var_04 = bot_validate_weapon(var_1["loadoutSecondary"], var_03, "none");
      break;
    case "loadoutSecondaryAttachment2":
      var_04 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_03);
      break;
    case "loadoutSecondaryAttachment3":
      var_04 = bot_validate_weapon(var_1["loadoutSecondary"], var_1["loadoutSecondaryAttachment"], var_1["loadoutSecondaryAttachment2"], var_03);
      break;
    case "loadoutSecondaryReticle":
      var_04 = bot_validate_reticle("loadoutSecondary", var_01, var_03);
      break;
    case "loadoutSecondaryCamo":
      var_04 = !isdefined(self.botloadoutfavoritecamo) || var_03 == self.botloadoutfavoritecamo;
      break;
    case "loadoutStreak3":
    case "loadoutStreak2":
    case "loadoutStreak1":
      var_04 = scripts\mp\bots\bots_killstreaks::bot_killstreak_is_valid_internal(var_03, "bots", undefined, var_1["loadoutStreakType"]);
      var_04 = var_04 && bot_loadout_item_allowed("killstreak", var_03, var_1["loadoutStreakType"]);
      break;
    case "loadoutPerk12":
    case "loadoutPerk11":
    case "loadoutPerk10":
    case "loadoutPerk9":
    case "loadoutPerk8":
    case "loadoutPerk7":
    case "loadoutPerk6":
    case "loadoutPerk5":
    case "loadoutPerk4":
    case "loadoutPerk3":
    case "loadoutPerk2":
    case "loadoutPerk1":
      var_04 = bot_validate_perk(var_03, var_02, var_01, 1, 12, bot_loadout_perk_slots(var_01));
      break;
    case "loadoutPerk15":
    case "loadoutPerk14":
    case "loadoutPerk13":
      if(var_1["loadoutStreakType"] != "streaktype_specialist")
        var_04 = 0;
      else
        var_04 = bot_validate_perk(var_03, var_02, var_01, -1, -1);

      break;
    case "loadoutPerk23":
    case "loadoutPerk22":
    case "loadoutPerk21":
    case "loadoutPerk20":
    case "loadoutPerk19":
    case "loadoutPerk18":
    case "loadoutPerk17":
    case "loadoutPerk16":
      if(var_1["loadoutStreakType"] != "streaktype_specialist")
        var_04 = 0;
      else
        var_04 = bot_validate_perk(var_03, var_02, var_01, 16, 23, 8);

      break;
  }

  return var_04;
}

bot_loadout_choose_from_set(var_00, var_01, var_02, var_03, var_04) {
  var_05 = "none";
  var_06 = undefined;
  var_07 = 0.0;

  if(scripts\engine\utility::array_contains(var_00, "specialty_null"))
    var_05 = "specialty_null";

  foreach(var_09 in var_00) {
    var_10 = undefined;

    if(getsubstr(var_09, 0, 9) == "template_") {
      var_10 = var_09;
      var_11 = level.botloadouttemplates[var_09][var_03];
      var_09 = bot_loadout_choose_from_set(strtok(var_11, "| "), var_01, var_02, var_03, 1);

      if(isdefined(var_10) && isdefined(self.chosentemplates[var_10]))
        return var_09;
    }

    if(var_09 == "attachmenttable")
      return bot_loadout_choose_from_attachmenttable(var_01, var_02, var_03, self.personality, self.difficulty);

    if(var_09 == "weap_statstable")
      return bot_loadout_choose_from_statstable(var_01, var_02, var_03, self.botarchetype, self.personality, self.difficulty);

    if(var_09 == "camotable")
      return bot_loadout_choose_from_camotable(var_01, var_02, var_03, self.personality, self.difficulty);

    if(getsubstr(var_09, 0, 5) == "class" && int(getsubstr(var_09, 5, 6)) > 0)
      var_09 = bot_loadout_choose_from_default_class(var_09, var_01, var_02, var_03, self.personality, self.difficulty);

    if(isdefined(level.bot_perktable) && getsubstr(var_09, 0, 10) == "perktable_")
      return bot_loadout_choose_from_perktable(var_09, var_01, var_02, var_03, self.personality, self.difficulty);

    if(bot_loadout_valid_choice(var_01, var_02, var_03, var_09)) {
      var_07 = var_07 + 1.0;

      if(randomfloat(1.0) <= 1.0 / var_07) {
        var_05 = var_09;
        var_06 = var_10;
      }
    }
  }

  if(isdefined(var_06))
    self.chosentemplates[var_06] = 1;

  return var_05;
}

bot_loadout_choose_values(var_00) {
  self.chosentemplates = [];

  foreach(var_06, var_02 in var_00) {
    var_03 = strtok(var_02, "| ");
    var_04 = bot_loadout_choose_from_set(var_03, var_02, var_00, var_06);
    var_0[var_06] = var_04;
  }

  return var_00;
}

bot_loadout_get_difficulty() {
  var_00 = "regular";
  var_00 = self botgetdifficulty();

  if(var_00 == "default") {
    scripts\mp\bots\bots_util::bot_set_difficulty("default");
    var_00 = self botgetdifficulty();
  }

  return var_00;
}

bot_loadout_get_archetype() {
  if(!isdefined(self.botarchetype)) {
    var_00 = self botgetpersonality();
    var_01 = level.botarchetypes[var_00];
    var_02 = randomint(var_1.size);
    self.botarchetype = var_1[var_02];
  }

  return self.botarchetype;
}

bot_loadout_class_callback() {
  while (!isdefined(level.bot_loadouts_initialized))
    wait 0.05;

  while (!isdefined(self.personality))
    wait 0.05;

  var_00 = [];
  var_01 = bot_loadout_get_difficulty();
  self.difficulty = var_01;
  var_02 = self botgetpersonality();
  var_03 = bot_loadout_get_archetype();

  if(isdefined(self.botlastloadout)) {
    var_04 = self.botlastloadoutdifficulty == var_01;
    var_05 = self.botlastloadoutpersonality == var_02;

    if(var_04 && var_05 && (!isdefined(self.hasdied) || self.hasdied) && !isdefined(self.respawn_with_launcher))
      return self.botlastloadout;
  }

  var_00 = bot_loadout_pick(var_03, var_02, var_01);
  var_00 = bot_loadout_choose_values(var_00);

  if(isdefined(level.bot_funcs["gametype_loadout_modify"]))
    var_00 = self[[level.bot_funcs["gametype_loadout_modify"]]](var_00);

  if(var_0["loadoutPrimary"] == "none") {
    self.bot_fallback_personality = undefined;
    var_0["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_00);
    var_0["loadoutPrimaryCamo"] = "none";
    var_0["loadoutPrimaryAttachment"] = "none";
    var_0["loadoutPrimaryAttachment2"] = "none";
    var_0["loadoutPrimaryAttachment3"] = "none";
    var_0["loadoutPrimaryReticle"] = "none";

    if(isdefined(self.bot_fallback_personality)) {
      if(self.bot_fallback_personality == "weapon")
        bot_pick_personality_from_weapon(var_0["loadoutPrimary"]);
      else
        scripts\mp\bots\bots_util::bot_set_personality(self.bot_fallback_personality);

      var_02 = self.personality;
      self.bot_fallback_personality = undefined;
    }
  }

  self.botlastloadout = var_00;
  self.botlastloadoutdifficulty = var_01;
  self.botlastloadoutpersonality = var_02;

  if(isdefined(var_0["loadoutPrimaryCamo"]) && var_0["loadoutPrimaryCamo"] != "none")
    self.botloadoutfavoritecamo = var_0["loadoutPrimaryCamo"];

  if(isdefined(self.respawn_with_launcher)) {
    if(isdefined(level.bot_respawn_launcher_name) && bot_loadout_item_allowed("weapon", level.bot_respawn_launcher_name)) {
      var_0["loadoutSecondary"] = level.bot_respawn_launcher_name;
      var_0["loadoutSecondaryAttachment"] = "none";
      var_0["loadoutSecondaryAttachment2"] = "none";
      self.botlastloadout = undefined;
    }

    self.respawn_with_launcher = undefined;
  }

  var_00 = bot_loadout_setup_perks(var_00);

  if(scripts\mp\utility\game::bot_israndom()) {
    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries")) {
      var_06 = bot_loadout_pick("cqb", var_01);
      var_0["loadoutSecondary"] = var_6["loadoutPrimary"];
      var_0["loadoutSecondaryAttachment"] = var_6["loadoutPrimaryAttachment"];
      var_0["loadoutSecondaryAttachment2"] = var_6["loadoutPrimaryAttachment2"];
      var_00 = bot_loadout_choose_values(var_00);
      var_00 = bot_loadout_setup_perks(var_00);
    }

    if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_extra_attachment")) {
      var_07 = bot_loadout_pick(var_02, var_01);
      var_0["loadoutPrimaryAttachment3"] = var_7["loadoutPrimaryAttachment2"];

      if(scripts\engine\utility::array_contains(self.pers["loadoutPerks"], "specialty_twoprimaries"))
        var_0["loadoutSecondaryAttachment2"] = var_7["loadoutPrimaryAttachment2"];
      else
        var_0["loadoutSecondaryAttachment2"] = var_7["loadoutSecondaryAttachment2"];

      var_00 = bot_loadout_choose_values(var_00);
      var_00 = bot_loadout_setup_perks(var_00);
    } else {
      var_0["loadoutSecondaryAttachment2"] = "none";

      if(!bot_validate_reticle("loadoutSecondary", var_00, var_0["loadoutSecondaryReticle"]))
        var_0["loadoutSecondaryReticle"] = "none";
    }
  }

  return var_00;
}

bot_loadout_setup_perks(var_00) {
  self.pers["loadoutPerks"] = [];
  self.pers["specialistBonusStreaks"] = [];
  self.pers["specialistStreaks"] = [];
  self.pers["specialistStreakKills"] = [];
  var_01 = 0;
  var_02 = isdefined(var_0["loadoutStreakType"]) && var_0["loadoutStreakType"] == "streaktype_specialist";

  if(var_02) {
    var_0["loadoutStreak1"] = "none";
    var_0["loadoutStreak2"] = "none";
    var_0["loadoutStreak3"] = "none";
  }

  foreach(var_08, var_04 in var_00) {
    if(var_04 == "specialty_null" || var_04 == "none") {
      continue;
    }
    if(getsubstr(var_08, 0, 11) == "loadoutPerk") {
      var_05 = int(getsubstr(var_08, 11));

      if(!var_02 && var_05 > 12) {
        continue;
      }
      var_06 = scripts\mp\utility\game::getbaseperkname(var_04);

      if(var_05 <= 12)
        self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_06;
      else if(var_05 <= 15) {
        var_0["loadoutStreak" + (var_01 + 1)] = var_06 + "_ks";
        self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_06 + "_ks";
        var_07 = 0;

        if(var_01 > 0)
          var_07 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];

        self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_07 + bot_perk_cost(var_06) + 2;
        var_1++;
      } else
        self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_06;
    }
  }

  if(var_02 && !isdefined(self.pers["specialistStreakKills"][0])) {
    self.pers["specialistStreakKills"][0] = 0;
    self.pers["specialistStreaks"][0] = "specialty_null";
  }

  if(var_02 && !isdefined(self.pers["specialistStreakKills"][1])) {
    self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
    self.pers["specialistStreaks"][1] = "specialty_null";
  }

  if(var_02 && !isdefined(self.pers["specialistStreakKills"][2])) {
    self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
    self.pers["specialistStreaks"][2] = "specialty_null";
  }

  return var_00;
}

bot_setup_loadout_callback() {
  var_00 = bot_loadout_get_archetype();
  var_01 = self botgetpersonality();
  var_02 = bot_loadout_get_difficulty();
  var_03 = bot_loadout_set(var_00, var_01, var_02, 0);

  if(isdefined(var_03) && isdefined(var_3.loadouts) && var_3.loadouts.size > 0) {
    self.classcallback = ::bot_loadout_class_callback;
    return 1;
  }

  var_04 = getsubstr(self.name, 0, self.name.size - 10);
  self.classcallback = undefined;
  return 0;
}

bot_squad_lookup_private(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isdefined(var_06))
    return var_00 getrankedplayerdata("privateloadouts", "squadMembers", "loadouts", var_02, var_03, var_04, var_05, var_06);
  else if(isdefined(var_05))
    return var_00 getrankedplayerdata("privateloadouts", "squadMembers", "loadouts", var_02, var_03, var_04, var_05);
  else if(isdefined(var_04))
    return var_00 getrankedplayerdata("privateloadouts", "squadMembers", "loadouts", var_02, var_03, var_04);
  else
    return var_00 getrankedplayerdata("privateloadouts", "squadMembers", "loadouts", var_02, var_03);
}

bot_squad_lookup_ranked(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isdefined(var_06))
    return var_00 getrankedplayerdata("rankedloadouts", "squadMembers", "loadouts", var_02, var_03, var_04, var_05, var_06);
  else if(isdefined(var_05))
    return var_00 getrankedplayerdata("rankedloadouts", "squadMembers", "loadouts", var_02, var_03, var_04, var_05);
  else if(isdefined(var_04))
    return var_00 getrankedplayerdata("rankedloadouts", "squadMembers", "loadouts", var_02, var_03, var_04);
  else
    return var_00 getrankedplayerdata("rankedloadouts", "squadMembers", "loadouts", var_02, var_03);
}

bot_squad_lookup_enemy(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(isdefined(var_06))
    return getenemysquaddata("squadMembers", "loadouts", var_02, var_03, var_04, var_05, var_06);
  else if(isdefined(var_05))
    return getenemysquaddata("squadMembers", "loadouts", var_02, var_03, var_04, var_05);
  else if(isdefined(var_04))
    return getenemysquaddata("squadMembers", "loadouts", var_02, var_03, var_04);
  else
    return getenemysquaddata("squadMembers", "loadouts", var_02, var_03);
}

bot_squad_lookup(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = ::bot_squad_lookup_ranked;

  if(getdvar("squad_match") == "1" && self.team == "axis")
    var_07 = ::bot_squad_lookup_enemy;
  else if(!scripts\mp\utility\game::matchmakinggame())
    var_07 = ::bot_squad_lookup_private;

  return self[[var_07]](var_00, var_01, var_02, var_03, var_04, var_05, var_06);
}

bot_squadmember_lookup(var_00, var_01, var_02) {
  if(getdvar("squad_match") == "1" && self.team == "axis")
    return getenemysquaddata("squadMembers", var_01, var_02);
  else if(!scripts\mp\utility\game::matchmakinggame())
    return var_00 getrankedplayerdata("privateloadouts", "squadMembers", var_02);
  else
    return var_00 getrankedplayerdata("rankedloadouts", "squadMembers", var_02);
}

bot_loadout_copy_from_client(var_00, var_01, var_02, var_03) {
  var_0["loadoutPrimary"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 0, "weapon");
  var_0["loadoutPrimaryAttachment"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 0, "attachment", 0);
  var_0["loadoutPrimaryAttachment2"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 0, "attachment", 1);
  var_0["loadoutPrimaryAttachment3"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 0, "attachment", 2);
  var_0["loadoutPrimaryCamo"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 0, "camo");
  var_0["loadoutPrimaryReticle"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 0, "reticle");
  var_0["loadoutSecondary"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 1, "weapon");
  var_0["loadoutSecondaryAttachment"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 1, "attachment", 0);
  var_0["loadoutSecondaryAttachment2"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 1, "attachment", 1);
  var_0["loadoutSecondaryCamo"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 1, "camo");
  var_0["loadoutSecondaryReticle"] = bot_squad_lookup(var_01, var_02, var_03, "weaponSetups", 1, "reticle");
  var_0["loadoutPowerPrimary"] = bot_squad_lookup(var_01, var_02, var_03, "perks", 0);
  var_0["loadoutPowerSecondary"] = bot_squad_lookup(var_01, var_02, var_03, "perks", 1);
  var_0["loadoutStreak1"] = "none";
  var_0["loadoutStreak2"] = "none";
  var_0["loadoutStreak3"] = "none";
  var_04 = bot_squad_lookup(var_01, var_02, var_03, "perks", 5);

  if(isdefined(var_04)) {
    var_0["loadoutStreakType"] = var_04;

    if(var_04 == "streaktype_assault") {
      var_0["loadoutStreak1"] = bot_squad_lookup(var_01, var_02, var_03, "assaultStreaks", 0);
      var_0["loadoutStreak2"] = bot_squad_lookup(var_01, var_02, var_03, "assaultStreaks", 1);
      var_0["loadoutStreak3"] = bot_squad_lookup(var_01, var_02, var_03, "assaultStreaks", 2);
    } else if(var_04 == "streaktype_support") {
      var_0["loadoutStreak1"] = bot_squad_lookup(var_01, var_02, var_03, "supportStreaks", 0);
      var_0["loadoutStreak2"] = bot_squad_lookup(var_01, var_02, var_03, "supportStreaks", 1);
      var_0["loadoutStreak3"] = bot_squad_lookup(var_01, var_02, var_03, "supportStreaks", 2);
    } else if(var_04 == "streaktype_specialist") {
      var_0["loadoutPerk13"] = bot_squad_lookup(var_01, var_02, var_03, "specialistStreaks", 0);
      var_0["loadoutPerk14"] = bot_squad_lookup(var_01, var_02, var_03, "specialistStreaks", 1);
      var_0["loadoutPerk15"] = bot_squad_lookup(var_01, var_02, var_03, "specialistStreaks", 2);
    }
  }

  var_0["loadoutCharacterType"] = bot_squad_lookup(var_01, var_02, var_03, "type");
  bot_pick_personality_from_weapon(var_0["loadoutPrimary"]);
  self.playercardpatch = bot_squadmember_lookup(var_01, var_02, "patch");
  self.playercardbackground = bot_squadmember_lookup(var_01, var_02, "background");
  return var_00;
}

bot_loadout_make_index(var_00, var_01, var_02) {
  return var_00 + "_" + var_01 + "_" + var_02;
}