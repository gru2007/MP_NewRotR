// by ALIAS
// Dust Storm SCRIPT 
// Tutorial: https://www.youtube.com/user/aliascartoons

if (!isServer) exitWith {};

_direction_duststorm	= _this select 0;
_duration_duststorm		= _this select 1;
_effect_on_objects		= _this select 2;
_dust_wall				= _this select 3;
_lethal_wall			= _this select 4;

//hint str _direction_duststorm;

al_duststorm_on = true;
publicVariable "al_duststorm_on";

al_foglevel		= fog;
al_rainlevel	= rain;
al_thundlevel	= lightnings;
al_windlevel	= wind;
publicVariable "al_foglevel";
publicVariable "al_rainlevel";
publicVariable "al_thundlevel";
publicVariable "al_windlevel";
/*
al_overforecast	= overcastForecast;
publicVariable "al_overforecast";
*/
sleep 0.1;

[_duration_duststorm] spawn {
	x_duration_storm = _this select 0;
	sleep x_duration_storm;
	
	al_duststorm_on = false;
	publicVariable "al_duststorm_on";

// restaureaza parametri vreme
	60 setFog al_foglevel;
	60 setRain al_rainlevel;
	60 setLightnings al_thundlevel;
//	180 setOvercast al_overforecast;
	setWind [al_windlevel select 0, al_windlevel select 1, true];
	//forceWeatherChange;
};

[] spawn {
	while {al_duststorm_on} do {
		["bcg_wind"] remoteExec ["playSound"];
		sleep 67;
	};
};

[] spawn {
	_ifog=0;
	while {_ifog <0.3} do {
		_ifog=_ifog+0.001; 0 setFog _ifog; sleep 0.01;
	};
};

[[],"external\dust_storm\functions\fn_duststorm_effect.sqf"] remoteExec ["BIS_fnc_execVM"];

