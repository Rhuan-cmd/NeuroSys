// Limites de Escala
escala_min = 1.0; // Tamanho lá no topo
escala_max = 3.0; // Tamanho aqui embaixo

// Limites da Tela (Baseado na sua Room)
y_topo = room_height/2 - 20;              // Onde ele atinge o tamanho mínimo
y_base = room_height;    // Onde ele atinge o tamanho máximo

velocidade = 700; // O objeto vai subir 200 pixels a cada 1 segundo

scale = 0.0;

y_ancora = y;          // Guarda o Y inicial onde o objeto nasceu
// No Create do obj_projetil, deixe cada um com um estilo único:
frequencia = random_range(3, 7);
amplitude = random_range(5, 10);
tempo_oscilacao = random(360); // Começa em um ponto diferente da onda