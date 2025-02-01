#include scripts\mp\utility;
#include scripts\mp\weapons;

init() {
	level.username = "Username";
	setup();
}

return_toggle(variable) {
	return isDefined(variable) && variable;
}

really_alive() {
	return isAlive(self) && !return_toggle(self.lastStand);
}

get_menu() {
	return self.syn["menu"];
}

get_cursor() {
	return self.cursor[self get_menu()];
}

get_title() {
	return self.syn["title"];
}

set_menu(menu) {
	if(isDefined(menu)) {
		self.syn["menu"] = menu;
	}
}

set_cursor(cursor, menu) {
	if(isDefined(cursor)) {
		self.cursor[isDefined(menu) ? menu : self get_menu()] = cursor;
	}
}

set_title(title) {
	if(isDefined(title)) {
		self.syn["title"] = title;
	}
}

has_menu() {
	return return_toggle(self.syn["user"].has_menu);
}

in_menu() {
	return return_toggle(self.syn["utility"].in_menu);
}

set_state() {
	self.syn["utility"].in_menu = !return_toggle(self.syn["utility"].in_menu);
}

execute_function(function, argument_1, argument_2, argument_3, argument_4) {
	if(!isDefined(function)) {
		return;
	}
	
	if(isDefined(argument_4)) {
		return self thread [[function]](argument_1, argument_2, argument_3, argument_4);
	}
	
	if(isDefined(argument_3)) {
		return self thread [[function]](argument_1, argument_2, argument_3);
	}
	
	if(isDefined(argument_2)) {
		return self thread [[function]](argument_1, argument_2);
	}
	
	if(isDefined(argument_1)) {
		return self thread [[function]](argument_1);
	}
	
	return self thread [[function]]();
}

set_slider(scrolling, index) {
	menu = self get_menu();
	index = isDefined(index) ? index : self get_cursor();
	storage = (menu + "_" + index);
	if(!isDefined(self.slider[storage])) {
		self.slider[storage] = isDefined(self.structure[index].array) ? 0 : self.structure[index].start;
	}
	
	if(!isDefined(self.structure[index].array)) {
		self notify("increment_slider");
		if(scrolling == -1)
			self.slider[storage] += self.structure[index].increment;
		
		if(scrolling == 1)
			self.slider[storage] -= self.structure[index].increment;
		
		if(self.slider[storage] > self.structure[index].maximum)
			self.slider[storage] = self.structure[index].minimum;
		
		if(self.slider[storage] < self.structure[index].minimum)
			self.slider[storage] = self.structure[index].maximum;
		
		position = abs((self.structure[index].maximum - self.structure[index].minimum)) / ((50 - 8));
		
		if(!self.structure[index].text_slider) {
			self.syn["hud"]["slider"][0][index] setValue(self.slider[storage]);
		} else {
			self.syn["hud"]["slider"][0][index].x = self.syn["utility"].x_offset + 85;
			if(self.structure[index].slider_text == "outline") {
				self.syn["hud"]["slider"][0][index] setText(self.syn["outline_colors"][self.slider[storage]]);
			}
		}
		self.syn["hud"]["slider"][2][index].x = (self.syn["hud"]["slider"][1][index].x + (abs((self.slider[storage] - self.structure[index].minimum)) / position));
	}
}

clear_option() {
	for(i = 0; i < self.syn["utility"].element_list.size; i++) {
		clear_all(self.syn["hud"][self.syn["utility"].element_list[i]]);
		self.syn["hud"][self.syn["utility"].element_list[i]] = [];
	}
}

check_option(player, menu, cursor) {
	if(isDefined(self.structure) && self.structure.size) {
		for(i = 0; i < self.structure.size; i++) {
			if(player.structure[cursor].text == self.structure[i].text && self get_menu() == menu) {
				return true;
			}
		}
	}

	return false;
}

fade_hud(alpha, time) {
	self endon("stop_hud_fade");
	self fadeOverTime(time);
	self.alpha = alpha;
	wait time;
}

create_text(text, font, font_scale, align_x, align_y, x, y, color, alpha, z_index, hide_when_in_menu, archive) {
	textElement = newClientHudElem(self);
	textElement.font = font;
	textElement.fontscale = font_scale;
	textElement.alpha = alpha;
	textElement.sort = z_index;
	textElement.foreground = true;
	if(isDefined(hide_when_in_menu)) {
		textElement.hideWhenInMenu = hide_when_in_menu;
	} else {
		textElement.hideWhenInMenu = true;
	}
	
	if(isDefined(archive)) {
		textElement.archived = archive;
	} else {
		textElement.archived = false;
	}
	
	textElement.x = x;
	textElement.y = y;
	textElement.alignX = align_x;
	textElement.alignY = align_y;
	textElement.horzAlign = align_x;
	textElement.vertAlign = align_y;
	
	if(color != "rainbow") {
		textElement.color = color;
	} else {
		textElement.color = level.rainbow_color;
		textElement thread start_rainbow();
	}
	
	if(isnumber(text)) {
		textElement setValue(text);
	} else {
		textElement set_text(text);
	}
	
	return textElement;
}

set_text(text) {
	if(!isDefined(self) || !isDefined(text)) {
		return;
	}
	
	self.text = text;
	self setText(text);
}

create_shader(shader, align_x, align_y, x, y, width, height, color, alpha, z_index) {
	shaderElement = newClientHudElem(self);
	shaderElement.elemType = "icon";
	shaderElement.children = [];
	shaderElement.alpha = alpha;
	shaderElement.sort = z_index;
	shaderElement.archived = true;
	shaderElement.foreground = true;
	shaderElement.hidden = false;
	shaderElement.hideWhenInMenu = true;
	
	shaderElement.x = x;
	shaderElement.y = y;
	shaderElement.alignX = align_x;
	shaderElement.alignY = align_y;
	shaderElement.horzAlign = align_x;
	shaderElement.vertAlign = align_y;
	
	if(color != "rainbow") {
		shaderElement.color = color;
	} else {
		shaderElement.color = level.rainbow_color;
		shaderElement thread start_rainbow();
	}
	
	shaderElement set_shader(shader, width, height);
	
	return shaderElement;
}

