extends Node2D

func walk():
	$AnimationPlayer.play("walk")

func jump():
	$AnimationPlayer.play("jump")
	
func punch():
	$AnimationPlayer.play("punch")

func idle():
	$AnimationPlayer.play("Idle")

func direction(x,y):
	$".".scale = Vector2(1*x,1*y)
	
