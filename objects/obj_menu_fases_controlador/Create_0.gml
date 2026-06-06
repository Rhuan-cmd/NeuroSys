menu_timer = 0;
audio_room_enter("menu_fases");
audio_menu_iniciar(0.36);
hover = -1;
hover_anterior = -1;
sino_cliques = 0;
negado_card = -1;
negado_timer = 0;
entrando_fase = false;
retornando_fase = false;
fase_escolhida = -1;
transicao_post_timer = 0;
transicao_post_dur = 207 + ceil(room_speed * 1.5);
transicao_audio_marca = -1;
transicao_preto_final = ceil(room_speed * 1.5);
transicao_alvo_x = 0;
transicao_alvo_y = 0;
retorno_timer = 0;
retorno_dur = 176;
voltar_hover = false;
voltar_hover_anterior = false;
voltando_menu = false;
fade_entrada_branco = 1;
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

if (variable_global_exists("menu_fases_retorno_fase") && global.menu_fases_retorno_fase >= 0) {
    retornando_fase = true;
    fase_escolhida = clamp(global.menu_fases_retorno_fase, 0, array_length(fase_nome) - 1);
    global.menu_fases_retorno_fase = -1;
    var _max_scroll_retorno = max(0, feed_altura - (feed_bottom - feed_top));
    scroll_alvo = clamp(fase_escolhida * (post_h + post_gap) - (feed_bottom - feed_top - post_h) * 0.5, 0, _max_scroll_retorno);
    scroll_y = scroll_alvo;
    var _card_y_retorno = feed_top + fase_escolhida * (post_h + post_gap) - scroll_y;
    transicao_alvo_x = feed_x + 18 + 53;
    transicao_alvo_y = clamp(_card_y_retorno + 62 + 29, feed_top + 29, feed_bottom - 29);
    retorno_timer = 0;
    transicao_audio_marca = -1;
    fade_entrada_branco = 0;
    global.transicao_ativa = true;
    audio_play_sfx(snd_f2_aparecer, 4, false, 0.58, 0, 0.68);
}

window_set_cursor(cr_none);
cursor_sprite = spr_ui_cursor;
if (!retornando_fase) global.transicao_ativa = false;
