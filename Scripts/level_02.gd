extends Node2D

func _process(_delta: float) -> void:
	$UserInterface/GameUI/ProgressBar.value = $Player.get_health()
	
		
		
		
