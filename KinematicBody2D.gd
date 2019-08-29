extends KinematicBody2D
var direction:Vector2 = Vector2(1, 0)
var lock:Vector2
var strafe_switcher:int = 1
var end:Vector2
var value = 1
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if get_move_input():
		set_lock()		
		direction = get_move_input()*lock
		position+=direction*300*delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)


func _physics_process(delta):
	rotation = direction.angle()
	if get_shot_input():


		value = 0
		end = position+direction.rotated(strafe_switcher*PI/2)*70
		if strafe_switcher == 1:
			get_node('player body/gun_fire_left_shape').visible = true
			get_node('player body/gun_fire_left_shape/Timer_left').start()			
						
			strafe_switcher = 3
		else:
			get_node('player body/gun_fire_right_shape').visible = true
			get_node('player body/gun_fire_right_shape/Timer_right').start()	
			
			strafe_switcher = 1
	if value <1:
		if abs(direction.x):
			end = Vector2(position.x, end.y)
		if abs(direction.y):
			end = Vector2(end.x, position.y)
		
		position = position.linear_interpolate(end, value)
		value += delta

	
func get_move_input():
	return Vector2(
		int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left')),
		int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
		)

func set_lock():
	if Input.is_action_just_pressed('ui_right') or Input.is_action_just_pressed('ui_left'):
		lock = Vector2(1, 0)
	if not(Input.is_action_pressed('ui_right') or Input.is_action_pressed('ui_left')):
		lock.y = 1 #unlock y axis when x not used
	if Input.is_action_just_pressed('ui_down') or Input.is_action_just_pressed('ui_up'):
		lock = Vector2(0, 1)
	if not(Input.is_action_pressed('ui_down') or Input.is_action_pressed('ui_up')):
		lock.x = 1 #unlock x axis when y not used

func get_shot_input():

	return Input.is_action_just_pressed('ui_select')


func _on_Timer_left_timeout():
	get_node('player body/player_left_shape').visible = false
	get_node('player body/player_right_shape').visible = true
	get_node('player body/gun_fire_left_shape').visible = false

func _on_Timer_right_timeout():
	get_node('player body/player_left_shape').visible = true
	get_node('player body/player_right_shape').visible = false
	get_node('player body/gun_fire_right_shape').visible = false
