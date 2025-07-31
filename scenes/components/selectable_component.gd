extends Area2D
class_name SelectableComponent

var is_selected: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D) -> void:
	is_selected = true
	
func _on_body_exited(body: Node2D) -> void:
	is_selected = false
