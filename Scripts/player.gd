extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 500
@export var jump_force : float = 1000
@export var gravity : float = 30
@export var max_jump_count : int = 2
@export var hp = 100
var jump_count : int = 2

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false

var is_grounded : bool = false

@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var particle_trails = $ParticleTrails
@onready var death_particles = $DeathParticles

# --------- BUILT-IN FUNCTIONS ---------- #

func _process(_delta):
	# Calling functions
	movement()
	player_animations()
	flip_player()
	if hp <= 0:
		AudioManager.death_sfx.play()
		death_particles.emitting = true
		get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Scenes/Levels/game_over.tscn")
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	# Gravity
	if !is_on_floor():
		velocity.y += gravity
	elif is_on_floor():
		jump_count = max_jump_count
	
	handle_jumping()
	
	# Move Player
	var inputAxis = Input.get_axis("Left", "Right")
	velocity = Vector2(inputAxis * move_speed, velocity.y)
	move_and_slide()

# Handles jumping functionality (double jump or single jump, can be toggled from inspector)
func handle_jumping():
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor() and !double_jump:
			jump()
		elif double_jump and jump_count > 0:
			jump()
			jump_count -= 1

# Player jump
func jump():
	#ทำให้ตอนโดตัวมันยืดๆ
	#jump_tween()
	AudioManager.jump_sfx.play()
	velocity.y = -jump_force

# Handle Player Animations
func player_animations():
	particle_trails.emitting = false
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			particle_trails.emitting = true
			player_sprite.play("Walk", 1.5)
	
		else:
			player_sprite.play("Idle")
		
	else:
		player_sprite.play("Jump")

		
# Flip player sprite based on X velocity
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
		
	elif velocity.x > 0:
		player_sprite.flip_h = false
	

# Tween Animations
func death_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	await tween.finished
	global_position = spawn_point.global_position
	await get_tree().create_timer(0.3).timeout
	AudioManager.respawn_sfx.play()
	respawn_tween()

func respawn_tween():
	var tween = create_tween()
	tween.stop(); tween.play()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15) 

func jump_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.7, 1.4), 0.1)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)

# --------- SIGNALS ---------- #

# Reset the player's position to the current level spawn point if collided with any trap
func _on_collision_body_entered(_body):
	if _body.is_in_group("Traps")  || _body.is_in_group("Death_Zone"):
		AudioManager.death_sfx.play()
		death_particles.emitting = true
		death_tween()
		get_tree().change_scene_to_file("res://Scenes/Levels/game_over.tscn")
		AudioManager.bg_sfx.stop()
	if _body.is_in_group("Monster"):
		AudioManager.hurt_sfx.play()
		$Animaiton.play("Hurt")
		set_hp(-10);
		await get_tree().create_timer(2).timeout
		print(get_health())
		$Animaiton.stop()
		
		
		
		
func get_health():
	return hp
	
func set_hp(Hp):
	hp += Hp
