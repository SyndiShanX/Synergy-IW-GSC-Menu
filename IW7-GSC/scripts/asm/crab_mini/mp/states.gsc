/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\crab_mini\mp\states.gsc
***********************************************/

func_2371() {
	if(scripts\asm\asm::func_232E("crab_mini")) {
		return;
	}

	scripts\asm\asm::func_230B("crab_mini","start_here");
	scripts\asm\asm::func_2374("start_here",::scripts\asm\crab_mini\crab_mini_asm::asminit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("entrance",undefined,::scripts\asm\crab_mini\crab_mini_asm::shouldplayentranceanim,undefined);
	scripts\asm\asm::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	scripts\asm\asm::func_2375("turn",undefined,::scripts\asm\crab_mini\crab_mini_asm::shouldturn,undefined);
	scripts\asm\asm::func_2375("choose_movetype",undefined,::trans_idle_to_choose_movetype1,undefined);
	scripts\asm\asm::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("entrance",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("decide_idle",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("stand_melee",undefined,::scripts\asm\crab_mini\crab_mini_asm::shoulddoaction,undefined);
	scripts\asm\asm::func_2375("moving_melee",undefined,::scripts\asm\crab_mini\crab_mini_asm::shoulddoaction,undefined);
	scripts\asm\asm::func_2374("stand_melee",::scripts\asm\crab_mini\crab_mini_asm::playmeleeattack,undefined,::scripts\asm\crab_mini\crab_mini_asm::meleenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	scripts\asm\asm::func_2375("action_done",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	scripts\asm\asm::func_2374("death_moving",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	scripts\asm\asm::func_2374("check_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("idle_exit_sprint",undefined,::trans_check_move_to_idle_exit_sprint0,undefined);
	scripts\asm\asm::func_2375("pass_run_in",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("idle_exit_sprint",::scripts\asm\zombie\zombie::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("pass_walk_in",undefined,::scripts\asm\asm::func_68B0,"code_move");
	scripts\asm\asm::func_2375("pass_walk_in",undefined,::scripts\asm\asm::func_68B0,"finish");
	scripts\asm\asm::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("pass_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2375("sprint_loop",undefined,::trans_pass_walk_in_to_sprint_loop1,undefined);
	scripts\asm\asm::func_2374("sprint_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2375("pass_walk_in",undefined,::scripts\asm\asm::func_68B0,"code_move");
	scripts\asm\asm::func_2375("pass_walk_in",undefined,::scripts\asm\asm::func_68B0,"end");
	scripts\asm\asm::func_2374("sprint_loop",::scripts\asm\zombie\zombie::func_D4E3,"walk",undefined,undefined,undefined,::scripts\asm\zombie\zombie::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	scripts\asm\asm::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("pass_sprint_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("sprint_stop",undefined,::scripts\asm\zombie\zombie::func_10092,undefined);
	scripts\asm\asm::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"walk_turn");
	scripts\asm\asm::func_2375("move_done",undefined,::trans_pass_sprint_out_to_move_done2,undefined);
	scripts\asm\asm::func_2374("sprint_stop",::scripts\asm\zombie\zombie::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2375("pass_walk_in",undefined,::scripts\asm\asm::func_68B0,"abort");
	scripts\asm\asm::func_2375("move_done",undefined,::scripts\asm\asm::func_68B0,"end");
	scripts\asm\asm::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("check_move",undefined,::trans_choose_movetype_to_check_move0,undefined);
	scripts\asm\asm::func_2375("move_done",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2375("idle_exit_run",undefined,::trans_pass_run_in_to_idle_exit_run1,undefined);
	scripts\asm\asm::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2375("run_loop",undefined,::scripts\asm\asm::func_68B0,"code_move");
	scripts\asm\asm::func_2375("run_loop",undefined,::scripts\asm\asm::func_68B0,"end");
	scripts\asm\asm::func_2374("run_loop",::scripts\asm\zombie\zombie::func_D4E3,"run",undefined,undefined,undefined,::scripts\asm\zombie\zombie::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	scripts\asm\asm::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("run_stop",::scripts\asm\zombie\zombie::func_D4E3,"run",undefined,undefined,undefined,::scripts\asm\zombie\zombie::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	scripts\asm\asm::func_2375("move_done",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("run_stop",undefined,::scripts\asm\zombie\zombie::func_10092,undefined);
	scripts\asm\asm::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	scripts\asm\asm::func_2374("idle_exit_run",::scripts\asm\zombie\zombie::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("run_loop",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("check_move_interruptions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_mini\crab_mini_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2375("idle",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("pain_moving",::scripts\asm\crab_mini\crab_mini_asm::playmovingpainanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	scripts\asm\asm::func_2375("pain_moving_done",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("check_interruptables",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("stand_melee",undefined,::scripts\asm\crab_mini\crab_mini_asm::shoulddoaction,undefined);
	scripts\asm\asm::func_2374("traverse_external",::scripts\asm\crab_mini\crab_mini_asm::doteleporthack,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2374("moving_melee",::scripts\asm\crab_mini\crab_mini_asm::playmovingmeleeattack,undefined,::scripts\asm\crab_mini\crab_mini_asm::movingmeleenotehandler,::scripts\asm\crab_mini\crab_mini_asm::terminate_movingmelee,undefined,::scripts\asm\crab_mini\crab_mini_asm::choosemeleeattack,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	scripts\asm\asm::func_2375("moving_melee_done",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("moving_melee_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("stuck_loop",0.05,::scripts\asm\crab_mini\crab_mini_asm::shoulddostuckanim,undefined);
	scripts\asm\asm::func_2375("action_done",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("stuck_loop",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_mini\crab_mini_asm::choosestuckanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	scripts\asm\asm::func_2375("stuck_exit",undefined,::scripts\asm\crab_mini\crab_mini_asm::isstuckdone,undefined);
	scripts\asm\asm::func_2374("stuck_exit",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_mini\crab_mini_asm::choosestuckanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	scripts\asm\asm::func_2375("action_done",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("pain_moving_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	scripts\asm\asm::func_2375("choose_movetype",undefined,::trans_pain_moving_done_to_choose_movetype0,undefined);
	scripts\asm\asm::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	scripts\asm\asm::func_2374("turn",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_mini\crab_mini_asm::choosecrabminiturnanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	scripts\asm\asm::func_2375("idle",undefined,::scripts\asm\crab_mini\crab_mini_asm::isanimdone,undefined);
	scripts\asm\asm::func_2374("jump_across",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_across_100",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("over_40_down_56",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("over_40_down_128",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_up_56_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_up_128_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("wall_over_40_flex",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("over_88",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"over_88",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("step_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("mantle_40_over_extended",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"mantle_40_over_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("wall_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_up_56",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_up_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_up_128",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_down_56",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_down_128",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2374("jump_down_56_out_50",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::scripts\asm\zombie\zombie::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scripts\asm\asm::func_2327();
}

trans_idle_to_choose_movetype1(param_00,param_01,param_02,param_03) {
	return scripts\asm\asm_bb::bb_moverequested();
}

trans_check_move_to_idle_exit_sprint0(param_00,param_01,param_02,param_03) {
	return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

trans_pass_walk_in_to_sprint_loop1(param_00,param_01,param_02,param_03) {
	return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_out_to_move_done2(param_00,param_01,param_02,param_03) {
	return !scripts\asm\asm_bb::bb_moverequested();
}

trans_choose_movetype_to_check_move0(param_00,param_01,param_02,param_03) {
	return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_in_to_idle_exit_run1(param_00,param_01,param_02,param_03) {
	return scripts\asm\asm_bb::bb_moverequested();
}

trans_pain_moving_done_to_choose_movetype0(param_00,param_01,param_02,param_03) {
	return scripts\asm\asm_bb::bb_moverequested();
}