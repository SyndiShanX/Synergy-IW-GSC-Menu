// IW7 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_6636()
{

}

_id_6639()
{

}

_id_7D0D( var_0 )
{

}

_id_1876()
{

}

_id_F390( var_0, var_1, var_2 )
{

}

_id_6638( var_0, var_1 )
{

}

_id_1877( var_0 )
{

}

_id_7997( var_0, var_1 )
{
    var_2 = getentarray();
    var_3 = [];

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    foreach ( var_5 in var_2 )
    {
        if ( !isdefined( var_5.classname ) )
            var_6 = "UNKNOWN?";
        else
            var_6 = var_5.classname;

        if ( var_0 )
        {
            if ( isai( var_5 ) )
                var_6 = "actors";
            else if ( _func_113( var_5 ) )
            {
                var_7 = getsubstr( var_6, 0, 5 );

                if ( var_7 == "actor" )
                    var_6 = "AI_spawners";
                else
                    var_6 = "vehicle_spawners";
            }
            else if ( isdefined( var_5._id_49BD ) )
                var_6 = var_5.classname + " CREATEFX";
            else if ( !isdefined( var_5.code_classname ) )
            {

            }
            else if ( var_5.code_classname == "script_model" )
            {
                if ( var_5._id_01F1 == "tag_origin" )
                    var_6 = "script_model TAG_ORIGIN";
            }
            else if ( var_5.code_classname == "trigger_multiple" )
            {
                var_7 = getsubstr( var_6, 0, 22 );

                if ( var_7 == "trigger_multiple_bcs_" )
                    var_6 = "trigger_multiple_bcs";
                else
                    var_6 = "trigger_multiple";
            }
            else
            {
                var_7 = getsubstr( var_5.code_classname, 0, 10 );

                if ( var_7 == "weapon_iw7" )
                    var_6 = "weapons";

                var_7 = getsubstr( var_5.code_classname, 0, 5 );

                if ( var_7 == "actor" )
                    var_6 = "drones";
            }
        }
        else
        {
            if ( isdefined( var_5._id_49BD ) )
                var_6 = "CREATEFX " + var_5.classname;

            if ( var_6 == "script_model" )
                var_6 = var_6 + ( " " + var_5._id_01F1 );
        }

        if ( !isdefined( var_3[var_6] ) )
            var_3[var_6] = 0;

        var_3[var_6]++;
    }

    if ( !isdefined( var_1 ) || !var_1 )
        var_3 = _id_10418( var_3 );

    return var_3;
}

_id_10418( var_0 )
{
    var_1 = getarraykeys( var_0 );

    for ( var_2 = 0; var_2 < var_1.size - 1; var_2++ )
    {
        for ( var_3 = var_2 + 1; var_3 < var_1.size; var_3++ )
        {
            if ( stricmp( var_1[var_2], var_1[var_3] ) > 0 )
            {
                var_4 = var_1[var_3];
                var_1[var_3] = var_1[var_2];
                var_1[var_2] = var_4;
            }
        }
    }

    var_5 = [];

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        var_5[var_1[var_2]] = var_0[var_1[var_2]];

    return var_5;
}

_id_4ED2( var_0 )
{
    var_1 = _func_072();

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2] getentitynumber() != var_0 )
            continue;

        var_1[var_2] thread _id_4ED3();
        break;
    }
}

_id_4F22( var_0 )
{
    var_1 = _func_072();

    for ( var_2 = 0; var_2 < var_1.size; var_2++ )
    {
        if ( var_1[var_2] getentitynumber() != var_0 )
            continue;

        var_1[var_2] notify( "stop_drawing_enemy_pos" );
        break;
    }
}

_id_4ED3()
{
    self endon( "death" );
    self endon( "stop_drawing_enemy_pos" );

    for (;;)
    {
        wait 0.05;

        if ( isalive( self._id_010C ) )
        {

        }

        if ( !scripts\anim\utility::_id_8BED() )
            continue;

        var_0 = scripts\anim\utility::_id_7E90();
    }
}

_id_4ED4()
{
    var_0 = _func_072();
    var_1 = undefined;

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_1 = var_0[var_2];

        if ( !isalive( var_1 ) )
            continue;

        if ( isdefined( var_1._id_01B2 ) )
        {

        }

        if ( isdefined( var_1._id_8451 ) )
        {
            if ( var_1 isbadguy() )
                var_3 = ( 1, 0, 0 );
            else
                var_3 = ( 0, 0, 1 );

            var_4 = var_1.origin + ( 0, 0, 54 );

            if ( isdefined( var_1._id_0205 ) )
            {
                if ( var_1._id_0205.type == "Cover Left" )
                {
                    var_5 = 1;
                    var_4 = anglestoright( var_1._id_0205.angles );
                    var_4 = var_4 * -32;
                    var_4 = ( var_4[0], var_4[1], 64 );
                    var_4 = var_1._id_0205.origin + var_4;
                }
                else if ( var_1._id_0205.type == "Cover Right" )
                {
                    var_5 = 1;
                    var_4 = anglestoright( var_1._id_0205.angles );
                    var_4 = var_4 * 32;
                    var_4 = ( var_4[0], var_4[1], 64 );
                    var_4 = var_1._id_0205.origin + var_4;
                }
            }

            scripts\engine\utility::_id_5B21( var_4, var_1._id_8451, var_3 );
        }
    }

    if ( 1 )
        return;

    if ( !isalive( var_1 ) )
        return;

    if ( isalive( var_1._id_010C ) )
    {

    }

    if ( isdefined( var_1._id_01B2 ) )
    {

    }

    if ( isalive( var_1._id_8450 ) )
    {

    }

    if ( !var_1 scripts\anim\utility::_id_8BED() )
        return;

    var_6 = var_1 scripts\anim\utility::_id_7E90();

    if ( isdefined( var_1._id_8451 ) )
        return;
}

