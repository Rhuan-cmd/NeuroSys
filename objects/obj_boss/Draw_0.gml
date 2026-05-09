if (image_alpha <= 0) return;
draw_sprite_ext(
	spr_vilao,
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

