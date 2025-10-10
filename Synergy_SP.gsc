#include scripts\sp\hud_util;

init() {
	executeCommand("sv_cheats 1");

	level initial_precache();
	level thread player_connect();
	level thread create_rainbow_color();

	level thread session_expired();
}

initial_precache() {
	precacheshader("ui_scrollbar_arrow_right");
}

initial_variable() {
	self.menu = [];
	self.cursor = [];
	self.slider = [];
	self.previous = [];

	self.font = "default";
	self.font_scale = 0.7;
	self.option_limit = 9;
	self.option_spacing = 16;
	self.x_offset = 175;
	self.y_offset = 160;
	self.width = -20;
	self.interaction_enabled = true;
	self.description_enabled = true;
	self.randomizing_enabled = true;
	self.scrolling_buffer = 3;

	self set_menu();
	self set_title();

	self.menu_color_red = 255;
	self.menu_color_green = 255;
	self.menu_color_blue = 255;
	self.color_theme = "rainbow";

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

initial_observer() {
	level endon("game_ended");
	self endon("disconnect");

	while(self has_access()) {
		if(!self in_menu()) {
			if(self adsButtonPressed() && self meleeButtonPressed()) {
				if(self.interaction_enabled) {
					self playSound("armory_terminal_got_file", self);
				}

				close_controls_menu();
				self open_menu();

				while(self adsButtonPressed() && self meleeButtonPressed()) {
					wait 0.2;
				}
			}
		} else {
			menu = self get_menu();
			cursor = self get_cursor();
			if(self meleeButtonPressed()) {
				if(self.interaction_enabled) {
					self playSound("armory_terminal_finish", self);
				}

				if(isDefined(self.previous[(self.previous.size - 1)])) {
					self new_menu();
				} else {
					self close_menu();
				}

				while(self meleeButtonPressed()) {
					wait 0.2;
				}
			} else if(self adsButtonPressed() && !self attackButtonPressed() || self attackButtonPressed() && !self adsButtonPressed()) {
				if(isDefined(self.structure) && self.structure.size >= 2) {
					if(self.interaction_enabled) {
						self playSound("plr_helmet_short_boot_up_lr", self);
					}

					scrolling = self attackButtonPressed() ? 1 : -1;

					self set_cursor((cursor + scrolling));
					self update_scrolling(scrolling);
				}

				wait (0.05 * self.scrolling_buffer);
			} else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || !self fragButtonPressed() && self secondaryOffhandButtonPressed()) {
				if(isDefined(self.structure[cursor].array) || isDefined(self.structure[cursor].increment)) {
					if(self.interaction_enabled) {
						self playSound("armory_terminal_tick", self);
					}

					scrolling = self secondaryOffhandButtonPressed() ? 1 : -1;

					self update_slider(scrolling);
					self update_progression();
				}

				wait (0.05 * self.scrolling_buffer);
			} else if(self useButtonPressed()) {
				if(isDefined(self.structure[cursor]) && isDefined(self.structure[cursor].command)) {
					if(self.interaction_enabled) {
						self playSound("plr_helmet_visor_pull_up_w_air_lr", self);
					}

					if(isDefined(self.structure[cursor].array) || isDefined(self.structure[cursor].increment)) {
						self thread execute_function(self.structure[cursor].command, isDefined(self.structure[cursor].array) ? self.structure[cursor].array[self.slider[(menu + "_" + cursor)]] : self.slider[(menu + "_" + cursor)], self.structure[cursor].parameter_1, self.structure[cursor].parameter_2);
					} else {
						self thread execute_function(self.structure[cursor].command, self.structure[cursor].parameter_1, self.structure[cursor].parameter_2);
					}

					if(isDefined(self.structure[cursor]) && isDefined(self.structure[cursor].toggle)) {
						self update_display();
					}
				}

				while(self useButtonPressed()) {
					wait 0.1;
				}
			}
		}
		wait 0.05;
	}
}

