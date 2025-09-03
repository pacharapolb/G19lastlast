extends StaticBody2D

func _ready() -> void:
	$CollisionShape2D.add_to_group("Death_Zone")
