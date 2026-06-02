alarm[0] = 30;
cont = 0;
desenhar = false;
mover = false;
ajeitar = false;
encerrando = false;
timer_encerramento = 0;
fade_saida = 0;

foco_x = instance_exists(obj_f4_chefe) ? obj_f4_chefe.x : room_width / 2;
foco_y = instance_exists(obj_f4_chefe) ? obj_f4_chefe.y : room_height / 2;
xboss = foco_x;
yboss = foco_y;
yvilaodestino = foco_y;

largura_base = 960;
altura_base = 540;
zoom_alvo = 0.5;
zoom_atual = 1;
velocidade_zoom = 0.1;
zoom = true;
