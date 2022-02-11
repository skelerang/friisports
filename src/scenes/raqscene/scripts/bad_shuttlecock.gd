extends KinematicBody


var gravity = Vector3(0,-200,0)
var velocity = Vector3(0,0,0)
var drag = 1


onready var model = $model


func _physics_process(delta):
	velocity *= 1 - drag * delta
	velocity += gravity * delta
	move_and_slide(velocity * delta, Vector3.UP)
	if get_slide_count() != 0:
		velocity = Vector3.ZERO

func _process(_delta):
	if velocity != Vector3.ZERO && velocity.normalized() != Vector3.UP && velocity.normalized() != Vector3.DOWN:
		look_at(transform.origin + velocity, Vector3.UP)
