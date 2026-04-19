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

vida = 1000;

danificado = false;
tempo_danificado = 5;

function tomardano(){
	vida -= 20;
	tempo_danificado = 5;
	danificado = true;
}

