menu_timer = 0;
audio_room_enter("menu_fases");
audio_menu_iniciar(0.36);

if (!variable_global_exists("op_volume")) global.op_volume = 1;
if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
if (!variable_global_exists("op_volume_efeitos")) global.op_volume_efeitos = 1;
if (!variable_global_exists("op_som_preset")) global.op_som_preset = 3;
if (!variable_global_exists("op_graficos")) global.op_graficos = 2;
if (!variable_global_exists("op_pixel_perfect")) global.op_pixel_perfect = true;
if (!variable_global_exists("op_pixel_perfect_nivel")) global.op_pixel_perfect_nivel = global.op_pixel_perfect ? 1 : 0;
if (!variable_global_exists("op_resolucao")) global.op_resolucao = 3;
if (!variable_global_exists("op_tela")) global.op_tela = 1;
if (!variable_global_exists("op_mostrar_save_aviso")) global.op_mostrar_save_aviso = true;
if (!variable_global_exists("op_mostrar_cards_dicas")) global.op_mostrar_cards_dicas = true;
if (!variable_global_exists("op_pular_dialogo_retry")) global.op_pular_dialogo_retry = false;

aba = 0;
hover_aba = -1;
hover_aba_anterior = -1;
hover_item = -1;
hover_item_anterior = -1;
hover_reset = -1;
hover_reset_anterior = -1;
hover_pixel = -1;
hover_pixel_anterior = -1;
confirmar_reset = -1;
hover_confirmar_reset = -1;
hover_confirmar_reset_anterior = -1;
reset_feedback_timer = 0;
reset_feedback_texto = "";
arrastando_volume = false;
arrastando_audio = -1;
voltar_hover = false;
voltar_hover_anterior = false;
voltando_menu = false;
fade_entrada_branco = 1;
fade_saida_branco = 0;
anim_brilho = 0;

abas = ["GRÁFICOS", "SOM", "RESOLUÇÃO", "TELA", "SISTEMA"];
grafico_opcoes = ["BAIXO", "EQUILIBRADO", "ALTO"];
pixel_opcoes = ["BAIXO", "MÉDIO", "ALTO"];
som_opcoes = ["MUDO", "BAIXO", "MÉDIO", "ALTO"];
som_valores = [0, 0.35, 0.65, 1];
res_opcoes = ["960 x 540", "1280 x 720", "1600 x 900", "1920 x 1080"];
res_w = [960, 1280, 1600, 1920];
res_h = [540, 720, 900, 1080];
tela_opcoes = ["JANELA", "TELA CHEIA"];
save_aviso_opcoes = ["MOSTRAR", "OCULTAR"];
sistema_linhas = ["AVISO DE SAVE", "CARDS DE DICAS", "PULAR DIÁLOGO NO RETRY"];
sistema_opcoes = ["SIM", "NÃO"];

voltar_x = 126;
voltar_y = display_get_gui_height() - 62;
voltar_w = 150;
voltar_h = 74;

window_set_cursor(cr_none);
cursor_sprite = spr_ui_cursor;
ns_audio_aplicar_opcoes();
if (variable_global_exists("audio_menu_musica") && global.audio_menu_musica != -1 && audio_is_playing(global.audio_menu_musica)) {
    ns_audio_gain_music(global.audio_menu_musica, 0.36, 0);
}
