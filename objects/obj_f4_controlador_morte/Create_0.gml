alarm[0] = 30;
cont = 0;
desenhar = false;
mover = false;
ajeitar = false;
encerrando = false;
timer_encerramento = 0;
fade_saida = 0;
audio_fade_iniciado = false;
espera_fade = ceil(room_speed * 1.35);
duracao_fade = room_speed * 4.4;

foco_x = instance_exists(obj_f4_chefe) ? obj_f4_chefe.x : room_width / 2;
foco_y = instance_exists(obj_f4_chefe) ? obj_f4_chefe.y : room_height / 2;
foco_camera_x = foco_x + 78;
xboss = foco_x;
yboss = foco_y;
yvilaodestino = foco_y;

largura_base = 960;
altura_base = 540;
zoom_alvo = 0.62;
zoom_atual = 1;
velocidade_zoom = 0.055;
zoom = true;
