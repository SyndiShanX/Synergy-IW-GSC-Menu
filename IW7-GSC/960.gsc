/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 960.gsc
************************/

main() {
  self setmodel("body_civ_facility_worker_lt");
  self attach("head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage", "", 1);
  self.headmodel = "head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage";
  self.hatmodel = "head_bg_engineering_mate_hair_a_brown";
  self attach(self.hatmodel);
  self.var_1FEC = "generic_human";
  self.var_1FA8 = "civilian";
  self.voice = "unitednations";
  self give_explosive_touch_on_revived("cloth");
  if(issentient(self)) {
    self sethitlocdamagetable("locdmgtable\ai_lochit_dmgtable");
  }

  self glinton(#animtree);
}

precache() {
  precachemodel("body_civ_facility_worker_lt");
  precachemodel("head_bg_var_head_bg_engineering_mate_head_male_bc_02_blast_damage");
  precachemodel("head_bg_engineering_mate_hair_a_brown");
}