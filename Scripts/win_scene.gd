extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$ColorRect/Label3.text = "Score : %d" % GameManager.score
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/menu.tscn")
	
