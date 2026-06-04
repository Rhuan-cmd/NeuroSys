var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var t = clamp(timer / duracao, 0, 1);
var suave = t * t * (3 - 2 * t);
var puxao = suave * suave;

draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

var tremor = sin(timer * 0.21) * clamp((t - 0.18) / 0.55, 0, 1) * 1.8;
var escala = lerp(1, 10.2, puxao);
var alvo_x = lerp(gui_w * 0.5, monitor_x + tremor, 0.08 + puxao * 0.92);
var alvo_y = lerp(gui_h * 0.5, monitor_y + tremor * 0.35, 0.08 + puxao * 0.92);
var draw_x = gui_w * 0.5 - alvo_x * escala;
var draw_y = gui_h * 0.5 - alvo_y * escala;

draw_sprite_ext(spr_menu_fundo, floor((timer * 0.35) mod sprite_get_number(spr_menu_fundo)), draw_x, draw_y, escala, escala, 0, c_white, 1);

draw_set_alpha(clamp((t - 0.20) / 0.52, 0, 1) * 0.48);
draw_set_color(make_color_rgb(106, 184, 255));
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_alpha(clamp((t - 0.66) / 0.24, 0, 1) * 0.94);
draw_set_color(c_white);
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_alpha(clamp((t - 0.88) / 0.12, 0, 1));
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

draw_set_alpha(1);
draw_set_color(c_white);
