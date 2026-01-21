#include scripts\sp\hud_util;

init() {
	executeCommand("sv_cheats 1");

	precacheshader("ui_scrollbar_arrow_right");

	level thread player_connect();
	level thread create_rainbow_color();

	wait 0.5;
}

initial_variables() {
	self.in_menu = false;
	self.hud_created = false;
	self.loaded_offset = false;
	self.option_limit = 7;
	self.current_menu = "Synergy";
	self.structure = [];
	self.previous = [];
	self.saved_index = [];
	self.saved_offset = [];
	self.saved_trigger = [];
	self.slider = [];

	self.font = "default";
	self.font_scale = 0.7;
	self.x_offset = 175;
	self.y_offset = 160;

	self.color_theme = "rainbow";
	self.menu_color_red = 0;
	self.menu_color_green = 0;
	self.menu_color_blue = 0;

	self.cursor_index = 0;
	self.scrolling_offset = 0;
	self.previous_scrolling_offset = 0;
	self.description_height = 0;
	self.previous_option = undefined;

	self.syn["weapons"]["category"] = ["Assault Rifles", "Light Machine Guns", "Sniper Rifles", "Sub Machine Guns", "Shotguns", "Pistols", "Heavies"];

	// Weapon IDs Plus Default Attachments
	self.syn["weapons"]["assault_rifles"][0] =     ["iw7_ake", "iw7_m4", "iw7_ar57", "iw7_sdfar", "iw7_fmg+akimbofmg_sp+fmgscope"];
	self.syn["weapons"]["light_machine_guns"][0] = ["iw7_mauler", "iw7_lmg03+lmg03scope", "iw7_sdflmg"];
	self.syn["weapons"]["sniper_rifles"][0] =      ["iw7_kbs+kbsscope", "iw7_m8+m8scope_sp"];
	self.syn["weapons"]["sub_machine_guns"][0] =   ["iw7_crb+crblscope", "iw7_ump45+ump45lscope", "iw7_fhr", "iw7_erad+eradscope+shotgunerad_sp", "iw7_ripper+ripperrscope_sp"];
	self.syn["weapons"]["shotguns"][0] =           ["iw7_devastator", "iw7_sdfshotty+sdfshottyscope", "iw7_sonic+sonicscope"];
	self.syn["weapons"]["pistols"][0] =            ["iw7_nrg", "iw7_emc", "iw7_g18"];
	self.syn["weapons"]["heavies"][0] =            ["iw7_penetrationrail+penetrationrailscope_sp", "iw7_chargeshot+chargeshotscope", "iw7_lockon+lockonscope", "iw7_steeldragon", "iw7_atomizer+atomizerscope", "defaultweapon"];
	// Weapon Names
	self.syn["weapons"]["assault_rifles"][1] =     ["Volk", "NV4", "KBAR-32", "R3K", "Type-2"];
	self.syn["weapons"]["light_machine_guns"][1] = ["Mauler", "Titan", "R.A.W."];
	self.syn["weapons"]["sniper_rifles"][1] =      ["KBS Longbow", "EBR-800"];
	self.syn["weapons"]["sub_machine_guns"][1] =   ["Karma-45", "HVR", "FHR-40", "Erad", "RPR Evo"];
	self.syn["weapons"]["shotguns"][1] =           ["Reaver", "DCM-8", "Banshee"];
	self.syn["weapons"]["pistols"][1] =            ["Oni", "EMC", "Kendall 44"];
	self.syn["weapons"]["heavies"][1] =            ["Ballista EM3", "P-Law", "Spartan SA3", "F-SpAr Torch", "Eraser", "Default Weapon"];

	self.syn["weapons"]["attachable_weapons"] = ["iw7_sdfar", "iw7_ake", "iw7_aker", "iw7_fmg", "iw7_m4", "iw7_ar57", "iw7_ripper", "iw7_fhr", "iw7_erad", "iw7_ump45l", "iw7_ump45", "iw7_crbl", "iw7_crb", "iw7_sdflmg", "iw7_mauler", "iw7_lmg03", "iw7_kbs", "iw7_m8", "iw7_devastator", "iw7_sdfshotty", "iw7_sonic", "iw7_g18r", "iw7_g18", "iw7_nrg", "iw7_emc"];

	self.syn["weapons"]["sights"] = ["acog", "acogake", "acogarnoalt", "acogkbs", "acoglmg", "acoglmgnoalt", "acogm4", "acogm8", "acogsmg", "acogsmgnoalt", "ar57scope", "crblscope", "elo", "eloake", "elofmg", "elokbs", "elolmg", "elom8", "elonrg", "elopstl", "elopstle", "eloshtgn", "elosmg", "eradscope", "fmgscope", "hybrid", "hybridake", "hybridarnoalt", "hybridgmg", "hybridlmg", "hybridsmg", "hybridsmgnoalt", "kbsoscope", "kbsscope", "kbsvzscope", "m8scope_sp", "oscope", "phase_sp", "phaseake_sp", "phasefmg_sp", "phaselmg_sp", "phasenrg_sp", "phasepstl_sp", "phaseshotgun_sp", "phasesmg_sp", "reflex", "reflexake", "reflexfmg", "reflexlmg", "reflexnrg", "reflexpstl", "reflexshotgun", "reflexsmg", "ripperrscope_sp", "sdfshottyscope", "smart", "sonicscope", "thermal", "thermalake", "thermalfmg", "thermalkbs", "thermallmg", "thermalm4", "thermalm8", "thermalsmg", "ump45lscope", "vzscope"];

	self.syn["weapons"]["attachments"]["iw7_ake"][0] = ["acogake", "reflexake", "phaseake_sp", "thermalake", "hybridake", "eloake", "silencere", "barrelrangee", "gripake", "reflect", "rofar", "xmagse", "epicake"];
	self.syn["weapons"]["attachments"]["iw7_ake"][1] = ["Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Particle Amp", "Foregrip", "Ram Servo", "Slide Rail", "Fusion Mag", "Volk Marksman"];

	self.syn["weapons"]["attachments"]["iw7_m4"][0] = ["acogm4", "reflex", "phase_sp", "thermalm4", "hybrid", "elo", "fastaim", "silencer", "barrelrange", "gripm4", "rofar", "xmags", "epicm4"];
	self.syn["weapons"]["attachments"]["iw7_m4"][1] = ["Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Quickdraw", "Suppressor", "Rifled Barrel", "Foregrip", "Slide Rail", "Extended Mag", "Tracker Rounds"];

	self.syn["weapons"]["attachments"]["iw7_ar57"][0] = ["ar57scope", "acog", "reflex", "phase_sp", "thermal", "hybrid", "elo", "silencer", "barrelrange", "gripar57", "rofar", "xmags", "epicar57"];
	self.syn["weapons"]["attachments"]["iw7_ar57"][1] = ["Default Sight","Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Rifled Barrel", "Foregrip", "Slide Rail", "Extended Mag", "High-Impact Rounds"];

	self.syn["weapons"]["attachments"]["iw7_fmg"][0] = ["fmgscope", "acogarnoalt", "reflexfmg", "phasefmg_sp", "thermalfmg", "hybridarnoalt", "elofmg", "silencerefmg", "barrelrangee", "gripfmg", "reflect", "roffmg", "xmagse", "epicfmg"];
	self.syn["weapons"]["attachments"]["iw7_fmg"][1] = ["Default Sight", "Scout", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor",  "Particle Amp", "Foregrip", "Ram Servo", "Slide Rail", "Fusion Mag", "Akimbo Shotguns"];

	self.syn["weapons"]["attachments"]["iw7_sdfar"][0] = ["acog", "reflex", "phase_sp", "thermal", "hybrid", "elo", "silencere", "barrelrangesdfar", "gripsdfar", "reflext", "rofburst", "xmagse", "epicsdfar"];
	self.syn["weapons"]["attachments"]["iw7_sdfar"][1] = ["Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Particle Amp", "Foregrip", "Ram Servo", "Slide Rail", "Fusion Mag", "Full-Auto"];

	self.syn["weapons"]["attachments"]["iw7_mauler"][0] = ["acoglmgnoalt", "reflexlmg", "phaselmg_sp", "thermallmg", "hybridlmg", "elolmg", "silencer", "barrelrange", "griphide", "roflmg", "xmags", "epicmauler"];
	self.syn["weapons"]["attachments"]["iw7_mauler"][1] = ["Scout", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Rifled Barrel", "Foregrip (Hidden)", "Slide Rail", "Extended Mag", "Heavy Mauler"];

	self.syn["weapons"]["attachments"]["iw7_lmg03"][0] = ["acoglmg", "reflexlmg", "phaselmg_sp", "thermallmg", "hybridlmg", "elolmg", "silencere", "barrelrangee", "grip", "reflect", "roflmg", "xmagselmg", "epiclmg03"];
	self.syn["weapons"]["attachments"]["iw7_lmg03"][1] = ["Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Particle Amp", "Foregrip", "Ram Servo", "Slide Rail", "Fusion Mag", "Overcharge"];

	self.syn["weapons"]["attachments"]["iw7_sdflmg"][0] = ["acoglmg", "reflexlmg", "phaselmg_sp", "thermallmg", "hybridlmg", "elolmg", "silencere", "barrelrangee", "grip", "reflect", "roflmg", "xmagselmg", "epicsdflmg"];
	self.syn["weapons"]["attachments"]["iw7_sdflmg"][1] = ["Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Particle Amp", "Foregrip", "Ram Servo", "Slide Rail", "Fusion Mag", "Compressor"];

	self.syn["weapons"]["attachments"]["iw7_kbs"][0] = ["kbsscope", "acogkbs", "thermalkbs", "elokbs", "kbsscope+kbsvzscope", "kbsoscope", "silencersniperhide", "gripsnpr", "cpu", "xmags", "epickbs"];
	self.syn["weapons"]["attachments"]["iw7_kbs"][1] = ["Default Scope", "Scout", "Thermal", "Elo", "Variable Zoom", "Tracking Chip", "Suppressor (Hidden)", "Foregrip", "Ballistic CPU", "Extended Mag", "Stasis"];

	self.syn["weapons"]["attachments"]["iw7_m8"][0] = ["m8scope_sp", "acogm8", "thermalm8", "elom8", "m8scope_sp+vzscope", "m8scope_sp+oscope", "silencersniperhidee", "gripsnpre", "cpu", "reflect", "xmagse", "epicm8"];
	self.syn["weapons"]["attachments"]["iw7_m8"][1] = ["Default Scope", "Scout", "Thermal", "Elo", "Variable Zoom", "Tracking Chip", "Suppressor (Hidden)", "Foregrip", "Ballistic CPU", "Ram Servo", "Fusion Mag", "Burst Snipe"];

	self.syn["weapons"]["attachments"]["iw7_crb"][0] = ["crblscope", "acogsmg", "reflexsmg", "phasesmg_sp", "thermalsmg", "hybridsmg", "elosmg", "silencersmg", "barrelrangesmg", "gripcrbl", "rof", "xmags", "epiccrb"];
	self.syn["weapons"]["attachments"]["iw7_crb"][1] = ["Default Sight", "Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Rifled Barrel", "Foregrip", "Slide Rail", "Extended Mag", "High-Cal Burst"];

	self.syn["weapons"]["attachments"]["iw7_ump45"][0] = ["ump45lscope", "acogsmg", "reflexsmg", "phasesmg_sp", "thermalsmg", "hybridgmg", "elosmg", "silencersmg", "barrelrangesmg", "gripump45l", "rof", "xmags", "epicump45"];
	self.syn["weapons"]["attachments"]["iw7_ump45"][1] = ["Default Sight", "Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Rifled Barrel", "Foregrip", "Slide Rail", "Extended Mag", "Akimbo"];

	self.syn["weapons"]["attachments"]["iw7_fhr"][0] = ["acogsmg", "reflexsmg", "phasesmg_sp", "thermalsmg", "hybridsmg", "elosmg", "silencersmg", "barrelrangesmg", "griphide", "rof", "xmags", "epicfhr"];
	self.syn["weapons"]["attachments"]["iw7_fhr"][1] = ["Scout Hybrid", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Rifled Barrel", "Foregrip (Hidden)", "Slide Rail", "Extended Mag", "FMJ Rounds"];

	self.syn["weapons"]["attachments"]["iw7_erad"][0] = ["eradscope", "acogsmgnoalt", "reflexsmg", "phasesmg_sp", "thermalsmg", "hybridsmgnoalt", "elosmg", "silencersmge", "barrelrangesmge", "griperad", "reflect", "rof", "xmagse", "epicerad+epicshotgunerad_sp"];
	self.syn["weapons"]["attachments"]["iw7_erad"][1] = ["Default Sight", "Scout", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Particle Amp", "Foregrip", "Ram Servo", "Slide Rail", "Fusion Mag", "Splitter"];

	self.syn["weapons"]["attachments"]["iw7_ripper"][0] = ["ripperrscope_sp", "acogsmgnoalt", "reflexsmg", "phasesmg_sp", "thermalsmg", "hybridsmgnoalt", "elosmg", "silencersmg", "barrelrangesmg", "gripripperr", "rof", "xmags", "epicripper"];
	self.syn["weapons"]["attachments"]["iw7_ripper"][1] = ["Default Sight", "Scout", "Reflex", "Trojan", "Thermal", "VMC", "Elo", "Suppressor", "Rifled Barrel", "Foregrip", "Slide Rail", "Extended Mag", "Burst-Fire"];

	self.syn["weapons"]["attachments"]["iw7_devastator"][0] = ["reflexshotgun", "phaseshotgun_sp", "eloshtgn", "smart", "silencershtgn", "barrelrangeshtgn", "gripdevastator", "xmags", "epicdevastator+epicdevastatorads"];
	self.syn["weapons"]["attachments"]["iw7_devastator"][1] = ["Reflex", "Trojan", "Elo", "Smart Shot", "Suppressor", "Rifled Barrel", "Foregrip", "Extended Mag", "Slug Shot"];

	self.syn["weapons"]["attachments"]["iw7_sdfshotty"][0] = ["sdfshottyscope", "reflexshotgun", "phaseshotgun_sp", "eloshtgn", "smart", "silencershtgne", "barrelrangeshtgne", "gripsdfshotty", "xmagseshtgn", "epicsdfshotty"];
	self.syn["weapons"]["attachments"]["iw7_sdfshotty"][1] = ["Default Sight", "Reflex", "Trojan", "Elo", "Smart Shot", "Suppressor", "Particle Amp", "Foregrip", "Fusion Mag", "Advanced DCM-8"];

	self.syn["weapons"]["attachments"]["iw7_sonic"][0] = ["sonicscope", "reflexshotgun", "phaseshotgun_sp", "eloshtgn", "smart", "silencershtgns", "barrelrangeshtgns_sp", "gripshtgn", "xmagseshtgnpump", "epicsonic"];
	self.syn["weapons"]["attachments"]["iw7_sonic"][1] = ["Reflex", "Trojan", "Elo", "Smart Shot", "Suppressor", "Speaker Amp", "Foregrip", "Fusion Mag", "C6 Stun"];

	self.syn["weapons"]["attachments"]["iw7_nrg"][0] = ["reflexnrg", "phasenrg_sp", "elonrg", "silencerpstle", "barrelrangepstle", "akimbonrg", "reflect", "xmagsepstle", "epicnrg"];
	self.syn["weapons"]["attachments"]["iw7_nrg"][1] = ["Reflex", "Trojan", "Elo", "Suppressor", "Particle Amp", "Akimbo", "Ram Servo", "Fusion Mag", "Energy Boost"];

	self.syn["weapons"]["attachments"]["iw7_emc"][0] = ["reflexpstl", "phasepstl_sp", "elopstle", "silencerpstle", "barrelrangepstle", "akimboemc", "reflect", "xmagspstl", "epicemc+epicemcads"];
	self.syn["weapons"]["attachments"]["iw7_emc"][1] = ["Reflex", "Trojan", "Elo", "Suppressor", "Particle Amp", "Akimbo", "Ram Servo", "Fusion Mag", "Spread Shot"];

	self.syn["weapons"]["attachments"]["iw7_g18"][0] = ["reflexpstl", "phasepstl_sp", "elopstl", "silencerpstl", "barrelrangepstl", "akimbog18", "xmags", "epicg18"];
	self.syn["weapons"]["attachments"]["iw7_g18"][1] = ["Reflex", "Trojan", "Elo", "Suppressor", "Rifled Barrel", "Akimbo", "Extended Mag", "Full Auto"];
}

initialize_menu() {
	level endon("game_ended");
	self endon("disconnect");

	for(;;) {
	if(!self.hud_created) {
		self freezeControls(false);

		self thread input_manager();

		self.syn["string"] = self create_text("", "default", 1, "center", "top", 0, -100, (1, 1, 1), 1, 9999, false, true);

		self.menu["border"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset - 1), (self.y_offset - 1), 226, 122, self.color_theme, 1, 1);
		self.menu["background"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, self.y_offset, 224, 121, (0.075, 0.075, 0.075), 1, 2);
		self.menu["separator_1"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 5.5), (self.y_offset + 7.5), 42, 1, self.color_theme, 1, 10);
		self.menu["separator_2"] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 220), (self.y_offset + 7.5), 42, 1, self.color_theme, 1, 10);
		self.menu["cursor"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, 215, 224, 16, (0.15, 0.15, 0.15), 0, 4);

		self.menu["title"] = self create_text("Title", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 94.5), (self.y_offset + 3), (1, 1, 1), 1, 10);
		self.menu["description"] = self create_text("Description", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 5), (self.y_offset + (self.option_limit * 17.5)), (0.75, 0.75, 0.75), 0, 10);

		for(i = 1; i <= self.option_limit; i++) {
			self.menu["toggle_" + i] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 11), ((self.y_offset + 4) + (i * 15)), 8, 8, (0.25, 0.25, 0.25), 0, 9);
			self.menu["slider_" + i] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset + (i * 15)), 224, 16, (0.25, 0.25, 0.25), 0, 5);
			self.menu["option_" + i] = self create_text("", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 5), ((self.y_offset + 4) + (i * 15)), (0.75, 0.75, 0.75), 1, 10);
			self.menu["slider_text_" + i] = self create_text("", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 132.5), ((self.y_offset + 4) + (i * 15)), (0.75, 0.75, 0.75), 0, 10);
			self.menu["submenu_icon_" + i] = self create_shader("ui_scrollbar_arrow_right", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 223), ((self.y_offset + 4) + (i * 15)), 7, 7, (0.5, 0.5, 0.5), 0, 10);
		}

		// Currently Disabled due to HUD Limit
		self.menu["foreground"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset + 15), 224, 106, (0.1, 0.1, 0.1), 1, 3);

		self.hud_created = true;

		self.menu["title"] set_text("Controls");
		self.menu["option_1"] set_text("Open: ^3ADS ^7and ^3Melee");
		self.menu["option_2"] set_text("Scroll: ^3ADS ^7and ^3Shoot");
		self.menu["option_3"] set_text("Select: ^3Interact ^7Back: ^3Melee");
		self.menu["option_4"] set_text("Sliders: ^3Heal^7 ^7and ^3Equipment");
		self.menu["option_5"].alpha = 0;
		self.menu["option_6"].alpha = 0;
		self.menu["option_7"].alpha = 0;

		self.menu["border"] set_shader("white", self.menu["border"].width, 78);
		self.menu["background"] set_shader("white", self.menu["background"].width, 76);
		self.menu["foreground"] set_shader("white", self.menu["foreground"].width, 61);

		self.controls_menu_open = true;

		wait 8;

		if(self.controls_menu_open) {
			close_controls_menu();
		}
	}
}
}

