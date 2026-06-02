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

if (resultado_ativo) {
    var _suave = resultado_transicao * resultado_transicao * (3 - 2 * resultado_transicao);
    var _offset = lerp(36, 0, _suave);
    var _cor = resultado_vitoria ? make_color_rgb(55, 222, 242) : make_color_rgb(255, 78, 105);
    var _hover_menu = point_in_rectangle(mouse_x, mouse_y, 302, 382 + _offset, 458, 420 + _offset);
    var _hover_reiniciar = point_in_rectangle(mouse_x, mouse_y, 502, 382 + _offset, 658, 420 + _offset);

    draw_set_alpha(0.86);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(_suave);
    draw_set_color(make_color_rgb(6, 17, 33));
    draw_rectangle(204, 116 + _offset, 756, 438 + _offset, false);
    draw_set_color(_cor);
    draw_rectangle(204, 116 + _offset, 756, 120 + _offset, false);
    draw_rectangle(204, 434 + _offset, 756, 438 + _offset, false);
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_color(_cor);
    draw_text_transformed(480, 148 + _offset, resultado_vitoria ? "CICLO INTERROMPIDO" : "CONEXÃO PERDIDA", 1.24, 1.24, 0);
    draw_set_color(make_color_rgb(167, 192, 224));
    draw_text(480, 180 + _offset, resultado_vitoria ? "a rede pode respirar novamente" : "a pressão digital venceu esta tentativa");
    draw_set_halign(fa_left);
    draw_set_color(make_color_rgb(105, 224, 246));
    draw_text(278, 232 + _offset, "VIDAS RESTANTES");
    draw_text(278, 270 + _offset, "AMEAÇA RESTANTE");
    draw_text(278, 308 + _offset, "NOTA");
    draw_set_color(c_white);
    draw_text(512, 232 + _offset, string(resultado_vidas) + "/4");
    draw_text(512, 270 + _offset, string(resultado_chefe) + "%");
    draw_text(512, 308 + _offset, resultado_nota);
    draw_set_color(_hover_menu ? make_color_rgb(255, 241, 145) : c_white);
    draw_rectangle(302, 382 + _offset, 458, 420 + _offset, true);
    draw_set_halign(fa_center);
    draw_text(380, 394 + _offset, "MENU");
    draw_set_color(_hover_reiniciar ? make_color_rgb(255, 241, 145) : c_white);
    draw_rectangle(502, 382 + _offset, 658, 420 + _offset, true);
    draw_text(580, 394 + _offset, "REINICIAR");
    draw_set_halign(fa_left);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
