// Pega o movimento do scroll do mouse
var _move = mouse_wheel_down() - mouse_wheel_up();

// Se o jogador rolou o scroll, atualiza a posição
if (_move != 0) {
    scroll_y -= _move * velocidade_scroll;
}

// Calcular o tamanho total da nossa lista
var _total_itens = array_length(meus_sprites);
var _altura_total = _total_itens * (altura_item + espacamento);

// Definir os limites do scroll (para não passar do topo nem do fundo)
var _scroll_maximo = 0; // O limite do topo (não pode passar do primeiro item)
var _scroll_minimo = caixa_altura - _altura_total; // O limite do fundo

// Se a lista for pequena e couber inteira na caixa, não precisa de scroll
if (_scroll_minimo > 0) {
    _scroll_minimo = 0;
}

// Trava o scroll_y para ele nunca sair dos limites (Clamp)
scroll_y = clamp(scroll_y, _scroll_minimo, _scroll_maximo);
if (scroll_y != scroll_y_anterior) {
    scroll_y_anterior = scroll_y;
    surf_dirty = true;
}
