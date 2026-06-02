// Cronômetro manual em microssegundos: este bloco mede a lógica global executada
// todo frame. Para investigar IA ou colisões específicas, repita o mesmo padrão
// get_timer() antes e depois do loop suspeito e valide o trecho no Profiler F6.
var _perf_step_inicio = get_timer();

if (keyboard_check_pressed(vk_f10)) {
    global.perf_overlay_ativo = !global.perf_overlay_ativo;
    show_debug_overlay(global.perf_overlay_ativo);
    show_debug_message("[PERF] Debug Overlay: " + string(global.perf_overlay_ativo));
}

// Verifica se a tecla F11 foi pressionada
if (keyboard_check_pressed(vk_f11)) {
    // Inverte o estado atual da tela cheia
    if (window_get_fullscreen()) {
        window_set_fullscreen(false);
    } else {
        window_set_fullscreen(true);
    }
}

global.perf_step_us = get_timer() - _perf_step_inicio;
global.perf_frame_us = get_timer() - global.perf_frame_inicio;
global.perf_frame_inicio = get_timer();
global.perf_fps = fps_real;
global.perf_log_timer--;

if (global.perf_log_timer <= 0) {
    if (global.perf_step_us > global.perf_limite_step_us) {
        show_debug_message("[PERF][CPU] " + room_get_name(room) + " Step global: " + string(global.perf_step_us) + " us. Revise loops, filas e colisões no Profiler F6.");
    }
    if (global.perf_frame_us > global.perf_limite_frame_us || fps_real < 56) {
        show_debug_message("[PERF][FRAME] " + room_get_name(room) + " FPS: " + string(fps_real) + " | frame: " + string(global.perf_frame_us) + " us. Verifique Draw, surfaces e excesso de instâncias.");
    }
    global.perf_log_timer = global.perf_log_intervalo;
}
