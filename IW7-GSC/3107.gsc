/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\3107.gsc
***************************************/

_id_BE5C() {
  if (_id_09FF::_id_0080("jackal/jackal_native_api"))
  return;

  _id_09FF::_id_0084("jackal/jackal_native_api", "Root", "selector", ["AnimScripted", "sequence", "ShouldFollow", "sequence", "ShouldHover", "sequence", "ShouldGotoAndFollowSpline", "sequence", "ShouldEscape", "sequence", "ShouldCombat", "sequence", "ShouldPatrol", "sequence", "jk_doNothing4", "action"]);
  _id_09FF::_id_0085("jackal/jackal_native_api");
  _id_09FF::_id_0082("AnimScripted", "sequence", ["jk_isAnimscripted4", "action", "jk_doNothing4", "action"], 4);
  _id_09FF::_id_0081("jk_isAnimscripted4", _id_0A0D::_id_9D44, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_doNothing4", _id_0A0D::_id_593B, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("ShouldFollow", "sequence", ["jk_shouldFollow4", "action", "Follow", "selector"], 4);
  _id_09FF::_id_0081("jk_shouldFollow4", _id_0A0D::_id_10015, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("Follow", "selector", ["Follow_Imitate", "sequence", "Follow_Approach", "sequence", "Follow_Hover", "sequence", "jk_follow4", "action"], 4);
  _id_09FF::_id_0082("Follow_Imitate", "sequence", ["jk_isFollowing4", "action", "jk_emulateLeader4", "action"], 4);
  _id_09FF::_id_0081("jk_isFollowing4", _id_0A0D::_id_9E00, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_emulateLeader4", _id_0A0D::_id_61C4, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("Follow_Approach", "sequence", ["jk_shouldFollowApproach4", "action", "jk_setFlightMode::fnArgsNative04", "action", "jk_followApproach4", "action"], 4);
  _id_09FF::_id_0081("jk_shouldFollowApproach4", _id_0A0D::_id_10016, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setFlightMode::fnArgsNative04", _id_0A0D::_id_F711, ::_id_7180, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_followApproach4", _id_0A0D::_id_7232, undefined, undefined, _id_0A0D::_id_7234, 4);
  _id_09FF::_id_0082("Follow_Hover", "sequence", ["jk_isLeaderHovering4", "action", "jk_setFlightMode::fnArgsNative14", "action", "jk_follow4", "action"], 4);
  _id_09FF::_id_0081("jk_isLeaderHovering4", _id_0A0D::_id_9E77, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setFlightMode::fnArgsNative14", _id_0A0D::_id_F711, ::_id_7181, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_follow4", _id_0A0D::_id_0137, undefined, _id_0A0D::_id_7221, _id_0A0D::_id_7231, 4);
  _id_09FF::_id_0081("jk_follow4", _id_0A0D::_id_0137, undefined, _id_0A0D::_id_7221, _id_0A0D::_id_7231, 4);
  _id_09FF::_id_0082("ShouldHover", "sequence", ["jk_shouldHover4", "action", "Hover", "selector"], 4);
  _id_09FF::_id_0081("jk_shouldHover4", _id_0A0D::_id_10027, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("Hover", "selector", ["ShouldHoverApproach", "active_sequence", "Hover0", "sequence"], 4);
  _id_09FF::_id_0082("ShouldHoverApproach", "active_sequence", ["jk_shouldHoverApproach4", "action", "HoverApproach", "active_sequence", "jk_clearHoverApproach4", "action"], 4);
  _id_09FF::_id_0081("jk_shouldHoverApproach4", _id_0A0D::_id_10028, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("HoverApproach", "active_sequence", ["jk_shouldSetHoverApproachGoal4", "action", "jk_setHoverApproachGoal4", "action", "jk_waitForGoal4", "action"], 4);
  _id_09FF::_id_0081("jk_shouldSetHoverApproachGoal4", _id_0A0D::_id_10075, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setHoverApproachGoal4", _id_0A0D::_id_F748, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_waitForGoal4", _id_0A0D::_id_136C0, undefined, _id_0A0D::_id_98E0, _id_0A0D::_id_11704, 4);
  _id_09FF::_id_0081("jk_clearHoverApproach4", _id_0A0D::_id_41B6, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("Hover0", "sequence", ["jk_setFlightMode::fnArgsNative14", "action", "jk_setFireMode::fnArgsNative24", "action", "jk_setOrientMode::fnArgsNative34", "action", "HoverAttack", "selector"], 4);
  _id_09FF::_id_0081("jk_setFlightMode::fnArgsNative14", _id_0A0D::_id_F711, ::_id_7181, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setFireMode::fnArgsNative24", _id_0A0D::_id_F706, ::_id_7182, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setOrientMode::fnArgsNative34", _id_0A0D::_id_F7C9, ::_id_7183, undefined, undefined, 4);
  _id_09FF::_id_0082("HoverAttack", "selector", ["HoverReposition", "sequence", "HoverShoot", "sequence"], 4);
  _id_09FF::_id_0082("HoverReposition", "sequence", ["jk_shouldHoverReposition4", "action", "jk_hoverReposition4", "action"], 4);
  _id_09FF::_id_0081("jk_shouldHoverReposition4", _id_0A0D::_id_1002B, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_hoverReposition4", _id_0A0D::_id_90F2, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("HoverShoot", "sequence", ["jk_setFireMode::fnArgsNative24", "action", "jk_setOrientMode::fnArgsNative34", "action", "doWait::fnArgsNative44", "action"], 4);
  _id_09FF::_id_0081("jk_setFireMode::fnArgsNative24", _id_0A0D::_id_F706, ::_id_7182, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setOrientMode::fnArgsNative34", _id_0A0D::_id_F7C9, ::_id_7183, undefined, undefined, 4);
  _id_09FF::_id_0081("doWait::fnArgsNative44", _id_0A09::_id_5AEA, ::_id_7184, _id_0A09::_id_FAF6, undefined, 4);
  _id_09FF::_id_0082("ShouldGotoAndFollowSpline", "sequence", ["jk_hasSpline4", "action", "GotoAndFollowSpline", "selector"], 4);
  _id_09FF::_id_0081("jk_hasSpline4", _id_0A0D::_id_8C2C, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("GotoAndFollowSpline", "selector", ["ShouldFollowSpline", "sequence", "GotoSpline", "sequence"], 4);
  _id_09FF::_id_0082("ShouldFollowSpline", "sequence", ["jk_shouldFollowSpline4", "action", "FollowSpline", "active_selector"], 4);
  _id_09FF::_id_0081("jk_shouldFollowSpline4", _id_0A0D::_id_10017, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("FollowSpline", "active_selector", ["jk_maybeBreakSpline4", "action", "jk_followSpline4", "action"], 4);
  _id_09FF::_id_0081("jk_maybeBreakSpline4", _id_0A0D::_id_B4DB, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_followSpline4", _id_0A0D::_id_7248, undefined, _id_0A0D::_id_724A, _id_0A0D::_id_724B, 4);
  _id_09FF::_id_0082("GotoSpline", "sequence", ["jk_findAndSetGoal::fnArgsNative54", "action", "jk_waitForGoal4", "action"], 4);
  _id_09FF::_id_0081("jk_findAndSetGoal::fnArgsNative54", _id_0A0D::_id_6CAB, ::_id_7185, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_waitForGoal4", _id_0A0D::_id_136C0, undefined, _id_0A0D::_id_98E0, _id_0A0D::_id_11704, 4);
  _id_09FF::_id_0082("ShouldEscape", "sequence", ["jk_isBeingPursued4", "action", "ShouldEscapeescape_native_api_Escape", "sequence"], 4);
  _id_09FF::_id_0081("jk_isBeingPursued4", _id_0A0D::_id_9D6A, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("ShouldCombat", "sequence", ["jk_hasValidTarget4", "action", "Not_jk_hasSpline4", "negate", "Combat", "selector"], 4);
  _id_09FF::_id_0081("jk_hasValidTarget4", _id_0A0D::_id_8C3A, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_hasSpline4", _id_0A0D::_id_8C2C, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("Combat", "selector", ["Attack", "sequence", "PassEnemy", "sequence", "Retreat", "sequence"], 4);
  _id_09FF::_id_0082("Attack", "sequence", ["jk_shouldAttack4", "action", "WhichAttack", "selector"], 4);
  _id_09FF::_id_0081("jk_shouldAttack4", _id_0A0D::_id_FFBE, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("WhichAttack", "selector", ["AttackHover", "sequence", "AttackStrafe", "active_sequence"], 4);
  _id_09FF::_id_0082("AttackHover", "sequence", ["jk_shouldHoverAttack4", "action", "jk_setHoverApproachGoal4", "action", "jk_passEnemy4", "action", "jk_setOrientMode::fnArgsNative34", "action", "jk_setFireMode::fnArgsNative24", "action", "doWait::fnArgsNative64", "action"], 4);
  _id_09FF::_id_0081("jk_shouldHoverAttack4", _id_0A0D::_id_10029, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setHoverApproachGoal4", _id_0A0D::_id_F748, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_passEnemy4", _id_0A0D::_id_C936, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setOrientMode::fnArgsNative34", _id_0A0D::_id_F7C9, ::_id_7183, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setFireMode::fnArgsNative24", _id_0A0D::_id_F706, ::_id_7182, undefined, undefined, 4);
  _id_09FF::_id_0081("doWait::fnArgsNative64", _id_0A09::_id_5AEA, ::_id_7186, _id_0A09::_id_FAF6, undefined, 4);
  _id_09FF::_id_0082("AttackStrafe", "active_sequence", ["jk_shouldContinueAttacking4", "action", "jk_stayAtOptimalDistance4", "action", "jk_findAndSetGoal::fnArgsNative74", "action", "jk_setBoostMode::fnArgsNative84", "action", "jk_setGoalRadius::fnArgsNative94", "action", "jk_setFireMode::fnArgsNative24", "action", "jk_waitForGoal4", "action"], 4);
  _id_09FF::_id_0081("jk_shouldContinueAttacking4", _id_0A0D::_id_FFD6, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_stayAtOptimalDistance4", _id_0A0D::_id_10E66, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_findAndSetGoal::fnArgsNative74", _id_0A0D::_id_6CAB, ::_id_7187, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setBoostMode::fnArgsNative84", _id_0A0D::_id_F672, ::_id_7188, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setGoalRadius::fnArgsNative94", _id_0A0D::_id_F72A, ::_id_7189, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setFireMode::fnArgsNative24", _id_0A0D::_id_F706, ::_id_7182, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_waitForGoal4", _id_0A0D::_id_136C0, undefined, _id_0A0D::_id_98E0, _id_0A0D::_id_11704, 4);
  _id_09FF::_id_0082("PassEnemy", "sequence", ["jk_shouldPass4", "action", "jk_setHoverApproachGoal4", "action", "jk_passEnemy4", "action", "jk_waitForGoal4", "action"], 4);
  _id_09FF::_id_0081("jk_shouldPass4", _id_0A0D::_id_1003E, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_setHoverApproachGoal4", _id_0A0D::_id_F748, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_passEnemy4", _id_0A0D::_id_C936, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_waitForGoal4", _id_0A0D::_id_136C0, undefined, _id_0A0D::_id_98E0, _id_0A0D::_id_11704, 4);
  _id_09FF::_id_0082("Retreat", "sequence", ["jk_shouldRetreat4", "action", "Retreatescape_native_api_Escape", "sequence"], 4);
  _id_09FF::_id_0081("jk_shouldRetreat4", _id_0A0D::_id_1006C, undefined, undefined, undefined, 4);
  _id_09FF::_id_0082("ShouldPatrol", "sequence", ["jk_shouldPatrol4", "action", "ShouldPatrolescape_native_api_Escape", "sequence"], 4);
  _id_09FF::_id_0081("jk_shouldPatrol4", _id_0A0D::_id_1003F, undefined, undefined, undefined, 4);
  _id_09FF::_id_0081("jk_doNothing4", _id_0A0D::_id_593B, undefined, undefined, undefined, 4);
  _id_0C1E::_id_BE5C("ShouldEscape");
  _id_0C1E::_id_BE5C("Retreat");
  _id_0C1E::_id_BE5C("ShouldPatrol");
  _id_09FF::_id_0082("Not_jk_hasSpline4", "negate", ["jk_hasSpline4", "action"], 4);
  _id_09FF::_id_007F();
}

_id_7180() {
  var_0 = [];
  var_0[0] = "fly";
  return var_0;
}

_id_7181() {
  var_0 = [];
  var_0[0] = "hover";
  return var_0;
}

_id_7182() {
  var_0 = [];
  var_0[0] = "shoot_at_will";
  return var_0;
}

_id_7183() {
  var_0 = [];
  var_0[0] = "face enemy";
  return var_0;
}

_id_7184() {
  var_0 = [];
  var_0[0] = 1500;
  return var_0;
}

_id_7185() {
  var_0 = [];
  var_0[0] = "spline";
  return var_0;
}

_id_7186() {
  var_0 = [];
  var_0[0] = 5000;
  return var_0;
}

_id_7187() {
  var_0 = [];
  var_0[0] = "attack";
  return var_0;
}

_id_7188() {
  var_0 = [];
  var_0[0] = "face motion";
  return var_0;
}

_id_7189() {
  var_0 = [];
  var_0[0] = 2048;
  return var_0;
}