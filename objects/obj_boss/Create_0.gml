#region Movimento
y_base = y;               // Guarda a posição original
escala_base = image_xscale;          // Escala original (1 = 100%)

timer = 0;                // Nosso relógio interno
velocidade_loop = 0.2;      // Quão rápido ele sobe e desce (por segundo)
amplitude_movimento = 5; // Quantos pixels ele desce/sobe
amplitude_escala = 0.1;   // Quanto ele cresce/encolhe (0.2 = 20%)

// ... (suas variáveis anteriores de loop e timer)

intensidade_parallax = 0.01; // 0.1 = suave, 0.5 = forte
x_base = x;                 // Guarda a posição X original
x_offset = 0;               // Variável auxiliar para o deslocamento
#endregion

vidaMax = 1000;
vida = vidaMax - 749;

danificado = false;
tempo_danificado = 5;

descansar = false;

function descanso(temp = 60){
	descansar = true;
	alarm[0] = temp;
}

function tomardano(){
	vida -= 2;
	tempo_danificado = 5;
	danificado = true;
}

ataque1 = true;
ataque2 = false;
ataque3 = false;
ataque4 = false;

preparar_fase2 = true;
preparar_fase3 = true;
preparar_fase4 = true;

descanso(120);

function fase1(){
	if (ataque1){
		instance_create_layer(0, 0, "projeteis_boss", obj_controller_ataque1);
		ataque1 = false;
	}
}


function fase2(){
	
	if (preparar_fase2){
		if (instance_exists(obj_controller_ataque1)){
			instance_destroy(obj_controller_ataque1);
		}
		
		ataque1 = false;
		ataque2 = true;
		descanso();
		preparar_fase2 = false;
		return;
	}
	
	if (ataque2){
		instance_create_layer(0, 0, "projeteis_boss", obj_controller_ataque2);
		ataque2 = false;
	}
}

function fase3(){
	if (preparar_fase3){
		if (instance_exists(obj_controller_ataque2)){
			instance_destroy(obj_controller_ataque2);
		}
		ataque1 = false;
		ataque2 = false;
		ataque3 = true;
		descanso();
		preparar_fase3 = false;
		return;
	}
	
	if (ataque3){
		instance_create_layer(0, 0, "projeteis_boss", obj_controller_ataque3);
		ataque3 = false;
	}
}

function fase4(){
	if (preparar_fase4){
		if (instance_exists(obj_controller_ataque3)){
			instance_destroy(obj_controller_ataque3);
		}
		
		ataque1 = false;
		ataque2 = false;
		ataque3 = false;
		ataque4 = true;
		
		if (!descansar){
			descanso();
		}
		
		preparar_fase4 = false;
		return;
	}
	
	if (ataque4){
		instance_create_layer(0, 0, "projeteis_boss", obj_controller_ataque4);
		ataque4 = false;
	}
}