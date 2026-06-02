scale = 3;
position_x = room_width/2 - (sprite_get_width(spr_ui_esqueleto_chefe)/2 * scale);
position_y = 0;

base_x = position_x;
base_y = position_y;

hp = 1;
tamanho_sprite = sprite_get_width(spr_ui_vida_chefe);
progresso = tamanho_sprite * hp;

offset = tamanho_sprite - progresso;

tamanho_coracao = sprite_get_width(spr_ui_coracao_chefe) * scale;
altura_coracao = sprite_get_height(spr_ui_coracao_chefe) * scale;

coracao4 = 0;
coracao3 = 0;
coracao2 = 0;
coracao1 = 0;

tremer = false;
tempo_tremer = 0.5;