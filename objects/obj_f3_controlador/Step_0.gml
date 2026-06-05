entrada_fade = max(0, entrada_fade - 1 / (room_speed * 2.3));

if (introducao_ativa && entrada_fade <= 0.72) {
    dialogo_abertura = lerp(dialogo_abertura, 1, 0.14);
    var _texto = dialogo_textos[dialogo_index];
    if (dialogo_chars < string_length(_texto)) {
        var _chars_antes = floor(dialogo_chars);
        dialogo_chars = min(string_length(_texto), dialogo_chars + dialogo_velocidade);
        dialogo_audio_timer = max(0, dialogo_audio_timer - 1);
        if (floor(dialogo_chars) > _chars_antes && dialogo_audio_timer <= 0) {
            audio_play_sound(snd_f2_digitacao, 2, false, 0.18, 0, random_range(0.96, 1.05));
            dialogo_audio_timer = 3;
        }
    }

    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        if (dialogo_chars < string_length(_texto)) {
            dialogo_chars = string_length(_texto);
        } else {
            dialogo_index++;
            dialogo_chars = 0;
            dialogo_audio_timer = 0;
            if (dialogo_index >= array_length(dialogo_textos)) {
                instance_create_layer(0, 0, layer, obj_f3_controlador_msg);
                introducao_ativa = false;
                excluir = true;
            }
        }
    }
}

if (excluir) {
    alpha = lerp(alpha, 0, 0.1);
    if (alpha <= 0.1) instance_destroy();
}
