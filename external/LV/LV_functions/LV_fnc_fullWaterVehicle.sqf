//ARMA3Alpha function LV_fnc_fullVehicle v2.0 - by SPUn / Kaarto Media
//Spawns random water vehicle full of units and returns the driver
private ["_hq","_grp","_veh","_man1","_man","_i","_pos","_side","_vehSpots","_vehicle","_vCrew","_crew","_driver","_classModuleFilters","_cMember","_clean","_menClassesFinal","_menClasses"];
_pos = param [0,[0,0,0]];
_side = param [1,0];
_classModuleFilters = param [2,[]];
_syncedUnit = param [3,nil];
_dissapearDistance = param [4,nil];
_clean = param [5,false];

if(isNil("LV_centerInit"))then{LV_centerInit = compileFinal preprocessFile "external\LV\LV_functions\LV_fnc_centerInit.sqf";};
if(isNil("LV_removeClasses"))then{LV_removeClasses = compileFinal preprocessFile "external\LV\LV_functions\LV_fnc_removeClasses.sqf";};

_veh = [];

switch(_side)do{
	case 1:{
		_hq = [1] call LV_centerInit;
		_grp = createGroup west;
	};
	case 2:{
		_hq = [2] call LV_centerInit;
		_grp = createGroup east;
	};
	case 3:{
		_hq = [3] call LV_centerInit;
		_grp = createGroup resistance;
	};
	case 0:{
		_hq = [0] call LV_centerInit;
		_grp = createGroup civilian;
	};
};
_veh = [_classModuleFilters,[(_side), 5]] call LV_classnames;

_veh = [_veh] call LV_validateClassArrays;
if((count _veh) == 0)then{
	_veh = ([[],[(_side), 5]] call LV_classnames);
};
_veh = selectRandom _veh;
if(typeName _veh == "ARRAY")then{_veh = selectRandom _veh;};

_vehSpots = getNumber (configFile >> "CfgVehicles" >> _veh >> "transportSoldier");
_vehicle = createVehicle [_veh, _pos, [], 0, "NONE"];
if(_clean)then{
	_vehicle setVariable ["syncedUnit",_syncedUnit,false];
	_vehicle setVariable ["dissapearDistance",_dissapearDistance,false];
	_vehicle addEventHandler ["killed", {_this execVM "external\LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
};
_vehicle setPos _pos;

_vCrew = [_vehicle, _grp] call BIS_fnc_spawnCrew;
_crew = crew _vehicle;
if(_clean)then{
	for "_i" from 0 to ((count _crew) - 1) do{
		_cMember = _crew select _i;
		_cMember setVariable ["syncedUnit",_syncedUnit,false];
		_cMember setVariable ["dissapearDistance",_dissapearDistance,false];
		_cMember addEventHandler ["killed", {_this execVM "external\LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
		sleep 0.001;
	};
};

if(_vehSpots > 0)then{
	_menClasses = [_classModuleFilters,[(_side), 6]] call LV_classnames;
	_menClasses = [_menClasses] call LV_validateClassArrays;
	if((count _menClasses) == 0)then{
		_menClasses = [[],[(_side), 6]] call LV_classnames;
	};
	_menClasses = [_menClasses,['crew','Crew','pilot','Pilot']] call LV_removeClasses;

	_i = 1;
	for "_i" from 1 to _vehSpots do {
		77_man1 = getText (configFile >> "CfgVehicles" >> _veh >> "crew"); //Crewmen
		if(typeName _menClasses == "ARRAY")then{_menClassesFinal = selectRandom _menClasses;}else{_menClassesFinal = _menClasses;};
		_man1 = selectRandom _menClassesFinal; //Random infantry class for selected side
		_man = _grp createUnit [_man1, _pos, [], 0, "NONE"];
		_man moveInCargo _vehicle;
		if(_clean)then{
			_man setVariable ["syncedUnit",_syncedUnit,false];
			_man setVariable ["dissapearDistance",_dissapearDistance,false];
			_man addEventHandler ["killed", {_this execVM "external\LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
		};
		sleep 0.3 ;
	};
};

_driver = driver _vehicle;
_driver