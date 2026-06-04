if (instance_exists(obj_f3_escudo) && obj_f3_escudo.vitoria_cutscene_ativa) {
    exit;
}

tremer = false;
image_blend = c_white;
speed = 10;
zoom_alvo = 1;
if (instance_exists(obj_f3_escudo)) obj_f3_escudo.exibir_resultado(true);
