shake_remain = 10;
atualizar_felicidade -= 1;
flash_vermelho = 1;
audio_play_sound(snd_damage, 1, 0, 2);
instance_destroy(other);