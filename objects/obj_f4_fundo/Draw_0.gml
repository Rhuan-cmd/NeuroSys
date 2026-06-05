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
var tempo_onda = current_time / 200;

for (var i = 0; i < num_barras; i++) {
    var xx = inicio_x + (i * barra_w) - deslocamento_onda;
    
    if (xx > -barra_w && xx < room_width) {
        
        var onda1 = sin(tempo_onda + i * 0.2);
        var onda2 = sin(tempo_onda * 1.5 + i * 0.1);
        var onda3 = sin(tempo_onda * 0.5 + i * 0.4);
        
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

var _vidas_perdidas = instance_exists(obj_f4_nave) ? 4 - obj_f4_nave.vida : 0;
var _corrupcao = clamp(_vidas_perdidas / 4 + corrupt_flash * 0.42, 0, 1);
if (_corrupcao > 0) {
    var _frame = floor(current_time / 140) mod sprite_get_number(spr_fx_corrupcao);
    draw_sprite_ext(spr_fx_corrupcao, _frame, 0, 0, room_width / sprite_get_width(spr_fx_corrupcao), room_height / sprite_get_height(spr_fx_corrupcao), 0, c_white, 0.12 + _corrupcao * 0.38);
}

if (resultado_ativo) {
    var _suave = resultado_transicao * resultado_transicao * (3 - 2 * resultado_transicao);
    var _offset = lerp(38, 0, _suave);
    var _cor = resultado_vitoria ? make_color_rgb(55, 222, 242) : make_color_rgb(255, 78, 105);
    var _mouse_gui_x = device_mouse_x_to_gui(0);
    var _mouse_gui_y = device_mouse_y_to_gui(0);
    var _hover_menu = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 312, 375 + _offset, 454, 411 + _offset);
    var _hover_reiniciar = point_in_rectangle(_mouse_gui_x, _mouse_gui_y, 506, 375 + _offset, 648, 411 + _offset);
    var _segundos = max(0, floor(resultado_tempo / room_speed));
    var _tempo_txt = string(floor(_segundos / 60)) + ":" + ((_segundos mod 60) < 10 ? "0" : "") + string(_segundos mod 60);

    draw_set_alpha(0.86);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(0.22 * _suave);
    draw_set_color(_cor);
    for (var _scan = 0; _scan < room_height; _scan += 22) {
        draw_rectangle(0, _scan + _offset * 0.25, room_width, _scan + 2 + _offset * 0.25, false);
    }
    draw_set_alpha(_suave);
    draw_sprite_ext(spr_f4_painel_resultado, 1, 480, 270 + _offset, 1, 1, 0, c_white, _suave);
    draw_set_font(fnt_dialogo);
    draw_set_halign(fa_center);
    draw_set_color(_cor);
    draw_text_transformed(480, 142 + _offset, "CONEXÃO PERDIDA", 1.12, 1.12, 0);
    draw_set_color(make_color_rgb(167, 192, 224));
    draw_text(480, 158 + _offset, "a pressão digital venceu esta tentativa");
    var _rotulos = ["NOTA", "ACERTOS", "TEMPO"];
    var _valores = [resultado_nota, string(resultado_acertos) + "/500", _tempo_txt];
    for (var _card = 0; _card < 3; _card++) {
        var _x1 = 264 + _card * 148;
        var _x2 = _x1 + 136;
        draw_set_alpha(0.22 * _suave);
        draw_set_color(_cor);
        draw_rectangle(_x1 - 3, 246 + _offset, _x2 + 3, 326 + _offset, false);
        draw_set_alpha(0.94 * _suave);
        draw_set_color(make_color_rgb(18, 12, 28));
        draw_rectangle(_x1, 249 + _offset, _x2, 323 + _offset, false);
        draw_set_color(_cor);
        draw_text(_x1 + 68, 266 + _offset, _rotulos[_card]);
        draw_set_color(c_white);
        draw_text_transformed(_x1 + 68, 296 + _offset, _valores[_card], 1.08, 1.08, 0);
    }
    draw_set_color(_hover_menu ? make_color_rgb(255, 241, 145) : c_white);
    draw_set_halign(fa_center);
    draw_text(383, 384 + _offset, "MENU");
    draw_set_color(_hover_reiniciar ? make_color_rgb(255, 241, 145) : c_white);
    draw_text(577, 384 + _offset, "REINICIAR");
    if (resultado_saida_fade > 0) {
        draw_set_alpha(resultado_saida_fade);
        draw_set_color(c_black);
        draw_rectangle(0, 0, room_width, room_height, false);
    }
    draw_set_halign(fa_left);
    draw_set_alpha(1);
    draw_set_color(c_white);
}
