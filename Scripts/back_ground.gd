extends Sprite2D

@onready var player = get_node("../Player")
@onready var background = $"."

func _process(delta):
	print(player)
	background.position = player.position
