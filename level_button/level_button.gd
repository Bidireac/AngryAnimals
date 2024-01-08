extends TextureButton

const HOVER_SCALE: Vector2 = Vector2(1.1, 1.1)
const DEFAULT_SCALE: Vector2 = Vector2(1.0, 1.0)

@export var level_number: int = 1

@onready var level_label: Label = $MC/VB/LevelLabel
@onready var score_label: Label = $MC/VB/ScoreLabel

var _level_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = str(level_number)
	score_label.text = str(ScoreManager.get_best_for_level(level_number))
	_level_scene = load("res://level/level_%s.tscn" % level_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	ScoreManager.level_selected(level_number)
	get_tree().change_scene_to_packed(_level_scene)


func _on_mouse_entered() -> void:
	scale = HOVER_SCALE


func _on_mouse_exited() -> void:
	scale = DEFAULT_SCALE
