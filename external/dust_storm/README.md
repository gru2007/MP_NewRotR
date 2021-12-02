# Описание параметров
```sqf
//Стандартный вид команды
null = [direction_duststorm, duration_duststorm, effect_on_objects, wall_of_dust, lethal_wall] execvm "AL_dust_storm\al_duststorm.sqf";

direction_duststorm	- от 0 до 360, направление песчаной бури по азимуту
duration_duststorm	- время действия песчаной бури в секундах
effect_on_objects	- если написать true, то случайный объект будет подброшен бурей в воздух
wall_of_dust		- если написать true, то создается стена пыли. ОЧЕНЬ ГРУЗИТ КОМП!
lethal_wall			- если написать true, то стена пыли начинает разрушать объекты. ОЧЕНЬ ГРУЗИТ КОМП!
```



# Как вызвать?
Нужно с помощью модуля выполнить код вписать это. И готово.

Не забудьте изменить параметры!
```sqf
// Только визуально
null = [340,600,false,false,false] execvm "external\dust_storm\functions\fn_duststorm.sqf";

// Начинает пододвигать случайные объеты рядом с игроком. Включая игрока.
null = [340,600,true,false,false] execvm "external\dust_storm\functions\fn_duststorm.sqf";

// Теперь ещё добавилась стена из пыли, но она ничего не разрушает
null = [340,600,true,true,false] execvm "external\dust_storm\functions\fn_duststorm.sqf";

// Теперь стена из пыли может разрушать объекты
null = [340,600,true,true,true] execvm "external\dust_storm\functions\fn_duststorm.sqf";
```