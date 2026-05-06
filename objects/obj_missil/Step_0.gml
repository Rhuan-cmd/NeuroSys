var dt = delta_time / 1000000;

y += velocidade * dt;

if (variable_instance_exists(id, "altura")){
	if (y > altura){
		instance_destroy();
	}
}

if (y > room_height+100) instance_destroy();