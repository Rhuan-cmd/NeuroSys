if (instance_exists(obj_npc_fase4)){
	direction = point_direction(x, y, obj_npc_fase4.x, obj_npc_fase4.y);
	image_angle = direction;
	speed = 4;
}

image_speed = 0;
image_xscale = 1.5;
image_yscale = 1.5;

image_index = irandom_range(0, image_number-1);
flip = (x > room_width/2);