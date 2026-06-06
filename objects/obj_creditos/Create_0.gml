timer = 0;
audio_room_enter("creditos");
fade_entrada = 1;
fade_saida = 0;
creditos_inicio = room_speed * 1.8;
rolagem_velocidade = 0.32;
creditos_scroll = 0;
etapa_final = false;
timer_final = 0;
encerrando = false;
creditos_visto_antes = variable_global_exists("creditos_vistos") && global.creditos_vistos;
creditos_salvo = false;
espaco_duplo_timer = 0;
audio_play_music(snd_creditos_musica, 4, true, 0.78);

memorias = [
    spr_f2_fechar,
    spr_f3_npc,
    spr_f3_escudo,
    spr_f4_nave,
    spr_f4_vilao_chorando
];

creditos = [
    { texto: "NEUROSYS", cor: make_color_rgb(94, 238, 255), escala: 1.7, espaco: 118 },
    { texto: "A HISTÓRIA QUE ATRAVESSOU A TELA", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 78 },
    { texto: "PRÓLOGO", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Tudo começou em uma tela aparentemente comum. Entre postagens, notificações e conversas rápidas, palavras cruéis passaram a se repetir até parecerem parte da paisagem digital.\nMas nenhuma mensagem desaparece somente porque a janela foi fechada. Do outro lado da tela existe alguém que sente o peso de cada comentário, de cada ataque e de cada silêncio.", cor: c_white, escala: 0.92, espaco: 150 },
    { texto: "FASE 1  FILTRO DE RESPEITO", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Na primeira fase, você aprendeu a interromper ataques antes que eles ganhassem força. Cada corte representou uma escolha: não espalhar, não reforçar e não permitir que a agressão continue circulando.", cor: c_white, escala: 0.92, espaco: 104 },
    { texto: "FASE 2  CHAT EM SOBRECARGA", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Depois, o computador foi tomado por mensagens em cascata. Fechar a janela deixou de ser simples. A pressão cresceu, o cursor foi desafiado e ficou claro que ignorar o problema nem sempre basta.", cor: c_white, escala: 0.92, espaco: 104 },
    { texto: "FASE 3  REDE DE APOIO", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Na terceira fase, a história revelou seu centro: uma pessoa cercada por hostilidade. O escudo não era apenas uma barreira. Ele simbolizava apoio, presença e a coragem de agir quando alguém precisa de ajuda.\nCada mensagem bloqueada mostrou que a rede também pode ser ocupada por cuidado. Uma resposta responsável, uma denúncia e uma conversa acolhedora podem mudar o rumo de uma história.", cor: c_white, escala: 0.92, espaco: 150 },
    { texto: "FASE 4  CONFRONTO FINAL", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "No confronto final, a agressão apareceu como uma força alimentada pela repetição. Ela parecia enorme porque cresceu com cada compartilhamento, cada curtida e cada pessoa que decidiu assistir sem intervir.", cor: c_white, escala: 0.92, espaco: 104 },
    { texto: "EPÍLOGO", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Ao interromper esse ciclo, você não apagou o que aconteceu. Mas abriu espaço para outra possibilidade: uma internet em que responsabilidade e empatia não sejam exceções.\nA história termina aqui, mas a escolha continua fora do jogo. Antes de comentar, compartilhar ou permanecer em silêncio, lembre-se de que sempre existe alguém do outro lado da tela.", cor: make_color_rgb(172, 224, 255), escala: 0.96, espaco: 164 },
    { texto: "AGRADECIMENTOS", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Instituto Federal de Educação, Ciência e Tecnologia do Maranhão - Campus Açailândia", cor: make_color_rgb(82, 214, 128), escala: 1, espaco: 74 },
    { texto: "FONTES", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Materiais jornalisticos e documentais inspirados em canais de informacao da Globo, SBT, Band e Record, usados como referencia para contextualizar o impacto real da violencia digital e do cyberbullying.", cor: c_white, escala: 0.92, espaco: 118 },
    { texto: "ORIENTADOR", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Valter dos Santos Mendonça Neto", cor: c_white, escala: 1, espaco: 68 },
    { texto: "CRIADORES", cor: make_color_rgb(255, 232, 138), escala: 1.18, espaco: 42 },
    { texto: "Hugo Oliveira Silva\nRhuan Gabriel Moura Brasilino", cor: c_white, escala: 1, espaco: 92 },
    { texto: "A todas as pessoas que escolhem tornar a internet um lugar mais humano.", cor: make_color_rgb(172, 224, 255), escala: 0.92, espaco: 112 }
];

creditos_altura = 0;
for (var _i = 0; _i < array_length(creditos); _i++) {
    creditos_altura += creditos[_i].espaco;
}
