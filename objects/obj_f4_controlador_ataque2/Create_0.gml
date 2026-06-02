pos_y = 0;
perigo_ativo = false; // Variável para controlar se o retângulo deve aparecer

perigo = noone;

gerar_area_perigo = function() {
	if (perigo){
		instance_destroy(perigo);
	}
    if (instance_exists(obj_f4_nave)) {
        var metade_tela = room_height / 2;
        var altura_retangulo = 100;
        
        // Pega o Y do player, mas garante que ele não suba além da metade da tela
        // clamp(valor, minimo, maximo) serve perfeitamente para isso
        pos_y = clamp(obj_f4_nave.y - (altura_retangulo / 2), metade_tela, room_height - altura_retangulo);
        
		perigo = instance_create_layer(room_width/2, pos_y+50, layer, obj_f4_perigo)
        perigo_ativo = true;
		alarm[0] = 60;
    }
}

gerar_area_perigo();

// ... (mantenha o código anterior da pos_y e perigo_ativo)

delay_entre_objetos = 0.1 * game_get_speed(gamespeed_fps); // 0.1 segundos (ajuste como quiser)
timer_geracao = 0;
gerar_dislike = false;