extends Area2D
var check = 1
# Define the next scene to load in the inspector
@export var next_scene : PackedScene
var enter = false
# Load next level scene when player collide with level finish door.
func _on_body_entered(body):
	if body.is_in_group("Player"):
		GameManager.set_cd(1)
		get_tree().call_group("Player", "death_tween") # death_tween is called here just to give the feeling of player entering the door.
		
		if GameManager.get_cd() > 1 :
			SceneTransition.load_scene(next_scene)
			AudioManager.bg_sfx.stop()
			AudioManager.win_sfx.play()
			await  get_tree().create_timer(1.0).timeout
			AudioManager.bg_sfx.play()
		else:
			SceneTransition.load_scene(next_scene)
			
		
func get_status():
	enter = true
	
