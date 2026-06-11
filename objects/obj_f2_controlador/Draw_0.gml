// ===== CENARIO PRINCIPAL DA REDE SOCIAL =====
draw_set_font(fnt_dialogo);
var desenhar_fase = !(estado_final != 0 && final_painel);
var escala_texto_f2 = 1;
if (desenhar_fase) {
draw_sprite(spr_f2_fundo_chat, 0, 0, 0);

if (cutscene_clickou || transicao_caixa || ativo || estado_final != 0) {
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(43, 56, 84));
    draw_rectangle(50, 23, 73, 41, false);
    draw_set_color(make_color_rgb(21, 31, 51));
    draw_rectangle(53, 26, 70, 38, false);
    draw_set_color(c_white);
} else {
    draw_sprite_ext(spr_f2_fechar, 0, botao_fixo_x, botao_fixo_y, 0.78, 0.78, 0, c_white, 1);
}

// ===== CASCATA DE CONTATOS E MENSAGENS =====
var fluxo_cascata = cascata_fluxo;
var fase_entrada = cutscene_ativo_timer / room_speed;
var modo_cascata = ativo || transicao_caixa;
var contatos_visiveis = 0;
var mensagens_visiveis = 0;

if (fase_entrada >= 5.0) contatos_visiveis = 1;
if (fase_entrada >= 5.8) contatos_visiveis = 2;
if (fase_entrada >= 6.6) contatos_visiveis = 3;
if (fase_entrada >= 7.3) contatos_visiveis = 4;
if (fase_entrada >= 8.2) contatos_visiveis = 6;
if (modo_cascata) contatos_visiveis = 7;
if (fase_entrada >= 5.6) mensagens_visiveis = 1;
if (fase_entrada >= 6.8) mensagens_visiveis = 2;
if (fase_entrada >= 7.8) mensagens_visiveis = 3;
if (fase_entrada >= 8.7) mensagens_visiveis = 4;
if (modo_cascata) mensagens_visiveis = 5;

if (contatos_visiveis > 0) {
    
    for (var c = 0; c < contatos_visiveis; c++) {
        var y_contato;
        if (modo_cascata) {
            y_contato = 66 + (((78 + c * 70) + fluxo_cascata - 66) mod (7 * 70));
        } else {
            y_contato = 78 + c * 70;
        }
        var alpha_contato = 0.72;
        if ((c mod 2) == 0) {
            alpha_contato = 0.9;
        }
        
        if (y_contato >= 66 && y_contato <= 394) {
            draw_sprite_ext(
                spr_f2_contato,
                0,
                18,
                y_contato,
                1,
                1,
                0,
                c_white,
                alpha_contato
            );
            draw_set_alpha(alpha_contato);
            draw_set_font(fnt_dialogo);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_color(make_color_rgb(210, 232, 255));
            draw_text_transformed(92, y_contato + 12, "ANÔNIMO", 0.74 * escala_texto_f2, 0.74 * escala_texto_f2, 0);
            draw_set_color(make_color_rgb(118, 137, 170));
            draw_text_transformed(92, y_contato + 35, "perfil oculto", 0.66 * escala_texto_f2, 0.66 * escala_texto_f2, 0);
            draw_set_alpha(1);
            draw_set_color(c_white);
        }
    }
}

