if (variable_instance_exists(id, "linha") && variable_instance_exists(id, "coluna")){
	if (instance_exists(obj_controller_ataque4)){
		obj_controller_ataque4.matriz[linha][coluna] = 0;
	}
}