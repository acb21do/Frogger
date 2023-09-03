extends Node
class_name CarSpawner

var separation_distance : float = 0.0
var start_pos : Vector2
var num_of_cars : int
var car_scene : PackedScene
var set_distance : float
var car_speed : float
var direction : float
var car_width : float = 16.0

var end_car_pos_x : float
var end_pos_x : float
var spawn_car : bool = false
var car_type : String

var is_turtle : bool = false
var current_frame : int = 0
var current_frame_progress : float = 0.0


func _ready() -> void:
	separation_distance = (separation_distance * 16.0) + car_width
	car_speed *= 16.0
	set_distance *= 16.0


func _physics_process(delta) -> void:
	if spawn_car:
		spawn_cars()
		spawn_car = false
	else:
		end_car_pos_x = $Cars.get_child($Cars.get_child_count()-1).global_position.x
		var next_first_car_pos_x : float = end_car_pos_x + ((direction * -1) * (16 + set_distance))
		
		if direction == -1:
			end_pos_x = 248
			if end_car_pos_x < end_pos_x:
				start_pos.x = next_first_car_pos_x
				spawn_car = true
		else:
			end_pos_x = -16
			if end_car_pos_x > end_pos_x:
				start_pos.x = next_first_car_pos_x
				spawn_car = true


func spawn_cars() -> void:
	for i in range(num_of_cars):
		var car : Area2D = car_scene.instantiate()
		car.global_position = Vector2(start_pos.x + (direction * -1 * (i * separation_distance + car_width - 16.0)), start_pos.y)
		car.speed = car_speed * direction
		if is_turtle:
			car.num_of_turtles = int(car_width / 16.0)
			car.current_frame = current_frame
			car.current_frame_progress = current_frame_progress
			if i == 0:
				car.diving_turtle = true
			
			
		$Cars.add_child(car)
		if is_turtle:
			current_frame = car.get_frame()
			current_frame_progress = car.get_frame_progress()
		else:
			car.sprite_2d.texture = load("res://Asset/Car"+car_type+".png")