set_shader(shader, width, height) {
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

clear_all(array) {
	if(!isDefined(array)) {
		return;
	}
	
	keys = getArrayKeys(array);
	for(a = 0; a < keys.size; a++) {
		if(isArray(array[keys[a]])) {
			forEach(value in array[keys[a]])
				if( isDefined(value)) {
					value destroy();
				}
		} else {
			if(isDefined(array[keys[a]])) {
				array[keys[a]] destroy();
			}
		}
	}
}

add_menu(title, menu_size, extra) {
	if(isDefined(title)) {
		self set_title(title);
		if(isDefined(extra)) {
			self.syn["hud"]["title"][0].x = self.syn["utility"].x_offset + 86 - menu_size - extra;
		} else {
			self.syn["hud"]["title"][0].x = self.syn["utility"].x_offset + 86 - menu_size;
		}
	}

	self.structure = [];
}

add_option(text, function, argument_1, argument_2, argument_3) {
	option = spawnStruct();
	option.text = text;
	option.function = function;
	option.argument_1 = argument_1;
	option.argument_2 = argument_2;
	option.argument_3 = argument_3;
	
	self.structure[self.structure.size] = option;
}

add_toggle(text, function, toggle, array, argument_1, argument_2, argument_3) {
	option = spawnStruct();
	option.text = text;
	option.function = function;
	option.toggle = return_toggle(toggle);
	option.argument_1 = argument_1;
	option.argument_2 = argument_2;
	option.argument_3 = argument_3;
	
	if(isDefined(array)) {
		option.slider = true;
		option.array  = array;
	}
	
	self.structure[self.structure.size] = option;
}

add_string(text, function, array, argument_1, argument_2, argument_3) {
	option = spawnStruct();
	option.text = text;
	option.function = function;
	option.slider = true;
	option.array = array;
	option.argument_1 = argument_1;
	option.argument_2 = argument_2;
	option.argument_3 = argument_3;
	
	self.structure[self.structure.size] = option;
}

add_increment(text, function, start, minimum, maximum, increment, text_slider, slider_text, argument_1, argument_2, argument_3) {
	option = spawnStruct();
	option.text = text;
	option.function = function;
	option.slider = true;
	option.text_slider = text_slider;
	option.slider_text = slider_text;
	option.start = start;
	option.minimum = minimum;
	option.maximum = maximum;
	option.increment = increment;
	option.argument_1 = argument_1;
	option.argument_2 = argument_2;
	option.argument_3 = argument_3;
	
	self.structure[self.structure.size] = option;
}

add_category(text) {
	option = spawnStruct();
	option.text = text;
	option.category = true;
	
	self.structure[self.structure.size] = option;
}

new_menu(menu) {
	if(!isDefined(menu)) {
		menu = self.previous[(self.previous.size - 1)];
		self.previous[(self.previous.size - 1)] = undefined;
	} else {
		self.previous[self.previous.size] = self get_menu();
	}
	
	self set_menu(menu);
	self clear_option();
	self create_option();
}

initial_variable() {
	self.syn["utility"] = spawnStruct();
	self.syn["utility"].font = "objective";
	self.syn["utility"].font_scale = 0.7;
	self.syn["utility"].option_limit = 10;
	self.syn["utility"].option_spacing = 14;
	self.syn["utility"].x_offset = 30;
	self.syn["utility"].y_offset = 190;
	self.syn["utility"].element_list = ["text", "subMenu", "toggle", "category", "slider"];
	
	self.syn["visions"][0] = ["None", "AC-130", "AC-130 Enhanced", "AC-130 inverted", "Aftermath", "Aftermath Glow", "Aftermath Post", "Apex", "Black & White", "Lobby", "Afterlife", "Zombies", "Zombies in Spaceland", "Zombies in Spaceland Black & White", "Zombies in Spaceland Ghost Path", "Zombies in Spaceland Basement", "Zombies in Spaceland Triton", "Default", "Default Night", "Night Vision", "Dronehive", "Endgame", "Europa", "Jackal", "Last Stand", "MP Map Select", "Missile Cam", "MP Intro", "MP Outro", "MP Nuke", "MP Nuke Aftermath", "Frontier", "Out of Bounds", "Nuke Flash", "Optic Wave", "RC8", "Thor Bright", "Thor", "Venom Gas"];
	self.syn["visions"][1] = ["", "ac130", "ac130_enhanced_mp", "ac130_inverted", "aftermath", "aftermath_glow", "aftermath_post", "apex_mp", "black_bw", "cp_frontend", "cp_zmb_afterlife", "cp_zmb_alien", "cp_zmb", "cp_zmb_bw", "cp_zmb_ghost_path", "cp_zmb_int_basement", "cp_zmb_int_triton_main", "default", "default_night", "default_night_mp", "dronehive_mp", "end_game", "europa", "jackal_streak_mp", "last_stand_cp_zmb", "map_select_mp", "missilecam", "mpintro", "mpoutro", "mpnuke", "mpnuke_aftermath", "mp_frontier", "mp_out_of_bounds", "nuke_global_flash", "opticwave_mp", "rc8_mp", "thorbright_mp", "thor_mp", "venomgas_mp"];
	
	self.syn["weapons"]["category"] = ["Assault Rifles", "Sub Machine Guns", "Light Machine Guns", "Sniper Rifles", "Shotguns", "Pistols", "Launchers", "Classic Weapons", "Melee Weapons", "Specialist Weapons"];
	
	// Weapon IDs Plus Default Attachments
	self.syn["weapons"]["assault_rifles"][0] =     ["iw7_m4_mp", "iw7_sdfar_mp", "iw7_ar57_mp", "iw7_fmg_mp+akimbofmg+fmgscope_camo", "iw7_ake_mpr", "iw7_rvn_mp+meleervn+rvnscope", "iw7_vr_mp+vrscope", "iw7_gauss_mp+gaussscope", "iw7_erad_mp+eradscope_camo"];
	self.syn["weapons"]["sub_machine_guns"][0] =   ["iw7_fhr_mp", "iw7_crb_mpl+crblscope_camo", "iw7_ripper_mpr+ripperrscope_mp", "iw7_ump45_mpl+ump45lscope_camo", "iw7_crdb_mp", "iw7_mp28_mp", "iw7_tacburst_mp+gltacburst+tacburstscope"];
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
	self.syn["perks"][0] = ["specialty_expanded_minimap", "specialty_blindeye", "specialty_blastshield", "specialty_dexterity", "specialty_ghost", "specialty_overclock", "specialty_stun_resistance", "specialty_hardline", "specialty_momentum", "specialty_tracker", "specialty_coldblooded", "specialty_scavenger", "specialty_sprintfire", "specialty_bullet_outline", "specialty_empimmune", "specialty_marksman", "specialty_engineer", "specialty_quieter"];
	self.syn["perks"][1] = ["Recon", "Blind Eye", "Blast Shield", "Dexterity", "Ghost", "Overclock", "Tac Resist", "Hardline", "Momentum", "Tracker", "Cold Blooded", "Scavenger", "Gung-Ho", "Pin Point", "Hardwired", "Marksman", "Engineer", "Dead Silence"];
	
	// Killstreaks
	self.syn["killstreaks"][0] = ["Scarab", "UAV", "Drone Package", "Counter UAV", "Vulture", "Trinity Rocket", "Scorchers", "Bombardment", "Shock Sentry", "Warden", "Advanced UAV", "T.H.O.R", "R-C8", "AP-3X", "Nuke"];
	self.syn["killstreaks"][1] = ["venom", "uav", "dronedrop", "counter_uav", "ball_drone_backup", "drone_hive", "precision_airstrike", "bombardment", "sentry_shock", "jackal", "directional_uav", "thor", "remote_c8", "minijackal", "nuke"];
	
	self.syn["utility"].interaction = true;
	
	self.syn["utility"].color[0] = (0.752941176, 0.752941176, 0.752941176); // Selected Slider Thumb and Category Text
	self.syn["utility"].color[1] = (0.074509804, 0.070588235, 0.078431373); // Title Background and Unselected Slider Background
	self.syn["utility"].color[2] = (0.074509804, 0.070588235, 0.078431373); // Main Background, Selected Slider Background
	self.syn["utility"].color[3] = (0.243137255, 0.22745098, 0.247058824); // Cursor, Scrollbar Background, Unselected Slider Thumb, and Unchecked Toggle
	self.syn["utility"].color[4] = (1, 1, 1); // Text Color
	self.syn["utility"].color[5] = "rainbow"; // Outline and Separators
	
	self.cursor = [];
	self.previous = [];
	
	self set_menu("Synergy");
	self set_title(self get_menu());
}

initial_monitor() {
	self endOn("disconnect");
	level endOn("game_ended");
	while(true) {
		if(self really_alive()) {
			if(!self in_menu()) {
				if(self adsButtonPressed() && self meleeButtonPressed()) {
					if(return_toggle(self.syn["utility"].interaction)) {
						self playSoundToPlayer("copycat_steal_class", self);
					}
					
					close_controls_menu();
					
					self open_menu();
					wait .15;
				}
			} else {
				menu   = self get_menu();
				cursor = self get_cursor();
				if(self meleeButtonPressed()) {
					if(return_toggle(self.syn["utility"].interaction)) {
						self playSoundToPlayer("mp_adrenaline_off", self);
					}
					
					if(isDefined(self.previous[(self.previous.size - 1)])) {
						self new_menu(self.previous[menu]);
					} else {
						self close_menu();
					}
					
					wait .75; // Knife Cooldown
				}
				else if(self adsButtonPressed() && !self attackButtonPressed() || self attackButtonPressed() && !self adsButtonPressed()) {
					if(isDefined(self.structure) && self.structure.size >= 2) {
						if(return_toggle(self.syn["utility"].interaction)) {
							self playSoundToPlayer("mp_cranked_countdown", self);
						}
						
						scrolling = self attackButtonPressed() ? 1 : -1;
						
						self set_cursor((cursor + scrolling));
						self update_scrolling(scrolling);
					}
					wait .25; // Scroll Cooldown
				}
				else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || self secondaryOffhandButtonPressed() && !self fragButtonPressed()) {
					if(return_toggle(self.structure[cursor].slider)) {
						if(return_toggle(self.syn["utility"].interaction)) {
							self playSoundToPlayer("mp_killstreak_warden_switch_mode", self);
						}
						
						scrolling = self secondaryOffhandButtonPressed() ? 1 : -1;
						
						self set_slider(scrolling);
					}
					wait .07;
				}
				else if(self useButtonPressed()) {
					if(isDefined(self.structure[cursor].function)) {
						if(return_toggle(self.syn["utility"].interaction)) {
							self playSoundToPlayer("mp_killstreak_screen_start", self);
						}
						
						if(return_toggle(self.structure[cursor].slider)) {
							self thread execute_function(self.structure[cursor].function, isDefined(self.structure[cursor].array) ? self.structure[cursor].array[self.slider[menu + "_" + cursor]] :self.slider[menu + "_" + cursor], self.structure[cursor].argument_1, self.structure[cursor].argument_2, self.structure[cursor].argument_3);
						} else {
							self thread execute_function(self.structure[cursor].function, self.structure[cursor].argument_1, self.structure[cursor].argument_2, self.structure[cursor].argument_3);
						}
						
						if(isDefined(self.structure[cursor].toggle)) {
							self update_menu(menu, cursor);
						}
					}
					wait .2;
				}
			}
		}
		wait .05;
	}
}

