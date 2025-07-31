extends CanvasLayer

signal finished(successful: bool)

@export var qte_length := 4
@export var available_keys := ["0", "7", "f", "a"] # Tasti in minuscolo
@export var key_textures := {} # Esempio: { "f": preload("res://textures/f.png"), "7": preload(...) }
@export var time_limit := 5.0

@onready var timer: Timer = $BruteForceTimer
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar
@onready var qte_display: HBoxContainer = $VBoxContainer/QTEBox

var qte_sequence: Array[String] = []
var current_index := 0
var active := false

func activate_self():
	
	self.visible = true
	start_qte()
func _process(delta):
	if active:
		progress_bar.value = timer.time_left


func start_qte():
	active = true
	current_index = 0
	qte_sequence.clear()

	# Pulisce texture precedenti
	for child in qte_display.get_children():
		child.queue_free()

	# Genera sequenza
	for i in range(qte_length):
		var key = available_keys[randi() % available_keys.size()]
		qte_sequence.append(key)

		var tex_rect := TextureRect.new()
		tex_rect.texture = key_textures.get(key, null)
		tex_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		tex_rect.custom_minimum_size = Vector2(200, 200)
		tex_rect.name = key
		qte_display.add_child(tex_rect)


	timer.start(time_limit)
	progress_bar.value = timer.time_left

func _input(event):
	if not active or not event is InputEventKey or not event.pressed:
		return

	var expected_key := qte_sequence[current_index]
	var pressed_key := OS.get_keycode_string(event.keycode).to_lower()

	if pressed_key == expected_key:
		var rect := qte_display.get_child(current_index)
		rect.modulate = Color(0, 1, 0) # Verde
		current_index += 1
		if current_index >= qte_sequence.size():
			complete(true)
	else:
		complete(false)


	

func complete(success: bool):
	self.visible = false
	active = false
	timer.stop()
	
	queue_free()  # Puoi usare anche `hide()` se vuoi riutilizzarlo


func _on_brute_force_timer_timeout() -> void:
	if active:
		complete(false)
