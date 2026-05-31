randomize();
window_set_cursor(cr_none);
cursor_sprite = cr_none;

// ===== FLUXO DA FASE E CUTSCENE =====
estado = 0; // 0: cutscene, 1: objetivo, 2: jogo, 3: vitoria, 4: derrota
cutscene_timer = 0;
fade_duracao = room_speed * 2.2;
dialogo_index = 0;
dialogo_total = 6;
dialogo_chars = 0;
dialogo_saida = 0;
dialogo_encerrando = false;
dialogo_layout = 0;
digitacao_audio_timer = 0;
objetivo_timer = 0;
objetivo_duracao = room_speed * 2.8;
objetivo_minimo = room_speed * 1.4;
objetivo_saida = false;
objetivo_saida_alpha = 0;
fim_timer = 0;
transicao_feita = false;
final_transition = 0;
final_fade = 0;
final_painel = false;
final_limpeza_feita = false;
saida_transition = 0;
saida_tipo = 0;
final_vitoria = false;
tempo_final = 0;
vidas_final = 0;
nota_final = "D";
hover_acao_anterior = false;
hover_reiniciar_anterior = false;
damage_flash = 0;
bonus_flash = 0;
shake = 0;
visual_timer = 0;
cursor_cutscene_x = 480;
cursor_cutscene_y = 270;
cursor_draw_x = cursor_cutscene_x;
cursor_draw_y = cursor_cutscene_y;
cursor_click_fx = 0;

dialogo_textos = [
    "Você abre a rede social e encontra a postagem de Luna: um desenho que ela fez enquanto aprendia.",
    "O cursor desce até os comentários. Primeiro aparece uma crítica. Depois chegam ataques pessoais.",
    "Uma mensagem de apoio surge no meio da onda. Leia antes de agir: apoio não deve ser removido.",
    "Ao abrir as ferramentas de moderação, você encontra a opção DENUNCIAR PERFIL.",
    "Denunciar protege a postagem. Compartilhar um ataque faz o oposto: aumenta o alcance da agressão.",
    "Agora assuma o controle. Comece pelos ataques simples. Novas situações aparecem aos poucos."
];

dialogo_titulos = [
    "Uma postagem comum",
    "Os comentários chegam",
    "Leia antes de agir",
    "Ferramentas de moderação",
    "Denuncie, não espalhe",
    "Seu objetivo"
];

// ===== REGRAS DO MINIJOGO =====
vidas_max = 5;
vidas = vidas_max;
objetivo = 26;
ataques_cortados = 0;
pontuacao = 0;
combo = 0;
melhor_combo = 0;
escudo = 0;
tempo_total = room_speed * 105;
tempo = tempo_total;
spawn_timer = 12;
mouse_anterior_x = mouse_x;
mouse_anterior_y = mouse_y;
mensagens = [];
particulas = [];
rastros = [];

textos_ruins = [
    "ninguém gosta de você",
    "some daqui",
    "que vergonha",
    "para de postar",
    "todo mundo ri de você",
    "você não pertence aqui",
    "apaga isso agora",
    "ninguém pediu sua opinião"
];

textos_bons = [
    "estamos com você",
    "não ligue para isso",
    "você não está sozinho",
    "vamos conversar",
    "respeito sempre",
    "seu desenho ficou ótimo"
];

aplicar_dano = function() {
    if (escudo > 0) {
        escudo = 0;
        bonus_flash = 1;
    } else {
        vidas--;
        damage_flash = 1;
        shake = 12;
        audio_play_sound(snd_f2_damage, 3, false, 0.62);
    }
    combo = 0;
};

reiniciar_fase = function() {
    estado = 2;
    vidas = vidas_max;
    ataques_cortados = 0;
    pontuacao = 0;
    combo = 0;
    melhor_combo = 0;
    escudo = 0;
    tempo = tempo_total;
    spawn_timer = 10;
    fim_timer = 0;
    transicao_feita = false;
    final_transition = 0;
    final_fade = 0;
    final_painel = false;
    final_limpeza_feita = false;
    saida_transition = 0;
    saida_tipo = 0;
    objetivo_saida = false;
    objetivo_saida_alpha = 0;
    mensagens = [];
    particulas = [];
    rastros = [];
};

