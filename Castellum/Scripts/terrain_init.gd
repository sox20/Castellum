extends Node

const MyStream = preload("terrain_load.gd")

var terrain = VoxelTerrain.new()

func _ready():
	terrain.stream = MyStream.new()
	terrain.voxel_library = VoxelLibrary.new()
	terrain.view_distance = 256
	terrain.viewer_path = "/root/Spatial/Player"    # Set this path to your player/camera
	add_child(terrain)
