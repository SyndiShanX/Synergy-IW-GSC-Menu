/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2645.gsc
***************************************/

init() {
  scripts\engine\utility::struct_class_init();
  func_F6BD();
  func_F6BA();
  scripts\cp\utility::func_F305();
  setupcallbacks();
  scripts\cp\utility::initgameflags();
  scripts\cp\utility::initlevelflags();
  func_FAAB();
  func_F6BB();
  func_F6BF();
  func_F6BC();
  func_AE18();
  func_10958();
  func_97F7();
  setupexploders();
  func_9817();
  func_988B();
  scripts\common\fx::initfx();
  scripts\mp\callbacksetup::setupdamageflags();
  scripts\cp\cp_movers::init();
  scripts\cp\func_0A53::main();
  scripts\cp\cp_merits::buildmeritinfo();
  scripts\cp\cp_gamelogic::init();
  scripts\cp\cp_laststand::init_laststand();

  if(func_100BC())
    level thread func_132A3();

  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.mapcenter = findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

findboxcenter(var_00, var_01) {
  var_02 = (0, 0, 0);
  var_02 = var_01 - var_00;
  var_02 = (var_2[0] / 2, var_2[1] / 2, var_2[2] / 2) + var_00;
  return var_02;
}

func_F6BD() {
  level.func_1307 = 1;
  level.splitscreen = _issplitscreen();
  level.onlinegame = getdvarint("onlinegame");
  level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch") || getdvarint("force_ranking");
  level.script = tolower(getdvar("mapname"));
  level.gametype = tolower(getdvar("ui_gametype"));
  level.teamnamelist = ["axis", "allies"];
  level.otherteam["allies"] = "axis";
  level.otherteam["axis"] = "allies";
  level.multiteambased = 0;
  level.teambased = 1;
  level.objectivebased = 0;
  level.func = [];
  level.createfx_enabled = getdvar("createfx") != "";
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.hardcoremode = 0;
  level.func_C22E = 0;
  level.reclaimedreservedobjectives = [];
}

func_F6BA() {
  setdvar("ui_inhostmigration", 0);
  setdvar("camera_thirdPerson", getdvarint("scr_thirdPerson"));
  setdvar("sm_sunShadowScale", 1);
  setdvar("r_specularcolorscale", 2.5);
  setdvar("r_diffusecolorscale", 1);
  setdvar("r_lightGridEnableTweaks", 0);
  setdvar("r_lightGridIntensity", 1);
  setdvar("bg_compassShowEnemies", getdvar("scr_game_forceuav"));
  setdvar("isMatchMakingGame", scripts\cp\utility::matchmakinggame());
  setdvar("ui_overtime", 0);
  setdvar("ui_allow_teamchange", 1);
  setdvar("g_deadChat", 1);
  setdvar("min_wait_for_players", 5);
  setdvar("ui_friendlyfire", 0);
  setdvar("cg_drawFriendlyHUDGrenades", 0);
  setdvar("cg_drawCrosshair", scripts\engine\utility::ter_op(level.hardcoremode == 1, 0, 1));
  setdvar("cg_drawCrosshairNames", 1);
  setdvar("cg_drawFriendlyNamesAlways", 0);
}

setupcallbacks() {
  level.callbackstartgametype = ::func_4631;
  level.callbackplayerconnect = ::func_5043;
  level.callbackplayerdisconnect = ::func_5045;
  level.callbackplayerdamage = ::func_5044;
  level.callbackplayerkilled = ::func_5046;
  level.callbackplayermigrated = ::func_5049;
  level.callbackhostmigration = ::func_503E;
  level.getspawnpoint = ::defaultgetspawnpoint;
  level.onspawnplayer = ::blank;
  level.onprecachegametype = ::blank;
  level.onstartgametype = ::blank;
  level.func_D3D5 = ::func_5048;
  level.initagentscriptvariables = scripts\cp\cp_agent_utils::initagentscriptvariables;
  level.setagentteam = scripts\cp\cp_agent_utils::set_agent_team;
  level.agentvalidateattacker = scripts\cp\cp_agent_utils::validateattacker;
  level.agentfunc = scripts\cp\cp_agent_utils::agentfunc;
  level.getfreeagent = scripts\cp\cp_agent_utils::getfreeagent;
  level.addtocharactersarray = scripts\cp\cp_agent_utils::addtocharactersarray;
  level.callbackplayerlaststand = scripts\cp\cp_laststand::callback_defaultplayerlaststand;
  level.endgame = scripts\cp\cp_gamelogic::endgame;
  level.func_72BF = scripts\cp\cp_gamelogic::func_72BF;
}

func_AE18() {
  level._effect["slide_dust"] = loadfx("vfx\core\screen\vfx_scrnfx_tocam_slidedust_m");
}

func_5044(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {}

func_5046(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08) {}

func_FAAB() {
  var_00 = ["trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage"];

  foreach(var_02 in var_00) {
    var_03 = getentarray(var_02, "classname");

    for (var_04 = 0; var_04 < var_3.size; var_4++) {
      if(isdefined(var_3[var_04].script_prefab_exploder))
        var_3[var_04].targetname = var_3[var_04].script_prefab_exploder;

      if(isdefined(var_3[var_04].targetname))
        level thread exploder_load(var_3[var_04]);
    }
  }
}

func_10958() {
  level thread trackgrenades();
  level thread trackmissiles();
  level thread trackcarepackages();
}

trackgrenades() {
  for (;;) {
    level.grenades = getentarray("grenade", "classname");
    scripts\engine\utility::waitframe();
  }
}

trackmissiles() {
  for (;;) {
    level.missiles = getentarray("rocket", "classname");
    scripts\engine\utility::waitframe();
  }
}

trackcarepackages() {
  for (;;) {
    level.carepackages = getentarray("care_package", "targetname");
    scripts\engine\utility::waitframe();
  }
}

func_5048() {
  if(scripts\engine\utility::is_true(self.keep_perks)) {
    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough"))
      return 200;
    else
      return 100;
  } else
    return 100;
}

func_F6BB() {
  game["thermal_vision"] = "thermal_mp";
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["clientid"] = 0;
  game["roundsPlayed"] = 0;
  game["state"] = "playing";
  game["status"] = "normal";
  game["roundsWon"] = [];
}

func_F6BF() {
  visionsetnaked("", 0);
  visionsetnight("default_night_mp");
  visionsetmissilecam("missilecam");
  visionsetthermal(game["thermal_vision"]);
  visionsetpain("", 0);
}

func_F6BC() {
  setnojipscore(0);
  setnojiptime(0);
}

defaultgetspawnpoint() {
  return getassignedspawnpoint(scripts\engine\utility::getstructarray("default_player_start", "targetname"));
}

getassignedspawnpoint(var_00) {
  var_01 = self getentitynumber();

  if(var_01 == 4)
    var_01 = 1;

  return var_0[var_01];
}

func_5038() {
  level.gameended = 1;
  setomnvar("allow_server_pause", 0);
  level notify("game_ended", "allies");
  scripts\engine\utility::waitframe();
  exitlevel(0);
}

func_4631() {
  [
    [level.onprecachegametype]
  ]();
  func_E256();
  func_E255();
  scripts\cp\perks\perkmachines::func_98B1();
  scripts\cp\perks\prestige::initprestige();
  scripts\cp\cp_weaponrank::init();
  scripts\cp\cp_weaponpassives::init();
  thread scripts\cp\powers\coop_powers::init();
  scripts\cp\cp_merits::init();
  thread scripts\cp\contracts_coop::init();
  level thread func_E896();
  level thread _meth_8489();
  level thread func_10D9F();
  game["gamestarted"] = 1;
}

func_E256() {
  level.teamcount["allies"] = 0;
  level.teamcount["axis"] = 0;
  level.teamcount["spectator"] = 0;
  level.hasspawned["allies"] = 0;
  level.hasspawned["axis"] = 0;
  level.fauxvehiclecount = 0;
  level.gameended = 0;
  level.func_72B3 = 0;
  level.hostforcedend = 0;
  level._meth_8487 = 10;
  level.ingraceperiod = level._meth_8487;
  level.noragdollents = getentarray("noragdoll", "targetname");
  level.friendlyfire = 0;
  level.starttime = gettime();
}

func_E255() {
  level.players = [];
  level.participants = [];
  level.characters = [];
  level.helis = [];
  level.turrets = [];
  level.func_935F = [];
  level.ugvs = [];
  level.balldrones = [];
}

func_E896() {
  level notify("coop_pre_match");
  level endon("game_ended");
  level endon("coop_pre_match");
  scripts\cp\utility::gameflaginit("prematch_done", 0);
  setomnvar("ui_prematch_period", 1);

  if(isdefined(level.prematchfunc))
    [[level.prematchfunc]]();

  scripts\cp\utility::gameflagset("prematch_done");
  setomnvar("ui_prematch_period", 0);
}

_meth_8489() {
  level notify("coop_grace_period");
  level endon("game_ended");
  level endon("coop_grace_period");

  while (getactiveclientcount() == 0)
    scripts\engine\utility::waitframe();

  while (level.ingraceperiod > 0) {
    wait 1.0;
    level.ingraceperiod--;
  }

  level.ingraceperiod = 0;
}

func_10D9F() {
  [
    [level.onstartgametype]
  ]();
}

func_100BC() {
  return !level.console && (getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server");
}

func_132A3() {
  for (;;) {
    if(level.rankedmatch)
      exitlevel(0);

    if(!getdvarint("xblive_privatematch"))
      exitlevel(0);

    if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server")
      exitlevel(0);

    wait 5;
  }
}

func_5043() {
  self endon("disconnect");
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  self.statusicon = "";
  var_00 = gettime();
  level notify("connected", self);
  game["clientid"]++;
  func_98BC();
  func_F7F0();
  initclientdvars();
  setupsavedactionslots();
  func_98B9();
  func_988E();
  scripts\cp\perks\prestige::initplayerprestige();
  scripts\cp\perks\perk_utility::func_95C1();
  self.no_team_outlines = 0;
  self.no_outline = 0;

  if(scripts\cp\utility::coop_mode_has("outline"))
    thread scripts\cp\cp_outline::playeroutlinemonitor();

  thread scripts\cp\cp_vo::func_97CC();
  thread scripts\cp\cp_merits::updatemerits();

  if(self ishost())
    level.player = self;

  if(!level.teambased)
    game["roundsWon"][self.guid] = 0;

  waittillframeend;
  func_1810(self);

  if(game["state"] == "postgame") {
    self.connectedpostgame = 1;
    self setclientdvars("cg_drawSpectatorMessages", 0);
    spawnintermission();
    return;
  }

  if(isai(self) && isdefined(level.bot_funcs) && isdefined(level.bot_funcs["think"]))
    self thread[[level.bot_funcs["think"]]]();

  level endon("game_ended");

  if(isdefined(level.hostmigrationtimer))
    thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

  if(isdefined(level.onplayerconnectaudioinit))
    [[level.onplayerconnectaudioinit]]();

  if(!isai(self))
    func_D3D9();

  spawnplayer();
}

func_D3D9() {
  thread func_102EC();
  thread func_72C1();
}

func_F7F0() {
  self.guid = scripts\cp\utility::getuniqueid();
  self.clientid = game["clientid"];
  self.usingonlinedataoffline = self isusingonlinedataoffline();
  self.connected = 1;
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.movespeedscaler = 1;
  self.objectivescaler = 1;
  self.inlaststand = 0;
}

initclientdvars() {
  initclientdvarssplitscreenspecific();
  self setclientdvars("cg_drawSpectatorMessages", 1, "cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0, "ui_altscene", 0);

  if(level.teambased)
    self setclientdvar("cg_everyonehearseveryone", 0);
}

initclientdvarssplitscreenspecific() {
  if(level.splitscreen || self issplitscreenplayer()) {
    self setclientdvars("cg_fovscale", "0.75");
    setdvar("r_materialBloomHQScriptMasterEnable", 0);
  } else
    self setclientdvars("cg_fovscale", "1");
}

setupsavedactionslots() {
  self.saved_actionslotdata = [];

  for (var_00 = 1; var_00 <= 4; var_0++) {
    self.saved_actionslotdata[var_00] = spawnstruct();
    self.saved_actionslotdata[var_00].type = "";
    self.saved_actionslotdata[var_00].item = undefined;
  }

  if(!level.console) {
    for (var_00 = 5; var_00 <= 8; var_0++) {
      self.saved_actionslotdata[var_00] = spawnstruct();
      self.saved_actionslotdata[var_00].type = "";
      self.saved_actionslotdata[var_00].item = undefined;
    }
  }
}

func_98B9() {
  self.perks = [];
  self.perksperkname = [];
}

func_102EC() {
  self endon("disconnect");

  for (;;) {
    self waittill("sprint_slide_begin");
    self _meth_8241(level._effect["slide_dust"], self geteye());
  }
}

func_72C1() {
  self endon("disconnect");
  level endon("game_ended");

  for (;;) {
    self waittill("luinotifyserver", var_00, var_01);

    if(var_00 == "arcade_off")
      self notify("adjustedStance");

    if(var_00 == "end_game") {
      level thread[[level.func_72BF]]();
      self notify("disconnect");
    }
  }
}

spawnintermission(var_00) {
  func_F726();
  var_01 = self.forcespawnangles;
  spawnplayer();
  self setclientdvar("cg_everyoneHearsEveryone", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(level.console)
    self setclientdvar("cg_fov", "90");

  scripts\cp\utility::updatesessionstate("intermission");
}

func_F726() {
  var_00 = func_7ED8();
  func_F717(var_0.origin, var_0.angles);
}

func_F717(var_00, var_01) {
  self.forcespawnorigin = var_00;
  self.forcespawnangles = var_01;
}

func_7ED8() {
  var_00 = getentarray("mp_global_intermission", "classname");
  return var_0[0];
}

spawnplayer(var_00) {
  thread func_108F4(var_00);
}

func_108F4(var_00) {
  self endon("disconnect");
  self endon("joined_spectators");
  level endon("game_ended");

  if(self.waitingtospawn) {
    return;
  }
  func_136E9();
  func_108F3(var_00);
}

func_136E9() {
  self.waitingtospawn = 1;

  if(scripts\cp\utility::isusingremote())
    self waittill("stopped_using_remote");

  self.waitingtospawn = 0;
}

func_108F3(var_00) {
  self notify("spawned");
  self notify("started_spawnPlayer");

  if(level.gameended)
    self spawn(getspawnorigin(self, 1), _meth_8132(self));
  else
    self spawn(getspawnorigin(self), _meth_8132(self));

  func_E262();
  func_E261();
  func_E263();
  resetplayerdamagemodifiers();
  var_00 = scripts\engine\utility::ter_op(isdefined(var_00), var_00, 0);

  if(!var_00)
    func_C07F();

  if(isai(self))
    func_10828(var_00);

  [
    [level.onspawnplayer]
  ]();

  if(!scripts\engine\utility::flag("introscreen_over"))
    scripts\cp\utility::freezecontrolswrapper(1);

  self[[level.custom_giveloadout]](var_00);

  if(getdvarint("camera_thirdPerson"))
    scripts\cp\utility::setthirdpersondof(1);

  if(func_1001B())
    scripts\cp\utility::freezecontrolswrapper(1);

  waittillframeend;
  self notify("spawned_player");
  level notify("player_spawned", self);
}

func_E262() {
  self setclientomnvar("ui_options_menu", 0);
  self setclientomnvar("ui_hud_shake", 0);
}

func_E261() {
  self stopshellshock();
  self stoprumble("damage_heavy");
  self setdepthoffield(0, 0, 512, 512, 4, 0);

  if(level.console)
    self setclientdvar("cg_fov", "65");
}

resetplayerdamagemodifiers() {
  if(isdefined(self.additivedamagemodifiers)) {
    var_00 = getarraykeys(self.additivedamagemodifiers);

    foreach(var_02 in var_00)
    scripts\cp\utility::removedamagemodifier(var_02, 1);
  }

  if(isdefined(self.multiplicativedamagemodifiers)) {
    var_00 = getarraykeys(self.multiplicativedamagemodifiers);

    foreach(var_02 in var_00)
    scripts\cp\utility::removedamagemodifier(var_02, 0);
  }
}

func_E263() {
  var_00 = getnearestnode();
  self.team = var_00;
  self.sessionteam = var_00;
  self.pers["team"] = var_00;
  self.fauxdeath = undefined;
  self.movespeedscaler = 1;
  self.disabledweapon = 0;
  self.disabledoffhandweapons = 0;
  self.hasriotshieldequipped = 0;
  self.hasriotshield = 0;
}

getnearestnode() {
  if(isdefined(level.func_D425))
    return [
      [level.func_D425]
    ](self);

  return "allies";
}

func_C07F() {
  func_E25B();
  scripts\cp\utility::updatesessionstate("playing");
}

func_E25B() {
  self.maxhealth = self[[level.func_D3D5]]();
  self.health = self.maxhealth;
  self.avoidkillstreakonspawntimer = 5.0;
  self.friendlydamage = undefined;
  self.hasspawned = 1;
  self.spawntime = gettime();
  self.objectivescaler = 1;
}

func_10828(var_00) {
  scripts\cp\utility::freezecontrolswrapper(1);

  if(!var_00) {
    if(isdefined(level.bot_funcs) && isdefined(level.bot_funcs["player_spawned"]))
      self[[level.bot_funcs["player_spawned"]]]();
  }
}

getspawnorigin(var_00, var_01) {
  var_02 = undefined;

  if(isdefined(var_0.forcespawnorigin)) {
    var_02 = var_0.forcespawnorigin;
    var_02 = getclosestpointonnavmesh(var_02);

    if(isdefined(var_01))
      var_02 = var_0.forcespawnorigin;

    var_0.forcespawnorigin = undefined;
  } else {
    var_03 = var_00[[level.getspawnpoint]]();
    var_02 = getclosestpointonnavmesh(var_3.origin);

    if(isdefined(var_01))
      var_02 = var_03;

    if(level.script == "cp_disco")
      var_02 = var_3.origin;
  }

  return var_02;
}

_meth_8132(var_00) {
  var_01 = undefined;

  if(isdefined(var_0.forcespawnangles)) {
    var_01 = var_0.forcespawnangles;
    var_0.forcespawnangles = undefined;
  } else {
    var_02 = var_00[[level.getspawnpoint]]();
    var_01 = scripts\engine\utility::ter_op(isdefined(var_2.angles), var_2.angles, (0, 0, 0));
  }

  return var_01;
}

func_1001B() {
  if(game["state"] == "postgame")
    return 1;

  return 0;
}

enterspectator() {
  var_00 = func_7ED8();
  self setspectatedefaults(var_0.origin, var_0.angles);
  func_F717(var_0.origin, var_0.angles);
  func_F858();
  scripts\cp\utility::updatesessionstate("spectator");
}

func_F858() {
  if(isdefined(level.func_10979))
    [[level.func_10979]](self);
  else
    func_504C(self);
}

func_504C(var_00) {
  var_00 allowspectateteam("allies", 1);
  var_00 allowspectateteam("axis", 1);
  var_00 allowspectateteam("freelook", 0);
  var_00 allowspectateteam("none", 1);
}

func_5045(var_00) {
  if(!isdefined(self.connected)) {
    return;
  }
  scripts\cp\cp_analytics::on_player_disconnect(var_00);
  func_E15A(self);

  if(func_563B())
    level thread[[level.func_72BF]]();

  if(isdefined(level.onplayerdisconnected))
    level thread[[level.onplayerdisconnected]](self, var_00);
}

func_563B() {
  if(level.splitscreen)
    return level.players.size <= 1;

  var_00 = 0;

  foreach(var_02 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_02))
      var_00 = scripts\cp\cp_laststand::gameshouldend(var_02);
  }

  return var_00;
}

func_1810(var_00) {
  level.players[level.players.size] = var_00;
  level.participants[level.participants.size] = var_00;
  level.characters[level.characters.size] = var_00;
}

func_E15A(var_00) {
  level.players = scripts\engine\utility::array_remove(level.players, var_00);
  level.participants = scripts\engine\utility::array_remove(level.participants, var_00);
  level.characters = scripts\engine\utility::array_remove(level.characters, var_00);
}

func_5049() {
  if(self ishost())
    initclientdvarssplitscreenspecific();

  if(func_9E39(self)) {
    var_00 = 0;

    foreach(var_02 in level.players) {
      if(func_9E39(var_02))
        var_0++;
    }

    level.hostmigrationreturnedplayercount++;

    if(level.hostmigrationreturnedplayercount >= var_00 * 2 / 3)
      level notify("hostmigration_enoughplayers");
  }
}

func_9E39(var_00) {
  return !isdefined(var_0.pers["isBot"]) || var_0.pers["isBot"] == 0;
}

func_503E() {
  if(level.gameended) {
    return;
  }
  if(isdefined(level.func_C53D))
    level thread[[level.func_C53D]]();

  level.hostmigrationreturnedplayercount = 0;

  foreach(var_01 in level.characters)
  var_1.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setdvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");

  foreach(var_01 in level.characters) {
    if(isdefined(var_01))
      var_01 thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();

    if(isplayer(var_01))
      var_01 setclientomnvar("ui_session_state", var_1.sessionstate);
  }

  setdvar("ui_game_state", game["state"]);
  level endon("host_migration_begin");
  scripts\cp\cp_hostmigration::hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setdvar("ui_inhostmigration", 0);

  if(isdefined(level.hostmigrationend))
    level thread[[level.hostmigrationend]]();

  level notify("host_migration_end");
}

func_97F7() {
  var_00 = getentarray("destructable", "targetname");

  if(getdvar("scr_destructables") == "0") {
    for (var_01 = 0; var_01 < var_0.size; var_1++)
      var_0[var_01] delete();
  } else {
    for (var_01 = 0; var_01 < var_0.size; var_1++)
      var_0[var_01] thread destructable_think();
  }
}

destructable_think() {
  var_00 = 40;
  var_01 = 0;

  if(isdefined(self.script_accumulate))
    var_00 = self.script_accumulate;

  if(isdefined(self.script_threshold))
    var_01 = self.script_threshold;

  if(isdefined(self.script_fxid))
    self.fx = loadfx(self.script_fxid);

  var_02 = 0;
  self setcandamage(1);

  for (;;) {
    self waittill("damage", var_03, var_04);

    if(var_03 >= var_01) {
      var_02 = var_02 + var_03;

      if(var_02 >= var_00) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  var_00 = self;

  if(isdefined(var_0.fx))
    playfx(var_0.fx, var_0.origin + (0, 0, 6));

  var_00 delete();
}

setupexploders() {
  var_00 = getentarray("script_brushmodel", "classname");
  var_01 = getentarray("script_model", "classname");

  for (var_02 = 0; var_02 < var_1.size; var_2++)
    var_0[var_0.size] = var_1[var_02];

  for (var_02 = 0; var_02 < var_0.size; var_2++) {
    if(isdefined(var_0[var_02].script_prefab_exploder))
      var_0[var_02].targetname = var_0[var_02].script_prefab_exploder;

    if(isdefined(var_0[var_02].targetname)) {
      if(var_0[var_02].model == "fx" && (!isdefined(var_0[var_02].targetname) || var_0[var_02].targetname != "exploderchunk")) {
        var_0[var_02] hide();
        continue;
      }

      if(isdefined(var_0[var_02].targetname) && var_0[var_02].targetname == "exploder") {
        var_0[var_02] hide();
        var_0[var_02] notsolid();
        continue;
      }

      if(isdefined(var_0[var_02].targetname) && var_0[var_02].targetname == "exploderchunk") {
        var_0[var_02] hide();
        var_0[var_02] notsolid();
      }
    }
  }

  var_03 = [];
  var_04 = getentarray("script_brushmodel", "classname");

  for (var_02 = 0; var_02 < var_4.size; var_2++) {
    if(isdefined(var_4[var_02].script_prefab_exploder))
      var_4[var_02].targetname = var_4[var_02].script_prefab_exploder;

    if(isdefined(var_4[var_02].targetname))
      var_3[var_3.size] = var_4[var_02];
  }

  var_04 = getentarray("script_model", "classname");

  for (var_02 = 0; var_02 < var_4.size; var_2++) {
    if(isdefined(var_4[var_02].script_prefab_exploder))
      var_4[var_02].targetname = var_4[var_02].script_prefab_exploder;

    if(isdefined(var_4[var_02].targetname))
      var_3[var_3.size] = var_4[var_02];
  }

  var_04 = getentarray("item_health", "classname");

  for (var_02 = 0; var_02 < var_4.size; var_2++) {
    if(isdefined(var_4[var_02].script_prefab_exploder))
      var_4[var_02].targetname = var_4[var_02].script_prefab_exploder;

    if(isdefined(var_4[var_02].targetname))
      var_3[var_3.size] = var_4[var_02];
  }

  if(!isdefined(level.createfxent))
    level.createfxent = [];

  var_05 = [];
  var_5["exploderchunk visible"] = 1;
  var_5["exploderchunk"] = 1;
  var_5["exploder"] = 1;

  for (var_02 = 0; var_02 < var_3.size; var_2++) {
    var_06 = var_3[var_02];
    var_07 = scripts\engine\utility::createexploder(var_6.script_fxid);
    var_7.v = [];
    var_7.v["origin"] = var_6.origin;
    var_7.v["angles"] = var_6.angles;
    var_7.v["delay"] = var_6.script_delay;
    var_7.v["firefx"] = var_6.script_firefx;
    var_7.v["firefxdelay"] = var_6.script_firefxdelay;
    var_7.v["firefxsound"] = var_6.script_firefxsound;
    var_7.v["firefxtimeout"] = var_6.func_ED96;
    var_7.v["earthquake"] = var_6.script_earthquake;
    var_7.v["damage"] = var_6.script_damage;
    var_7.v["damage_radius"] = var_6.script_radius;
    var_7.v["soundalias"] = var_6.script_soundalias;
    var_7.v["repeat"] = var_6.script_repeat;
    var_7.v["delay_min"] = var_6.script_delay_min;
    var_7.v["delay_max"] = var_6.script_delay_max;
    var_7.v["target"] = var_6.target;
    var_7.v["ender"] = var_6.script_ender;
    var_7.v["type"] = "exploder";

    if(!isdefined(var_6.script_fxid))
      var_7.v["fxid"] = "No FX";
    else
      var_7.v["fxid"] = var_6.script_fxid;

    var_7.v["exploder"] = var_6.targetname;

    if(!isdefined(var_7.v["delay"]))
      var_7.v["delay"] = 0;

    if(isdefined(var_6.target)) {
      var_08 = getent(var_7.v["target"], "targetname").origin;
      var_7.v["angles"] = vectortoangles(var_08 - var_7.v["origin"]);
    }

    if(var_6.classname == "script_brushmodel" || isdefined(var_6.model)) {
      var_7.model = var_06;
      var_7.model.disconnect_paths = var_6.script_disconnectpaths;
    }

    if(isdefined(var_6.targetname) && isdefined(var_5[var_6.targetname]))
      var_7.v["exploder_type"] = var_6.targetname;
    else
      var_7.v["exploder_type"] = "normal";

    var_07 scripts\common\createfx::post_entity_creation_function();
  }
}

func_9817() {
  level.uiparent = spawnstruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.func_912F["allies"] = spawnstruct();
  level.func_912F["axis"] = spawnstruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 1.2;
  level.func_115E4 = 32;
  level.func_115E1 = 14;
  level.func_115E3 = 192;
  level.func_115E2 = 8;
  level.func_115E0 = 1.65;
  level.lowertextyalign = "BOTTOM";
  level.lowertexty = -140;
  level.lowertextfontsize = 1.2;
}

exploder_load(var_00) {
  level endon("killexplodertridgers" + var_0.targetname);
  var_00 waittill("trigger");

  if(isdefined(var_0.script_chance) && randomfloat(1) > var_0.script_chance) {
    if(isdefined(var_0.script_delay))
      wait(var_0.script_delay);
    else
      wait 4;

    level thread exploder_load(var_00);
    return;
  }

  scripts\engine\utility::exploder(var_0.targetname);
  level notify("killexplodertridgers" + var_0.targetname);
}

player_init_health_regen() {
  self.regenspeed = 1;
}

player_init_invulnerability() {
  self.haveinvulnerabilityavailable = 1;
}

player_init_damageshield() {
  self.damageshieldexpiretime = gettime();
}

blank(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09) {}

func_98BC() {
  self setrankedplayerdata("cp", "alienSession", "team_shots", 0);
  self setrankedplayerdata("cp", "alienSession", "team_kills", 0);
  self setrankedplayerdata("cp", "alienSession", "team_hives", 0);
  self setrankedplayerdata("cp", "alienSession", "downed", 0);
  self setrankedplayerdata("cp", "alienSession", "hivesDestroyed", 0);
  self setrankedplayerdata("cp", "alienSession", "prestigenerfs", 0);
  self setrankedplayerdata("cp", "alienSession", "repairs", 0);
  self setrankedplayerdata("cp", "alienSession", "drillPlants", 0);
  self setrankedplayerdata("cp", "alienSession", "deployables", 0);
  self setrankedplayerdata("cp", "alienSession", "challengesCompleted", 0);
  self setrankedplayerdata("cp", "alienSession", "challengesAttempted", 0);
  self setrankedplayerdata("cp", "alienSession", "trapKills", 0);
  self setrankedplayerdata("cp", "alienSession", "currencyTotal", 0);
  self setrankedplayerdata("cp", "alienSession", "currencySpent", 0);
  self setrankedplayerdata("cp", "alienSession", "kills", 0);
  self setrankedplayerdata("cp", "alienSession", "revives", 0);
  self setrankedplayerdata("cp", "alienSession", "time", 0);
  self setrankedplayerdata("cp", "alienSession", "score", 0);
  self setrankedplayerdata("cp", "alienSession", "shots", 0);
  self setrankedplayerdata("cp", "alienSession", "last_stand_count", 0);
  self setrankedplayerdata("cp", "alienSession", "deaths", 0);
  self setrankedplayerdata("cp", "alienSession", "headShots", 0);
  self setrankedplayerdata("cp", "alienSession", "hits", 0);
  self setrankedplayerdata("cp", "alienSession", "resources", 0);
  self setrankedplayerdata("cp", "alienSession", "waveNum", 0);
}

func_988E() {
  if(isdefined(level.func_D0FE))
    [[level.func_D0FE]]();
  else
    scripts\cp\cp_laststand::default_player_init_laststand();
}

func_988B() {
  level.func_A6CB = scripts\engine\utility::getstructarray("respawn_edge", "targetname");
}

func_7F56() {
  return scripts\engine\utility::getclosest(self.origin, level.func_A6CB);
}