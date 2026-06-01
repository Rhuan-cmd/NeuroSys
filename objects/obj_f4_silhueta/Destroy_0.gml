if (variable_instance_exists(id, "linha") && variable_instance_exists(id, "coluna")){
	if (instance_exists(obj_f4_controlador_ataque4)){
		obj_f4_controlador_ataque4.matriz[linha][coluna] = 0;
	}
}