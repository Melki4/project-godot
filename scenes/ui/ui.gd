extends CanvasLayer

class_name UI

@onready var health_container: HBoxContainer = %HealthContainer
@onready var wave_counter: Label = $MarginContainer/WaveCounter
@onready var boss_hb: ProgressBar = $MarginContainer/BossHB
@onready var boss_name: Label = $MarginContainer/BossName

const LIFE_FULL_UI = preload("uid://d1kvvoyux3fbo")
const LIFE_HALF_UI = preload("uid://bfm0x88tcao07")

func set_initial_health(health: int):
	var full_health_textures = health / 2
	
	for i in full_health_textures:
		var texture_rect = TextureRect.new()
		texture_rect.texture = LIFE_FULL_UI
		texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		health_container.add_child(texture_rect)
		
	var half_life_texture = health % 2
	
	if half_life_texture:
		var hl_texture_rect = TextureRect.new()
		hl_texture_rect.texture = LIFE_HALF_UI
		hl_texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		health_container.add_child(hl_texture_rect)

func decrease_health(current_health):
	var health_textures = health_container.get_children()
	if !(current_health % 2):
		health_textures.pop_back().queue_free()
	else:
		health_textures.back().texture = LIFE_HALF_UI

func on_wave_started(current_wave, total_waves):
	wave_counter.text = "Wave %d of %d" %[current_wave, total_waves]

func change_boss_hb_value(new_value: int):
	boss_hb.value = new_value

func on_vlad_died():
	print("VLAD DIED")
	
func init_boss_health_bar(max_health: int):
	boss_name.visible = true
	boss_hb.visible = true
	boss_hb.max_value = max_health
	boss_hb.value = max_health
	wave_counter.text = "Boss fight"
