if (!perdeu && !obj_f3_escudo.umavez){
	draw_sprite_ext(spr_ui_barra_felicidade, estado_felicidade, 30, view_hport/2 - sprite_get_height(spr_ui_barra_felicidade)*5/2, 5, 5, 0, c_white, 1);
	var pos_dentro = view_hport/2 - (sprite_get_height(spr_ui_barra_felicidade)*5/2) + sprite_get_height(spr_ui_felicidade)*5;
	draw_sprite_ext(spr_ui_felicidade, 0, 30, pos_dentro, 5, -total_felicidade, 0, cor_barra, 1);
}