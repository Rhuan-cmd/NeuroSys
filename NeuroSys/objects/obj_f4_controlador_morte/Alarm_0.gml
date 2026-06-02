if (instance_exists(obj_f4_chefe)) {
    instance_create_layer(foco_x + irandom_range(-100, 100), foco_y + irandom_range(-100, 100), "UI", obj_f4_explosao_morte);
    cont++;
    if (cont > 10) {
        var _explosao = instance_create_layer(foco_x, foco_y + 150, "UI", obj_f4_explosao_chefe);
        _explosao.image_xscale = 5;
        _explosao.image_yscale = 5;
        obj_f4_chefe.image_alpha = 0;
        xboss = foco_x;
        yboss = foco_y - 50;
        yvilaodestino = foco_y;
        desenhar = true;
        alarm[1] = 60;
    } else {
        alarm[0] = 8;
    }
}
