#include scripts\mp\utility;
#include scripts\mp\weapons;

init() {
	executeCommand("sv_cheats 1");

	level initial_precache();
	level thread player_connect();
	level thread create_rainbow_color();

	level thread session_expired();
}

initial_precache() {
	precacheshader("ui_scrollbar_arrow_right");
	precacheshader("ui_scrollbar_arrow_left");
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
	self.syn["weapons"]["melees"][0] =             ["iw7_fists_mp", "iw7_knife_mp", "iw7_axe_mpr_melee", "iw7_axe_mp", "iw7_katana_mp", "iw7_nunchucks_mp"];
	self.syn["weapons"]["specials"][0] =           ["iw7_atomizer_mp", "iw7_penetrationrail_mp+penetrationrailscope", "iw7_steeldragon_mp", "iw7_claw_mp", "iw7_blackholegun_mp+blackholegunscope"];
	// Weapon Names
	self.syn["weapons"]["assault_rifles"][1] =     ["NV4", "R3K", "KBAR-32", "Type-2", "Volk", "R-VN", "X-Con", "G-Rail", "Erad"];
	self.syn["weapons"]["sub_machine_guns"][1] =   ["FHR-40", "Karma-45", "RPR Evo", "HVR", "VPR", "Trencher", "Raijin-EMX"];
	self.syn["weapons"]["light_machine_guns"][1] = ["R.A.W.", "Mauler", "Titan", "Auger", "Atlas"];
	self.syn["weapons"]["sniper_rifles"][1] =      ["KBS Longbow", "EBR-800", "Widowmaker", "DMR-1", "Trek-50", "Proteus"];
	self.syn["weapons"]["shotguns"][1] =           ["Reaver", "Banshee", "DCM-8", "Rack-9", "M.2187"];
	self.syn["weapons"]["pistols"][1] =            ["EMC", "Oni", "Kendall 44", "Hailstorm", "UDM", "Stallion 44"];
	self.syn["weapons"]["launchers"][1] =          ["Spartan SA3", "Howitzer", "P-Law", "Venom-X"];
	self.syn["weapons"]["classics"][1] =           ["M1", "Hornet", "MacTav-45", "S-Ravage", "OSA", "TF-141"];
	self.syn["weapons"]["melees"][1] =             ["Fists", "Combat Knife", "Axe", "Fancy Axe", "Katana", "Nunchucks"];
	self.syn["weapons"]["specials"][1] =           ["Eraser", "Ballista EM3", "Steel Dragon", "Claw", "Gravity Vortex Gun"];
	
	// Perks
	self.syn["perks"][0] = ["specialty_expanded_minimap", "specialty_blindeye", "specialty_blastshield", "specialty_dexterity", "specialty_ghost", "specialty_overclock",  "specialty_stun_resistance", "specialty_hardline", "specialty_momentum", "specialty_tracker", "specialty_coldblooded", "specialty_scavenger", "specialty_sprintfire", "specialty_bullet_outline", "specialty_empimmune", "specialty_marksman", "specialty_engineer", "specialty_quieter", "specialty_explosivebullets", "specialty_fasterlockon", "specialty_rearguard", "specialty_delaymine", "specialty_superpack", "specialty_spygame", "specialty_no_target", "specialty_localjammer"];
	self.syn["perks"][1] = ["Recon", "Blind Eye", "Blast Shield", "Dexterity", "Ghost", "Overclock", "Tac Resist", "Hardline", "Momentum", "Tracker", "Cold Blooded", "Scavenger", "Gung-Ho", "Pin Point", "Hardwired", "Marksman", "Engineer", "Dead Silence", "Explosive Bullets", "Faster Launcher Lock-On", "Shield on Back", "Delay Mines", "Payload Pack", "No Player Name on Hover", "AI No Target", "Scrambler"];
	
	// Killstreaks
	self.syn["killstreaks"][0] = ["Scarab", "UAV", "Drone Package", "Counter UAV", "Vulture", "Trinity Rocket", "Scorchers", "Bombardment", "Shock Sentry", "Warden", "Advanced UAV", "T.H.O.R", "R-C8", "AP-3X", "Nuke"];
	self.syn["killstreaks"][1] = ["venom", "uav", "dronedrop", "counter_uav", "ball_drone_backup", "drone_hive", "precision_airstrike", "bombardment", "sentry_shock", "jackal", "directional_uav", "thor", "remote_c8", "minijackal", "nuke"];
}

