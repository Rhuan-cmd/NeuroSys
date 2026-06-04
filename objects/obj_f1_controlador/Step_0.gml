window_set_cursor(global.perf_overlay_ativo ? cr_default : cr_none);
cursor_sprite = cr_none;
cutscene_timer++;
if (estado < 3) visual_timer++;
damage_flash = max(0, damage_flash - 0.05);
bonus_flash = max(0, bonus_flash - 0.04);
corrupt_flash = max(0, corrupt_flash - 0.009);
shake = max(0, shake - 0.7);
cursor_click_fx = max(0, cursor_click_fx - 1);
var _corrupcao_tremor = estado == 2 ? clamp(nivel_corrupcao / vidas_max + (vidas <= 2 ? (3 - vidas) * 0.2 : 0), 0, 1) : 0;
var _forca_tremor = shake + _corrupcao_tremor * 7;
tremor_x = sin(visual_timer * 0.31) * _forca_tremor;
tremor_y = cos(visual_timer * 0.27) * _forca_tremor * 0.55;
audio_mix_timer--;
if (estado < 3 && audio_mix_timer <= 0) {
    if (ambiente_audio == -1 || !audio_is_playing(ambiente_audio)) ambiente_audio = audio_play_sound(snd_f1_musica, 1, true, 0.68);
    var _mix_corrupcao = estado == 2 ? clamp(_corrupcao_tremor, 0, 1) : 0;
    var _mix_suave = _mix_corrupcao * _mix_corrupcao * (3 - 2 * _mix_corrupcao);
    if (ambiente_corrupto_audio == -1 || !audio_is_playing(ambiente_corrupto_audio)) {
        audio_stop_sound(snd_f1_tensao);
        ambiente_corrupto_audio = audio_play_sound(snd_f1_tensao, 1, true, 0);
    }
    audio_sound_gain(ambiente_audio, lerp(0.68, 0.2, _mix_suave), 180);
    audio_sound_gain(ambiente_corrupto_audio, lerp(0, 0.78, _mix_suave), 180);
    audio_mix_timer = 12;
}

// ===== TELA FINAL: CONGELA O JOGO E LIMPA O FUNDO =====
if (estado >= 3) {
    fim_timer++;
    cursor_draw_x = mouse_x;
    cursor_draw_y = mouse_y;
    if (!final_painel) {
        final_fade = min(1, final_fade + 0.04);
        if (final_fade >= 1 && fim_timer > room_speed * 0.72) final_painel = true;
    } else {
        final_transition = min(1, final_transition + 0.06);
    }
    if (final_painel && !final_limpeza_feita) {
        final_limpeza_feita = true;
    }
    if (saida_tipo != 0) {
        saida_transition = min(1, saida_transition + 0.06);
        if (saida_transition >= 1) {
            if (saida_tipo == 1) transicao(rm_menu);
            else room_restart();
        }
    }
    var _final_suave = final_transition * final_transition * (3 - 2 * final_transition);
    var _final_offset = lerp(38, 0, _final_suave);
    var _hover_acao = final_painel && point_in_rectangle(mouse_x, mouse_y, 312, 375 + _final_offset, 454, 411 + _final_offset);
    var _hover_reiniciar = final_painel && point_in_rectangle(mouse_x, mouse_y, 506, 375 + _final_offset, 648, 411 + _final_offset);
    if ((_hover_acao && !hover_acao_anterior) || (_hover_reiniciar && !hover_reiniciar_anterior)) {
        audio_play_sound(snd_f2_selecao, 3, false, 0.42);
    }
    hover_acao_anterior = _hover_acao;
    hover_reiniciar_anterior = _hover_reiniciar;
    if (final_painel && mouse_check_button_pressed(mb_left)) {
        if (_hover_acao) {
            audio_play_sound(snd_f2_botao, 4, false, 0.62);
            saida_tipo = 1;
        }
        if (_hover_reiniciar) {
            audio_play_sound(snd_f2_botao, 4, false, 0.62);
            saida_tipo = 2;
        }
    }
    if (final_painel && keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_f2_botao, 4, false, 0.62);
        saida_tipo = final_vitoria ? 1 : 2;
    }
    exit;
}

// ===== CUTSCENE NO MESMO RITMO DA FASE 2 =====
if (estado == 0 && cutscene_timer >= fade_duracao) {
    var _texto = dialogo_textos[dialogo_index];
    if (dialogo_encerrando) {
        dialogo_saida = min(1, dialogo_saida + 0.07);
        if (dialogo_saida >= 1) {
            estado = 1;
            objetivo_timer = 0;
            audio_play_sound(snd_f2_aparecer, 3, false, 0.52);
        }
    } else if (dialogo_chars < string_length(_texto)) {
        dialogo_chars = min(string_length(_texto), dialogo_chars + 0.62);
        digitacao_audio_timer--;
        if (digitacao_audio_timer <= 0) {
            audio_play_sound(snd_f2_digitacao, 1, false, 0.18, 0, random_range(0.96, 1.06));
            digitacao_audio_timer = 4;
        }
        if (keyboard_check_pressed(vk_enter)) {
            dialogo_chars = string_length(_texto);
            audio_play_sound(snd_f2_confirmar, 3, false, 0.46);
        }
    } else if (keyboard_check_pressed(vk_enter)) {
        dialogo_index++;
        dialogo_chars = 0;
        audio_play_sound(snd_f2_confirmar, 3, false, 0.54);
        if (dialogo_index >= dialogo_total) {
            dialogo_index = dialogo_total - 1;
            dialogo_encerrando = true;
        }
    }
}

