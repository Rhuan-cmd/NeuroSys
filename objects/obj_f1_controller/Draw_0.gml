var _pulso = 0.5 + sin(visual_timer * 0.12) * 0.5;
var _sx = shake > 0 ? random_range(-shake, shake) : 0;
var _sy = shake > 0 ? random_range(-shake * 0.5, shake * 0.5) : 0;

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// ===== MESA DIGITAL E MONITOR =====
draw_clear(make_color_rgb(4, 10, 20));
draw_set_color(make_color_rgb(8, 20, 38));
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(0.12);
draw_set_color(make_color_rgb(70, 191, 234));
for (var _linha = 0; _linha < room_height; _linha += 10) draw_line(0, _linha, room_width, _linha);
draw_set_alpha(1);

draw_set_color(make_color_rgb(3, 8, 17));
draw_roundrect(54 + _sx, 18 + _sy, 906 + _sx, 520 + _sy, false);
draw_set_color(make_color_rgb(25, 43, 65));
draw_roundrect(65 + _sx, 29 + _sy, 895 + _sx, 509 + _sy, false);
draw_set_color(make_color_rgb(4, 12, 24));
draw_rectangle(78 + _sx, 42 + _sy, 882 + _sx, 496 + _sy, false);
draw_set_color(make_color_rgb(70, 210, 232));
draw_circle(480 + _sx, 512 + _sy, 3 + _pulso * 1.5, false);

// ===== REDE SOCIAL CONECTA =====
draw_set_color(make_color_rgb(226, 237, 248));
draw_rectangle(91 + _sx, 54 + _sy, 869 + _sx, 484 + _sy, false);
draw_set_color(make_color_rgb(23, 51, 85));
draw_rectangle(91 + _sx, 54 + _sy, 869 + _sx, 104 + _sy, false);
draw_set_color(make_color_rgb(39, 211, 231));
draw_rectangle(91 + _sx, 101 + _sy, 869 + _sx, 104 + _sy, false);
draw_set_color(make_color_rgb(96, 237, 251));
draw_circle(127 + _sx, 79 + _sy, 15, true);
draw_circle(127 + _sx, 79 + _sy, 7, false);
draw_set_color(c_white);
draw_text_transformed(154 + _sx, 66 + _sy, "CONECTA", 1.04, 1.04, 0);
draw_set_color(make_color_rgb(131, 166, 201));
draw_text(699 + _sx, 68 + _sy, "rede segura");
draw_set_color(make_color_rgb(80, 232, 187));
draw_circle(837 + _sx, 79 + _sy, 6 + _pulso, false);

// ===== BARRA LATERAL =====
draw_set_color(make_color_rgb(16, 35, 61));
draw_rectangle(91 + _sx, 104 + _sy, 236 + _sx, 484 + _sy, false);
draw_set_color(make_color_rgb(82, 222, 236));
draw_text(115 + _sx, 126 + _sy, "FEED");
for (var _menu = 0; _menu < 5; _menu++) {
    var _menu_y = 168 + _menu * 43;
    draw_set_color(_menu == 0 ? make_color_rgb(37, 81, 112) : make_color_rgb(23, 52, 80));
    draw_roundrect(108 + _sx, _menu_y + _sy, 218 + _sx, _menu_y + 25 + _sy, false);
    draw_set_color(_menu == 0 ? make_color_rgb(111, 235, 244) : make_color_rgb(91, 130, 164));
    draw_circle(126 + _sx, _menu_y + 12 + _sy, 5, false);
    draw_rectangle(140 + _sx, _menu_y + 10 + _sy, 198 + _sx, _menu_y + 14 + _sy, false);
}

// ===== POSTAGEM DA LUNA =====
draw_set_color(make_color_rgb(250, 253, 255));
draw_roundrect(260 + _sx, 126 + _sy, 652 + _sx, 286 + _sy, false);
draw_set_color(make_color_rgb(221, 232, 242));
draw_roundrect(272 + _sx, 138 + _sy, 640 + _sx, 274 + _sy, true);
draw_set_color(make_color_rgb(51, 86, 119));
draw_circle(301 + _sx, 169 + _sy, 20, false);
draw_set_color(make_color_rgb(149, 218, 235));
draw_circle(301 + _sx, 164 + _sy, 8, false);
draw_roundrect(287 + _sx, 175 + _sy, 315 + _sx, 186 + _sy, false);
draw_set_color(make_color_rgb(34, 65, 96));
draw_text(337 + _sx, 145 + _sy, "@luna_online");
draw_set_color(make_color_rgb(94, 119, 145));
draw_text(337 + _sx, 174 + _sy, "Meu desenho novo. Ainda estou aprendendo :)");
draw_set_color(make_color_rgb(226, 236, 245));
draw_rectangle(282 + _sx, 216 + _sy, 630 + _sx, 219 + _sy, false);
draw_set_color(make_color_rgb(46, 139, 182));
draw_text(291 + _sx, 239 + _sy, "CURTIR    COMENTAR    APOIAR");

// ===== PAINEL DE MODERAÇÃO =====
draw_set_color(make_color_rgb(12, 29, 51));
draw_roundrect(676 + _sx, 126 + _sy, 846 + _sx, 286 + _sy, false);
draw_set_color(make_color_rgb(52, 202, 225));
draw_rectangle(676 + _sx, 126 + _sy, 846 + _sx, 131 + _sy, false);
draw_set_color(make_color_rgb(130, 232, 248));
draw_text(694 + _sx, 148 + _sy, "MODERACAO");
draw_set_color(make_color_rgb(151, 180, 205));
draw_text(694 + _sx, 183 + _sy, "Leia antes");
draw_text(694 + _sx, 204 + _sy, "de cortar.");
draw_set_color(make_color_rgb(85, 232, 185));
draw_text(694 + _sx, 243 + _sy, "DENUNCIA = ESCUDO");

