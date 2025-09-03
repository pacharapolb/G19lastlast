extends CharacterBody2D
@export var speed = 40
@export var gravity : float = 30
@export var sprite = "walk"
var time_run = 0
var status = 1

func _ready() -> void:
	$AnimatedSprite2D.play(sprite)
	velocity.x = speed if randf_range(0,1)< 0.5 else -speed
	print(velocity.x)
	
func _process(delta: float) -> void:
	velocity.x = speed * -status
	if($AnimatedSprite2D.flip_h):
		status = -1
		
	if !is_on_floor():
		velocity.y += gravity
	
	move_and_slide()
	
	if is_on_wall() || time_run > randi_range(5,10):
		
		speed = -speed
		velocity.x = speed 
		print(velocity.x)
		time_run = 0
		print("tm")
		$AnimatedSprite2D.flip_h = speed > 0
	
	$AnimatedSprite2D.flip_h = speed > 0
	if !$AnimatedSprite2D.is_playing() or $AnimatedSprite2D.animation != sprite:
		$AnimatedSprite2D.play(sprite)
		
	time_run += delta
	

func dis():
	hide()
	await get_tree().create_timer(0.1).timeout
	queue_free()
	GameManager.add_score()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		dis()
		
		
