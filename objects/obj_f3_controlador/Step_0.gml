entrada_fade = max(0, entrada_fade - 1 / (room_speed * 2.3));

if (introducao_ativa && entrada_fade <= 0.72) {
    dialogo_abertura = lerp(dialogo_abertura, 1, 0.14);
    var _texto = dialogo_textos[dialogo_index];
    if (dialogo_chars < string_length(_texto)) {
        dialogo_chars = min(string_length(_texto), dialogo_chars + dialogo_velocidade);
    }

    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        if (dialogo_chars < string_length(_texto)) {
            dialogo_chars = string_length(_texto);
        } else {
            dialogo_index++;
            dialogo_chars = 0;
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