if (_dust_wall) then {
	// perete de praf
	_rand_pl = [] execVM "external\dust_storm\functions\fn_hunt.sqf";
	waitUntil {scriptDone _rand_pl};

	//_origine_storm = -1*_direction_duststorm;

	//_pozstorm = getpos hunt_alias;
	_rapoz = 360-_direction_duststorm;

	_xpoz= 0;
	_ypoz= 0;
	 
	if (_rapoz>=315) then {_xpoz = 0; _ypoz = -800};
	if (_rapoz <45) then {_xpoz = 0; _ypoz = -800};
	if ((_rapoz <90) and (_rapoz >=45)) then {_xpoz = 800; _ypoz = 0};
	if ((315>_rapoz) and (_rapoz>=270)) then {_xpoz = -800; _ypoz = 0};
	if ((270>_rapoz) and (_rapoz>=225)) then {_xpoz = -800; _ypoz = 0};
	if ((225>_rapoz) and (_rapoz>=180)) then {_xpoz = 0; _ypoz = 800};
	if ((180>_rapoz) and (_rapoz>=135)) then {_xpoz = 0; _ypoz = 800};
	if ((135>_rapoz) and (_rapoz>=90)) then {_xpoz = 800; _ypoz = 0};

	//hint str _xpoz;sleep 1;hint str _ypoz;

	_pozobcj = [(getPos hunt_alias select 0) + _xpoz, (getPos hunt_alias select 1) + _ypoz, 0];

	_xadd = 0;
	_yadd = 0;

	if ((_ypoz == -800) or ((_ypoz == 800))) then {_yadd =0; _xadd = 160};
	if ((_xpoz == -800) or ((_xpoz == 800))) then {_yadd =160; _xadd = 0};


	_stormsource = "Land_HelipadEmpty_F" createVehicle _pozobcj;

	_stormsource_1 = "Land_HelipadEmpty_F" createVehicle [(_pozobcj select 0)-2*_xadd,(_pozobcj select 1)-2*_yadd,0];
	_stormsource_2 = "Land_HelipadEmpty_F" createVehicle [(_pozobcj select 0)-_xadd,(_pozobcj select 1)-_yadd,0];

	_stormsource_3 = "Land_HelipadEmpty_F" createVehicle [(_pozobcj select 0)+_xadd,(_pozobcj select 1)+_yadd,0];
	_stormsource_4 = "Land_HelipadEmpty_F" createVehicle [(_pozobcj select 0)+2*_xadd,(_pozobcj select 1)+2*_yadd,0];

	_stormsource_5 = "Land_HelipadEmpty_F" createVehicle [(_pozobcj select 0)-3*_xadd,(_pozobcj select 1)-3*_yadd,0];
	_stormsource_6 = "Land_HelipadEmpty_F" createVehicle [(_pozobcj select 0)+3*_xadd,(_pozobcj select 1)+3*_yadd,0];
	
	[_stormsource,_stormsource_1,_stormsource_2,_stormsource_3,_stormsource_4,_stormsource_5,_stormsource_6] spawn {
		private ["_xadv","_yadv","_storm","_storm_1","_storm_2","_storm_3","_storm_4","_storm_5","_storm_6"];
		_storm = _this select 0;
		_storm_1 = _this select 1;
		_storm_2 = _this select 2;
		_storm_3 = _this select 3;
		_storm_4 = _this select 4;
		_storm_5 = _this select 5;
		_storm_6 = _this select 6;

		_xadv = 0;
		_yadv = 0;
		
		// depl vert
		if (((getPos _storm select 1)-(getPos hunt_alias select 1)) > 0) then {
		/*_xadv = 0;*/_yadv =-5;
		} else {/*_xadv = 0;*/_yadv =5;};

		// depl oriz
		if (((getPos _storm select 0)-(getPos hunt_alias select 0)) > 0) then {
		_xadv = -5;/*_yadv =0;*/
		} else {_xadv = 5;/*_yadv =0;*/};
			
		//hint str _xadv;		
		
		while {al_duststorm_on} do {		
			_storm 	 setPos [(getPos _storm select 0)+_xadv,(getPos _storm select 1)+_yadv,0];
			_storm_1 setPos [(getPos _storm_1 select 0)+_xadv,(getPos _storm_1 select 1)+_yadv,0];
			_storm_2 setPos [(getPos _storm_2 select 0)+_xadv,(getPos _storm_2 select 1)+_yadv,0];
			_storm_3 setPos [(getPos _storm_3 select 0)+_xadv,(getPos _storm_3 select 1)+_yadv,0];
			_storm_4 setPos [(getPos _storm_4 select 0)+_xadv,(getPos _storm_4 select 1)+_yadv,0];
			_storm_5 setPos [(getPos _storm_5 select 0)+_xadv,(getPos _storm_5 select 1)+_yadv,0];
			_storm_6 setPos [(getPos _storm_6 select 0)+_xadv,(getPos _storm_6 select 1)+_yadv,0];		
			sleep 5;
			//hint str getPos _storm;
		};
	};	
	
	sleep 0.1;
	
	[_stormsource] spawn {
		_stormsource_s = _this select 0;
		while {al_duststorm_on} do {
			[_stormsource_s,["uragan_1",2000]] remoteExec ["say3d"];
			sleep 40;
		};
	};
	
// >> wall of dust distrugator
	if (_lethal_wall) then {
		[_stormsource,_stormsource_1,_stormsource_2,_stormsource_3,_stormsource_4,_stormsource_5,_stormsource_6] spawn {
			_storm = _this select 0;
			_storm_1 = _this select 1;
			_storm_2 = _this select 2;
			_storm_3 = _this select 3;
			_storm_4 = _this select 4;
			_storm_5 = _this select 5;
			_storm_6 = _this select 6;
			
			while {al_duststorm_on} do {
			_dir_blow_wall = wind;
			//hint str _dir_blow_wall;
			
			_lethal_obj = [	_storm,_storm_1,_storm_2,_storm_3,_storm_4,_storm_5,_storm_6] call BIS_fnc_selectRandom;
			_nearobjects = nearestObjects[_lethal_obj,[],50];
			
			{if((_x != _storm)and(_x != _storm_1)and(_x != _storm_2)and(_x != _storm_3)and(_x != _storm_4)and(_x != _storm_5)and(_x != _storm_6)) then {
				if((_x isKindOf "LandVehicle") or (_x isKindOf "Man") or (_x isKindOf "Air")) then {
					_x setvelocity [random (_dir_blow_wall select 0),random (_dir_blow_wall select 1),5+(random 15)];
					_x setdamage 0.5; sleep 0.1} else {_x setdamage 1}; sleep 0.1};
			} foreach _nearobjects;
			sleep 1;//30 + random 30;
			};
		};
	};
// >>>>>>>>>>>>>>>>>>>>	

	[[_stormsource,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.1;
	[[_stormsource_1,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.1;
	[[_stormsource_2,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.1;
	[[_stormsource_3,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.1;
	[[_stormsource_4,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.1;
	[[_stormsource_5,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
	sleep 0.1;
	[[_stormsource_6,_duration_duststorm],"external\dust_storm\functions\fn_dust_wall.sqf"] remoteExec ["BIS_fnc_execVM"];
};

// seteaza wind storm functie de directie
raport = 360/_direction_duststorm;
raport = round (raport * (10 ^ 2)) / (10 ^ 2);

if (raport >= 4) then {fctx = 1; fcty = 1;}
	else {if (raport >= 2) then {fctx = 1; fcty = -1;}
						else { if (raport >=1.33) then {fctx = -1; fcty = -1;}
												else {fctx = -1; fcty = 1;};
						};
	};
if ((raport <= 2) and (raport >= 1.33)) then {fctx = -1; fcty = -1;};

_unx	= ((_direction_duststorm - floor (_direction_duststorm/90)*90))*fctx;

vx = floor (_unx * 0.6);
vy = (54 - vx)*fcty;

// mareste incremental vantul
inx = 0;
iny = 0;

incr = true;
incrx = false;
incry = false;

while {incr} do {
	sleep 0.01;
	if (inx < abs vx) then {inx = inx+0.1;} else {incrx = true};
	if (iny < abs vy) then {iny = iny+0.1} else {incry = true};
	if (incrx and incry) then {incr=false};
	winx = floor (inx*fctx/2);
	winy = floor (iny*fcty/2);
	setWind [winx,winy,true];
};

if (_effect_on_objects) then {

	while {al_duststorm_on} do {
		sleep 1;
		_rand_pl = [] execVM "external\dust_storm\functions\fn_hunt.sqf";
		waitUntil {scriptDone _rand_pl};

	// interval object blow
		//sleep 1;
		sleep 60+random 120;
		
		al_nearobjects = nearestObjects [hunt_alias,[],50];
		ar_obj_eligibl = [];
		
		{if((_x isKindOf "LandVehicle") or (_x isKindOf "Man") or (_x isKindOf "Air") or (_x isKindOf "Wreck")) then 
			{ar_obj_eligibl pushBack _x;};
		} foreach al_nearobjects;
		
		sleep 1;
		
		// alege obiect
		_blowobj= ar_obj_eligibl call BIS_fnc_selectRandom;

		//durata_rafala = 1+random 5;	sleep 30+random 120;
		sleep 1;
		[] spawn {
			_rafale = ["rafala_1","sandstorm","rafala_4_dr","rafala_5_st"] call BIS_fnc_selectRandom;
			[_rafale] remoteExec ["playSound"];
		};
		
		if (!isNull _blowobj) then {
			_xblow	= 0.1+random 5;
			_yblow	= 0.1+random 5;
	
			// creste viteza incremental
			_xx=0;
			_yy=0;
			
			while {(_xx< _xblow) or (_yy< _yblow)} do {
				_blowobj setvelocity [_xx*fctx,_yy*fcty,random -1];
				_xx = _xx + 0.01;
				_yy = _yy + 0.01;
				sleep 0.001;
			};
		
		};
	};
};

while {al_duststorm_on} do {
	_rafale = ["rafala_1","sandstorm","rafala_4_dr","rafala_5_st"] call BIS_fnc_selectRandom;
	[_rafale] remoteExec ["playSound"];
	sleep 60+random 120;
};

//deleteVehicle _stormsource;deleteVehicle _stormsource_1;deleteVehicle _stormsource_2;deleteVehicle _stormsource_3;deleteVehicle _stormsource_4;deleteVehicle _stormsource_5;deleteVehicle _stormsource_6;