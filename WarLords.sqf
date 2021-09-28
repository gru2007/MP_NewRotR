/////////////////////////////////////////////////////////////////////////////////////////// 
// Init 
params [["_layerWhiteList",[],[[]]],["_layerBlacklist",[],[[]]],["_posCenter",[0,0,0],[[]]],["_dir",0,[0]],["_idBlacklist",[],[[]]]]; 
private _allWhitelisted = _layerWhiteList isEqualTo []; 
private _layerRoot = (_allWhitelisted || {true in _layerWhiteList}) && {!(true in _layerBlackList)}; 
private _layer0 = (_allWhitelisted || {"warlords" in _layerWhiteList}) && {!("warlords" in _layerBlackList)}; 
private _layer2 = (_allWhitelisted || {"warlords init" in _layerWhiteList}) && {!("warlords init" in _layerBlackList)}; 
 
/////////////////////////////////////////////////////////////////////////////////////////// 
// Logics 
private _logics = []; 
private _logicIDs = []; 
 
private _item1 = objNull; 
if (_layer0 && _layer2) then { 
 _item1 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleWLInit_F",[9409.24,243.539,4.76837e-007],[],0,"CAN_COLLIDE"]; 
 _this = _item1; 
 _logics pushback _this; 
 _logicIDs pushback 1; 
 _this setPosWorld [9409.24,243.539,7.3135]; 
 _this setVectorDirAndUp [[0,1,0],[0,0,1]]; 
 _this setVariable ['Progress',1,true];; 
 _this setVariable ['TimeAcceleration',1,true];; 
 _this setVariable ['FTEnabled',4,true];; 
 _this setVariable ['ScanEnabled',1,true];; 
 _this setVariable ['AIVoting',0,true];; 
 _this setVariable ['ArsenalEnabled',0,true];; 
 _this setVariable ['VotingResetEnabled',0,true];; 
 _this setVariable ['TeamBalanceEnabled',0,true];; 
 _this setVariable ['MarkersTransparency',2,true];; 
 _this setVariable ['PlayersTransparency',2,true];; 
 _this setVariable ['FatigueEnabled',1,true];; 
 _this setVariable ['Music',0,true];; 
 _this setVariable ['Voice',1,true];; 
 _this setVariable ['StartCP',500,true];; 
 _this setVariable ['CPMultiplier',1,true];; 
 _this setVariable ['MaxCP',-1,true];; 
 _this setVariable ['VotingTimeout',20,true];; 
 _this setVariable ['VehicleSpan',3600,true];; 
 _this setVariable ['FactionBLUFOR',"",true];; 
 _this setVariable ['FactionOPFOR',"",true];; 
 _this setVariable ['FactionIndep',"",true];; 
 _this setVariable ['AssetList',"['MyWLAssetList']",true];; 
 _this setVariable ['MaxSubordinates',0,true];; 
 _this setVariable ['ScanCooldown',20,true];; 
 _this setVariable ['MissionEnd',0,true];; 
 _this setVariable ['DebriefingWinBLUFOR',"BIS_WLVictoryWEST",true];; 
 _this setVariable ['DebriefingFailBLUFOR',"BIS_WLDefeatWEST",true];; 
 _this setVariable ['DebriefingWinOPFOR',"BIS_WLVictoryEAST",true];; 
 _this setVariable ['DebriefingFailOPFOR',"BIS_WLDefeatEAST",true];; 
 _this setvariable ["BIS_fnc_initModules_disableAutoActivation",true]; 
}; 
 
 
/////////////////////////////////////////////////////////////////////////////////////////// 
// Layers 
if (_layer0) then {missionNamespace setVariable ["l%3fl%3f_WarLords",[[_item1],[]]];}; 
if (_layer2) then {missionNamespace setVariable ["l%3fl%3f_WarLords Init",[[_item1],[]]];}; 

/////////////////////////////////////////////////////////////////////////////////////////// 
// Inits (executed only once all entities exist; isNil used to ensure non-scheduled environment) 
isNil { 
}; 
 
 
/////////////////////////////////////////////////////////////////////////////////////////// 
// Module activations (only once everything is spawned and connected) 
if !(isNull _item1) then {_item1 setvariable ["BIS_fnc_initModules_activate",true];}; 
 
 
/////////////////////////////////////////////////////////////////////////////////////////// 
[[_logics],[_logicIDs]]
