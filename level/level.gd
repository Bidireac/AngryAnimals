extends Node2D

var animal_scene: PackedScene = preload("res://animal/animal.tscn")

@onready var debug_label: Label = $DebugLabel
@onready var animal_start: Marker2D = $AnimalStart

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	SignalManager.on_update_debug_level.connect(on_update_debug_level)
	SignalManager.on_animal_died.connect(on_animal_died)
	on_animal_died()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_Q) == true:
		GameManager.load_main_scene()

func setup() -> void:
	var tc = get_tree().get_nodes_in_group(GameManager.GROUP_CUP)
	ScoreManager.set_target_cups(tc.size())

func on_update_debug_level(text: String) -> void:
	debug_label.text = text

func on_animal_died() -> void:
	var animal = animal_scene.instantiate()
	animal.global_position = animal_start.global_position
	add_child(animal)
