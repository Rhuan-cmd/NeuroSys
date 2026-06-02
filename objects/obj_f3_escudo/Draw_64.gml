if (resultado_ativo) {
	var _gui_w = display_get_gui_width();
	var _gui_h = display_get_gui_height();
	var _suave = resultado_transicao * resultado_transicao * (3 - 2 * resultado_transicao);
	var _offset = lerp(36, 0, _suave);
	var _cor = resultado_vitoria ? make_color_rgb(55, 222, 242) : make_color_rgb(255, 78, 105);
	var _hover_acao = point_in_rectangle(mouse_x, mouse_y, 302, 382 + _offset, 458, 420 + _offset);
	var _hover_reiniciar = point_in_rectangle(mouse_x, mouse_y, 502, 382 + _offset, 658, 420 + _offset);

	draw_set_alpha(0.86);
	draw_set_color(c_black);
	draw_rectangle(0, 0, _gui_w, _gui_h, false);
	draw_set_alpha(_suave);
	draw_set_color(make_color_rgb(6, 17, 33));
	draw_rectangle(204, 116 + _offset, 756, 438 + _offset, false);
	draw_set_color(_cor);
	draw_rectangle(204, 116 + _offset, 756, 120 + _offset, false);
	draw_rectangle(204, 434 + _offset, 756, 438 + _offset, false);
	draw_set_font(fnt_dialogo);
	draw_set_halign(fa_center);
	draw_set_color(_cor);
	draw_text_transformed(480, 148 + _offset, resultado_vitoria ? "REDE PROTEGIDA" : "PRESSÃO DIGITAL", 1.24, 1.24, 0);
	draw_set_color(make_color_rgb(167, 192, 224));
	draw_text(480, 180 + _offset, resultado_vitoria ? "a origem dos ataques foi localizada" : "a pessoa precisa de uma nova tentativa");
	draw_set_halign(fa_left);
	draw_set_color(make_color_rgb(105, 224, 246));
	draw_text(278, 240 + _offset, "ATAQUES BLOQUEADOS");
	draw_text(278, 286 + _offset, "CONFIANÇA RESTANTE");
	draw_set_color(c_white);
	draw_text(512, 240 + _offset, string(destruidos) + "/50");
	draw_text(512, 286 + _offset, string(resultado_felicidade) + "/5");
	draw_set_color(_hover_acao ? make_color_rgb(255, 241, 145) : c_white);
	draw_rectangle(302, 382 + _offset, 458, 420 + _offset, true);
	draw_set_halign(fa_center);
	draw_text(380, 394 + _offset, resultado_vitoria ? "CONTINUAR" : "MENU");
	draw_set_color(_hover_reiniciar ? make_color_rgb(255, 241, 145) : c_white);
	draw_rectangle(502, 382 + _offset, 658, 420 + _offset, true);
	draw_text(580, 394 + _offset, "REINICIAR");
	draw_set_halign(fa_left);
	draw_set_alpha(1);
	draw_set_color(c_white);
	exit;
}

if (instance_exists(obj_f3_npc)) {
	if (obj_f3_npc.perdeu) return;
}

if (umavez) return;

draw_set_color(c_black);
draw_set_font(fnt_contador);
draw_text(view_wport - 150, 35, string(destruidos) + string("/50"));
draw_sprite(spr_f3_msg_negativa, 0, view_wport - 50, 50);
