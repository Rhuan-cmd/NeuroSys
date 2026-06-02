timer = 0;
fade_entrada = 1;
fade_saida = 0;
creditos_inicio = room_speed * 4.8;
encerrando = false;
audio_stop_all();
audio_play_sound(snd_f2_vitoria, 4, false, 0.95);

memorias = [
    spr_f2_fechar,
    spr_f3_npc,
    spr_f3_escudo,
    spr_f4_nave,
    spr_f4_vilao_chorando
];