event_system() {
	level endon("game_ended");
	self endon("disconnect");

	for(;;) {
		self.spawn_origin = self.origin;
		self.spawn_angles = self.angles;
		if(!isDefined(self.finalized) && self has_access()) {
			self.finalized = true;

			self initial_variable();
			self thread initial_observer();

			self.controls["title"] = self create_text("Controls", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 99), (self.y_offset + 4), self.color_theme, 1, 10);
			self.controls["separator"][0] = self create_shader("white", "TOP_LEFT", "TOPCENTER", 181, (self.y_offset + 7.5), 37, 1, self.color_theme, 1, 10);
			self.controls["separator"][1] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", 399, (self.y_offset + 7.5), 37, 1, self.color_theme, 1, 10);
			self.controls["border"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset - 1), (self.width + 250), 97, self.color_theme, 1, 1);
			self.controls["background"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), self.y_offset, (self.width + 248), 95, (0.075, 0.075, 0.075), 1, 2);
			self.controls["foreground"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), (self.y_offset + 16), (self.width + 248), 79, (0.1, 0.1, 0.1), 1, 3);

			self.controls["text"][0] = self create_text("Open: ^3[{+speed_throw}] ^7and ^3[{+melee}]", self.font, 0.9, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 20), (0.75, 0.75, 0.75), 1, 10);
			self.controls["text"][1] = self create_text("Scroll: ^3[{+speed_throw}] ^7and ^3[{+attack}]", self.font, 0.9, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 40), (0.75, 0.75, 0.75), 1, 10);
			self.controls["text"][2] = self create_text("Select: ^3[{+activate}] ^7Back: ^3[{+melee}]", self.font, 0.9, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 60), (0.75, 0.75, 0.75), 1, 10);
			self.controls["text"][3] = self create_text("Sliders: ^3[{+smoke}] ^7and ^3[{+frag}]", self.font, 0.9, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 80), (0.75, 0.75, 0.75), 1, 10);

			wait 8;

			close_controls_menu();
		}
	}
}

session_expired() {
	level waittill("game_ended");
	level endon("game_ended");

	foreach(index, player in level.players) {
		if(!player has_access()) {
			continue;
		}

		if(player in_menu()) {
			player close_menu();
		}
	}
}

player_connect() {
	level endon("game_ended");

	for(;;) {
		level waittill("can_save");

		player = level.player;
		player.access = "Host";

		player thread event_system();
	}
}

player_disconnect() {
	[[level.player_disconnect]]();
}

player_downed(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
	self notify("player_downed");
	[[level.player_downed]](einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);
}

// Utilities

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