if (mensagens_visiveis > 0) {
    for (var m = 0; m < mensagens_visiveis; m++) {
        var y_msg;
        if (modo_cascata) {
            y_msg = 74 + (((88 + m * 108) + fluxo_cascata * 0.82 - 74) mod (5 * 108));
        } else {
            y_msg = 88 + m * 108;
        }
        var spr_msg = spr_f2_msg_censurada;
        var x_msg = 266;
        
        if (y_msg >= 74 && y_msg <= 350) {
            draw_sprite_ext(
                spr_msg,
                0,
                x_msg,
                y_msg,
                1,
                1,
                0,
                c_white,
                0.76
            );
            var msg_linha1 = "[censurado] não devia";
            var msg_linha2 = "### bloqueado";
            switch (m mod 5) {
                case 1:
                    msg_linha1 = "ninguém acredita";
                    msg_linha2 = "[apagado] !!!";
                    break;
                case 2:
                    msg_linha1 = "print no grupo";
                    msg_linha2 = "### [censurado]";
                    break;
                case 3:
                    msg_linha1 = "não tente fechar";
                    msg_linha2 = "notificação";
                    break;
                case 4:
                    msg_linha1 = "[anônimo] olhando";
                    msg_linha2 = "msg corrompida";
                    break;
            }
            draw_set_alpha(0.78);
            draw_set_font(fnt_dialogo);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_set_color(make_color_rgb(162, 198, 238));
            draw_text_transformed(x_msg + 58, y_msg + 12, "ANÔNIMO", 0.72 * escala_texto_f2, 0.72 * escala_texto_f2, 0);
            draw_set_color(make_color_rgb(225, 234, 255));
            draw_text_transformed(x_msg + 58, y_msg + 36, msg_linha1, 0.68 * escala_texto_f2, 0.68 * escala_texto_f2, 0);
            draw_text_transformed(x_msg + 58, y_msg + 59, msg_linha2, 0.68 * escala_texto_f2, 0.68 * escala_texto_f2, 0);
            draw_set_alpha(1);
            draw_set_color(c_white);
        }
    }
}

// ===== PAINEIS DE VIDA, SINO, TEMPO E PONTUACAO =====
var intro = clamp(status_intro_timer / 38, 0, 1);
var pulse = 1 + sin(current_time * 0.004) * 0.015;
var s_lives = lerp(0.12, pulse, intro);
var s_timer = lerp(0.12, pulse, clamp((status_intro_timer - 8) / 38, 0, 1));
var s_score = lerp(0.12, pulse, clamp((status_intro_timer - 16) / 38, 0, 1));
draw_sprite_ext(spr_f2_status_vidas, vidas, 831, 99, s_lives, s_lives, 0, c_white, intro);

var frame_tempo = 10;
if (ativo) {
    frame_tempo = floor(clamp((limite_clique_atual - timer_clique) / limite_clique_atual, 0, 1) * 10);
}
draw_sprite_ext(spr_f2_status_tempo, frame_tempo, 831, 274, s_timer, s_timer, 0, c_white, clamp((status_intro_timer - 8) / 38, 0, 1));

if (!ativo && status_intro_timer > 8) {
    draw_sprite_ext(
        spr_f2_sino,
        0,
        775,
        266,
        0.78 * s_timer,
        0.78 * s_timer,
        0,
        c_white,
        clamp((status_intro_timer - 8) / 38, 0, 1)
    );
}

if (ativo && frame_tempo > 7) {
    var sino_idle_forca = 0.8;
    draw_sprite_ext(
        spr_f2_sino,
        floor(current_time / 220) mod 4,
        775 + sin(current_time * 0.012) * sino_idle_forca,
        266 + cos(current_time * 0.014) * sino_idle_forca,
        0.78 * pulse,
        0.78 * pulse,
        sin(current_time * 0.018) * 3,
        c_white,
        1
    );
}

if (ativo && frame_tempo <= 7) {
    var sino_forca = (8 - frame_tempo) * 0.36;
    draw_sprite_ext(
        spr_f2_sino,
        floor(current_time / 80) mod 4,
        775 + sin(current_time * 0.032) * sino_forca,
        266 + cos(current_time * 0.029) * sino_forca,
        0.78 * pulse,
        0.78 * pulse,
        sin(current_time * 0.05) * 3.6 * sino_forca,
        c_white,
        1
    );
}

