shake_remain = 12 + (5 - atualizar_felicidade) * 3;
corrupt_flash = 1;
atualizar_felicidade -= 1;
instance_create_layer(0, 0, "layer_dano", obj_f3_controlador_dano);
audio_play_sound(snd_f3_dano, 1, 0, 2);
instance_destroy(other);
