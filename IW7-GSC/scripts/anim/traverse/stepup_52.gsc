/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\scripts\anim\traverse\stepup_52.gsc
*******************************************************/

main() {
	if(self.type == "dog") {
		scripts\anim\traverse\shared::func_5868(52,5);
		return;
	}

	func_B0CC();
}

func_B0CC() {
	var_00 = [];
	var_00["traverseAnim"] = func_7814();
	if(getdvarint("ai_iw7",0) == 0) {
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}

func_7814() {
	return %traverse_stepup_52;
}