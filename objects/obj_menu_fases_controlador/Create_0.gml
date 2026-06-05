menu_timer = 0;
hover = -1;
hover_anterior = -1;
voltar_hover = false;
voltando_menu = false;
fade_saida_branco = 0;
scroll_y = 0;
scroll_alvo = 0;
app_x = 36;
app_y = 24;
app_w = 888;
app_h = 492;
feed_x = 270;
feed_w = 560;
post_h = 132;
post_gap = 12;
feed_top = 116;
feed_bottom = 488;
voltar_x = 142;
voltar_y = 466;
voltar_w = 96;
voltar_h = 48;
voltar_sprite = asset_get_index("spr_menu_btn_voltar");

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
    "Enfrente a origem da pressão digital."
];
fase_room = [rm_fase1, rm_fase2, rm_fase3, rm_fase4];
fase_foto = [spr_f4_perigo, spr_f2_fundo_chat, spr_f3_npc, spr_f4_chefe];
feed_altura = array_length(fase_nome) * (post_h + post_gap) - post_gap;

window_set_cursor(cr_default);
cursor_sprite = cr_default;
