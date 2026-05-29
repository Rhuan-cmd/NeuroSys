cutscene_timer++;
if (cutscene_timer >= fade_duracao) {
    if (!historia_finalizada && !ativo && !transicao_caixa) {
        var texto_atual = "";
        switch (dialogo_index) {
            case 0: texto_atual = "No grupo da turma, uma conversa comum começou a mudar de tom."; break;
            case 1: texto_atual = "Primeiro vieram indiretas. Depois perfis anônimos apareceram."; break;
            case 2: texto_atual = "Cada notificação tenta prender sua atenção e te fazer desistir de fechar a tela."; break;
            case 3: texto_atual = "Seu objetivo é simples: recuperar o controle antes que a pressão tome conta."; break;
            case 4: texto_atual = "Quando as mensagens desabarem, o botão de fechar vai fugir do cursor."; break;
            case 5: texto_atual = "Clique no X dez vezes. Se demorar demais, você perde uma vida."; break;
        }
        if (dialogo_chars < string_length(texto_atual)) {
            dialogo_chars = min(string_length(texto_atual), dialogo_chars + 0.58);
            if (keyboard_check_pressed(vk_enter)) {
                dialogo_chars = string_length(texto_atual);
            }
        } else {
            if (keyboard_check_pressed(vk_enter)) {
                dialogo_index++;
                dialogo_chars = 0;
                if (dialogo_index >= dialogo_total) {
                    historia_finalizada = true;
                    cutscene_ativo_timer = 0;
                }
            }
        }
    } else {
        cutscene_ativo_timer++;
    }
}
cascata_ativa = cutscene_ativo_timer >= tempo_ate_cascata;
if (cutscene_timer >= fade_duracao) {
    status_intro_timer++;
}
cascata_fluxo += 1.35 + (cliques + (vidas_max - vidas) * 2 + corrupt_flash * 4) * 0.13;
window_set_cursor(cr_none);
cursor_sprite = cr_none;
var cursor_destino_x = cursor_cutscene_x;
var cursor_destino_y = cursor_cutscene_y;
if (ativo || estado_final != 0) {
    cursor_destino_x = mouse_x;
    cursor_destino_y = mouse_y;
}
cursor_draw_x = lerp(cursor_draw_x, cursor_destino_x, 0.18);
cursor_draw_y = lerp(cursor_draw_y, cursor_destino_y, 0.18);

for (var fx_i = 0; fx_i < array_length(fx_timer); fx_i++) {
    if (fx_timer[fx_i] > 0) {
        fx_timer[fx_i]--;
    }
}

if (estado_final != 0) {
    final_timer++;
    if (saida_tipo != 0) {
        saida_transition = min(1, saida_transition + 0.055);
        if (saida_transition >= 1) {
            if (saida_tipo == 1) {
                game_end();
            } else {
                room_restart();
            }
        }
    } else if (!final_painel) {
        final_fade = min(1, final_fade + 0.035);
        if (final_fade >= 1 && final_timer > room_speed * 0.75) {
            final_painel = true;
        }
    } else {
        final_transition = min(1, final_transition + 0.055);
    }
    if (view_camera[0] != -1) {
        camera_set_view_pos(view_camera[0], view_base_x, view_base_y);
    }
    var final_suave_btn = final_transition * final_transition * (3 - 2 * final_transition);
    var final_offset_btn = lerp(38, 0, final_suave_btn);
    var bx_menu_1 = 312;
    var bx_menu_2 = 454;
    var bx_rein_1 = 506;
    var bx_rein_2 = 648;
    var by_1 = 375 + final_offset_btn;
    var by_2 = 411 + final_offset_btn;
    if (final_painel && mouse_check_button_pressed(mb_left)) {
        if (point_in_rectangle(mouse_x, mouse_y, bx_menu_1, by_1, bx_menu_2, by_2)) {
            saida_tipo = 1;
        }
        if (point_in_rectangle(mouse_x, mouse_y, bx_rein_1, by_1, bx_rein_2, by_2)) {
            saida_tipo = 2;
        }
    }
    if (final_painel && keyboard_check_pressed(vk_enter)) {
        saida_tipo = 1;
    }
    exit;
}

if (ativo) {
    tempo_jogo++;
}

