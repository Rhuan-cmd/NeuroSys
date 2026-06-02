if (!perdeu && !obj_f3_escudo.umavez){
	draw_sprite_ext(spr_ui_barra_felicidade, estado_felicidade, 30, view_hport/2 - sprite_get_height(spr_ui_barra_felicidade)*5/2, 5, 5, 0, c_white, 1);
	var pos_dentro = view_hport/2 - (sprite_get_height(spr_ui_barra_felicidade)*5/2) + sprite_get_height(spr_ui_felicidade)*5;
	draw_sprite_ext(spr_ui_felicidade, 0, 30, pos_dentro, 5, -total_felicidade, 0, cor_barra, 1);
}

var _corrupcao = clamp((5 - atualizar_felicidade) / 5 + corrupt_flash * 0.42, 0, 1);
if (_corrupcao > 0) {
	var _frame = floor(current_time / 95) mod sprite_get_number(spr_fx_corrupcao);
	draw_sprite_ext(spr_fx_corrupcao, _frame, 0, 0, display_get_gui_width() / sprite_get_width(spr_fx_corrupcao), display_get_gui_height() / sprite_get_height(spr_fx_corrupcao), 0, c_white, 0.12 + _corrupcao * 0.36);
}