input_manager() {
	level endon("game_ended");
	self endon("disconnect");

	while(true) {
		if(!self.in_menu) {
			if(self adsButtonPressed() && self meleeButtonPressed()) {
				if(self.controls_menu_open) {
					close_controls_menu();
				}

				self playSound("armory_terminal_got_file", self);

				open_menu();

				while(self adsButtonPressed() && self meleeButtonPressed()) {
					wait 0.2;
				}
			}
		} else {
			if(self meleeButtonPressed()) {
				self.saved_index[self.current_menu] = self.cursor_index;
				self.saved_offset[self.current_menu] = self.scrolling_offset;
				self.saved_trigger[self.current_menu] = self.previous_trigger;

				self playSound("armory_terminal_finish", self);

				if(isDefined(self.previous[(self.previous.size - 1)])) {
					self new_menu();
				} else {
					self close_menu();
				}

				while(self meleeButtonPressed()) {
					wait 0.2;
				}
			} else if(self adsButtonPressed() && !self attackButtonPressed() || self attackButtonPressed() && !self adsButtonPressed()) {

				self playSound("plr_helmet_short_boot_up_lr", self);

				scroll_cursor(set_variable(self attackButtonPressed(), "down", "up"));

				wait (0.2);
			} else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || !self fragButtonPressed() && self secondaryOffhandButtonPressed()) {

				self playSound("armory_terminal_tick", self);

				if(isDefined(self.structure[self.cursor_index].array) || isDefined(self.structure[self.cursor_index].increment)) {
					scroll_slider(set_variable(self secondaryOffhandButtonPressed(), "left", "right"));
				}

				wait (0.2);
			} else if(self useButtonPressed()) {
				self.saved_index[self.current_menu] = self.cursor_index;
				self.saved_offset[self.current_menu] = self.scrolling_offset;
				self.saved_trigger[self.current_menu] = self.previous_trigger;

				self playSound("plr_helmet_visor_pull_up_w_air_lr", self);

				if(self.structure[self.cursor_index].command == ::new_menu) {
					self.previous_option = self.structure[self.cursor_index].text;
				}

				if(isDefined(self.structure[self.cursor_index].array) || isDefined(self.structure[self.cursor_index].increment)) {
					if(isDefined(self.structure[self.cursor_index].array)) {
						cursor_selected = self.structure[self.cursor_index].array[self.slider[(self.current_menu + "_" + self.cursor_index)]];
					} else {
						cursor_selected = self.slider[(self.current_menu + "_" + (self.cursor_index))];
					}
					self thread execute_function(self.structure[self.cursor_index].command, cursor_selected, self.structure[self.cursor_index].parameter_1, self.structure[self.cursor_index].parameter_2, self.structure[self.cursor_index].parameter_3);
				} else if(isDefined(self.structure[self.cursor_index]) && isDefined(self.structure[self.cursor_index].command)) {
					self thread execute_function(self.structure[self.cursor_index].command, self.structure[self.cursor_index].parameter_1, self.structure[self.cursor_index].parameter_2, self.structure[self.cursor_index].parameter_3);
				}

				self menu_option();
				set_options();

				while(self useButtonPressed()) {
					wait 0.2;
				}
			}
		}
		wait 0.05;
	}
}

