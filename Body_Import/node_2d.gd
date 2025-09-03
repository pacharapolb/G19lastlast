extends Sprite2D


func walk():
	$AnimationPlayer.play("walk")

func jump():
	$AnimationPlayer.play("jump")
	
func punch():
	$AnimationPlayer.play("punch")

func idle():
	$AnimationPlayer.play("Idle")

func direction(n):
	$polygons.scale = n