_id_5B76( var_0 )
{

}

_id_5B88( var_0, var_1, var_2 )
{
    if ( isdefined( self._id_01F1 ) && _id_0B91::_id_8C32( self._id_01F1, var_0 ) )
    {
        var_3 = self gettagorigin( var_0 );
        var_4 = self gettagangles( var_0 );
        _id_5B6D( var_3, var_4, var_1, var_2 );
    }
}

_id_5B6D( var_0, var_1, var_2, var_3 )
{
    var_4 = 10;
    var_5 = anglestoforward( var_1 );
    var_6 = var_5 * var_4;
    var_7 = var_5 * ( var_4 * 0.8 );
    var_8 = anglestoright( var_1 );
    var_9 = var_8 * ( var_4 * -0.2 );
    var_10 = var_8 * ( var_4 * 0.2 );
    var_11 = anglestoup( var_1 );
    var_8 = var_8 * var_4;
    var_11 = var_11 * var_4;
    var_12 = ( 0.9, 0.2, 0.2 );
    var_13 = ( 0.2, 0.9, 0.2 );
    var_14 = ( 0.2, 0.2, 0.9 );

    if ( isdefined( var_2 ) )
    {
        var_12 = var_2;
        var_13 = var_2;
        var_14 = var_2;
    }

    if ( !isdefined( var_3 ) )
        var_3 = 1;
}

_id_5B89( var_0, var_1 )
{
    for (;;)
    {
        if ( !isdefined( self ) )
            return;

        _id_5B88( var_0, var_1 );
        wait 0.05;
    }
}

_id_5B1D( var_0, var_1 )
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( self ) )
            break;

        if ( !isdefined( self.origin ) )
            break;

        _id_5B88( var_0, var_1 );
        wait 0.05;
    }
}

_id_133A3( var_0, var_1 )
{
    if ( var_0 == "ai" )
    {
        var_2 = _func_072();

        for ( var_3 = 0; var_3 < var_2.size; var_3++ )
            var_2[var_3] _id_5B88( var_1 );
    }
}

_id_4EC1()
{
    level.player._id_0184 = 1;
    var_0 = getallnodes();
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_0[var_2].type == "Cover Left" )
            var_1[var_1.size] = var_0[var_2];

        if ( var_0[var_2].type == "Cover Right" )
            var_1[var_1.size] = var_0[var_2];
    }

    var_3 = _func_072();

    for ( var_2 = 0; var_2 < var_3.size; var_2++ )
        var_3[var_2] delete();

    level._id_4F54 = _func_0C8();
    level._id_1658 = [];
    level._id_4484 = [];

    for ( var_2 = 0; var_2 < level._id_4F54.size; var_2++ )
        level._id_4F54[var_2]._id_0336 = "blah";

    var_4 = 0;

    for ( var_2 = 0; var_2 < 30; var_2++ )
    {
        if ( var_2 >= var_1.size )
            break;

        var_1[var_2] thread _id_474E();
        var_4++;
    }

    if ( var_1.size <= 30 )
        return;

    for (;;)
    {
        level waittill( "debug_next_corner" );

        if ( var_4 >= var_1.size )
            var_4 = 0;

        var_1[var_4] thread _id_474E();
        var_4++;
    }
}

_id_474E()
{
    _id_4747();
}

_id_4747()
{
    var_0 = undefined;
    var_1 = undefined;

    for (;;)
    {
        for ( var_2 = 0; var_2 < level._id_4F54.size; var_2++ )
        {
            wait 0.05;
            var_1 = level._id_4F54[var_2];
            var_3 = 0;

            for ( var_4 = 0; var_4 < level._id_1658.size; var_4++ )
            {
                if ( distance( level._id_1658[var_4].origin, self.origin ) > 250 )
                    continue;

                var_3 = 1;
                break;
            }

            if ( var_3 )
                continue;

            var_5 = 0;

            for ( var_4 = 0; var_4 < level._id_4484.size; var_4++ )
            {
                if ( level._id_4484[var_4] != self )
                    continue;

                var_5 = 1;
                break;
            }

            if ( var_5 )
                continue;

            level._id_1658[level._id_1658.size] = self;
            var_1.origin = self.origin;
            var_1.angles = self.angles;
            var_1._id_00C1 = 1;
            var_0 = var_1 _meth_8393();

            if ( _id_0B91::_id_106ED( var_0 ) )
            {
                _id_E0C0( self );
                continue;
            }

            break;
        }

        if ( isalive( var_0 ) )
            break;
    }

    wait 1;

    if ( isalive( var_0 ) )
    {
        var_0._id_0184 = 1;
        var_0.team = "neutral";
        var_0 _meth_82EF( var_0.origin );
        thread _id_49E3( self.origin );
        var_0 thread _id_0B91::_id_4F4B();
        thread _id_49E4( var_0 );
        var_0 waittill( "death" );
    }

    _id_E0C0( self );
    level._id_4484[level._id_4484.size] = self;
}

