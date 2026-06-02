timer = 0;
fade_entrada = 1;
fade_saida = 0;
creditos_inicio = room_speed * 1.8;
rolagem_velocidade = 0.86;
etapa_final = false;
timer_final = 0;
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

creditos = [
    { texto: "CYBERBULLYING GAME 2.0", cor: make_color_rgb(94, 238, 255), escala: 1.7, espaco: 118 },
    { texto: "A HISTÓRIA QUE ATRAVESSOU A TELA", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 78 },
    { texto: "PRÓLOGO", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 58 },
    { texto: "Tudo começou em uma tela aparentemente comum. Entre postagens, notificações e conversas rápidas, palavras cruéis passaram a se repetir até parecerem parte da paisagem digital.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "Mas nenhuma mensagem desaparece somente porque a janela foi fechada. Do outro lado da tela existe alguém que sente o peso de cada comentário, de cada ataque e de cada silêncio.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "FASE 1  INTERROMPER", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 58 },
    { texto: "Na primeira fase, você aprendeu a interromper ataques antes que eles ganhassem força. Cada corte representou uma escolha: não espalhar, não reforçar e não permitir que a agressão continue circulando.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "FASE 2  RESISTIR", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 58 },
    { texto: "Depois, o computador foi tomado por mensagens em cascata. Fechar a janela deixou de ser simples. A pressão cresceu, o cursor foi desafiado e ficou claro que ignorar o problema nem sempre basta.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "FASE 3  PROTEGER", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 58 },
    { texto: "Na terceira fase, a história revelou seu centro: uma pessoa cercada por hostilidade. O escudo não era apenas uma barreira. Ele simbolizava apoio, presença e a coragem de agir quando alguém precisa de ajuda.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "Cada mensagem bloqueada mostrou que a rede também pode ser ocupada por cuidado. Uma resposta responsável, uma denúncia e uma conversa acolhedora podem mudar o rumo de uma história.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "FASE 4  CONFRONTAR", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 58 },
    { texto: "No confronto final, a agressão apareceu como uma força alimentada pela repetição. Ela parecia enorme porque cresceu com cada compartilhamento, cada curtida e cada pessoa que decidiu assistir sem intervir.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "EPÍLOGO", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 58 },
    { texto: "Ao interromper esse ciclo, você não apagou o que aconteceu. Mas abriu espaço para outra possibilidade: uma internet em que responsabilidade e empatia não sejam exceções.", cor: c_white, escala: 0.92, espaco: 108 },
    { texto: "A história termina aqui, mas a escolha continua fora do jogo. Antes de comentar, compartilhar ou permanecer em silêncio, lembre-se de que sempre existe alguém do outro lado da tela.", cor: make_color_rgb(172, 224, 255), escala: 0.96, espaco: 132 },
    { texto: "AGRADECIMENTOS", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 64 },
    { texto: "IFMA Campus Açailândia", cor: c_white, escala: 1, espaco: 50 },
    { texto: "ORIENTADOR", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 54 },
    { texto: "Valter dos Santos Mendonça Neto", cor: c_white, escala: 1, espaco: 64 },
    { texto: "CRIADORES", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 72 },
    { texto: "Hugo Oliveira Silva", cor: c_white, escala: 1, espaco: 54 },
    { texto: "Rhuan Gabriel Moura Brasilino", cor: c_white, escala: 1, espaco: 92 },
    { texto: "A todas as pessoas que escolhem tornar a internet um lugar mais humano.", cor: make_color_rgb(172, 224, 255), escala: 0.92, espaco: 112 }
];

creditos_altura = 0;
for (var _i = 0; _i < array_length(creditos); _i++) {
    creditos_altura += creditos[_i].espaco;
}