open_menu(menu) {
	if(!isDefined(menu)) {
		menu = isDefined(self get_menu()) && self get_menu() != "Synergy" ? self get_menu() : "Synergy";
	}
	
	self.syn["hud"] = [];
	self.syn["hud"]["title"][0] = self create_text(self get_title(), self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 86), (self.syn["utility"].y_offset + 2), self.syn["utility"].color[4], 1, 10); // Title Text
	self.syn["hud"]["title"][1] = self create_text("______                                      ______", self.syn["utility"].font, self.syn["utility"].font_scale * 1.5, "left", "CENTER", (self.syn["utility"].x_offset + 4), (self.syn["utility"].y_offset - 4), self.syn["utility"].color[5], 1, 10); // Title Separator
	
	self.syn["hud"]["background"][0] = self create_shader("white", "left", "CENTER", self.syn["utility"].x_offset - 1, (self.syn["utility"].y_offset - 1), 202, 30, self.syn["utility"].color[5], 1, 1); // Outline
	self.syn["hud"]["background"][1] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset), self.syn["utility"].y_offset, 200, 28, self.syn["utility"].color[1], 1, 2); // Main Background
	self.syn["hud"]["foreground"][1] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset), (self.syn["utility"].y_offset + 14), 194, 14, self.syn["utility"].color[3], 1, 4); // Cursor
	self.syn["hud"]["foreground"][2] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset + 195), (self.syn["utility"].y_offset + 14), 4, 14, self.syn["utility"].color[3], 1, 4); // Scrollbar Background
	
	self set_menu(menu);
	self create_option();
	self set_state();
}

