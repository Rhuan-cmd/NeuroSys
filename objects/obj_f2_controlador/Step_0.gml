cutscene_timer++;
// ===== CUTSCENE E AVANCO DOS DIALOGOS =====
if (cutscene_timer >= fade_duracao) {
    if (!historia_finalizada && !ativo && !transicao_caixa) {
        if (dialogo_encerrando) {
            dialogo_saida = min(1, dialogo_saida + 0.06);
            if (dialogo_saida >= 1) {
                historia_finalizada = true;
                cutscene_ativo_timer = 0;
            }
        } else {
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
            digitacao_audio_timer--;
            if (digitacao_audio_timer <= 0) {
                audio_play_sound(snd_f2_digitacao, 1, false, 0.2, 0, random_range(0.94, 1.08));
                digitacao_audio_timer = 4;
            }
            if (keyboard_check_pressed(vk_enter)) {
                audio_play_sound(snd_f2_confirmar, 3, false, 0.46);
                dialogo_chars = string_length(texto_atual);
            }
        } else {
            if (keyboard_check_pressed(vk_enter)) {
                audio_play_sound(snd_f2_confirmar, 3, false, 0.54);
                dialogo_index++;
                dialogo_chars = 0;
                if (dialogo_index >= dialogo_total) {
                    dialogo_encerrando = true;
                }
            }
        }
        }
    } else {
        cutscene_ativo_timer++;
    }
}
// ===== ENTRADA ANIMADA DOS PAINEIS DE STATUS =====
cascata_ativa = cutscene_ativo_timer >= tempo_ate_cascata;
if (cutscene_timer >= fade_duracao) {
    status_intro_timer++;
}
if (status_intro_timer >= 1 && aparicao_audio_etapa == 0) {
    audio_play_sound(snd_f2_aparecer, 2, false, 0.34);
    aparicao_audio_etapa = 1;
}
if (status_intro_timer >= 9 && aparicao_audio_etapa == 1) {
    audio_play_sound(snd_f2_aparecer, 2, false, 0.4, 0, 1.04);
    aparicao_audio_etapa = 2;
}
if (status_intro_timer >= 17 && aparicao_audio_etapa == 2) {
    audio_play_sound(snd_f2_aparecer, 2, false, 0.46, 0, 1.08);
    aparicao_audio_etapa = 3;
}
// ===== VELOCIDADE PROGRESSIVA DA CASCATA =====
if (estado_final == 0) {
    cascata_fluxo += 1.35 + (cliques + (vidas_max - vidas) * 2 + corrupt_flash * 4) * 0.13;
}
// ===== LOOPS DE AUDIO AMBIENTE, CORRUPCAO E TREMOR =====
window_set_cursor(global.perf_overlay_ativo ? cr_default : cr_none);
cursor_sprite = cr_none;
audio_mix_timer--;
if (estado_final == 0 && audio_mix_timer <= 0) {
    var audio_corrupcao = clamp((vidas_max - vidas) / vidas_max + corrupt_flash * 0.35, 0, 1);
    var audio_chiado = clamp((vidas_max - vidas) / vidas_max + corrupt_flash * 0.8, 0, 1);
    var audio_tremor = clamp(shake_inicio * 0.08 + (vidas_max - vidas) * 0.16 + shake_impacto * 0.008, 0, 1);
    if (ambiente_audio == -1 || !audio_is_playing(ambiente_audio)) {
        ambiente_audio = audio_play_sound(snd_f2_ambiente, 2, true, 0.62);
    }
    audio_sound_gain(ambiente_audio, 0.62 * (1 - audio_corrupcao * 0.54), 120);

    if (ativo && audio_corrupcao > 0) {
        if (ambiente_corrupto_audio == -1 || !audio_is_playing(ambiente_corrupto_audio)) {
            ambiente_corrupto_audio = audio_play_sound(snd_f2_ambiente_corrupto, 2, true, 0.08);
        }
        audio_sound_gain(ambiente_corrupto_audio, min(0.96, 0.22 + 0.92 * audio_corrupcao), 120);
    } else if (ambiente_corrupto_audio != -1 && audio_is_playing(ambiente_corrupto_audio)) {
        audio_sound_gain(ambiente_corrupto_audio, 0, 120);
    }

    if (ativo && audio_chiado > 0) {
        if (chiado_audio == -1 || !audio_is_playing(chiado_audio)) {
            chiado_audio = audio_play_sound(snd_f2_chiado, 3, true, 0.16);
        }
        audio_sound_gain(chiado_audio, 0.18 + 0.62 * audio_chiado, 100);
    } else if (chiado_audio != -1 && audio_is_playing(chiado_audio)) {
        audio_sound_gain(chiado_audio, 0, 100);
    }

    if (ativo && (vidas_max - vidas) > 0) {
        if (tremor_audio == -1 || !audio_is_playing(tremor_audio)) {
            tremor_audio = audio_play_sound(snd_f2_tremor_loop, 3, true, 0.2);
        }
        audio_sound_gain(tremor_audio, 0.22 + 0.58 * audio_tremor, 100);
    } else if (tremor_audio != -1 && audio_is_playing(tremor_audio)) {
        audio_sound_gain(tremor_audio, 0, 100);
    }
    audio_mix_timer = 8;
}
if (ativo && mouse_check_button_pressed(mb_left)) {
    audio_play_sound(snd_f2_clique, 2, false, 0.34);
}
if (aviso_x_timer > 0) {
    aviso_x_timer--;
}
// ===== SONS INDIVIDUAIS DE CONTATOS E MENSAGENS =====
if (estado_final == 0) {
    var notif_fase = cutscene_ativo_timer / room_speed;
    var notif_contatos = 0;
    var notif_mensagens = 0;
    if (notif_fase >= 5.0) notif_contatos = 1;
    if (notif_fase >= 5.8) notif_contatos = 2;
    if (notif_fase >= 6.6) notif_contatos = 3;
    if (notif_fase >= 7.3) notif_contatos = 4;
    if (notif_fase >= 8.2) notif_contatos = 6;
    if (notif_fase >= 5.6) notif_mensagens = 1;
    if (notif_fase >= 6.8) notif_mensagens = 2;
    if (notif_fase >= 7.8) notif_mensagens = 3;
    if (notif_fase >= 8.7) notif_mensagens = 4;
    if (ativo || transicao_caixa) {
        notif_contatos = 10;
        notif_mensagens = 8;
    }
    if (notif_contatos > notificacao_contatos_anteriores) {
        notificacao_fila += notif_contatos - notificacao_contatos_anteriores;
    }
    if (notif_mensagens > notificacao_mensagens_anteriores) {
        notificacao_fila += notif_mensagens - notificacao_mensagens_anteriores;
    }
    notificacao_contatos_anteriores = notif_contatos;
    notificacao_mensagens_anteriores = notif_mensagens;

    if (ativo || transicao_caixa) {
        var notif_contato_ciclo_atual = floor(cascata_fluxo / 70);
        var notif_mensagem_ciclo_atual = floor(cascata_fluxo * 0.82 / 108);
        if (notif_contato_ciclo_atual > notificacao_contato_ciclo) {
            notificacao_fila += notif_contato_ciclo_atual - notificacao_contato_ciclo;
        }
        if (notif_mensagem_ciclo_atual > notificacao_mensagem_ciclo) {
            notificacao_fila += notif_mensagem_ciclo_atual - notificacao_mensagem_ciclo;
        }
        notificacao_contato_ciclo = notif_contato_ciclo_atual;
        notificacao_mensagem_ciclo = notif_mensagem_ciclo_atual;
    }

    notificacao_audio_timer--;
    if (notificacao_fila > 0 && notificacao_audio_timer <= 0) {
        audio_play_sound(snd_f2_notificacao, 1, false, ativo ? 0.17 : 0.26, 0, random_range(0.94, 1.08));
        notificacao_fila--;
        notificacao_audio_timer = ativo ? 4 : 6;
    }
}
// ===== POSICAO DO CURSOR CUSTOMIZADO =====
var cursor_destino_x = cursor_cutscene_x;
var cursor_destino_y = cursor_cutscene_y;
if (ativo || estado_final != 0) {
    cursor_draw_x = mouse_x;
    cursor_draw_y = mouse_y;
} else {
    cursor_draw_x = lerp(cursor_draw_x, cursor_destino_x, 0.18);
    cursor_draw_y = lerp(cursor_draw_y, cursor_destino_y, 0.18);
}

