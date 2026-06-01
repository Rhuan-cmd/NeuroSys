instance_create_layer(irandom_range(0, room_width), room_height/2, layer, obj_f4_raivoso);

vezes--;

if (vezes > 0){
	alarm[0] = 30;
}else{
	obj_f4_chefe.descanso(180);
	obj_f4_chefe.ataque1 = true;
	instance_destroy();
}