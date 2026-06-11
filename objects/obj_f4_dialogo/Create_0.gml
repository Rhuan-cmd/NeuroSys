audio_room_enter("fase4");
textos = [
    "Você bloqueou o enxame de mensagens, mas encontrou a origem dos ataques. Agora a pressão digital tenta ocupar toda a tela.",
    "Nem sei por que você continua tentando... ninguém se importa.",
    "Use W, A, S, D ou as SETAS para mover a nave. Desvie dos ataques e escolha seu espaço antes de reagir.",
    "Pressione K para disparar. Seu objetivo é enfraquecer a fonte dos ataques sem deixar sua resistência chegar a zero.",
    "Cada resposta responsável interrompe parte do ciclo. Este é o confronto final: proteja a rede e encerre a perseguição."
];
pagina_atual = 0;
tamanho_texto = 0;
velocidade_texto = 0.5;
entrada_fade = 1;
audio_stop_sound(snd_f4_cutscene);
cutscene_audio = ns_audio_play_music(snd_f4_cutscene, 1, true, 0.62, 0, 1);
glitch_timer = 0;
troca_audio_timer = 0;

sprite_rosto = spr_f4_vilao;
abertura = 0; 
estado = "";

// Variáveis de borda
pontos_borda = 14;
offsets_borda = array_create(pontos_borda, 0); 
intensidade_glitch = 4;

alarm[0] = ceil(room_speed * 2.4);

if (variable_global_exists("op_pular_dialogo_retry") && global.op_pular_dialogo_retry && variable_global_exists("retry_room") && global.retry_room == room) {
    global.retry_room = -1;
    alarm[0] = -1;
    estado = "skip_retry";
    abertura = 0;
    pagina_atual = array_length(textos) - 1;
    tamanho_texto = string_length(textos[pagina_atual]);
    ns_audio_gain_music(cutscene_audio, 0, 900);
    var _musica_retry = ns_audio_play_music(snd_f4_musica_chefe, 1, true, 0, 0, 1);
    ns_audio_gain_music(_musica_retry, 0.82, 900);
    troca_audio_timer = ceil(room_speed * 1.0);
}
