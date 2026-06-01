draw_set_font(fnt_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);

// ===== HUD DO MINIJOGO =====
if (estado == 2) {
    var _pulse = 1 + sin(visual_timer * 0.14) * 0.018;
    // Cada informacao usa um sprite proprio da fase 1, integrado ao CONECTA.
    draw_sprite_ext(spr_f1_status_lives, 0, 756, 204, 0.72 * _pulse, 0.72 * _pulse, 0, c_white, 1);
    draw_sprite_ext(spr_f1_status_timer, 0, 756, 276, 0.72 * _pulse, 0.72 * _pulse, 0, c_white, 1);
    draw_sprite_ext(spr_f1_status_progress, 0, 756, 348, 0.72 * _pulse, 0.72 * _pulse, 0, c_white, 1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_halign(fa_right);
    draw_text_transformed(818, 207, string(vidas) + "/" + string(vidas_max), 0.88 * _pulse, 0.88 * _pulse, 0);
    draw_text_transformed(818, 279, string(ceil(tempo / room_speed)) + "s", 0.88 * _pulse, 0.88 * _pulse, 0);
    draw_text_transformed(818, 351, string(ataques_cortados) + "/" + string(objetivo), 0.88 * _pulse, 0.88 * _pulse, 0);
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(120, 232, 250));
    draw_text_transformed(761, 392, "COMBO  x" + string(combo), _pulse, _pulse, 0);
    draw_set_halign(fa_left);

    // Conteúdo da aba de objetivo integrada ao fundo do CONECTA.
    draw_set_color(make_color_rgb(120, 232, 250));
    draw_text_transformed(112, 399, "OBJETIVO", 0.72, 0.72, 0);
    draw_set_color(c_white);
    draw_text_transformed(112, 423, "ATAQUES: " + string(ataques_cortados) + "/" + string(objetivo), 0.72, 0.72, 0);
    draw_set_color(make_color_rgb(158, 220, 239));
    draw_text_transformed(112, 447, "TEMPO: " + string(ceil(tempo / room_speed)) + "s", 0.72, 0.72, 0);
    if (escudo > 0) {
        draw_set_alpha(0.24 + sin(visual_timer * 0.2) * 0.08);
        draw_set_color(make_color_rgb(87, 226, 255));
        draw_circle(756, 204, 52, true);
        draw_set_alpha(1);
    }
}

// ===== FLASHES DE FEEDBACK =====
var _corrupcao = estado == 2 ? (vidas_max - vidas) / vidas_max : 0;
if (_corrupcao > 0 || corrupt_flash > 0) {
    var _ruido = clamp(_corrupcao + corrupt_flash * 0.72, 0, 1);
    draw_set_alpha(0.045 + _ruido * 0.08);
    draw_set_color(make_color_rgb(255, 37, 89));
    draw_rectangle(0, 0, room_width, room_height, false);
    for (var _linha_glitch = 0; _linha_glitch < 4 + floor(_ruido * 13); _linha_glitch++) {
        var _glitch_y = irandom(room_height);
        var _glitch_x = irandom_range(-28, 28);
        draw_set_alpha(random_range(0.04, 0.12) + _ruido * 0.11);
        draw_set_color(choose(make_color_rgb(255, 49, 93), make_color_rgb(66, 224, 255)));
        draw_rectangle(_glitch_x, _glitch_y, room_width + _glitch_x, _glitch_y + irandom_range(1, 3), false);
    }
}
if (damage_flash > 0) {
    draw_set_alpha(damage_flash * 0.34);
    draw_set_color(make_color_rgb(255, 49, 83));
    draw_rectangle(0, 0, room_width, room_height, false);
}
if (bonus_flash > 0) {
    draw_set_alpha(bonus_flash * 0.22);
    draw_set_color(make_color_rgb(67, 225, 255));
    draw_rectangle(0, 0, room_width, room_height, false);
}
draw_set_alpha(1);

