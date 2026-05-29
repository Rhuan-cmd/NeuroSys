if (instance_exists(obj_npc_fase3)){
	if (obj_npc_fase3.perdeu) return;
}

if (umavez) return;

draw_set_color(c_black);
draw_set_font(fnt_contador);
draw_text(view_wport-150, 35, string(destruidos) + string("/50"));
draw_sprite(spr_mensagem_negativa, 0, view_wport-50, 50);