/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_hero_gator.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 135 ms
 * Timestamp: 10\26\2023 11:58:13 PM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_17DB = "";
	self.team = "allies";
	self.type = "human";
	self.unittype = "soldier";
	self.subclass = "crew";
	self.accuracy = 0.2;
	self.health = 150;
	self.objective_team = "frag";
	self.objective_state = 0;
	self.secondaryweapon = "";
	self.var_101B4 = lib_0A2F::func_7BEC("pistol");
	self.behaviortreeasset = "enemy_combatant";
	self.var_1FA9 = "soldier";
	if(isai(self))
	{
		self _meth_82DC(256,0);
		self _meth_82DB(768,1024);
	}

	self.var_394 = lib_0A2F::func_7BEC("rifle");
	lib_08ED::main();
}

//Function Number: 2
spawner()
{
	self _meth_833A("allies");
}

//Function Number: 3
precache()
{
	lib_08ED::precache();
	scripts\aitypes\bt_util::init();
	lib_09FD::soldier();
	lib_03AE::func_DEE8();
	lib_0C69::func_2371();
	precacheitem("frag");
}