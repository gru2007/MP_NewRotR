//ARMA3Alpha function LV_fnc_fullLandVehicle v2.0 - by SPUn / Kaarto Media
//Spawns random vehicle full of units and returns the driver
private ["_hq","_veh","_grp","_roads","_radius","_pos1","_man1","_man","_i","_pos","_side","_vehSpots","_vehicle","_vCrew","_crew","_driver","_classModuleFilters","_cMember","_clean","_menClassesFinal","_menClasses"];
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

_veh = ([_classModuleFilters,[(_side), 1]] call LV_classnames) + ([_classModuleFilters,[(_side), 2]] call LV_classnames);

_veh = [_veh] call LV_validateClassArrays;
if((count _veh) == 0)then{
	_veh = ([[],[(_side), 1]] call LV_classnames) + ([[],[(_side), 2]] call LV_classnames);
};

_veh = selectRandom _veh;
if(typeName _veh == "ARRAY")then{_veh = selectRandom _veh;};

_vehSpots = getNumber (configFile >> "CfgVehicles" >> _veh >> "transportSoldier");

_radius = 40;
_roads = [];
while{(count _roads) == 0}do{
	_roads = _pos nearRoads _radius;
	_radius = _radius + 10;
	sleep 0.001;
};
if(((_roads select 0) distance _pos)<200)then{
	_pos = getPos(_roads select 0);
	_pos1 = [_pos,0,25,8,0,.4,0] call BIS_fnc_findSafePos;
}else{
	_pos1 = [_pos,0,200,8,0,.4,0] call BIS_fnc_findSafePos;
};
_pos = [_pos1 select 0, _pos1 select 1, 0];

sleep 0.5;

_vehicle = createVehicle [_veh, _pos, [], 0, "NONE"];
if(_clean)then{
	_vehicle setVariable ["syncedUnit",_syncedUnit,false];
	_vehicle setVariable ["dissapearDistance",_dissapearDistance,false];
	_vehicle addEventHandler ["killed", {_this execVM "external\LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
};
_vehicle setPos _pos;

_vehicle allowDamage false;
sleep 2;
if(((vectorUp _vehicle) select 2) != 0)then{ _vehicle setvectorup [0,0,0]; };
sleep 2;
_vehicle allowDamage true;

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
		//_man1 = getText (configFile >> "CfgVehicles" >> _veh >> "crew"); //Crewman
		if(typeName _menClasses == "ARRAY")then{_menClassesFinal = selectRandom _menClasses;}else{_menClassesFinal = _menClasses;};
		_man1 = selectRandom _menClassesFinal; //Random infantry class for selected side
		_man = _grp createUnit [_man1, _pos, [], 0, "NONE"];
		_man moveInCargo _vehicle;
		if(_clean)then{
			_man setVariable ["syncedUnit",_syncedUnit,false];
			_man setVariable ["dissapearDistance",_dissapearDistance,false];
			_man addEventHandler ["killed", {_this execVM "external\LV\LV_functions\LV_fnc_ACAIkilled.sqf"}];
		};
		sleep 0.3;
	};
};

_driver = driver _vehicle;
_driver