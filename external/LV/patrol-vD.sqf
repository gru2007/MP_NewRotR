///////Simple Patrol script vD 2.0 - SPUn / Kaarto Media
//
//*infantry units patrols independently around starting position in defined radius and also checks randomly buildings
//*Syntax: nul = [this] execVM "external\LV\patrol-vD.sqf";
//     or: nul = [this,center position,radius,handle doors] execVM "external\LV\patrol-vD.sqf";
//*center position: [position array] (center point of patrol, f.ex. (getMarkerPos "marker1")) DEFAULT: (getPos _unit) = unit's starting position
//*radius: number (how far from center position will the patrol reach) DEFAULT: 150
//*handle doors: true = units will close doors behind them

private ["_buildings","_wp1","_unit","_startingPos","_pDir","_pRange","_newPos","_buildingVisits","_justDidBuilding","_i","_i2","_bPoss","_chooseBuildingOrNot","_building","_center","_radius","_buildingVisitMax","_buildingDistanceLimit"];
if(isNil("LV_CloseDoors"))then{LV_CloseDoors = compileFinal preprocessFile "external\LV\LV_functions\LV_fnc_closeDoors.sqf";};
if(isNil("LV_nearestBuilding"))then{LV_nearestBuilding = compileFinal preprocessFile "external\LV\LV_functions\LV_fnc_nearestBuilding.sqf";};
_unit = _this select 0;
_cPos = _this select 1;
_radius = _this select 2;
_handleDoors = if(count _this > 3) then {_this select 3; }else{false;};

if(isNil("_cPos"))then{_cPos = (getPos _unit);}else{_cPos = _cPos;};
if(isNil("_radius"))then{_radius = 150;}else{_radius = _radius;};

_startingPos = getPos _unit;
_newPos = _startingPos;
_justDidBuilding = false;

_buildingVisits = 0;
_buildingVisitMax = 5;
_buildingDistanceLimit = 50;

while { alive _unit }do{
	if(_cPos in allMapMarkers)then{
		_center = getMarkerPos _cPos;
	}else{
		if (typeName _cPos == "ARRAY") then{
			_center = _cPos;
		}else{
			_center = getPos _cPos;
		};
	};

    if(isNull(_unit findNearestEnemy _unit))then{
        _unit forceSpeed 1;
    };

	_pDir = random 360;
    _pRange = 25 + random _radius;
    _newPos = [(_center select 0) + (sin _pDir) * _pRange, (_center select 1) + (cos _pDir) * _pRange, 0];

	if(surfaceIsWater _newPos)then{
			private["_randomWay","_dir"];
			_dir = (((_center) select 0) - (_newPos select 0)) atan2 (((_center) select 1) - (_newPos select 1));
			_randomWay = floor(random 2);
			while{surfaceIsWater _newPos}do{
				if(_randomWay == 0)then{_dir = _dir + 20;}else{_dir = _dir - 20;};
				if(_dir < 0) then {_dir = _dir + 360;};
				_newPos = [(_center select 0) + (sin _dir) * _pRange, (_center select 1) + (cos _dir) * _pRange, 0];
				sleep 0.001;
			};
	};
    	waitUntil {sleep 0.031;(unitReady _unit || _unit distance _newPos < 2) && behaviour _unit != "COMBAT"};
    	_unit doMove _newPos;
    	waitUntil {sleep 0.030;(unitReady _unit || _unit distance _newPos < 2) && behaviour _unit != "COMBAT"};

	if(_buildingVisits < _buildingVisitMax)then{
		_buildingVisits = _buildingVisits + 1;
	}else{
		_buildingVisits = 0;
		_justDidBuilding = false;
	};

	if(!_justDidBuilding)then{
		_buildings = ["nearest one",_unit,50] call LV_nearestBuilding;
		while{true}do{
			if(isNil("_buildings"))exitWith{_justDidBuilding = true;};
			if(count _buildings == 0)exitWith{_justDidBuilding = true;};
			_building = _buildings select 0;
			if((_unit distance _building) < _buildingDistanceLimit)then{
				_chooseBuildingOrNot = round(random 3);
				if(_chooseBuildingOrNot < 4)then{ //2
					_bPoss = [];
					_i = 0;
					while { ((_building buildingPos _i) select 0) != 0 } do {
						_bPoss set [count (_bPoss), (_building buildingPos _i)];
						_i = _i + 1;
						sleep 0.001;
					};
					//hint format["%1",(count _bPoss)];
					_i2 = 0;
					_unit setVariable ["TargetBuilding", _building, false];
					if(_handleDoors)then{[_unit,_building] spawn LV_CloseDoors;};
						while{_i2 < (count _bPoss)}do{
							_newPos = (floor(random(count _bPoss)));
							_newPos = _bPoss select _newPos;
							waitUntil {sleep 0.016;(unitReady _unit || _unit distance _newPos < 2) && behaviour _unit != "COMBAT"};
							_unit doMove _newPos;
							waitUntil {sleep 0.021;(unitReady _unit || _unit distance _newPos < 2) && behaviour _unit != "COMBAT"};
							sleep 5 + random 25;
							_i2 = _i2 + 1;
							sleep 0.001;
						};
					_justDidBuilding = true;
					if(_handleDoors)then{
						[_unit,_building] spawn {
							private["_unit","_building"];
							_unit = _this select 0;
							_building = _this select 1;
							waitUntil{sleep 2;((_unit distance _building)>20)};
							if((_unit getVariable "TargetBuilding")==_building)then{
								_unit setVariable ["TargetBuilding", nil, false];
							};
						};
					};
				};
			};
			if(true)exitWith{};
		};
	};
	_break = _unit getVariable "breakPatrol";
	if(!isNil("_break"))exitWith{};
    sleep 1 + random 59;
	if(!isNil("_break"))exitWith{};
};
