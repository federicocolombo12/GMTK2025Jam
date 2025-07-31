extends Resource
class_name character_stats

@export var name:String
@export var crime:String
@export var traits:String
var difficulty:int = randi_range(1,3)
@export var character_sprite: CompressedTexture2D