close_menu() {
	self clear_option();
	self clear_all(self.syn["hud"]);
	self set_state();
}

create_title(title) {
	self.syn["hud"]["title"][0] set_text(isDefined(title) ? title : self get_title());
}

create_option() {
	self clear_option();
	self menu_index();
	if(!isDefined(self.structure) || !self.structure.size) {
		self add_option("Currently No Options To Display");
	}
	
	if(!isDefined(self get_cursor())) {
		self set_cursor(0);
	}
	
	start = 0;
	if((self get_cursor() > int(((self.syn["utility"].option_limit - 1) / 2))) && (self get_cursor() < (self.structure.size - int(((self.syn["utility"].option_limit + 1) / 2)))) && (self.structure.size > self.syn["utility"].option_limit)) {
		start = (self get_cursor() - int((self.syn["utility"].option_limit - 1) / 2));
	}
	
	if((self get_cursor() > (self.structure.size - (int(((self.syn["utility"].option_limit + 1) / 2)) + 1))) && (self.structure.size > self.syn["utility"].option_limit)) {
		start = (self.structure.size - self.syn["utility"].option_limit);
	}
	
	self create_title();
	if(isDefined(self.structure) && self.structure.size) {
		limit = min(self.structure.size, self.syn["utility"].option_limit);
		for(i = 0; i < limit; i++) {
			index = (i + start);
			cursor = (self get_cursor() == index);
			color[0] = cursor ? self.syn["utility"].color[0] : self.syn["utility"].color[4];
			color[1] = return_toggle(self.structure[index].toggle) ? cursor ? self.syn["utility"].color[0] : self.syn["utility"].color[4] : cursor ? self.syn["utility"].color[2] : self.syn["utility"].color[3];
			if(isDefined(self.structure[index].function) && self.structure[index].function == ::new_menu) {
				self.syn["hud"]["subMenu"][index] = self create_text(">", self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 185), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 16)), self.syn["utility"].color[4], 1, 10);
			}
			
			if(isDefined(self.structure[index].toggle)) {
				self.syn["hud"]["toggle"][1][index] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset + 4), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 17)), 8, 8, color[1], 1, 10); // Toggle Box
			}
			
			for(x = 0; x < 15; x++) {
				if(x != self get_cursor()) {
					if(isDefined(self.syn["hud"]["arrow"][0][x])) {
						self.syn["hud"]["arrow"][0][x] destroy();
						self.syn["hud"]["arrow"][1][x] destroy();
					}
				}
			}
			
			if(return_toggle(self.structure[index].slider)) {
				if(isDefined(self.structure[index].array)) {
					self.syn["hud"]["slider"][0][index] = self create_text(self.structure[index].array[self.slider[self get_menu() + "_" + index]], self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 155), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 16)), color[0], 1, 10);
				} else {
					if(cursor) {
						self.syn["hud"]["slider"][0][index] = self create_text(self.slider[self get_menu() + "_" + index], self.syn["utility"].font, (self.syn["utility"].font_scale - 0.1), "left", "CENTER", (self.syn["utility"].x_offset + 155), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 17)), self.syn["utility"].color[4], 1, 10);
						self.syn["hud"]["arrow"][0][self get_cursor()] = self create_text("<", self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 129), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 16)), self.syn["utility"].color[4], 1, 10); // Slider Arrow
						self.syn["hud"]["arrow"][1][self get_cursor()] = self create_text(">", self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 185), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 16)), self.syn["utility"].color[4], 1, 10); // Slider Arrow
					} else {
						self.syn["hud"]["arrow"][0][index] destroy();
						self.syn["hud"]["arrow"][1][index] destroy();
					}
				
					self.syn["hud"]["slider"][1][index] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset + 135), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 17)), 50, 8, cursor ? self.syn["utility"].color[2] : self.syn["utility"].color[1], 1, 8); // Slider Background
					self.syn["hud"]["slider"][2][index] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset + 149), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 17)), 8, 8, cursor ? self.syn["utility"].color[0] : self.syn["utility"].color[3], 1, 9); // Slider Thumb
				}
				
				self set_slider(undefined, index);
			}
			
			if(return_toggle(self.structure[index].category)) {
				self.syn["hud"]["category"][0][index] = self create_text(self.structure[index].text, self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 88), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 17)), self.syn["utility"].color[0], 1, 10);
				self.syn["hud"]["category"][1][index] = self create_text("______                                      ______", self.syn["utility"].font, self.syn["utility"].font_scale * 1.5, "left", "CENTER", (self.syn["utility"].x_offset + 4), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 11)), self.syn["utility"].color[5], 1, 10); // Category Separator
			}
			else {
				if(return_toggle(self.shader_option[self get_menu()])) {
					self.syn["hud"]["text"][index] = self create_shader(isDefined(self.structure[index].text) ? self.structure[index].text : "white", "left", "CENTER", (self.syn["utility"].x_offset + ((i * 20) - ((limit * 10) - 110))), (self.syn["utility"].y_offset + 27), isDefined(self.structure[index].argument_2) ? self.structure[index].argument_2 : 18, isDefined(self.structure[index].argument_3) ? self.structure[index].argument_3 : 18, isDefined(self.structure[index].argument_1) ? self.structure[index].argument_1 : (1, 1, 1), cursor ? 1 : 0.2, 10);
				} else {
					self.syn["hud"]["text"][index] = self create_text(return_toggle(self.structure[index].slider) ? self.structure[index].text + ":" : self.structure[index].text, self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", isDefined(self.structure[index].toggle) ? (self.syn["utility"].x_offset + 15) : (self.syn["utility"].x_offset + 4), (self.syn["utility"].y_offset + ((i * self.syn["utility"].option_spacing) + 16)), color[0], 1, 10);
				}
			}
		}
		
		if(!isDefined(self.syn["hud"]["text"][self get_cursor()])) {
			self set_cursor((self.structure.size - 1));
		}
	}
	self update_resize();
}

