extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"

const PROJECTILE = preload("uid://blbddtyqepm5j")

var animation_prefix
var can_shoot = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") && can_shoot:
		shoot()
		can_shoot = false
		
func shoot():
	var projectile = PROJECTILE.instantiate()
	projectile.global_position = global_position
	projectile.projectile_prefix = animation_prefix
	animated_sprite_2d.play("%s_shooting" %animation_prefix)
	get_tree().root.add_child(projectile)
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "%s_shooting" % animation_prefix:
		animated_sprite_2d.play("%s_default" % animation_prefix)
		can_shoot = true