// ===== ATUALIZACAO DAS PARTICULAS DE EXPLOSAO =====
for (var fx_i = 0; fx_i < array_length(fx_timer); fx_i++) {
    if (fx_timer[fx_i] > 0) {
        fx_timer[fx_i]--;
    }
}

// ===== TELA DE RESULTADO, BOTOES E SAIDA =====
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
    if (final_painel && !final_limpeza_feita) {
        audio_stop_sound(snd_f2_chiado);
        audio_stop_sound(snd_f2_tremor_loop);
        final_limpeza_feita = true;
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
    var hover_menu_atual = final_painel && point_in_rectangle(mouse_x, mouse_y, bx_menu_1, by_1, bx_menu_2, by_2);
    var hover_reiniciar_atual = final_painel && point_in_rectangle(mouse_x, mouse_y, bx_rein_1, by_1, bx_rein_2, by_2);
    if ((hover_menu_atual && !hover_menu_anterior) || (hover_reiniciar_atual && !hover_reiniciar_anterior)) {
        audio_play_sound(snd_f2_selecao, 3, false, 0.42);
    }
    hover_menu_anterior = hover_menu_atual;
    hover_reiniciar_anterior = hover_reiniciar_atual;
    if (final_painel && mouse_check_button_pressed(mb_left)) {
        if (point_in_rectangle(mouse_x, mouse_y, bx_menu_1, by_1, bx_menu_2, by_2)) {
            audio_play_sound(snd_f2_botao, 4, false, 0.62);
            saida_tipo = 1;
        }
        if (point_in_rectangle(mouse_x, mouse_y, bx_rein_1, by_1, bx_rein_2, by_2)) {
            audio_play_sound(snd_f2_botao, 4, false, 0.62);
            saida_tipo = 2;
        }
    }
    if (final_painel && keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_f2_confirmar, 3, false, 0.54);
        audio_play_sound(snd_f2_botao, 4, false, 0.62);
        saida_tipo = 1;
    }
    exit;
}

