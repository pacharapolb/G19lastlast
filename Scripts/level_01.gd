extends Node2D
@onready var player = $Player
var die_count = 0
func _ready() -> void:
	GameManager.score = 0
func _process(_delta: float) -> void:
	if($Trap/Spear_Trap.status):
		die_count += 1
	if die_count >= 1:
		$TutorialText/SetNextScene3.visible = true
		$TutorialText/SetNextScene2.visible = false
