extends Marker2D

class_name EnemyShootingSystem

signal shot

const ENEMY_PROJECTILE = preload("uid://d0m0ixoukivdh")
@onready var timer: RandomTimer = $Timer as RandomTimer

var projectile_collision_shape
var projectile_texture

func _on_timer_timeout() -> void:
	var projectile = ENEMY_PROJECTILE.instantiate() as EnemyProjectile
	get_tree().root.add_child(projectile)
	projectile.set_projectile_texture(projectile_texture)
	projectile.collision_shape_2d.shape = projectile_collision_shape
	projectile.global_position = global_position
	timer.setup()
	shot.emit()

func stop():
	timer.stop()
