vel = 0;

// Limites de Movimentação
// A nave só vai até o meio da tela (room_height / 2) no eixo Y
limit_top = room_height / 2 + 20;
limit_bottom = room_height - 50; // Um pequeno respiro no fundo
limit_left = 50;
limit_right = room_width - 50;

// Profundidade e Escala
min_y = limit_top;
max_y = limit_bottom;
min_scale = 0.8;
max_scale = 1.5;

// Suavização do 3D (Tilt)
tilt_y_current = 1; // Começa na escala normal

rotacao = 0;

vida = 4;
morto = false;

pode_atirar = true;
tempo_tiro = 10;

flash_vermelho = 0;
// Velocidade do retorno (quanto menor, mais suave/lento)
flash_suave = 0.01;

cor_nave = c_white;

imune = false;

alpha = 1;

function tomar_dano(){
	if (instance_exists(obj_f4_chefe)){
		if (obj_f4_chefe.vida <= 0) return;
	}
	if (vida <= 0) return;
	if (imune) return;
	
	vida--;
	flash_vermelho = 1;
	if (instance_exists(obj_f4_fundo)) {
		obj_f4_fundo.corrupt_flash = 1;
		obj_f4_fundo.shake_fx = 12 + (4 - vida) * 4;
	}
	imune = true;
	alarm[1] = 60;
	if (instance_exists(obj_f4_barra_vida_jogador)){
		obj_f4_barra_vida_jogador.tomou_dano = true;
	}
	audio_play_sfx(snd_f3_dano, 1, 0);
}
