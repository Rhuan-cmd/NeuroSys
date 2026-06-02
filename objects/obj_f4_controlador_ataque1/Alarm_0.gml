var _x_faixa = ((faixa mod 5) + 0.5) * (room_width / 5);
var _x_ataque = _x_faixa;
if (instance_exists(obj_f4_nave) && faixa mod 2 == 0) {
    _x_ataque = clamp(obj_f4_nave.x + irandom_range(-54, 54), 32, room_width - 32);
}
instance_create_layer(_x_ataque, room_height / 2, layer, obj_f4_raivoso);
faixa++;

vezes--;

if (vezes > 0){
	alarm[0] = 30;
}else{
	obj_f4_chefe.descanso(180);
	obj_f4_chefe.ataque1 = true;
	instance_destroy();
}