player_connect() {
	level endon("game_ended");

	for(;;) {
		level waittill("can_save");

		player = level.player;
		player.access = "Host";

		player initial_variables();
		player thread initialize_menu();
	}
}

// Hud Functions

open_menu() {
	self.in_menu = true;

	set_menu_visibility(1);

	self menu_option();
	scroll_cursor();
	set_options();
}

close_menu() {
	set_menu_visibility(0);

	self.in_menu = false;
}

close_controls_menu() {
	self.menu["border"] set_shader("white", self.menu["border"].width, 123);
	self.menu["background"] set_shader("white", self.menu["background"].width, 121);
	self.menu["foreground"] set_shader("white", self.menu["foreground"].width, 106);

	self.controls_menu_open = false;

	set_menu_visibility(0);

	self.menu["title"] set_text("");
	self.menu["option_1"] set_text("");
	self.menu["option_2"] set_text("");
	self.menu["option_3"] set_text("");
	self.menu["option_4"] set_text("");

	self.in_menu = false;
}

set_menu_visibility(opacity) {
	if(opacity == 0) {
		self.menu["border"].alpha = opacity;
		self.menu["description"].alpha = opacity;
		for(i = 1; i <= self.option_limit; i++) {
			self.menu["toggle_" + i].alpha = opacity;
			self.menu["slider_" + i].alpha = opacity;
			self.menu["submenu_icon_" + i].alpha = opacity;
		}
	}

	self.menu["title"].alpha = opacity;
	self.menu["separator_1"].alpha = opacity;
	self.menu["separator_2"].alpha = opacity;

	for(i = 1; i <= self.option_limit; i++) {
		self.menu["option_" + i].alpha = opacity;
		self.menu["slider_text_" + i].alpha = opacity;
	}

	wait 0.05;

	self.menu["background"].alpha = opacity;
	self.menu["foreground"].alpha = opacity;
	self.menu["cursor"].alpha = opacity;

	if(opacity == 1) {
		self.menu["border"].alpha = opacity;
	}
}

