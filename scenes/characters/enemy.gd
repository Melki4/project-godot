extends Area2D

class_name Enemy

signal killed


var sounds = [
	preload("uid://cj158onm83oe4"),
	preload("uid://bu3iow2nf7xc1"),
	preload("uid://btaqr0ytvm3m4"),
	preload("uid://b78ji5i7pwh7k"),
	preload("uid://cno6cwfsychmf")
]

@onready var shooting_system: EnemyShootingSystem = $ShootingSystem
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: RandomTimer = $ShootingSystem/Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var speed = 250

var movement_points 

var default_animation_name
var shooting_animation_name
var current_movement_point

func init(config, enemy_movement_points):
	default_animation_name = "%s_default" % config.enemy_name
	shooting_animation_name = "%s_shoot" % config.enemy_name
	animated_sprite_2d.play(default_animation_name)
	movement_points = enemy_movement_points
	collision_shape_2d.shape = config.enemy_collision_shape
	
	var random_point = movement_points.pick_random()
	current_movement_point = random_point.position
	
	shooting_system.shot.connect(on_shot)
	shooting_system.projectile_texture = config.projectile_texture
	shooting_system.projectile_collision_shape = config.projectile_collision_shape
	audio_stream_player.stream = sounds.pick_random()
	
func _process(delta: float) -> void:
	global_position = global_position.move_toward(current_movement_point, delta * speed)
	
	if global_position.distance_squared_to(current_movement_point) < 0.1:
		current_movement_point = movement_points.pick_random().global_position
	
func on_shot():
	animated_sprite_2d.play(shooting_animation_name)

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "die":
		killed.emit()
		await audio_stream_player.finished
		queue_free()
	
	if animated_sprite_2d.animation == shooting_animation_name:
		animated_sprite_2d.play(default_animation_name)


func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		set_collision_layer_value(2, false)
		shooting_system.stop()
		set_process(false)
		animated_sprite_2d.play("die")
		audio_stream_player.play()
		area.queue_free()

#func on_sound_finished():
	#pass
