waitUntil {vehicle player == player};

[] spawn ZONT_fnc_loadProfile;
[] spawn ZONT_fnc_autoSaveInit;

[] spawn ZONT_fnc_initSkills;

[] spawn ZONT_fnc_initTeleportTerminals;

[] execVM "chatCommands.sqf";
[] execVM "legacy\intro\introtext.sqf";

/******                            Inf Ammo                             ******/
MagazineBlackList = [
  "SWLW_plx1_at_mag",
  "SWLW_plx1_ap_mag",
  "SWLW_plx1_aa_mag"
];
player addEventHandler ["Reloaded", { 
  if not (((_this select 3) select 0) in MagazineBlackList) then { 
    (_this select 0) addMagazine ((_this select 3) select 0); 
  }; 
}];

/******                            Zeus list                             ******/
MCH_ZEUS_LIST = [{
  if (isnull (finddisplay 312)) exitWith {};
  mpc_cc_name = format ["%1 (%2)", name player, getPlayerUID player];
  if (isNil 'mpv_current_curators') then {mpv_current_curators = []};

  if (!(mpc_cc_name in mpv_current_curators)) then {
      mpv_current_curators pushBack mpc_cc_name;
      publicVariable 'mpv_current_curators';
      (finddisplay 312) displayAddEventHandler ["Unload", {
          mpv_current_curators deleteAt (mpv_current_curators find mpc_cc_name);
          publicVariable 'mpv_current_curators';
          hintSilent "";
      }];
  };
  private _str = "<t color='#00FF00'>Активные зевсы:</t>";
  { _str = format ["%1<br/>%2", _str, _x]; } forEach mpv_current_curators;
  hintSilent parseText _str;
}, 1] call CBA_fnc_addPerFrameHandler;
