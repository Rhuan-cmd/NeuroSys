gm_text = "Made in GameMaker";
gm_text_index = 0;
gm_text_vel = 5;
gm_timer = 0;
gm_logo_alpha = 0;
aparecer = true;

if (!variable_global_exists("intro_phase")) {
    global.intro_phase = -1;
    global.intro_phase_alpha = 0;
}
