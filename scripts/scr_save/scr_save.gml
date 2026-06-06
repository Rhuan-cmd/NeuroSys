function save_init() {
    if (!variable_global_exists("save_arquivo")) global.save_arquivo = "neurosys_save.ini";
    if (!variable_global_exists("save_sujo")) global.save_sujo = false;
    if (!variable_global_exists("save_timer")) global.save_timer = 0;
    if (!variable_global_exists("save_aviso_timer")) global.save_aviso_timer = 0;
    if (!variable_global_exists("op_volume")) global.op_volume = 1;
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    if (!variable_global_exists("op_volume_efeitos")) global.op_volume_efeitos = 1;
    if (!variable_global_exists("op_som_preset")) global.op_som_preset = 3;
    if (!variable_global_exists("op_graficos")) global.op_graficos = 2;
    if (!variable_global_exists("op_resolucao")) global.op_resolucao = 3;
    if (!variable_global_exists("op_tela")) global.op_tela = 1;
    if (!variable_global_exists("fase_liberada")) global.fase_liberada = 1;
    if (!variable_global_exists("fase_concluida")) global.fase_concluida = 0;
    if (!variable_global_exists("creditos_vistos")) global.creditos_vistos = false;
}

function save_carregar() {
    save_init();
    if (!file_exists(global.save_arquivo)) {
        save_escrever();
        return;
    }

    ini_open(global.save_arquivo);
    global.op_volume = clamp(ini_read_real("config", "volume_geral", global.op_volume), 0, 1);
    global.op_volume_musica = clamp(ini_read_real("config", "volume_musica", global.op_volume_musica), 0, 1);
    global.op_volume_efeitos = clamp(ini_read_real("config", "volume_efeitos", global.op_volume_efeitos), 0, 1);
    global.op_som_preset = clamp(ini_read_real("config", "som_preset", global.op_som_preset), 0, 3);
    global.op_graficos = clamp(ini_read_real("config", "graficos", global.op_graficos), 0, 2);
    global.op_resolucao = clamp(ini_read_real("config", "resolucao", global.op_resolucao), 0, 3);
    global.op_tela = clamp(ini_read_real("config", "tela", global.op_tela), 0, 1);
    global.fase_liberada = clamp(ini_read_real("progresso", "fase_liberada", global.fase_liberada), 1, 4);
    global.fase_concluida = clamp(ini_read_real("progresso", "fase_concluida", global.fase_concluida), 0, 4);
    global.creditos_vistos = ini_read_real("progresso", "creditos_vistos", global.creditos_vistos ? 1 : 0) >= 1;
    ini_close();

    global.save_sujo = false;
}

function save_escrever() {
    save_init();
    ini_open(global.save_arquivo);
    ini_write_real("config", "volume_geral", variable_global_exists("op_volume") ? global.op_volume : 1);
    ini_write_real("config", "volume_musica", variable_global_exists("op_volume_musica") ? global.op_volume_musica : 1);
    ini_write_real("config", "volume_efeitos", variable_global_exists("op_volume_efeitos") ? global.op_volume_efeitos : 1);
    ini_write_real("config", "som_preset", variable_global_exists("op_som_preset") ? global.op_som_preset : 3);
    ini_write_real("config", "graficos", variable_global_exists("op_graficos") ? global.op_graficos : 2);
    ini_write_real("config", "resolucao", variable_global_exists("op_resolucao") ? global.op_resolucao : 3);
    ini_write_real("config", "tela", variable_global_exists("op_tela") ? global.op_tela : 1);
    ini_write_real("progresso", "fase_liberada", variable_global_exists("fase_liberada") ? global.fase_liberada : 1);
    ini_write_real("progresso", "fase_concluida", variable_global_exists("fase_concluida") ? global.fase_concluida : 0);
    ini_write_real("progresso", "creditos_vistos", variable_global_exists("creditos_vistos") && global.creditos_vistos ? 1 : 0);
    ini_close();
    global.save_sujo = false;
    global.save_aviso_timer = room_speed * 1.8;
}

function save_marcar_sujo() {
    save_init();
    global.save_sujo = true;
    save_escrever();
}

function save_resetar_progresso() {
    global.fase_liberada = 1;
    global.fase_concluida = 0;
    save_escrever();
}
