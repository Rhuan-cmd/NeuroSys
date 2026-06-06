// ===== REGRAS PRINCIPAIS DA FASE =====
audio_room_enter("fase2");
vidas_max = 5;
vidas = vidas_max;
cliques = 0;
cliques_necessarios = 10;
randomize();

// ===== CUTSCENE, DIALOGOS E TRANSICOES =====
cutscene_timer = 0;
cutscene_ativo_timer = 0;
fade_duracao = room_speed * 2.4;
tempo_ate_cascata = room_speed * 9.4;
cascata_ativa = false;
cascata_fluxo = 0;
cutscene_clickou = false;
cursor_real_liberado = false;
historia_finalizada = false;
dialogo_index = 0;
dialogo_chars = 0;
dialogo_total = 6;
dialogo_encerrando = false;
dialogo_saida = 0;
cascata_inicio_tempo = 0;
transicao_caixa = false;
transicao_timer = 0;
transicao_duracao = room_speed * 0.85;
status_intro_timer = 0;
estado_final = 0;
final_timer = 0;
final_transition = 0;
final_fade = 0;
final_painel = false;
final_limpeza_feita = false;
saida_transition = 0;
saida_tipo = 0;
final_vitoria = false;
// ===== ESTATISTICAS E EFEITOS VISUAIS =====
damage_flash = 0;
corrupt_flash = 0;
tempo_jogo = 0;
tempo_final = 0;
vidas_final = 0;
nota_final = "0/10";
fx_x = [];
fx_y = [];
fx_timer = [];
fx_total = 0;
// ===== AUDIO AMBIENTE E EFEITOS SONOROS =====
sino_audio_timer = room_speed;
ambiente_audio = ns_audio_play_music(snd_f2_ambiente, 2, true, 0.62, 0, 1);
ambiente_corrupto_audio = -1;
chiado_audio = -1;
ns_audio_play_sfx(snd_f2_entrada, 4, false, 0.52, 0, 1);
digitacao_audio_timer = 0;
aparicao_audio_etapa = 0;
audio_mix_timer = 0;
tremor_audio = -1;
notificacao_audio_timer = 0;
notificacao_fila = 0;
notificacao_contatos_anteriores = 0;
notificacao_mensagens_anteriores = 0;
notificacao_contato_ciclo = 0;
notificacao_mensagem_ciclo = 0;
aviso_x_timer = 0;
aviso_x_duracao = room_speed * 1.8;
// ===== PODERES DO X: GELO E REPELAO =====
poder_cooldown = room_speed * 3;
congelado_timer = 0;
congelado_total = room_speed * 0.52;
gelo_x = 0;
gelo_y = 0;
gelo_quebra_timer = 0;
repel_fx_timer = 0;
repel_fx_x = 0;
repel_fx_y = 0;
poder_ataque_tipo = 0;
poder_ataque_timer = 0;
poder_ataque_total = 28;
poder_ataque_x0 = 0;
poder_ataque_y0 = 0;
poder_ataque_x1 = 0;
poder_ataque_y1 = 0;
hover_menu_anterior = false;
hover_reiniciar_anterior = false;

// ===== MINIGAME, CURSOR E BOTAO FIXO =====
limite_clique = room_speed * 12;
limite_clique_atual = limite_clique;
timer_clique = 0;
respawn_timer = 0;
ativo = false;
caixa = noone;
botao_fixo_x = 62;
botao_fixo_y = 31;
cursor_cutscene_x = room_width * 0.5;
cursor_cutscene_y = room_height * 0.5;
cursor_draw_x = cursor_cutscene_x;
cursor_draw_y = cursor_cutscene_y;
cursor_alvo_x = cursor_cutscene_x;
cursor_alvo_y = cursor_cutscene_y;
cursor_troca_timer = 1;
window_set_cursor(cr_none);
cursor_sprite = cr_none;

// ===== TREMOR DA CAMERA =====
shake_impacto = 0;
shake_inicio = 0;
view_base_x = 0;
view_base_y = 0;

if (view_camera[0] != -1) {
    view_base_x = camera_get_view_x(view_camera[0]);
    view_base_y = camera_get_view_y(view_camera[0]);
}

// ===== FUNCOES AUXILIARES DO CURSOR E EFEITOS =====
novo_alvo_cursor = function() {
    cursor_alvo_x = random_range(300, 635);
    cursor_alvo_y = random_range(140, 390);
    cursor_troca_timer = irandom_range(28, 58);
};