auto_archive() {
	if(!isDefined(self.element_result)) {
		self.element_result = 0;
	}

	if(!isAlive(self) || self.element_result > 22) {
		return true;
	}

	return false;
}

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

	while(isDefined(self)) {
		self fadeOverTime(.05);
		self.color = level.rainbow_color;
		wait 0.05;
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

	if(color != "rainbow") {
		textElement.color = color;
	} else {
		textElement.color = level.rainbow_color;
		textElement thread start_rainbow();
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

	if(color != "rainbow") {
		shaderElement.color = color;
	} else {
		shaderElement.color = level.rainbow_color;
		shaderElement thread start_rainbow();
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

clean_text(text) {
	if(!isDefined(text) || text == "") {
		return;
	}

	if(text[0] == toUpper(text[0])) {
		if(isSubStr(text, " ") && !isSubStr(text, "_")) {
			return text;
		}
	}

	text = strTok(toLower(text), "_");
	new_string = "";
	for(a = 0; a < text.size; a++) {
		illegal = ["player", "weapon", "wpn", "viewmodel", "camo"];
		replacement = " ";
		if(in_array(illegal, text[a])) {
			for(b = 0; b < text[a].size; b++) {
				if(b != 0) {
					new_string += text[a][b];
				} else {
					new_string += toUpper(text[a][b]);
				}
			}

			if(a != (text.size - 1)) {
				new_string += replacement;
			}
		}
	}

	return new_string;
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

destroy_element() {
	if(!isDefined(self)) {
		return;
	}

	self destroy();
	if(isDefined(self.anchor)) {
		self.anchor.element_result--;
	}
}

destroy_all(array) {
	if(!isDefined(array) || !isArray(array)) {
		return;
	}

	keys = getarraykeys(array);
	for(a = 0; a < keys.size; a++) {
		if(isArray(array[keys[a]])) {
			foreach(index, value in array[keys[a]]) {
				if(isDefined(value)) {
					value destroy_element();
				}
			}
		} else {
			if(isDefined(array[keys[a]])) {
				array[keys[a]] destroy_element();
			}
		}
	}
}

destroy_option() {
	element = ["text", "submenu", "toggle", "slider"];
	for(a = 0; a < element.size; a++) {
		if(isDefined(self.menu[element[a]]) && self.menu[element[a]].size) {
			destroy_all(self.menu[element[a]]);
		}

		self.menu[element[a]] = [];
	}
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

has_access() {
	return isDefined(self.access) && self.access != "None";
}

calculate_distance(origin, destination, velocity) {
	return (distance(origin, destination) / velocity);
}

// Structure

set_menu(menu) {
	self.current_menu = isDefined(menu) ? menu : "Synergy";
}

get_menu() {
	if(!isDefined(self.current_menu)) {
		self set_menu();
	}

	return self.current_menu;
}

set_title(title) {
	self.current_title = isDefined(title) ? title : self get_menu();
}

get_title() {
	if(!isDefined(self.current_title)) {
		self set_title();
	}

	return self.current_title;
}

set_cursor(index) {
	self.cursor[self get_menu()] = isDefined(index) && isNumber(index) ? index : 0;
}

get_cursor() {
	if(!isDefined(self.cursor[self get_menu()])) {
		self set_cursor();
	}

	return self.cursor[self get_menu()];
}

get_description() {
	return self.structure[self get_cursor()].description;
}

set_state(state) {
	self.in_menu = isDefined(state) && state < 2 ? state : false;
}

in_menu() {
	return isDefined(self.in_menu) && self.in_menu;
}

set_locked(state) {
	self.is_locked = isDefined(state) && state < 2 ? state : false;
}

is_locked() {
	return isDefined(self.is_locked) && self.is_locked;
}

empty_option() {
	option = ["Nothing To See Here!", "Quiet Here, Isn't It?", "Oops, Nothing Here Yet!", "Bit Empty, Don't You Think?"];
	return option[randomint(option.size)];
}

empty_function() {}

execute_function(command, parameter_1, parameter_2, parameter_3) {
	self endon("disconnect");

	if(!isDefined(command)) {
		return;
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

add_menu(title, menu_size, extra) {
	self.structure = [];
	self set_title(title);

	if(!isDefined(self get_cursor())) {
		self set_cursor();
	}

	if(isDefined(self.menu["title"])) {
		if(isDefined(extra)) {
			self.menu["title"].x = (self.x_offset + 106) - menu_size - extra;
		} else {
			if(menu_size <= 7) {
				self.menu["title"].x = (self.x_offset + 106) - menu_size;
			} else {
				self.menu["title"].x = (self.x_offset + 106) - (menu_size * 1.4);
			}
		}
	}
}

add_option(text, description, command, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.command = isDefined(command) ? command : ::empty_function;
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

add_toggle(text, description, command, variable, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.command = isDefined(command) ? command : ::empty_function;
	option.toggle = isDefined(variable) && variable;
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

add_array(text, description, command, array, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.command = isDefined(command) ? command : ::empty_function;
	option.array = isDefined(array) && isArray(array) ? array : [];
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

add_increment(text, description, command, start, minimum, maximum, increment, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.command = isDefined(command) ? command : ::empty_function;
	option.start = isDefined(start) && isNumber(start) ? start : 0;
	option.minimum = isDefined(minimum) && isNumber(minimum) ? minimum : 0;
	option.maximum = isDefined(maximum) && isNumber(maximum) ? maximum : 10;
	option.increment = isDefined(increment) && isNumber(increment) ? increment : 1;
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

new_menu(menu) {
	if(!isDefined(menu)) {
		menu = self.previous[(self.previous.size - 1)];
		self.previous[(self.previous.size - 1)] = undefined;
	} else {
		if(self get_menu() == "All Players") {
			player = level.players[self get_cursor()];
			self.selected_player = player;
		}

		self.previous[self.previous.size] = self get_menu();
	}

	self set_menu(menu);
	self update_display();
}

// Custom Structure

open_menu() {
	self.menu["border"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset - 1), (self.width + 250), 34, self.color_theme, 1, 1);
	self.menu["background"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), self.y_offset, (self.width + 248), 32, (0.075, 0.075, 0.075), 1, 2);
	self.menu["foreground"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), (self.y_offset + 16), (self.width + 248), 16, (0.1, 0.1, 0.1), 1, 3);
	self.menu["cursor"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), (self.y_offset + 16), (self.width + 243), 16, (0.15, 0.15, 0.15), 1, 4);
	self.menu["scrollbar"] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["background"].width + 1)), (self.y_offset + 16), 4, 16, (0.25, 0.25, 0.25), 1, 4);

	self set_state(true);
	self update_display();
}

close_menu() {
	self notify("menu_ended");
	self set_state(false);
	self destroy_option();
	self destroy_all(self.menu);
}

display_title(title) {
	title = isDefined(title) ? title : self get_title();
	if(!isDefined(self.menu["title"])) {
		self.menu["title"] = self create_text(title, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 99), (self.y_offset + 4), self.color_theme, 1, 10);
		self.menu["separator"][0] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 6), (self.y_offset + 7.5), int((self.menu["cursor"].width / 6)), 1, self.color_theme, 1, 10);
		self.menu["separator"][1] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["cursor"].width - 2) + 3), (self.y_offset + 7.5), int((self.menu["cursor"].width / 6)), 1, self.color_theme, 1, 10);
	} else {
		self.menu["title"] set_text(title);
	}
}

