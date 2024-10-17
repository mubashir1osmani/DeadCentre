#badguy.gd
extends Area2D

func _ready():
	set_process_input(true)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("BANG!")
			get_tree().call_group("score", "add_points", 1) #call add_points to scirpt in group 'score'
			queue_free()  #die


func _on_attack_timer_timeout():
	print("AGONY!!!")
	get_tree().call_group("score", "change_lives", -1)
	queue_free()
