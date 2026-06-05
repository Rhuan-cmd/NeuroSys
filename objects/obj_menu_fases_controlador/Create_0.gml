menu_timer = 0;
audio_menu_iniciar(0.36);
hover = -1;
hover_anterior = -1;
negado_card = -1;
negado_timer = 0;
entrando_fase = false;
fase_escolhida = -1;
transicao_post_timer = 0;
transicao_post_dur = 44;
voltar_hover = false;
voltando_menu = false;
fade_saida_branco = 0;
scroll_y = 0;
scroll_alvo = 0;
app_x = 0;
app_y = 0;
app_w = display_get_gui_width();
app_h = display_get_gui_height();
feed_x = 304;
feed_w = max(520, app_w - feed_x - 20);
post_h = 132;
post_gap = 12;
feed_top = 70;
feed_bottom = app_h - 2;
voltar_x = 141;
voltar_y = app_h - 66;
voltar_w = 132;
voltar_h = 66;
voltar_sprite = spr_menu_btn_voltar;

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
