#extends Node2D
#
#onready var description_panel = $Panel
#onready var name_label = $"3DGlasses"
#onready var description_label = $TicketBox
#
#var items = {
	#"3DGlasses": "Reveal the truth (some targets)",
	#"Candy": "Restores a small amount of health",
	#"IceCube": "Temporary speed boost",
	#"Magazine": "Distracts enemies for a short time",
	#"Pillow": "Improves sleep quality, restoring more health when resting",
	#"Pills": "Cures status effects"
#}
#
#func _ready():
	#description_panel.hide()
#
#func _process(delta):
	#var mouse_pos = get_global_mouse_position()
	#var hovered_item = get_item_at_position(mouse_pos)
	#
	#if hovered_item:
		#show_description(hovered_item)
	#else:
		#hide_description()
#
#func get_item_at_position(pos):
	#for child in get_children():
		#if child is TextureButton and child.get_global_rect().has_point(pos):
			#return child.name
	#return null
#
#func show_description(item_name):
	#if item_name in items:
		#name_label.text = item_name
		#description_label.text = items[item_name]
		#description_panel.show()
		#description_panel.rect_global_position = get_global_mouse_position() + Vector2(10, 10)
#
#func hide_description():
	#description_panel.hide()
#
