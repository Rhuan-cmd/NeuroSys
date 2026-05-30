if (!modo_intro) {
    for (var rastro_i = 0; rastro_i < 8; rastro_i++) {
        if (rastro_alpha[rastro_i] > 0) {
            var rastro_escala = image_xscale * (0.78 + rastro_alpha[rastro_i] * 0.12);
            draw_sprite_ext(
                spr_f2_close,
                0,
                rastro_x[rastro_i],
                rastro_y[rastro_i],
                rastro_escala,
                rastro_escala,
                image_angle,
                make_color_rgb(255, 82, 104),
                rastro_alpha[rastro_i] * 0.16
            );
        }
    }
}

draw_sprite_ext(
    spr_f2_close,
    0,
    x,
    y,
    image_xscale,
    image_yscale,
    image_angle,
    imortal_timer > 0 ? make_color_rgb(188, 225, 255) : c_white,
    image_alpha * (imortal_timer > 0 ? 0.62 + sin(current_time * 0.03) * 0.18 : 1)
);