if (estado == 0) {
    var _layout_alvo = (dialogo_index >= 1 && dialogo_index <= 4) ? 1 : 0;
    dialogo_layout = lerp(dialogo_layout, _layout_alvo, 0.09);
}

// ===== CURSOR AUTOMATICO: USUARIO INTERAGINDO NA TELA =====
if (estado == 0) {
    var _alvo_x = 480;
    var _alvo_y = 270;
    switch (dialogo_index) {
        case 0: _alvo_x = 342; _alvo_y = 244; break;
        case 1: _alvo_x = 550; _alvo_y = 322; break;
        case 2: _alvo_x = 488; _alvo_y = 370; break;
        case 3: _alvo_x = 756; _alvo_y = 242; break;
        case 4: _alvo_x = 756; _alvo_y = 272; break;
        case 5: _alvo_x = 480; _alvo_y = 444; break;
    }
    cursor_cutscene_x = lerp(cursor_cutscene_x, _alvo_x, 0.045);
    cursor_cutscene_y = lerp(cursor_cutscene_y, _alvo_y, 0.045);
    cursor_draw_x = lerp(cursor_draw_x, cursor_cutscene_x, 0.2);
    cursor_draw_y = lerp(cursor_draw_y, cursor_cutscene_y, 0.2);
    if (point_distance(cursor_draw_x, cursor_draw_y, _alvo_x, _alvo_y) < 5 && cursor_click_fx <= 0) cursor_click_fx = 34;
} else {
    cursor_draw_x = mouse_x;
    cursor_draw_y = mouse_y;
}

// ===== CARTÃO DE OBJETIVO ANTES DO JOGO =====
if (estado == 1) {
    objetivo_timer++;
    if (!objetivo_saida && objetivo_timer >= objetivo_minimo && (keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left))) {
        objetivo_saida = true;
        audio_play_sound(snd_f2_confirmar, 3, false, 0.5);
    }
    if (objetivo_saida) {
        objetivo_saida_alpha = min(1, objetivo_saida_alpha + 0.055);
        cutscene_post_alpha = max(0, cutscene_post_alpha - 0.055);
    }
    if (objetivo_saida_alpha >= 1) {
        reiniciar_fase();
        audio_play_sound(snd_f2_aparecer, 3, false, 0.62, 0, 1.08);
    }
}

