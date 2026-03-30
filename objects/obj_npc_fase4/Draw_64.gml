draw_sprite_ext(spr_barra_felicidade_corpo, estado_felicidade, 30, view_hport/2 - sprite_get_height(spr_barra_felicidade_corpo)*5/2, 5, 5, 0, c_white, 1);
var pos_dentro = view_hport/2 - (sprite_get_height(spr_barra_felicidade_corpo)*5/2) + sprite_get_height(spr_barra_felicidade_dentro)*5;
draw_sprite_ext(spr_barra_felicidade_dentro, 0, 30, pos_dentro, 5, -total_felicidade, 0, cor_barra, 1);