_id_E0C0( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < level._id_1658.size; var_2++ )
    {
        if ( level._id_1658[var_2] == var_0 )
            continue;

        var_1[var_1.size] = level._id_1658[var_2];
    }

    level._id_1658 = var_1;
}

_id_49E3( var_0 )
{
    for (;;)
        wait 0.05;
}

_id_49E4( var_0 )
{
    var_1 = undefined;

    while ( isalive( var_0 ) )
    {
        var_1 = var_0.origin;
        wait 0.05;
    }

    for (;;)
        wait 0.05;
}

_id_4F49()
{
    self notify( "stopdebugmisstime" );
    self endon( "stopdebugmisstime" );
    self endon( "death" );

    for (;;)
    {
        if ( self._id_1491._id_B8D6 <= 0 )
        {

        }
        else
        {

        }

        wait 0.05;
    }
}

_id_4F4A()
{
    self notify( "stopdebugmisstime" );
}

_id_4F46( var_0 )
{

}

_id_4F41()
{

}

_id_E02E()
{

}

_id_48F2()
{

}

_id_CD1E()
{

}

_id_4EDC()
{

}

_id_4EDD()
{

}

_id_1011D()
{
    var_0 = undefined;
    var_1 = undefined;
    var_0 = ( 15.1859, -12.2822, 4.071 );
    var_1 = ( 947.2, -10918, 64.9514 );

    for (;;)
    {
        wait 0.05;
        var_2 = var_0;
        var_3 = var_1;

        if ( !isdefined( var_0 ) )
            var_2 = level._id_11A8E;

        if ( !isdefined( var_1 ) )
            var_3 = level.player geteye();

        var_4 = bullettrace( var_2, var_3, 0, undefined );
    }
}

_id_4EBB()
{
    var_0 = newhudelem();
    var_0._id_002B = "left";
    var_0._id_002C = "middle";
    var_0.x = 10;
    var_0.y = 100;
    var_0._id_01AD = &"DEBUG_DRONES";
    var_0.alpha = 0;
    var_1 = newhudelem();
    var_1._id_002B = "left";
    var_1._id_002C = "middle";
    var_1.x = 10;
    var_1.y = 115;
    var_1._id_01AD = &"DEBUG_ALLIES";
    var_1.alpha = 0;
    var_2 = newhudelem();
    var_2._id_002B = "left";
    var_2._id_002C = "middle";
    var_2.x = 10;
    var_2.y = 130;
    var_2._id_01AD = &"DEBUG_AXIS";
    var_2.alpha = 0;
    var_3 = newhudelem();
    var_3._id_002B = "left";
    var_3._id_002C = "middle";
    var_3.x = 10;
    var_3.y = 145;
    var_3._id_01AD = &"DEBUG_VEHICLES";
    var_3.alpha = 0;
    var_4 = newhudelem();
    var_4._id_002B = "left";
    var_4._id_002C = "middle";
    var_4.x = 10;
    var_4.y = 160;
    var_4._id_01AD = &"DEBUG_TOTAL";
    var_4.alpha = 0;
    var_5 = "off";

    for (;;)
    {
        var_6 = getdvar( "debug_character_count" );

        if ( var_6 == "off" )
        {
            if ( var_6 != var_5 )
            {
                var_0.alpha = 0;
                var_1.alpha = 0;
                var_2.alpha = 0;
                var_3.alpha = 0;
                var_4.alpha = 0;
                var_5 = var_6;
            }

            wait 0.25;
            continue;
        }
        else if ( var_6 != var_5 )
        {
            var_0.alpha = 1;
            var_1.alpha = 1;
            var_2.alpha = 1;
            var_3.alpha = 1;
            var_4.alpha = 1;
            var_5 = var_6;
        }

        var_7 = getentarray( "drone", "targetname" ).size;
        var_0 setvalue( var_7 );
        var_8 = _func_072( "allies" ).size;
        var_1 setvalue( var_8 );
        var_9 = _func_072( "bad_guys" ).size;
        var_2 setvalue( var_9 );
        var_3 setvalue( getentarray( "script_vehicle", "classname" ).size );
        var_4 setvalue( var_7 + var_8 + var_9 );
        wait 0.25;
    }
}

