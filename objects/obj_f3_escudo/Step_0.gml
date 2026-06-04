if (resultado_ativo) {
	resultado_timer++;
	resultado_fade = min(1, resultado_fade + 0.06);
	if (resultado_fade >= 1 && resultado_timer > 18) resultado_transicao = min(1, resultado_transicao + 0.055);
	var _offset = lerp(36, 0, resultado_transicao);
	var _mouse_gui_x = device_mouse_x_to_gui(0);
	var _mouse_gui_y = device_mouse_y_to_gui(0);
	var _hover_acao = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 312, 375 + _offset, 454, 411 + _offset);
	var _hover_reiniciar = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 506, 375 + _offset, 648, 411 + _offset);
	if (resultado_saida == 0 && mouse_check_button_pressed(mb_left)) {
		if (_hover_acao) resultado_saida = 1;
		if (_hover_reiniciar) resultado_saida = 2;
	}
	if (resultado_saida == 0 && keyboard_check_pressed(vk_enter)) resultado_saida = 1;
	if (resultado_saida == 1) {
		if (resultado_vitoria) transicao(rm_fase4);
		else transicao(rm_menu);
	}
	if (resultado_saida == 2) transicao(rm_fase3);
	return;
}

tempo_fase++;

var objeto_centro = obj_f3_npc;
var raio = 96;

if (instance_exists(objeto_centro)) {
	var angulo = point_direction(objeto_centro.x, objeto_centro.y, mouse_x, mouse_y);
	x = lerp(x, objeto_centro.x + lengthdir_x(raio, angulo), 0.3);
	y = lerp(y, objeto_centro.y + lengthdir_y(raio, angulo), 0.3);
	image_angle = angulo;
}

scala_x = lerp(scala_x, escala_alvo, fator_mola);
scala_y = lerp(scala_y, escala_alvo, fator_mola);

if (destruidos >= 50 and !umavez) {
	if (instance_exists(obj_f3_controlador_msg)) instance_destroy(obj_f3_controlador_msg);
	with (obj_f3_msg_negativa) instance_destroy();
	ganhou = true;
	audio_stop_all();
	audio_play_sound(snd_f3_vilao_raiva, 1, 0);
	umavez = true;
	destruidos = 50;
}

if (ganhou) {
	if (instance_exists(obj_f3_vilao)) obj_f3_vilao.parar = true;
	ganhou = false;
}
