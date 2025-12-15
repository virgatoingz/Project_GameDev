extends Control

func _on_gempa_button_pressed():
	GameState.disaster_selected = "gempa"
	get_tree().change_scene_to_file("res://scenes/levels/Map_Gempa.tscn")

func _on_banjir_button_pressed():
	GameState.disaster_selected = "banjir"
	get_tree().change_scene_to_file("res://scenes/levels/Map_Banjir.tscn")

func _on_kebakaran_button_pressed():
	GameState.disaster_selected = "kebakaran"
	get_tree().change_scene_to_file("res://scenes/levels/Map_Kebakaran.tscn")
