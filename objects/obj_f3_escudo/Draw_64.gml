if (instance_exists(obj_f3_npc)){
	if (obj_f3_npc.perdeu) return;
}

if (umavez) return;

draw_set_color(c_black);
draw_set_font(fnt_contador);
draw_text(view_wport-150, 35, string(destruidos) + string("/50"));
draw_sprite(spr_f3_msg_negativa, 0, view_wport-50, 50);