// ===== CONTAGEM REGRESSIVA, SINO E PODERES DO X =====
if (ativo) {
    tempo_jogo++;
    poder_cooldown--;
    if (poder_ataque_timer > 0) {
        poder_ataque_x1 = mouse_x;
        poder_ataque_y1 = mouse_y;
        poder_ataque_timer--;
        if (poder_ataque_timer <= 0) {
            if (poder_ataque_tipo == 1) {
                congelar_cursor();
            } else if (poder_ataque_tipo == 2) {
                repelir_cursor();
            }
            poder_ataque_tipo = 0;
        }
    }
    if (congelado_timer > 0) {
        congelado_timer--;
        window_mouse_set(gelo_x, gelo_y);
        cursor_draw_x = gelo_x;
        cursor_draw_y = gelo_y;
        if (congelado_timer <= 0) {
            gelo_quebra_timer = 18;
            audio_play_sound(snd_f2_gelo_quebra, 4, false, 0.78);
        }
    } else if (poder_ataque_timer <= 0 && instance_exists(caixa) && !caixa.modo_intro && poder_cooldown <= 0 && cliques >= 6) {
        var usar_repulsao = cliques >= 8 && irandom(2) == 2;
        if (usar_repulsao) {
            iniciar_ataque_cursor(2);
        } else {
            iniciar_ataque_cursor(1);
        }
        poder_cooldown = irandom_range(room_speed * 4, room_speed * 6);
    }
    if (gelo_quebra_timer > 0) {
        gelo_quebra_timer--;
    }
    if (repel_fx_timer > 0) {
        repel_fx_timer--;
    }
    if (instance_exists(caixa)) {
    sino_audio_timer--;
    if (sino_audio_timer <= 0) {
        var sino_segundos = max(0, ceil((limite_clique_atual - timer_clique) / room_speed));
        var sino_intervalo = room_speed * 0.82;
        var sino_volume = 0.28;
        var sino_pitch = 0.92;
        if (sino_segundos <= 7) {
            sino_intervalo = room_speed * 0.56;
            sino_volume = 0.42;
            sino_pitch = 1.02;
        }
        if (sino_segundos <= 3) {
            sino_intervalo = room_speed * 0.28;
            sino_volume = 0.64;
            sino_pitch = 1.16;
        }
        audio_play_sound(snd_f2_sino, 2, false, sino_volume, 0, sino_pitch);
        sino_audio_timer = max(5, sino_intervalo);
    }
    }
}

// ===== TRANSICAO DO X FIXO PARA O CENTRO DA TELA =====
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

// ===== MOVIMENTO AUTOMATICO DO CURSOR NA CUTSCENE =====
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

// ===== CLIQUES, REAPARECIMENTO E PERDA DE VIDA =====
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
        timer_clique++;
        
        var caixa_clicavel = !caixa.modo_intro && caixa.imortal_timer <= 0 && congelado_timer <= 0;
        var acertou_caixa = caixa_clicavel && point_in_rectangle(mouse_x, mouse_y, caixa.bbox_left - 12, caixa.bbox_top - 12, caixa.bbox_right + 12, caixa.bbox_bottom + 12);
        
        if (mouse_check_button_pressed(mb_left) && acertou_caixa) {
            registrar_explosao(caixa.x, caixa.y);
            audio_play_sound(snd_f2_acerto_x, 2, false, 0.62, 0, random_range(0.96, 1.08));
            audio_play_sound(snd_f2_explosao, 3, false, 0.48, 0, random_range(0.96, 1.04));
            audio_play_sound(snd_f2_ponto, 3, false, 0.44, 0, 1 + cliques * 0.025);
            cliques++;
            timer_clique = 0;
            
            with (caixa) instance_destroy();
            caixa = noone;
            
            if (cliques >= cliques_necessarios) {
                finalizar_jogo(true);
            } else {
                respawn_timer = max(5, 18 - cliques);
            }
        } else if (timer_clique >= limite_clique_atual) {
            perder_vida();
        }
    }
}

// ===== TREMOR PROGRESSIVO DA CAMERA =====
var vidas_perdidas = vidas_max - vidas;
var tremor_constante = 0;
if (ativo) {
    tremor_constante = shake_inicio + vidas_perdidas * 0.72;
}
if (ativo && vidas == 1) {
    tremor_constante = 5.8;
}

var intensidade = tremor_constante + shake_impacto;
if (view_camera[0] != -1) {
    if (intensidade > 0) {
        camera_set_view_pos(
            view_camera[0],
            view_base_x + sin(current_time * 0.024) * intensidade,
            view_base_y + cos(current_time * 0.021) * intensidade * 0.62
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
