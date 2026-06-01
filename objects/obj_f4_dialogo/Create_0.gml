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

sprite_rosto = spr_f4_vilao;
abertura = 0; 
estado = "";

// Variáveis de borda
pontos_borda = 20; 
offsets_borda = array_create(pontos_borda, 0); 
intensidade_glitch = 4;

alarm[0] = 72;
