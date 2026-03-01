extends Area2D

class_name HomingBat

var speed = 350

var player

var max_homing_time = 2
var current_homing_time = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	current_homing_time += delta
	if current_homing_time >= max_homing_time:
		position += speed * Vector2.RIGHT.rotated(rotation) * delta
		
	elif player:
		look_at(player.global_position)
		position = position.move_toward(player.global_position, speed * delta)
		

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is not Projectile:
		queue_free()
	