_id_C1A6()
{
    if ( !self._id_00E0 )
    {
        if ( isdefined( self._id_12BA4 ) && self._id_12BA4 == "c12" )
            self _meth_81D0( ( 0, 0, -500 ), level.player );
        else
            self _meth_81D0( ( 0, 0, -500 ), level.player, level.player );
    }
}

_id_4EFD()
{

}

_id_37A5()
{
    wait 0.05;
    var_0 = getentarray( "camera", "targetname" );

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        var_2 = getent( var_0[var_1]._id_0334, "targetname" );
        var_0[var_1]._id_C712 = var_2.origin;
        var_0[var_1].angles = vectortoangles( var_2.origin - var_0[var_1].origin );
    }

    for (;;)
    {
        var_3 = _func_072( "axis" );

        if ( !var_3.size )
        {
            _id_7370();
            wait 0.5;
            continue;
        }

        var_4 = [];

        for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        {
            for ( var_5 = 0; var_5 < var_3.size; var_5++ )
            {
                if ( distance( var_0[var_1].origin, var_3[var_5].origin ) > 256 )
                    continue;

                var_4[var_4.size] = var_0[var_1];
                break;
            }
        }

        if ( !var_4.size )
        {
            _id_7370();
            wait 0.5;
            continue;
        }

        var_6 = [];

        for ( var_1 = 0; var_1 < var_4.size; var_1++ )
        {
            var_7 = var_4[var_1];
            var_8 = var_7._id_C712;
            var_9 = var_7.origin;
            var_10 = vectortoangles( ( var_9[0], var_9[1], var_9[2] ) - ( var_8[0], var_8[1], var_8[2] ) );
            var_11 = ( 0, var_10[1], 0 );
            var_12 = anglestoforward( var_11 );
            var_10 = vectornormalize( var_9 - level.player.origin );
            var_13 = vectordot( var_12, var_10 );

            if ( var_13 < 0.85 )
                continue;

            var_6[var_6.size] = var_7;
        }

        if ( !var_6.size )
        {
            _id_7370();
            wait 0.5;
            continue;
        }

        var_14 = distance( level.player.origin, var_6[0].origin );
        var_15 = var_6[0];

        for ( var_1 = 1; var_1 < var_6.size; var_1++ )
        {
            var_16 = distance( level.player.origin, var_6[var_1].origin );

            if ( var_16 > var_14 )
                continue;

            var_15 = var_6[var_1];
            var_14 = var_16;
        }

        _id_F7FD( var_15 );
        wait 3;
    }
}

_id_7370()
{
    setdvar( "cl_freemove", "0" );
}

_id_F7FD( var_0 )
{
    setdvar( "cl_freemove", "2" );
}

_id_4E6B()
{
    waittillframeend;

    for ( var_0 = 0; var_0 < 50; var_0++ )
    {
        if ( !isdefined( level._id_4E6A[var_0] ) )
            continue;

        var_1 = level._id_4E6A[var_0];

        for ( var_2 = 0; var_2 < var_1.size; var_2++ )
        {
            var_3 = var_1[var_2];

            if ( isdefined( var_3._id_12844 ) )
                continue;
        }
    }
}

_id_A9EF()
{

}

_id_13ACF()
{
    for (;;)
    {
        _id_12ED1();
        wait 0.25;
    }
}

