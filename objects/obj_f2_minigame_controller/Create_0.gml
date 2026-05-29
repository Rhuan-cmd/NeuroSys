vidas_max = 5;
vidas = vidas_max;
cliques = 0;
cliques_necessarios = 10;
randomize();

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
saida_transition = 0;
saida_tipo = 0;
final_vitoria = false;
damage_flash = 0;
corrupt_flash = 0;
tempo_jogo = 0;
tempo_final = 0;
vidas_final = 0;
nota_final = "D";
fx_x = [];
fx_y = [];
fx_timer = [];
fx_total = 0;

limite_clique = room_speed * 10;
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

shake_impacto = 0;
shake_inicio = 0;
view_base_x = 0;
view_base_y = 0;

if (view_camera[0] != -1) {
    view_base_x = camera_get_view_x(view_camera[0]);
    view_base_y = camera_get_view_y(view_camera[0]);
}

novo_alvo_cursor = function() {
    cursor_alvo_x = random_range(300, 635);
    cursor_alvo_y = random_range(140, 390);
    cursor_troca_timer = irandom_range(28, 58);
};

registrar_explosao = function(_x, _y) {
    var i = fx_total;
    fx_x[i] = _x;
    fx_y[i] = _y;
    fx_timer[i] = 18;
    fx_total++;
    if (fx_total > 24) {
        fx_total = 0;
    }
};

iniciar_minigame = function() {
    transicao_caixa = true;
    transicao_timer = 0;
    timer_clique = 0;
    cutscene_clickou = true;
    cascata_fluxo = 0;
    window_set_cursor(cr_none);
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
    shake_impacto = 42;
    shake_inicio = 3.2;
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
        obj_f2_close_box
    );
    caixa.configurar(cliques);
    
    if (_reposicionar) {
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

perder_vida = function() {
    vidas--;
    timer_clique = 0;
    shake_impacto = 56 + (vidas_max - vidas) * 18;
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
    tempo_final = tempo_jogo;
    vidas_final = vidas;
    shake_impacto = _vitoria ? 36 : 78;
    damage_flash = _vitoria ? 0.35 : 1;
    
    var nota_pontos = cliques * 8 + vidas * 4 - floor(tempo_final / room_speed);
    if (nota_pontos >= 85) nota_final = "S";
    else if (nota_pontos >= 70) nota_final = "A";
    else if (nota_pontos >= 55) nota_final = "B";
    else if (nota_pontos >= 35) nota_final = "C";
    else nota_final = "D";
    
    if (instance_exists(caixa)) {
        with (caixa) instance_destroy();
    }
};