desenhar_corrupcao_otimizada = function(_forca, _flash) {
    var _nivel = clamp(_forca + _flash * 0.72, 0, 1);
    if (_nivel <= 0) return;
    var _fx_brilho = variable_global_exists("fx_brilho") ? global.fx_brilho : 1;
    var _pulso = 0.72 + sin(current_time * 0.014) * 0.16;
    var _frame = floor(current_time / 140) mod sprite_get_number(spr_fx_corrupcao);
    draw_sprite_ext(spr_fx_corrupcao, _frame, 0, 0, room_width / sprite_get_width(spr_fx_corrupcao), room_height / sprite_get_height(spr_fx_corrupcao), 0, c_white, (0.16 + _nivel * 0.34) * _pulso * _fx_brilho);
};

registrar_explosao = function(_x, _y) {
    var i = fx_total;
    fx_x[i] = _x;
    fx_y[i] = _y;
    fx_timer[i] = 18;
    fx_total++;
    if (fx_total > 12) {
        fx_total = 0;
    }
};

// ===== INICIO DO MINIGAME APOS A CUTSCENE =====
iniciar_minigame = function() {
    transicao_caixa = true;
    transicao_timer = 0;
    timer_clique = 0;
    sino_audio_timer = 1;
    cutscene_clickou = true;
    cascata_fluxo = 0;
    window_set_cursor(cr_none);
    aviso_x_timer = aviso_x_duracao;
    ns_audio_play_sfx(snd_f2_clique, 3, false, 0.5, 0, 1);
    ns_audio_play_sfx(snd_f2_suspense, 4, false, 0.76, 0, 1);
    criar_caixa(botao_fixo_x, botao_fixo_y, false);
    if (instance_exists(caixa)) {
        caixa.modo_intro = true;
        caixa.intro_timer = 0;
        caixa.intro_duracao = transicao_duracao;
        caixa.intro_x0 = botao_fixo_x;
        caixa.intro_y0 = botao_fixo_y;
        caixa.intro_x1 = room_width * 0.5;
        caixa.intro_y1 = room_height * 0.5;
        caixa.image_xscale = 1;
        caixa.image_yscale = 1;
    }
};

// ===== PODERES ESPECIAIS USADOS PELO X =====
congelar_cursor = function() {
    gelo_x = mouse_x;
    gelo_y = mouse_y;
    congelado_timer = congelado_total;
    gelo_quebra_timer = 0;
    window_mouse_set(gelo_x, gelo_y);
    ns_audio_play_sfx(snd_f2_congelar, 4, false, 0.72, 0, 1);
};

repelir_cursor = function() {
    var origem_x = room_width * 0.5;
    var origem_y = room_height * 0.5;
    if (instance_exists(caixa)) {
        origem_x = caixa.x;
        origem_y = caixa.y;
    }
    var direcao = point_direction(origem_x, origem_y, mouse_x, mouse_y);
    if (point_distance(origem_x, origem_y, mouse_x, mouse_y) < 12) {
        direcao = irandom(359);
    }
    var repel_x = clamp(mouse_x + lengthdir_x(210, direcao), 28, room_width - 28);
    var repel_y = clamp(mouse_y + lengthdir_y(210, direcao), 28, room_height - 28);
    repel_fx_x = mouse_x;
    repel_fx_y = mouse_y;
    repel_fx_timer = 20;
    window_mouse_set(repel_x, repel_y);
    cursor_draw_x = repel_x;
    cursor_draw_y = repel_y;
    shake_impacto = max(shake_impacto, 18);
    ns_audio_play_sfx(snd_f2_repelir, 4, false, 0.78, 0, 1);
};

iniciar_ataque_cursor = function(_tipo) {
    poder_ataque_tipo = _tipo;
    poder_ataque_timer = poder_ataque_total;
    poder_ataque_x0 = room_width * 0.5;
    poder_ataque_y0 = room_height * 0.5;
    if (instance_exists(caixa)) {
        poder_ataque_x0 = caixa.x;
        poder_ataque_y0 = caixa.y;
    }
    poder_ataque_x1 = mouse_x;
    poder_ataque_y1 = mouse_y;
    ns_audio_play_sfx(snd_f2_fuga, 3, false, 0.5, 0, _tipo == 1 ? 1.08 : 0.9);
};

