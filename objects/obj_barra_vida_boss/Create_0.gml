
scale = 3;
position_x = room_width/2 - (sprite_get_width(spr_esqueleto_barra_boss)/2 * scale);
position_y = 0;

base_x = position_x;
base_y = position_y;

hp = 1;
tamanho_sprite = sprite_get_width(spr_preenchimento_barra_boss);
progresso = tamanho_sprite * hp;

offset = tamanho_sprite - progresso;

tamanho_coracao = sprite_get_width(spr_coracao_barra_boss) * scale;
altura_coracao = sprite_get_height(spr_coracao_barra_boss) * scale;

coracao4 = 0;
coracao3 = 0;
coracao2 = 0;
coracao1 = 0;

tremer = false;
tempo_tremer = 0.5;