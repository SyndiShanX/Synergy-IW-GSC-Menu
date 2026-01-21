#include scripts\cp\cp_weapon;
#include scripts\cp\utility;
#include scripts\engine\utility;

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

	self.point_increment = 100;
	self.map_name = getDvar("mapname");
	self.color_theme = "rainbow";
	self.menu_color_red = 0;
	self.menu_color_green = 0;
	self.menu_color_blue = 0;

	self.cursor_index = 0;
	self.scrolling_offset = 0;
	self.previous_scrolling_offset = 0;
	self.description_height = 0;
	self.previous_option = undefined;

	self.outline_zombies = undefined;

	self.syn["visions"][0] = ["", "ac130", "ac130_enhanced_mp", "ac130_inverted", "aftermath", "aftermath_glow", "aftermath_post", "apex_mp", "black_bw", "cp_frontend", "cp_zmb_afterlife", "cp_zmb_alien", "cp_zmb", "cp_zmb_bw", "cp_zmb_ghost_path", "cp_zmb_int_basement", "cp_zmb_int_triton_main", "default", "default_night", "default_night_mp", "dronehive_mp", "end_game", "europa", "jackal_streak_mp", "last_stand_cp_zmb", "map_select_mp", "missilecam", "mpintro", "mpoutro", "mpnuke", "mpnuke_aftermath", "mp_frontier", "mp_out_of_bounds", "nuke_global_flash", "opticwave_mp", "rc8_mp", "thorbright_mp", "thor_mp", "venomgas_mp"];
	self.syn["visions"][1] = ["None", "AC-130", "AC-130 Enhanced", "AC-130 inverted", "Aftermath", "Aftermath Glow", "Aftermath Post", "Apex", "Black & White", "Lobby", "Afterlife", "Zombies", "Zombies in Spaceland", "Zombies in Spaceland Black & White", "Zombies in Spaceland Ghost Path", "Zombies in Spaceland Basement", "Zombies in Spaceland Triton", "Default", "Default Night", "Night Vision", "Dronehive", "Endgame", "Europa", "Jackal", "Last Stand", "MP Map Select", "Missile Cam", "MP Intro", "MP Outro", "MP Nuke", "MP Nuke Aftermath", "Frontier", "Out of Bounds", "Nuke Flash", "Optic Wave", "RC8", "Thor Bright", "Thor", "Venom Gas"];

	self.syn["powerups"][0] = ["Nuke", "Max Ammo", "Instakill", "Double Money", "Carpenter", "Pack-a-Punch", "Fire Sale", "Infinite Ammo", "Infinite Grenades"];
	self.syn["powerups"][1] = ["kill_50", "ammo_max", "instakill_30", "cash_2", "board_windows", "upgrade_weapons", "fire_30", "infinite_20", "grenade_30"];

	self.syn["weapons"]["category"] = ["Assault Rifles", "Sub Machine Guns", "Light Machine Guns", "Sniper Rifles", "Shotguns", "Pistols", "Launchers", "Classic Weapons", "Melee Weapons", "Specialist Weapons", "Map Specific Weapons", "Other Weapons"];

	// Weapon IDs Plus 1 Default Attachment
	self.syn["weapons"]["assault_rifles"][0] =     ["iw7_m4_zm", "iw7_sdfar_zm", "iw7_ar57_zm", "iw7_fmg_zm+akimbofmg_zm", "iw7_ake_zmr", "iw7_rvn_zm+meleervn", "iw7_vr_zm", "iw7_gauss_zm", "iw7_erad_zm"];
	self.syn["weapons"]["sub_machine_guns"][0] =   ["iw7_fhr_zm", "iw7_crb_zml+crblscope_camo", "iw7_ripper_zmr", "iw7_ump45_zml+ump45lscope_camo", "iw7_crdb_zm", "iw7_mp28_zm", "iw7_tacburst_zm+gltacburst"];
	self.syn["weapons"]["light_machine_guns"][0] = ["iw7_sdflmg_zm", "iw7_mauler_zm", "iw7_lmg03_zm", "iw7_minilmg_zm", "iw7_unsalmg_zm"];
	self.syn["weapons"]["sniper_rifles"][0] =      ["iw7_kbs_zm", "iw7_m8_zm", "iw7_cheytac_zmr", "iw7_m1_zm", "iw7_ba50cal_zm", "iw7_longshot_zm+longshotlscope_zm"];
	self.syn["weapons"]["shotguns"][0] =           ["iw7_devastator_zm", "iw7_sonic_zmr", "iw7_sdfshotty_zm+sdfshottyscope_camo", "iw7_spas_zmr", "iw7_mod2187_zm"];
	self.syn["weapons"]["pistols"][0] =            ["iw7_emc_zm", "iw7_nrg_zm", "iw7_g18_zmr", "iw7_revolver_zm", "iw7_udm45_zm+udm45scope", "iw7_mag_zm"];
	self.syn["weapons"]["launchers"][0] =          ["iw7_lockon_zm", "iw7_glprox_zm", "iw7_chargeshot_zm+chargeshotscope_camo"];
	self.syn["weapons"]["classics"][0] =           ["iw7_m1c_zm", "iw7_g18c_zm", "iw7_ump45c_zm", "iw7_spasc_zm", "iw7_arclassic_zm", "iw7_cheytacc_zm"];
	self.syn["weapons"]["melee"][0] =             ["iw7_axe_zm"];
	self.syn["weapons"]["specialist"][0] =           ["iw7_atomizer_mp", "iw7_penetrationrail_mp+penetrationrailscope", "iw7_steeldragon_mp", "iw7_claw_mp", "iw7_blackholegun_mp+blackholegunscope"];
	// Weapon Names
	self.syn["weapons"]["assault_rifles"][1] =     ["NV4", "R3K", "KBAR-32", "Type-2", "Volk", "R-VN", "X-Con", "G-Rail", "Erad"];
	self.syn["weapons"]["sub_machine_guns"][1] =   ["FHR-40", "Karma-45", "RPR Evo", "HVR", "VPR", "Trencher", "Raijin-EMX"];
	self.syn["weapons"]["light_machine_guns"][1] = ["R.A.W.", "Mauler", "Titan", "Auger", "Atlas"];
	self.syn["weapons"]["sniper_rifles"][1] =      ["KBS Longbow", "EBR-800", "Widowmaker", "DMR-1", "Trek-50", "Proteus"];
	self.syn["weapons"]["shotguns"][1] =           ["Reaver", "Banshee", "DCM-8", "Rack-9", "M.2187"];
	self.syn["weapons"]["pistols"][1] =            ["EMC", "Oni", "Kendall 44", "Hailstorm", "UDM", "Stallion 44"];
	self.syn["weapons"]["launchers"][1] =          ["Spartan SA3", "Howitzer", "P-Law"];
	self.syn["weapons"]["classics"][1] =           ["M1", "Hornet", "MacTav-45", "S-Ravage", "OSA", "TF-141"];
	self.syn["weapons"]["melee"][1] =             ["Axe"];
	self.syn["weapons"]["specialist"][1] =           ["Eraser", "Ballista EM3", "Steel Dragon", "Claw", "Gravity Vortex Gun"];
	// Spaceland Weapons
	self.syn["weapons"]["cp_zmb"][0] =	 ["iw7_forgefreeze_zm+forgefreezealtfire", "iw7_dischord_zm", "iw7_facemelter_zm", "iw7_headcutter_zm", "iw7_shredder_zm", "iw7_spaceland_wmd"];
	self.syn["weapons"]["cp_zmb"][1] =   ["Forge Freeze", "Dischord", "Face Melter", "Head Cutter", "Shredder", "NX 2.0"];
	// Rave in the Redwoods Weapons
	self.syn["weapons"]["cp_rave"][0] =  ["iw7_golf_club_mp", "iw7_spiked_bat_mp", "iw7_two_headed_axe_mp", "iw7_machete_mp", "iw7_harpoon1_zm", "iw7_harpoon2_zm", "iw7_harpoon3_zm+akimbo", "iw7_harpoon4_zm"];
	self.syn["weapons"]["cp_rave"][1] =  ["Golf Club", "Spiked Bat", "2 Headed Axe", "Machete", "Harpoon Gun 1", "Harpoon Gun 2", "Harpoon Gun 3", "Harpoon Gun 4"];
	// Shaolin Shuffle Weapons
	self.syn["weapons"]["cp_disco"][0] = ["iw7_katana_zm", "iw7_nunchucks_zm"];
	self.syn["weapons"]["cp_disco"][1] = ["Katana", "Nunchucks"];
	// Attack of the Radioactive Thing Weapons
	self.syn["weapons"]["cp_town"][0] =  ["iw7_cutie_zm"];
	self.syn["weapons"]["cp_town"][1] =  ["Modular Atomic Disintegrator"];
	// Beast from Beyond Weapons
	self.syn["weapons"]["cp_final"][0] = ["iw7_venomx_zm"];
	self.syn["weapons"]["cp_final"][1] = ["Venom-X"];
	// Misc Weapons
	self.syn["weapons"]["other"][0] =    ["iw7_fists_zm", "iw7_entangler_zm"];
	self.syn["weapons"]["other"][1] =    ["Fists", "Entangler"];
	// Melee Weapons
	self.syn["melee"]["cp_town"][0] =    ["iw7_knife_zm_cleaver", "iw7_knife_zm_crowbar"];
	self.syn["melee"]["cp_town"][1] =    ["Cleaver", "Crowbar"];
	// PaP Camos
	self.syn["camos"]["cp_zmb"] =   ["+camo1", "+camo4"];
	self.syn["camos"]["cp_rave"] =  ["+camo204", "+camo205"];
	self.syn["camos"]["cp_disco"] = ["+camo211", "+camo212"];
	self.syn["camos"]["cp_town"] =  ["+camo92", "+camo93"];
	self.syn["camos"]["cp_final"] = ["+camo32", "+camo34"];

	// Spaceland Teleport Names
	self.syn["Main Teleports"]["cp_zmb"][0] =            ["PaP Room", "Spawn", "Main Portal", "Afterlife Arcade"];
	self.syn["Map Setup Teleports"]["cp_zmb"][0] =       ["Spawn Power", "Journey Power", "Kepler Power", "Polar Peak Power", "Arcade Power", "Journey Teleporter", "Kepler Teleporter", "Polar Peak Teleporter", "Arcade Teleporter"];
	self.syn["Mystery Wheel Teleports"]["cp_zmb"][0] =   ["Journey 1", "Journey 2", "Journey 3", "Astrocade", "Polar Peak", "Kepler 1", "Kepler 2", "Kepler 3"];
	self.syn["Main Quest Teleports"]["cp_zmb"][0] =      ["Calculator 1", "Calculator 2", "Calculator 3", "Boom Box 1", "Boom Box 2", "Boom Box 3", "Umbrella 1", "Umbrella 2", "Umbrella 3", "DJ Booth 1", "DJ Booth 2", "DJ Booth 3"];
	self.syn["Extra Teleports"]["cp_zmb"][0] =           ["N31L's Head", "N31L Auxiliary Battery 1", "N31L Auxiliary Battery 2", "N31L Auxiliary Battery 3", "N31L Auxiliary Battery 4", "N31L Auxiliary Battery 5", "N31L Auxiliary Battery 6", "N31L Floppy Disk 1", "N31L Floppy Disk 2", "N31L Floppy Disk 3", "N31L Floppy Disk 4"];
	// Spaceland Teleport Origins
	self.syn["Main Teleports"]["cp_zmb"][1] =            [(-10245, 740, -1630), (465, 3680, 0), (650, 970, 0), (-9885, -70, -1795)];
	self.syn["Map Setup Teleports"]["cp_zmb"][1] =       [(1075, 3720, 0), (4695, 1250, 115), (-1365, -65, 380), (-695, -2795, 560), (2390, -1825, 115), (3640, 1165, 55), (-2150, -35, 225), (-1490, -2650, 360), (2285, -1615, 115)];
	self.syn["Mystery Wheel Teleports"]["cp_zmb"][1] =   [(1470, 1045, 0), (4065, 2135, 55), (3690, 420, 55), (2575, -865, 240), (955, -2260, 440), (-1950, 1830, 365), (-1900, -530, 380), (-845, -1492, 360)];
	self.syn["Main Quest Teleports"]["cp_zmb"][1] =      [(540, 1060, 0), (-2520, 805, 365), (2960, -850, 240), (595, 2125, -65), (-1415, -175, 380), (1375, -590, -195), (155, -505, 0), (-1890, -3040, 360), (3640, 2335, 115), (-1000, 1495, 225), (-2710, -2480, 360), (2926, 1305, 0)];
	self.syn["Extra Teleports"]["cp_zmb"][1] =           [(475, -265, 0), (-1800, -2825, 360), (-535, -3265, 390), (-757, -2415, 560), (-2775, 1565, 365), (-3045, 730, 365), (-1230, 1625, 225), (2425, -106, -196), (2495, -295, -196), (1920, -635, -196), (100, -1115, -252)];
	// Spaceland Teleport Angles
	self.syn["Main Teleports"]["cp_zmb"][2] =            [90, -90, -90];
	self.syn["Map Setup Teleports"]["cp_zmb"][2] =       [-90, 0, -90, 90, 180, 0, -45, 20, -90];
	self.syn["Mystery Wheel Teleports"]["cp_zmb"][2] =   [180, 90, 0, -90, 0, -45, -90, 0];
	self.syn["Main Quest Teleports"]["cp_zmb"][2] =      [0, 0, 90, 45, 0, 90, 160, 90, -90, 0, -90, 0];
	self.syn["Extra Teleports"]["cp_zmb"][2] =           [-90, 180, -90, 0, 0, 0, 90, 50, 60, -100, 135];
	// Rave in the Redwoods Teleport Names
	self.syn["Main Teleports"]["cp_rave"][0] =           ["PaP Room", "Spawn", "Cellar", "Kevin's Cabin", "Afterlife Arcade"];
	self.syn["Mystery Wheel Teleports"]["cp_rave"][0] =  ["Rave Stage", "Dock", "Main Fire", "Mess Hall", "Cellar", "Bear Lodge", "Camp Wolf"];
	// Rave in the Redwoods Teleport Origins
	self.syn["Main Teleports"]["cp_rave"][1] =           [(-10245, 750, -1630), (-940, -1620, 225), (-395, -1815, 55), (-6035, 4890, 120), (-9885, -70, -1795)];
	self.syn["Map Setup Teleports"]["cp_rave"][1] =      [(000, 000, 000), (000, 000, 000)];
	self.syn["Mystery Wheel Teleports"]["cp_rave"][1] =  [(2205, -1390, -15), (-2900, 2275, -150), (145, 1125, 50), (-3355, -3365, 150), (-560, -1895, 55), (-950, -1150, 390), (-2585, -4575, 255)];
	self.syn["Main Quest Teleports"]["cp_rave"][1] =     [(000, 000, 000), (000, 000, 000)];
	self.syn["Extra Teleports"]["cp_rave"][1] =          [(000, 000, 000), (000, 000, 000)];
	// Rave in the Redwoods Teleport Angles
	self.syn["Main Teleports"]["cp_rave"][2] =           [90, 165, 130, 100, 0];
	self.syn["Map Setup Teleports"]["cp_rave"][2] =      [0, 0];
	self.syn["Mystery Wheel Teleports"]["cp_rave"][2] =  [100, 140, 90, -50, -180, -90, -75];
	self.syn["Main Quest Teleports"]["cp_rave"][2] =     [0, 0];
	self.syn["Extra Teleports"]["cp_rave"][2] =          [0, 0];
	// Shaolin Shuffle Teleport Names
	self.syn["Main Teleports"]["cp_disco"][0] =          ["PaP Room", "Spawn", "Sewer", "Afterlife Arcade"];
	self.syn["Mystery Wheel Teleports"]["cp_disco"][0] = ["Alleyway", "Rooftop", "Garden", "Disco Roof", "Subway Station 1", "Subway Station 2", "Disco"];
	self.syn["Extra Teleports"]["cp_disco"][0] =         ["Pink Cat Flier 1", "Pink Cat Flier 2", "Pink Cat Flier 3", "Pink Cat Flier 4", "Token"];
	// Shaolin Shuffle Teleport Origins
	self.syn["Main Teleports"]["cp_disco"][1] =          [(-10245, 750, -1630), (580, 3025, 285), (-875, 1820, 180), (-9885, -35, -1795)];
	self.syn["Map Setup Teleports"]["cp_disco"][1] =     [(-1915, 4620, 750), (1590, 1290, 750), (-810, 765, 925), (-1110, 3435, 1120), (-1075, 2795, 260)];
	self.syn["Mystery Wheel Teleports"]["cp_disco"][1] = [(105, 1300, 750), (15, 665, 935), (-3515, 1165, 975), (-2100, 2795, 1175), (375, 2065, 525), (-2450, 3610, 500), (-1185, 3735, 750)];
	self.syn["Main Quest Teleports"]["cp_disco"][1] =    [(000, 000, 000), (000, 000, 000)];
	self.syn["Extra Teleports"]["cp_disco"][1] =         [(000, 000, 000), (000, 000, 000)];
	// Shaolin Shuffle Teleport Angles
	self.syn["Main Teleports"]["cp_disco"][2] =          [90, -145, 90, 0];
	self.syn["Map Setup Teleports"]["cp_disco"][2] =     [-180, -30, 90, 0, 180];
	self.syn["Mystery Wheel Teleports"]["cp_disco"][2] = [-90, 90, -180, 180, -180, 90. -20];
	self.syn["Main Quest Teleports"]["cp_disco"][2] =    [0, 0];
	self.syn["Extra Teleports"]["cp_disco"][2] =         [0, 0];
	// Attack of the Radioactive Thing Teleport Names
	self.syn["Main Teleports"]["cp_town"][0] =           ["PaP Room", "Spawn", "Studio", "Afterlife Arcade"];
	self.syn["Map Setup Teleports"]["cp_town"][0] =      ["Power Handle", "Power Station", "Telepad 1", "Telepad 2", "Telepad 3", "Telepad 4"];
	self.syn["Mystery Wheel Teleports"]["cp_town"][0] =  ["Power Station", "Beach Mart", "RV Park", "Pool", "Studio", "Trail"];
	self.syn["Main Quest Teleports"]["cp_town"][0] =     ["Elvira's Book", "Zombie Head", "Zombie Torso", "Zombie Arm 1", "Zombie Arm 2", "Zombie Leg"];
	self.syn["Extra Teleports"]["cp_town"][0] =          ["Cleaver", "Crowbar", "M.A.D. Attachment 1", "M.A.D. Attachment 2", "M.A.D. Attachment 3"];
	// Attack of the Radioactive Thing Teleport Origins
	self.syn["Main Teleports"]["cp_town"][1] =           [(-10245, 750, -1630), (3939, -4515, 15), (235, -2555, 520), (-9885, -70, -1795)];
	self.syn["Map Setup Teleports"]["cp_town"][1] =      [(3205, 1815, -105), (6440, -2770, 105), (5375, -2800, 195), (4795, -180, 330), (490, 4115, 395), (-937, -2695, 520)];
	self.syn["Mystery Wheel Teleports"]["cp_town"][1] =  [(6440, -1955, 105), (6210, 1075, 330), (-790, 3840, 400), (-255, -590, 410), (-480, -3410, 515), (340, -4710, 255)];
	self.syn["Main Quest Teleports"]["cp_town"][1] =     [(5405, -4720, -15), (-295, 3665, 425), (6245, -550, 335), (3205, 1815, -105), (470, 2200, 395), (-1175, -4219, 335)];
	self.syn["Extra Teleports"]["cp_town"][1] =          [(6015, -820, 335), (1270, -130, 475), (-1055, 3505, 400), (4260, 1620, 335), (-130, -3045, 520)];
	// Attack of the Radioactive Thing Teleport Angles
	self.syn["Main Teleports"]["cp_town"][2] =           [90, 60, 0, 0];
	self.syn["Map Setup Teleports"]["cp_town"][2] =      [65, 20, -160, -90, 100, -180];
	self.syn["Mystery Wheel Teleports"]["cp_town"][2] =  [-65, 0, 150, 180, -90, -80];
	self.syn["Main Quest Teleports"]["cp_town"][2] =     [45, -170, 75, 65, 30, 80];
	self.syn["Extra Teleports"]["cp_town"][2] =          [-85, -30, 100, -180, 90];
	// Beast from Beyond Teleport Names
	self.syn["Main Teleports"]["cp_final"][0] =          ["PaP Room", "Spawn", "Control Room", "Theatre", "Afterlife Arcade"];
	self.syn["Map Setup Teleports"]["cp_final"][0] =     ["N31L's Head", "N31L", "Open Theatre Portal"];
	self.syn["Mystery Wheel Teleports"]["cp_final"][0] = ["Spawn", "Water Room", "Main Room", "Hallway", "Storage Room", "Theatre", "Outside"];
	self.syn["Extra Teleports"]["cp_final"][0] =         ["PaP Bridge Part 1", "PaP Bridge Part 2", "PaP Bridge Part 3", "PaP Bridge", "Mephistopheles Arena"];
	// Beast from Beyond Teleport Origins
	self.syn["Main Teleports"]["cp_final"][1] =          [(5135, -5180, 285), (-760, 2920, 90), (730, 5065, 90), (5515, -4515, -20), (2080, -4520, 330)];
	self.syn["Map Setup Teleports"]["cp_final"][1] =     [(-1210, 5040, -70), (45, 3840, 25), (1920, 3470, 15)];
	self.syn["Mystery Wheel Teleports"]["cp_final"][1] = [(-90, 2880, 25), (-1215, 4755, -205), (645, 5710, 60), (1510, 4010, 15), (1470, 3565, -175), (5700, -4050, -70), (2185, 6275, 95)];
	self.syn["Main Quest Teleports"]["cp_final"][1] =    [(000, 000, 000), (000, 000, 000)];
	self.syn["Extra Teleports"]["cp_final"][1] =         [(-855, 5435, -70), (1755, 3110, -290), (4990, -6835, 50), (3465, 6640, 165), (-13300, -325, -105)];
	// Beast from Beyond Teleport Angles
	self.syn["Main Teleports"]["cp_final"][2] =          [90, 20, -45, 90, 0];
	self.syn["Map Setup Teleports"]["cp_final"][2] =     [-155, 90, 90];
	self.syn["Mystery Wheel Teleports"]["cp_final"][2] = [-90, -130, 180, 90, 60, 0, -50];
	self.syn["Main Quest Teleports"]["cp_final"][2] =    [0, 0];
	self.syn["Extra Teleports"]["cp_final"][2] =         [-55, 60, -100, 45, 0];

	// Spaceland Zombies
	self.syn["zombies"]["cp_zmb"][0] =   ["generic_zombie", "zombie_clown", "zombie_cop", "zombie_brute", "zombie_ghost", "the_hoff"];
	self.syn["zombies"]["cp_zmb"][1] =   ["Normal Zombie", "Clown", "Cop", "Brute", "Ghost", "David Hasselhoff"];
	// Rave in the Redwoods Zombies
	self.syn["zombies"]["cp_rave"][0] =  ["generic_zombie", "lumberjack", "zombie_sasquatch", "slasher", "superslasher"];
	self.syn["zombies"]["cp_rave"][1] =  ["Normal Zombie", "Lumberjack", "Sasquatch", "Slasher", "Super Slasher"];
	// Shaolin Shuffle Zombies
	self.syn["zombies"]["cp_disco"][0] = ["generic_zombie", "karatemaster", "skater", "ratking", "pamgrier"];
	self.syn["zombies"]["cp_disco"][1] = ["Normal Zombie", "Karate Zombie", "Skater", "Rat King", "Pam Grier"];
	// Attack of the Radioactive Thing Zombies
	self.syn["zombies"]["cp_town"][0] =  ["generic_zombie", "crab_mini", "crab_brute", "crab_boss", "elvira"];
	self.syn["zombies"]["cp_town"][1] =  ["Normal Zombie", "Crog", "Crog Brute", "Crog Boss", "Elvira"];
	// Beast from Beyond Zombies
	self.syn["zombies"]["cp_final"][0] = ["generic_zombie", "alien_goon", "alien_phantom", "alien_rhino", "dlc4_boss"];
	self.syn["zombies"]["cp_final"][1] = ["Normal Zombie", "Cryptid", "Phantom", "Rhino", "Mephistopheles"];

	// Common Perks
	self.syn["perks"][0] = ["perk_machine_revive", "perk_machine_tough", "perk_machine_rat_a_tat", "perk_machine_flash", "perk_machine_run", "perk_machine_boom", "perk_machine_more", "perk_machine_zap", "perk_machine_fwoosh"];
	self.syn["perks"][1] = ["Up N' Atoms", "Tuff Nuff", "Bang Bangs", "Quickies", "Racin' Stripes", "Bombstoppers", "Mule Munchies", "Blue Bolts", "Trail Blazers"];
	// Zombies in Spaceland Perk
	self.syn["perks"]["cp_zmb"][0] = ["perk_machine_smack"];
	self.syn["perks"]["cp_zmb"][1] = ["Slappy Taffy"];
	// Shaolin Shuffle Extra Perk
	self.syn["perks"]["cp_disco"][0] = ["perk_machine_deadeye"];
	self.syn["perks"]["cp_disco"][1] = ["Deadeye Dewdrops"];
	// Attack of the Radioactive Thing and Beast from Beyond Extra Perks
	self.syn["perks"]["cp_town"][0] = ["perk_machine_smack", "perk_machine_deadeye", "perk_machine_change"];
	self.syn["perks"]["cp_town"][1] = ["Slappy Taffy", "Deadeye Dewdrops", "Change Chews"];
	self.syn["perks"]["cp_final"][0] = ["perk_machine_smack", "perk_machine_deadeye", "perk_machine_change"];
	self.syn["perks"]["cp_final"][1] = ["Slappy Taffy", "Deadeye Dewdrops", "Change Chews"];
	// Map Names
	self.syn["maps"]["cp_zmb"] = "Zombies in Spaceland";
	self.syn["maps"]["cp_rave"] = "Rave in the Redwoods";
	self.syn["maps"]["cp_disco"] = "Shaolin Shuffle";
	self.syn["maps"]["cp_town"] = "Attack of the Radioactive Thing";
	self.syn["maps"]["cp_final"] = "The Beast from Beyond";
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

						//self.x_offset = 175;
						//self.y_offset = 160;

						self.menu["border"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset - 1), (self.y_offset - 1), 226, 122, self.color_theme, 1, 1);
						self.menu["background"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, self.y_offset, 224, 121, (0.075, 0.075, 0.075), 1, 2);
						self.menu["foreground"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset + 15), 224, 106, (0.1, 0.1, 0.1), 1, 3);
						self.menu["separator_1"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", (self.x_offset + 5.5), (self.y_offset + 7.5), 42, 1, self.color_theme, 1, 10);
						self.menu["separator_2"] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 220), (self.y_offset + 7.5), 42, 1, self.color_theme, 1, 10);
						self.menu["cursor"] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, 215, 224, 16, (0.15, 0.15, 0.15), 0, 4);
						//self.menu["scrollbar"] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + (self.menu["background"].width + 1)), (self.y_offset + 16), 4, 16, (0.25, 0.25, 0.25), 1, 4);

						self.menu["title"] = self create_text("Title", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 94.5), (self.y_offset + 3), (1, 1, 1), 1, 10);
						self.menu["description"] = self create_text("Description", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 5), (self.y_offset + (self.option_limit * 17.5)), (0.75, 0.75, 0.75), 0, 10);

						for(i = 1; i <= self.option_limit; i++) {
							self.menu["toggle_" + i] = self create_shader("white", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 11), ((self.y_offset + 4) + (i * 15)), 8, 8, (0.25, 0.25, 0.25), 0, 9);
							self.menu["slider_" + i] = self create_shader("white", "TOP_LEFT", "TOPCENTER", self.x_offset, (self.y_offset + (i * 15)), 224, 16, (0.25, 0.25, 0.25), 0, 5);
							self.menu["option_" + i] = self create_text("", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 5), ((self.y_offset + 4) + (i * 15)), (0.75, 0.75, 0.75), 1, 10);
							self.menu["slider_text_" + i] = self create_text("", self.font, self.font_scale, "TOP_LEFT", "TOPCENTER", (self.x_offset + 132.5), ((self.y_offset + 4) + (i * 15)), (0.75, 0.75, 0.75), 0, 10);
							self.menu["submenu_icon_" + i] = self create_shader("ui_scrollbar_arrow_right", "TOP_RIGHT", "TOPCENTER", (self.x_offset + 223), ((self.y_offset + 4) + (i * 15)), 7, 7, (0.5, 0.5, 0.5), 0, 10);
						}

						//self setClientOmnvar("element_id", 100001);
						//self setClientOmnvar("element_x_start", (self.x_offset - 2));
						//self setClientOmnvar("element_x_end", (self.x_offset + 452));
						//self setClientOmnvar("element_y_start", (self.y_offset - 2));
						//self setClientOmnvar("element_y_end", (self.y_offset + 244));
						//self setClientOmnvar("element_alpha", 1);
						//self setClientOmnvar("element_color", 255);

						self.hud_created = true;

						self.menu["title"] set_text("Controls");
						self.menu["option_1"] set_text("Open: ^3[{+speed_throw}] ^7and ^3[{+melee}]");
						self.menu["option_2"] set_text("Scroll: ^3[{+speed_throw}] ^7and ^3[{+attack}]");
						self.menu["option_3"] set_text("Select: ^3[{+activate}] ^7Back: ^3[{+melee}]");
						self.menu["option_4"] set_text("Sliders: ^3[{+smoke}] ^7and ^3[{+frag}]");
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

				self playSoundToPlayer("entrance_sign_power_on_build", self);

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

				self playSoundToPlayer("mp_ability_ready_L1", self);

				if(isDefined(self.previous[(self.previous.size - 1)])) {
					self new_menu();
				} else {
					self close_menu();
				}

				while(self meleeButtonPressed()) {
					wait 0.2;
				}

				while(scripts\engine\utility::string_starts_with(self getCurrentWeapon(), "iw7_knife")) {
					wait 0.2;
				}
			} else if(self adsButtonPressed() && !self attackButtonPressed() || self attackButtonPressed() && !self adsButtonPressed()) {

				self playSoundToPlayer("zmb_powerup_activate", self);

				scroll_cursor(set_variable(self attackButtonPressed(), "down", "up"));

				wait (0.2);
			} else if(self fragButtonPressed() && !self secondaryOffhandButtonPressed() || !self fragButtonPressed() && self secondaryOffhandButtonPressed()) {

				self playSoundToPlayer("mp_ability_ready_R1", self);

				if(isDefined(self.structure[self.cursor_index].array) || isDefined(self.structure[self.cursor_index].increment)) {
					scroll_slider(set_variable(self secondaryOffhandButtonPressed(), "left", "right"));
				}

				wait (0.2);
			} else if(self useButtonPressed()) {
				self.saved_index[self.current_menu] = self.cursor_index;
				self.saved_offset[self.current_menu] = self.scrolling_offset;
				self.saved_trigger[self.current_menu] = self.previous_trigger;

				self playSoundToPlayer("part_pickup", self);
				
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
			self add_option("Zombie Options", undefined, ::new_menu, "Zombie Options");
			self add_option("Powerup Options", undefined, ::new_menu, "Powerup Options");
			self add_option("Menu Options", undefined, ::new_menu, "Menu Options");
			self add_option("Account Options", undefined, ::new_menu, "Account Options");
			self add_option(self.syn["maps"][self.map_name] + " Options", undefined, ::new_menu, self.syn["maps"][self.map_name]);
			self add_option("Teleport Options", undefined, ::new_menu, "Teleport Options");
			self add_option("All Players", undefined, ::new_menu, "All Players");

			break;
		case "Basic Options":
			self add_menu(menu);

			self add_toggle("God Mode", "Makes you Invincible", ::god_mode, self.god_mode);
			self add_toggle("No Clip", "Fly through the Map", ::no_clip, self.no_clip);
			self add_toggle("Frag No Clip", "Fly through the Map using (^3[{+frag}]^7)", ::frag_no_clip, self.frag_no_clip);
			self add_toggle("UFO", "Fly Straight through the Map", ::ufo_mode, self.ufo_mode);
			self add_toggle("Infinite Ammo", "Gives you Infinite Ammo and Infinite Grenades", ::infinite_ammo, self.infinite_ammo);
			self add_toggle("Self Revive", "Auto-Revive when Entering Last Stand", ::self_revive, self.self_revive);

			self add_option("Give Perks", undefined, ::new_menu, "Give Perks");
			self add_option("Take Perks", undefined, ::new_menu, "Take Perks");
			self add_option("Give Perma Perkaholic", "Gives you all Perks that won't go away after dying", ::give_perkaholic);

			self add_increment("Set Points", undefined, ::set_points, 500, 0, 100000, 500);

			break;
		case "Weapon Options":
			self add_menu(menu);

			self add_option("Give Weapons", undefined, ::new_menu, "Give Weapons");

			self add_toggle("Give Pack-a-Punched Weapons", "Weapons Given will be Pack-a-Punched", ::give_packed_weapon, self.give_packed_weapon);
			self add_toggle("Give Double Pack-a-Punched Weapons", "Weapons Given will be Double Pack-a-Punched", ::give_double_packed_weapon, self.give_double_packed_weapon);

			self add_option("Take Current Weapon", undefined, ::take_weapon);
			self add_option("Drop Current Weapon", undefined, ::drop_weapon);

			self add_toggle("Double Pack-a-Punch", "Activate Double Pack-a-Punch", ::double_pack, self.double_pack);
			self add_toggle("Mystery Wheel Pack-a-Punch", "Pack-a-Punched Weapons in the Mystery Wheel", ::upgraded_box_weapons, self.upgraded_box_weapons);
			self add_toggle("Mystery Wheel Double Pack-a-Punch", "Double Pack-a-Punched Weapons in the Mystery Wheel", ::double_upgraded_box_weapons, self.double_upgraded_box_weapons);
			self add_toggle("Freeze Mystery Wheel", "Locks the Mystery Wheel, so it can't move", ::freeze_box, self.freeze_box);

			break;
		case "Fun Options":
			self add_menu(menu);

			self add_toggle("Exo Movement", "Enable/Disable Exo-Suits", ::exo_movement, self.exo_movement);
			self add_toggle("Max Money in Bank", "Maxes out the Money in the ATM", ::max_bank, self.max_bank);

			self add_toggle("Fullbright", "Removes all Shadows and Lighting", ::fullbright, self.fullbright);
			self add_toggle("Third Person", undefined, ::third_person, self.third_person);

			self add_increment("Set Speed", undefined, ::set_speed, 190, 190, 1190, 50);
			self add_increment("Set Timescale", undefined, ::set_timescale, 1, 1, 10, 1);
			self add_increment("Set Gravity", undefined, ::set_gravity, 800, 40, 800, 10);

			self add_option("Visions", undefined, ::new_menu, "Visions");

			break;
		case "Powerup Options":
			self add_menu(menu);

			self add_toggle("Shoot Powerups", undefined, ::shoot_powerups, self.shoot_powerups);

			for(i = 0; i < self.syn["powerups"][0].size; i++) {
				self add_option("Spawn " + self.syn["powerups"][0][i], undefined, ::spawn_powerup, self.syn["powerups"][1][i]);
			}

			break;
		case "Zombie Options":
			self add_menu(menu);

			self add_toggle("No Target", "Zombies won't Target You", ::no_target, self.no_target);

			self add_increment("Set Round", undefined, ::set_round, 1, 1, 255, 1);

			self add_option("Spawn Zombies", undefined, ::new_menu, "Spawn Zombies");
			self add_option("Kill All Zombies", undefined, ::kill_all_zombies);
			self add_option("Teleport Zombies to Me", undefined, ::teleport_zombies);

			self add_toggle("One Shot Zombies", undefined, ::one_shot_zombies, self.one_shot_zombies);
			self add_toggle("Freeze Zombies", undefined, ::freeze_zombies, self.freeze_zombies);
			self add_toggle("Disable Zombie Spawns", undefined, ::zombies_spawn, self.zombies_spawn);

			self add_array("Zombie ESP", "Set Colored Outlines around Zombies", ::set_outline_color, ["None", "White", "Red", "Green", "Aqua", "Orange", "Yellow"]);

			break;
		case "Teleport Options":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["Main Teleports"][map][0].size; i++) {
				self add_option(self.syn["Main Teleports"][map][0][i], undefined, ::set_position, self.syn["Main Teleports"][map][1][i], (0, self.syn["Main Teleports"][map][2][i], 0));
			}

			if(isDefined(self.syn["Map Setup Teleports"][map][0])) {
				self add_option("Map Setup Teleports", undefined, ::new_menu, "Map Setup Teleports");
			}
			if(isDefined(self.syn["Mystery Wheel Teleports"][map][0])) {
				self add_option("Mystery Wheel Teleports", undefined, ::new_menu, "Mystery Wheel Teleports");
			}
			if(isDefined(self.syn["Main Quest Teleports"][map][0])) {
				self add_option("Main Quest Teleports", undefined, ::new_menu, "Main Quest Teleports");
			}
			if(isDefined(self.syn["Extra Teleports"][map][0])) {
				self add_option("Extra Teleports", undefined, ::new_menu, "Extra Teleports");
			}

			break;
		case "Account Options":
			self add_menu(menu);

			self add_increment("Set Prestige", undefined, ::set_prestige, 0, 0, 20, 1);
			self add_increment("Set Level", undefined, ::set_rank, 1, 1, 999, 1);
			self add_increment("Set XP Scale", undefined, ::set_xp_scale, 1, 1, 10, 1);

			self add_option("Set Weapons to Max Level", undefined, ::set_max_weapons);

			self add_option("Complete All Challenges", undefined, ::complete_challenges);
			self add_option("Complete Active Contracts", undefined, ::complete_active_contracts);

			self add_option("Give All Soul Keys", undefined, ::unlock_soul_keys);
			self add_option("Unlock " + self.syn["maps"][self.map_name] + " Talisman", undefined, ::unlock_talismans);
			self add_toggle("Temp Director's Cut", undefined, ::temp_directors_cut, self.temp_directors_cut);

			break;
		case "Menu Options":
			self add_menu(menu);

			self add_increment("Move Menu X", "Move the Menu around Horizontally", ::modify_menu_position, 0, -600, 20, 10, "x");
			self add_increment("Move Menu Y", "Move the Menu around Vertically", ::modify_menu_position, 0, -100, 30, 10, "y");

			self add_option("Rainbow Menu", "Set the Menu Outline Color to Cycling Rainbow", ::set_menu_rainbow);

			self add_increment("Red", "Set the Red Value for the Menu Outline Color", ::set_menu_color, 255, 1, 255, 1, "Red");
			self add_increment("Green", "Set the Green Value for the Menu Outline Color", ::set_menu_color, 255, 1, 255, 1, "Green");
			self add_increment("Blue", "Set the Blue Value for the Menu Outline Color", ::set_menu_color, 255, 1, 255, 1, "Blue");

			self add_toggle("Hide UI", undefined, ::hide_ui, self.hide_ui);
			self add_toggle("Hide Weapon", undefined, ::hide_weapon, self.hide_weapon);

			break;
		case "All Players":
			self add_menu(menu);

			foreach(player in level.players) {
				self add_option(player.name, undefined, ::new_menu, "Player Option", player);
			}

			break;
		case "Player Option":
			self add_menu(menu);

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

				if(!target isHost()) {
					self add_option("Kick", "Kick the Player from the Game", ::kick_player, target);
				}
			} else {
				self add_option("Player not found");
			}

			break;
		case "Give Perks":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], undefined, scripts\cp\zombies\zombies_perk_machines::give_zombies_perk, self.syn["perks"][0][i], 0);
			}

			if(map == "cp_zmb" || map == "cp_disco" || map == "cp_town" || map == "cp_final") {
				for(i = 0; i < self.syn["perks"][map][0].size; i++) {
					self add_option(self.syn["perks"][map][1][i], undefined, scripts\cp\zombies\zombies_perk_machines::give_zombies_perk, self.syn["perks"][map][0][i], 0);
				}
			}

			break;
		case "Take Perks":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["perks"][0].size; i++) {
				self add_option(self.syn["perks"][1][i], undefined, scripts\cp\zombies\zombies_perk_machines::take_zombies_perk, self.syn["perks"][0][i]);
			}

			if(map == "cp_zmb" || map == "cp_disco" || map == "cp_town" || map == "cp_final") {
				for(i = 0; i < self.syn["perks"][map][0].size; i++) {
					self add_option(self.syn["perks"][map][1][i], undefined, scripts\cp\zombies\zombies_perk_machines::take_zombies_perk, self.syn["perks"][map][0][i], 0);
				}
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
				self add_option(self.syn["visions"][1][i], undefined, ::set_vision, self.syn["visions"][0][i]);
			}

			break;
		case "Spawn Zombies":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["zombies"][map][0].size; i++) {
				self add_option("Spawn " + self.syn["zombies"][map][1][i], undefined, ::spawn_zombie, self.syn["zombies"][map][0][i]);
			}

			break;
		case "Map Setup Teleports":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["Map Setup Teleports"][map][0].size; i++) {
				self add_option(self.syn["Map Setup Teleports"][map][0][i], undefined, ::set_position, self.syn["Map Setup Teleports"][map][1][i], (0, self.syn["Map Setup Teleports"][map][2][i], 0));
			}

			break;
		case "Mystery Wheel Teleports":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["Mystery Wheel Teleports"][map][0].size; i++) {
				self add_option(self.syn["Mystery Wheel Teleports"][map][0][i], undefined, ::set_position, self.syn["Mystery Wheel Teleports"][map][1][i], (0, self.syn["Mystery Wheel Teleports"][map][2][i], 0));
			}

			break;
		case "Main Quest Teleports":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["Main Quest Teleports"][map][0].size; i++) {
				self add_option(self.syn["Main Quest Teleports"][map][0][i], undefined, ::set_position, self.syn["Main Quest Teleports"][map][1][i], (0, self.syn["Main Quest Teleports"][map][2][i], 0));
			}

			break;
		case "Extra Teleports":
			self add_menu(menu);

			map = self.map_name;

			for(i = 0; i < self.syn["Extra Teleports"][map][0].size; i++) {
				self add_option(self.syn["Extra Teleports"][map][0][i], undefined, ::set_position, self.syn["Extra Teleports"][map][1][i], (0, self.syn["Extra Teleports"][map][2][i], 0));
			}

			break;
		case "Zombies in Spaceland":
			self add_menu(menu);

			self add_increment("Give Tickets", undefined, ::give_tickets, 50, 50, 950, 50);
			self add_option("Turn on Power & Open Doors", undefined, scripts\cp\zombies\direct_boss_fight::open_sesame);
			self add_toggle("Show Dischord Targets", undefined, ::show_dischord_targets, self.show_dischord_targets);
			self add_option("Move UFO to Main Portal", undefined, ::move_ufo_to_center_portal);
			self add_option("Move UFO to Spawn", undefined, ::move_ufo_to_spawn);
			self add_toggle("UFO Follows Player", undefined, ::ufo_follow_player, self.ufo_follow_player);
			self add_toggle("Random UFO Colors", undefined, ::cycle_ufo_colors, self.cycle_ufo_colors);
			self add_option("Spawn Alien Fuses", "Spawns Alien Fuses in front of the Main Portal", ::drop_alien_fuses);

			break;
		case "Rave in the Redwoods":
			self add_menu(menu);

			self add_option("Turn on Power & Open Doors", undefined, scripts\cp\zombies\direct_boss_fight::open_sesame);
			self add_toggle("Rave Mode", undefined, ::enable_rave_mode, self.enable_rave_mode);
			self add_option("Complete Vlad Quest", undefined, ::complete_vlad);

			break;
		case "Shaolin Shuffle":
			self add_menu(menu);

			self add_option("Turn on Power & Open Doors", undefined, scripts\cp\zombies\direct_boss_fight::open_sesame);
			self add_toggle("Unlimited Chi", undefined, ::unlimited_chi, self.unlimited_chi);

			break;
		case "Attack of the Radioactive Thing":
			self add_menu(menu);

			self add_option("Open Doors", undefined, scripts\cp\zombies\direct_boss_fight::open_sesame);
			self add_toggle("Full Color", undefined, ::attack_toggle_full_color, self.full_color);

			break;
		case "The Beast from Beyond":
			self add_menu(menu);

			self add_option("Turn on Power & Open Doors", undefined, ::beast_open_sesame);
			self add_option("Complete Venom-X Quest", undefined, ::complete_venom_x);

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

			map = self.map_name;

			if(map == "cp_town") {
				for(i = 0; i < self.syn["melee"][map][0].size; i++) {
					self add_option(self.syn["melee"][map][1][i], undefined, ::give_melee, self.syn["melee"][map][0][i]);
				}
			}

			break;
		case "Specialist Weapons":
			self add_menu(menu);

			load_weapons("specialist");

			break;
		case "Map Specific Weapons":
			self add_menu(menu);

			load_weapons(self.map_name);

			break;
		case "Other Weapons":
			self add_menu(menu);

			load_weapons("other");

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
	}
}

