if (instance_exists(obj_f4_controlador_morte)) exit;
if (instance_exists(obj_f4_fundo) && obj_f4_fundo.vitoria_em_andamento) exit;
if (instance_exists(obj_f4_chefe) && (obj_f4_chefe.morto || obj_f4_chefe.vida <= 0)) exit;
if (instance_exists(obj_f4_fundo)) obj_f4_fundo.exibir_resultado(false);