_id_12ED1()
{
    var_0 = getdvarfloat( "scr_requiredMapAspectRatio", 1 );

    if ( !isdefined( level._id_B7AF ) )
    {
        setdvar( "scr_minimap_corner_targetname", "minimap_corner" );
        level._id_B7AF = "minimap_corner";
    }

    if ( !isdefined( level._id_B7B1 ) )
    {
        setdvar( "scr_minimap_height", "0" );
        level._id_B7B1 = 0;
    }

    var_1 = getdvarfloat( "scr_minimap_height" );
    var_2 = getdvar( "scr_minimap_corner_targetname" );

    if ( var_1 != level._id_B7B1 || var_2 != level._id_B7AF )
    {
        if ( isdefined( level._id_B7B2 ) )
        {
            level._id_B7B3 unlink();
            level._id_B7B2 delete();
            level notify( "end_draw_map_bounds" );
        }

        if ( var_1 > 0 )
        {
            level._id_B7B1 = var_1;
            level._id_B7AF = var_2;
            var_3 = level.player;
            var_4 = getentarray( var_2, "targetname" );

            if ( var_4.size == 2 )
            {
                var_5 = var_4[0].origin + var_4[1].origin;
                var_5 = ( var_5[0] * 0.5, var_5[1] * 0.5, var_5[2] * 0.5 );
                var_6 = ( var_4[0].origin[0], var_4[0].origin[1], var_5[2] );
                var_7 = ( var_4[0].origin[0], var_4[0].origin[1], var_5[2] );

                if ( var_4[1].origin[0] > var_4[0].origin[0] )
                    var_6 = ( var_4[1].origin[0], var_6[1], var_6[2] );
                else
                    var_7 = ( var_4[1].origin[0], var_7[1], var_7[2] );

                if ( var_4[1].origin[1] > var_4[0].origin[1] )
                    var_6 = ( var_6[0], var_4[1].origin[1], var_6[2] );
                else
                    var_7 = ( var_7[0], var_4[1].origin[1], var_7[2] );

                var_8 = var_6 - var_5;
                var_5 = ( var_5[0], var_5[1], var_5[2] + var_1 );
                var_9 = spawn( "script_origin", var_3.origin );
                var_10 = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
                var_11 = ( var_10[1], 0 - var_10[0], 0 );
                var_12 = vectordot( var_10, var_8 );

                if ( var_12 < 0 )
                    var_12 = 0 - var_12;

                var_13 = vectordot( var_11, var_8 );

                if ( var_13 < 0 )
                    var_13 = 0 - var_13;

                if ( var_0 > 0 )
                {
                    var_14 = var_13 / var_12;

                    if ( var_14 < var_0 )
                    {
                        var_15 = var_0 / var_14;
                        var_13 = var_13 * var_15;
                        var_16 = _id_13193( var_11, vectordot( var_11, var_6 - var_5 ) * ( var_15 - 1 ) );
                        var_7 = var_7 - var_16;
                        var_6 = var_6 + var_16;
                    }
                    else
                    {
                        var_15 = var_14 / var_0;
                        var_12 = var_12 * var_15;
                        var_16 = _id_13193( var_10, vectordot( var_10, var_6 - var_5 ) * ( var_15 - 1 ) );
                        var_7 = var_7 - var_16;
                        var_6 = var_6 + var_16;
                    }
                }

                if ( level._id_4542 )
                {
                    var_17 = 1.77778;
                    var_18 = 2 * _func_014( var_13 * 0.8 / var_1 );
                    var_19 = 2 * _func_014( var_12 * var_17 * 0.8 / var_1 );
                }
                else
                {
                    var_17 = 1.33333;
                    var_18 = 2 * _func_014( var_13 * 1.05 / var_1 );
                    var_19 = 2 * _func_014( var_12 * var_17 * 1.05 / var_1 );
                }

                if ( var_18 > var_19 )
                    var_20 = var_18;
                else
                    var_20 = var_19;

                var_21 = var_1 - 1000;

                if ( var_21 < 16 )
                    var_21 = 16;

                if ( var_21 > 10000 )
                    var_21 = 10000;

                var_3 _meth_823B( var_9 );
                var_9.origin = var_5 + ( 0, 0, -62 );
                var_9.angles = ( 90, getnorthyaw(), 0 );
                var_3 giveweapon( "defaultweapon" );
                _func_1C5( "cg_fov", var_20 );
                level._id_B7B3 = var_3;
                level._id_B7B2 = var_9;
                thread _id_5B7E( var_5, var_7, var_6 );
            }
            else
            {

            }
        }
    }
}

_id_7E1F()
{
    var_0 = [];
    var_0 = getentarray( "minimap_line", "script_noteworthy" );
    var_1 = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
        var_1[var_2] = var_0[var_2] _id_7E1E();

    return var_1;
}

_id_7E1E()
{
    var_0 = [];
    var_1 = self;

    while ( isdefined( var_1 ) )
    {
        var_0[var_0.size] = var_1;

        if ( !isdefined( var_1 ) || !isdefined( var_1._id_0334 ) )
            break;

        var_1 = getent( var_1._id_0334, "targetname" );

        if ( isdefined( var_1 ) && var_1 == var_0[0] )
        {
            var_0[var_0.size] = var_1;
            break;
        }
    }

    var_2 = [];

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
        var_2[var_3] = var_0[var_3].origin;

    return var_2;
}

_id_13193( var_0, var_1 )
{
    return ( var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1 );
}

_id_5B7E( var_0, var_1, var_2 )
{
    level notify( "end_draw_map_bounds" );
    level endon( "end_draw_map_bounds" );
    var_3 = var_0[2] - var_2[2];
    var_4 = length( var_1 - var_2 );
    var_5 = var_1 - var_0;
    var_5 = vectornormalize( ( var_5[0], var_5[1], 0 ) );
    var_1 = var_1 + _id_13193( var_5, var_4 * 1 / 800 * 0 );
    var_6 = var_2 - var_0;
    var_6 = vectornormalize( ( var_6[0], var_6[1], 0 ) );
    var_2 = var_2 + _id_13193( var_6, var_4 * 1 / 800 * 0 );
    var_7 = ( cos( getnorthyaw() ), sin( getnorthyaw() ), 0 );
    var_8 = var_2 - var_1;
    var_9 = _id_13193( var_7, vectordot( var_8, var_7 ) );
    var_10 = _id_13193( var_7, abs( vectordot( var_8, var_7 ) ) );
    var_11 = var_1;
    var_12 = var_1 + var_9;
    var_13 = var_2;
    var_14 = var_2 - var_9;
    var_15 = _id_13193( var_1 + var_2, 0.5 ) + _id_13193( var_10, 0.51 );
    var_16 = var_4 * 0.003;
    var_17 = _id_7E1F();

    for (;;)
    {
        scripts\engine\utility::_id_22A1( var_17, scripts\engine\utility::_id_D5DA );
        wait 0.05;
    }
}

