if (!surface_exists(surf_caixa)) {
    surf_caixa = surface_create(caixa_largura, caixa_altura);
    surf_dirty = true;
}

if (surf_dirty) {
    surf_dirty = false;
    surface_set_target(surf_caixa);
    draw_clear_alpha(c_black, 0);

    var _y_atual = scroll_y;
    for (var i = 0; i < array_length(meus_sprites); i++) {
        var _spr = meus_sprites[i];
        var _largura_sprite = sprite_get_width(_spr);
        var _x_centro = (caixa_largura * 0.5) - (_largura_sprite * 0.5);
        draw_sprite(_spr, 0, _x_centro, _y_atual);
        _y_atual += altura_item + espacamento;
    }

    surface_reset_target();
}

draw_surface(surf_caixa, caixa_x, caixa_y);
