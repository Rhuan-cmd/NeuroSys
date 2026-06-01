// Lista de sprites (substitua pelos nomes dos seus sprites reais)
meus_sprites = [spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes, spr_pc_cartazes];

// Configurações da Caixa (onde os itens vão aparecer)
caixa_largura = 700; // Largura da caixa
caixa_altura = 450;  // Altura da caixa
caixa_x = room_width/2 - caixa_largura/2 + 100;       // Posição X da caixa na tela
caixa_y = room_height/2 - caixa_altura/2;       // Posição Y da caixa na tela

// Configurações dos itens
altura_item = 128; // Altura aproximada de cada sprite
espacamento = 10; // Espaço entre um sprite e outro

// Variáveis de Scroll
scroll_y = 0;           // Posição atual do scroll
velocidade_scroll = 20; // Quantos pixels a lista move por "clique" do scroll

// Variável para guardar a nossa superfície (o quadro de desenho)
surf_caixa = -1;