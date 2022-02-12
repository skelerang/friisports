extends Spatial

var max_angle_h = 45
var max_angle_v = 45
var max_speed = 900

var lefthanded = false

onready var game = get_parent()
onready var racquet = $racquet
onready var shuttlecock = get_parent().get_node("shuttlecock")

# -- Debug
onready var debughud = get_tree().root.get_node("main").get_node("debughud")
onready var debug_dir_dot = debughud.get_node("badm").get_node("dir").get_child(0)
onready var debug_pow_bar = debughud.get_node("badm").get_node("pow")

# --- AI Movement --- #
var play_area = [ # defence
	0,0, # x min max
	0,0  # z min max
]
var move_spd = 1.5
var raq_offset = -.5

# Called when the node enters the scene tree for the first time.
func _ready():
	play_area = game.p1_area
	if lefthanded:
		raq_offset = -raq_offset
		racquet.transform.origin.x = -racquet.transform.origin.x



func _process(delta):
	# --- AI Movement --- #
	var move_target = Vector3()
	if game.ball_owner != 0:
		move_target = game.ball_predict_hit
		move_target.x = clamp(move_target.x, play_area[0], play_area[1])
		move_target.y = 0
		move_target.z = clamp(move_target.z, play_area[2], play_area[3])
		
		move_target.x += raq_offset
	
	else:
		# go to middle of play_area
		move_target = Vector3(play_area[0] + (play_area[1] - play_area[0]) * .5, 0, play_area[2] + (play_area[3] - play_area[2]) * .5)
	
	var move_dir = (move_target - transform.origin).normalized()
	var move_dist = (move_target - transform.origin).length()
	
	transform.origin += move_dir * clamp(move_dist * delta, -move_spd, move_spd)
	
	# TODO: define controls
	var input_h = Input.get_action_raw_strength("raqscene_bad_right") - Input.get_action_raw_strength("airscene_glide_left")
	var input_v = Input.get_action_raw_strength("raqscene_bad_down") - Input.get_action_raw_strength("airscene_glide_up")
	var input_p = Input.get_action_strength("raqscene_bad_pow")
	
	# -- Debug
	debug_pow_bar.value = input_p
	debug_dir_dot.rect_position.x = 62 + input_h * 64
	debug_dir_dot.rect_position.y = 62 + input_v * 64
	
	# -- model
	racquet.rotation_degrees = Vector3(input_v * max_angle_v, input_h * max_angle_h, 0)
	
	# -- Hit
	if Input.is_action_just_pressed("raqscene_bad_hit"):
		shuttlecock.global_transform.origin = racquet.global_transform.origin
		var dir = -racquet.get_global_transform().basis.z
		shuttlecock.velocity = dir * input_p * max_speed
		game._on_serve()
		game._set_ball_owner(0)