// ===== DIÁLOGO DA CUTSCENE, IGUAL À FASE 2 =====
if (estado == 0 && cutscene_timer >= fade_duracao) {
    var _texto = dialogo_textos[dialogo_index];
    var _titulo = dialogo_titulos[dialogo_index];
    var _abre = clamp((cutscene_timer - fade_duracao) / 24, 0, 1) * (1 - dialogo_saida);
    var _suave = _abre * _abre * (3 - 2 * _abre);
    var _painel_x1 = lerp(188, 104, dialogo_layout);
    var _painel_x2 = lerp(772, 540, dialogo_layout);
    var _painel_y1 = lerp(344, 118, dialogo_layout);
    var _painel_y2 = lerp(492, 270, dialogo_layout);
    var _x1 = lerp(room_width / 2, _painel_x1, _suave);
    var _x2 = lerp(room_width / 2, _painel_x2, _suave);
    var _y1 = lerp(430, _painel_y1, _suave);
    var _y2 = lerp(430, _painel_y2, _suave);
    var _visivel = string_copy(_texto, 1, min(string_length(_texto), floor(dialogo_chars)));
    var _completo = dialogo_chars >= string_length(_texto);
    draw_set_alpha(0.76 * (1 - dialogo_saida));
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(0.97 * (1 - dialogo_saida));
    draw_set_color(make_color_rgb(8, 17, 32));
    draw_rectangle(_x1, _y1, _x2, _y2, false);
    draw_set_color(make_color_rgb(43, 211, 238));
    draw_rectangle(_x1 + 6, _y1 + 6, _x2 - 6, _y1 + 10, false);
    draw_set_alpha(_suave * (1 - dialogo_saida));
    draw_set_color(make_color_rgb(116, 231, 255));
    draw_text(_x1 + 24, _y1 + 22, _titulo);
    draw_set_color(c_white);
    draw_text_ext(_x1 + 24, _y1 + 58, _visivel, dialogo_layout > 0.5 ? 20 : 24, _x2 - _x1 - 48);
    if (_completo) {
        draw_set_alpha((0.48 + sin(visual_timer * 0.18) * 0.34) * (1 - dialogo_saida));
        draw_set_halign(fa_right);
        draw_set_color(make_color_rgb(255, 230, 118));
        draw_text(_x2 - 22, _y2 - 38, "ENTER");
        draw_set_halign(fa_left);
    }
}

// ===== AVISO DE OBJETIVO, NO MESMO RITMO DA FASE 2 =====
if (estado == 1) {
    var _t = clamp(objetivo_timer / objetivo_duracao, 0, 1);
    var _saida = 1 - objetivo_saida_alpha;
    var _entrada = clamp(_t / 0.24, 0, 1);
    var _pop = lerp(0.86, 1.08, _entrada);
    draw_set_alpha(0.68 * _entrada * _saida);
    draw_set_color(c_black);
    draw_rectangle(0, 208, room_width, 332, false);
    draw_set_alpha(_entrada * _saida);
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(255, 226, 128));
    draw_text_transformed(480, 236, "PROTEJA A POSTAGEM", 1.42 * _pop, 1.42 * _pop, 0);
    draw_set_color(make_color_rgb(164, 229, 245));
    draw_text_transformed(480, 282, "CORTE 26 ATAQUES  |  NOVAS SITUAÇÕES APARECEM AOS POUCOS", 0.9, 0.9, 0);
    draw_set_color(make_color_rgb(255, 224, 123));
    draw_text_transformed(480, 310, "ENTER OU CLIQUE", 0.78, 0.78, 0);
    draw_set_halign(fa_left);
}

