extends Area2D

var speed = 200
var movement_type = 0  # 0: left to right, 1: right to left, 2: left to middle, 3: right to middle
var direction = 1  #1 for original direction, -1 for turned around
var target_position = null  #for behaviors 2 and 3

func _ready():
	set_process_input(true)
	
	#set up middle target for behaviors 2 and 3
	if movement_type == 2 or movement_type == 3:
		target_position = get_viewport_rect().size.x / 2

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("BANG!")
			get_tree().call_group("score", "add_points", 1)
			queue_free()

func _process(delta):
	match movement_type:
		0:  #move from left to right
			position.x += speed * delta
		1:  #move from right to left
			position.x += speed * delta
		2:  #move from left to middle, then turn around to the right
			if direction == 1 and position.x < target_position:
				position.x += speed * delta
			elif direction == 1:  # Reached the middle, change direction to left
				direction = -1
			elif direction == -1:
				position.x -= speed * delta
		3:  #move from right to middle, then turn around to the left
			if direction == 1 and position.x > target_position:
				position.x += speed * delta
			elif direction == 1:  # Reached the middle, change direction to right
				direction = -1
			elif direction == -1:
				position.x -= speed * delta

	var sprite = $Sprite2D
	var sprite_width = sprite.texture.get_size().x
	
	# Remove enemy if it leaves the screen
	if position.x < -sprite_width or position.x > get_viewport_rect().size.x + sprite_width:
		queue_free()

func _on_attack_timer_timeout():
	print("AGONY!!!")
	get_tree().call_group("score", "change_lives", -1)
	queue_free()