// ===== CUTSCENE: COMENTARIOS E INTERACOES NA TELA =====
if (estado == 0 && dialogo_index >= 1) {
    draw_set_alpha(0.96);
    draw_set_color(make_color_rgb(163, 48, 73));
    draw_roundrect(286 + _sx, 304 + _sy, 600 + _sx, 344 + _sy, false);
    draw_set_color(c_white);
    draw_text(306 + _sx, 314 + _sy, "anonimo: apaga isso agora");
}
if (estado == 0 && dialogo_index >= 2) {
    draw_set_color(make_color_rgb(32, 139, 121));
    draw_roundrect(322 + _sx, 354 + _sy, 640 + _sx, 394 + _sy, false);
    draw_set_color(c_white);
    draw_text(342 + _sx, 364 + _sy, "bia: seu desenho ficou otimo!");
}
if (estado == 0 && dialogo_index >= 3) {
    draw_set_color(make_color_rgb(17, 40, 68));
    draw_roundrect(688 + _sx, 218 + _sy, 834 + _sx, 314 + _sy, false);
    draw_set_color(make_color_rgb(103, 225, 248));
    draw_text(704 + _sx, 232 + _sy, "ACOES");
    draw_set_color(make_color_rgb(41, 132, 177));
    draw_roundrect(702 + _sx, 260 + _sy, 820 + _sx, 292 + _sy, false);
    draw_set_color(c_white);
    draw_text(712 + _sx, 267 + _sy, "DENUNCIAR");
}
if (estado == 0 && dialogo_index >= 4) {
    draw_set_color(make_color_rgb(53, 46, 54));
    draw_roundrect(688 + _sx, 322 + _sy, 834 + _sx, 358 + _sy, false);
    draw_set_color(make_color_rgb(255, 196, 92));
    draw_text(702 + _sx, 329 + _sy, "COMPARTILHAR");
}

// ===== CARTÕES LANÇADOS =====
for (var _i = 0; _i < array_length(mensagens); _i++) {
    var _m = mensagens[_i];
    var _onda = sin(visual_timer * 0.22 + _m.fase) * 2.5;
    var _cor = make_color_rgb(191, 52, 78);
    var _borda = make_color_rgb(255, 122, 143);
    var _icone = "!";
    if (_m.tipo == 1) { _cor = make_color_rgb(35, 145, 126); _borda = make_color_rgb(115, 238, 197); _icone = "+"; }
    if (_m.tipo == 2) { _cor = make_color_rgb(30, 129, 183); _borda = make_color_rgb(118, 224, 255); _icone = "D"; }
    if (_m.tipo == 3) { _cor = make_color_rgb(42, 42, 59); _borda = make_color_rgb(255, 183, 83); _icone = "C"; }
    if (_m.forte) { _cor = make_color_rgb(137, 39, 103); _borda = make_color_rgb(255, 126, 213); }
    var _yy = _m.y + _onda;
    draw_set_alpha(0.2);
    draw_set_color(_borda);
    draw_roundrect(_m.x - _m.largura * 0.5 - 5, _yy - 29, _m.x + _m.largura * 0.5 + 5, _yy + 29, false);
    draw_set_alpha(1);
    draw_set_color(_cor);
    draw_roundrect(_m.x - _m.largura * 0.5, _yy - 24, _m.x + _m.largura * 0.5, _yy + 24, false);
    draw_set_color(_borda);
    draw_roundrect(_m.x - _m.largura * 0.5 + 3, _yy - 21, _m.x + _m.largura * 0.5 - 3, _yy + 21, true);
    draw_circle(_m.x - _m.largura * 0.5 + 25, _yy, 13, false);
    draw_set_color(_cor);
    draw_set_halign(fa_center);
    draw_text(_m.x - _m.largura * 0.5 + 25, _yy - 11, _icone);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text(_m.x - _m.largura * 0.5 + 48, _yy - 11, _m.texto);
    if (_m.forte) {
        draw_set_color(make_color_rgb(255, 214, 238));
        draw_text(_m.x + _m.largura * 0.5 - 38, _yy - 11, "x" + string(_m.hp));
    }
}

// ===== RASTRO DO CORTE E PARTÍCULAS =====
for (var _i = 0; _i < array_length(rastros); _i++) {
    var _r = rastros[_i];
    draw_set_alpha(_r.vida / 11);
    draw_set_color(make_color_rgb(118, 231, 255));
    draw_line_width(_r.x1, _r.y1, _r.x2, _r.y2, 2 + _r.vida * 0.3);
}
for (var _i = 0; _i < array_length(particulas); _i++) {
    var _p = particulas[_i];
    var _pcor = make_color_rgb(255, 93, 124);
    if (_p.tipo == 1) _pcor = make_color_rgb(95, 232, 180);
    if (_p.tipo == 2) _pcor = make_color_rgb(106, 218, 255);
    if (_p.tipo == 3) _pcor = make_color_rgb(255, 188, 86);
    draw_set_alpha(_p.vida / _p.maxvida);
    draw_set_color(_pcor);
    draw_circle(_p.x, _p.y, 2 + _p.vida * 0.06, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
