if (!hasInterface) exitWith {};

if (isNil {player}) exitWith {diag_log "ZONT_PRS: PLAYER IS NIL"; []};
private _uid = getPlayerUID player;
private _name = name player
if (!("7656" in _uid)) exitWith {diag_log "ZONT_PRS: UID IS INVALID"; []};

waitUntil {sleep 0.1; !dialog};

[{
  params ["_uid","_name"];
  [MPS_BDL_pres, "getChars", [_uid]] call ZONT_fnc_bd_customRequest;
  [MPS_BDL_pres, "updName", [_name, _uid]] call ZONT_fnc_bd_customRequest;
},{
  ZPR_ID = nil;

  {
    _x params ["_id", "_name", "_side", "_roles", "_equip", "_pos"];
    if (_name == name player and _side == str side player) exitWith {
      ZPR_ID = _id;
      ZPR_roles = _roles;
      [_equip, _pos] spawn ZONT_fnc_loadDone;
    };
  } foreach _this;

  if (not isNil "ZPR_ID") exitWith { };

  [_this] call ZONT_fnc_profilesGUI;

}, _uid] call ZONT_fnc_remoteExecCallback;
