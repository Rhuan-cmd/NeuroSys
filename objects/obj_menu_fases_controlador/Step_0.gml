menu_timer += 1;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _side_w = 282;
app_x = 0;
app_y = 0;
app_w = _gui_w;
app_h = _gui_h;
feed_x = _side_w + 22;
feed_w = max(520, _gui_w - feed_x - 20);
feed_top = 70;
feed_bottom = _gui_h - 2;
voltar_x = _side_w * 0.5;
voltar_y = _gui_h - 66;
voltar_w = 132;
voltar_h = 66;
feed_altura = array_length(fase_nome) * (post_h + post_gap) - post_gap;
fade_entrada_branco = max(0, fade_entrada_branco - 0.035);

if (negado_timer > 0) negado_timer -= 1;

if (entrando_fase) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
    transicao_post_timer += 1;
    if (transicao_post_timer >= transicao_post_dur) {
        room_goto(fase_room[fase_escolhida]);
    }
    exit;
}

if (voltando_menu) {
    window_set_cursor(cr_none);
    cursor_sprite = cr_none;
    fade_saida_branco = min(1, fade_saida_branco + 0.065);
    if (fade_saida_branco >= 1) {
        global.menu_reverso = true;
        global.menu_destino_room = rm_menu;
        room_goto(rm_menu2);
    }
    exit;
}

var _max_scroll = max(0, feed_altura - (feed_bottom - feed_top));
if (mouse_wheel_down()) scroll_alvo = min(_max_scroll, scroll_alvo + 68);
if (mouse_wheel_up()) scroll_alvo = max(0, scroll_alvo - 68);
if (keyboard_check(vk_down)) scroll_alvo = min(_max_scroll, scroll_alvo + 8);
if (keyboard_check(vk_up)) scroll_alvo = max(0, scroll_alvo - 8);
scroll_y = lerp(scroll_y, scroll_alvo, 0.22);

hover = -1;
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var _liberada = variable_global_exists("fase_liberada") ? global.fase_liberada : 1;
voltar_hover = mx >= voltar_x - voltar_w * 0.5 && mx <= voltar_x + voltar_w * 0.5 && my >= voltar_y - voltar_h * 0.5 && my <= voltar_y + voltar_h * 0.5;

for (var i = 0; i < array_length(fase_nome); i += 1) {
    var _y = feed_top + i * (post_h + post_gap) - scroll_y;
    if (mx >= feed_x && mx <= feed_x + feed_w && my >= max(_y + 4, feed_top) && my <= min(_y + post_h - 4, feed_bottom)) {
        hover = i;
        break;
    }
}

if (hover != hover_anterior && hover != -1) {
    audio_play_sound(snd_f2_selecao, 3, false, 0.42);
}
hover_anterior = hover;

if (hover != -1 && mouse_check_button_pressed(mb_left)) {
    if (hover + 1 <= _liberada) {
        audio_play_sound(snd_f2_botao, 4, false, 0.62);
        audio_play_sound(snd_f2_aparecer, 4, false, 0.48, 0, 0.82);
        audio_menu_fade(0, 1850);
        fase_escolhida = hover;
        transicao_post_timer = 0;
        entrando_fase = true;
    } else {
        audio_play_sound(snd_f1_erro, 4, false, 0.72, 0, 0.86);
        negado_card = hover;
        negado_timer = 18;
    }
}

if (keyboard_check_pressed(vk_escape) || (voltar_hover && mouse_check_button_pressed(mb_left))) {
    audio_play_sound(snd_f2_botao, 4, false, 0.62);
    voltando_menu = true;
}
