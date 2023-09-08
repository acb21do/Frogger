extends Area2D

signal dead
signal safe

enum STATE {
	ALIVE,
	DEAD,
	SAFE,
}

var state : STATE = STATE.ALIVE
@onready var ray_cast_2d = $AnimatedSprite2D/RayCast2D


var move_timer : float = 0.200
var curent_time : float = 0
var direction : Vector2 = Vector2.ZERO

var on_floating_object : bool = false
var floating_object_dir : float = 0.0

var water_pos_y : float = 120.0
var on_water : bool = false


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
	if state == STATE.ALIVE:
		#Update pos
		if curent_time > move_timer and !ray_cast_2d.is_colliding():
			global_position = global_position + (direction * 16.0)
			#Move the player if a button was pressed
			if direction != Vector2.ZERO:
				#Checks if the player is on water
				if global_position.y <= water_pos_y:
					on_water = true
				else:
					on_water = false
				$AnimatedSprite2D.rotation = Vector2.UP.angle_to(direction)
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.play("hop")
				curent_time = 0.0
		global_position.x += floating_object_dir * delta
	curent_time += delta


func death() -> void:
	state = STATE.DEAD
	$AnimatedSprite2D.rotation_degrees = 0.0
	$AnimatedSprite2D.play("death")
	$AnimatedSprite2D.animation_finished.connect(respawn.bind(state))
	emit_signal("dead")


func respawn(state : STATE) -> void:
	var player_start_pos : Vector2 = Vector2(120, 232)
	global_position = player_start_pos
	if state == STATE.DEAD:
		$AnimatedSprite2D.disconnect("animation_finished", respawn)
	elif state == STATE.SAFE:
		emit_signal("safe")
	self.state = STATE.ALIVE
	$AnimatedSprite2D.animation = "hop"
	$AnimatedSprite2D.frame = 1


func _on_area_entered(area) -> void:
	print(area.name)
	if area.is_in_group("floating"):
		floating_object_dir = area.speed
		on_floating_object = true
	else:
		if not on_floating_object:
			death()
	print(get_overlapping_areas())

func _on_area_exited(area) -> void:
	if area.is_in_group("floating"):
		floating_object_dir = 0.0
		round_position(global_position.x)
		on_floating_object = false
		if on_water:
			death()


func round_position(pos_x : float) -> void:
	var remainder : float = fmod(pos_x, 16.0)
	var difference : float = absf(8.0 - remainder)
	
	if remainder > 8.0:
		global_position.x = pos_x - difference
	else:
		global_position.x = pos_x + difference


