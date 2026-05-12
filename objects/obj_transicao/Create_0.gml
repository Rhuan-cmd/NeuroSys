// --- Configurações Básicas ---
proxima_room = -1;
estado = "indo"; // "indo" (preenchendo) ou "voltando" (revelando)

// Tamanho da GUI
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

// Tamanho de cada quadrado
quadrado_tamanho = 64; 

// Calcula quantos quadrados cabem na tela (+2 para garantir margem de segurança)
colunas = ceil(gui_w / quadrado_tamanho) + 2;
linhas = ceil(gui_h / quadrado_tamanho) + 2;

// --- Variáveis de Animação ---
timer = 0; 
velocidade = 0.020; // Velocidade da transição
atraso_diagonal = 0.5; 

// Pré-calcula o tempo máximo para evitar calcular isso todo frame
tempo_maximo = 1 + (colunas + linhas) * atraso_diagonal * 0.1;

// O evento Clean Up pode ser apagado, já que não usamos mais surfaces!