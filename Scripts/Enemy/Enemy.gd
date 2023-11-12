extends Area3D

class_name  Enemy

var shadow_scene : PackedScene = preload("res://Scenes/Prefabs/shadow.tscn")
var active : bool = false

func _ready():
	connect("body_entered", _on_body_entered)
	GameManager.connect("state_changed", _on_state_change)
	draw_shadow()

func _on_body_entered(body : Node3D):
	if body.name == "Player":
		MusicManager.play_sound("hurt")
		body.lose_life()

func _on_state_change():
	active = GameManager.current_state == GameManager.GameState.Playing

func draw_shadow():
	var shadow_instance : Node = shadow_scene.instantiate()
	get_parent().call_deferred("add_child", shadow_instance)
	shadow_instance.follow_node = self