create_text(text, font, font_scale, align_x, align_y, x_offset, y_offset, color, alpha, z_index, hide_when_in_menu) {
	textElement = self createFontString(font, font_scale);
	textElement setPoint(align_x, align_y, x_offset, y_offset);

	textElement.alpha = alpha;
	textElement.sort = z_index;
	textElement.anchor = self;
	textElement.archived = self auto_archive();

	if(isDefined(hide_when_in_menu)) {
		textElement.hideWhenInMenu = hide_when_in_menu;
	} else {
		textElement.hideWhenInMenu = true;
	}

	if(isDefined(color)) {
		if(!isString(color)) {
			textElement.color = color;
		} else if(color == "rainbow") {
			textElement.color = level.rainbow_color;
			textElement thread start_rainbow();
		}
	} else {
		textElement.color = (0, 1, 1);
	}

	if(isDefined(text)) {
		if(isNumber(text)) {
			textElement setValue(text);
		} else {
			textElement set_text(text);
		}
	}

	self.element_result++;
	return textElement;
}

create_shader(shader, align_x, align_y, x_offset, y_offset, width, height, color, alpha, z_index, hide_when_in_menu) {
	shaderElement = newClientHudElem(self);
	shaderElement.elemType = "icon";
	shaderElement.children = [];
	shaderElement.alpha = alpha;
	shaderElement.sort = z_index;
	shaderElement.anchor = self;
	shaderElement.archived = self auto_archive();

	if(isDefined(hide_when_in_menu)) {
		shaderElement.hideWhenInMenu = hide_when_in_menu;
	} else {
		shaderElement.hideWhenInMenu = true;
	}

	if(isDefined(color)) {
		if(!isString(color)) {
			shaderElement.color = color;
		} else if(color == "rainbow") {
			shaderElement.color = level.rainbow_color;
			shaderElement thread start_rainbow();
		}
	} else {
		shaderElement.color = (0, 1, 1);
	}

	shaderElement setParent(level.uiParent);
	shaderElement setPoint(align_x, align_y, x_offset, y_offset);

	shaderElement set_shader(shader, width, height);

	self.element_result++;
	return shaderElement;
}

set_text(text) {
	if(!isDefined(self) || !isDefined(text)) {
		return;
	}

	self.text = text;
	self setText(text);
}

set_shader(shader, width, height) {
	if(!isDefined(self)) {
		return;
	}

	if(!isDefined(shader)) {
		if(!isDefined(self.shader)) {
			return;
		}

		shader = self.shader;
	}

	if(!isDefined(width)) {
		if(!isDefined(self.width)) {
			return;
		}

		width = self.width;
	}

	if(!isDefined(height)) {
		if(!isDefined(self.height)) {
			return;
		}

		height = self.height;
	}

	self.shader = shader;
	self.width = width;
	self.height = height;
	self setShader(shader, width, height);
}

auto_archive() {
	if(!isDefined(self.element_result)) {
		self.element_result = 0;
	}

	if(!isAlive(self) || self.element_result > 27) {
		return true;
	}

	return false;
}

update_element_positions() {
	self.menu["border"].x = (self.x_offset - 1);
	self.menu["border"].y = (self.y_offset - 1);

	self.menu["background"].x = self.x_offset;
	self.menu["background"].y = self.y_offset;

	self.menu["foreground"].x = self.x_offset;
	self.menu["foreground"].y = (self.y_offset + 15);

	self.menu["separator_1"].x = (self.x_offset + 5);
	self.menu["separator_1"].y = (self.y_offset + 7.5);

	self.menu["separator_2"].x = (self.x_offset + 220);
	self.menu["separator_2"].y = (self.y_offset + 7.5);

	self.menu["cursor"].x = self.x_offset;

	self.menu["description"].y = (self.y_offset + (self.option_limit * 17.5));

	for(i = 1; i <= self.option_limit; i++) {
		self.menu["toggle_" + i].x = (self.x_offset + 11);
		self.menu["toggle_" + i].y = ((self.y_offset + 4) + (i * 15));

		self.menu["slider_" + i].x = self.x_offset;
		self.menu["slider_" + i].y = (self.y_offset + (i * 15));

		self.menu["option_" + i].y = ((self.y_offset + 4) + (i * 15));

		self.menu["slider_text_" + i].x = (self.x_offset + 132.5);
		self.menu["slider_text_" + i].y = ((self.y_offset + 4) + (i * 15));

		self.menu["submenu_icon_" + i].x = (self.x_offset + 223);
		self.menu["submenu_icon_" + i].y = ((self.y_offset + 4) + (i * 15));
	}
}

// Colors

create_rainbow_color() {
	x = 0; y = 0;
	r = 0; g = 0; b = 0;
	level.rainbow_color = (0, 0, 0);

	level endon("game_ended");

	while(true) {
		if(y >= 0 && y < 258) {
			r = 255;
			g = 0;
			b = x;
		} else if(y >= 258 && y < 516) {
			r = 255 - x;
			g = 0;
			b = 255;
		} else if(y >= 516 && y < 774) {
			r = 0;
			g = x;
			b = 255;
		} else if(y >= 774 && y < 1032) {
			r = 0;
			g = 255;
			b = 255 - x;
		} else if(y >= 1032 && y < 1290) {
			r = x;
			g = 255;
			b = 0;
		} else if(y >= 1290 && y < 1545) {
			r = 255;
			g = 255 - x;
			b = 0;
		}

		x += 3;
		if(x > 255) {
			x = 0;
		}

		y += 3;
		if(y > 1545) {
			y = 0;
		}

		level.rainbow_color = (r/255, g/255, b/255);
		wait 0.05;
	}
}

start_rainbow() {
	level endon("game_ended");
	self endon("stop_rainbow");
	self.rainbow_enabled = true;

	while(isDefined(self) && self.rainbow_enabled) {
		self fadeOverTime(.05);
		self.color = level.rainbow_color;
		wait 0.05;
	}
}

// Misc Functions

return_toggle(variable) {
	return isDefined(variable) && variable;
}

