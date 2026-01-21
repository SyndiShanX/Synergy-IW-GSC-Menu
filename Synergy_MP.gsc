#include scripts\mp\utility;
#include scripts\mp\weapons;
#include scripts\engine\utility;
#include scripts\mp\bots\bots_util;

init() {
	executeCommand("sv_cheats 1");

	precacheshader("ui_scrollbar_arrow_right");

	level thread player_connect();
	level thread create_rainbow_color();

	wait 0.5;

	level.originalCallbackPlayerDamage = level.callbackPlayerDamage; //doktorSAS - Retropack
	level.callbackPlayerDamage = ::player_damage_callback; // Retropack
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

	self.syn["visions"][0] = ["None", "AC-130", "AC-130 Enhanced", "AC-130 inverted", "Aftermath", "Aftermath Glow", "Aftermath Post", "Apex", "Default", "Default Night", "Night Vision", "Dronehive", "Endgame", "Europa", "Jackal", "MP Map Select", "Missile Cam", "MP Intro", "MP Outro", "MP Nuke", "MP Nuke Aftermath", "Frontier", "Out of Bounds", "Nuke Flash", "Optic Wave", "RC8", "Thor Bright", "Thor", "Venom Gas"];
	self.syn["visions"][1] = ["", "ac130", "ac130_enhanced_mp", "ac130_inverted", "aftermath", "aftermath_glow", "aftermath_post", "apex_mp", "default", "default_night", "default_night_mp", "dronehive_mp", "end_game", "europa", "jackal_streak_mp", "map_select_mp", "missilecam", "mpintro", "mpoutro", "mpnuke", "mpnuke_aftermath", "mp_frontier", "mp_out_of_bounds", "nuke_global_flash", "opticwave_mp", "rc8_mp", "thorbright_mp", "thor_mp", "venomgas_mp"];

	self.syn["weapons"]["category"] = ["Assault Rifles", "Sub Machine Guns", "Light Machine Guns", "Sniper Rifles", "Shotguns", "Pistols", "Launchers", "Classic Weapons", "Melee Weapons", "Specialist Weapons"];

	// Weapon IDs Plus Default Attachments
	self.syn["weapons"]["assault_rifles"][0] =     ["iw7_m4_mp", "iw7_sdfar_mp", "iw7_ar57_mp", "iw7_fmg_mp+akimbofmg+fmgscope_camo", "iw7_ake_mpr", "iw7_rvn_mp+meleervn+rvnscope", "iw7_vr_mp+vrscope", "iw7_gauss_mp+gaussscope", "iw7_erad_mp+eradscope_camo"];
	self.syn["weapons"]["sub_machine_guns"][0] =   ["iw7_fhr_mp", "iw7_crb_mpl+crblscope_camo", "iw7_ripper_mpr+ripperrscope_camo", "iw7_ump45_mpl+ump45lscope_camo", "iw7_crdb_mp", "iw7_mp28_mp", "iw7_tacburst_mp+gltacburst+tacburstscope"];
	self.syn["weapons"]["light_machine_guns"][0] = ["iw7_sdflmg_mp", "iw7_mauler_mp", "iw7_lmg03_mp+lmg03scope_camo", "iw7_minilmg_mp+minilmgscope", "iw7_unsalmg_mp"];
	self.syn["weapons"]["sniper_rifles"][0] =      ["iw7_kbs_mp+kbsscope_camo", "iw7_m8_mp+m8scope_camo", "iw7_cheytac_mpr+cheytacrscope_camo", "iw7_m1_mp+m1scope_camo", "iw7_ba50cal_mp+ba50calscope", "iw7_longshot_mp+longshotscope"];
	self.syn["weapons"]["shotguns"][0] =           ["iw7_devastator_mp", "iw7_sonic_mpr+sonicrscope_camo", "iw7_sdfshotty_mp+sdfshottyscope_camo", "iw7_spas_mpr", "iw7_mod2187_mp+mod2187scope"];
	self.syn["weapons"]["pistols"][0] =            ["iw7_emc_mp", "iw7_nrg_mp", "iw7_g18_mpr", "iw7_revolver_mp", "iw7_udm45_mp+udm45scope", "iw7_mag_mp"];
	self.syn["weapons"]["launchers"][0] =          ["iw7_lockon_mp+lockonscope_camo", "iw7_glprox_mp+glproxscope_camo", "iw7_chargeshot_mp+chargeshotscope_camo", "iw7_venomx_mp+venomxalt_burst"];
	self.syn["weapons"]["classics"][0] =           ["iw7_m1c_mp", "iw7_g18c_mp", "iw7_ump45c_mp", "iw7_spasc_mp", "iw7_arclassic_mp+glarclassic", "iw7_cheytacc_mp+cheytacscope_camo"];
	self.syn["weapons"]["melee"][0] =             ["iw7_fists_mp", "iw7_knife_mp", "iw7_axe_mpr_melee", "iw7_axe_mp", "iw7_katana_mp", "iw7_nunchucks_mp"];
	self.syn["weapons"]["specialist"][0] =           ["iw7_atomizer_mp", "iw7_penetrationrail_mp+penetrationrailscope", "iw7_steeldragon_mp", "iw7_claw_mp", "iw7_blackholegun_mp+blackholegunscope"];
	// Weapon Names
	self.syn["weapons"]["assault_rifles"][1] =     ["NV4", "R3K", "KBAR-32", "Type-2", "Volk", "R-VN", "X-Con", "G-Rail", "Erad"];
	self.syn["weapons"]["sub_machine_guns"][1] =   ["FHR-40", "Karma-45", "RPR Evo", "HVR", "VPR", "Trencher", "Raijin-EMX"];
	self.syn["weapons"]["light_machine_guns"][1] = ["R.A.W.", "Mauler", "Titan", "Auger", "Atlas"];
	self.syn["weapons"]["sniper_rifles"][1] =      ["KBS Longbow", "EBR-800", "Widowmaker", "DMR-1", "Trek-50", "Proteus"];
	self.syn["weapons"]["shotguns"][1] =           ["Reaver", "Banshee", "DCM-8", "Rack-9", "M.2187"];
	self.syn["weapons"]["pistols"][1] =            ["EMC", "Oni", "Kendall 44", "Hailstorm", "UDM", "Stallion 44"];
	self.syn["weapons"]["launchers"][1] =          ["Spartan SA3", "Howitzer", "P-Law", "Venom-X"];
	self.syn["weapons"]["classics"][1] =           ["M1", "Hornet", "MacTav-45", "S-Ravage", "OSA", "TF-141"];
	self.syn["weapons"]["melee"][1] =             ["Fists", "Combat Knife", "Axe", "Fancy Axe", "Katana", "Nunchucks"];
	self.syn["weapons"]["specialist"][1] =           ["Eraser", "Ballista EM3", "Steel Dragon", "Claw", "Gravity Vortex Gun"];

	// Perks
	self.syn["perks"][0] = ["specialty_expanded_minimap", "specialty_blindeye", "specialty_blastshield", "specialty_dexterity", "specialty_ghost", "specialty_overclock",  "specialty_stun_resistance", "specialty_hardline", "specialty_momentum", "specialty_tracker", "specialty_coldblooded", "specialty_scavenger", "specialty_sprintfire", "specialty_bullet_outline", "specialty_empimmune", "specialty_marksman", "specialty_engineer", "specialty_quieter", "specialty_explosivebullets", "specialty_fasterlockon", "specialty_rearguard", "specialty_delaymine", "specialty_superpack", "specialty_spygame", "specialty_no_target", "specialty_localjammer"];
	self.syn["perks"][1] = ["Recon", "Blind Eye", "Blast Shield", "Dexterity", "Ghost", "Overclock", "Tac Resist", "Hardline", "Momentum", "Tracker", "Cold Blooded", "Scavenger", "Gung-Ho", "Pin Point", "Hardwired", "Marksman", "Engineer", "Dead Silence", "Explosive Bullets", "Faster Launcher Lock-On", "Shield on Back", "Delay Mines", "Payload Pack", "No Player Name on Hover", "AI No Target", "Scrambler"];

	// Killstreaks
	self.syn["killstreaks"][0] = ["venom", "uav", "dronedrop", "counter_uav", "ball_drone_backup", "drone_hive", "precision_airstrike", "bombardment", "sentry_shock", "jackal", "directional_uav", "thor", "remote_c8", "minijackal", "nuke"];
	self.syn["killstreaks"][1] = ["Scarab", "UAV", "Drone Package", "Counter UAV", "Vulture", "Trinity Rocket", "Scorchers", "Bombardment", "Shock Sentry", "Warden", "Advanced UAV", "T.H.O.R", "R-C8", "AP-3X", "Nuke"];
}

