extends Node2D

export (PackedScene) var bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_bullet_timer_timeout():
	var bt = bullet.instance()
	add_child(bt)