// ===== ATIVACAO, CRIACAO E REAPARECIMENTO DO X =====
ativar_minigame = function() {
    transicao_caixa = false;
    ativo = true;
    timer_clique = 0;
    cursor_real_liberado = true;
    window_mouse_set(cursor_cutscene_x, cursor_cutscene_y);
    window_set_cursor(cr_none);
    if (instance_exists(caixa)) {
        caixa.modo_intro = false;
        caixa.x = room_width * 0.5;
        caixa.y = room_height * 0.5;
        caixa.image_xscale = caixa.escala_padrao;
        caixa.image_yscale = caixa.escala_padrao;
        caixa.novo_alvo();
    }
    shake_impacto = 22;
    shake_inicio = 1.8;
    ns_audio_play_sfx(snd_f2_fuga, 2, false, 0.52, 0, 1);
    ns_audio_play_sfx(snd_f2_tremor, 3, false, 0.36, 0, 1);
};

criar_caixa = function(_x, _y, _reposicionar) {
    var spawn_x = _x;
    var spawn_y = _y;
    if (_reposicionar) {
        spawn_x = botao_fixo_x;
        spawn_y = botao_fixo_y;
    }
    
    caixa = instance_create_layer(
        spawn_x,
        spawn_y,
        "Fase2_Minijogo",
        obj_f2_caixa_fechar
    );
    caixa.configurar(cliques);
    limite_clique_atual = limite_clique;
    if (cliques >= 8) limite_clique_atual = room_speed * 8;
    if (cliques >= 9) limite_clique_atual = room_speed * 6;
    timer_clique = 0;
    sino_audio_timer = 1;
    
    if (_reposicionar) {
        ns_audio_play_sfx(snd_f2_fuga, 2, false, 0.34, 0, random_range(0.96, 1.08));
        caixa.imortal_timer = ceil(room_speed * 0.5);
        caixa.modo_intro = true;
        caixa.intro_timer = 0;
        caixa.intro_duracao = 22;
        caixa.intro_x0 = botao_fixo_x;
        caixa.intro_y0 = botao_fixo_y;
        caixa.intro_x1 = _x;
        caixa.intro_y1 = _y;
        caixa.image_xscale = 0.72;
        caixa.image_yscale = 0.72;
    } else {
        caixa.novo_alvo();
    }
};

// ===== PERDA DE VIDA E ENCERRAMENTO DA FASE =====
perder_vida = function() {
    vidas--;
    ns_audio_play_sfx(snd_f2_dano, 3, false, 0.72, 0, 1);
    ns_audio_play_sfx(snd_f2_tremor, 3, false, min(0.82, 0.42 + (vidas_max - vidas) * 0.08), 0, 1);
    timer_clique = 0;
    shake_impacto = 32 + (vidas_max - vidas) * 9;
    damage_flash = 1;
    corrupt_flash = min(1, corrupt_flash + 0.28);
    
    if (instance_exists(caixa)) {
        with (caixa) instance_destroy();
    }
    
    if (vidas <= 0) {
        finalizar_jogo(false);
    } else {
        respawn_timer = max(8, 28 - cliques * 2);
    }
};

finalizar_jogo = function(_vitoria) {
    final_vitoria = _vitoria;
    estado_final = 1;
    final_timer = 0;
    final_transition = 0;
    final_fade = 0;
    final_painel = false;
    saida_transition = 0;
    saida_tipo = 0;
    ativo = false;
    congelado_timer = 0;
    gelo_quebra_timer = 0;
    repel_fx_timer = 0;
    poder_ataque_timer = 0;
    poder_ataque_tipo = 0;
    tempo_final = tempo_jogo;
    vidas_final = vidas;
    shake_impacto = _vitoria ? 20 : 46;
    damage_flash = _vitoria ? 0.35 : 1;
    audio_stop_sound(snd_f2_ambiente);
    audio_stop_sound(snd_f2_ambiente_corrupto);
    ns_audio_play_sfx(snd_f2_saida, 4, false, 0.56, 0, 1);
    ns_audio_play_sfx(_vitoria ? snd_f2_vitoria : snd_f2_derrota, 4, false, _vitoria ? 0.96 : 0.82, 0, 1);
    if (_vitoria) {
        global.fase_liberada = max(variable_global_exists("fase_liberada") ? global.fase_liberada : 1, 3);
        global.fase_concluida = max(variable_global_exists("fase_concluida") ? global.fase_concluida : 0, 2);
    }
    
    if (_vitoria) {
        nota_final = string(clamp(round(6 + vidas * 0.62 - min(1.25, tempo_final / (room_speed * 95))), 6, 10)) + "/10";
    } else {
        nota_final = string(clamp(round((cliques / cliques_necessarios) * 5), 0, 5)) + "/10";
    }
    
    if (instance_exists(caixa)) {
        with (caixa) instance_destroy();
    }
};
