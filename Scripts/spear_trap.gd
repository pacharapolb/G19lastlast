extends StaticBody2D
@onready var status = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player") && status == false):
		status = true
		var ran_t = randf_range(0.1,0.5)
		await get_tree().create_timer(ran_t).timeout
		$AnimationPlayer.play("spear_up")
		AudioManager.spear_sfx.play()
		print(ran_t)
		print("haha")
		await get_tree().create_timer(0.5).timeout
		$AnimationPlayer.stop()
		status = false
		print("haha")
		