initialize_menu() {
	level endon("game_ended");
	self endon("disconnect");

	for(;;) {
		event_name = self waittill_any_return("spawned_player", "player_downed", "death", "joined_spectators");
		switch (event_name) {
			case "spawned_player":
				if(self isHost()) {
					if(!self.hud_created) {
						self freezeControls(false);

						self thread input_manager();

						self.syn["string"] = self create_text("", "default", 1, "center", "top", 0, -100, (1, 1, 1), 0, 9999, false, true);

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
				break;
			default:
				if(!self isHost()) {
					continue;
				}

				if(self.in_menu) {
					self close_menu();
				}
				break;
		}
	}
}

input_manager() {
	level endon("game_ended");
	self endon("disconnect");

	while(self isHost()) {
		if(!self.in_menu) {
			if(self adsButtonPressed() && self meleeButtonPressed()) {
				if(self.controls_menu_open) {
					close_controls_menu();
				}

				self playSoundToPlayer("copycat_steal_class", self);

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

				self playSoundToPlayer("mp_adrenaline_off", self);

				if(isDefined(self.previous[(self.previous.size - 1)])) {
					self new_menu();
				} else {
					self close_menu();
				}

				while(self meleeButtonPressed()) {
					wait 0.2;
				}
			} else if(self adsButtonPressed() && !self attackButtonPressed() || self attackButtonPressed() && !self adsButtonPressed()) {

				self playSoundToPlayer("mp_cranked_countdown", self);

				scroll_cursor(set_variable(self attackButtonPressed(), "down", "up"));

				wait (0.2);
			} else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || !self fragButtonPressed() && self secondaryOffhandButtonPressed()) {

				self playSoundToPlayer("mp_killstreak_warden_switch_mode", self);

				if(isDefined(self.structure[self.cursor_index].array) || isDefined(self.structure[self.cursor_index].increment)) {
					scroll_slider(set_variable(self secondaryOffhandButtonPressed(), "left", "right"));
				}

				wait (0.2);
			} else if(self useButtonPressed()) {
				self.saved_index[self.current_menu] = self.cursor_index;
				self.saved_offset[self.current_menu] = self.scrolling_offset;
				self.saved_trigger[self.current_menu] = self.previous_trigger;

				self playSoundToPlayer("mp_killstreak_screen_start", self);

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
		level waittill("connected", player);

		if(isBot(player)) {
			return;
		}

		player.access = player isHost() ? "Host" : "None";

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

	waitframe();

	self.menu["background"].alpha = opacity;
	self.menu["foreground"].alpha = opacity;
	self.menu["cursor"].alpha = opacity;

	if(opacity == 1) {
		self.menu["border"].alpha = opacity;
	}
}

create_text(text, font, font_scale, align_x, align_y, x_offset, y_offset, color, alpha, z_index, hide_when_in_menu) {
	textElement = self scripts\mp\hud_util::createFontString(font, font_scale);
	textElement scripts\mp\hud_util::setPoint(align_x, align_y, x_offset, y_offset);

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

	shaderElement scripts\mp\hud_util::setParent(level.uiParent);
	shaderElement scripts\mp\hud_util::setPoint(align_x, align_y, x_offset, y_offset);

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

player_damage_callback(inflictor, attacker, damage, flags, death_reason, weapon, point, direction, hit_location, time_offset) {
	self endon("disconnect");

	if(isDefined(self.god_mode) && self.god_mode) {
		return;
	}

	[[level.originalCallbackPlayerDamage]](inflictor, attacker, damage, flags, death_reason, weapon, point, direction, hit_location, time_offset);
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
			self add_option("Give Killstreaks", undefined, ::new_menu, "Give Killstreaks");
			self add_option("Account Options", undefined, ::new_menu, "Account Options");
			self add_option("Menu Options", undefined, ::new_menu, "Menu Options");
			self add_option("All Players", undefined, ::new_menu, "All Players");

			break;
		case "Basic Options":
			self add_menu(menu);

			self add_toggle("God Mode", "Makes you Invincible", ::god_mode, self.god_mode);
			self add_toggle("No Clip", "Fly through the Map", ::no_clip, self.no_clip);
			self add_toggle("Frag No Clip", "Fly through the Map using (^3[{+frag}]^7)", ::frag_no_clip, self.frag_no_clip);
			self add_toggle("UFO", "Fly Straight through the Map", ::ufo_mode, self.ufo_mode);
			self add_toggle("Infinite Ammo", "Gives you Infinite Ammo and Infinite Grenades", ::infinite_ammo, self.infinite_ammo);

			self add_option("Give All Perks", undefined, ::give_all_perks);
			self add_option("Take All Perks", undefined, ::take_all_perks);

			self add_option("Give Perks", undefined, ::new_menu, "Give Perks");
			self add_option("Take Perks", undefined, ::new_menu, "Take Perks");

			break;
		case "Fun Options":
			self add_menu(menu);

			self add_toggle("Disable Exo Movement", "Disable/Enable Exo-Suits", ::exo_movement, self.exo_movement);
			self add_toggle("Enable Out of Bounds Popup", "Enables/Disables the Out of Bounds Popup", ::out_of_bounds, self.out_of_bounds);

			self add_toggle("Earnable Nuke", "Gives you a Nuke when you reach a 25 Kill Streak", ::earnable_nuke, self.earnable_nuke);

			self add_toggle("Fullbright", "Removes all Shadows and Lighting", ::fullbright, self.fullbright);
			self add_toggle("Third Person", undefined, ::third_person, self.third_person);

			self add_increment("Set Speed", undefined, ::set_speed, 190, 190, 1190, 50);
			self add_increment("Set Timescale", undefined, ::set_timescale, 1, 1, 10, 1);
			self add_increment("Set Gravity", undefined, ::set_gravity, 800, 40, 800, 10);

			self add_option("Visions", undefined, ::new_menu, "Visions");

			break;
		case "Weapon Options":
			self add_menu(menu);

			self add_option("Give Weapons", undefined, ::new_menu, "Give Weapons");

			self add_option("Take Current Weapon", undefined, ::take_weapon);
			self add_option("Drop Current Weapon", undefined, ::drop_weapon);

			break;
		case "Give Killstreaks":
			self add_menu(menu, menu.size, 1);

			for(i = 0; i < self.syn["killstreaks"][0].size; i++) {
				self add_option(self.syn["killstreaks"][1][i], undefined, ::give_killstreak, self.syn["killstreaks"][0][i]);
			}

			break;
		case "Account Options":
			self add_menu(menu);

			self add_increment("Set Prestige", undefined, ::set_prestige, 0, 0, 30, 1);
			self add_increment("Set Level", undefined, ::set_rank, 1, 1, 55, 1);
			self add_increment("Set XP Scale", undefined, ::set_xp_scale, 1, 1, 10, 1);

			self add_option("Set Weapons to Max Level", undefined, ::set_max_weapons);

			self add_option("Complete Active Contracts", undefined, ::complete_active_contracts);

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
		case "All Players":
			self add_menu(menu, menu.size);

			foreach(player in level.players){
				self add_option(player.name, undefined, ::new_menu, "Player Option", player);
			}

			break;
		case "Player Option":
			self add_menu(menu, menu.size);

			target = undefined;
			foreach(player in level.players) {
				if(player.name == self.previous_option) {
					target = player;
					break;
				}
			}

			if(isDefined(target)) {
				self add_option("Print", "Print Player Name", ::print_player_name, target);
				self add_option("Kill", "Kill the Player", ::commit_suicide, target);

				if(isBot(target)) {
					self add_array("Set Difficulty", undefined, ::set_difficulty, ["Recruit", "Regular", "Hardened", "Veteran"], target);
					self add_option("Get Difficulty", undefined, ::get_difficulty, target);
				}

				if(!target isHost()) {
					self add_option("Kick", "Kick the Player from the Game", ::kick_player, target);
				}
			} else {
				self add_option("Player not found");
			}

			break;
		case "Give Perks":
			self add_menu(menu);

			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], undefined, ::give_perk, self.syn["perks"][0][i], 0);
			}

			break;
		case "Take Perks":
			self add_menu(menu);

			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], undefined, ::take_perk, self.syn["perks"][0][i]);
			}

			break;
		case "Give Weapons":
			self add_menu(menu);

			for(i = 0; i < self.syn["weapons"]["category"].size; i++) {
				self add_option(self.syn["weapons"]["category"][i], undefined, ::new_menu, self.syn["weapons"]["category"][i]);
			}

			break;
		case "Visions":
			self add_menu(menu);

			for(i = 0; i < self.syn["visions"][0].size; i++) {
				self add_option(self.syn["visions"][0][i], undefined, ::set_vision, self.syn["visions"][1][i]);
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
		case "Launchers":
			self add_menu(menu);

			load_weapons("launchers");

			break;
		case "Classic Weapons":
			self add_menu(menu);

			load_weapons("classics");

			break;
		case "Melee Weapons":
			self add_menu(menu);

			load_weapons("melee");

			break;
		case "Specialist Weapons":
			self add_menu(menu);

			load_weapons("specialist");

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
		self.god_mode = true;
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
		self.god_mode = false;
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
		self scripts\mp\powers::power_adjustcharges(2, "primary", 2);
		self scripts\mp\powers::power_adjustcharges(2, "secondary", 2);
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
	} else {
		iPrintString("Exo Movement [^2ON^7]");
		self allowdoublejump(1);
		self allowwallrun(1);
		self allowdodge(1);
	}
}

