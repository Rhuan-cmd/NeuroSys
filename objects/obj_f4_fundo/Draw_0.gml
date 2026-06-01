// ==========================================
// 1. FUNDO GRADIENTE ANIMADO (TELA INTEIRA)
// ==========================================
var tempo_cor = get_timer() / 3000000; 
var blend = (sin(tempo_cor) + 1) / 2; 

var cor_topo = merge_color(make_color_rgb(0, 0, 10), make_color_rgb(10, 0, 25), blend);
var cor_horizonte = merge_color(make_color_rgb(40, 0, 100), make_color_rgb(60, 0, 130), blend);

// Agora o retângulo vai do topo (0) até a base da tela (room_height)
draw_rectangle_color(0, 0, room_width, room_height, cor_topo, cor_topo, cor_horizonte, cor_horizonte, false);

// ==========================================
// 2. POEIRA 3D EM DIREÇÃO À CÂMERA
// ==========================================
draw_set_color(c_white);
var centro_x = room_width / 2;

for (var i = 0; i < num_poeiras; i++) {
    var dz = poeira_z[i]; 
    
    var px = centro_x + (poeira_x[i] - centro_x - (camera_offset_x * 0.2)) / dz;
    var py = poeira_y[i] + (poeira_y[i] - horizon_y) / dz; 
    
    if (px > 0 && px < room_width && py > 0 && py < horizon_y) {
        var escala = clamp(2 / dz, 0.5, 4); 
        var alfa = clamp(2 - dz, 0, 0.6);   // Deixei o brilho máximo em 0.6 para ficar sutil
        
        draw_set_alpha(alfa);
        draw_circle(px, py, escala, false);
    }
}
draw_set_alpha(1);

// ==========================================
// 3. ONDAS DE ÁUDIO ORGÂNICAS E VASTAS
// ==========================================
draw_set_color(c_aqua);

var inicio_x = -(room_width / 2); 
var deslocamento_onda = camera_offset_x * 0.4; 

for (var i = 0; i < num_barras; i++) {
    var xx = inicio_x + (i * barra_w) - deslocamento_onda;
    
    if (xx > -barra_w && xx < room_width) {
        
        var tempo = get_timer() / 200000;
        
        var onda1 = sin(tempo + i * 0.2);
        var onda2 = sin(tempo * 1.5 + i * 0.1);
        var onda3 = sin(tempo * 0.5 + i * 0.4);
        
        var onda_final = (onda1 + onda2 + onda3) / 3;
        var wave_h = round(25 + (onda_final * 20));
        
        draw_set_alpha(0.7);
        draw_rectangle(round(xx), horizon_y - wave_h, round(xx + barra_w - 2), horizon_y, false);
        
        draw_set_alpha(1);
        draw_rectangle(round(xx), horizon_y - wave_h, round(xx + barra_w - 2), horizon_y - wave_h + 3, false);
    }
}

// Linha demarcando o horizonte final (Brilho intenso)
draw_set_color(c_white);
draw_set_alpha(0.8);
draw_line_width(0, horizon_y, room_width, horizon_y, 2);
draw_set_alpha(1);