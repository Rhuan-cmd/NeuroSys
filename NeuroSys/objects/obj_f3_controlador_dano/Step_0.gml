if (flash_vermelho > 0) {
	// Diminui o flash
	flash_vermelho = max(0, flash_vermelho - flash_suave);
}else{
	instance_destroy();
}