// ===== RESULTADO NO ESTILO DA FASE 2 =====
if (estado == 3 || estado == 4) {
    var _final_suave = final_transition * final_transition * (3 - 2 * final_transition);
    var _final_offset = lerp(38, 0, _final_suave);
    var _final_pop = 1 + sin(_final_suave * pi) * 0.055;
    draw_set_alpha(max(final_fade, 0.72 * _final_suave));
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    if (!final_painel) {
        draw_set_alpha(1);
        exit;
    }
    draw_set_alpha(0.22 * _final_suave);
    draw_set_color(final_vitoria ? make_color_rgb(34, 211, 238) : make_color_rgb(255, 67, 88));
    for (var _scan = 0; _scan < room_height; _scan += 22) {
        draw_rectangle(0, _scan + _final_offset * 0.25, room_width, _scan + 2 + _final_offset * 0.25, false);
    }
    draw_set_alpha(_final_suave);
    draw_sprite_ext(spr_f2_end_panel, final_vitoria ? 0 : 1, 480, 270 + _final_offset, _final_pop, _final_pop, 0, c_white, _final_suave);

    var _segundos = max(0, floor(tempo_final / room_speed));
    var _minutos = floor(_segundos / 60);
    var _resto = _segundos mod 60;
    var _tempo_txt = string(_minutos) + ":" + (_resto < 10 ? "0" : "") + string(_resto);
    var _hover_acao = point_in_rectangle(mouse_x, mouse_y, 312, 375 + _final_offset, 454, 411 + _final_offset);
    var _hover_reiniciar = point_in_rectangle(mouse_x, mouse_y, 506, 375 + _final_offset, 648, 411 + _final_offset);

    draw_set_alpha(_final_suave);
    draw_set_halign(fa_center);
    draw_set_color(final_vitoria ? make_color_rgb(91, 238, 255) : make_color_rgb(255, 92, 112));
    draw_text_transformed(480, 142 + _final_offset, final_vitoria ? "POSTAGEM PROTEGIDA" : "PRESSÃO DIGITAL", 1.12, 1.12, 0);
    draw_set_color(make_color_rgb(144, 163, 196));
    draw_text(480, 164 + _final_offset, final_vitoria ? "ataques contidos com responsabilidade" : "a rede precisa de uma nova tentativa");
    draw_set_halign(fa_center);
    draw_set_color(make_color_rgb(116, 231, 255));
    draw_text(344, 242 + _final_offset, "TEMPO  " + _tempo_txt);
    draw_text(334, 282 + _final_offset, "ATAQUES  " + string(ataques_cortados) + "/" + string(objetivo));
    draw_text(330, 344 + _final_offset, "VIDAS  " + string(vidas_final) + "/" + string(vidas_max));
    draw_set_color(make_color_rgb(116, 231, 255));
    draw_text(606, 214 + _final_offset, "NOTA");
    draw_set_color(c_white);
    draw_text_transformed(606, 264 + _final_offset, nota_final, 1.8, 1.8, 0);

    draw_set_alpha(_final_suave * (_hover_acao ? 0.34 : 0));
    draw_set_color(make_color_rgb(54, 222, 246));
    draw_rectangle(312, 375 + _final_offset, 454, 411 + _final_offset, false);
    draw_set_alpha(_final_suave * (_hover_reiniciar ? 0.34 : 0));
    draw_rectangle(506, 375 + _final_offset, 648, 411 + _final_offset, false);
    draw_set_alpha(_final_suave);
    draw_set_color(_hover_acao ? make_color_rgb(255, 246, 152) : c_white);
    draw_text(383, 384 + _final_offset, "MENU");
    draw_set_color(_hover_reiniciar ? make_color_rgb(255, 246, 152) : c_white);
    draw_text(577, 384 + _final_offset, "REINICIAR");
    draw_set_halign(fa_left);

    if (saida_tipo != 0) {
        draw_set_alpha(saida_transition);
        draw_set_color(c_black);
        draw_rectangle(0, 0, room_width, room_height, false);
    }
}

// ===== FADE E TÍTULO DA FASE =====
var _fade = max(0, 1 - cutscene_timer / fade_duracao);
if (_fade > 0) {
    var _tt = clamp(cutscene_timer / fade_duracao, 0, 1);
    draw_set_alpha(_fade);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(sin(_tt * pi));
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text_transformed(room_width / 2, room_height / 2 - 28, "FASE 1", 1.9, 1.9, 0);
    draw_set_color(make_color_rgb(112, 230, 250));
    draw_text_transformed(room_width / 2, room_height / 2 + 18, "FILTRO DE RESPEITO", 1.12, 1.12, 0);
    draw_set_halign(fa_left);
}

// ===== MESMO CURSOR DA FASE 2 =====
draw_set_alpha(1);
var _cursor_pulso = 1 + sin(visual_timer * 0.18) * 0.035;
if (cursor_click_fx > 0 && estado == 0) {
    draw_set_alpha(cursor_click_fx / 34 * 0.5);
    draw_set_color(make_color_rgb(96, 228, 255));
    draw_circle(cursor_draw_x + 7, cursor_draw_y + 9, lerp(30, 8, cursor_click_fx / 34), true);
}
draw_set_alpha(1);
draw_sprite_ext(spr_f2_cursor, 0, cursor_draw_x, cursor_draw_y, _cursor_pulso, _cursor_pulso, 0, c_white, 1);
draw_set_color(c_white);
