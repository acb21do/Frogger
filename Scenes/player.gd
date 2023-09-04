extends Area2D

enum STATE {
	ALIVE,
	DEAD,
}

var move_timer : float = 0.200
var curent_time : float = 0
var direction : Vector2 = Vector2.ZERO

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
	elif event.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
	elif event.is_action_pressed("ui_up"):
		direction = Vector2.UP
	elif event.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	else:
		direction = Vector2.ZERO
	

func _physics_process(delta) -> void:
	if curent_time > move_timer:
		global_position = global_position + (direction * 16.0)
		if direction != Vector2.ZERO:
			curent_time = 0.0
	curent_time += delta
