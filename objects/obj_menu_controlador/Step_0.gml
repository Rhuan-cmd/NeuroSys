entrada_bloqueada = max(0, entrada_bloqueada - 1);
menu_timer += 1;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
botao_hover = -1;

for (var i = 0; i < array_length(botao_sprite); i += 1) {
    var spr = botao_sprite[i];
    var bw = sprite_get_width(spr);
    var bh = sprite_get_height(spr);
    var bx = botao_x;
    var by = botao_y[i];

    if (mx >= bx - bw * 0.5 && mx <= bx + bw * 0.5 && my >= by - bh * 0.5 && my <= by + bh * 0.5) {
        botao_hover = i;
        break;
    }
}

if (menu_bg_layer != -1) {
    layer_x(menu_bg_layer, sin(menu_timer * 0.018) * 1.5);
    layer_y(menu_bg_layer, cos(menu_timer * 0.015) * 0.9);
}

if (!clique_iniciado && entrada_bloqueada <= 0 && botao_hover != botao_hover_anterior && botao_hover != -1) {
    audio_play_sfx(snd_f2_selecao, 3, false, 0.42, 0, 1);
}
botao_hover_anterior = botao_hover;

if (clique_iniciado) {
    menu_saida_timer -= 1;

    if (menu_saida_timer <= 0) {
        audio_stop_sound(snd_menu_luz);
        audio_stop_sound(snd_menu_natureza);
        if (menu_saindo_jogo) {
            game_end();
        } else {
            room_goto(rm_menu2);
        }
    }

    exit;
}

if (!clique_iniciado && entrada_bloqueada <= 0) {
    if (botao_hover != -1 && mouse_check_button_pressed(mb_left)) {
        clique_iniciado = true;
        menu_saida_timer = round(room_speed * 0.82);
        menu_destino = botao_room[botao_hover];
        global.menu_destino_room = menu_destino;
        global.menu_reverso = false;
        menu_saindo_jogo = menu_destino == -1;
        audio_gain_sfx(som_luz_id, 0, 950);
        audio_gain_sfx(som_natureza_id, 0, 950);
        audio_menu_fade(menu_saindo_jogo ? 0 : 0.24, 950);
        audio_play_sfx(snd_f2_botao, 4, false, 0.62, 0, 1);
        if (!menu_saindo_jogo) {
            audio_play_sfx(snd_menu_succao, 1, false, 1, 0, 1);
        }
    }
}
