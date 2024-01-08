extends Node

const DEFAULT_SCORE: int = 1000

var _level_scores: Dictionary = {}
var _level_selected: int = 0
var _attempts: int = 0
var _cups_hit: int = 0
var _target_cups: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_cup_destroyed.connect(on_cup_destroyed)

func check_and_add(level: int) -> void:
	if _level_scores.has(level) == false:
		_level_scores[level] = DEFAULT_SCORE

func level_selected(level: int) -> void:
	check_and_add(level)
	_level_selected = level
	_attempts = 0
	_cups_hit = 0
	print("_level_selected: %s _level_scores: %s" % [
		_level_selected,
		_level_scores
	])

func get_best_for_level(level: int) -> int:
	check_and_add(level)
	return _level_scores[level]

func get_attempts() -> int:
	return _attempts

func get_level_selected() -> int:
	return _level_selected

func set_target_cups(t: int) -> void:
	_target_cups = t
	print("set_target_cups: ", _target_cups)

func attempt_made() -> void:
	_attempts += 1
	SignalManager.on_attempt_made.emit()
	print("attempt_made() _target_cups: %s _attempts: %s _cups_hit: %s" % [
		_target_cups, _attempts, _cups_hit
	])

func check_game_over() -> void:
	if _cups_hit >= _target_cups:
		print("GAME OVER", _level_scores)
		SignalManager.on_game_over.emit()
		if _level_scores[_level_selected] > _attempts:
			_level_scores[_level_selected] = _attempts
			print("record set: ", _level_scores)
	
func on_cup_destroyed() -> void:
	_cups_hit += 1
	print("on_cup_destroyed() _target_cups: %s _attempts: %s _cups_hit: %s" % [
		_target_cups, _attempts, _cups_hit
	])
	check_game_over()




