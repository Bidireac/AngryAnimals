extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var vanish_sound: AudioStreamPlayer2D = $VanishSound

func die() -> void:
	vanish_sound.play()
	animation_player.play("vanish")


func _on_vanish_sound_finished() -> void:
	SignalManager.on_cup_destroyed.emit()
	queue_free()
