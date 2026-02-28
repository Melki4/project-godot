extends CanvasLayer

class_name LevelSelection

var panel_material = preload("res://scenes/material/level_selection.material")

@onready var levels = [
	preload("res://scenes/levels/castle_level.tscn"), 
	preload("res://scenes/levels/forest_level.tscn"),
	preload("res://scenes/levels/pyramids_level.tscn")
]

@onready var level_panels = [
	%Castle,
	%Forest,
	%Pyramids
]

var level_selected_index: int = 0

func _ready() -> void:
	select_level(level_selected_index)

func select_level(level_index: int) -> void:
	var selected_panel = level_panels[level_index] as PanelContainer
	selected_panel.theme_type_variation = "selected_panel"
	var texture_rect = selected_panel.get_child(0) as TextureRect
	texture_rect.material = null
	
	var level_title_label = selected_panel.get_child(1) as Label
	level_title_label.visible = true

func unselect_level(level_index: int) -> void:
	var panel = level_panels[level_index] as PanelContainer
	panel.theme_type_variation = ""
	var texture_rect = panel.get_child(0) as TextureRect
	texture_rect.material = panel_material
	
	var level_title_label = panel.get_child(1) as Label
	level_title_label.visible = false
	
func _input(event) -> void:
	if Input.is_action_just_pressed("left"):
		if !level_selected_index:
			return
		unselect_level(level_selected_index)
		level_selected_index -= 1
		select_level(level_selected_index)
		
	elif Input.is_action_just_pressed("right"):
		if level_selected_index == level_panels.size()-1:
			return
		unselect_level(level_selected_index)
		level_selected_index += 1
		select_level(level_selected_index)
	elif Input.is_action_just_pressed("accept"):
		get_tree().change_scene_to_packed(levels[level_selected_index])
		
		
