extends CanvasLayer
@onready var input_box = $Control/Input
@onready var submit_button = $Control/Submit
@onready var feedback_label = $Control/Feedback
@onready var enigma_label = $Control/Enigma

signal password_game_ended

var current_puzzle
var puzzles = []


func activate_self():
	self.visible = true

func deactivate_self():
	self.visible = false	

func load_puzzles() -> Array:
	return [
		PasswordPuzzle.new("È il primo numero primo a due cifre", "11"),
		PasswordPuzzle.new("Il nome del fondatore di Godot", "Juan"),
		PasswordPuzzle.new("Scrivi la parola 'password' al contrario", "drowssap")
	]

func start_new_puzzle():
	current_puzzle = puzzles.pick_random()
	enigma_label.text = current_puzzle.prompt
	input_box.text = ""
	feedback_label.text = ""

func _on_submit_pressed():
	var answer = input_box.text.strip_edges()
	if current_puzzle.is_correct(answer):
		feedback_label.text = "✔ Corretto!"
		# invia segnale al gioco principale, chiudi overlay ecc.
		
	else:
		feedback_label.text = "✘ Sbagliato. Riprova."
	password_game_ended.emit()


func _on_visibility_changed() -> void:
	if self.visible:
		puzzles = load_puzzles()
		start_new_puzzle()
		
