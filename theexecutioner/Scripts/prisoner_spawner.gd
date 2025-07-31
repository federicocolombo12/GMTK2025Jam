extends Node

var prisoner_scene := preload("res://scenes/Prisoner.tscn")
@export var character_resource:Array[character_stats] = []
func spawn() -> Node:
	var instance = prisoner_scene.instantiate()
	add_child(instance)
	instance.init(generate_random_data())
	return instance

func generate_random_data():
	var current_index = randi_range(0, character_resource.size()-1)
	var dictionary = {
		"name":character_resource[current_index].name,
		"crime" : character_resource[current_index].crime,
		"trait" : character_resource[current_index].traits,
		"difficulty" : character_resource[current_index].difficulty,
		"sprite": character_resource[current_index].character_sprite
		
		
	}
	
	
	return dictionary
