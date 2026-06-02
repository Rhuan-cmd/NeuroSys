draw_sprite_ext(
	spr_ui_fundo_vida_chefe,
	0,
	position_x,
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);

draw_sprite_part_ext(
	spr_ui_vida_chefe,
	0,
	offset,
	0,
	progresso,
	sprite_get_height(spr_ui_vida_chefe),
	position_x,
	position_y,
	scale,
	scale,
	c_white,
	1
)

draw_sprite_ext(
	spr_ui_esqueleto_chefe,
	0,
	position_x,
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);

draw_sprite_ext(
	spr_ui_icone_chefe,
	0,
	position_x,
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);

draw_sprite_ext(
	spr_ui_coracao_chefe,
	coracao4,
	position_x,
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);

draw_sprite_ext(
	spr_ui_coracao_chefe,
	coracao3,
	position_x + tamanho_coracao,
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);

draw_sprite_ext(
	spr_ui_coracao_chefe,
	coracao2,
	position_x + (tamanho_coracao*2),
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);

draw_sprite_ext(
	spr_ui_coracao_chefe,
	coracao1,
	position_x + (tamanho_coracao*3),
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);