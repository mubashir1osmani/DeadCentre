extends Node2D

@onready var eyesMoves = $ShopKeep 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eyesMoves.play("ShopEyes")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_input_event(viewport, event, shape_idx):
	# Check if the left mouse button is clicked
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Next button clicked!")
		get_tree().change_scene_to_file("res://round2.tscn")
