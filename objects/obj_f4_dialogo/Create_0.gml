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
cutscene_audio = audio_play_music(snd_f4_cutscene, 1, true, 0.62, 0, 1);
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
