extends DampedSpringJoint2D

@onready var line = $RopeLine
var node_a_obj : Object
var node_b_obj : Object

func _ready():
	node_a_obj = get_node(node_a)
	node_b_obj = get_node(node_b)

func _process(delta):
	line.set_point_position(0,node_a_obj.global_position)
	line.set_point_position(1,node_b_obj.global_position)