out_of_bounds() {
	self.out_of_bounds = !return_toggle(self.out_of_bounds);
	if(!self.out_of_bounds) {
		iPrintString("Out of Bounds Popup [^1OFF^7]");
		foreach(barrier in self.out_of_bounds_barriers) {
			barrier.origin = (0, 0, 999999);
		}
	} else {
		iPrintString("Out of Bounds Popup [^2ON^7]");
		foreach(barrier in self.out_of_bounds_barriers) {
			barrier.origin = barrier.oldorigin;
		}
	}
}

earnable_nuke() {
	self.earnable_nuke = !return_toggle(self.earnable_nuke);
	if(self.earnable_nuke) {
		iPrintString("Earnable Nuke [^2ON^7]");
		self thread earnable_nuke_loop();
	} else {
		iPrintString("Earnable Nuke [^1OFF^7]");
		self notify("stop_earnable_nuke");
	}
}

earnable_nuke_loop() {
	self endon("stop_earnable_nuke");
	self endon("game_ended");

	for(;;) {
		if(self.previousKillNum < self.pers["cur_kill_streak"]) {
			if(self.pers["cur_kill_streak"] == 24) {
				self thread scripts\mp\hud_message::showsplash("nuke_kill_single");
			} else if(self.pers["cur_kill_streak"] % 5 == 0 || self.pers["cur_kill_streak"] >= 20 ) {
				if(self.pers["cur_kill_streak"] != 0 && (self.pers["cur_kill_streak"] - 25 != 0)) {
					self thread scripts\mp\hud_message::showsplash("nuke_kill", (25 - self.pers["cur_kill_streak"]));
				}
			}
		}

		if(self.pers["cur_kill_streak"] >= 25) {
			give_killstreak("nuke");
			earnable_nuke();
		}

		self.previousKillNum = self.pers["cur_kill_streak"];
		wait 0.2;
	}
}