set_menu_color(value, color) {
	if(color == "Red") {
		self.menu_color_red = value;
		iPrintln(color + " Changed to " + value);
	} else if(color == "Green") {
		self.menu_color_green = value;
		iPrintln(color + " Changed to " + value);
	} else if(color == "Blue") {
		self.menu_color_blue = value;
		iPrintln(color + " Changed to " + value);
	} else {
		iPrintln(value + " | " + color);
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
		iPrintln("God Mode [^2ON^7]");
	} else {
		iPrintln("God Mode [^1OFF^7]");
	}
}

no_clip() {
	self.no_clip = !return_toggle(self.no_clip);
	executecommand("noclip");
	wait 0.01;
	if(self.no_clip) {
		iPrintln("No Clip [^2ON^7]");
	} else {
		iPrintln("No Clip [^1OFF^7]");
	}
}

frag_no_clip() {
	self endon("disconnect");
	self endon("game_ended");

	if(!isDefined(self.frag_no_clip)) {
		self.frag_no_clip = true;
		iPrintln("Frag No Clip [^2ON^7], Press ^3[{+frag}]^7 to Enter and ^3[{+melee}]^7 to Exit");
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
		iPrintln("Frag No Clip [^1OFF^7]");
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
		iPrintln("UFO Mode [^2ON^7]");
	} else {
		iPrintln("UFO Mode [^1OFF^7]");
	}
}

