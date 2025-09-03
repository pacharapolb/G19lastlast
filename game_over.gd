extends Node2D

func _process(delta: float) -> void:
	$CanvasLayer/Label3.text = "score : + %d" % GameManager.score
	



func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_02.tscn")
	GameManager.score = 0

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")
	GameManager.check_door = 0
