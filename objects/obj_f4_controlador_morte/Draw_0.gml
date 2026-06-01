draw_set_color(c_black);
draw_set_alpha(alpha);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);
if (desenhar){
	alpha = lerp(alpha, 1, 0.1);
	draw_sprite_ext(
		spr_f4_vilao_chorando,
		0,
		xboss,
		yboss,
		-1,
		1,
		0,
		c_white,
		1
	);
	
	if (mover) yboss = lerp(yboss, yvilaodestino, 0.1);
	
	if (yboss >= yvilaodestino-2 && !ajeitar){
		mover = false;
		yboss = yvilaodestino;
		alarm[2] = 60;
		ajeitar = true;
	}
}