update_scrolling(scrolling) {	
	if(return_toggle(self.structure[self get_cursor()].category)) {
		self set_cursor((self get_cursor() + scrolling));
		return self update_scrolling(scrolling);
	}
	
	if((self.structure.size > self.syn["utility"].option_limit) || (self get_cursor() >= 0) || (self get_cursor() <= 0)) {
		if((self get_cursor() >= self.structure.size) || (self get_cursor() < 0)) {
			self set_cursor((self get_cursor() >= self.structure.size) ? 0 : (self.structure.size - 1));
		}
		self create_option();
	}
	self update_resize();
}

update_resize() {
	limit = min(self.structure.size, self.syn["utility"].option_limit);
	height = int((limit * self.syn["utility"].option_spacing));
	adjust = (self.structure.size > self.syn["utility"].option_limit) ? int(((94 / self.structure.size) * limit)) : height;
	position = (self.structure.size - 1) / (height - adjust);
	if(!return_toggle(self.shader_option[self get_menu()])) {
		if(!isDefined(self.syn["hud"]["foreground"][1])) {
			self.syn["hud"]["foreground"][1] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset), (self.syn["utility"].y_offset + 14), 194, 14, self.syn["utility"].color[3], 1, 4); // Cursor
		}
		
		if(!isDefined(self.syn["hud"]["foreground"][2])) {
			self.syn["hud"]["foreground"][2] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset + 195), (self.syn["utility"].y_offset + 14), 4, 14, self.syn["utility"].color[3], 1, 4); // Scrollbar
		}
	}
	
	self.syn["hud"]["background"][0] set_shader(self.syn["hud"]["background"][0].shader, self.syn["hud"]["background"][0].width, return_toggle(self.shader_option[self get_menu()]) ? 42 : (height + 16));
	self.syn["hud"]["background"][1] set_shader(self.syn["hud"]["background"][1].shader, self.syn["hud"]["background"][1].width, return_toggle(self.shader_option[self get_menu()]) ? 40 : (height + 14));
	self.syn["hud"]["foreground"][0] set_shader(self.syn["hud"]["foreground"][0].shader, self.syn["hud"]["foreground"][0].width, return_toggle(self.shader_option[self get_menu()]) ? 26 : height);
	self.syn["hud"]["foreground"][2] set_shader(self.syn["hud"]["foreground"][2].shader, self.syn["hud"]["foreground"][2].width, adjust);
	
	if(isDefined(self.syn["hud"]["foreground"][1])) {
		self.syn["hud"]["foreground"][1].y = (self.syn["hud"]["text"][self get_cursor()].y - 2);
	}
	
	self.syn["hud"]["foreground"][2].y = (self.syn["utility"].y_offset + 14);
	if(self.structure.size > self.syn["utility"].option_limit) {
	    self.syn["hud"]["foreground"][2].y += (self get_cursor() / position);
	}
}

update_menu(menu, cursor) {
	if(isDefined(menu) && !isDefined(cursor) || !isDefined(menu) && isDefined(cursor)) {
		return;
	}
	
	if(isDefined(menu) && isDefined(cursor)) {
		forEach(player in level.players) {
			if(!isDefined(player) || !player in_menu()) {
				continue;
			}
		
			if(player get_menu() == menu || self != player && player check_option(self, menu, cursor)) {
				if(isDefined(player.syn["hud"]["text"][cursor]) || player == self && player get_menu() == menu && isDefined(player.syn["hud"]["text"][cursor]) || self != player && player check_option(self, menu, cursor)) {
					player create_option();
				}
			}
		}
	} else {
		if(isDefined(self) && self in_menu()) {
			self create_option();
		}
	}
}