_id_4EC0()
{
    wait 0.05;
    var_0 = _func_072();
    var_1 = [];
    var_1["axis"] = [];
    var_1["allies"] = [];
    var_1["neutral"] = [];

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        var_3 = var_0[var_2];

        if ( !isdefined( var_3._id_4BDF ) )
            continue;

        var_1[var_3.team][var_3._id_4BDF] = 1;
        var_4 = ( 1, 1, 1 );

        if ( isdefined( var_3._id_EDAD ) )
            var_4 = level._id_4391[var_3._id_EDAD];

        if ( var_3.team == "axis" )
            continue;

        var_3 _id_12879();
    }

    _id_5B2E( var_1, "allies" );
    _id_5B2E( var_1, "axis" );
}

_id_5B2E( var_0, var_1 )
{
    var_2 = getarraykeys( var_0[var_1] );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = ( 1, 1, 1 );
        var_4 = level._id_4391[getsubstr( var_2[var_3], 0, 1 )];

        if ( isdefined( level._id_43AD[var_1][var_2[var_3]] ) )
        {
            var_5 = level._id_43AD[var_1][var_2[var_3]];

            for ( var_6 = 0; var_6 < var_5.size; var_6++ )
            {

            }
        }
    }
}

_id_7CE8()
{
    if ( self.team == "allies" )
    {
        if ( !isdefined( self._id_0205._id_ED33 ) )
            return;

        return self._id_0205._id_ED33;
    }

    if ( self.team == "axis" )
    {
        if ( !isdefined( self._id_0205._id_ED34 ) )
            return;

        return self._id_0205._id_ED34;
    }
}

_id_12879()
{
    if ( !isdefined( self._id_0205 ) )
        return;

    if ( !isdefined( self._id_EDAD ) )
        return;

    var_0 = _id_7CE8();

    if ( !isdefined( var_0 ) )
        return;

    if ( !issubstr( var_0, self._id_EDAD ) )
        return;
}

_id_4F55()
{
    level._id_A91E = gettime();
    thread _id_4F56();
}

_id_4F56()
{

}

_id_56E2( var_0, var_1 )
{
    if ( self.team == var_0.team )
        return;

    var_2 = 0;
    var_2 = var_2 + self._id_033F;
    var_3 = 0;
    var_3 = var_3 + var_0._id_033F;
    var_4 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_4 = self _meth_8163();

        if ( isdefined( var_4 ) )
        {
            var_3 = var_3 + getthreatbias( var_1, var_4 );
            var_2 = var_2 + getthreatbias( var_4, var_1 );
        }
    }

    if ( var_0._id_0184 || var_3 < -900000 )
        var_3 = "Ignore";

    if ( self._id_0184 || var_2 < -900000 )
        var_2 = "Ignore";

    var_5 = 20;
    var_6 = ( 1, 0.5, 0.2 );
    var_7 = ( 0.2, 0.5, 1 );
    var_8 = !isplayer( self ) && self._id_0223;

    for ( var_9 = 0; var_9 <= var_5; var_9++ )
    {
        if ( isdefined( var_1 ) )
        {

        }

        if ( isdefined( var_4 ) )
        {

        }

        if ( var_8 )
        {

        }

        wait 0.05;
    }
}

_id_4F3B()
{
    level._id_4EBE = [];
    level._id_4EBF = [];

    for (;;)
    {
        level waittill( "updated_color_friendlies" );
        _id_5B2C();
    }
}

_id_7C31()
{
    var_0 = [];
    var_0["r"] = ( 1, 0, 0 );
    var_0["o"] = ( 1, 0.5, 0 );
    var_0["y"] = ( 1, 1, 0 );
    var_0["g"] = ( 0, 1, 0 );
    var_0["c"] = ( 0, 1, 1 );
    var_0["b"] = ( 0, 0, 1 );
    var_0["p"] = ( 1, 0, 1 );
    return var_0;
}

_id_5B2C()
{
    level endon( "updated_color_friendlies" );
    var_0 = getarraykeys( level._id_4EBE );
    var_1 = [];
    var_2 = [];
    var_2[var_2.size] = "r";
    var_2[var_2.size] = "o";
    var_2[var_2.size] = "y";
    var_2[var_2.size] = "g";
    var_2[var_2.size] = "c";
    var_2[var_2.size] = "b";
    var_2[var_2.size] = "p";
    var_3 = _id_7C31();

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
        var_1[var_2[var_4]] = 0;

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        var_5 = level._id_4EBE[var_0[var_4]];
        var_1[var_5]++;
    }

    for ( var_4 = 0; var_4 < level._id_4EBF.size; var_4++ )
        level._id_4EBF[var_4] destroy();

    level._id_4EBF = [];
    var_6 = 15;
    var_7 = 365;
    var_8 = 25;
    var_9 = 25;

    for ( var_4 = 0; var_4 < var_2.size; var_4++ )
    {
        if ( var_1[var_2[var_4]] <= 0 )
            continue;

        for ( var_10 = 0; var_10 < var_1[var_2[var_4]]; var_10++ )
        {
            var_11 = newhudelem();
            var_11.x = var_6 + 25 * var_10;
            var_11.y = var_7;
            var_11 setshader( "white", 16, 16 );
            var_11._id_002B = "left";
            var_11._id_002C = "bottom";
            var_11.alpha = 1;
            var_11._id_00B9 = var_3[var_2[var_4]];
            level._id_4EBF[level._id_4EBF.size] = var_11;
        }

        var_7 = var_7 + var_9;
    }
}

