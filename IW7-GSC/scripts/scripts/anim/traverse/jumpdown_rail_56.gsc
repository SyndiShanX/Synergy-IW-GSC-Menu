/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\jumpdown_rail_56.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 109 ms
 * Timestamp: 10\26\2023 11:59:34 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(self.type == "dog")
	{
		scripts\anim\traverse\shared::func_5867(7,0.7);
		return;
	}

	func_91D4();
}

//Function Number: 2
func_91D4()
{
	var_00 = [];
	var_00["traverseAnim"] = %traverse_jumpdown_rail_56;
	if(getdvarint("ai_iw7",0) == 0)
	{
		scripts\anim\traverse\shared::func_5AC3(var_00);
		return;
	}

	self waittill("killanimscript");
}