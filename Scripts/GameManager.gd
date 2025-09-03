# This script is an autoload, that can be accessed from any other script!

extends Node2D

var score : int = 0
var check_door = 0
# Adds 1 to score variable
func add_score():
	score += 1

# Loads next level
func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
	
func set_cd(cd):
	check_door += cd

func get_cd():
	return check_door
