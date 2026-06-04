if (resultado_ativo) {
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _suave = resultado_transicao * resultado_transicao * (3 - 2 * resultado_transicao);
	var _offset = lerp(38, 0, _suave);
	var _cor = resultado_vitoria ? make_color_rgb(55, 222, 242) : make_color_rgb(255, 78, 105);
	var _mouse_gui_x = device_mouse_x_to_gui(0);
	var _mouse_gui_y = device_mouse_y_to_gui(0);
	var _hover_acao = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 312, 375 + _offset, 454, 411 + _offset);
	var _hover_reiniciar = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 506, 375 + _offset, 648, 411 + _offset);
	var _segundos = max(0, floor(resultado_tempo / room_speed));
	var _tempo_txt = string(floor(_segundos / 60)) + ":" + ((_segundos mod 60) < 10 ? "0" : "") + string(_segundos mod 60);

	draw_set_alpha(resultado_fade);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gui_w, _gui_h, false);
	if (resultado_transicao <= 0) exit;

	draw_set_alpha(0.22 * _suave);
	draw_set_color(_cor);
	for (var _scan = 0; _scan < _gui_h; _scan += 22) {
		draw_rectangle(0, _scan + _offset * 0.25, _gui_w, _scan + 2 + _offset * 0.25, false);
	}
	draw_set_alpha(_suave);
	draw_sprite_ext(spr_f3_painel_resultado, resultado_vitoria ? 0 : 1, 480, 270 + _offset, 1, 1, 0, c_white, _suave);
	draw_set_font(fnt_dialogo);
	draw_set_halign(fa_center);
	draw_set_color(_cor);
	draw_text_transformed(480, 142 + _offset, resultado_vitoria ? "REDE PROTEGIDA" : "PRESSÃO DIGITAL", 1.12, 1.12, 0);
	draw_set_color(make_color_rgb(144, 163, 196));
	draw_text(480, 158 + _offset, resultado_vitoria ? "a origem dos ataques foi localizada" : "a pessoa precisa de uma nova tentativa");
	var _rotulos = ["ACERTOS", "TEMPO", "NOTA"];
	var _valores = [string(destruidos) + "/50", _tempo_txt, resultado_nota];
	for (var _card = 0; _card < 3; _card++) {
		var _x1 = 264 + _card * 148;
		var _x2 = _x1 + 136;
		draw_set_alpha(0.22 * _suave);
		draw_set_color(_cor);
		draw_rectangle(_x1 - 3, 246 + _offset, _x2 + 3, 326 + _offset, false);
		draw_set_alpha(0.94 * _suave);
		draw_set_color(make_color_rgb(8, 19, 35));
		draw_rectangle(_x1, 249 + _offset, _x2, 323 + _offset, false);
		draw_set_color(_cor);
		draw_text(_x1 + 68, 266 + _offset, _rotulos[_card]);
		draw_set_color(c_white);
		draw_text_transformed(_x1 + 68, 296 + _offset, _valores[_card], 1.08, 1.08, 0);
	}
	draw_set_halign(fa_center);
	draw_set_color(_hover_acao ? make_color_rgb(255, 246, 152) : c_white);
	draw_text(383, 384 + _offset, "MENU");
	draw_set_color(_hover_reiniciar ? make_color_rgb(255, 246, 152) : c_white);
	draw_text(577, 384 + _offset, "REINICIAR");
	if (resultado_saida_fade > 0) {
		draw_set_alpha(resultado_saida_fade);
		draw_set_color(resultado_saida == 1 ? c_white : c_black);
		draw_rectangle(0, 0, _gui_w, _gui_h, false);
	}
	draw_set_halign(fa_left);
	draw_set_alpha(1);
	draw_set_color(c_white);
	exit;
}

if (vitoria_cutscene_ativa && vitoria_cutscene_fade > 0) {
	draw_set_alpha(vitoria_cutscene_fade);
	draw_set_color(c_black);
	draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
	draw_set_alpha(1);
	draw_set_color(c_white);
}

if (instance_exists(obj_f3_npc)) {
	if (obj_f3_npc.perdeu) return;
}

if (umavez) return;

draw_set_color(c_black);
draw_set_font(fnt_contador);
draw_text(view_wport - 150, 35, string(destruidos) + string("/50"));
draw_sprite(spr_f3_msg_negativa, 0, view_wport - 50, 50);
