// Escala original (1 = 100%)
escala_alvo = 1;

scala_x = 1;
scala_y = 1;

fator_mola = 0.2;

destruidos = 0;

ganhou = false;
umavez = false;
resultado_ativo = false;
resultado_vitoria = false;
resultado_timer = 0;
resultado_fade = 0;
resultado_transicao = 0;
resultado_saida = 0;
resultado_tempo = 0;
resultado_nota = "0/10";
tempo_fase = 0;

exibir_resultado = function(_vitoria) {
	if (resultado_ativo) return;
	resultado_ativo = true;
	resultado_vitoria = _vitoria;
	resultado_timer = 0;
	resultado_fade = 0;
	resultado_transicao = 0;
	resultado_saida = 0;
	resultado_tempo = tempo_fase;
	resultado_nota = string(clamp(round((destruidos / 50) * 10), 0, 10)) + "/10";
	with (obj_f3_msg_negativa) instance_destroy();
	audio_stop_all();
	audio_play_sound(_vitoria ? snd_f2_vitoria : snd_f2_derrota, 4, false, _vitoria ? 0.95 : 0.86);
	instance_deactivate_all(true);
	instance_activate_object(obj_controlador_jogo);
};
