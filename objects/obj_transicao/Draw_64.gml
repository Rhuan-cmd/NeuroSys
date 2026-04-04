// 1. Pega o tamanho EXATO da tela neste frame (resolve a tela cheia)
var _largura_atual = display_get_gui_width();
var _altura_atual = display_get_gui_height();

// 2. Se a tela mudou de tamanho (entrou em tela cheia), recalcula tudo
if (gui_w != _largura_atual || gui_h != _altura_atual) {
    gui_w = _largura_atual;
    gui_h = _altura_atual;
    
    // Colocamos + 2 na margem de segurança para garantir que passe das bordas
    colunas = ceil(gui_w / quadrado_tamanho) + 2;
    linhas = ceil(gui_h / quadrado_tamanho) + 2;
    
    // Limpa a superfície antiga para ela ser recriada no novo tamanho
    if (surface_exists(surf)) {
        surface_free(surf);
    }
}

// 1. Garante que a superfície exista
if (!surface_exists(surf)) {
    surf = surface_create(gui_w, gui_h);
}

// 2. Define o alvo do desenho para a superfície
surface_set_target(surf);
    
    // Limpa a superfície (torna-a transparente)
    draw_clear_alpha(c_black, 0);
    
    // Define a cor dos quadrados
    draw_set_color(c_black);
    
    // Loop para desenhar cada quadrado da grade
    for (var r = -1; r < linhas; r++) {
        for (var c = -1; c < colunas; c++) {
            
            // Calcula a posição central do quadrado
            var _px = c * quadrado_tamanho + quadrado_tamanho/2;
            var _py = r * quadrado_tamanho + quadrado_tamanho/2;
            
            // Calcula o atraso para este quadrado baseado na diagonal (coluna + linha)
            var _atraso = (c + r) * atraso_diagonal * 0.1;
            
            // Variáveis de animação locais (escala e rotação)
            var _escala = 0;
            var _rotacao = 0;
            
            if (estado == "indo") {
                // --- Animação INDO: Aparecendo na Diagonal ---
                // Clamp garante que o valor fique entre 0 e 1
                var _t = clamp(timer - _atraso, 0, 1);
                
                // Escala vai de 0 a 1.4 (um pouco maior para cobrir frestas)
                _escala = lerp(0, 1.4, _t); 
                // Rotação vai de 0 a 90 graus
                _rotacao = lerp(0, 90, _t);
                
            } else if (estado == "voltando") {
                // --- Animação VOLTANDO: Diminuindo e Rotacionando ---
                // O atraso é invertido para a animação começar do final da diagonal
                var _atraso_inv = ((colunas + linhas) - (c + r)) * atraso_diagonal * 0.1;
                var _t = clamp(timer - _atraso_inv, 0, 1);
                
                // Escala vai de 1.4 a 0
                _escala = lerp(1.4, 0, _t);
                // Rotação continua rotacionando de 90 a 180 (ou volta para 0)
                _rotacao = lerp(90, 180, _t);
            }
            
            // Desenha o quadrado (usando draw_sprite_ext com um sprite branco de 1x1 ou draw_rectangle_color)
            // Para rotação, precisamos usar draw_sprite_ext. Vamos usar o sprite padrão 'spr_white_pixel' (crie um sprite branco de 1x1 pixel)
            
            // Se você não tem um sprite de 1x1 pixel, crie um agora (spr_pixel_branco)
            if (sprite_exists(spr_pixel_branco)) {
                draw_sprite_ext(spr_pixel_branco, 0, _px, _py, _escala * quadrado_tamanho, _escala * quadrado_tamanho, _rotacao, c_black, 1);
            } else {
                // Fallback: Se não houver sprite, desenha retângulos (sem rotação)
                if (_escala > 0) {
                    var _metade = (quadrado_tamanho * _escala) / 2;
                    draw_rectangle(_px - _metade, _py - _metade, _px + _metade, _py + _metade, false);
                }
            }
        }
    }

// 3. Reseta o alvo do desenho para a tela principal
surface_reset_target();

// 4. Desenha a superfície final na tela
draw_surface(surf, 0, 0);