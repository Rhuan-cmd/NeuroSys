timer = 0;
fade_entrada = 1;
fade_saida = 0;
creditos_inicio = room_speed * 1.8;
rolagem_velocidade = 0.78;
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
    { texto: "A HISTORIA QUE ATRAVESSOU A TELA", cor: make_color_rgb(255, 232, 138), escala: 1.12, espaco: 104 },
    { texto: "Tudo comecou em uma tela aparentemente comum. Entre postagens, notificacoes e conversas rapidas, palavras crueis passaram a se repetir ate parecerem parte da paisagem digital.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "Mas nenhuma mensagem desaparece somente porque a janela foi fechada. Do outro lado da tela existe alguem que sente o peso de cada comentario, de cada ataque e de cada silencio.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "Na primeira fase, voce aprendeu a interromper ataques antes que eles ganhassem forca. Cada corte representou uma escolha: nao espalhar, nao reforcar e nao permitir que a agressao continue circulando.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "Depois, o computador foi tomado por mensagens em cascata. Fechar a janela deixou de ser simples. A pressao cresceu, o cursor foi desafiado e ficou claro que ignorar o problema nem sempre basta.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "Na terceira fase, a historia revelou seu centro: uma pessoa cercada por hostilidade. O escudo nao era apenas uma barreira. Ele simbolizava apoio, presenca e a coragem de agir quando alguem precisa de ajuda.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "Cada mensagem bloqueada mostrou que a rede tambem pode ser ocupada por cuidado. Uma resposta responsavel, uma denuncia e uma conversa acolhedora podem mudar o rumo de uma historia.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "No confronto final, a agressao apareceu como uma forca alimentada pela repeticao. Ela parecia enorme porque cresceu com cada compartilhamento, cada curtida e cada pessoa que decidiu assistir sem intervir.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "Ao interromper esse ciclo, voce nao apagou o que aconteceu. Mas abriu espaco para outra possibilidade: uma internet em que responsabilidade e empatia nao sejam excecoes.", cor: c_white, escala: 0.92, espaco: 142 },
    { texto: "A historia termina aqui, mas a escolha continua fora do jogo. Antes de comentar, compartilhar ou permanecer em silencio, lembre-se de que sempre existe alguem do outro lado da tela.", cor: make_color_rgb(172, 224, 255), escala: 0.96, espaco: 190 },
    { texto: "AGRADECIMENTOS", cor: make_color_rgb(255, 232, 138), escala: 1.35, espaco: 92 },
    { texto: "IFMA Campus Acailandia", cor: c_white, escala: 1, espaco: 58 },
    { texto: "Orientador", cor: make_color_rgb(172, 199, 230), escala: 0.86, espaco: 42 },
    { texto: "Valter dos Santos Mendonca Neto", cor: c_white, escala: 1, espaco: 82 },
    { texto: "CRIADORES", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 72 },
    { texto: "Hugo Oliveira Silva", cor: c_white, escala: 1, espaco: 54 },
    { texto: "Rhuan Gabriel Moura Brasilino", cor: c_white, escala: 1, espaco: 92 },
    { texto: "A todas as pessoas que escolhem tornar a internet um lugar mais humano.", cor: make_color_rgb(172, 224, 255), escala: 0.92, espaco: 160 }
];

creditos_altura = 0;
for (var _i = 0; _i < array_length(creditos); _i++) {
    creditos_altura += creditos[_i].espaco;
}
