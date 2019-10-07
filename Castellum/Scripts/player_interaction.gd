extends Node

var _terrain = null
var _terrain_tool = null
var _player = null
var _ray = null

func _ready():
	_player = get_parent()
	_terrain = get_parent().get_parent().get_node("VoxelTerrain")
	_ray = get_parent().get_node("rotation_help").get_node("Camera").get_node("RayCast")
	if _terrain != null:
		_terrain_tool = _terrain.get_voxel_tool()

func _physics_process(delta):
	if _terrain == null: #Stops function if terrain is not present
		return
	
	if Input.is_action_just_pressed("block_place"):
		print()
		var selectedBlock = 1
		var pos = get_selected_pos()
		if pos != null:
			print("block ID: ", selectedBlock," placed at ", pos)
			set_voxel(pos, selectedBlock)

func set_voxel(position, type):
	_terrain_tool.channel = VoxelBuffer.CHANNEL_TYPE
	_terrain_tool.value = type
	_terrain_tool.do_point(position)

func get_selected_pos():
	if _ray.is_enabled() and _ray.is_colliding():
		return _ray.get_collision_point()
	else:
		return null
		
	#if _ray.is_enabled() and _ray.is_colliding():
	#	print(_ray.get_collision_point())
