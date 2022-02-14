# ---------------------------------- #
# --- Frii Sports - Badminton AI --- #
# ---------------------------------- #

extends Spatial

var max_angle_h = 45
var max_angle_v = 45
var max_speed = 900

var lefthanded = false

onready var game = get_parent()
onready var racquet = $racquet
onready var ball = get_parent().get_node("shuttlecock")

# --- AI Movement --- #
var play_area = [ # defence
	0,0, # x min max
	0,0  # z min max
]
var move_spd = 1.5
var raq_offset = .5

var hit_dist_threshold = .5


func _ready():
	play_area = game.p2_area
	if lefthanded:
		raq_offset = -raq_offset
		racquet.transform.origin.x = -racquet.transform.origin.x

func _physics_process(delta):
	
	var move_target = Vector3()
	if game.ball_owner != 1:
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
	
	var ball_dist = (ball.global_transform.origin - racquet.global_transform.origin).length()
	
	if ball_dist < hit_dist_threshold and game.ball_owner != 1:
		ball.velocity = -ball.velocity.normalized()
		ball.velocity *= 500
		game._set_ball_owner(1)

