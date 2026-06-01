// 1. Pega o tamanho atual e checa se a tela foi redimensionada
var _largura_atual = display_get_gui_width();
var _altura_atual = display_get_gui_height();

if (gui_w != _largura_atual || gui_h != _altura_atual) {
    gui_w = _largura_atual;
    gui_h = _altura_atual;
    colunas = ceil(gui_w / quadrado_tamanho) + 2;
    linhas = ceil(gui_h / quadrado_tamanho) + 2;
    tempo_maximo = 1 + (colunas + linhas) * atraso_diagonal * 0.1;
}

// 2. Define a cor global para preto (otimiza o GameMaker a não mudar cor a todo momento)
draw_set_color(c_black);

// 3. Loop de desenho da grade
for (var r = -1; r < linhas; r++) {
    for (var c = -1; c < colunas; c++) {
        
        var _px = c * quadrado_tamanho + (quadrado_tamanho / 2);
        var _py = r * quadrado_tamanho + (quadrado_tamanho / 2);
        
        var _escala = 0;
        var _rotacao = 0;
        var _t_bruto = 0;
        
        if (estado == "indo") {
            var _atraso = (c + r) * atraso_diagonal * 0.1;
            _t_bruto = timer - _atraso;
            
            // OTIMIZAÇÃO 1: Se a animação deste quadrado não começou, não desenha nada
            if (_t_bruto <= 0) continue; 
            
            // OTIMIZAÇÃO 2: Se já terminou de crescer, desenha um bloco sólido sem rotacionar
            if (_t_bruto >= 1) {
                var _metade = (quadrado_tamanho * 1.4) / 2;
                draw_rectangle(_px - _metade, _py - _metade, _px + _metade, _py + _metade, false);
                continue;
            }
            
            // Se está no meio da animação, calcula escala e rotação
            _escala = lerp(0, 1.4, _t_bruto);
            _rotacao = lerp(0, 90, _t_bruto);
            
        } else if (estado == "voltando") {
            var _atraso_inv = ((colunas + linhas) - (c + r)) * atraso_diagonal * 0.1;
            _t_bruto = timer - _atraso_inv;
            
            // OTIMIZAÇÃO 3: Se já terminou de sumir, não desenha nada
            if (_t_bruto >= 1) continue; 
            
            // OTIMIZAÇÃO 4: Se ainda não começou a sumir, desenha bloco sólido
            if (_t_bruto <= 0) {
                var _metade = (quadrado_tamanho * 1.4) / 2;
                draw_rectangle(_px - _metade, _py - _metade, _px + _metade, _py + _metade, false);
                continue;
            }
            
            // Se está no meio da animação
            _escala = lerp(1.4, 0, _t_bruto);
            _rotacao = lerp(90, 180, _t_bruto);
        }
        
        // 4. Desenha o quadrado em animação
        if (sprite_exists(spr_ui_transicao)) {
            // Usa o sprite já no tamanho correto. Note que a escala agora é _escala direto, e não multiplicada.
            draw_sprite_ext(spr_ui_transicao, 0, _px, _py, _escala, _escala, _rotacao, c_black, 1);
        } else {
            // Fallback caso esqueça de criar o sprite
            var _metade = (quadrado_tamanho * _escala) / 2;
            draw_rectangle(_px - _metade, _py - _metade, _px + _metade, _py + _metade, false);
        }
    }
}