fullbright() {
	self.fullbright = !return_toggle(self.fullbright);
	if(self.fullbright) {
		iPrintString("Fullbright [^2ON^7]");
		setDvar("r_fullbright", 1);
		wait 0.01;
	} else {
		iPrintString("Fullbright [^1OFF^7]");
		setDvar("r_fullbright", 0);
		wait 0.01;
	}
}

third_person() {
	self.third_person = !return_toggle(self.third_person);
	if(self.third_person) {
		iPrintString("Third Person [^2ON^7]");
		setDvar("camera_thirdPerson", 1);
	} else {
		iPrintString("Third Person [^1OFF^7]");
		setDvar("camera_thirdPerson", 0);
	}
}

set_speed(value) {
	setDvar("g_speed", value);
}

set_timescale(value) {
	setDvar("timescale", value);
}

set_gravity(value) {
	setDvar("bg_gravity", value);
}

set_vision(vision) {
	self visionSetNakedForPlayer("", 0.1);
	wait 0.25;
	self visionSetNakedForPlayer(vision, 0.1);
}

// Player Options

print_player_name(target) {
	iPrintString(target);
}

commit_suicide(target) {
	target suicide();
}

kick_player(target) {
	kick(target getEntityNumber());
}

set_difficulty(difficulty, target) {
	difficulty = tolower(difficulty);
	target thread set_difficulty_loop(difficulty, target);
}

