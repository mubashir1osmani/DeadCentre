extends Area2D

var speed = 300
var movement_type = 0  # 0: left to right, 1: right to left, 2: left to middle, 3: right to middle, 4: top to bottom, 5: bottom to top
var direction = 1  # 1 for original direction, -1 for turned around
var target_position = null  # for behaviors 2, 3, 4, and 5
var animation_sets = ["DangerTarget", "MediumTarget", "RareTarget", "EasyTarget"]
var is_paused = false  # Variable to track if the movement is paused

func _ready():
	set_process_input(true)
	
	# Randomize the animation set on spawn
	var random_animation = animation_sets[randi() % animation_sets.size()]
	$AnimatedSprite2D.play(random_animation)
	
	# Assign movement type after animation set is decided
	if random_animation == "EasyTarget":
		# EasyTarget can only have movement types 4 or 5 (top to bottom, bottom to top)
		movement_type = randi() % 2 + 4
	else:
		# Other targets can have movement types 0 to 3
		movement_type = randi() % 4

	# Set spawn points based on movement type
	match movement_type:
		0:  # Left to right
			position = Vector2(0, get_random_height())
			speed = 300
		1:  # Right to left
			position = Vector2(get_viewport_rect().size.x, get_random_height())
			speed = -300
		2:  # Left to middle, then turn around to the right
			position = Vector2(0, get_random_height())
			speed = 300
		3:  # Right to middle, then turn around to the left
			position = Vector2(get_viewport_rect().size.x, get_random_height())
			speed = -300
		4:  # Top to bottom
			position = Vector2(randi() % int(get_viewport_rect().size.x), 0)
			speed = 300
		5:  # Bottom to top
			position = Vector2(randi() % int(get_viewport_rect().size.x), get_viewport_rect().size.y)
			speed = -300

	#set up middle target for behaviors 2, 3, 4, and 5
	if movement_type == 2 or movement_type == 3:
		target_position = get_viewport_rect().size.x / 2
	elif movement_type == 4 or movement_type == 5:
		target_position = get_viewport_rect().size.y / 2

# Helper function to get a random height for horizontal movement
func get_random_height() -> float:
	var heights = [100, 175, 250, 325, 400]
	return heights[randi() % heights.size()]

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("BANG!")
			get_tree().call_group("score", "add_points", 1)
			queue_free()

func _process(delta):
	# Don't process movement if paused
	if is_paused:
		return
	
	match movement_type:
		0:  # move from left to right
			position.x += speed * delta
		1:  # move from right to left
			position.x += speed * delta
		2:  # move from left to middle, then turn around to the right
			if direction == 1 and position.x < target_position:
				position.x += speed * delta
			elif direction == 1:
				direction = -1  # Reached the middle, change direction to left
			elif direction == -1:
				position.x -= speed * delta
		3:  # move from right to middle, then turn around to the left
			if direction == 1 and position.x > target_position:
				position.x += speed * delta
			elif direction == 1:
				direction = -1  # Reached the middle, change direction to right
			elif direction == -1:
				position.x -= speed * delta
		4:  # move from top to middle, then stop, and turn back
			if direction == 1 and position.y < target_position:
				position.y += speed * delta
			elif direction == 1:  # Reached the middle
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true
				direction = -1
			elif direction == -1:
				position.y -= speed * delta
		5:  # move from bottom to middle, then stop, and turn back
			if direction == 1 and position.y > target_position:
				position.y += speed * delta
			elif direction == 1:  # Reached the middle
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true
				direction = -1
			elif direction == -1:
				position.y -= speed * delta

	# Get the size of the current frame of the AnimatedSprite2D
	var sprite = $Sprite2D
	var sprite_width = sprite.texture.get_size().x
	var sprite_height = sprite.texture.get_size().y
	
# Remove enemy if it leaves the screen
	if position.x < -sprite_width or position.x > get_viewport_rect().size.x + sprite_width or position.y < -sprite_height or position.y > get_viewport_rect().size.y + sprite_height:
		queue_free()

func _on_attack_timer_timeout():
	print("AGONY!!!")
	get_tree().call_group("score", "change_lives", -1)
	queue_free()

# Timer callback to resume movement after 2 seconds
func _on_easy_target_stall_timeout():
	is_paused = false
