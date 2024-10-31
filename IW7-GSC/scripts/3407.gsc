// IW7 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_C900()
{
    scripts\engine\utility::_id_6E39( "jukebox_paused" );
    level._id_A4BD = [];
    level._id_72AB = [];
    level._id_689D = [ "mus_pa_sp_knightrider", "mus_pa_mw1_80s_cover", "mus_pa_mw2_80s_cover" ];
    level._id_10405 = 0;
    level._id_BF50 = 0;
    level.songs_played = 0;

    if ( isdefined( level._id_A4BF ) )
        var_0 = level._id_A4BF;
    else
        var_0 = "cp/zombies/cp_zmb_music_genre.csv";

    var_1 = 0;

    for (;;)
    {
        var_2 = tablelookupbyrow( var_0, var_1, 1 );

        if ( var_2 == "" )
            break;

        if ( scripts\engine\utility::array_contains( level._id_689D, var_2 ) )
        {
            var_1++;
            continue;
        }

        var_3 = tablelookupbyrow( var_0, var_1, 2 );
        var_4 = tablelookupbyrow( var_0, var_1, 3 );
        var_5 = tablelookupbyrow( var_0, var_1, 4 );
        var_6 = tablelookupbyrow( var_0, var_1, 5 );
        var_7 = spawnstruct();
        var_7._id_10406 = var_2;
        var_7._id_5747 = var_4;
        var_7._id_5748 = var_5;
        var_7._id_5745 = var_6;
        var_7._id_7783 = var_3;
        level._id_A4BD[level._id_A4BD.size] = var_7;
        var_1++;
    }
}

_id_A4BE( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    level endon( "add_hidden_song_to_playlist" );
    level endon( "add_hidden_song_2_to_playlist" );
    level endon( "force_new_song" );

    if ( !isdefined( var_1 ) )
    {
        level waittill( "jukebox_start" );

        if ( _id_0A77::map_check( 0 ) )
            var_3 = lookupsoundlength( "dj_jingle_intro" ) / 1000;
        else
            var_3 = 0.005;

        wait( var_3 );
    }

    if ( isdefined( level._id_A4BF ) )
        var_4 = level._id_A4BF;
    else
        var_4 = "cp/zombies/cp_zmb_music_genre.csv";

    if ( !scripts\engine\utility::_id_9CEE( var_2 ) )
    {
        var_5 = scripts\engine\utility::_id_22A8( level._id_A4BD );

        if ( isdefined( level._id_4B67 ) )
        {
            for (;;)
            {
                if ( var_5[0]._id_10406 == level._id_4B67 )
                    var_5 = scripts\engine\utility::_id_22A8( level._id_A4BD );
                else
                    break;

                wait 0.05;
            }
        }
    }
    else
        var_5 = level._id_A4BD;

    var_6 = spawn( "script_origin", var_0 );
    level.jukebox_org_struct = var_6;
    var_7 = _id_7C73( var_5, 1, var_6 );

    for (;;)
    {
        if ( scripts\engine\utility::_id_6E25( "jukebox_paused" ) )
            scripts\engine\utility::_id_6E5A( "jukebox_paused" );

        var_8 = var_7._id_10406;
        level._id_4B67 = var_8;
        var_5 = scripts\engine\utility::array_remove( var_5, var_7 );
        var_9 = var_7._id_5748;

        if ( var_5.size < 1 && !scripts\engine\utility::_id_9CEE( var_2 ) )
        {
            var_5 = scripts\engine\utility::_id_22A8( level._id_A4BD );

            if ( isdefined( level._id_4B67 ) )
            {
                for (;;)
                {
                    if ( var_5[0]._id_10406 == level._id_4B67 )
                        var_5 = scripts\engine\utility::_id_22A8( level._id_A4BD );
                    else
                        break;

                    wait 0.05;
                }
            }
        }

        var_10 = int( tablelookup( var_4, 1, var_8, 0 ) );
        var_6 playloopsound( var_8 );
        level.songs_played++;
        var_11 = lookupsoundlength( var_8 ) / 1000;
        setomnvar( "song_playing", var_10 );
        level.song_last_played = var_10;
        var_6 thread _id_5FB6( var_6 );
        level scripts\engine\utility::_id_13736( var_11, "skip_song" );
        var_6 stoploopsound();

        if ( level.songs_played % 4 == 0 )
        {
            if ( var_9 != "" )
            {
                var_6 playsound( var_9 );
                var_12 = lookupsoundlength( var_9 ) / 1000;
                level scripts\engine\utility::_id_13736( var_12 );
            }
        }

        var_7 = _id_7C73( var_5, 0, var_6 );
        wait 1.0;
    }
}

_id_5FB6( var_0 )
{
    level endon( "game_ended" );
    level scripts\engine\utility::waittill_any( "add_hidden_song_to_playlist", "add_hidden_song_2_to_playlist", "force_new_song" );
    var_0 stoploopsound();
    wait 2.0;

    if ( isdefined( var_0 ) )
        var_0 delete();
}

