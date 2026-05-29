shake_remain = 10;
atualizar_felicidade -= 1;
instance_create_layer(0, 0, "layer_dano", obj_controller_dano);
audio_play_sound(snd_damage, 1, 0, 2);
instance_destroy(other);