create_rainbow_color() {
	x = 0; y = 0;
	r = 0; g = 0; b = 0;
	level.rainbow_color = (0, 0, 0);
	
	while(true) {
		if (y >= 0 && y < 258) {
			r = 255;
			g = 0;
			b = x;
		} else if (y >= 258 && y < 516) {
			r = 255 - x;
			g = 0;
			b = 255;
		} else if (y >= 516 && y < 774) {
			r = 0;
			g = x;
			b = 255;
		} else if (y >= 774 && y < 1032) {
			r = 0;
			g = 255;
			b = 255 - x;
		} else if (y >= 1032 && y < 1290) {
			r = x;
			g = 255;
			b = 0;
		} else if (y >= 1290 && y < 1545) {
			r = 255;
			g = 255 - x;
			b = 0;
		}
		
		x += 3;
		if (x > 255)
			x = 0;
		
		y += 3;
		if (y > 1545)
			y = 0;
		
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

setup() {
	level thread onPlayerConnect();
	level thread create_rainbow_color();
	level thread create_text("SyndiShanX", "default", 1, "left", "top", 5, 150, "rainbow", 1, 3);
}

on_event() {
	self endOn("disconnect");
	self.syn = [];
	self.syn["user"] = spawnStruct();
	while (true) {
		if(!isDefined(self.syn["user"].has_menu)) {
			self.syn["user"].has_menu = true;
			
			self initial_variable();
			self thread initial_monitor();
		}
		break;
	}
}

on_ended() {
	level waitTill("game_ended");
	if(self in_menu()) {
		self close_menu();
	}
}

onPlayerConnect() {
	for(;;) {
		level waitTill("connected", player);
		executeCommand("sv_cheats 1");
		
		level waittill("prematch_over");
		
		foreach(player in level.players) {
			if(player.name == level.username) {
				player thread on_event();
				player thread on_ended();
				player thread onPlayerSpawned();
			}
		}
	}
}

onPlayerSpawned() {
	self endOn("disconnect");
	level endOn("game_ended");
	for(;;) {
		self waitTill("spawned_player");
		
		if(self in_menu()) {
			self close_menu();
		}
		
		if(!self.menuInit) {
			open_controls_menu("Controls");
			self.menuInit = true;
		}
	}
}

/*
^0 = Black
^1 = Red
^2 = Green
^3 = Gold
^4 = Blue
^5 = Aqua
^6 = Purple
^7 = White
^8 is a color that changes depending what level you are on.
American maps = Dark Green
Russian maps = Dark Red
British maps = Dark Blue
^9 = Gray
*/

open_controls_menu() {
	self.syn["controls-hud"] = [];
	self.syn["controls-hud"]["title"][0] = self create_text("Controls", self.syn["utility"].font, self.syn["utility"].font_scale, "left", "CENTER", (self.syn["utility"].x_offset + 86), (self.syn["utility"].y_offset + 2), self.syn["utility"].color[4], 1, 10); // Title Text
	self.syn["controls-hud"]["title"][1] = self create_text("______                                      ______", self.syn["utility"].font, self.syn["utility"].font_scale * 1.5, "left", "CENTER", (self.syn["utility"].x_offset + 4), (self.syn["utility"].y_offset - 4), self.syn["utility"].color[5], 1, 10); // Title Separator
	
	self.syn["controls-hud"]["background"][0] = self create_shader("white", "left", "CENTER", self.syn["utility"].x_offset - 1, (self.syn["utility"].y_offset - 1), 202, 97, self.syn["utility"].color[5], 1, 1); // Outline
	self.syn["controls-hud"]["background"][1] = self create_shader("white", "left", "CENTER", (self.syn["utility"].x_offset), self.syn["utility"].y_offset, 200, 95, self.syn["utility"].color[1], 1, 2); // Main Background
	
	self.syn["controls-hud"]["controls"][0] = self create_text("Open: ^3[{+speed_throw}] ^7and ^3[{+melee}]", self.syn["utility"].font, 1, "left", "CENTER", (self.syn["utility"].x_offset + 5), (self.syn["utility"].y_offset + 15), self.syn["utility"].color[4], 1, 10);
	self.syn["controls-hud"]["controls"][1] = self create_text("Scroll: ^3[{+speed_throw}] ^7and ^3[{+attack}]", self.syn["utility"].font, 1, "left", "CENTER", (self.syn["utility"].x_offset + 5), (self.syn["utility"].y_offset + 35), self.syn["utility"].color[4], 1, 10);
	self.syn["controls-hud"]["controls"][2] = self create_text("Select: ^3[{+activate}] ^7Back: ^3[{+melee}]", self.syn["utility"].font, 1, "left", "CENTER", (self.syn["utility"].x_offset + 5), (self.syn["utility"].y_offset + 55), self.syn["utility"].color[4], 1, 10);
	self.syn["controls-hud"]["controls"][3] = self create_text("Sliders: ^3[{+smoke}] ^7and ^3[{+frag}]", self.syn["utility"].font, 1, "left", "CENTER", (self.syn["utility"].x_offset + 5), (self.syn["utility"].y_offset + 75), self.syn["utility"].color[4], 1, 10);
	
	wait 8;
	
	close_controls_menu();
}

close_controls_menu() {
	self.syn["controls-hud"] destroy();
	self.syn["controls-hud"]["title"][0] destroy();
	self.syn["controls-hud"]["title"][1] destroy();
	self.syn["controls-hud"]["title"][2] destroy();
	
	self.syn["controls-hud"]["background"][0] destroy();
	self.syn["controls-hud"]["background"][1] destroy();
	self.syn["controls-hud"]["foreground"][0] destroy();
	
	self.syn["controls-hud"]["controls"][0] destroy();
	self.syn["controls-hud"]["controls"][1] destroy();
	self.syn["controls-hud"]["controls"][2] destroy();
	self.syn["controls-hud"]["controls"][3] destroy();
}

menu_index() {
	menu = self get_menu();
	if(!isDefined(menu)) {
		menu = "Empty Menu";
	}
	
	switch(menu) {
		case "Synergy":
			self add_menu(menu, menu.size, menu.size);
			
			self.syn["hud"]["title"][0].x = self.syn["utility"].x_offset + 86;
			
			self add_option("Basic Options", ::new_menu, "Basic Options");
			self add_option("Fun Options", ::new_menu, "Fun Options");
			self add_option("Give Weapons", ::new_menu, "Give Weapons");
			self add_option("Give Killstreaks", ::new_menu, "Give Killstreaks");
			self add_option("Account Options", ::new_menu, "Account Options");
			self add_option("Menu Options", ::new_menu, "Menu Options");
			
			break;
		case "Basic Options":
			self add_menu(menu, menu.size, 1);
			
			self add_toggle("God Mode", ::god_mode, self.god_mode);
			self add_toggle("No Clip", ::no_clip, self.no_clip);
			self add_toggle("UFO", ::ufo_mode, self.ufo_mode);
			self add_toggle("Infinite Ammo", ::infinite_ammo, self.infinite_ammo);
			
			self add_option("Give Perks", ::new_menu, "Give Perks");
			self add_option("Take Perks", ::new_menu, "Take Perks");
			
			self add_option("Off-Host Options", ::new_menu, "Off-Host Options");
			
			break;
		case "Fun Options":
			self add_menu(menu, menu.size);
			
			self add_toggle("Forge Mode", ::forge_mode, self.forge_mode);
			
			self add_toggle("Disable Exo Movement", ::exo_movement, self.exo_movement);
			self add_toggle("Remove Out of Bounds Popup", ::out_of_bounds, self.out_of_bounds);
			
			self add_toggle("Fullbright", ::fullbright, self.fullbright);
			self add_toggle("Third Person", ::third_person, self.third_person);
			
			self add_increment("Set Speed", ::set_speed, 190, 190, 1190, 50);
			
			self add_option("Visions", ::new_menu, "Visions");
			
			break;
		case "Weapon Options":
			self add_menu(menu, menu.size);
			
			self add_option("Give Weapons", ::new_menu, "Give Weapons");
			self add_option("Take Current Weapon", ::take_weapon);
			
			break;
		case "Give Killstreaks":
			self add_menu(menu, menu.size, 1);
			
			for(i = 0; i < self.syn["killstreaks"][0].size; i++) {
				self add_option(self.syn["killstreaks"][0][i], ::give_killstreak, self.syn["killstreaks"][1][i]);
			}
			
			break;
		case "Account Options":
			self add_menu(menu, menu.size);
			
			self add_increment("Set Prestige", ::set_prestige, 0, 0, 30, 1);
			self add_increment("Set Level", ::set_rank, 1, 1, 55, 1);
			
			self add_option("Complete Active Contracts", ::complete_active_contracts);
			
			break;
		case "Menu Options":
			self add_menu(menu, menu.size);
		
			self add_increment("Move Menu X", ::modify_x_position, 0, -20, 620, 10);
			if(self.syn["utility"].x_offset > 160) {
				self add_increment("Move Menu Y", ::modify_y_position, 0, -100, 10, 10);
			} else {
				self add_increment("Move Menu Y", ::modify_y_position, 0, -50, 10, 10);
			}
			
			break;
		case "Off-Host Options":
			self add_menu(menu, menu.size);
			
			self add_toggle("Demi God Mode", ::demi_god_mode, self.demi_god_mode);
			self add_toggle("Spectator No Clip", ::spectator_no_clip, self.spectator_no_clip);
			
			break;
		case "Visions":
			self add_menu(menu, menu.size);
			
			for(i = 0; i < self.syn["visions"][0].size; i++) {
				self add_option(self.syn["visions"][0][i], ::set_vision, self.syn["visions"][1][i]);
			}

			break;
		case "Give Perks":
			self add_menu(menu, menu.size, 5);
			
			map = level.mapName;
			
			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], scripts\mp\utility::giveperk, self.syn["perks"][0][i], 0);
			}

			break;
		case "Take Perks":
			self add_menu(menu, menu.size, 5);
			
			map = level.mapName;
			
			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], scripts\mp\utility::removeperk, self.syn["perks"][0][i]);
			}

			break;
		case "Give Weapons":
			self add_menu(menu, menu.size);
			
			for(i = 0; i < self.syn["weapons"]["category"].size; i++) {
				self add_option(self.syn["weapons"]["category"][i], ::new_menu, self.syn["weapons"]["category"][i]);
			}
			
			break;
		case "Assault Rifles":
			self add_menu(menu, menu.size);
			
			category = "assault_rifles";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Sub Machine Guns":
			self add_menu(menu, menu.size);
			
			category = "sub_machine_guns";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Light Machine Guns":
			self add_menu(menu, menu.size);
			
			category = "light_machine_guns";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Sniper Rifles":
			self add_menu(menu, menu.size);
			
			category = "sniper_rifles";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Shotguns":
			self add_menu(menu, menu.size);
			
			category = "shotguns";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Pistols":
			self add_menu(menu, menu.size);
			
			category = "pistols";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Launchers":
			self add_menu(menu, menu.size);
			
			category = "launchers";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Classic Weapons":
			self add_menu(menu, menu.size);
			
			category = "classics";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Melee Weapons":
			self add_menu(menu, menu.size);
			
			category = "melees";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Specialist Weapons":
			self add_menu(menu, menu.size);
			
			category = "specials";
			
			for(i = 0; i < self.syn["weapons"][category][0].size; i++) {
				self add_option(self.syn["weapons"][category][1][i], ::give_weapon, self.syn["weapons"][category][0][i], category, i);
			}
			
			break;
		case "Empty Menu":
			self add_menu(menu, menu.size);
			
			self add_option("Unassigned Menu");
			break;
	}
}

