extends Spatial


func _process(delta):
	rotate(Vector3.UP, .05 * delta)
