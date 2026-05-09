if (instance_exists(obj_boss)){
	var _x = obj_boss.x;
	var _y = obj_boss.y;
	instance_create_layer(_x + irandom_range(-100, 100), _y + irandom_range(-100, 100), "UI", obj_explosao_morte);
	cont++;
	if (cont > 20){
		var expl = instance_create_layer(_x, _y+150, "UI", obj_explosao_boss);
		expl.image_xscale = 5;
		expl.image_yscale = 5;
		obj_boss.image_alpha = 0;
		xboss = obj_boss.x;
		yboss = obj_boss.y - 50;
		yvilaodestino = yboss+50;
		desenhar = true;
		alarm[1] = 60;
	}else{
		alarm[0] = 5;
	}
}