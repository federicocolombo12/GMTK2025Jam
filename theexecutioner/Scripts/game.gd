extends Node

@onready var state_chart: StateChart = $StateMachine
@onready var prisoner_spawner = $PrisonerSpawner
@onready var crime_info_ui: Control = $Ui/CrimeInfoPanel
@onready var suspicion_bar: ProgressBar = $Ui/PanelContainer/SuspicionBar
@onready var decision_ui: Control = $Ui/DecisionUi
@onready var minigame_ui: CanvasLayer = $MinigameOverlay
@export var mercy_buff: float = 10.0
@export var brute_force: float = 15.0
@onready var timer_node = $Timer

@export var time_left := 120.0

var suspicion := 0.0
var current_prisoner = null

func _ready():
	state_chart.send_event("StartDay")
	timer_node.timeout.connect(_on_CountdownTimer_timeout)

	
func _on_CountdownTimer_timeout():
	time_left -= 1
	print("Secondi rimasti:", time_left)

	if time_left <= 0:
		print("Tempo scaduto!")
		timer_node.stop()

func spawn_prisoner():
	current_prisoner = prisoner_spawner.spawn()
	if current_prisoner and current_prisoner.has_method("get_data"):
		crime_info_ui.update_crime_info(current_prisoner.get_data())

func _input(event):
	if event.is_action_pressed("decide_mercy"):
		state_chart.send_event("ChooseMercy")
		
	elif event.is_action_pressed("decide_execute"):
		state_chart.send_event("ChooseExecute")

	


func apply_decision(decision: String):
	match decision:
		"mercy":
			suspicion = max(0.0, suspicion - mercy_buff)
		"execute":
			suspicion = min(100.0, suspicion + brute_force)
	suspicion_bar.value = suspicion


func _on_new_prisoner_state_entered() -> void:
	spawn_prisoner()
	


func _on_decision_state_state_entered() -> void:
	decision_ui.activate_self()


func _on_decision_state_state_exited() -> void:
	decision_ui.deactivate_self()


func _on_mercy_puzzle_state_entered() -> void:
	minigame_ui.activate_self()


func _on_minigame_overlay_password_game_ended() -> void:
	state_chart.send_event("MinigameEnded")
	


func _on_resolve_decision_state_entered() -> void:
	minigame_ui.deactivate_self()
