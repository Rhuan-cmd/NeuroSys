menu_timer = 0;
hover = -1;
hover_anterior = -1;
voltando_menu = false;
fade_saida_branco = 0;
scroll_y = 0;
scroll_alvo = 0;
post_x = 248;
post_w = 464;
post_h = 178;
post_gap = 28;
feed_top = 118;
feed_bottom = 486;
feed_altura = 4 * (post_h + post_gap) + 90;

fase_nome = [
    "Filtro de Respeito",
    "Chat em Sobrecarga",
    "Rede de Apoio",
    "Confronto Final"
];
fase_tag = [
    "@conecta.alerta",
    "@chat.comunidade",
    "@apoio.digital",
    "@neurosys.final"
];
fase_desc = [
    "Corte ataques antes que eles se espalhem pela rede.",
    "Controle o caos do chat e proteja a conversa.",
    "Bloqueie mensagens hostis e preserve a pessoa atacada.",
    "Enfrente a origem da pressao digital."
];
fase_room = [rm_fase1, rm_fase2, rm_fase3, rm_fase4];
fase_foto = [spr_app_rede_social, spr_f2_fundo_chat, spr_f3_npc, spr_f4_chefe];

window_set_cursor(cr_default);
cursor_sprite = cr_default;
