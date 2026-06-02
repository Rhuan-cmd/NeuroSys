// Limites de Escala
escala_min = 2.0; // Tamanho lá no topo
escala_max = 4.0; // Tamanho aqui embaixo

// Limites da Tela (Baseado na sua Room)
y_topo = room_height/2 - 20;              // Onde ele atinge o tamanho mínimo
y_base = room_height;    // Onde ele atinge o tamanho máximo

scale = 0.0;

// ... seus códigos anteriores ...
tempo_pulso = 0; 
velocidade_pulso = 0.1; // Ajuste para ser mais rápido ou devagar
intensidade_pulso = 0.3; // O quanto ele cresce (o 0.3 que você pediu)	