_id_77F0( var_0 )
{
    if ( !isdefined( level._id_1FD4[var_0._id_1FBB] ) )
        return;

    if ( !isdefined( level._id_1FD4[var_0._id_1FBB][var_0._id_1FAF] ) )
        return;

    if ( !isdefined( level._id_1FD4[var_0._id_1FBB][var_0._id_1FAF][var_0._id_C0C2] ) )
        return;

    return level._id_1FD4[var_0._id_1FBB][var_0._id_1FAF][var_0._id_C0C2]["soundalias"];
}

_id_9BEC( var_0, var_1, var_2 )
{
    return isdefined( level._id_1FD4[var_0][var_1][var_2]["created_by_animSound"] );
}

_id_4EA9( var_0 )
{

}

_id_4EAA()
{

}

_id_113E6( var_0, var_1 )
{
    if ( !isdefined( level._id_1FDA ) )
        return;

    if ( !isdefined( level._id_1FDA._id_1FDC[var_1] ) )
        return;

    var_2 = level._id_1FDA._id_1FDC[var_1];
    var_3 = _id_77F0( var_2 );

    if ( !isdefined( var_3 ) || _id_9BEC( var_2._id_1FBB, var_2._id_1FAF, var_2._id_C0C2 ) )
    {
        level._id_1FD4[var_2._id_1FBB][var_2._id_1FAF][var_2._id_C0C2]["soundalias"] = var_0;
        level._id_1FD4[var_2._id_1FBB][var_2._id_1FAF][var_2._id_C0C2]["created_by_animSound"] = 1;
    }
}

_id_6C96( var_0 )
{

}

_id_3D44( var_0 )
{
    if ( !isdefined( level._id_3D30 ) )
        level._id_3D30 = -1;

    if ( level._id_3D30 == var_0 )
        return;

    _id_6C96( var_0 );

    if ( !isdefined( level._id_3D31 ) )
        return;

    level._id_3D30 = var_0;

    if ( !isdefined( level._id_3D2F ) )
        level._id_3D2F = level._id_3D31 scripts\engine\utility::_id_107E6();

    thread _id_3D45( level._id_3D31 );
}

_id_3D45( var_0 )
{
    level notify( "new_chasecam" );
    level endon( "new_chasecam" );
    var_0 endon( "death" );
    level.player unlink();
    level.player _meth_823C( level._id_3D2F, "tag_origin", 2, 0.5, 0.5 );
    wait 2;
    level.player _meth_823D( level._id_3D2F, "tag_origin", 1, 180, 180, 180, 180 );

    for (;;)
    {
        wait 0.2;

        if ( !isdefined( level._id_3D31 ) )
            return;

        var_1 = level._id_3D31.origin;
        var_2 = level._id_3D31.angles;
        var_3 = anglestoforward( var_2 );
        var_3 = var_3 * 200;
        var_1 = var_1 + var_3;
        var_2 = level.player getplayerangles();
        var_3 = anglestoforward( var_2 );
        var_3 = var_3 * -200;
        level._id_3D2F moveto( var_1 + var_3, 0.2 );
    }
}

_id_13399()
{
    foreach ( var_1 in level.createfxent )
    {
        if ( isdefined( var_1._id_B051 ) )
        {

        }
    }
}

_id_1705( var_0, var_1 )
{

}

_id_D908( var_0 )
{
    if ( !isdefined( level._id_134AD ) )
        level._id_134AD = 9500;

    level._id_134AD++;
    var_1 = "bridge_helpers";
    _id_1705( "origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2] );
    _id_1705( "angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2] );
    _id_1705( "targetname", "helper_model" );
    _id_1705( "model", self._id_01F1 );
    _id_1705( "classname", "script_model" );
    _id_1705( "spawnflags", "4" );
    _id_1705( "_color", "0.443137 0.443137 1.000000" );

    if ( isdefined( var_0 ) )
        _id_1705( "script_noteworthy", var_0 );
}

_id_5B3B( var_0 )
{

}

_id_5B3C()
{
    var_0 = level.player getplayerangles();
    var_1 = anglestoforward( var_0 );
    var_2 = level.player geteye();
    var_3 = self geteye();
    var_4 = vectortoangles( var_3 - var_2 );
    var_5 = anglestoforward( var_4 );
    var_6 = vectordot( var_5, var_1 );
}

_id_13C26()
{
    setdvarifuninitialized( "weaponlist", "0" );

    if ( !getdvarint( "weaponlist" ) )
        return;

    var_0 = getentarray();
    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3.code_classname ) )
            continue;

        if ( issubstr( var_3.code_classname, "weapon" ) )
            var_1[var_3.classname] = 1;
    }

    foreach ( var_7, var_6 in var_1 )
    {

    }

    var_8 = _func_0C8();
    var_9 = [];

    foreach ( var_11 in var_8 )
        var_9[var_11.code_classname] = 1;

    foreach ( var_14, var_6 in var_9 )
    {

    }
}