infinite_ammo() {
	self.infinite_ammo = !return_toggle(self.infinite_ammo);
	if(self.infinite_ammo) {
		iPrintln("Infinite Ammo [^2ON^7]");
		enable_infinite_ammo(self.infinite_ammo);
		self thread infinite_ammo_loop();
	} else {
		iPrintln("Infinite Ammo [^1OFF^7]");
		enable_infinite_ammo(self.infinite_ammo);
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
		self scripts\cp\powers\coop_powers::power_adjustcharges(2, "primary", 2);
		self scripts\cp\powers\coop_powers::power_adjustcharges(2, "secondary", 2);
		wait 0.2;
	}
}

self_revive() {
	self.self_revive = !return_toggle(self.self_revive);
	if(self.self_revive) {
		iPrintln("Self Revive [^2ON^7]");
		self thread self_revive_loop();
	} else {
		iPrintln("Self Revive [^1OFF^7]");
		self notify("stop_self_revive");
	}
}

self_revive_loop() {
	self endon("stop_self_revive");
	self endon("game_ended");

	for(;;) {
		self.self_revive = 1;
		wait 5;
	}
}

give_perkaholic() {
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(self);
}

set_points(value) {
	self setPlayerData("cp", "alienSession", "currency", value);
}

// Fun Options

