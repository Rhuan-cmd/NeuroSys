var h_input = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
var v_input = (keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up));

var dt = delta_time / 1000000;

// 1. Movimento Normalizado
if (h_input != 0 || v_input != 0) {
    var dir = point_direction(0, 0, h_input, v_input);
    x += lengthdir_x(vel, dir) * dt;
    y += lengthdir_y(vel, dir) * dt;
}

// 2. Limitar Nave no Cenário (Clamping)
x = clamp(x, limit_left, limit_right);
y = clamp(y, limit_top, limit_bottom);

// 3. Suavização do Efeito 3D (Inclinação Vertical)
// Se subir, encolhe levemente o Y. Se descer, estica.
var target_tilt_y = 1;
if (v_input < 0) target_tilt_y = 0.8; // Inclinada para "dentro" da tela
if (v_input > 0) target_tilt_y = 1.2; // Inclinada para "fora" da tela

// O valor 0.05 torna a transição bem sutil e suave
tilt_y_current = lerp(tilt_y_current, target_tilt_y, 0.05);

// 4. Escala de Profundidade
var t = (y - min_y) / (max_y - min_y);
var scale = lerp(min_scale, max_scale, t);

image_xscale = scale;
image_yscale = scale * tilt_y_current; // Aplica o tilt sobre a escala de profundidade

// 5. Rotação Lateral (Z-axis tilt)
var target_rot = h_input * -15;
rotacao = lerp(rotacao, target_rot, 0.1);

depth = -y;