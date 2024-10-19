extends Node2D

@onready var eyesMoves = $ShopKeep 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eyesMoves.play("ShopEyes")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
