/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\3101.gsc
***************************************/

_id_008B(var_0, var_1, var_2) {
  var_0._id_11591[var_1] = var_2 + 0;
  _id_008C(var_0, var_2);
  return var_2 + 7;
}

_id_707F(var_0, var_1, var_2, var_3) {
  while (var_2._id_4B1B < var_2._id_C21E) {
  if (!isdefined(var_3)) {
  switch (var_2._id_4B1B) {
  case 0:
  var_4 = var_0;
  var_3 = _id_0A0D::_id_8C2C(var_4);

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;

  break;
  case 1:
  var_4 = var_0 + 1;
  var_3 = _id_0A0D::_id_6CAB(var_4, scripts\aitypes\bt_util::_id_0076(var_4));

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;

  break;
  case 2:
  var_4 = var_0 + 2;
  var_3 = _id_0A0D::_id_F672(var_4, scripts\aitypes\bt_util::_id_0076(var_4));

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;

  break;
  case 3:
  var_4 = var_0 + 3;
  var_3 = _id_0A0D::_id_F72A(var_4, scripts\aitypes\bt_util::_id_0076(var_4));

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;

  break;
  case 4:
  var_4 = var_0 + 4;
  var_3 = _id_0A0D::_id_F706(var_4, scripts\aitypes\bt_util::_id_0076(var_4));

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;

  break;
  case 5:
  var_4 = var_0 + 5;

  if (!isdefined(var_1._id_D8BE[var_4]))
  _id_0A0D::_id_98E0(var_4);

  var_3 = _id_0A0D::_id_136C0(var_4);

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;
  else
  _id_0A0D::_id_11704(var_4);

  break;
  case 6:
  var_4 = var_0 + 6;
  var_3 = _id_0A0D::_id_F7C9(var_4, scripts\aitypes\bt_util::_id_0076(var_4));

  if (var_3 == anim.running)
  var_1._id_E87F[var_4] = -1;

  break;
  }
  }

  if (var_2._id_4B1B == 0)
  var_3 = scripts\aitypes\bt_util::_id_0087(var_3);

  if (var_3 != anim.success)
  return var_3;

  var_2._id_4B1B++;
  var_3 = undefined;
  }

  return anim.success;
}

_id_710A(var_0, var_1, var_2) {
  var_3 = var_0._id_D8BE[var_1];

  if (isdefined(var_3) && var_3 != -1) {
  if (var_3 == 5)
  _id_0A0D::_id_11704(scripts\aitypes\bt_util::_id_0074(var_1, var_3));
  }

  var_2._id_71D2 = undefined;
}

_id_008C(var_0, var_1) {
  var_0._id_1158E[var_1 + 1] = ::_id_7171;
  var_0._id_1158E[var_1 + 2] = ::_id_7172;
  var_0._id_1158E[var_1 + 3] = ::_id_7173;
  var_0._id_1158E[var_1 + 4] = ::_id_7174;
  var_0._id_1158E[var_1 + 6] = ::_id_7172;
}

_id_7171() {
  var_0 = [];
  var_0[0] = "escape";
  return var_0;
}

_id_7172() {
  var_0 = [];
  var_0[0] = "face motion";
  return var_0;
}

_id_7173() {
  var_0 = [];
  var_0[0] = 2048;
  return var_0;
}

_id_7174() {
  var_0 = [];
  var_0[0] = "shoot_at_will";
  return var_0;
}