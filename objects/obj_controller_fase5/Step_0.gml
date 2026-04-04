if (keyboard_check_pressed(vk_space)){
	instance_create_layer(0, 0, layer, obj_controller_mensagem_negativa);
	instance_destroy();
}