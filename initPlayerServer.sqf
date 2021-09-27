params ["_player", "_didJIP"];
//private _curators = call ZONT_fnc_retrieveCurators;
zeusmodule = [
   "76561198317961869" // gru2007
];
if not ((getPlayerUID _player) in zeusmodule) exitWith { };
_player call ZONT_fnc_giveZeus;
