if (instance_exists(obj_npc_fase5)){
	direction = point_direction(x, y, obj_npc_fase5.x, obj_npc_fase5.y);
	image_angle = direction;
}

image_speed = 0;
image_xscale = 1.5;
image_yscale = 1.5;

image_index = irandom_range(0, image_number-1);
flip = (x > room_width/2);