exo_movement() {
	self.exo_movement = !return_toggle(self.exo_movement);
	if(self.exo_movement) {
		iPrintln("Exo Movement [^2ON^7]");
		self allowdoublejump(1);
		self allowwallrun(1);
		self allowdodge(1);
		self allowMantle(1);
		self.disabledMantle = 0;
	} else {
		iPrintln("Exo Movement [^1OFF^7]");
		self allowdoublejump(0);
		self allowwallrun(0);
		self allowdodge(0);
		self allowMantle(0);
		self.disabledMantle = 1;
	}
}

max_bank() {
	self.max_bank = !return_toggle(self.max_bank);
	if(self.max_bank) {
		iPrintln("Max Money in Bank [^2ON^7]");
		self.old_bank = level.atm_amount_deposited;
		level.atm_amount_deposited = 2147483647;
	} else {
		iPrintln("Max Money in Bank [^1OFF^7]");
		level.atm_amount_deposited = self.old_bank;
	}
}

freeze_box() {
	self.freeze_box = !return_toggle(self.freeze_box);
	if(self.freeze_box) {
		iPrintln("Freeze Box [^2ON^7]");
		self thread freeze_box_loop();
	} else {
		iPrintln("Freeze Box [^1OFF^7]");
		level.var_B162 = 1;
		level.var_13D01 = 4;
		level notify("stop_freeze_box");
	}
}

