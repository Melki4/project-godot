extends Area2D

class_name VladBoss

signal vlad_damaged(current_health: int)
signal vlad_died

var speed = 300
var movement_points
var current_movement_point

enum Phase{
	ONE,
	TWO
}

enum Actions{
	SPAWN_DEVIL,
	HOMING_SHOT,
	SPRAY_SHOT
}

var phase = Phase.ONE

@onready var health_system: HealthSystem = $HealthSystem
@onready var shooting_point: Marker2D = $ShootingPoint
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var action_timer: RandomTimer = $ActionTimer

func init():
	var random_point = movement_points.pick_random()
	current_movement_point = random_point.position
	health_system.damaged.connect(on_damaged)
	health_system.died.connect(on_died)
	action_timer.setup()
	
func on_died():
	vlad_died.emit()
	
func on_damaged():
	vlad_damaged.emit(get_health())
	
func _process(delta: float) -> void:
	global_position = global_position.move_toward(current_movement_point, delta * speed)
	if global_position.distance_squared_to(current_movement_point) < 0.1:
		current_movement_point = movement_points.pick_random().global_position

func get_health():
	return health_system.health

func _on_area_entered(area: Area2D) -> void:
	var blink_tween = get_tree().create_tween()
	blink_tween.tween_property(animated_sprite_2d, "modulate", Color.RED, .25)
	blink_tween.chain().tween_property(animated_sprite_2d, "modulate", Color.WHITE, .25)
	health_system.damage(1)
