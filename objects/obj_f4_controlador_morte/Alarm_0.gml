if (instance_exists(obj_f4_chefe)){
	var _x = obj_f4_chefe.x;
	var _y = obj_f4_chefe.y;
	instance_create_layer(_x + irandom_range(-100, 100), _y + irandom_range(-100, 100), "UI", obj_f4_explosao_morte);
	cont++;
	if (cont > 20){
		var expl = instance_create_layer(_x, _y+150, "UI", obj_f4_explosao_chefe);
		expl.image_xscale = 5;
		expl.image_yscale = 5;
		obj_f4_chefe.image_alpha = 0;
		xboss = obj_f4_chefe.x;
		yboss = obj_f4_chefe.y - 50;
		yvilaodestino = yboss+50;
		desenhar = true;
		alarm[1] = 60;
	}else{
		alarm[0] = 5;
	}
}