//Counts AI in groups ID 1 and ID 2 +shows fps
private["_count1","_count2","_count3","_count4"];
if(isNil("diagHint"))then{diagHint = true;}else{
	if(diagHint)then{diagHint = false; hint "";}else{diagHint = true;};
};

while{diagHint}do{ 

if(!isNil("LVgroup1"))then{_count1 = ({alive _x} count units LVgroup1);}else{_count1 = 0;};
if(!isNil("LVgroup2"))then{_count2 = ({alive _x} count units LVgroup2);}else{_count2 = 0;};
if(!isNil("LVgroup3"))then{_count3 = ({alive _x} count units LVgroup3);}else{_count3 = 0;};
if(!isNil("LVgroup4"))then{_count4 = ({alive _x} count units LVgroup4);}else{_count4 = 0;};

_total = _count1 + _count2 + _count3 + _count4;

_fps = diag_fps;

hint parseText format["<t size='1.25' font='puristaMedium' color='#ff0000'>Дроидов осталось:</t> <t size='1.5' font='puristaMedium' color='#ffffff'>%1</t>",_total];

sleep 1;

};