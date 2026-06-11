if (image_alpha <= 0) return;
draw_sprite_ext(
	spr_f4_vilao,
	0,
	x,
	y - 50,
	-1,
	1,
	0,
	c_white,
	1
)
draw_self();

if (danificado){
	image_blend = make_color_rgb(255, 204, 204);
}else{
	image_blend = c_white;
}

if (controles_timer > 0) {
	var _fade_in = clamp(controles_intro / 24, 0, 1);
	var _fade_out = clamp(controles_timer / max(1, room_speed * 0.75), 0, 1);
	var _alpha = min(_fade_in, _fade_out);
	var _pulse = 1 + sin(current_time * 0.008) * 0.025;
	var _bx = x + 78;
	var _by = y - 118 + sin(current_time * 0.006) * 3;
	draw_set_alpha(0.78 * _alpha);
	draw_set_color(make_color_rgb(5, 13, 26));
	draw_roundrect(_bx, _by, _bx + 172, _by + 82, false);
	draw_set_alpha(_alpha);
	draw_set_color(make_color_rgb(122, 72, 255));
	draw_roundrect(_bx, _by, _bx + 172, _by + 82, true);
	draw_set_font(fnt_dialogo);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(make_color_rgb(186, 118, 255));
	draw_text_transformed(_bx + 86, _by + 25, "WASD / SETAS", 0.62 * _pulse, 0.62 * _pulse, 0);
	draw_set_color(make_color_rgb(255, 218, 116));
	draw_text_transformed(_bx + 86, _by + 55, "K  ATIRAR", 0.62 * _pulse, 0.62 * _pulse, 0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	draw_set_color(c_white);
}
