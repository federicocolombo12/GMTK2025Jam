extends CanvasLayer


@onready var time_left_label = $TimeLeft




	


func _on_game_timer_changed(new_time_left: float) -> void:
	time_left_label.text = "Time Left :" + str(int(new_time_left))
