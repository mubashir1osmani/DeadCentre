extends Control

@onready var inv: Inv = preload("res://Inventory/playerinv.tres")

var is_open = true 

func _ready():
	open()
	$"3dGlassess".visible = false
	$"Candy".visible = false
	$"IceCube".visible = false
	$"Magazine".visible = false
	$"Pillow".visible = false
	$"Pills".visible = false
	
	
func _process(delta):
	if inv.items[0].bought :
		$"3dGlassess".visible = true
	if inv.items[1].bought :
		$"Candy".visible = true
	if inv.items[2].bought :
		$"IceCube".visible = true
	if inv.items[3].bought :
		$"Magazine".visible = true
	if inv.items[4].bought :
		$"Pillow".visible = true
	if inv.items[5].bought :
		$"Pills".visible = true

func open():
	visible = true
	is_open = true 