_id_B514()
{
    thread _id_4EC2();
    setdvar( "debug_measure", 2 );
    var_0 = [];
    var_1 = 0;

    while ( getdvarint( "debug_measure" ) )
    {
        if ( level.player usebuttonpressed() && gettime() > var_1 )
        {
            if ( var_0.size == 2 )
                var_0 = [];
            else
            {
                var_2 = level._id_4EA1._id_4C23;
                var_0[var_0.size] = var_2;
            }

            var_1 = gettime() + 500;
        }

        foreach ( var_7, var_2 in var_0 )
        {
            _id_5B38( var_2 );

            if ( var_7 > 0 )
            {
                var_4 = distance( var_2, var_0[var_7 - 1] );
                var_5 = vectornormalize( var_0[var_7 - 1] - var_2 );
                var_6 = var_2 + var_5 * var_4 * 0.5;
            }
        }

        if ( var_0.size == 2 )
        {
            var_8 = ( 1, 0, 0 );
            var_8 = ( 0, 1, 0 );
            var_8 = ( 0.2, 0.2, 1 );
            var_9 = var_0;

            if ( var_0[1][2] > var_9[0][2] )
                var_9 = [ var_0[1], var_0[0] ];

            var_10 = var_9[0];
            var_11 = ( var_10[0], var_10[1], var_9[1][2] );
            var_4 = distance( var_10, var_11 );
            var_5 = vectornormalize( var_11 - var_10 );
            var_12 = var_10 + var_5 * var_4 * 0.6;
        }

        wait 0.05;
    }

    level notify( "stop_debug_cursor" );
}

_id_4EC2()
{
    level._id_4EA1._id_4C23 = ( 0, 0, 0 );
    level notify( "stop_debug_cursor" );
    level endon( "stop_debug_cursor" );

    for (;;)
    {
        var_0 = level.player geteye();
        var_1 = anglestoforward( level.player getplayerangles() );
        var_2 = var_0 + var_1 * 10000;
        var_3 = bullettrace( var_0, var_2, 0 );
        level._id_4EA1._id_4C23 = var_3["position"];
        _id_5B38( level._id_4EA1._id_4C23 );
        wait 0.05;
    }
}

_id_5B38( var_0 )
{
    level endon( "stop_debug_cursor" );
    var_1 = 4;
    var_2 = ( 1, 1, 1 );
    var_3 = 1;
    var_4 = 1;
}

_id_5B54( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isdefined( var_3 ) )
        var_3 = 32;

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_6 = anglestoup( var_1 );
    var_7 = anglestoforward( var_1 );
    var_8 = var_0 + var_6 * var_3 * 0.5;
    var_9 = var_8 + var_7 * var_3;
    _id_5B5D( var_8, var_9, var_2, var_4, var_5 );
    _id_5B24( var_0, var_2, var_1, var_3, var_4, var_5 );
}

_id_5B5D( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 0;

    var_5 = vectortoangles( var_1 - var_0 );
    var_6 = length( var_1 - var_0 );
    var_7 = anglestoforward( var_5 );
    var_8 = var_7 * var_6;
    var_9 = 5;
    var_10 = var_7 * ( var_6 - var_9 );
    var_11 = anglestoright( var_5 );
    var_12 = var_11 * ( var_9 * -1 );
    var_13 = var_11 * var_9;
}

_id_5B24( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 32;

    if ( !isdefined( var_2 ) )
        var_2 = ( 0, 0, 0 );

    if ( !isdefined( var_4 ) )
        var_4 = 1;

    if ( !isdefined( var_5 ) )
        var_5 = 0;

    var_6 = anglestoforward( var_2 );
    var_7 = anglestoright( var_2 );
    var_8 = anglestoup( var_2 );
    var_9 = var_0 + var_6 * var_3 * 0.5;
    var_9 = var_9 + var_7 * var_3 * 0.5;
    var_10 = [];
    var_10[var_10.size] = var_9;
    var_10[var_10.size] = var_10[var_10.size - 1] + var_6 * var_3 * -1;
    var_10[var_10.size] = var_10[var_10.size - 1] + var_7 * var_3 * -1;
    var_10[var_10.size] = var_10[var_10.size - 1] + var_6 * var_3;
    var_11 = var_3 * var_8;

    for ( var_12 = 0; var_12 < var_10.size; var_12++ )
    {
        if ( var_12 == var_10.size - 1 )
            continue;
    }
}