// ===== FRUIT NINJA SOCIAL =====
if (estado == 2) {
    tempo--;
    spawn_timer--;
    if (spawn_timer <= 0 && array_length(mensagens) < 4) {
        criar_mensagem();
        audio_play_sound(snd_f2_notificacao, 1, false, 0.16, 0, random_range(0.94, 1.05));
        spawn_timer = max(28, 54 - floor(ataques_cortados * 0.45));
    }

    var _dist_mouse = point_distance(mouse_anterior_x, mouse_anterior_y, mouse_x, mouse_y);
    if (mouse_check_button(mb_left) && _dist_mouse > 2) {
        if (array_length(rastros) < 7) array_push(rastros, { x1 : mouse_anterior_x, y1 : mouse_anterior_y, x2 : mouse_x, y2 : mouse_y, vida : 8 });
        for (var _i = array_length(mensagens) - 1; _i >= 0; _i--) {
            var _m = mensagens[_i];
            var _visivel = _m.x - _m.largura * 0.5 >= 236 && _m.x + _m.largura * 0.5 <= 666;
            if (_visivel && _m.invul <= 0 && cartao_atingido(_m, mouse_anterior_x, mouse_anterior_y, mouse_x, mouse_y)) {
                var _angulo_corte = point_direction(mouse_anterior_x, mouse_anterior_y, mouse_x, mouse_y);
                criar_particulas(_m.x, _m.y, _m.tipo, _angulo_corte);
                audio_play_sound(snd_f1_corte, 3, false, 0.58, 0, random_range(0.94, 1.08));
                if (_m.tipo == 0) {
                    _m.hp--;
                    if (_m.hp > 0) {
                        _m.invul = 10;
                        _m.corte_fx = 12;
                        _m.corte_angulo = _angulo_corte;
                        _m.vx *= -1.15;
                        _m.vy -= 1.6;
                        shake = 4;
                    } else {
                        criar_fragmentos_cartao(_m, _angulo_corte);
                        ataques_cortados++;
                        combo++;
                        melhor_combo = max(melhor_combo, combo);
                        pontuacao += 100 + combo * 12;
                        audio_play_sound(snd_f2_ponto, 3, false, 0.42, 0, 1 + min(combo, 12) * 0.025);
                        array_delete(mensagens, _i, 1);
                    }
                } else if (_m.tipo == 1) {
                    criar_fragmentos_cartao(_m, _angulo_corte);
                    audio_play_sound(snd_f1_erro, 4, false, 0.72);
                    aplicar_dano();
                    array_delete(mensagens, _i, 1);
                } else if (_m.tipo == 2) {
                    criar_fragmentos_cartao(_m, _angulo_corte);
                    vidas = min(vidas_max, vidas + 1);
                    nivel_corrupcao = max(0, nivel_corrupcao - 1);
                    corrupt_flash = max(0, corrupt_flash - 0.24);
                    tempo = min(tempo_total, tempo + room_speed * 3);
                    bonus_flash = 1;
                    pontuacao += 180;
                    audio_play_sound(snd_f2_repelir, 3, false, 0.62);
                    array_delete(mensagens, _i, 1);
                } else {
                    criar_fragmentos_cartao(_m, _angulo_corte);
                    audio_play_sound(snd_f1_erro, 4, false, 0.76);
                    aplicar_dano();
                    shake = 18;
                    array_delete(mensagens, _i, 1);
                }
            }
        }
    }

    for (var _i = array_length(mensagens) - 1; _i >= 0; _i--) {
        var _m = mensagens[_i];
        _m.x += _m.vx;
        _m.y += _m.vy;
        _m.vy += _m.grav;
        _m.rot += _m.vx * 0.045;
        _m.invul = max(0, _m.invul - 1);
        _m.corte_fx = max(0, _m.corte_fx - 1);
        var _sobrepoe_feed = _m.x + _m.largura * 0.5 >= 236
            && _m.x - _m.largura * 0.5 <= 676
            && _m.y + _m.altura * 0.5 >= 104
            && _m.y - _m.altura * 0.5 <= 484;
        if (_sobrepoe_feed) {
            _m.entrou_feed = true;
            _m.frames_feed++;
        }
        if (_m.x - _m.largura * 0.5 < 236 && _m.vx < 0) {
            _m.x = 236 + _m.largura * 0.5;
            _m.vx = abs(_m.vx);
        }
        if (_m.x + _m.largura * 0.5 > 676 && _m.vx > 0) {
            _m.x = 676 - _m.largura * 0.5;
            _m.vx = -abs(_m.vx);
        }
        var _limite_topo = 116 + _m.altura * 0.5;
        var _limite_base = 472 - _m.altura * 0.5;
        if (_m.entrou_feed && _m.frames_feed < 78 && _m.y < _limite_topo && _m.vy < 0) {
            _m.y = _limite_topo;
            _m.vy = abs(_m.vy) * 0.78;
        }
        if (_m.entrou_feed && _m.frames_feed < 78 && _m.y > _limite_base && _m.vy > 0) {
            _m.y = _limite_base;
            _m.vy = -abs(_m.vy) * 0.78;
        }
        if (_m.entrou_feed && _m.frames_feed >= 78 && (_m.y > 510 || _m.y < 82 || _m.x < -320 || _m.x > room_width + 320)) {
            if (_m.tipo == 0) aplicar_dano();
            array_delete(mensagens, _i, 1);
        }
    }

    if (ataques_cortados >= objetivo) finalizar_fase(true);
    else if (vidas <= 0) finalizar_fase(false);
    else if (tempo <= 0) finalizar_fase(ataques_cortados >= objetivo);
}

for (var _i = array_length(particulas) - 1; _i >= 0; _i--) {
    var _p = particulas[_i];
    _p.x += _p.vx;
    _p.y += _p.vy;
    _p.vy += 0.12;
    _p.vida--;
    if (_p.vida <= 0) array_delete(particulas, _i, 1);
}

for (var _i = array_length(rastros) - 1; _i >= 0; _i--) {
    rastros[_i].vida--;
    if (rastros[_i].vida <= 0) array_delete(rastros, _i, 1);
}

for (var _i = array_length(fragmentos) - 1; _i >= 0; _i--) {
    var _f = fragmentos[_i];
    _f.espera--;
    if (_f.espera <= 0) {
        _f.x += _f.vx;
        _f.y += _f.vy;
        _f.vy += _f.grav;
        _f.rot += _f.vrot;
    }
    _f.vida--;
    if (_f.vida <= 0) array_delete(fragmentos, _i, 1);
}

for (var _i = array_length(ecos_cartao) - 1; _i >= 0; _i--) {
    var _e = ecos_cartao[_i];
    _e.espera--;
    if (_e.espera <= 0) {
        _e.x += _e.vx;
        _e.y += _e.vy;
        _e.vy += _e.grav;
    }
    _e.vida--;
    if (_e.vida <= 0) array_delete(ecos_cartao, _i, 1);
}

mouse_anterior_x = mouse_x;
mouse_anterior_y = mouse_y;
