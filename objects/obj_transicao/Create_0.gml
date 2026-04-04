// --- Configurações Básicas ---
proxima_room = -1;
estado = "indo"; // "indo" (preenchendo) ou "voltando" (revelando)

// Tamanho da GUI
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

// Tamanho de cada quadrado (ajuste para mais ou menos quadrados)
quadrado_tamanho = 32;

// Calcula quantos quadrados cabem na tela
colunas = ceil(gui_w / quadrado_tamanho);
linhas = ceil(gui_h / quadrado_tamanho);

// --- Variáveis de Animação ---
// Tempo geral da animação (0 a 1)
timer = 0; 
velocidade = 0.020; // Velocidade da transição

// Atraso entre cada quadrado na diagonal
atraso_diagonal = 0.5; 

// Superfície temporária para desenhar a grade
surf = -1;