criar_mensagem = function() {
    var _roll = random(1);
    var _tipo = 0; // 0: ataque, 1: apoio, 2: denúncia, 3: compartilhar
    if (ataques_cortados >= 5 && _roll > 0.84) _tipo = 1;
    if (ataques_cortados >= 9 && _roll > 0.92) _tipo = 2;
    if (ataques_cortados >= 13 && _roll > 0.97) _tipo = 3;
    var _forte = _tipo == 0 && ataques_cortados >= 14 && random(1) < 0.22;
    var _texto = textos_ruins[irandom(array_length(textos_ruins) - 1)];
    if (_tipo == 1) _texto = textos_bons[irandom(array_length(textos_bons) - 1)];
    if (_tipo == 2) _texto = "DENUNCIAR PERFIL";
    if (_tipo == 3) _texto = "COMPARTILHAR ATAQUE";
    var _lado = 0; // 0: baixo, 1: cima, 2: esquerda, 3: direita
    if (ataques_cortados >= 6 && random(1) < 0.34) _lado = 1;
    if (ataques_cortados >= 12 && random(1) < 0.42) _lado = choose(2, 3);
    var _x = random_range(236, 786);
    var _y = room_height + 42;
    var _vx = random_range(-2.3, 2.3);
    var _vy = random_range(-10.4, -8.2);
    var _grav = random_range(0.12, 0.17);
    if (_lado == 1) {
        _y = -42;
        _vy = random_range(3.2, 5.0);
        _grav = random_range(0.025, 0.055);
    }
    if (_lado == 2) {
        _x = -150;
        _y = random_range(186, 388);
        _vx = random_range(5.4, 7.0);
        _vy = random_range(-3.8, -1.8);
        _grav = random_range(0.08, 0.13);
    }
    if (_lado == 3) {
        _x = room_width + 150;
        _y = random_range(186, 388);
        _vx = random_range(-7.0, -5.4);
        _vy = random_range(-3.8, -1.8);
        _grav = random_range(0.08, 0.13);
    }
    array_push(mensagens, {
        x : _x,
        y : _y,
        vx : _vx,
        vy : _vy,
        grav : _grav,
        tipo : _tipo,
        texto : _texto,
        largura : clamp(118 + string_length(_texto) * 4.1, 168, 252),
        altura : 48,
        fase : random(100),
        rot : random_range(-7, 7),
        hp : _forte ? 2 : 1,
        forte : _forte,
        invul : 0
    });
};

criar_particulas = function(_x, _y, _tipo) {
    for (var _i = 0; _i < 12; _i++) {
        var _dir = random(360);
        var _vel = random_range(1.5, 5.5);
        array_push(particulas, {
            x : _x, y : _y,
            vx : lengthdir_x(_vel, _dir),
            vy : lengthdir_y(_vel, _dir),
            vida : irandom_range(16, 28),
            maxvida : 28,
            tipo : _tipo
        });
    }
};

distancia_segmento = function(_px, _py, _x1, _y1, _x2, _y2) {
    var _dx = _x2 - _x1;
    var _dy = _y2 - _y1;
    if (_dx == 0 && _dy == 0) return point_distance(_px, _py, _x1, _y1);
    var _t = ((_px - _x1) * _dx + (_py - _y1) * _dy) / (_dx * _dx + _dy * _dy);
    _t = clamp(_t, 0, 1);
    return point_distance(_px, _py, _x1 + _t * _dx, _y1 + _t * _dy);
};

cartao_atingido = function(_m, _x1, _y1, _x2, _y2) {
    var _meia_largura = _m.largura * 0.38;
    var _limite = _m.altura * 0.72;
    return distancia_segmento(_m.x, _m.y, _x1, _y1, _x2, _y2) < _limite
        || distancia_segmento(_m.x - _meia_largura, _m.y, _x1, _y1, _x2, _y2) < _limite
        || distancia_segmento(_m.x + _meia_largura, _m.y, _x1, _y1, _x2, _y2) < _limite;
};

finalizar_fase = function(_venceu) {
    if (estado != 2) return;
    estado = _venceu ? 3 : 4;
    final_vitoria = _venceu;
    fim_timer = 0;
    final_transition = 0;
    final_fade = 0;
    final_painel = false;
    final_limpeza_feita = false;
    saida_transition = 0;
    saida_tipo = 0;
    tempo_final = tempo_total - tempo;
    vidas_final = vidas;
    mensagens = [];
    combo = 0;
    var _nota_pontos = ataques_cortados * 4 + vidas * 6 + melhor_combo * 2;
    if (_nota_pontos >= 130) nota_final = "S";
    else if (_nota_pontos >= 105) nota_final = "A";
    else if (_nota_pontos >= 82) nota_final = "B";
    else if (_nota_pontos >= 58) nota_final = "C";
    else nota_final = "D";
    audio_play_sound(_venceu ? snd_f2_win : snd_f2_lose, 4, false, 0.78);
};
