params [
  ["_profiles", [], [[]]],
  ["_handlerSelect", nil],
  ["_handlerEscape", nil],
  ["_headerOverride", nil],
  ["_str_role", "НОВЫЙ ПРОФИЛЬ [ %1 ]", [""]],
  ["_roles", (call ZONT_fnc_getRoles + [[0, "ДРУГОЙ"]]), [[]]]
];

private _newUser = count _profiles == 0;

if (isNil "_headerOverride") then {
  if (_newUser) then {
    [
    "<t size='1' color='#09F009'>Приветствуем тебя, боец!</t><br/>" +
    "<t size='1.2'>Поскольку ты в первый раз зашел на наш сервер, " +
    "убедись, что ты ознакомился с правилами и уставом! <t size='0.8'>[ ссылки кликабельны ]</t><br/>" +
    "<a size='2.9' href='https://discord.gg/nZaGMaFTav'><img image='pic\dis.paa'/></a><br/>" +
    "<a size='1.8' href='https://docs.google.com/document/d/16r7T-iu-q0XcEom3wJscB209_QQhxK3hwyK5Tzgbero/edit'>" +
    "<img image='pic\doc.paa'/><t colorLink='#0788ff' color='#0788ff'> Устав</t></a><br/>" +
    "После этого выбери роль из списка ниже. Если подходящей нет - выбери ""Другой""",
    0.49, 0.52 ]
  } else {
    [
    "Ты зашел с новым ником, либо за другую сторону. Если ты просто его поменял, "+
    "то выбери профиль, для которого применить новый ник/сторону.<br/>" +
    "Иначе, выбери роль, для которой создать новый профиль.<br/>" +
    "Если нужной роли нет в списке, выбери ""Другой""",
    0.28, 0.7 ]
  }
} else {
   _headerOverride
} params ["_synopsis", "_headerH", "_pHeight"];

_headerH = _headerH max 0.1 min 0.65;
_pHeight = _pHeight max 0.4 min 0.7;

private _spaceH   = 0.008 * safezoneH;
private _paddingW = 0.0025 * safezoneW;
private _paddingH = 0.0025 * safezoneH;
private _width    = 0.4 * safezoneW;
private _height   = _pHeight * safezoneH;
private _startY   = safeZoneY + ((safeZoneH - _height) / 2);
private _startX   = safeZoneX + ((safeZoneW -  _width) / 2);

disableSerialization;

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

private _background = _display ctrlCreate ["RscText", -1];
_background ctrlSetPosition [
  _startX-_paddingW, _startY-_paddingH,
  _width+_paddingW*2, _height+_paddingH*2
];
_background ctrlSetBackgroundColor [0,0,0,0.6];
_background ctrlCommit 0;

private _title = _display ctrlCreate ["RscStructuredText", -1];
_title ctrlSetPosition [_startX,_startY,_width,_headerH];
_title ctrlSetBackgroundColor [151/255,42/255,245/255,1];
_title ctrlSetStructuredText parseText ("<t align='center'><t shadow='1' size='2.3' color='#ffffff'>Revenge of the Republic</t><br/>" +
    _synopsis + "<br/><t size='0.6'>Двойной клик по пункту в списке, что бы выбрать его</t></t>");
_title ctrlCommit 0;

private _tv = _display ctrlCreate ["RscTreeSearch", -1];
_tv ctrlSetFont "EtelkaMonospacePro";
_tv ctrlSetFontHeight 0.03;
_tv ctrlSetPosition [_startX, _startY+_headerH+_spaceH, _width, _height-_headerH-_spaceH];
_tv ctrlSetBackgroundColor [0,0,0,0.6];
_tv ctrlCommit 0;

uiNamespace setVariable ["zpr_list", _profiles];
{
  _x params ["_id", "_name", "_side", "_role", "_equip", "_pos"];
  private _c = _tv tvAdd [[], format ["%2 || %1", _name, _side]];
  _tv tvSetData [[_c], "set"];
  _tv tvSetValue [[_c], _forEachIndex];
} forEach _profiles;

{
  _x params ["_id", "_name"];
  private _c = _tv tvAdd [[], format [_str_role, _name]];
  _tv tvSetData [[_c], "new"];
  _tv tvSetValue [[_c], _id];
  _tv tvSetColor [[_c], [255/255,242/255,0/255, 1]];
  _tv tvSetPicture [[_c], "pic\add.paa"];
  _tv tvSetPictureColorSelected [[_c], [1,1,1,1]];
} forEach _roles;


if (isNil "_handlerSelect") then {
  _tv ctrlAddEventHandler ["TreeDblClick", {
    params ["_tv", "_path"];
    private _display = ctrlParent _tv;
    _display closeDisplay 1;

    switch (_tv tvData _path) do {
      case ("new"): { (_tv tvValue _path) spawn ZONT_fnc_newProfile };
      case ("set"): {
        (uiNamespace getVariable ["zpr_list", []]) select (_tv tvValue _path)
          spawn ZONT_fnc_updProfile
      };
      default { "profileErr" call ZONT_fnc_forceExit };
    };
  }];
} else {
  _tv ctrlAddEventHandler ["TreeDblClick", _handlerSelect];
};

if (isNil "_handlerEscape") then {
  _display displayAddEventHandler ["unload", {
    params ["_d", "_ex"];
    if (_ex == 1) exitWith {};

    private _count = (uiNamespace getVariable ["zpr_esc", 0]) + 1;
    if (_count > 5) exitWith {"profileErr" call ZONT_fnc_forceExit};

    hint "Выберите профиль!";
    [uiNamespace getVariable ["zpr_list", []]] spawn ZONT_fnc_profilesGUI;
    uiNamespace setVariable ["zpr_esc", _count];
  }];
} else {
  _display displayAddEventHandler ["unload", _handlerEscape];
};
