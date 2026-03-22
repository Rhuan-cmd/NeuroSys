// 1. Apagamos o draw_rectangle_color daqui para a caixa ficar totalmente transparente!

// 2. Checa se a superfície existe
if (!surface_exists(surf_caixa)) {
    surf_caixa = surface_create(caixa_largura, caixa_altura);
}

// 3. Inicia o desenho dentro da superfície
surface_set_target(surf_caixa);

// Essa é a linha que garante que o fundo da surface será transparente
draw_clear_alpha(c_black, 0); 

// 4. Loop para desenhar e centralizar os sprites
var _y_atual = scroll_y; 

for (var i = 0; i < array_length(meus_sprites); i++) {
    
    var _spr = meus_sprites[i]; // Guarda o sprite atual para facilitar
    
    // --- LÓGICA DE CENTRALIZAÇÃO ---
    // SE a origem do seu sprite for "Top Left" (Superior Esquerdo - o padrão):
    var _largura_sprite = sprite_get_width(_spr);
    var _x_centro = (caixa_largura / 2) - (_largura_sprite / 2);
    
    // SE a origem do seu sprite for "Middle Center" (Centro), apague as duas linhas acima e use apenas essa:
    // var _x_centro = caixa_largura / 2;
    // -------------------------------
    
    // Desenha o sprite na posição X centralizada
    draw_sprite(_spr, 0, _x_centro, _y_atual);
    
    // Desce a coordenada Y para o próximo item
    _y_atual += altura_item + espacamento;
}

// 5. Finaliza o desenho na surface
surface_reset_target();

// 6. Desenha a surface pronta na tela
draw_surface(surf_caixa, caixa_x, caixa_y);