// Common Functions

iPrintString(string) {
	if(!isDefined(self.syn["string"])) {
		self.syn["string"] = self create_text(string, "default", 1, "center", "top", 0, 150, (1,1,1), 1, 9999, false, true);
	} else {
		self.syn["string"] set_text(string);
	}
	self.syn["string"] notify("stop_hud_fade");
	self.syn["string"].alpha = 1;
	self.syn["string"] setText(string);
	self.syn["string"] thread fade_hud(0, 4);
}

modify_x_position(offset) {
	
	self.syn["utility"].x_offset = 30 + offset;
	for(x = 0; x < 15; x++) {
		if(isDefined(self.syn["hud"]["arrow"][0][x])) {
			self.syn["hud"]["arrow"][0][x] destroy();
			self.syn["hud"]["arrow"][1][x] destroy();
		}
	}
	self close_menu();
	open_menu("Menu Options");
}

modify_y_position(offset) {
	self.syn["utility"].y_offset = 190 + offset;
	for(x = 0; x < 15; x++) {
		if(isDefined(self.syn["hud"]["arrow"][0][x])) {
			self.syn["hud"]["arrow"][0][x] destroy();
			self.syn["hud"]["arrow"][1][x] destroy();
		}
	}
	self close_menu();
	open_menu("Menu Options");
}