set_difficulty_loop(difficulty, target) {
	target endon("disconnect");
  level endon("game_ended");

  for(;;) {
    target waittill("spawned_player");

		target.var_2D32 = difficulty;
		target scripts\mp\bots\bots_util::bot_set_difficulty(difficulty);
	}
}

get_difficulty(target) {
	iPrintString(target.difficulty);
}

// Killstreaks

give_killstreak(streak) {
	self thread scripts\mp\hud_message::showkillstreaksplash(streak, undefined, 1);
	self scripts\mp\killstreaks\killstreaks::awardkillstreak(streak, self);
}

// Perks

give_all_perks() {
	foreach(perk in self.syn["perks"][0]) {
		scripts\mp\utility::giveperk(perk);
	}

	self thread scripts\mp\hud_message::showsplash("specialty_specialist");
}

take_all_perks() {
	foreach(perk in self.syn["perks"][0]) {
		take_perk(perk);
	}
}

give_perk(perk) {
	scripts\mp\utility::giveperk(perk);
	self thread scripts\mp\hud_message::showsplash("specialty_specialist");
}

take_perk(perk) {
	if(scripts\mp\utility::_hasperk(perk)) {
		scripts\mp\utility::removeperk(perk);
	}
}

// Weapon Options

give_weapon(weapon, category, index) {
	if(self getCurrentWeapon() != weapon && self getWeaponsListPrimaries()[1] != weapon && self getWeaponsListPrimaries()[2] != weapon && self getWeaponsListPrimaries()[3] != weapon && self getWeaponsListPrimaries()[4] != weapon) {
		max_weapon_num = 2;
		if(self getWeaponsListPrimaries().size >= max_weapon_num) {
			self _takeweapon(self getCurrentWeapon());
		}

		self _giveweapon(weapon);
		self _switchToWeapon(weapon);
	} else {
		self _switchToWeaponImmediate(weapon);
	}
	wait 1;
	self setWeaponAmmoClip(self getCurrentWeapon(), 999);
	self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
	self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
}