display_description(description) {
	description = isDefined(description) ? description : self get_description();
	if(isDefined(self.menu["description"]) && !self.description_enabled || isDefined(self.menu["description"]) && !isDefined(description)) {
		self.menu["description"] destroy_element();
	}

	if(isDefined(description) && self.description_enabled) {
		if(!isDefined(self.menu["description"])) {
			self.menu["description"] = self create_text(description, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 4), (self.y_offset + 36), (0.75, 0.75, 0.75), 1, 10);
		} else {
			self.menu["description"] set_text(description);
		}
	}
}

display_option() {
	self destroy_option();
	self menu_option();
	if(!isDefined(self.structure) || !self.structure.size) {
		self add_option(empty_option());
	}

	self display_title();
	self display_description();
	if(isDefined(self.structure) && self.structure.size) {
		if(self get_cursor() >= self.structure.size) {
			self set_cursor((self.structure.size - 1));
		}

		if(!isDefined(self.menu["toggle"][0])) {
			self.menu["toggle"][0] = [];
		}

		menu = self get_menu();
		cursor = self get_cursor();
		maximum = min(self.structure.size, self.option_limit);
		for(a = 0; a < maximum; a++) {
			start = self get_cursor() >= int((self.option_limit / 2)) && self.structure.size > self.option_limit ? (((self get_cursor() + int((self.option_limit / 2))) >= (self.structure.size - 1)) ? (self.structure.size - self.option_limit) : (self get_cursor() - int((self.option_limit / 2)))) : 0;
			index = (a + start);
			if(isDefined(self.structure[index].command) && self.structure[index].command == ::new_menu) {
				self.menu["submenu"][index] = self create_shader("ui_scrollbar_arrow_right", "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["cursor"].width - 1)), (self.y_offset + ((a * self.option_spacing) + 20.5)), 7, 7, (cursor == index) ? (0.75, 0.75, 0.75) : (0.5, 0.5, 0.5), 1, 10);
			}

			if(isDefined(self.structure[index].toggle)) { // Toggle Off
				self.menu["toggle"][0][index] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 14), (self.y_offset + ((a * self.option_spacing) + 19)), 10, 10, (0.25, 0.25, 0.25), 1, 9);
				if(self.structure[index].toggle) { // Toggle On
					self.menu["toggle"][0][index].color = (1, 1, 1);
				}
			}

			if(isDefined(self.structure[index].array) || isDefined(self.structure[index].increment)) {
				if(isDefined(self.structure[index].array)) { // Array Text
					self.menu["slider"][index] = self create_text(self.slider[(menu + "_" + index)], self.font, self.font_scale, "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["cursor"].width - 2)), (self.y_offset + ((a * self.option_spacing) + 20)), (cursor == index) ? (0.75, 0.75, 0.75) : (0.5, 0.5, 0.5), 1, 10);
				} else if(cursor == index) { // Increment Text
					self.menu["slider"][index] = self create_text(self.slider[(menu + "_" + index)], self.font, self.font_scale, "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["cursor"].width - 3)), (self.y_offset + ((a * self.option_spacing) + 20)), (0.75, 0.75, 0.75), 1, 10);
				}

				self update_slider(undefined, index);
			}

			self.menu["text"][index] = self create_text((isDefined(self.structure[index].array) || isDefined(self.structure[index].increment)) ? (self.structure[index].text + ":") : self.structure[index].text, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", isDefined(self.structure[index].toggle) ? (self.x_offset + 16) : (!isDefined(self.structure[index].command) ? (self.x_offset + (self.menu["cursor"].width / 2)) : (self.x_offset + 4)), (self.y_offset + ((a * self.option_spacing) + 20)), !isDefined(self.structure[index].command) ? self.color_theme : ((cursor == index) ? (0.75, 0.75, 0.75) : (0.5, 0.5, 0.5)), 1, 10);
		}
	}
}

update_display() {
	self display_option();
	self update_scrollbar();
	self update_progression();
	self update_rescaling();
}

update_scrolling(scrolling) {
	if(isDefined(self.structure[self get_cursor()]) && !isDefined(self.structure[self get_cursor()].command)) {
		self set_cursor((self get_cursor() + scrolling));
		return self update_scrolling(scrolling);
	}

	if(self get_cursor() >= self.structure.size || self get_cursor() < 0) {
		self set_cursor(self get_cursor() >= self.structure.size ? 0 : (self.structure.size - 1));
	}

	self update_display();
}

update_slider(scrolling, cursor) {
	menu = self get_menu();
	cursor = isDefined(cursor) ? cursor : self get_cursor();
	scrolling = isDefined(scrolling) ? scrolling : 0;
	if(!isDefined(self.slider[(menu + "_" + cursor)])) {
		self.slider[(menu + "_" + cursor)] = isDefined(self.structure[cursor].array) ? 0 : self.structure[cursor].start;
	}

	if(isDefined(self.structure[cursor].array)) {
		if(scrolling == -1) {
			self.slider[(menu + "_" + cursor)]++;
		}

		if(scrolling == 1) {
			self.slider[(menu + "_" + cursor)]--;
		}

		if(self.slider[(menu + "_" + cursor)] > (self.structure[cursor].array.size - 1) || self.slider[(menu + "_" + cursor)] < 0) {
			self.slider[(menu + "_" + cursor)] = self.slider[(menu + "_" + cursor)] > (self.structure[cursor].array.size - 1) ? 0 : (self.structure[cursor].array.size - 1);
		}

		if(isDefined(self.menu["slider"][cursor])) {
			self.menu["slider"][cursor] set_text((self.structure[cursor].array[self.slider[(menu + "_" + cursor)]] + " [" + (self.slider[(menu + "_" + cursor)] + 1) + "/" + self.structure[cursor].array.size + "]"));
		}
	} else {
		if(scrolling == -1) {
			self.slider[(menu + "_" + cursor)] += self.structure[cursor].increment;
		}

		if(scrolling == 1) {
			self.slider[(menu + "_" + cursor)] -= self.structure[cursor].increment;
		}

		if(self.slider[(menu + "_" + cursor)] > self.structure[cursor].maximum || self.slider[(menu + "_" + cursor)] < self.structure[cursor].minimum) {
			self.slider[(menu + "_" + cursor)] = self.slider[(menu + "_" + cursor)] > self.structure[cursor].maximum ? self.structure[cursor].minimum : self.structure[cursor].maximum;
		}

		if(isDefined(self.menu["slider"][cursor])) {
			self.menu["slider"][cursor] setValue(self.slider[(menu + "_" + cursor)]);
		}
	}
}

update_progression() {
	if(isDefined(self.structure[self get_cursor()].increment) && self.slider[(self get_menu() + "_" + self get_cursor())] != 0) {
		value = abs((self.structure[self get_cursor()].minimum - self.structure[self get_cursor()].maximum)) / (self.menu["cursor"].width);
		width = ceil(((self.slider[(self get_menu() + "_" + self get_cursor())] - self.structure[self get_cursor()].minimum) / value));
		if(!isDefined(self.menu["progression"])) {
			self.menu["progression"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 1), self.menu["cursor"].y, int(width), 16, (0.3, 0.3, 0.3), 1, 5);
		} else {
			self.menu["progression"] set_shader(self.menu["progression"].shader, int(width), self.menu["progression"].height);
		}

		if(self.menu["progression"].y != self.menu["cursor"].y) {
			self.menu["progression"].y = self.menu["cursor"].y;
		}
	} else if(isDefined(self.menu["progression"])) {
		self.menu["progression"] destroy_element();
	}
}

update_scrollbar() {
	maximum = min(self.structure.size, self.option_limit);
	height = int((maximum * self.option_spacing));
	adjustment = self.structure.size > self.option_limit ? ((self.menu["foreground"].height / self.structure.size) * maximum) : height;
	position = self.structure.size > self.option_limit ? ((self.structure.size - 1) / (height - adjustment)) : 0;
	if(isDefined(self.menu["cursor"])) {
		self.menu["cursor"].y = (self.menu["text"][self get_cursor()].y - 4);
	}

	if(isDefined(self.menu["scrollbar"])) {
		self.menu["scrollbar"].y = (self.y_offset + 16);
		if(self.structure.size > self.option_limit) {
			self.menu["scrollbar"].y += (self get_cursor() / position);
		}
	}

	self.menu["scrollbar"] set_shader(self.menu["scrollbar"].shader, self.menu["scrollbar"].width, int(adjustment));
}

update_rescaling() {
	maximum = min(self.structure.size, self.option_limit);
	height = int((maximum * self.option_spacing));
	if(isDefined(self.menu["description"])) {
		self.menu["description"].y = (self.y_offset + (height + 20));
	}

	self.menu["border"] set_shader(self.menu["border"].shader, self.menu["border"].width, isDefined(self get_description()) && self.description_enabled ? (height + 34) : (height + 18));
	self.menu["background"] set_shader(self.menu["background"].shader, self.menu["background"].width, isDefined(self get_description()) && self.description_enabled ? (height + 32) : (height + 16));
	self.menu["foreground"] set_shader(self.menu["foreground"].shader, self.menu["foreground"].width, height);
}

// Option Structure

menu_option() {
	menu = self get_menu();
	switch (menu) {
		case "Synergy":
			self add_menu(menu, menu.size);

			self add_option("Basic Options", undefined, ::new_menu, "Basic Options");
			self add_option("Fun Options", undefined, ::new_menu, "Fun Options");
			self add_option("Weapon Options", undefined, ::new_menu, "Weapon Options");
			self add_option("Menu Options", undefined, ::new_menu, "Menu Options");

			break;
		case "Basic Options":
			self add_menu(menu, menu.size);

			self add_toggle("God Mode", "Makes you Invincible", ::god_mode, self.god_mode);
			self add_toggle("No Clip", "Fly through the Map", ::no_clip, self.no_clip);
			self add_toggle("Frag No Clip", "Fly through the Map using (^3[{+frag}]^7)", ::frag_no_clip, self.frag_no_clip);
			self add_toggle("UFO", "Fly Straight through the Map", ::ufo_mode, self.ufo_mode);
			self add_toggle("Infinite Ammo", "Gives you Infinite Ammo and Infinite Grenades", ::infinite_ammo, self.infinite_ammo);

			break;
		case "Fun Options":
			self add_menu(menu, menu.size);

			self add_toggle("Disable Exo Movement", "Disable/Enable Exo-Suits", ::exo_movement, self.exo_movement);

			self add_toggle("Fullbright", "Removes all Shadows and Lighting", ::fullbright, self.fullbright);

			self add_increment("Set Speed", undefined, ::set_speed, 190, 190, 1190, 50);
			self add_increment("Set Timescale", undefined, ::set_timescale, 1, 1, 10, 1);
			self add_increment("Set Gravity", undefined, ::set_gravity, 800, 40, 800, 10);

			break;
		case "Weapon Options":
			self add_menu(menu, menu.size);

			self add_option("Give Weapons", undefined, ::new_menu, "Give Weapons");
			self add_option("Give Attachments", undefined, ::new_menu, "Give Attachments");

			self add_option("Take Current Weapon", undefined, ::take_weapon);

			break;
		case "Menu Options":
			self add_menu(menu, menu.size);

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
			self add_menu(menu, menu.size);

			for(i = 0; i < self.syn["weapons"]["category"].size; i++) {
				self add_option(self.syn["weapons"]["category"][i], undefined, ::new_menu, self.syn["weapons"]["category"][i]);
			}

			break;
		case "Give Attachments":
			self add_menu(menu, menu.size);

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
			self add_menu(menu, menu.size);

			category = "assault_rifles";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

			break;
		case "Sub Machine Guns":
			self add_menu(menu, menu.size);

			category = "sub_machine_guns";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

			break;
		case "Light Machine Guns":
			self add_menu(menu, menu.size);

			category = "light_machine_guns";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

			break;
		case "Sniper Rifles":
			self add_menu(menu, menu.size);

			category = "sniper_rifles";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

			break;
		case "Shotguns":
			self add_menu(menu, menu.size);

			category = "shotguns";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

			break;
		case "Pistols":
			self add_menu(menu, menu.size);

			category = "pistols";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

			break;
		case "Heavies":
			self add_menu(menu, menu.size);

			category = "heavies";

			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}

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
	if(!isDefined(menu) || !isDefined(player) || !isplayer(player)) {
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

// Misc Options

return_toggle(variable) {
	return isDefined(variable) && variable;
}

close_controls_menu() {
	if(isDefined(self.controls["title"])) {
		self.controls["title"] destroy();
		self.controls["separator"][0] destroy();
		self.controls["separator"][1] destroy();
		self.controls["border"] destroy();
		self.controls["background"] destroy();
		self.controls["foreground"] destroy();

		self.controls["text"][0] destroy();
		self.controls["text"][1] destroy();
		self.controls["text"][2] destroy();
		self.controls["text"][3] destroy();
	}
}

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

// Menu Options

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
		self close_menu();
		self open_menu();
		self.menu["title"].x = 264.2;
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
	self close_menu();
	self open_menu();
	self.menu["title"].x = 264.2;
}

watermark() {
	self.watermark = !return_toggle(self.watermark);
	if(self.watermark) {
		iPrintString("Watermark [^2ON^7]");
		if(!isDefined(self.syn["watermark"])) {
			self.syn["watermark"] = self create_text("SyndiShanX", self.font, 1, "TOP_LEFT", "TOPCENTER", -425, 10, self.color_theme, 1, 3);
		} else {
			self.syn["watermark"].alpha = 1;
			self.syn["watermark"].color = self.color_theme;
		}
	} else {
		iPrintString("Watermark [^1OFF^7]");
		self.syn["watermark"].alpha = 0;
	}
}

hide_ui() {
	self.hide_ui = !return_toggle(self.hide_ui);
	executeCommand("cg_draw2D " + !self.hide_ui);
}

hide_weapon() {
	self.hide_weapon = !return_toggle(self.hide_weapon);
	executeCommand("cg_drawGun " + !self.hide_weapon);
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