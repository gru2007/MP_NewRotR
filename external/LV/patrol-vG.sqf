///////Simple House Patrol script vG 1.3 - SPUn / LostVar
//
//*infantry units patrols inside nearest building and outside of it
//*Syntax: nul = [this] execVM "external\LV\patrol-vG.sqf";

private ["_unit","_newPos","_i","_i2","_bPoss","_building","_dir","_range","_curPos","_outOrNot"];

if(isNil("LV_nearestBuilding"))then{LV_nearestBuilding = compileFinal preprocessFile "external\LV\LV_functions\LV_fnc_nearestBuilding.sqf";};

_unit = _this select 0;
_buildings = ["nearest one",_unit] call LV_nearestBuilding;
if(isNil("_buildings") || (count _buildings < 1))then{_buildings = nearestBuilding (getPos _unit)};
_building = _buildings select 0;

while { alive _unit }do{
    if(isNull(_unit findNearestEnemy _unit))then{
        _unit forceSpeed 1;
        _unit setBehaviour "SAFE";
    };

    _bPoss = [];
	_i = 0;
	while { ((_building buildingPos _i) select 0) != 0 } do {
    	if((lineIntersects [(AGLToASL (_building buildingPos _i)) vectorAdd [0,0,1], (AGLToASL (_building buildingPos _i)) vectorAdd [0,0,10]]) == true)then{
    		_bPoss set [count (_bPoss), (_building buildingPos _i)];
		};
        _i = _i + 1;
        sleep 0.001;
	};
	_i2 = 0;
    while{_i2 < (count _bPoss)}do{
       	_newPos = (floor(random(count _bPoss)));
        	_newPos = _bPoss select _newPos;
        	waitUntil {sleep 0.015;(unitReady _unit || _unit distance _newPos < 2)};
        	_unit doMove _newPos;
        	waitUntil {sleep 0.015;(unitReady _unit || _unit distance _newPos < 2)};
        	sleep 5 + random 25;

         _outOrNot = ceil(random 3);
        if(_outOrNot == 1)then{
            _dir = random 360;
            _range = 10 + (random 10);
            _curPos = getPos _unit;
            _newPos = [(_curPos select 0) + (sin _dir) * _range, (_curPos select 1) + (cos _dir) * _range, 0];
            _unit doMove _newPos;
            waitUntil {sleep 0.016;(unitReady _unit || _unit distance _newPos < 2)};
            sleep 5 + random 25;
        }else{
            _i2 = _i2 + 1;
        };
        sleep 0.001;
    };

    _break = _unit getVariable "breakPatrol";
	if(!isNil("_break"))exitWith{};
    sleep 0.001;
};