set_variable(check, option_1, option_2) {
	if(check) {
		return option_1;
	} else {
		return option_2;
	}
}

in_array(array, item) {
	if(!isDefined(array) || !isArray(array)) {
		return;
	}

	for(a = 0; a < array.size; a++) {
		if(array[a] == item) {
			return true;
		}
	}

	return false;
}

clean_name(name) {
	if(!isDefined(name) || name == "") {
		return;
	}

	illegal = ["^A", "^B", "^F", "^H", "^I", "^0", "^1", "^2", "^3", "^4", "^5", "^6", "^7", "^8", "^9", "^:"];
	new_string = "";
	for(a = 0; a < name.size; a++) {
		if(a < (name.size - 1)) {
			if(in_array(illegal, (name[a] + name[(a + 1)]))) {
				a += 2;
				if(a >= name.size) {
					break;
				}
			}
		}

		if(isDefined(name[a]) && a < name.size) {
			new_string += name[a];
		}
	}

	return new_string;
}

get_name() {
	name = self.name;
	if(name[0] != "[") {
		return name;
	}

	for(a = (name.size - 1); a >= 0; a--) {
		if(name[a] == "]") {
			break;
		}
	}

	return getSubStr(name, (a + 1));
}

load_weapons(weapon_category) {
	for(i = 0; i < self.syn["weapons"][weapon_category][0].size; i++) {
		self add_option(self.syn["weapons"][weapon_category][1][i], undefined, ::give_weapon, self.syn["weapons"][weapon_category][0][i], weapon_category, i);
	}
}

// Custom Structure

execute_function(command, parameter_1, parameter_2, parameter_3, parameter_4) {
	self endon("disconnect");

	if(!isDefined(command)) {
		return;
	}

	if(isDefined(parameter_4)) {
		return self thread[[command]](parameter_1, parameter_2, parameter_3, parameter_4);
	}

	if(isDefined(parameter_3)) {
		return self thread[[command]](parameter_1, parameter_2, parameter_3);
	}

	if(isDefined(parameter_2)) {
		return self thread[[command]](parameter_1, parameter_2);
	}

	if(isDefined(parameter_1)) {
		return self thread[[command]](parameter_1);
	}

	self thread[[command]]();
}

add_option(text, description, command, parameter_1, parameter_2, parameter_3) {
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = ::empty_function;
	} else {
		option.command = command;
	}
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}
	if(isDefined(parameter_3)) {
		option.parameter_3 = parameter_3;
	}

	self.structure[self.structure.size] = option;
}

add_toggle(text, description, command, variable, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = ::empty_function;
	} else {
		option.command = command;
	}
	option.toggle = isDefined(variable) && variable;
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}

	self.structure[self.structure.size] = option;
}

add_array(text, description, command, array, parameter_1, parameter_2, parameter_3) {
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = ::empty_function;
	} else {
		option.command = command;
	}
	if(!isDefined(command)) {
		option.array = [];
	} else {
		option.array = array;
	}
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}
	if(isDefined(parameter_3)) {
		option.parameter_3 = parameter_3;
	}

	self.structure[self.structure.size] = option;
}

add_increment(text, description, command, start, minimum, maximum, increment, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	if(isDefined(description)) {
		option.description = description;
	}
	if(!isDefined(command)) {
		option.command = ::empty_function;
	} else {
		option.command = command;
	}
	if(isNumber(start)) {
		option.start = start;
	} else {
		option.start = 0;
	}
	if(isNumber(minimum)) {
		option.minimum = minimum;
	} else {
		option.minimum = 0;
	}
	if(isNumber(maximum)) {
		option.maximum = maximum;
	} else {
		option.maximum = 10;
	}
	if(isNumber(increment)) {
		option.increment = increment;
	} else {
		option.increment = 1;
	}
	if(isDefined(parameter_1)) {
		option.parameter_1 = parameter_1;
	}
	if(isDefined(parameter_2)) {
		option.parameter_2 = parameter_2;
	}

	self.structure[self.structure.size] = option;
}

