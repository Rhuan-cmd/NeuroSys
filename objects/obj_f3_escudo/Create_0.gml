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
resultado_saida_fade = 0;
resultado_tempo = 0;
resultado_nota = "0/10";
hover_acao_anterior = false;
hover_reiniciar_anterior = false;
tempo_fase = 0;
vitoria_cutscene_ativa = false;
vitoria_cutscene_timer = 0;
vitoria_cutscene_fade = 0;
vitoria_audio_id = -1;

exibir_resultado = function(_vitoria) {
	if (resultado_ativo) return;
	vitoria_cutscene_ativa = false;
	resultado_ativo = true;
	resultado_vitoria = _vitoria;
	resultado_timer = 0;
	resultado_fade = _vitoria ? 1 : 0;
	resultado_transicao = _vitoria ? 0.001 : 0;
	resultado_saida = 0;
	resultado_saida_fade = 0;
	hover_acao_anterior = false;
	hover_reiniciar_anterior = false;
	resultado_tempo = tempo_fase;
	var _nota_limite = _vitoria ? 10 : 9;
	resultado_nota = string(clamp(round((destruidos / 50) * 10), 0, _nota_limite)) + "/10";
	with (obj_f3_msg_negativa) instance_destroy();
	audio_stop_all();
	audio_play_sfx(_vitoria ? snd_f2_vitoria : snd_f2_derrota, 4, false, _vitoria ? 0.95 : 0.86);
	if (_vitoria) {
		global.fase_liberada = max(variable_global_exists("fase_liberada") ? global.fase_liberada : 1, 4);
		global.fase_concluida = max(variable_global_exists("fase_concluida") ? global.fase_concluida : 0, 3);
	}
	instance_deactivate_all(true);
	instance_activate_object(obj_controlador_jogo);
};
