extends Area2D

class_name Projectile

@onready var sprite_2d: Sprite2D = $Sprite2D

const FRANKIE_PROJECTILE = preload("uid://dei3b7xpi84yc")
const HUNTER_PROJECTILE = preload("uid://ce13r274vyyjg")
const WITCH_PROJECTILE = preload("uid://ddahr17ph5582")
const WOLFIE_PROJECTILE = preload("uid://b73dnxj867box")

var speed = 500
var projectile_prefix

func _ready() -> void:
	match projectile_prefix:
		"frankie":
			sprite_2d.texture = FRANKIE_PROJECTILE
		"wolfie":
			sprite_2d.texture = WOLFIE_PROJECTILE
		"witch":
			sprite_2d.texture = WITCH_PROJECTILE
		"hunter":
			sprite_2d.texture = HUNTER_PROJECTILE
			
func _process(delta: float) -> void:
	position += Vector2.RIGHT * speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is not HomingBat:
		queue_free()
