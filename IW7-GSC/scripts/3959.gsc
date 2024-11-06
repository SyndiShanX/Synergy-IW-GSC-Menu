/****************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\3959.gsc
****************************/

zombie_clown_init() {
	registerscriptedagent();
	if(!isdefined(level.cop_spawn_percent)) {
		level.cop_spawn_percent = 2;
	}

	level.agent_funcs["zombie_clown"]["on_damaged"] = ::scripts/cp/agents/gametype_zombie::onzombiedamaged;
	level.agent_funcs["zombie_clown"]["gametype_on_damage_finished"] = ::scripts/cp/agents/gametype_zombie::onzombiedamagefinished;
	level.agent_funcs["zombie_clown"]["gametype_on_killed"] = ::scripts/cp/agents/gametype_zombie::onzombiekilled;
	level.movemodefunc["zombie_clown"] = ::scripts/cp/agents/gametype_zombie::run_if_last_zombie;
}

registerscriptedagent() {
	scripts/aitypes/bt_util::init();
	func_AEB0();
	thread func_FAB0();
}

func_FAB0() {
	level endon("game_ended");
	if(!isdefined(level.agent_definition)) {
		level waittill("scripted_agents_initialized");
	}

	level.agent_definition["zombie_clown"]["setup_func"] = ::setupagent;
	level.agent_definition["zombie_clown"]["setup_model_func"] = ::func_FACE;
	level.agent_funcs["zombie_clown"]["on_damaged_finished"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiedamagefinished;
	level.agent_funcs["zombie_clown"]["on_killed"] = ::scripts\mp\agents\zombie\zmb_zombie_agent::onzombiekilled;
	if(!isdefined(level.var_8CBD)) {
		level.var_8CBD = [];
	}

	level.var_8CBD["zombie_clown"] = ::func_3725;
}

setupagent() {
	scripts\mp\agents\zombie\zmb_zombie_agent::setupagent();
	self.entered_playspace = 1;
	self.is_suicide_bomber = 1;
	self.nocorpse = 1;
	self.allowpain = 0;
	if(isdefined(level.suicider_avoidance_radius)) {
		self setavoidanceradius(level.suicider_avoidance_radius);
	}
}

func_899C() {
	self endon("death");
	level waittill("game_ended");
	self clearpath();
	foreach(var_04, var_01 in self.var_164D) {
		var_02 = var_01.var_4BC0;
		var_03 = level.asm[var_04].states[var_02];
		scripts/asm/asm::func_2388(var_04,var_02,var_03,var_03.var_116FB);
		scripts/asm/asm::func_238A(var_04,"idle",0.2,undefined,undefined,undefined);
	}
}

func_FACE(param_00) {
	var_01 = ["park_clown_zombie","park_clown_zombie_blue","park_clown_zombie_green","park_clown_zombie_orange","park_clown_zombie_yellow"];
	self setmodel(scripts\engine\utility::random(var_01));
}

func_AEB0() {}

func_3725() {
	var_00 = 200;
	switch(level.specialroundcounter) {
		case 0:
			var_00 = 100;
			break;

		case 1:
			var_00 = 400;
			break;

		case 2:
			var_00 = 900;
			break;

		case 3:
			var_00 = 1300;
			break;

		default:
			var_00 = 1600;
			break;
	}

	return var_00;
}