extends Spatial

onready var hud = $hud
onready var score = hud.get_node("score")
onready var ball = $shuttlecock

enum {
	ST_WAIT,
	ST_AIR,
	ST_FLOOR,
	ST_OUT
	}

var p1_area = [
	-3.0,  3.0, # x min max
	 0.3,  6.5  # z min max
]
var p2_area = [
	-3.0,  3.0, # x min max
	-6.5, -0.3  # z min max
]

var state = ST_WAIT
var ball_owner = 0



# --- AI trajectory predict --- #
# Settings
var target_height = 1.2 # The AI will try to hit the ball when it's at this height.
var trajectory_step = .00025 # step length
var trajectory_count = 300

# variables
var ball_predict_hit = Vector3()  # predicted pos at target_height
var ball_predict_land = Vector3() # predicted landing pos

# -- Debug
var draw_debug = true
#var draw_debug = false
onready var trajectory = get_node("debug/trajectory")
onready var trajectory2 = get_node("debug/trajectory2")


func _ready():
	score.bbcode_text = "[center]Status: Wait"

func _physics_process(delta):
	if state == ST_WAIT:
		if ball.get_slide_count() != 0:
			if !ball.get_slide_collision(0):
				state = ST_AIR
	if state == ST_AIR:
		if ball.get_slide_count() != 0:
			var col = ball.get_slide_collision(0)
			if col.collider.name == "out": _on_out()
			if col.collider.name == "floor": _on_floor()
	
	
	# Trajectory predict 
	var ball_position = ball.transform.origin
	var ball_gravity = Vector3(0,-200,0)
	var ball_velocity = ball.velocity
	var ball_drag = 1
	
	if draw_debug:
		if ball_position.y > target_height:
			trajectory.clear()
			trajectory.begin(1, null)
		trajectory2.clear()
		trajectory2.begin(1, null)
	
	for i in range(trajectory_count):
		if ball_position.y > target_height:
			ball_velocity *= 1 - ball_drag * delta
			ball_velocity += ball_gravity * delta
			ball_position += ball_velocity * trajectory_step
			if draw_debug: trajectory.add_vertex(ball_position)
			ball_predict_hit = ball_position
			if ball_position.y <= target_height:
				if draw_debug: trajectory.end()
		else:
			ball_velocity *= 1 - ball_drag * delta
			ball_velocity += ball_gravity * delta
			ball_position += ball_velocity * trajectory_step
			if draw_debug: trajectory2.add_vertex(ball_position)
			ball_predict_land = ball_position
		
		if ball_position.y < 0:
			break
	
	if draw_debug:
		trajectory2.end()

func _on_serve():
	score.bbcode_text = "[center]Status: Air"
	state = ST_WAIT

func _on_out():
	score.bbcode_text = "[center]Status: Out"
	state = ST_OUT

func _on_floor():
	score.bbcode_text = "[center]Status: Floor"
	state = ST_FLOOR

func _set_ball_owner(ballowner):
	ball_owner = ballowner
	if ball_owner == 0:
		print("ping")
	else:
		print("pong")
