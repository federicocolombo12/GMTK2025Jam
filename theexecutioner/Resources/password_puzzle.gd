extends Resource
class_name PasswordPuzzle

var prompt: String
var solution: String
var custom_check: Callable = Callable()  # Vuoto di default

func _init(_prompt, _solution, _custom_check = null):
	prompt = _prompt
	solution = _solution
	if _custom_check is Callable:
		custom_check = _custom_check


func is_correct(input: String) -> bool:
	if custom_check:
		return custom_check.call(input)
	return input.to_lower() == solution.to_lower()
