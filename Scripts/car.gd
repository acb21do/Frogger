extends Area2D

var speed : float
@onready var sprite_2d : Sprite2D = $Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	position.x += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