if (transicao_caixa) {
    transicao_timer++;
    cursor_cutscene_x = lerp(cursor_cutscene_x, room_width * 0.5 + 28, 0.055);
    cursor_cutscene_y = lerp(cursor_cutscene_y, room_height * 0.5 + 24, 0.055);
    if (instance_exists(caixa)) {
        var t_intro = clamp(transicao_timer / transicao_duracao, 0, 1);
        var t_suave = t_intro * t_intro * (3 - 2 * t_intro);
        caixa.x = lerp(caixa.intro_x0, caixa.intro_x1, t_suave);
        caixa.y = lerp(caixa.intro_y0, caixa.intro_y1, t_suave);
        caixa.image_xscale = lerp(1, caixa.escala_padrao, t_suave);
        caixa.image_yscale = caixa.image_xscale;
    }
    if (transicao_timer >= transicao_duracao) {
        ativar_minigame();
    }
}

if (historia_finalizada && cutscene_timer >= fade_duracao && !ativo && !transicao_caixa) {
    cursor_troca_timer--;
    if (cursor_troca_timer <= 0 || point_distance(cursor_cutscene_x, cursor_cutscene_y, cursor_alvo_x, cursor_alvo_y) < 12) {
        novo_alvo_cursor();
    }
    
    if (!cascata_ativa) {
        cursor_cutscene_x = lerp(cursor_cutscene_x, cursor_alvo_x, 0.026);
        cursor_cutscene_y = lerp(cursor_cutscene_y, cursor_alvo_y, 0.026);
    } else {
        cursor_cutscene_x = lerp(cursor_cutscene_x, botao_fixo_x + 4, 0.075);
        cursor_cutscene_y = lerp(cursor_cutscene_y, botao_fixo_y + 4, 0.075);
        
        if (!cutscene_clickou && point_distance(cursor_cutscene_x, cursor_cutscene_y, botao_fixo_x + 4, botao_fixo_y + 4) < 5) {
            iniciar_minigame();
        }
    }
}

if (!ativo && !transicao_caixa) {
    if (false && cascata_ativa && mouse_check_button_pressed(mb_left)) {
        var tentou_fechar = point_in_rectangle(
            mouse_x,
            mouse_y,
            botao_fixo_x - 18,
            botao_fixo_y - 16,
            botao_fixo_x + 18,
            botao_fixo_y + 16
        );
        
        if (tentou_fechar) {
            ativo = true;
            timer_clique = 0;
            criar_caixa(botao_fixo_x, botao_fixo_y, false);
        }
    }
} else if (ativo) {
    if (!instance_exists(caixa)) {
        respawn_timer--;
        if (respawn_timer <= 0) {
            criar_caixa(random_range(64, room_width - 64), random_range(64, room_height - 64), true);
        }
    } else {
        if (!caixa.modo_intro) {
            timer_clique++;
        }
        
        var caixa_clicavel = !caixa.modo_intro;
        var acertou_caixa = caixa_clicavel && point_in_rectangle(mouse_x, mouse_y, caixa.bbox_left, caixa.bbox_top, caixa.bbox_right, caixa.bbox_bottom);
        
        if (mouse_check_button_pressed(mb_left) && acertou_caixa) {
            registrar_explosao(caixa.x, caixa.y);
            cliques++;
            timer_clique = 0;
            
            with (caixa) instance_destroy();
            caixa = noone;
            
            if (cliques >= cliques_necessarios) {
                finalizar_jogo(true);
            } else {
                respawn_timer = max(5, 18 - cliques);
            }
        } else if (timer_clique >= limite_clique) {
            perder_vida();
        }
    }
}

var vidas_perdidas = vidas_max - vidas;
var tremor_constante = 0;
if (ativo) {
    tremor_constante = shake_inicio + vidas_perdidas * 1.25;
}
if (ativo && vidas == 1) {
    tremor_constante = 10.5;
}

var intensidade = tremor_constante + shake_impacto;
if (view_camera[0] != -1) {
    if (intensidade > 0) {
        camera_set_view_pos(
            view_camera[0],
            view_base_x + random_range(-intensidade, intensidade),
            view_base_y + random_range(-intensidade, intensidade)
        );
    } else {
        camera_set_view_pos(view_camera[0], view_base_x, view_base_y);
    }
}

shake_impacto = max(0, shake_impacto - 1.2);
damage_flash = max(0, damage_flash - 0.035);
corrupt_flash = max(0, corrupt_flash - 0.012);
if (ativo) {
    shake_inicio = max(0.75, shake_inicio * 0.992);
} else {
    shake_inicio = 0;
}
