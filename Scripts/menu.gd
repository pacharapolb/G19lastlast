extends Node2D
	

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_01.tscn")
	AudioManager.bg_sfx.play()

func _on_exit_pressed() -> void:
	print("lol")
	get_tree().quit()
