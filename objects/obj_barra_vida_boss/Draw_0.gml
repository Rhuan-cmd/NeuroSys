draw_sprite_ext(
	spr_fundo_barra_boss,
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
	spr_preenchimento_barra_boss,
	0,
	offset,
	0,
	progresso,
	sprite_get_height(spr_preenchimento_barra_boss),
	position_x,
	position_y,
	scale,
	scale,
	c_white,
	1
)

draw_sprite_ext(
	spr_esqueleto_barra_boss,
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
	spr_icone_barra_boss,
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
	spr_coracao_barra_boss,
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
	spr_coracao_barra_boss,
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
	spr_coracao_barra_boss,
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
	spr_coracao_barra_boss,
	coracao1,
	position_x + (tamanho_coracao*3),
	position_y,
	scale,
	scale,
	0,
	c_white,
	1
);