initial_observer() {
	level endon("game_ended");
	self endon("disconnect");
	while(self has_access()) {
		if(!self in_menu()) {
			if(self adsButtonPressed() && self meleeButtonPressed()) {
				if(self.interaction_enabled) {
					self playSoundToPlayer("copycat_steal_class", self);
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
					self playSoundToPlayer("mp_adrenaline_off", self);
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
						self playSoundToPlayer("mp_cranked_countdown", self);
					}

					scrolling = self attackButtonPressed() ? 1 : -1;

					self set_cursor((cursor + scrolling));
					self update_scrolling(scrolling);
				}

				wait (0.05 * self.scrolling_buffer);
			} else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || !self fragButtonPressed() && self secondaryOffhandButtonPressed()) {
				if(isDefined(self.structure[cursor].array) || isDefined(self.structure[cursor].increment)) {
					if(self.interaction_enabled) {
						self playSoundToPlayer("mp_killstreak_warden_switch_mode", self);
					}

					scrolling = self secondaryOffhandButtonPressed() ? 1 : -1;

					self update_slider(scrolling);
					self update_progression();
				}

				wait (0.05 * self.scrolling_buffer);
			} else if(self useButtonPressed()) {
				if(isDefined(self.structure[cursor]) && isDefined(self.structure[cursor].function)) {
					if(self.interaction_enabled) {
						self playSoundToPlayer("mp_killstreak_screen_start", self);
					}

					if(isDefined(self.structure[cursor].array) || isDefined(self.structure[cursor].increment)) {
						self thread execute_function(self.structure[cursor].function, isDefined(self.structure[cursor].array) ? self.structure[cursor].array[self.slider[(menu + "_" + cursor)]] : self.slider[(menu + "_" + cursor)], self.structure[cursor].parameter_1, self.structure[cursor].parameter_2);
					} else {
						self thread execute_function(self.structure[cursor].function, self.structure[cursor].parameter_1, self.structure[cursor].parameter_2);
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
	for (;;) {
		event_name = self scripts\engine\utility::waittill_any_return("spawned_player", "player_downed", "death", "joined_spectators");
		switch (event_name) {
			case "spawned_player":
				self.spawn_origin = self.origin;
				self.spawn_angles = self.angles;
				if(!isDefined(self.finalized) && self has_access()) {
					self.finalized = true;
					
					if(self isHost()) {
						self freezeControls(false);
					}
		
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
				break;
			default:
				if(!self has_access()) {
					continue;
				}
		
				if(self in_menu()) {
					self close_menu();
				}
				break;
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
	for(;;) {
		level waitTill("connected", player);
		player.access = self isHost() ? "Host" : "None";
		
		if(isBot(player)) {
			return;
		}
		
		player thread event_system();
	}
}

player_disconnect() {
	[[level.player_disconnect]]();
}

player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
	if(isDefined(self.god_mode) && self.god_mode) {
		return;
	}
	[[level.player_damage]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime);
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

	for (a = 0; a < array.size; a++) {
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
		wait .05;
	}
}

start_rainbow() {
	while(isDefined(self)) {
		self fadeOverTime(.05);
		self.color = level.rainbow_color;
		wait .05;
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
	
	if(color != "rainbow") {
		textElement.color = color;
	} else {
		textElement.color = level.rainbow_color;
		textElement thread start_rainbow();
	}
	
	if(isNumber(text)) {
		textElement setValue(text);
	} else {
		textElement set_text(text);
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
	for (a = 0; a < text.size; a++) {
		illegal = ["player", "weapon", "wpn", "viewmodel", "camo"];
		replacement = " ";
		if(in_array(illegal, text[a])) {
			for (b = 0; b < text[a].size; b++) {
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
	for (a = 0; a < name.size; a++) {
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
	for (a = 0; a < keys.size; a++) {
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
	for (a = 0; a < element.size; a++) {
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

	for (a = (name.size - 1); a >= 0; a--) {
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
	return option[randomInt(option.size)];
}

empty_function() {}

execute_function(function, parameter_1, parameter_2, parameter_3) {
	self endon("disconnect");
	if(!isDefined(function)) {
		return;
	}

	if(isDefined(parameter_3)) {
		return self thread[[function]](parameter_1, parameter_2, parameter_3);
	}

	if(isDefined(parameter_2)) {
		return self thread[[function]](parameter_1, parameter_2);
	}

	if(isDefined(parameter_1)) {
		return self thread[[function]](parameter_1);
	}

	self thread[[function]]();
}

add_menu(title, menu_size, extra) {
	self.structure = [];
	self set_title(title);
	
	if(!isDefined(self get_cursor())) {
		self set_cursor();
	}
	
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

add_option(text, description, function, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.function = isDefined(function) ? function : ::empty_function;
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

add_toggle(text, description, function, variable, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.function = isDefined(function) ? function : ::empty_function;
	option.toggle = isDefined(variable) && variable;
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

add_array(text, description, function, array, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.function = isDefined(function) ? function : ::empty_function;
	option.array = isDefined(array) && isArray(array) ? array : [];
	option.parameter_1 = parameter_1;
	option.parameter_2 = parameter_2;

	self.structure[self.structure.size] = option;
}

add_increment(text, description, function, start, minimum, maximum, increment, parameter_1, parameter_2) {
	option = spawnStruct();
	option.text = text;
	option.description = description;
	option.function = isDefined(function) ? function : ::empty_function;
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

		self.previous[self.previous.size] = self get_menu();;
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

		if(!isDefined(self.menu["toggle"][1])) {
			self.menu["toggle"][1] = [];
		}

		menu = self get_menu();
		cursor = self get_cursor();
		maximum = min(self.structure.size, self.option_limit);
		for (a = 0; a < maximum; a++) {
			start = self get_cursor() >= int((self.option_limit / 2)) && self.structure.size > self.option_limit ? (((self get_cursor() + int((self.option_limit / 2))) >= (self.structure.size - 1)) ? (self.structure.size - self.option_limit) : (self get_cursor() - int((self.option_limit / 2)))) : 0;
			index = (a + start);
			if(isDefined(self.structure[index].function) && self.structure[index].function == ::new_menu) {
				self.menu["submenu"][index] = self create_shader("ui_scrollbar_arrow_right", "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["cursor"].width - 1)), (self.y_offset + ((a * self.option_spacing) + 20.5)), 7, 7, (cursor == index) ? (0.75, 0.75, 0.75) : (0.5, 0.5, 0.5), 1, 10);
			}

			if(isDefined(self.structure[index].toggle)) { // Toggle Off
				self.menu["toggle"][0][index] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 14), (self.y_offset + ((a * self.option_spacing) + 19)), 10, 10, (0.25, 0.25, 0.25), 1, 9);
				if(self.structure[index].toggle) { // Toggle On
					self.menu["toggle"][1][index] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 13), (self.y_offset + ((a * self.option_spacing) + 20)), 8, 8, (1, 1, 1), 1, 10);
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

			self.menu["text"][index] = self create_text((isDefined(self.structure[index].array) || isDefined(self.structure[index].increment)) ? (self.structure[index].text + ":") : self.structure[index].text, self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", isDefined(self.structure[index].toggle) ? (self.x_offset + 16) : (!isDefined(self.structure[index].function) ? (self.x_offset + (self.menu["cursor"].width / 2)) : (self.x_offset + 4)), (self.y_offset + ((a * self.option_spacing) + 20)), !isDefined(self.structure[index].function) ? self.color_theme : ((cursor == index) ? (0.75, 0.75, 0.75) : (0.5, 0.5, 0.5)), 1, 10);
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
	if(isDefined(self.structure[self get_cursor()]) && !isDefined(self.structure[self get_cursor()].function)) {
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
	adjustment = self.structure.size > self.option_limit ? ((180 / self.structure.size) * maximum) : height;
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
			self add_option("Give Killstreaks", undefined, ::new_menu, "Give Killstreaks");
			self add_option("Account Options", undefined, ::new_menu, "Account Options");
			self add_option("Menu Options", undefined, ::new_menu, "Menu Options");
			
			break;
		case "Basic Options":
			self add_menu(menu, menu.size);
			
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
			self add_menu(menu, menu.size);
			
			self add_toggle("Forge Mode", "Pick Up/Move some Objects", ::forge_mode, self.forge_mode);
			
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
			self add_menu(menu, menu.size);
			
			self add_option("Give Weapons", undefined, ::new_menu, "Give Weapons");

			self add_option("Take Current Weapon", undefined, ::take_weapon);
			self add_option("Drop Current Weapon", undefined, ::drop_weapon);
			
			break;
		case "Give Killstreaks":
			self add_menu(menu, menu.size, 1);
			
			for(i = 0; i < self.syn["killstreaks"][0].size; i++) {
				self add_option(self.syn["killstreaks"][0][i], undefined, ::give_killstreak, self.syn["killstreaks"][1][i]);
			}
			
			break;
		case "Account Options":
			self add_menu(menu, menu.size);
			
			self add_increment("Set Prestige", undefined, ::set_prestige, 0, 0, 30, 1);
			self add_increment("Set Level", undefined, ::set_rank, 1, 1, 55, 1);
			self add_increment("Set XP Scale", undefined, ::set_xp_scale, 1, 1, 10, 1);
			
			self add_option("Set Weapons to Max Level", undefined, ::set_max_weapons);
			
			self add_option("Complete Active Contracts", undefined, ::complete_active_contracts);
			
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
		case "Give Perks":
			self add_menu(menu, menu.size);
			
			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], undefined, ::give_perk, self.syn["perks"][0][i], 0);
			}

			break;
		case "Take Perks":
			self add_menu(menu, menu.size);
			
			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], undefined, ::take_perk, self.syn["perks"][0][i]);
			}

			break;
		case "Give Weapons":
			self add_menu(menu, menu.size);
			
			for(i = 0; i < self.syn["weapons"]["category"].size; i++) {
				self add_option(self.syn["weapons"]["category"][i], undefined, ::new_menu, self.syn["weapons"]["category"][i]);
			}
			
			break;
		case "Visions":
			self add_menu(menu, menu.size);
			
			for(i = 0; i < self.syn["visions"][0].size; i++) {
				self add_option(self.syn["visions"][0][i], undefined, ::set_vision, self.syn["visions"][1][i]);
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
		case "Launchers":
			self add_menu(menu, menu.size);
			
			category = "launchers";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Classic Weapons":
			self add_menu(menu, menu.size);
			
			category = "classics";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Melee Weapons":
			self add_menu(menu, menu.size);
			
			category = "melees";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], undefined, ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Specialist Weapons":
			self add_menu(menu, menu.size);
			
			category = "specials";
			
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
		self.syn["string"] = self create_text(string, "default", 1, "center", "top", 0, -100, (1,1,1), 1, 9999, false, true);
	} else {
		self.syn["string"] set_text(string);
	}
	self.syn["string"] notify("stop_hud_fade");
	self.syn["string"].alpha = 1;
	self.syn["string"] setText(string);
	self.syn["string"] thread fade_hud(0, 4);
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
	open_menu("Menu Options");
	self.menu["title"].x = 264.2;
}

set_menu_rainbow() {
	if(!isString(self.color_theme)) {
		self.color_theme = "rainbow";
		self close_menu();
		open_menu("Menu Options");
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
	open_menu("Menu Options");
	self.menu["title"].x = 264.2;
}

watermark() {
	self.watermark = !return_toggle(self.watermark);
	if(self.watermark) {
		iPrintString("Watermark [^2ON^7]");
		if(!isDefined(self.syn["watermark"])) {
			self.syn["watermark"] = self create_text("SyndiShanX", self.font, 1, "TOP_LEFT", "TOPCENTER", 350, 10, "rainbow", 1, 3);
		}
	} else {
		iPrintString("Watermark [^1OFF^7]");
		self.syn["watermark"] destroy();
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
	wait .01;
	if(self.god_mode) {
		iPrintString("God Mode [^2ON^7]");
	} else {
		iPrintString("God Mode [^1OFF^7]");
	}
}

no_clip() {
	self.no_clip = !return_toggle(self.no_clip);
	executecommand("noclip");
	wait .01;
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
			wait .05;
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
		wait .01;
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
		wait .05;
	}

	clip delete();
	self enableWeapons();
	self enableOffhandWeapons();

	if(isDefined(self.temp_god_mode)) {
		executeCommand("god");
		wait .01;
		iPrintString("");
		self.temp_god_mode = undefined;
	}

	self.frag_no_clip_loop = undefined;
}

ufo_mode() {
	self.ufo_mode = !return_toggle(self.ufo_mode);
	executecommand("ufo");
	wait .01;
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
	self endOn("stop_infinite_ammo");
	self endOn("game_ended");
	
	for(;;) {
		self setWeaponAmmoClip(self getCurrentWeapon(), 999);
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
		self scripts\mp\powers::power_adjustcharges(2, "primary", 2);
		self scripts\mp\powers::power_adjustcharges(2, "secondary", 2);
		wait .2;
	}
}

// Fun Options

forge_mode() {
	self.forge_mode = !return_toggle(self.forge_mode);
	if(self.forge_mode) {
		iPrintString("Forge Mode [^2ON^7], Press ^3[{+speed_throw}]^7 to Pick Up/Drop Objects");
		self thread forge_mode_loop();
	} else {
		iPrintString("Forge Mode [^1OFF^7]");
		self notify("stop_forge_mode");
	}
}

forge_mode_loop() {
	self endon("death");
	self endon("stop_forge_mode");
	while(true) {
		trace = bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, true, self);
		if(isDefined(trace["entity"])) {
			while(self adsButtonPressed()) {
				trace["entity"] moveTo(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
				trace["entity"].origin = self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200;
				wait .01;
				
				if(self attackButtonPressed()) {
					while(self attackButtonPressed()) {
						trace["entity"] rotatePitch(1, .01);
						trace["entity"] moveTo(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
						trace["entity"].origin = self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200;
						wait .01;
					}
				}
				if(self fragButtonPressed()) {
					while(self fragButtonPressed()) {	 
						trace["entity"] rotateYaw(1, .01);
						trace["entity"] moveTo(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
						trace["entity"].origin = self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200;
						wait .01;
					}
				}
				if(self secondaryOffhandButtonPressed()) {
					while(self secondaryOffhandButtonPressed()) {	 
						trace["entity"] rotateRoll(1, .01);
						trace["entity"] moveTo(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
						trace["entity"].origin = self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200;
						wait .01;
					}
				}
				if(!isPlayer( trace["entity"]) && self meleeButtonPressed()) {
					trace["entity"] delete();
					wait .2;
				}
				wait .01;
			}
		}
		wait .05;
	}
}

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
	self endOn("stop_earnable_nuke");
	self endOn("game_ended");
	
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
		wait .2;
	}
}

fullbright() {
	self.fullbright = !return_toggle(self.fullbright);
	if(self.fullbright) {
		iPrintString("Fullbright [^2ON^7]");
		setdvar("r_fullbright", 1);
		wait .01;
	} else {
		iPrintString("Fullbright [^1OFF^7]");
		setdvar("r_fullbright", 0);
		wait .01;
	}
}

third_person() {
	self.third_person = !return_toggle(self.third_person);
	if(self.third_person) {
		iPrintString("Third Person [^2ON^7]");
		setdvar("camera_thirdPerson", 1);
	} else {
		iPrintString("Third Person [^1OFF^7]");
		setdvar("camera_thirdPerson", 0);
	}
}

set_speed(value) {
	setdvar("g_speed", value);
}

set_timescale(value) {
	setDvar("timescale", value);
}

set_gravity(value) {
	setDvar("bg_gravity", value);
}

set_vision(vision) {
	self visionSetNakedForPlayer("", 0.1);
	wait .25;
	self visionSetNakedForPlayer(vision, 0.1);
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
	self setPlayerData("mp", "progression", "playerLevel", "xp", Int(TableLookup("mp/rankTable.csv", 0, value, (value == Int(TableLookup("mp/rankTable.csv", 0, "maxrank", 1))) ? 7 : 2)));
}

set_xp_scale(xpScale) {
	iPrintString("XP Multiplier Set to [^3" + xpScale + "x^7]");
	setdvar("online_mp_xpscale", xpScale);
	setdvar("online_mp_party_xpscale", xpScale);
	setdvar("online_mp_weapon_xpscale", xpScale);

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