var _score_alpha = clamp((status_intro_timer - 16) / 38, 0, 1);
var _score_frames = max(1, sprite_get_number(spr_f2_status_pontos));
var _score_frame = floor(clamp(cliques / max(1, cliques_necessarios), 0, 1) * (_score_frames - 1));
draw_sprite_ext(spr_f2_status_pontos, _score_frame, 831, 445, s_score, s_score, 0, c_white, _score_alpha);
draw_set_alpha(_score_alpha);
draw_set_font(fnt_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed(831, 445, string(cliques) + "/" + string(cliques_necessarios), 0.58 * escala_texto_f2, 0.58 * escala_texto_f2, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

// ===== EXPLOSAO VISUAL AO CLICAR NO X =====
for (var fx_i = 0; fx_i < array_length(fx_timer); fx_i++) {
    if (fx_timer[fx_i] > 0) {
        var fx_t = 1 - fx_timer[fx_i] / 18;
        var fx_alpha = 1 - fx_t;
        var fx_raio = lerp(8, 48, fx_t);
        draw_set_alpha(fx_alpha);
        draw_set_color(make_color_rgb(255, 80, 96));
        draw_circle(fx_x[fx_i], fx_y[fx_i], fx_raio * 0.38, false);
        draw_set_color(make_color_rgb(255, 224, 116));
        for (var fx_p = 0; fx_p < 4; fx_p++) {
            var fx_dir = fx_p * 90 + fx_t * 80;
            draw_line_width(
                fx_x[fx_i] + lengthdir_x(fx_raio * 0.25, fx_dir),
                fx_y[fx_i] + lengthdir_y(fx_raio * 0.25, fx_dir),
                fx_x[fx_i] + lengthdir_x(fx_raio, fx_dir),
                fx_y[fx_i] + lengthdir_y(fx_raio, fx_dir),
                3
            );
        }
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}

// ===== CAIXA DE DIALOGO DA CUTSCENE =====
if (!historia_finalizada && cutscene_timer >= fade_duracao && !ativo && !transicao_caixa) {
    var historia_texto = "";
    var historia_titulo = "Registro do chat";
    switch (dialogo_index) {
        case 0:
            historia_texto = "No grupo da turma, uma conversa comum começou a mudar de tom.";
            historia_titulo = "Antes da sobrecarga";
            break;
        case 1:
            historia_texto = "Primeiro vieram indiretas. Depois perfis anônimos apareceram.";
            historia_titulo = "Perfis anônimos";
            break;
        case 2:
            historia_texto = "Cada notificação tenta prender sua atenção e te fazer desistir de fechar a tela.";
            historia_titulo = "A armadilha";
            break;
        case 3:
            historia_texto = "Seu objetivo é simples: recuperar o controle antes que a pressão tome conta.";
            historia_titulo = "Objetivo";
            break;
        case 4:
            historia_texto = "Quando as mensagens desabarem, o botão de fechar vai fugir do cursor.";
            historia_titulo = "O botão";
            break;
        default:
            historia_texto = "Clique no X quatorze vezes. Se demorar demais, você perde uma vida.";
            historia_titulo = "Assuma o controle";
            break;
    }
    
    var h_abre = clamp((cutscene_timer - fade_duracao) / 24, 0, 1) * (1 - dialogo_saida);
    var h_suave = h_abre * h_abre * (3 - 2 * h_abre);
    var h_x1 = lerp(room_width / 2, 206, h_suave);
    var h_x2 = lerp(room_width / 2, 754, h_suave);
    var h_y1 = lerp(420, 348, h_suave);
    var h_y2 = lerp(420, 492, h_suave);
    var chars_visiveis = min(string_length(historia_texto), floor(dialogo_chars));
    var texto_visivel = string_copy(historia_texto, 1, chars_visiveis);
    var completo = chars_visiveis >= string_length(historia_texto);
    var h_alpha = 1 - dialogo_saida;
    
    draw_set_alpha(0.84 * h_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(0.96 * h_alpha);
    draw_set_color(make_color_rgb(9, 16, 30));
    draw_rectangle(h_x1, h_y1, h_x2, h_y2, false);
    draw_set_color(make_color_rgb(42, 211, 238));
    draw_rectangle(h_x1 + 6, h_y1 + 6, h_x2 - 6, h_y1 + 10, false);
    draw_set_color(make_color_rgb(43, 58, 88));
    draw_rectangle(h_x1 + 12, h_y2 - 22, h_x2 - 12, h_y2 - 18, false);
    
    draw_set_alpha(h_suave * h_alpha);
    draw_set_font(fnt_dialogo);
    draw_set_color(make_color_rgb(115, 230, 255));
    draw_text_transformed(h_x1 + 26, h_y1 + 22, historia_titulo, escala_texto_f2, escala_texto_f2, 0);
    draw_set_color(c_white);
    draw_text_ext_transformed(h_x1 + 26, h_y1 + 58, texto_visivel, 26, h_x2 - h_x1 - 52, escala_texto_f2, escala_texto_f2, 0);
    
    if (completo) {
        var enter_alpha = 0.45 + sin(current_time * 0.008) * 0.35;
        draw_set_alpha(enter_alpha * h_alpha);
        draw_set_color(make_color_rgb(255, 232, 122));
        draw_set_halign(fa_right);
        draw_text_transformed(h_x2 - 24, h_y2 - 48, "ENTER", escala_texto_f2, escala_texto_f2, 0);
        draw_set_halign(fa_left);
    }
    draw_set_alpha(1);
    draw_set_color(c_white);
}

// ===== AVISO DE INICIO DO MINIGAME =====
if (aviso_x_timer > 0 && estado_final == 0) {
    var aviso_t = 1 - aviso_x_timer / aviso_x_duracao;
    var aviso_alpha = min(clamp(aviso_t / 0.22, 0, 1), clamp((1 - aviso_t) / 0.34, 0, 1));
    var aviso_escala = lerp(0.82, 1.08, clamp(aviso_t / 0.28, 0, 1));
    draw_set_alpha(aviso_alpha * 0.62);
    draw_set_color(c_black);
    draw_rectangle(0, room_height / 2 - 54, room_width, room_height / 2 + 54, false);
    draw_set_alpha(aviso_alpha);
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(make_color_rgb(255, 228, 132));
    draw_text_transformed(room_width / 2, room_height / 2, "PEGUE O X...", aviso_escala * 1.6 * escala_texto_f2, aviso_escala * 1.6 * escala_texto_f2, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// ===== FADE-IN E TITULO DA FASE =====
var fade_alpha = max(0, 1 - cutscene_timer / fade_duracao);
if (fade_alpha > 0) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    var titulo_t = clamp(cutscene_timer / fade_duracao, 0, 1);
    var titulo_alpha = sin(titulo_t * pi);
    var titulo_escala = lerp(0.82, 1.12, titulo_t);
    draw_set_alpha(titulo_alpha);
    draw_set_color(c_white);
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(room_width / 2, room_height / 2 - 28, "FASE 2", titulo_escala * 1.8 * escala_texto_f2, titulo_escala * 1.8 * escala_texto_f2, 0);
    draw_text_transformed(room_width / 2, room_height / 2 + 18, "CHAT EM SOBRECARGA", 1.1 * escala_texto_f2, 1.1 * escala_texto_f2, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

draw_set_alpha(1);
draw_set_color(c_white);

// ===== CORRUPCAO VISUAL APOS PERDER VIDAS =====
var vidas_perdidas_fx = vidas_max - vidas;
if (damage_flash > 0 || vidas_perdidas_fx > 0) {
    var ruido_forca = clamp(vidas_perdidas_fx / vidas_max + corrupt_flash * 0.8, 0, 1);
    desenhar_corrupcao_otimizada(ruido_forca, damage_flash);
    draw_set_alpha(damage_flash * 0.55);
    draw_set_color(c_red);
    draw_rectangle(0, 0, room_width, 14, false);
    draw_rectangle(0, room_height - 14, room_width, room_height, false);
    draw_rectangle(0, 0, 14, room_height, false);
    draw_rectangle(room_width - 14, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
}

// ===== TELA FINAL DE VITORIA OU DERROTA =====
if (estado_final != 0) {
    var final_suave = final_transition * final_transition * (3 - 2 * final_transition);
    var final_offset = lerp(38, 0, final_suave);
    var final_pop = 1 + sin(final_suave * pi) * 0.055;
    draw_set_alpha(max(final_fade, 0.72 * final_suave));
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    
    if (!final_painel) {
        draw_set_alpha(1);
        draw_set_color(c_white);
        exit;
    }
    
    draw_set_alpha(0.22 * final_suave);
    draw_set_color(final_vitoria ? make_color_rgb(34, 211, 238) : make_color_rgb(255, 67, 88));
    for (var scan = 0; scan < room_height; scan += 22) {
        draw_rectangle(0, scan + final_offset * 0.25, room_width, scan + 2 + final_offset * 0.25, false);
    }
    draw_set_alpha(final_suave);
    draw_sprite_ext(
        spr_f2_painel_resultado,
        final_vitoria ? 0 : 1,
        room_width / 2,
        room_height / 2 + final_offset,
        lerp(0.84, 1, final_suave) * final_pop,
        lerp(0.84, 1, final_suave) * final_pop,
        0,
        c_white,
        final_suave
    );
    
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_alpha(final_suave);
    draw_set_color(c_white);
    
    var segundos = max(0, floor(tempo_final / room_speed));
    var minutos = floor(segundos / 60);
    var segundos_resto = segundos mod 60;
    var segundos_txt = string(segundos_resto);
    if (segundos_resto < 10) segundos_txt = "0" + segundos_txt;
    var tempo_txt_resultado = string(minutos) + ":" + segundos_txt;
    var hover_menu = point_in_rectangle(mouse_x, mouse_y, 312, 375 + final_offset, 454, 411 + final_offset);
    var hover_reiniciar = point_in_rectangle(mouse_x, mouse_y, 506, 375 + final_offset, 648, 411 + final_offset);
    draw_set_halign(fa_center);
    draw_set_color(final_vitoria ? make_color_rgb(91, 238, 255) : make_color_rgb(255, 92, 112));
    draw_text_transformed(room_width / 2, 142 + final_offset, final_vitoria ? "CONEXÃO RETOMADA" : "SOBRECARGA SOCIAL", 1.12 * escala_texto_f2, 1.12 * escala_texto_f2, 0);
    draw_set_color(make_color_rgb(144, 163, 196));
    draw_text_transformed(room_width / 2, 158 + final_offset, final_vitoria ? "controle do chat recuperado" : "mensagens no limite", escala_texto_f2, escala_texto_f2, 0);
    
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(116, 231, 255));
    draw_text_transformed(286, 238 + final_offset, "TEMPO", 0.92 * escala_texto_f2, 0.92 * escala_texto_f2, 0);
    draw_text_transformed(286, 282 + final_offset, "ACERTOS", 0.92 * escala_texto_f2, 0.92 * escala_texto_f2, 0);
    draw_text_transformed(286, 326 + final_offset, "VIDAS", 0.92 * escala_texto_f2, 0.92 * escala_texto_f2, 0);
    draw_set_halign(fa_center);
    draw_text_transformed(606, 214 + final_offset, "NOTA", escala_texto_f2, escala_texto_f2, 0);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_transformed(396, 238 + final_offset, tempo_txt_resultado, 1.05 * escala_texto_f2, 1.05 * escala_texto_f2, 0);
    draw_text_transformed(396, 282 + final_offset, string(cliques) + "/" + string(cliques_necessarios), 1.05 * escala_texto_f2, 1.05 * escala_texto_f2, 0);
    draw_text_transformed(396, 326 + final_offset, string(vidas_final) + "/" + string(vidas_max), 1.05 * escala_texto_f2, 1.05 * escala_texto_f2, 0);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(606, 284 + final_offset, nota_final, 1.22 * escala_texto_f2, 1.22 * escala_texto_f2, 0);
    draw_set_valign(fa_top);
    
    draw_set_alpha(final_suave * (hover_menu ? 0.34 : 0));
    draw_set_color(make_color_rgb(54, 222, 246));
    draw_rectangle(312, 375 + final_offset, 454, 411 + final_offset, false);
    draw_set_alpha(final_suave * (hover_reiniciar ? 0.34 : 0));
    draw_rectangle(506, 375 + final_offset, 648, 411 + final_offset, false);
    draw_set_alpha(final_suave);
    
    draw_set_halign(fa_center);
    draw_set_color(hover_menu ? make_color_rgb(255, 246, 152) : c_white);
    draw_text_transformed(383, 384 + final_offset, "MENU", (hover_menu ? 1.08 : 1.0) * escala_texto_f2, (hover_menu ? 1.08 : 1.0) * escala_texto_f2, 0);
    draw_set_color(hover_reiniciar ? make_color_rgb(255, 246, 152) : c_white);
    draw_text_transformed(577, 384 + final_offset, "REINICIAR", (hover_reiniciar ? 1.0 : 0.92) * escala_texto_f2, (hover_reiniciar ? 1.0 : 0.92) * escala_texto_f2, 0);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_set_alpha(1);
    
    if (saida_tipo != 0) {
        draw_set_alpha(saida_transition);
        draw_set_color(c_black);
        draw_rectangle(0, 0, room_width, room_height, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}
