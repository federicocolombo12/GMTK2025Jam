extends CharacterBody2D

@onready var sprite := $Sprite2D
var prisoner_data :={}
func init(data:Dictionary) -> void:
	prisoner_data = data
	sprite.texture = prisoner_data.sprite
func get_data():
	return prisoner_data

	
