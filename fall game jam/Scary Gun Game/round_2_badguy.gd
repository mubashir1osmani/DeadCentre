#round_2_badguy.gd
extends Node2D

var speed = 300
var movement_type = 0  # 0: left to right, 1: right to left, 2: left to middle, 3: right to middle, 4: top to bottom, 5: bottom to top, 6: custom movement
var direction = 1  # 1 for original direction, -1 for turned around
var target_position = null  # for behaviors 2, 3, 4, and 5
var is_paused = false  # Variable to track if the movement is paused
@export var target_type: String = ""

var oscillation_amplitude = 100  # Adjust as needed for vertical oscillation range
var oscillation_speed = 4.0  # Speed of the oscillation
var initial_y_position# Store initial Y position for oscillation reference
var time_elapsed = 0.0  # Track elapsed time for sinusoidal movement

func _ready():
	set_process_input(true)
	
	$Spider.visible = false
	$Web.visible = false
	$MediumMask.visible = false
	$HazardMask.visible = false
	$RareMask.visible = false
	$Butterfly.visible = false
	$EasyTargetCollision.disabled = true
	$MediumTargetCollision.disabled = true
	$HazardTargetCollision.disabled = true
	$RareTargetCollision.disabled = true
	$ButterflyCollision.disabled = true
	
	if target_type == "EasyTarget":
		movement_type = 0  # Movement types 0
		$Spider.visible = true
		$Web.visible = true
		$EasyTargetCollision.disabled = false
	elif target_type != "EasyTarget":  # Ensures we spawn non-EasyTargets (Medium, Rare)
		movement_type = 1 + randi() % 8  # Movement types 1-8
		if target_type == "MediumTarget":
			$MediumMask.visible = true
			$MediumTargetCollision.disabled = false
		if target_type == "DangerTarget":
			$HazardMask.visible = true
			$HazardTargetCollision.disabled = false
		if target_type == "RareTarget":
			$RareMask.visible = true
			$RareTargetCollision.disabled = false
		if target_type == "Butterfly":
			$Butterfly.visible = true
			$ButterflyCollision.disabled = false
		

	# Set spawn points based on movement type
	match movement_type:
		0:  # top dangle return
			position = Vector2(100 + randi() % (int(get_viewport_rect().size.x) - 200), 0)
			z_index = 35
			speed = 300
			target_position = position.y + (100 + randi() % 550)
		1:  # Left to right
			position = Vector2(0, 300 + randi() % 500)
			z_index = 35
			speed = 700
		2:  # Left to right
			position = Vector2(0, 300 + randi() % 500)
			z_index = 25
			speed = 475
		3:  # Left to right
			position = Vector2(0, 300 + randi() % 500)
			z_index = 15
			speed = 400
		4:  # Left to right
			position = Vector2(0, 300 + randi() % 500)
			z_index = 5
			speed = 325
		5:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 300 + randi() % 500)
			initial_y_position = position.y
			z_index = 35
			speed = -700
		6:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 300 + randi() % 500)
			initial_y_position = position.y
			z_index = 25
			speed = -475
		7:  # Left to right
			position = Vector2(get_viewport_rect().size.x, 300 + randi() % 500)
			initial_y_position = position.y
			z_index = 15
			speed = -400
		8:  # Left to right with oscillation (new behavior)
			position = Vector2(get_viewport_rect().size.x, 300 + randi() % 500)  # Random starting Y position
			initial_y_position = position.y  # Store initial Y position for the oscillation
			z_index = 5
			speed = -325
	
	#Set the initial_y_position for the oscillation
	initial_y_position = position.y

	if target_type == "RareTarget":
		speed = speed * 2
	if target_type == "Butterfly":
		speed = speed/2
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
			# Check the type of target and add corresponding points
			match target_type:
				"EasyTarget":
					get_tree().call_group("player", "add_points", 1)
					get_tree().call_group("player", "change_combo", 1)
				"MediumTarget":
					get_tree().call_group("player", "add_points", 2)
					get_tree().call_group("player", "change_combo", 1)
				"DangerTarget":
					get_tree().call_group("player", "add_points", 3)
					get_tree().call_group("player", "change_combo", 1)
				"RareTarget":
					get_tree().call_group("player", "add_points", 10)
					get_tree().call_group("player", "change_combo", 1)
				"Butterfly":
					get_tree().call_group("player", "drop_combo")
					get_tree().call_group("player", "change_lives", -15)
					

			
			queue_free()  # Remove the target once it's shot


func _process(delta):
	# Don't process movement if paused
	if is_paused:
		return
		
	if target_type == "":
		target_type = "EasyTarget"
	
	time_elapsed += delta  # Track time for oscillation calculation
	
	match movement_type:
		0:  # move from bottom to middle, then stop, and turn back
			if direction == 1 and position.y < target_position:
				position.y += speed * delta
			elif direction == 1:  # Reached the middle
				$EasyTargetStall.start()  # Start the EasyTargetStall timer and pause movement
				is_paused = true
				direction = -1
			elif direction == -1:
				position.y -= speed * delta
		1:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		2:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		3:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		4:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		5:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		6:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		7:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
		8:  # move from left to right
			position.x += speed * delta
			position.y = initial_y_position + oscillation_amplitude * sin(oscillation_speed * time_elapsed)
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

	# Get the size of the current frame of the Sprite2D
	var sprite = null
	var sprite_width = 0
	var sprite_height = 0
	if target_type == "":
		target_type = "EasyTarget"
	match target_type:
		"EasyTarget":
			sprite = $Spider
			sprite_width = $EasyTargetCollision.shape.get_rect().size.x
			sprite_height = $EasyTargetCollision.shape.get_rect().size.y
		"MediumTarget":
			sprite = $MediumMask
			sprite_width = $MediumTargetCollision.shape.get_rect().size.x
			sprite_height = $MediumTargetCollision.shape.get_rect().size.y
		"DangerTarget":
			sprite = $HazardMask
			sprite_width = $HazardTargetCollision.shape.get_rect().size.x
			sprite_height = $HazardTargetCollision.shape.get_rect().size.y
		"RareTarget":
			sprite = $RareMask
			sprite_width = $RareTargetCollision.shape.get_rect().size.x
			sprite_height = $RareTargetCollision.shape.get_rect().size.y
		"Butterfly":
			sprite = $Butterfly
			



	# Remove enemy if it leaves the screen
	if target_type != "Butterfly":
		if position.x < -sprite_width or position.x > get_viewport_rect().size.x + sprite_width or position.y < -sprite_height or position.y > get_viewport_rect().size.y + sprite_height:
			get_tree().call_group("player", "drop_combo")
			if target_type == "DangerTarget":
				get_tree().call_group("player", "change_lives", -15)
			
			queue_free()
	


# Timer callback to resume movement after 3 seconds
func _on_easy_target_stall_timeout():
	is_paused = false