_id_728D( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    level endon( "game_ended" );
    level endon( "add_hidden_song_to_playlist" );
    level endon( "add_hidden_song_2_to_playlist" );
    level notify( "force_new_song" );
    level endon( "force_new_song" );

    if ( isdefined( var_5 ) )
        level._id_72AB[var_5] = var_5;

    var_7 = spawnstruct();
    var_7._id_10406 = var_1;
    var_7._id_5747 = "";
    var_7._id_5748 = "";
    var_7._id_5745 = "";
    var_7._id_7783 = "music";
    level._id_A4BD[level._id_A4BD.size] = var_7;

    if ( !isdefined( var_0 ) )
        var_0 = ( 649, 683, 254 );

    wait 2.5;

    if ( isdefined( var_3 ) )
    {

    }

    if ( isdefined( var_2 ) )
        scripts\engine\utility::_id_CE2B( var_2, var_0 );
    else
        scripts\engine\utility::_id_CE2B( "zmb_jukebox_on", var_0 );

    var_8 = spawn( "script_origin", var_0 );
    var_8 playloopsound( var_1 );
    level._id_4B67 = var_1;
    var_8 thread _id_5FB6( var_8 );
    var_9 = lookupsoundlength( var_1 ) / 1000;
    scripts\engine\utility::_id_13736( var_9, "skip_song" );
    var_8 stoploopsound();

    if ( getdvar( "ui_mapname" ) != "cp_disco" )
    {
        level thread _id_0A6A::_id_12885( "dj_sign_off", "zmb_dj_vo", "high", 20, 1, 0, 1 );
        var_10 = lookupsoundlength( "dj_sign_off" ) / 1000;
        wait( var_10 );
    }

    if ( scripts\engine\utility::_id_9CEE( var_6 ) )
        _id_C900();

    level thread _id_A4BE( ( 649, 683, 254 ), 1 );
}

_id_7C73( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    foreach ( var_9, var_4 in var_0 )
    {
        var_5 = var_0[var_9]._id_5747;

        if ( var_0[var_9]._id_7783 == "perk" )
        {
            if ( var_1 )
                continue;

            var_6 = gettime();

            if ( var_6 < level._id_BF50 && var_9 + 1 < var_0.size )
                continue;
            else
            {
                if ( isdefined( var_5 ) && var_5 != "" )
                {
                    level thread _id_0A6A::_id_12885( var_5, "zmb_dj_vo" );
                    var_7 = lookupsoundlength( var_5 ) / 1000;
                    wait( var_7 );
                }

                level._id_BF50 = gettime() + 180000;
                return var_0[var_9];
            }
        }
        else
        {
            if ( isdefined( var_5 ) && var_5 != "" )
            {
                if ( getdvar( "ui_mapname" ) == "cp_disco" )
                {
                    var_5 = cp_disco_pam_radio_vo();

                    if ( var_5 != "nil" )
                    {
                        while ( scripts\engine\utility::_id_9CEE( level.pam_playing ) || scripts\engine\utility::_id_9CEE( level._id_2001 ) )
                            wait 0.1;

                        var_2 playloopsound( var_5 );

                        if ( !isdefined( level.jukebox_playing ) )
                            level.jukebox_playing = [];

                        if ( !isdefined( level.jukebox_playing ) )
                            level.jukebox_playing[var_5] = [];

                        level.jukebox_playing[var_5] = 1;
                        var_2 thread _id_5FB6( var_2 );
                        var_8 = lookupsoundlength( var_5 ) / 1000;
                        scripts\engine\utility::_id_13736( var_8, "skip_song" );
                        level.jukebox_playing[var_5] = 0;
                        var_2 stoploopsound();
                    }
                }
                else
                {
                    level thread _id_0A6A::_id_12885( var_5, "zmb_dj_vo", "high", 20, 1, 0, 1 );
                    var_7 = lookupsoundlength( var_5 ) / 1000;
                    wait( var_7 );
                }
            }

            return var_0[var_9];
        }
    }
}

cp_disco_pam_radio_vo()
{
    var_0 = "nil";

    switch ( level.pam_radio_counter )
    {
        case 1:
            var_0 = "pam_radio_dojo_intro";
            break;
        case 2:
            var_0 = "pam_radio_power";
            break;
        case 3:
            var_0 = "pam_radio_perks";
            break;
        case 4:
            var_0 = "pam_radio_generic";
            break;
        case 5:
            var_0 = "pam_radio_dojo";
            break;
        case 6:
            var_0 = "pam_radio_pap";
            break;
        case 7:
            var_0 = "pam_radio_defeat_ratking_1";
            break;
        case 8:
            var_0 = "pam_radio_defeat_ratking_2";
            break;
        case 11:
            var_0 = "pam_radio_defeat_ratking_3";
            break;
        case 13:
            var_0 = "pam_radio_final_right_ratking";
            break;
        default:
            var_0 = "nil";
            break;
    }

    level.pam_radio_counter = level.pam_radio_counter + 1;
    return var_0;
}