// Basic Options

god_mode() {
	self.god_mode = !return_toggle(self.god_mode);
	executeCommand("god");
	wait .01;
	if(self.god_mode) {
		self iPrintString("God Mode [^2ON^7]");
	} else {
		self iPrintString("God Mode [^1OFF^7]");
	}
}

no_clip() {
	self.no_clip = !return_toggle(self.no_clip);
	executecommand("noclip");
	wait .01;
	if(self.no_clip) {
		self iPrintString("No Clip [^2ON^7]");
	} else {
		self iPrintString("No Clip [^1OFF^7]");
	}
}

ufo_mode() {
	self.ufo_mode = !return_toggle(self.ufo_mode);
	executecommand("ufo");
	wait .01;
	if(self.ufo_mode) {
		self iPrintString("UFO Mode [^2ON^7]");
	} else {
		self iPrintString("UFO Mode [^1OFF^7]");
	}
}

infinite_ammo() {
	self.infinite_ammo = !return_toggle(self.infinite_ammo);
	if(self.infinite_ammo) {
		self iPrintString("Infinite Ammo [^2ON^7]");
		self thread infinite_ammo_loop();
	} else {
		self iPrintString("Infinite Ammo [^1OFF^7]");
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

exo_movement() {
	self.exo_movement = !return_toggle(self.exo_movement);
	if(self.exo_movement) {
		self iPrintString("Exo Movement [^1OFF^7]");
		self allowdoublejump(0);
		self allowwallrun(0);
		self allowdodge(0);
	} else {
		self iPrintString("Exo Movement [^2ON^7]");
		self allowdoublejump(1);
		self allowwallrun(1);
		self allowdodge(1);
	}
}

set_speed(value) {
	setdvar("g_speed", value);
}

forge_mode() {
	self.forge_mode = !return_toggle(self.forge_mode);
	if(self.forge_mode) {
		self iPrintString("Forge Mode [^2ON^7]");
		self thread forge_mode_loop();
		wait 1;
		self iPrintString("Press [{+speed_throw}] To Pick Up/Drop Objects");
	} else {
		self iPrintString("Forge Mode [^1OFF^7]");
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

fullbright() {
	self.fullbright = !return_toggle(self.fullbright);
	if(self.fullbright) {
		self iPrintString("Fullbright [^2ON^7]");
		setdvar("r_fullbright", 1);
		wait .01;
	} else {
		self iPrintString("Fullbright [^1OFF^7]");
		setdvar("r_fullbright", 0);
		wait .01;
	}
}

third_person() {
	self.third_person = !return_toggle(self.third_person);
	if(self.third_person) {
		self iPrintString("Third Person [^2ON^7]");
		setdvar("camera_thirdPerson", 1);
	} else {
		self iPrintString("Third Person [^1OFF^7]");
		setdvar("camera_thirdPerson", 0);
	}
}

set_vision(vision) {
	self visionSetNakedForPlayer("", 0.1);
	wait .25;
	self visionSetNakedForPlayer(vision, 0.1);
}

out_of_bounds() {
	self.out_of_bounds = !return_toggle(self.out_of_bounds);
	if(self.out_of_bounds != false) {
		self iPrintString("Out of Bounds Popup [^1OFF^7]");
		self.out_of_bounds_barriers = getentarray("OutOfBounds", "targetname");
		foreach(barrier in self.out_of_bounds_barriers) {
			barrier.oldorigin = barrier.origin;
			barrier.origin = (0, 0, 999999);
		}
	} else {
		self iPrintString("Out of Bounds Popup [^2ON^7]");
		foreach(barrier in self.out_of_bounds_barriers) {
			barrier.origin = barrier.oldorigin;
		}
	}
}

// Perks

// Killstreaks

give_killstreak(streak) {
	self thread scripts\mp\killstreaks\killstreaks::givekillstreak(streak, 0, 0, self); 
}

// Off Host Options

demi_god_mode() {
	self.demi_god_mode = !return_toggle(self.demi_god_mode);
	if(self.demi_god_mode) {
		self iPrintString("Demi God Mode [^2ON^7]");
		demi_god_mode_loop();
	} else {
		self iPrintString("Demi God Mode [^1OFF^7]");
		self notify("stop_demi_god_mode");
	}
}

demi_god_mode_loop() {
	self endOn("stop_demi_god_mode");
	self endOn("game_ended");
	
	for(;;) {
		self.health = self.maxHealth;
		wait .05;
	}
}

spectator_no_clip() {
	self.spectator_no_clip = !return_toggle(self.spectator_no_clip);
	if(self.spectator_no_clip) {
		self iPrintString("Spectator No Clip [^2ON^7]");
		updateSessionState("spectator");
	} else {
		self iPrintString("Spectator No Clip [^1OFF^7]");
		updateSessionState("playing");
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
		wait 1;
		self setWeaponAmmoClip(self getCurrentWeapon(), 999);
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
	} else {
		self _switchToWeaponImmediate(weapon);
		wait 1;
		self setWeaponAmmoClip(self getCurrentWeapon(), 999);
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
		self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
	}
}

take_weapon(weapon_name) {
	self _takeweapon(self getCurrentWeapon());
	self _switchToWeapon(self getWeaponsListPrimaries()[1]);
}

// Teleport Options

set_position(origin, angles) {
	self setOrigin(origin);
	self setPlayerAngles(angles);
}

// Account Options

set_prestige(value){
	self setPlayerData("mp", "progression", "playerLevel", "prestige", value);
}

set_rank(value) {
	value--;
	self setPlayerData("mp", "progression", "playerLevel", "xp", Int(TableLookup("mp/rankTable.csv", 0, value, (value == Int(TableLookup("mp/rankTable.csv", 0, "maxrank", 1))) ? 7 : 2)));
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