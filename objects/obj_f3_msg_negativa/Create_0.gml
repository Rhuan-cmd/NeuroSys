if (instance_exists(obj_f3_npc)){
	direction = point_direction(x, y, obj_f3_npc.x, obj_f3_npc.y);
	image_angle = direction;
}

image_speed = 0;
image_xscale = 1.5;
image_yscale = 1.5;

image_index = irandom_range(0, image_number-1);
flip = (x > room_width/2);