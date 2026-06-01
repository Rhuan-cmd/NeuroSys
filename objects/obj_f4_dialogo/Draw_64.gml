// --- Evento Draw GUI ---

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Dimensões da anomalia
var _largura = 850 * abertura;
var _altura = 140 * abertura; // Um pouco mais baixa para ficar elegante
var _x1 = (_gui_w / 2) - (_largura / 2);

// POSIÇÃO MAIS PARA BAIXO: Ajustado de -250 para -180
var _y1 = _gui_h - 150; 
var _x2 = _x1 + _largura;
var _y2 = _y1 + _altura;

if (abertura <= 0) return;

// --- DESENHAR BORDAS (Preto Sólido) ---
draw_set_color(c_black);
draw_set_font(fnt_dialogo)
var _passo = _largura / (pontos_borda / 2);

for (var i = 0; i < (pontos_borda / 2); i++) {
    var _px = _x1 + (i * _passo);
    var _off_sup = offsets_borda[i];
    var _off_inf = offsets_borda[i + (pontos_borda/2)];
    
    // Desenha as fatias da caixa
    draw_rectangle(_px - 1, _y1 + _off_sup, _px + _passo + 1, _y2 + _off_inf, false);
}

// --- DESENHAR O ROSTO (Glitch Suavizado) ---
var _foto_x = _x1 + 50;
var _foto_y = _y1 + (_altura / 2) - 45;

if (abertura > 0.5) {
    for (var j = 0; j < 5; j++) {
        var _yy = j * 18;
        // Tremor do rosto agora é metade da intensidade do glitch
        var _sh = random_range(-intensidade_glitch/2, intensidade_glitch/2);
        draw_sprite_part_ext(sprite_rosto, 0, 0, _yy, 100, 18, _foto_x + _sh, _foto_y + _yy, 0.9, 0.9, c_white, 1);
    }
}

// --- DESENHAR O TEXTO ---
if (estado == "ativo") {
    var _txt_x = _foto_x + 120;
    var _txt_y = _y1 + 40;
    var _str = string_copy(textos[pagina_atual], 1, floor(tamanho_texto));
    
    // Sombra de glitch muito sutil (apenas 1 pixel de desvio)
    draw_set_color(c_red);
    draw_text(_txt_x + 1, _txt_y + 1, _str);
    
    draw_set_color(c_white);
    draw_text(_txt_x, _txt_y, _str);
    
    // Cursor fixo ou piscando devagar
    if (current_time % 600 < 300) {
        draw_text(_txt_x + string_width(_str), _txt_y, "█");
    }
}

draw_set_color(c_white);