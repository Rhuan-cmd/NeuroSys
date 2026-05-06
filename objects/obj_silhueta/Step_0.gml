if (explodir){
	instance_create_layer(x, y, layer, obj_explosao_boss);
	criar_explosao_particulas(x, y, c_orange, 50, 0.4);
	image_alpha = 0;
	dardano = true;
	alarm[0] = 30;
	explodir = false;
}