take_weapon() {
	self _takeweapon(self getCurrentWeapon());
	self _switchToWeapon(self getWeaponsListPrimaries()[0]);
}

drop_weapon() {
	self dropitem(self getCurrentWeapon());
	self _switchToWeapon(self getWeaponsListPrimaries()[0]);
}

// Account Options

set_prestige(value){
	self setPlayerData("mp", "progression", "playerLevel", "prestige", value);
}

set_rank(value) {
	value--;
	self setPlayerData("mp", "progression", "playerLevel", "xp", int(TableLookup("mp/rankTable.csv", 0, value, (value == int(TableLookup("mp/rankTable.csv", 0, "maxrank", 1))) ? 7 : 2)));
}

set_xp_scale(xpScale) {
	iPrintString("XP Multiplier Set to [^3" + xpScale + "x^7]");
	setDvar("online_mp_xpscale", xpScale);
	setDvar("online_mp_party_xpscale", xpScale);
	setDvar("online_mp_weapon_xpscale", xpScale);

	self.rankxpmultipliers["online_mp_xpscale"] = xpScale;
	self.weaponrankxpmultipliers["online_mp_party_weapon_xpscale"] = xpScale;
}

set_max_weapons() {
	for(x = 1; x < 62; x++) {
		weapon = TableLookup("mp/statstable.csv", 0, x, 4);

		if(!isDefined(weapon) || weapon == "")
			continue;

		self setPlayerData("common", "sharedProgression", "weaponLevel", weapon, "mpXP", 54300);
		self setPlayerData("common", "sharedProgression", "weaponLevel", weapon, "prestige", 3);

		iPrintString("Set ^3" + weapon + "^7 to Max Level");

		wait 0.175;
	}
}

complete_active_contracts() {
	contracts = getArrayKeys(self.contracts);

	if(!isDefined(contracts) || !contracts.size) {
		return;
	}

	foreach(contract in contracts) {
		target = self.contracts[contract].target;
		progress = self getRankedPlayerData("mp", "contracts", "challenges", contract, "progress");

		if(!isDefined(progress) || !isDefined(target) || progress >= target) {
			continue;
		}

		self setPlayerData("mp", "contracts", "challenges", contract, "progress", target);
		self setPlayerData("mp", "contracts", "challenges", contract, "completed", 1);

		wait 0.01;
	}
}