freeze_box_loop() {
	self endon("death");
	self endon("disconnect");
	self endon("stop_freeze_box");
	for(;;) {
		level.var_13D01 = 0;
		wait 1;
	}
}

fullbright() {
	self.fullbright = !return_toggle(self.fullbright);
	if(self.fullbright) {
		iPrintln("Fullbright [^2ON^7]");
		setDvar("r_fullbright", 1);
		wait 0.01;
	} else {
		iPrintln("Fullbright [^1OFF^7]");
		setDvar("r_fullbright", 0);
		wait 0.01;
	}
}

third_person() {
	self.third_person = !return_toggle(self.third_person);
	if(self.third_person) {
		iPrintln("Third Person [^2ON^7]");
		setDvar("camera_thirdPerson", 1);
		setThirdPersonDOF(1);
	} else {
		iPrintln("Third Person [^1OFF^7]");
		setDvar("camera_thirdPerson", 0);
		setThirdPersonDOF(0);
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
	iPrintln(target);
}

commit_suicide(target) {
	target suicide();
}

kick_player(target) {
	kick(target getEntityNumber());
}

// Powerup Options

spawn_powerup(powerup) {
	level scripts\cp\loot::drop_loot(self.origin + anglesToForward(self.angles) * 115, undefined, powerup, undefined, undefined, 1);
}

shoot_powerups() {
	self.shoot_powerups = !return_toggle(self.shoot_powerups);
	if(self.shoot_powerups) {
		iPrintln("Shoot Powerups [^2ON^7]");
		shoot_powerups_loop();
	} else {
		iPrintln("Shoot Powerups [^1OFF^7]");
		self notify("stop_shoot_powerups");
	}
}

shoot_powerups_loop() {
	self endon("stop_shoot_powerups");
	self endon("game_ended");

	for(;;) {
		while(self attackButtonPressed()) {
			powerup = self.syn["powerups"][1][randomint(self.syn["powerups"][1].size)];
			level scripts\cp\loot::drop_loot(self.origin + anglesToForward(self.angles) * 115, undefined, powerup, undefined, undefined, 0);
			wait 0.5;
		}
		wait 0.05;
	}
}

// Weapon Options

double_pack() {
	self.double_pack = !return_toggle(self.double_pack);
	if(self.double_pack) {
		iPrintln("Double Pack-a-Punch [^2ON^7]");
		level.pap_max++;
	} else {
		iPrintln("Double Pack-a-Punch [^1OFF^7]");
		level.pap_max--;
	}
}

upgraded_box_weapons() {
	self.upgraded_box_weapons = !return_toggle(self.upgraded_box_weapons);
	if(self.upgraded_box_weapons) {
		iPrintln("Mystery Wheel Pack-a-Punch [^2ON^7]");
		level.magic_wheel_upgraded_pap1 = 1;
	} else {
		iPrintln("Mystery Wheel Pack-a-Punch [^1OFF^7]");
		level.magic_wheel_upgraded_pap1 = 0;
	}
}

double_upgraded_box_weapons() {
	self.double_upgraded_box_weapons = !return_toggle(self.double_upgraded_box_weapons);
	if(self.double_upgraded_box_weapons) {
		iPrintln("Mystery Wheel Double Pack-a-Punch [^2ON^7]");
		level.magic_wheel_upgraded_pap2 = 1;
	} else {
		iPrintln("Mystery Wheel Double Pack-a-Punch [^1OFF^7]");
		level.magic_wheel_upgraded_pap2 = 0;
	}
}

give_packed_weapon() {
	self.give_packed_weapon = !return_toggle(self.give_packed_weapon);
	if(isDefined(self.give_double_packed_weapon) && self.give_double_packed_weapon == true) {
		self.give_double_packed_weapon = !return_toggle(self.give_double_packed_weapon);
	}
}

give_double_packed_weapon() {
	self.give_double_packed_weapon = !return_toggle(self.give_double_packed_weapon);
	if(isDefined(self.give_packed_weapon) && self.give_packed_weapon == true) {
		self.give_packed_weapon = !return_toggle(self.give_packed_weapon);
	}
}

give_melee(weapon) {
	if(isDefined(self.currentMeleeWeapon)) {
		self takeWeapon(self.currentMeleeWeapon);
	}
	self giveWeapon(weapon);
	self.default_starting_melee_weapon = weapon;
	self.currentMeleeWeapon = weapon;
	self.melee_weapon = weapon;
}

give_weapon(weapon, category, index) {
	if(isDefined(self.give_packed_weapon) && self.give_packed_weapon == 1 || isDefined(self.give_double_packed_weapon) && self.give_double_packed_weapon == 1) {
		papText = undefined;
		papCamo = undefined;
		papLevel = undefined;
		if(self.give_packed_weapon == 1) {
			papText = "pap1";
			papCamo = self.syn["camos"][self.map_name][0];
			papLevel = "1";
		} else if(self.give_double_packed_weapon == 1) {
			papText = "pap2";
			papCamo = self.syn["camos"][self.map_name][1];
			papLevel = "2";
		}

		if(weapon == "iw7_axe_zm") {
			weapon += "_pap" + papLevel + "+axe" + papText;
		} else if(weapon == "iw7_dischord_zm") {
			weapon += "_pap1+dischordpap1+camo20";
		} else if(weapon == "iw7_facemelter_zm") {
			weapon += "_pap1+fmpap1+camo22";
		} else if(weapon == "iw7_headcutter_zm") {
			weapon += "_pap1+hcpap1+camo21";
		} else if(weapon == "iw7_shredder_zm") {
			weapon += "_pap1+shredderpap1+camo23";
		} else if(weapon == "iw7_katana_zm") {
			weapon += "_pap" + papLevel + "+camo222";
		} else if(weapon == "iw7_nunchucks_zm") {
			weapon += "_pap" + papLevel + "+camo222";
		} else if(weapon == "iw7_forgefreeze_zm+forgefreezealtfire") {
			weapon += "+freeze" + papText;
		} else if(weapon == "iw7_spaceland_wmd" || weapon == "iw7_fists_zm" || weapon == "iw7_entangler_zm" || weapon == "iw7_atomizer_mp" || weapon == "iw7_penetrationrail_mp+penetrationrailscope" || weapon == "iw7_steeldragon_mp" || weapon == "iw7_claw_mp" || weapon == "iw7_blackholegun_mp+blackholegunscope" || weapon == "iw7_cutie_zm") {
		} else {
			weapon = build_custom_weapon(weapon, papCamo, [papText]);
		}
	} else {
		switch(weapon) {
			case "iw7_axe_zm":
			case "iw7_dischord_zm":
			case "iw7_facemelter_zm":
			case "iw7_headcutter_zm":
			case "iw7_shredder_zm":
			case "iw7_golf_club_mp":
			case "iw7_spiked_bat_mp":
			case "iw7_two_headed_axe_mp":
			case "iw7_machete_mp":
			case "iw7_harpoon1_zm":
			case "iw7_harpoon2_zm":
			case "iw7_harpoon3_zm+akimbo":
			case "iw7_harpoon4_zm":
			case "iw7_katana_zm":
			case "iw7_nunchucks_zm":
			case "iw7_venomx_zm":
			case "iw7_forgefreeze_zm+forgefreezealtfire":
			case "iw7_spaceland_wmd":
			case "iw7_cutie_zm":
			case "iw7_fists_zm":
			case "iw7_entangler_zm":
			case "iw7_atomizer_mp":
			case "iw7_penetrationrail_mp+penetrationrailscope":
			case "iw7_steeldragon_mp":
			case "iw7_claw_mp":
			case "iw7_blackholegun_mp+blackholegunscope":
				break;
			default:
				weapon = build_custom_weapon(weapon, undefined, undefined);
		}
	}

	if(self getCurrentWeapon() != weapon && self getWeaponsListPrimaries()[1] != weapon && self getWeaponsListPrimaries()[2] != weapon && self getWeaponsListPrimaries()[3] != weapon && self getWeaponsListPrimaries()[4] != weapon) {
		if(self has_zombie_perk("perk_machine_more")) {
			max_weapon_num = 4;
		} else {
			max_weapon_num = 3;
		}
		if(self getWeaponsListPrimaries().size >= max_weapon_num) {
			self takeWeapon(self getCurrentWeapon());
		}

		if(weapon == "iw7_spaceland_wmd" || weapon == "iw7_fists_zm" || weapon == "iw7_entangler_zm" || weapon == "iw7_atomizer_mp" || weapon == "iw7_penetrationrail_mp+penetrationrailscope" || weapon == "iw7_steeldragon_mp" || weapon == "iw7_claw_mp" || weapon == "iw7_blackholegun_mp+blackholegunscope" || weapon == "iw7_cutie_zm") {
			self giveWeapon(weapon);
			self switchToWeapon(weapon);
		} else {
			self giveWeapon(return_weapon_name_with_like_attachments(weapon));
			self switchToWeapon(return_weapon_name_with_like_attachments(weapon));
		}
	} else {
		self switchToWeaponImmediate(return_weapon_name_with_like_attachments(weapon));
	}
	wait 1;
	self setWeaponAmmoClip(self getCurrentWeapon(), 999);
	self setWeaponAmmoClip(self getCurrentWeapon(), 999, "left");
	self setWeaponAmmoClip(self getCurrentWeapon(), 999, "right");
}

build_custom_weapon(weapon, camo, extra_attachments) {
	weapon_name = getrawbaseweaponname(weapon);

	if(isDefined(self.weapon_build_models[weapon_name])) {
		weapon_model = self.weapon_build_models[weapon_name];
		weapon_attachments = getweaponattachments(weapon_model);
		weapon_build = array_combine(extra_attachments, weapon_attachments);
		weapon_custom = self return_weapon_name_with_like_attachments(getweaponbasename(weapon), undefined, weapon_build, 1, camo);
		return weapon_custom;
	} else {
		weapon_custom = array_combine(extra_attachments, weapon);
		return weapon_custom;
	}
}

take_weapon() {
	self takeWeapon(self getCurrentWeapon());
	self switchToWeapon(self getWeaponsListPrimaries()[0]);
}

drop_weapon() {
	self dropitem(self getCurrentWeapon());
	self switchToWeapon(self getWeaponsListPrimaries()[0]);
}

// Zombie Options

no_target() {
	self.no_target = !return_toggle(self.no_target);
	if(self.no_target) {
		iPrintln("No Target [^2ON^7]");
		self.ignoreme = 1;
	} else {
		iPrintln("No Target [^1OFF^7]");
		self.ignoreme = 0;
	}
}

set_round(value) {
	level.wave_num = value;
}

get_zombies() {
	return scripts\cp\cp_agent_utils::getAliveAgentsOfTeam("axis");
}

spawn_zombie(archetype) {
	team = "axis";
	if(archetype == "zombie_grey") {
		weapon = "iw7_zapper_grey";
	} else if(archetype == "the_hoff" || archetype == "pamgrier" || archetype == "elvira") {
		weapon = "iw7_ake_zmr+akepap2";
		team = "allies";
	} else {
		weapon = undefined;
	}
	scripts\mp\mp_agent::spawnNewAgent(archetype, team, self.origin + anglesToForward(self.angles) * 200, self.angles, weapon);
}

kill_all_zombies() {
	foreach(zombie in get_zombies()) {
		zombie doDamage(zombie.health + 999, zombie.origin);
	}
}

teleport_zombies() {
	foreach(zombie in get_zombies()) {
		zombie setOrigin(self.origin + anglesToForward(self.angles) * 200);
	}
}

one_shot_zombies() {
	if(!isDefined(self.one_shot_zombies)) {
		iPrintln("One Shot Zombies [^2ON^7]");
		self.one_shot_zombies = true;
		zombies = get_zombies();
		level.prevHealth = zombies[0].health;
		while(isDefined(self.one_shot_zombies)) {
			foreach(zombie in get_zombies()) {
				zombie.maxHealth = 1;
				zombie.health = zombie.maxHealth;
			}
			wait 0.01;
		}
	} else {
		iPrintln("One Shot Zombies [^1OFF^7]");
		self.one_shot_zombies = undefined;
		foreach(zombie in get_zombies()) {
			zombie.maxHealth = level.prevHealth;
			zombie.health = level.prevHealth;
		}
	}
}

freeze_zombies() {
	if(!isDefined(self.freeze_zombies)) {
		iPrintln("Freeze Zombies [^2ON^7]");
		self.freeze_zombies = true;
		while(isDefined(self.freeze_zombies)) {
			foreach(zombie in get_zombies()) {
				zombie freezeControls(true);
			}
			wait 0.01;
		}
	} else {
		iPrintln("Freeze Zombies [^1OFF^7]");
		self.freeze_zombies = undefined;
		foreach(zombie in get_zombies()) {
			zombie freezeControls(false);
		}
	}
}

zombies_spawn() {
	self.zombies_spawn = !return_toggle(self.zombies_spawn);
	if(self.zombies_spawn) {
		iPrintln("Disable Zombie Spawns [^2ON^7]");
		flag_set("pause_wave_progression");
		level.zombies_paused = 1;
		level.dont_resume_wave_after_solo_afterlife = 1;
	} else {
		iPrintln("Disable Zombie Spawns [^1OFF^7]");
		level.dont_resume_wave_after_solo_afterlife = undefined;
		level.zombies_paused = 0;
		flag_clear("pause_wave_progression");
	}
}

set_outline_color(color) {
	if(color == "White") {
		self.outline_color = 0;
	} else if(color == "Red") {
		self.outline_color = 1;
	} else if(color == "Green") {
		self.outline_color = 2;
	} else if(color == "Aqua") {
		self.outline_color = 3;
	} else if(color == "Orange") {
		self.outline_color = 4;
	} else if(color == "Yellow") {
		self.outline_color = 5;
	}

	if(!isDefined(self.outline_zombies) && color != "None") {
		iPrintln("Zombie ESP [^2ON^7]");
		self.outline_zombies = true;
		outline_zombies_loop();
	} else if(color == "None") {
		iPrintln("Zombie ESP [^1OFF^7]");
		self notify("stop_outline_zombies");
		self.outline_zombies = undefined;
		foreach(zombie in get_zombies()) {
			scripts\cp\cp_outline::disable_outline_for_players(zombie, level.players);
		}
	}
}

outline_zombies_loop() {
	self endon("stop_outline_zombies");
	self endon("game_ended");

	for(;;) {
		foreach(zombie in get_zombies()) {
			scripts\cp\cp_outline::enable_outline_for_players(zombie, level.players, self.outline_color, 0, 0, "high");
		}
		wait 0.2;
	}
}

// Teleport Options

set_position(origin, angles) {
	self setOrigin(origin);
	self setPlayerAngles(angles);
}

// Account Options

set_prestige(value) {
	self setPlayerData("cp", "progression", "playerLevel", "prestige", value);
}

set_rank(value) {
	value--;
	self setPlayerData("cp", "progression", "playerLevel", "xp", int(tableLookup("cp/zombies/rankTable.csv", 0, value, (value == int(tableLookup("cp/zombies/rankTable.csv", 0, "maxrank", 1))) ? 7 : 2)));
}

set_xp_scale(xpScale) {
	iPrintln("XP Multiplier Set to [^3" + xpScale + "x^7]");
	self.xpScale = xpScale;
	self.weaponxpscale = xpScale;
}

set_max_weapons() {
	for(x = 1; x < 62; x++) {
		weapon = tableLookup("mp/statstable.csv", 0, x, 4);

		if(!isDefined(weapon) || weapon == "") {
			continue;
		}

		self setPlayerData("common", "sharedProgression", "weaponLevel", weapon, "cpXP", 54300);
		self setPlayerData("common", "sharedProgression", "weaponLevel", weapon, "prestige", 3);

		iPrintln("Set ^3" + weapon + "^7 to Max Level");

		wait 0.175;
	}
}

complete_challenges() {
	merits = getArrayKeys(level.meritinfo);

	if(!isDefined(merits) || !merits.size) {
		return;
	}

	foreach(merit in merits) {
		meritInfo = level.meritinfo[merit]["targetval"];
		meritState = self getRankedPlayerData("cp", "meritState", merit);
		meritProgress = self getRankedPlayerData("cp", "meritProgress", merit);

		if(!isDefined(meritInfo)) {
			continue;
		}

		if(meritState < meritInfo.size || meritProgress < meritInfo[(meritInfo.size - 1)]) {
			if(meritProgress < meritInfo[(meritInfo.size - 1)]) {
				self setPlayerData("cp", "meritProgress", merit, meritInfo[(meritInfo.size - 1)]);
				iPrintln("Completed Challenge: ^3" + merit);
			}

			if(meritState < meritInfo.size) {
				self setPlayerData("cp", "meritState", merit, meritInfo.size);
				iPrintln("Completed Challenge: ^3" + merit);
			}

			wait 0.175;
		}
	}
}

complete_active_contracts() {
	contracts = getArrayKeys(self.contracts);

	if(!isDefined(contracts) || !contracts.size) {
		return;
	}

	foreach(contract in contracts) {
		target = self.contracts[contract].target;
		progress = self getRankedPlayerData("cp", "contracts", "challenges", contract, "progress");

		if(!isDefined(progress) || !isDefined(target) || progress >= target) {
			continue;
		}

		self setPlayerData("cp", "contracts", "challenges", contract, "progress", target);
		self setPlayerData("cp", "contracts", "challenges", contract, "completed", 1);

		wait 0.01;
	}
}

unlock_soul_keys() {
	self setPlayerData("cp", "haveSoulKeys", "soul_key_1", 1);
	self setPlayerData("cp", "haveSoulKeys", "soul_key_2", 1);
	self setPlayerData("cp", "haveSoulKeys", "soul_key_3", 1);
	self setPlayerData("cp", "haveSoulKeys", "soul_key_4", 1);
	self setPlayerData("cp", "haveSoulKeys", "soul_key_5", 1);
	iPrintln("All Soul Keys Given");
	wait 2.5;
	iPrintln("Activate the Soul Jar to Unlock Perma Director's Cut");
	set_position((-10250, 875, -1630), (0, 90, 0));
}

unlock_talismans() {
	if(level.script == "cp_zmb") {
		self scripts\cp\cp_merits::processMerit("mt_tali_1");
	} else if(level.script == "cp_rave") {
		self scripts\cp\cp_merits::processMerit("mt_tali_2");
	} else if(level.script == "cp_disco") {
		self scripts\cp\cp_merits::processMerit("mt_tali_3");
	} else if(level.script == "cp_town") {
		self scripts\cp\cp_merits::processMerit("mt_tali_4");
	} else if(level.script == "cp_final") {
		self scripts\cp\cp_merits::processMerit("mt_tali_5");
	}
	self setPlayerData("cp", "haveItems", "item_1", 1);
	self setPlayerData("cp", "haveItems", "item_2", 1);
	self setPlayerData("cp", "haveItems", "item_3", 1);
	self setPlayerData("cp", "haveItems", "item_4", 1);
	self setPlayerData("cp", "haveItems", "item_5", 1);
	iPrintln(self.syn["maps"][self.map_name] + " Talisman Unlocked");
}

temp_directors_cut() {
	self.temp_directors_cut = !return_toggle(self.temp_directors_cut);
	if(self.temp_directors_cut) {
		iPrintln("Temp Director's Cut Enabled");
		self setPlayerData("cp", "dc", 1);
	} else {
		iPrintln("Temp Director's Cut Disabled");
		self setPlayerData("cp", "dc", 0);
	}
}

// Zombies in Spaceland

give_tickets(value) {
	self playLocalSound("zmb_ui_earn_tickets");
	scripts\cp\zombies\arcade_game_utility::give_player_tickets(self, value);
}

show_dischord_targets() {
	self.show_dischord_targets = !return_toggle(self.show_dischord_targets);
	if(self.show_dischord_targets) {
		iPrintln("Show Dischord Targets [^2ON^7]");
		self.wearing_dischord_glasses = 1;
	} else {
		iPrintln("Show Dischord Targets [^1OFF^7]");
		self.wearing_dischord_glasses = 0;
	}
}

// UFO

cycle_ufo_colors() {
	self.cycle_ufo_colors = !return_toggle(self.cycle_ufo_colors);
	if(self.cycle_ufo_colors) {
		iPrintln("Cycle UFO Colors [^2ON^7]");
		self thread cycle_ufo_loop();
	} else {
		iPrintln("Cycle UFO Colors [^1OFF^7]");
		self notify("stop_cycle_ufo_colors");
	}
}

cycle_ufo_loop() {
	self endon("stop_cycle_ufo_colors");
	for(;;) {
		for(i = 1; i < 6; i++) {
			level.ufo setmodel(get_ufo_model(i));
			wait 0.5;
		}
	}
}

get_ufo_model(color) {
	switch(color) {
		case 1:
			return "zmb_spaceland_ufo_blue";
		case 2:
			return "zmb_spaceland_ufo_green";
		case 3:
			return "zmb_spaceland_ufo_yellow";
		case 4:
			return "zmb_spaceland_ufo_red";
		case 5:
			return "zmb_spaceland_ufo";
		default:
			break;
	}
}

play_ufo_start_vfx() {
	snow_vfx_1 = (-1066.27, -2577.7, 2051.62);
	snow_vfx_2 = (-2164.96, -2780.52, 1923.13);
	snow_vfx_3 = (-1710.99, -2499.7, 1618.13);
	playSoundAtPos((-1198, -2137, 1946), "zmb_ufo_break_free_ice");
	playFx(level._effect["vfx_ufo_snow"], snow_vfx_1);
	playFx(level._effect["vfx_ufo_snow"], snow_vfx_2);
	wait 0.8;
	playFx(level._effect["vfx_ufo_snow"], snow_vfx_3);
}

move_ufo_to_center_portal() {
	if(!isDefined(level.ufo_spawned)) {
		level.ufo_spawned = 1;
		level thread play_ufo_start_vfx();
		ufo = level.ufo;
		ufo.angles = vectorToAngles((1, 0, 0));
		ufo playLoopSound("ufo_movement_lp");
		ufo.origin = (647, 621, 901);
		ufo.angles = (0, 0, 0);
		ufo scriptModelPlayAnim("zmb_spaceland_ufo_breakaway", 1);
		ufo setScriptablePartState("thrusters", "on");
		wait(7);
		ufo scriptModelPlayAnim("zmb_spaceland_ufo_idle");
		flag_set("ufo_intro_reach_center_portal");
	} else {
		level.ufo moveTo((647, 621, 901), 5);
		level.ufo waittill("movedone");
	}
}

move_ufo_to_spawn() {
	level.ufo moveTo((650, 2265, 901), 5);
	level.ufo waittill("movedone");
}

ufo_follow_player() {
	self.ufo_follow_player = !return_toggle(self.ufo_follow_player);
	if(self.ufo_follow_player) {
		iPrintln("UFO Follows Player [^2ON^7]");
		self thread ufo_follow_player_loop();
	} else {
		iPrintln("UFO Follows Player [^1OFF^7]");
		self notify("stop_ufo_follow_player");
	}
}

ufo_follow_player_loop() {
	self endon("stop_ufo_follow_player");
	for(;;) {
		level.ufo moveTo((level.players[0].origin[0], level.players[0].origin[1], 901), 5);
		level.ufo waittill("movedone");
	}
}

// Zombies

toggle_clowns() {
	foreach(zombie in level.spawned_enemies) {
		if(isDefined(zombie.agent_type) && zombie.agent_type == "generic_zombie") {
			zombie scripts\asm\zombie\zombie::turnintosuicidebomber(1);
			zombie setavoidanceradius(4);
			wait(randomFloatRange(0.3, 0.7));
		}
	}
}

// Fuses

drop_alien_fuses() {
	var_00 = spawn("script_model", (657, 765, 105));
	var_00 setModel("park_alien_gray_fuse");
	var_00.angles = (randomIntRange(0, 360), randomIntRange(0, 360), randomIntRange(0, 360));
	var_01 = spawn("script_model", (641, 765, 105));
	var_01 setModel("park_alien_gray_fuse");
	var_01.angles = (randomIntRange(0, 360), randomIntRange(0, 360), randomIntRange(0, 360));
	var_01 thread delay_spawn_glow_vfx_on(var_01, "souvenir_glow");
	var_01 thread item_keep_rotating(var_01);
	var_00 thread delay_spawn_glow_vfx_on(var_00, "souvenir_glow");
	var_00 thread item_keep_rotating(var_00);
	var_00 thread fuse_pick_up_monitor(var_00, var_01);
}

delay_spawn_glow_vfx_on(param_00, param_01) {
	param_00 endon("death");
	wait(0.3);
	playFxOnTag(level._effect[param_01], param_00, "tag_origin");
}

item_keep_rotating(param_00) {
	param_00 endon("death");
	var_01 = param_00.angles;
	for(;;) {
		param_00 rotateTo(var_01 + (randomIntRange(-40, 40), randomIntRange(-40, 90), randomIntRange(-40, 90)), 3);
		wait(3);
	}
}

fuse_pick_up_monitor(param_00, param_01) {
	param_00 endon("death");
	param_00 makeUsable();
	param_00 setHintString(&"CP_ZMB_UFO_PICK_UP_FUSE");
	foreach(var_03 in level.players) {
		var_03 thread scripts\cp\cp_vo::add_to_nag_vo("nag_ufo_fusefail", "zmb_comment_vo", 60, 15, 6, 1);
	}

	for(;;) {
		param_00 waittill("trigger", var_03);
		if(isplayer(var_03)) {
			var_03 playLocalSound("part_pickup");
			var_03 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_collect_alienfuse_2", "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
			break;
		}
	}

	level.num_fuse_in_possession++;
	scripts\cp\cp_interaction::add_to_current_interaction_list(getStruct("pap_upgrade", "script_noteworthy"));
	scripts\cp\cp_interaction::remove_from_current_interaction_list(getStruct("weapon_upgrade", "script_noteworthy"));
	level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_ufo_fusefail");
	foreach(var_03 in level.players) {
		var_03 setClientOmnvar("zm_special_item", 1);
	}

	param_01 delete();
	param_00 delete();
}

// Rave in the Redwoods

enable_rave_mode() {
	self.enable_rave_mode = !return_toggle(self.enable_rave_mode);
	if(self.enable_rave_mode) {
		iPrintln("Rave Mode [^2ON^7]");
		self.rave_mode = 1;
		self visionsetnakedforplayer("cp_rave_rave_mode", 0.1);
	} else {
		iPrintln("Rave Mode [^1OFF^7]");
		self.rave_mode = 0;
		self visionsetnakedforplayer("", 0.1);
	}
}

complete_vlad() {
	flag_set("chains_unlocked");
}

// Shaolin Shuffle

unlimited_chi() {
	self.unlimited_chi = !return_toggle(self.unlimited_chi);
	if(self.unlimited_chi) {
		iPrintln("Unlimited Chi [^2ON^7]");
		self.unlimited_chi = 1;
	} else {
		iPrintln("Unlimited Chi [^1OFF^7]");
		self.unlimited_chi = 0;
	}
}

// Attack of the Radioactive Thing

attack_toggle_full_color() {
	self.full_color = !return_toggle(self.full_color);
	if(self.full_color) {
		iPrintln("Full Color [^2ON^7]");
		level.current_vision_set = "cp_town_color";
		level.vision_set_override = level.current_vision_set;
		self visionsetnakedforplayer("cp_town_color", 1);
		level.film_grain_off = 1;
	} else {
		iPrintln("Full Color [^1OFF^7]");
		level.current_vision_set = "cp_town_bw";
		level.vision_set_override = level.current_vision_set;
		self visionsetnakedforplayer("cp_town_bw", 1);
		level.film_grain_off = 0;
	}
}

// Beast from Beyond

beast_open_sesame() {
	flag_set("neil_head_found");
	flag_set("neil_head_placed");
	flag_set("restorepower_step1");
	flag_set("power_on");
	level notify("power_on");

	set_quest_icon(6);
	heads = getStructArray("neil_head", "script_noteworthy");
	foreach(head in heads) {
		if(isDefined(head.headmodel)) {
			head.headmodel delete();
		}
	}

	foreach(door in level.allslidingdoors) {
		door.player_opened = 1;
		thread [[level.interactions[door.script_noteworthy].activation_func]](door, undefined);
	}
}

complete_venom_x() {
	flag_set("completepuzzles_step4");
	getent("venomx_locker_door","script_noteworthy") rotateTo((0,105,0),0.1);
	level.completed_venomx_pap1_challenges = 1;
	level.completed_venomx_pap2_challenges = 1;
}