get_title_width(title) {
	letter_index = [" ", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
	letter_width = [5, 12, 11, 11, 10, 10, 10, 11, 11, 5, 10, 10, 9, 12, 11, 11, 10, 12, 10, 19, 11, 10, 11, 14, 10, 11, 10];
	title_width = 0;

	for(i = 1; i < title.size; i++) {
		for(x = 1; x < letter_index.size; x++) {
			if(tolower(title[i]) == tolower(letter_index[x])) {
				title_width = int(title_width) + int(letter_width[x]);
			}
		}
	}

	return title_width;
}

add_menu(title) {
	self.menu["title"] set_text(title);

	title_width = get_title_width(title);

	self.menu["title"].x = (self.x_offset + ceil((((-0.0000124 * title_width + 0.003832) * title_width - 0.52) * title_width + 115.258) * 10) / 10);
	self.menu["title"].y = (self.y_offset + 3);
}

new_menu(menu) {
	if(!isDefined(menu)) {
		menu = self.previous[(self.previous.size - 1)];
		self.previous[(self.previous.size - 1)] = undefined;
	} else {
		self.previous[self.previous.size] = self.current_menu;
	}

	if(!isDefined(self.slider[(menu + "_" + (self.cursor_index))])) {
		self.slider[(menu + "_" + (self.cursor_index))] = 0;
	}

	self.current_menu = set_variable(isDefined(menu), menu, "Synergy");

	if(isDefined(self.saved_index[self.current_menu])) {
		self.cursor_index = self.saved_index[self.current_menu];
		self.scrolling_offset = self.saved_offset[self.current_menu];
		self.previous_trigger = self.saved_trigger[self.current_menu];
		self.loaded_offset = true;
	} else {
		self.cursor_index = 0;
		self.scrolling_offset = 0;
		self.previous_trigger = 0;
	}

	self menu_option();
	scroll_cursor();
}

empty_function() {}

empty_option() {
	option = ["Nothing To See Here!", "Quiet Here, Isn't It?", "Oops, Nothing Here Yet!", "Bit Empty, Don't You Think?"];
	return option[randomInt(option.size)];
}

scroll_cursor(direction) {
	maximum = self.structure.size - 1;
	fake_scroll = false;

	if(maximum < 0) {
		maximum = 0;
	}

	if(isDefined(direction)) {
		if(direction == "down") {
			self.cursor_index++;
			if(self.cursor_index > maximum) {
				self.cursor_index = 0;
				self.scrolling_offset = 0;
			}
		} else if(direction == "up") {
			self.cursor_index--;
			if(self.cursor_index < 0) {
				self.cursor_index = maximum;
				if(((self.cursor_index) + int((self.option_limit / 2))) >= (self.structure.size - 2)) {
					self.scrolling_offset = (self.structure.size - self.option_limit);
				}
			}
		}
	} else {
		while(self.cursor_index > maximum) {
			self.cursor_index--;
		}
		self.menu["cursor"].y = int(self.y_offset + (((self.cursor_index + 1) - self.scrolling_offset) * 15));
	}

	self.previous_scrolling_offset = self.scrolling_offset;

	if(!self.loaded_offset) {
		if(self.cursor_index >= int(self.option_limit / 2) && self.structure.size > self.option_limit) {
			if((self.cursor_index + int(self.option_limit / 2)) >= (self.structure.size - 2)) {
				self.scrolling_offset = (self.structure.size - self.option_limit);
				if(self.previous_trigger == 2) {
					self.scrolling_offset--;
				}
				if(self.previous_scrolling_offset != self.scrolling_offset) {
					fake_scroll = true;
					self.previous_trigger = 1;
				}
			} else {
				self.scrolling_offset = (self.cursor_index - int(self.option_limit / 2));
				self.previous_trigger = 2;
			}
		} else {
			self.scrolling_offset = 0;
			self.previous_trigger = 0;
		}
	}

	if(self.scrolling_offset < 0) {
		self.scrolling_offset = 0;
	}

	if(!fake_scroll) {
		self.menu["cursor"].y = int(self.y_offset + (((self.cursor_index + 1) - self.scrolling_offset) * 15));
	}

	if(isDefined(self.structure[self.cursor_index]) && isDefined(self.structure[self.cursor_index].description)) {
		self.menu["description"] set_text(self.structure[self.cursor_index].description);
		self.description_height = 15;

		self.menu["description"].x = (self.x_offset + 5);
		self.menu["description"].alpha = 1;
	} else {
		self.menu["description"] set_text("");
		self.menu["description"].alpha = 0;
		self.description_height = 0;
	}

	self.loaded_offset = false;
	set_options();
}

scroll_slider(direction) {
	current_slider_index = self.slider[(self.current_menu + "_" + (self.cursor_index))];
	if(isDefined(direction)) {
		if(isDefined(self.structure[self.cursor_index].array)) {
			if(direction == "left") {
				current_slider_index--;
				if(current_slider_index < 0) {
					current_slider_index = (self.structure[self.cursor_index].array.size - 1);
				}
			} else if(direction == "right") {
				current_slider_index++;
				if(current_slider_index > (self.structure[self.cursor_index].array.size - 1)) {
					current_slider_index = 0;
				}
			}
		} else {
			if(direction == "left") {
				current_slider_index -= self.structure[self.cursor_index].increment;
				if(current_slider_index < self.structure[self.cursor_index].minimum) {
					current_slider_index = self.structure[self.cursor_index].maximum;
				}
			} else if(direction == "right") {
				current_slider_index += self.structure[self.cursor_index].increment;
				if(current_slider_index > self.structure[self.cursor_index].maximum) {
					current_slider_index = self.structure[self.cursor_index].minimum;
				}
			}
		}
	}
	self.slider[(self.current_menu + "_" + (self.cursor_index))] = current_slider_index;
	set_options();
}

set_options() {
	for(i = 1; i <= self.option_limit; i++) {
		self.menu["toggle_" + i].alpha = 0;
		self.menu["slider_" + i].alpha = 0;
		self.menu["option_" + i] set_text("");
		self.menu["slider_text_" + i] set_text("");
		self.menu["submenu_icon_" + i].alpha = 0;
	}

	update_element_positions();

	if(isDefined(self.structure)) {
		if(self.structure.size == 0) {
			self add_option(empty_option());
		}

		self.maximum = int(min(self.structure.size, self.option_limit));

		if(self.structure.size <= self.option_limit) {
			self.scrolling_offset = 0;
		}

		for(i = 1; i <= self.maximum; i++) {
			x = ((i - 1) + self.scrolling_offset);

			self.menu["option_" + i] set_text(self.structure[x].text);

			if(isDefined(self.structure[x].toggle)) {
				self.menu["option_" + i].x = (self.x_offset + 13.5);
				self.menu["option_" + i].alpha = 1;
				self.menu["toggle_" + i].alpha = 1;

				if(self.structure[x].toggle) {
					self.menu["toggle_" + i].color = (1, 1, 1);
				} else {
					self.menu["toggle_" + i].color = (0.25, 0.25, 0.25);
				}
			} else {
				self.menu["option_" + i].x = (self.x_offset + 5);
				self.menu["toggle_" + i].alpha = 0;
			}

			if(isDefined(self.structure[x].array) && (self.cursor_index) == x) {
				if(!isDefined(self.slider[(self.current_menu + "_" + x)])) {
					self.slider[(self.current_menu + "_" + x)] = 0;
				}

				if(self.slider[(self.current_menu + "_" + x)] > (self.structure[x].array.size - 1) || self.slider[(self.current_menu + "_" + x)] < 0) {
					self.slider[(self.current_menu + "_" + x)] = set_variable(self.slider[(self.current_menu + "_" + x)] > (self.structure[x].array.size - 1), 0, (self.structure[x].array.size - 1));
				}

				slider_text = self.structure[x].array[self.slider[(self.current_menu + "_" + x)]] + " [" + (self.slider[(self.current_menu + "_" + x)] + 1) + "/" + self.structure[x].array.size + "]";

				self.menu["slider_text_" + i] set_text(slider_text);
			} else if(isDefined(self.structure[x].increment) && (self.cursor_index) == x) {
				value = abs((self.structure[x].minimum - self.structure[x].maximum)) / 224;
				width = ceil((self.slider[(self.current_menu + "_" + x)] - self.structure[x].minimum) / value);

				if(width >= 0) {
					self.menu["slider_" + i] set_shader("white", int(width), 16);
				} else {
					self.menu["slider_" + i] set_shader("white", 0, 16);
					self.menu["slider_" + i].alpha = 0;
				}

				if(!isDefined(self.slider[(self.current_menu + "_" + x)]) || self.slider[(self.current_menu + "_" + x)] < self.structure[x].minimum) {
					self.slider[(self.current_menu + "_" + x)] = self.structure[x].start;
				}

				slider_value = self.slider[(self.current_menu + "_" + x)];
				self.menu["slider_text_" + i] set_text("" + slider_value);
				self.menu["slider_" + i].alpha = 1;
			}

			if(isDefined(self.structure[x].command) && self.structure[x].command == ::new_menu) {
				self.menu["submenu_icon_" + i].alpha = 1;
			}

			if(!isDefined(self.structure[x].command)) {
				self.menu["option_" + i].color = (0.75, 0.75, 0.75);
			} else {
				if((self.cursor_index) == x) {
					self.menu["option_" + i].color = (0.75, 0.75, 0.75);
					self.menu["submenu_icon_" + i].color = (0.75, 0.75, 0.75);
				} else {
					self.menu["option_" + i].color = (0.5, 0.5, 0.5);
					self.menu["submenu_icon_" + i].color = (0.5, 0.5, 0.5);
				}
			}
		}
	}

	menu_height = int(18 + (self.maximum * 15));

	self.menu["description"].y = int((self.y_offset + 4) + ((self.maximum + 1) * 15));

	self.menu["border"] set_shader("white", self.menu["border"].width, int(menu_height + self.description_height));
	self.menu["background"] set_shader("white", self.menu["background"].width, int((menu_height - 2) + self.description_height));
	self.menu["foreground"] set_shader("white", self.menu["foreground"].width, int(menu_height - 17));
}

// Menu Options

menu_option() {
	self.structure = [];
	menu = self.current_menu;
	switch(menu) {
		case "Synergy":
			self add_menu(menu);

			self add_option("Basic Options", undefined, ::new_menu, "Basic Options");
			self add_option("Fun Options", undefined, ::new_menu, "Fun Options");
			self add_option("Weapon Options", undefined, ::new_menu, "Weapon Options");
			self add_option("Menu Options", undefined, ::new_menu, "Menu Options");

			break;
		case "Basic Options":
			self add_menu(menu);

			self add_toggle("God Mode", "Makes you Invincible", ::god_mode, self.god_mode);
			self add_toggle("No Clip", "Fly through the Map", ::no_clip, self.no_clip);
			self add_toggle("Frag No Clip", "Fly through the Map using (^3[{+frag}]^7)", ::frag_no_clip, self.frag_no_clip);
			self add_toggle("UFO", "Fly Straight through the Map", ::ufo_mode, self.ufo_mode);
			self add_toggle("Infinite Ammo", "Gives you Infinite Ammo and Infinite Grenades", ::infinite_ammo, self.infinite_ammo);

			break;
		case "Fun Options":
			self add_menu(menu);

			self add_toggle("Disable Exo Movement", "Disable/Enable Exo-Suits", ::exo_movement, self.exo_movement);

			self add_toggle("Fullbright", "Removes all Shadows and Lighting", ::fullbright, self.fullbright);

			self add_increment("Set Speed", undefined, ::set_speed, 190, 190, 1190, 50);
			self add_increment("Set Timescale", undefined, ::set_timescale, 1, 1, 10, 1);
			self add_increment("Set Gravity", undefined, ::set_gravity, 800, 40, 800, 10);

			break;
		case "Weapon Options":
			self add_menu(menu);

			self add_option("Give Weapons", undefined, ::new_menu, "Give Weapons");
			self add_option("Give Attachments", undefined, ::new_menu, "Give Attachments");

			self add_option("Take Current Weapon", undefined, ::take_weapon);

			break;
		case "Menu Options":
			self add_menu(menu);

			self add_increment("Move Menu X", "Move the Menu around Horizontally", ::modify_menu_position, 0, -600, 20, 10, "x");
			self add_increment("Move Menu Y", "Move the Menu around Vertically", ::modify_menu_position, 0, -100, 30, 10, "y");

			self add_option("Rainbow Menu", "Set the Menu Outline Color to Cycling Rainbow", ::set_menu_rainbow);

			self add_increment("Red", "Set the Red Value for the Menu Outline Color", ::set_menu_color, 255, 1, 255, 1, "Red");
			self add_increment("Green", "Set the Green Value for the Menu Outline Color", ::set_menu_color, 255, 1, 255, 1, "Green");
			self add_increment("Blue", "Set the Blue Value for the Menu Outline Color", ::set_menu_color, 255, 1, 255, 1, "Blue");

			self add_toggle("Watermark", "Enable/Disable Watermark in the Top Left Corner", ::watermark, self.watermark);
			self add_toggle("Hide UI", undefined, ::hide_ui, self.hide_ui);
			self add_toggle("Hide Weapon", undefined, ::hide_weapon, self.hide_weapon);

			break;
		case "Give Weapons":
			self add_menu(menu);

			for(i = 0; i < self.syn["weapons"]["category"].size; i++) {
				self add_option(self.syn["weapons"]["category"][i], undefined, ::new_menu, self.syn["weapons"]["category"][i]);
			}

			break;
		case "Give Attachments":
			self add_menu(menu);

			weapon = strTok(self getCurrentWeapon(), "+")[0];

			if(weapon == "alt_iw7_fmg") {
				weapon = "iw7_fmg";
			} else if(weapon == "alt_iw7_sdfar") {
				weapon = "iw7_sdfar";
			} else if(weapon == "iw7_g18r") {
				weapon = "iw7_g18";
			} else if(weapon == "alt_iw7_ripper") {
				weapon = "iw7_ripper";
			} else if(weapon == "alt_iw7_ake") {
				weapon = "iw7_ake";
			} else if(weapon == "alt_iw7_m8") {
				weapon = "iw7_m8";
			} else if(weapon == "alt_iw7_ar57") {
				weapon = "iw7_ar57";
			} else if(weapon == "alt_iw7_mauler") {
				weapon = "iw7_mauler";
			} else if(weapon == "alt_iw7_sdflmg") {
				weapon = "iw7_sdflmg";
			} else if(weapon == "alt_iw7_lmg03") {
				weapon = "iw7_lmg03";
			}

			forEach(weapon_id in self.syn["weapons"]["attachable_weapons"]) {
				if(weapon == weapon_id) {
					for(i = 0; i < self.syn["weapons"]["attachments"][weapon][0].size; i++) {
						self add_option(self.syn["weapons"]["attachments"][weapon][1][i], undefined, ::equip_attachment, weapon, self.syn["weapons"]["attachments"][weapon][0][i]);
					}
				}
			}

			break;
		case "Assault Rifles":
			self add_menu(menu);

			load_weapons("assault_rifles");

			break;
		case "Sub Machine Guns":
			self add_menu(menu);

			load_weapons("sub_machine_guns");

			break;
		case "Light Machine Guns":
			self add_menu(menu);

			load_weapons("light_machine_guns");

			break;
		case "Sniper Rifles":
			self add_menu(menu);

			load_weapons("sniper_rifles");

			break;
		case "Shotguns":
			self add_menu(menu);

			load_weapons("shotguns");

			break;
		case "Pistols":
			self add_menu(menu);

			load_weapons("pistols");

			break;
		case "Heavies":
			self add_menu(menu);

			load_weapons("heavies");

			break;
		default:
			if(!isDefined(self.selected_player)) {
				self.selected_player = self;
			}

			self player_option(menu, self.selected_player);
			break;
	}
}

player_option(menu, player) {
	if(!isDefined(menu) || !isDefined(player) || !isPlayer(player)) {
		menu = "Error";
	}

	switch (menu) {
		case "Player Option":
			self add_menu(clean_name(player get_name()));
			break;
		case "Error":
			self add_menu();
			self add_option("Oops, Something Went Wrong!", "Condition: Undefined");
			break;
		default:
			error = true;
			if(error) {
				self add_menu("Critical Error");
				self add_option("Oops, Something Went Wrong!", "Condition: Menu Index");
			}
			break;
	}
}

// Menu Options

iPrintString(string) {
	if(!isDefined(self.syn["string"])) {
		self.syn["string"] = self create_text(string, "default", 1, "center", "top", 0, -100, (1, 1, 1), 1, 9999, false, true);
	} else {
		self.syn["string"] set_text(string);
	}
	self.syn["string"] notify("stop_hud_fade");
	self.syn["string"].alpha = 1;
	self.syn["string"] setText(string);
	self.syn["string"] thread fade_hud(0, 2.5);
}

fade_hud(alpha, time) {
	self endon("stop_hud_fade");
	self fadeOverTime(time);
	self.alpha = alpha;
	wait time;
}

modify_menu_position(offset, axis) {
	if(axis == "x") {
		self.x_offset = 175 + offset;
	} else {
		self.y_offset = 160 + offset;
	}
	self close_menu();
	self open_menu();
}

set_menu_rainbow() {
	if(!isString(self.color_theme)) {
		self.color_theme = "rainbow";
		self.menu["border"] thread start_rainbow();
		self.menu["separator_1"] thread start_rainbow();
		self.menu["separator_2"] thread start_rainbow();
		self.menu["border"].color = self.color_theme;
		self.menu["separator_1"].color = self.color_theme;
		self.menu["separator_2"].color = self.color_theme;

		if(isDefined(self.syn["watermark"])) {
			self.syn["watermark"] thread start_rainbow();
			self.syn["watermark"].color = self.color_theme;
		}
	}
}

set_menu_color(value, color) {
	if(color == "Red") {
		self.menu_color_red = value;
		iPrintString(color + " Changed to " + value);
	} else if(color == "Green") {
		self.menu_color_green = value;
		iPrintString(color + " Changed to " + value);
	} else if(color == "Blue") {
		self.menu_color_blue = value;
		iPrintString(color + " Changed to " + value);
	} else {
		iPrintString(value + " | " + color);
	}
	self.color_theme = (self.menu_color_red / 255, self.menu_color_green / 255, self.menu_color_blue / 255);
	self.menu["border"] notify("stop_rainbow");
	self.menu["separator_1"] notify("stop_rainbow");
	self.menu["separator_2"] notify("stop_rainbow");
	self.menu["border"].rainbow_enabled = false;
	self.menu["separator_1"].rainbow_enabled = false;
	self.menu["separator_2"].rainbow_enabled = false;
	self.menu["border"].color = self.color_theme;
	self.menu["separator_1"].color = self.color_theme;
	self.menu["separator_2"].color = self.color_theme;

	if(isDefined(self.syn["watermark"])) {
		self.syn["watermark"] notify("stop_rainbow");
		self.syn["watermark"].rainbow_enabled = false;
		self.syn["watermark"].color = self.color_theme;
	}
}

watermark() {
	self.watermark = !return_toggle(self.watermark);
	if(self.watermark) {
		iPrintString("Watermark [^2ON^7]");
		if(!isDefined(self.syn["watermark"])) {
			self.syn["watermark"] = self create_text("SyndiShanX", self.font, 1, "TOP_LEFT", "TOPCENTER", -425, 10, self.color_theme, 1, 3);
		} else {
			self.syn["watermark"].alpha = 1;
		}
	} else {
		iPrintString("Watermark [^1OFF^7]");
		self.syn["watermark"].alpha = 0;
	}
}

hide_ui() {
	self.hide_ui = !return_toggle(self.hide_ui);
	setDvar("cg_draw2d", !self.hide_ui);
}

hide_weapon() {
	self.hide_weapon = !return_toggle(self.hide_weapon);
	setDvar("cg_drawgun", !self.hide_weapon);
}

// Basic Options

god_mode() {
	self.god_mode = !return_toggle(self.god_mode);
	executeCommand("god");
	wait 0.01;
	if(self.god_mode) {
		iPrintString("God Mode [^2ON^7]");
	} else {
		iPrintString("God Mode [^1OFF^7]");
	}
}

no_clip() {
	self.no_clip = !return_toggle(self.no_clip);
	executecommand("noclip");
	wait 0.01;
	if(self.no_clip) {
		iPrintString("No Clip [^2ON^7]");
	} else {
		iPrintString("No Clip [^1OFF^7]");
	}
}

frag_no_clip() {
	self endon("disconnect");
	self endon("game_ended");

	if(!isDefined(self.frag_no_clip)) {
		self.frag_no_clip = true;
		iPrintString("Frag No Clip [^2ON^7], Press ^3[{+frag}]^7 to Enter and ^3[{+melee}]^7 to Exit");
		while (isDefined(self.frag_no_clip)) {
			if(self fragButtonPressed()) {
				if(!isDefined(self.frag_no_clip_loop)) {
					self thread frag_no_clip_loop();
				}
			}
			wait 0.05;
		}
	} else {
		self.frag_no_clip = undefined;
		iPrintString("Frag No Clip [^1OFF^7]");
	}
}

frag_no_clip_loop() {
	self endon("disconnect");
	self endon("noclip_end");
	self disableWeapons();
	self disableOffHandWeapons();
	self.frag_no_clip_loop = true;

	clip = spawn("script_origin", self.origin);
	self playerLinkTo(clip);
	if(!isDefined(self.god_mode) || !self.god_mode) {
		executeCommand("god");
		wait 0.01;
		iPrintString("");
		self.temp_god_mode = true;
	}

	while (true) {
		vec = anglesToForward(self getPlayerAngles());
		end = (vec[0] * 60, vec[1] * 60, vec[2] * 60);
		if(self attackButtonPressed()) {
			clip.origin = clip.origin + end;
		}
		if(self adsButtonPressed()) {
			clip.origin = clip.origin - end;
		}
		if(self meleeButtonPressed()) {
			break;
		}
		wait 0.05;
	}

	clip delete();
	self enableWeapons();
	self enableOffhandWeapons();

	if(isDefined(self.temp_god_mode)) {
		executeCommand("god");
		wait 0.01;
		iPrintString("");
		self.temp_god_mode = undefined;
	}

	self.frag_no_clip_loop = undefined;
}

ufo_mode() {
	self.ufo_mode = !return_toggle(self.ufo_mode);
	executecommand("ufo");
	wait 0.01;
	if(self.ufo_mode) {
		iPrintString("UFO Mode [^2ON^7]");
	} else {
		iPrintString("UFO Mode [^1OFF^7]");
	}
}

infinite_ammo() {
	self.infinite_ammo = !return_toggle(self.infinite_ammo);
	if(self.infinite_ammo) {
		iPrintString("Infinite Ammo [^2ON^7]");
		self thread infinite_ammo_loop();
	} else {
		iPrintString("Infinite Ammo [^1OFF^7]");
		self notify("stop_infinite_ammo");
	}
}

infinite_ammo_loop() {
	self endon("stop_infinite_ammo");
	self endon("game_ended");

	for(;;) {
		self setWeaponAmmoClip(self getCurrentWeapon(), 999);
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
		wait 0.2;
	}
}

// Fun Options

exo_movement() {
	self.exo_movement = !return_toggle(self.exo_movement);
	if(self.exo_movement) {
		iPrintString("Exo Movement [^1OFF^7]");
		self allowdoublejump(0);
		self allowwallrun(0);
		self allowdodge(0);
		self allowMantle(1);
		self.disabledMantle = 0;
	} else {
		iPrintString("Exo Movement [^2ON^7]");
		self allowdoublejump(1);
		self allowwallrun(1);
		self allowdodge(1);
		self allowMantle(0);
		self.disabledMantle = 1;
	}
}

fullbright() {
	self.fullbright = !return_toggle(self.fullbright);
	if(self.fullbright) {
		iPrintString("Fullbright [^2ON^7]");
		executeCommand("r_fullbright 1");
		wait 0.01;
	} else {
		iPrintString("Fullbright [^1OFF^7]");
		executeCommand("r_fullbright 0");
		wait 0.01;
	}
}

set_speed(value) {
	executeCommand("g_speed " + value);
}

set_timescale(value) {
	executeCommand("timescale " + value);
}

set_gravity(value) {
	executeCommand("bg_gravity " + value);
}

// Weapon Options

give_weapon(weapon) {
	if(self getCurrentWeapon() != weapon && self getWeaponsListPrimaries()[1] != weapon && self getWeaponsListPrimaries()[2] != weapon && self getWeaponsListPrimaries()[3] != weapon && self getWeaponsListPrimaries()[4] != weapon) {
		max_weapon_num = 100;
		if(self getWeaponsListPrimaries().size >= max_weapon_num) {
			self takeweapon(self getCurrentWeapon());
		}

		self giveweapon(weapon);
		self switchToWeapon(weapon);
	} else {
		self switchToWeaponImmediate(weapon);
	}
	wait 1;
	self setWeaponAmmoClip(self getCurrentWeapon(), 999);
	self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
	self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
}

equip_attachment(weapon, attachment) {
	weapon_attached = self getCurrentWeapon();
	weapon_attachments = strTok(weapon_attached, "+");
	already_attached = false;
	attachment_sight = false;
	replace_sight = false;
	sight_index = 0;

	for(i = 1; i < weapon_attachments.size; i++) {
		if(weapon_attachments[i] == attachment) {
			already_attached = true;
		}
	}

	forEach(sight in self.syn["weapons"]["sights"]) {
		if(attachment == sight) {
			attachment_sight = true;
		}
	}

	forEach(sight in self.syn["weapons"]["sights"]) {
		for(i = 1; i < weapon_attachments.size; i++) {
			if(weapon_attachments[i] == sight) {
				replace_sight = true;
				sight_index = i;
			}
		}
	}

	if(!already_attached) {
		if(replace_sight) {
			weapon_attached = weapon;
			for(i = 1; i < weapon_attachments.size; i++) {
				if(i == sight_index) {
					weapon_attached += "+" + attachment;
				} else {
					weapon_attached += "+" + weapon_attachments[i];
				}
				take_weapon();
				give_weapon(weapon_attached);
				iPrintString(weapon_attached);
			}
		} else {
			weapon_attached = weapon;
			for(i = 1; i < weapon_attachments.size; i++) {
				weapon_attached += "+" + weapon_attachments[i];
			}
			take_weapon();
			give_weapon(weapon_attached + "+" + attachment);
			iPrintString(weapon_attached + "+" + attachment);
		}
	} else {
		iPrintString("^1Attachment already Equipped!");
	}
}

take_weapon() {
	self takeweapon(self getCurrentWeapon());
	self switchToWeapon(self getWeaponsListPrimaries()[0]);
}