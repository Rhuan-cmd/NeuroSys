var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var cx = gui_w * 0.5;
var cy = gui_h * 0.5;
var phase_alpha = global.intro_phase_alpha;

draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

if ((global.intro_phase >= 0 && global.intro_phase <= 2) || global.intro_phase == 4) {
    draw_set_color(make_color_rgb(4, 8, 14));
    draw_rectangle(0, 0, gui_w, gui_h, false);

    for (var scan_y = -18; scan_y < gui_h; scan_y += 18) {
        var yy = scan_y + scan_offset;
        draw_set_alpha(0.05 * phase_alpha);
        draw_set_color(make_color_rgb(70, 210, 230));
        draw_line(0, yy, gui_w, yy);
    }
}

draw_set_font(fnt_f2_dialogo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (global.intro_phase == 0) {
    var logo_scale = 0.38;
    var logo_w = sprite_get_width(spr_c_ifma_logo) * logo_scale;
    var logo_x = cx - logo_w * 0.5;
    var logo_y = cy - 190 + (1 - phase_alpha) * 16;

    draw_set_alpha(phase_alpha);
    draw_sprite_ext(spr_c_ifma_logo, 0, logo_x, logo_y, logo_scale, logo_scale, 0, c_white, phase_alpha);

    draw_set_color(c_white);
    draw_text_transformed(cx, cy + 34, "INSTITUTO FEDERAL", 2, 2, 0);
    draw_set_color(make_color_rgb(31, 214, 181));
    draw_text_transformed(cx, cy + 88, "Maranhão", 2, 2, 0);
    draw_set_color(make_color_rgb(195, 232, 236));
    draw_text_transformed(cx, cy + 132, "Campus Açailândia", 1, 1, 0);
}

if (global.intro_phase == 4) {
    var _video_frame = video_draw();
    intro_video_draw_status = -1;
    var _surface = -1;
    if (is_array(_video_frame) && array_length(_video_frame) > 0) {
        intro_video_draw_status = _video_frame[0];
        if (intro_video_draw_status == 0 && array_length(_video_frame) > 1) {
            _surface = _video_frame[1];
        }
    }

    if (surface_exists(_surface)) {
        var _surface_w = max(1, surface_get_width(_surface));
        var _surface_h = max(1, surface_get_height(_surface));
        var _scale = max(gui_w / _surface_w, gui_h / _surface_h);
        var _draw_w = _surface_w * _scale;
        var _draw_h = _surface_h * _scale;
        draw_set_alpha(phase_alpha);
        draw_surface_stretched(_surface, (gui_w - _draw_w) * 0.5, (gui_h - _draw_h) * 0.5, _draw_w, _draw_h);
    } else {
        draw_set_alpha(phase_alpha);
        draw_set_color(make_color_rgb(7, 12, 22));
        draw_rectangle(0, 0, gui_w, gui_h, false);
        if (!intro_video_ready) {
            draw_set_color(make_color_rgb(145, 204, 230));
            draw_text(cx, cy, "carregando video...");
        }
    }

    if (intro_video_ready && intro_video_hint_timer < room_speed * 5) {
        var _hint_alpha = phase_alpha * clamp((room_speed * 5 - intro_video_hint_timer) / room_speed, 0, 1);
        var _hint_bob = abs(sin(intro_video_hint_timer * 0.18)) * 7;
        var _hint_x1 = gui_w - 238;
        var _hint_y1 = gui_h - 92 - _hint_bob;
        var _hint_x2 = gui_w - 30;
        var _hint_y2 = gui_h - 28 - _hint_bob;
        draw_set_alpha(_hint_alpha * (0.72 + intro_skip_flash * 0.28));
        draw_set_color(make_color_rgb(5, 12, 22));
        draw_roundrect(_hint_x1, _hint_y1, _hint_x2, _hint_y2, false);
        draw_set_color(make_color_rgb(94, 238, 255));
        draw_roundrect(_hint_x1, _hint_y1, _hint_x2, _hint_y2, true);
        draw_set_color(c_white);
        draw_text(( _hint_x1 + _hint_x2) * 0.5, _hint_y1 + 23, "ENTER x2");
        draw_set_color(make_color_rgb(172, 198, 218));
        draw_text(( _hint_x1 + _hint_x2) * 0.5, _hint_y1 + 47, "pular video");
    }

    if (intro_video_encerrando) {
        draw_set_alpha(clamp(intro_video_fade_timer / max(1, room_speed * 0.8), 0, 1));
        draw_set_color(c_black);
        draw_rectangle(0, 0, gui_w, gui_h, false);
    }
}

if (global.intro_phase == 2) {
    var render_title = string_copy(title_text, 1, title_index);
    var render_subtitle = string_copy(subtitle_text, 1, subtitle_index);
    var render_status = string_copy(status_text, 1, status_index);
    var glitch_x = choose(-glitch_amount, 0, glitch_amount);
    var cursor_visible = (intro_timer div 18) mod 2 == 0;

    for (var node_i = 0; node_i < 14; node_i += 1) {
        var px = (node_i * 73 + intro_timer * (1 + (node_i mod 3))) mod gui_w;
        var py = 74 + ((node_i * 41 + intro_timer) mod (gui_h - 148));
        draw_set_alpha((0.08 + (node_i mod 3) * 0.03) * phase_alpha);
        draw_set_color(merge_color(make_color_rgb(31, 214, 181), make_color_rgb(242, 74, 124), (node_i mod 5) / 4));
        draw_circle(px, py, 2 + (node_i mod 3), false);
        draw_line(px - 18, py, px + 18, py);
        draw_line(px, py - 12, px, py + 12);
    }

    draw_set_alpha(phase_alpha * 0.65);
    draw_set_color(make_color_rgb(242, 74, 124));
    draw_text_transformed(cx + glitch_x + 3, cy - 34, render_title, 3, 3, 0);
    draw_set_color(make_color_rgb(31, 214, 181));
    draw_text_transformed(cx - glitch_x - 3, cy - 30, render_title, 3, 3, 0);

    draw_set_alpha(phase_alpha);
    draw_set_color(c_white);
    draw_text_transformed(cx, cy - 32 - type_pulse * 2, render_title, 3, 3, 0);

    if (cursor_visible && title_index < string_length(title_text)) {
        draw_set_color(make_color_rgb(31, 214, 181));
        draw_text_transformed(cx + string_width(render_title) * 1.5 + 18, cy - 32, "_", 3, 3, 0);
    }

    draw_set_color(make_color_rgb(31, 214, 181));
    draw_rectangle(cx - line_width * 0.5, cy + 32, cx + line_width * 0.5, cy + 35, false);

    draw_set_color(make_color_rgb(195, 232, 236));
    draw_text_transformed(cx, cy + 74, render_subtitle, 1, 1, 0);

    if (cursor_visible && title_index >= string_length(title_text) && subtitle_index < string_length(subtitle_text)) {
        draw_text_transformed(cx + string_width(render_subtitle) * 0.5 + 12, cy + 74, "_", 1, 1, 0);
    }

    draw_set_alpha(phase_alpha * 0.62);
    draw_set_color(make_color_rgb(242, 74, 124));
    draw_text_transformed(cx, cy + 116, render_status, 1, 1, 0);
}

if (global.intro_phase == 3) {
    draw_set_alpha(1);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

if (intro_video_finished && intro_timer >= intro_fade_out_start) {
    var fade_alpha = clamp((intro_timer - intro_fade_out_start) / (intro_fade_out_end - intro_fade_out_start), 0, 1);
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
