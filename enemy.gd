extends KinematicBody2D
var spawn_distance:Vector2
var enemy_direction:Vector2

func _ready():
	spawn_distance = get_node('../player').position - position
	print(spawn_distance)

func _physics_process(delta):
	if abs(spawn_distance.x) > abs(spawn_distance.y):
		position.x = get_node("../player").position.x
	else:
		position.y = get_node("../player").position.y
		
	if moving_to_player().length() > 40:
		position += moving_to_player().normalized()*delta*50
	print(moving_to_player().length())
		
func moving_to_player():
	return get_node("../player").position - position