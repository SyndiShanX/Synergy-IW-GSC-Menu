/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\2606.gsc
***************************************/

_id_F7A1(var_0) {
  self setmodel(var_0[randomint(var_0.size)]);
}

_id_D811(var_0) {
  for (var_1 = 0; var_1 < var_0.size; var_1++)
  precachemodel(var_0[var_1]);
}

_id_2483(var_0, var_1) {
  if (!isdefined(level._id_3CAF))
  level._id_3CAF = [];

  if (!isdefined(level._id_3CAF[var_0]))
  level._id_3CAF[var_0] = randomint(var_1.size);

  var_2 = (level._id_3CAF[var_0] + 1) % var_1.size;

  if (isdefined(self._id_ED2A))
  var_2 = self._id_ED2A % var_1.size;

  level._id_3CAF[var_0] = var_2;
  self attach(var_1[var_2], "", 1);
  self._id_8C98 = var_1[var_2];
}

_id_2482(var_0, var_1) {
  if (!isdefined(level._id_3CAE))
  level._id_3CAE = [];

  if (!isdefined(level._id_3CAE[var_0]))
  level._id_3CAE[var_0] = randomint(var_1.size);

  var_2 = (level._id_3CAE[var_0] + 1) % var_1.size;
  level._id_3CAE[var_0] = var_2;
  self attach(var_1[var_2]);
  self._id_8C43 = var_1[var_2];
}

_id_BEFC() {
  self detachall();
  var_0 = self._id_1ED5;

  if (!isdefined(var_0))
  return;

  self._id_1ED5 = "none";
  self [[anim._id_DB38]](var_0);
}

_id_EB53() {
  var_0["gunHand"] = self._id_1ED5;
  var_0["gunInHand"] = self._id_1ED6;
  var_0["model"] = self._id_01F1;
  var_0["hatModel"] = self._id_8C43;

  if (isdefined(self.name))
  var_0["name"] = self.name;
  else
  {}

  var_1 = self getattachsize();

  for (var_2 = 0; var_2 < var_1; var_2++) {
  var_0["attach"][var_2]["model"] = self getattachmodelname(var_2);
  var_0["attach"][var_2]["tag"] = self getattachtagname(var_2);
  }

  return var_0;
}

_id_ADA6(var_0) {
  self detachall();
  self._id_1ED5 = var_0["gunHand"];
  self._id_1ED6 = var_0["gunInHand"];
  self setmodel(var_0["model"]);
  self._id_8C43 = var_0["hatModel"];

  if (isdefined(var_0["name"]))
  self.name = var_0["name"];
  else
  {}

  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for (var_3 = 0; var_3 < var_2; var_3++)
  self attach(var_1[var_3]["model"], var_1[var_3]["tag"]);
}

_id_0247(var_0) {
  if (isdefined(var_0["name"])) {} else {}

  precachemodel(var_0["model"]);
  var_1 = var_0["attach"];
  var_2 = var_1.size;

  for (var_3 = 0; var_3 < var_2; var_3++)
  precachemodel(var_1[var_3]["model"]);
}

_id_7BE5(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = strtok(self.classname, "_");

  if (!scripts\engine\utility::_id_9F64()) {
  if (isdefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < var_0)
  return self.pers["modelIndex"];

  var_3 = randomint(var_0);
  self.pers["modelIndex"] = var_3;
  return var_3;
  }
  else if (var_4.size <= 2)
  return randomint(var_0);

  var_5 = "auto";

  if (isdefined(self._id_ED2A))
  var_3 = self._id_ED2A;
  else if (isdefined(var_1))
  var_3 = _id_7BF5(var_1);

  if (isdefined(self._id_ED29))
  var_5 = "group_" + self._id_ED29;

  if (!isdefined(level._id_3CB1))
  level._id_3CB1 = [];

  if (!isdefined(level._id_3CB1[var_5]))
  level._id_3CB1[var_5] = [];

  if (!isdefined(var_3)) {
  var_3 = _id_7A7C(var_2, var_5);

  if (!isdefined(var_3))
  var_3 = randomint(var_2.size);
  }

  if (!isdefined(level._id_3CB1[var_5][var_2[var_3]]))
  level._id_3CB1[var_5][var_2[var_3]] = 0;

  level._id_3CB1[var_5][var_2[var_3]]++;
  return var_3;
}

_id_7A7C(var_0, var_1) {
  var_2 = [];
  var_3 = 999999;
  var_2[0] = 0;

  for (var_4 = 0; var_4 < var_0.size; var_4++) {
  if (!isdefined(level._id_3CB1[var_1][var_0[var_4]]))
  level._id_3CB1[var_1][var_0[var_4]] = 0;

  var_5 = level._id_3CB1[var_1][var_0[var_4]];

  if (var_5 > var_3)
  continue;

  if (var_5 < var_3) {
  var_2 = [];
  var_3 = var_5;
  }

  var_2[var_2.size] = var_4;
  }

  return _id_DC6B(var_2);
}

_id_984D(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < var_2; var_3++)
  level._id_3CB1[var_0][var_1][var_3] = 0;
}

_id_7BF3(var_0) {
  return randomint(var_0);
}

_id_DC6B(var_0) {
  return var_0[randomint(var_0.size)];
}

_id_7BF5(var_0) {
  var_1 = randomfloat(1);

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
  if (var_1 < var_0[var_2])
  return var_2;
  }

  return 0;
}