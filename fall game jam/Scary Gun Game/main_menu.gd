extends Control



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://testingground.tscn")
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://credenza.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
