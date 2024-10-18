extends Area2D

var speed = 300
var movement_type = 0  # 0: left to right, 1: right to left, 2: left to middle, 3: right to middle, 4: top to bottom, 5: bottom to top, 6: custom movement
var direction = 1  # 1 for original direction, -1 for turned around
var target_position = null  # for behaviors 2, 3, 4, and 5
var animation_sets = ["DangerTarget", "MediumTarget", "RareTarget", "EasyTarget"]
var is_paused = false  # Variable to track if the movement is paused

func _ready():
	set_process_input(true)

	# Randomize the animation set on spawn
	var random_animation = animation_sets[randi() % animation_sets.size()]
	$AnimatedSprite2D.play(random_animation)

	random_animation = "EasyTarget"
	movement_type = randi() % 12 # Set the new movement type here

	# Set spawn points based on movement type
	match movement_type:
		0:  # Bottom to top
			position = Vector2(100 + randi() % (int(get_viewport_rect().size.x) - 200), get_viewport_rect().size.y)
			z_index = 35
			speed = -300
			target_position = position.y - 300
		1:  # layer 1
			position = Vector2(100 + randi() % (int(get_viewport_rect().size.x) - 200), 780)  # Start at height 780
			z_index = 25  # Set the z-index
			speed = 300  # Set the speed for this movement type
			target_position = position.y - 250  # Set target position to 30 units above spawn point
		2:
			position = Vector2(100 + randi() % (int(get_viewport_rect().size.x) - 200), 500)  # Start at height 780
			z_index = 15  # Set the z-index
			speed = 300  # Set the speed for this movement type
			target_position = position.y - 250  # Set target position to 30 units above spawn point
		3:
			position = Vector2(100 + randi() % (int(get_viewport_rect().size.x) - 200), 250)  # Start at height 780
			z_index = 5  # Set the z-index
			speed = 300  # Set the speed for this movement type
			target_position = position.y - 150  # Set target position to 30 units above spawn point
		4:  # Left to right
			position = Vector2(0, 730)
			z_index = 35
			speed = 450
		5:  # Left to right
			position = Vector2(0, 530)
			z_index = 25
			speed = 400
		6:  # Left to right
			position = Vector2(0, 250)
			z_index = 15
			speed = 350
		7:  # Left to right
			position = Vector2(0, 100)
			z_index = 5
			speed = 300
		8:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 730)
			z_index = 35
			speed = -450
		9:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 530)
			z_index = 25
			speed = -400
		10:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 250)
			z_index = 15
			speed = -350
		11:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 100)
			z_index = 5
			speed = -300
"""
		5:  # Right to left
			position = Vector2(get_viewport_rect().size.x, get_random_height())
			speed = -300
		6:  # Left to middle, then turn around to the right
			position = Vector2(0, get_random_height())
			speed = 300
			target_position = get_viewport_rect().size.x / 2
		7:  # Right to middle, then turn around to the left
			position = Vector2(get_viewport_rect().size.x, get_random_height())
			speed = -300
			target_position = get_viewport_rect().size.x / 2
		8:  # Top to bottom
			position = Vector2(100 + randi() % (int(get_viewport_rect().size.x) - 200), 0)
			z_index = 35
			speed = 300
			target_position = position.y + 150
"""

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
		0:  # move from bottom to middle, then stop, and turn back
			if direction == 1 and position.y > target_position:
				position.y += speed * delta
			elif direction == 1:  # Reached the middle
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true
				direction = -1
			elif direction == -1:
				position.y -= speed * delta
		1:  # Custom movement behavior
			if direction == 1 and position.y > target_position:
				position.y -= speed * delta  # Move up towards target
			elif direction == 1:  # Reached the target position
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true  # Pause movement
				direction = -1  # Prepare to turn around
			elif direction == -1:
				position.y += speed * delta  # Move back down
		2:  # Custom movement behavior
			if direction == 1 and position.y > target_position:
				position.y -= speed * delta  # Move up towards target
			elif direction == 1:  # Reached the target position
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true  # Pause movement
				direction = -1  # Prepare to turn around
			elif direction == -1:
				position.y += speed * delta
		3:  # Custom movement behavior
			if direction == 1 and position.y > target_position:
				position.y -= speed * delta  # Move up towards target
			elif direction == 1:  # Reached the target position
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true  # Pause movement
				direction = -1  # Prepare to turn around
			elif direction == -1:
				position.y += speed * delta
		4:  # move from left to right
			position.x += speed * delta
		5:  # move from left to right
			position.x += speed * delta
		6:  # move from left to right
			position.x += speed * delta
		7:  # move from left to right
			position.x += speed * delta
		8:  # move from left to right
			position.x += speed * delta
		9:  # move from left to right
			position.x += speed * delta
		10:  # move from left to right
			position.x += speed * delta
		11:  # move from left to right
			position.x += speed * delta
			"""
		5:  # move from right to left
			position.x += speed * delta
		6:  # move from left to middle, then turn around to the right
			if direction == 1 and position.x < target_position:
				position.x += speed * delta
			elif direction == 1:
				direction = -1  # Reached the middle, change direction to left
			elif direction == -1:
				position.x -= speed * delta
		7:  # move from right to middle, then turn around to the left
			if direction == 1 and position.x > target_position:
				position.x += speed * delta
			elif direction == 1:
				direction = -1  # Reached the middle, change direction to right
			elif direction == -1:
				position.x -= speed * delta
		8:  # move from top to middle, then stop, and turn back
			if direction == 1 and position.y < target_position:
				position.y += speed * delta
			elif direction == 1:  # Reached the middle
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true
				direction = -1
			elif direction == -1:
				position.y -= speed * delta
			"""

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
	#queue_free()

# Timer callback to resume movement after 2 seconds
func _on_easy_target_stall_timeout():
	is_paused = false
