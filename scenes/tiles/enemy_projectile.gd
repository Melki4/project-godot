extends Area2D

class_name EnemyProjectile

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

enum ProjectilePattern {
	LINEAR,
	SIN,
	ACOS,
	ACOSH,
	TANH,
	VLAD
}

@export_group("shooting params")
var pattern: ProjectilePattern = ProjectilePattern.SIN
var horizontal_speed = 400
var amplitude = 4
var y_direction = -1

func set_projectile_texture(projectile_texture):
	sprite_2d.texture = projectile_texture
	
func _process(delta: float) -> void:
	var x = global_position.x - delta * horizontal_speed
	var y = global_position.y + get_vertical_position(x, delta)
	
	position = Vector2(x, y)

func get_vertical_position(x_postition: float, delta: float):
	match pattern:
		ProjectilePattern.SIN:
			return sin(delta * x_postition * PI * 2 / amplitude)
		ProjectilePattern.ACOS:
			return acos(delta * x_postition * PI * 2 / amplitude) * y_direction
		ProjectilePattern.ACOSH:
			return acosh(delta * x_postition * PI * 2 / amplitude) * y_direction
		ProjectilePattern.TANH:
			return tanh(delta * x_postition * PI * 2 / amplitude)
		ProjectilePattern.VLAD:
			return x_postition * tan(rotation) * delta
		ProjectilePattern.LINEAR:
			return 0

func set_vlad_pattern():
	pattern = ProjectilePattern.VLAD

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	#area.queue_free()
	queue_free()
