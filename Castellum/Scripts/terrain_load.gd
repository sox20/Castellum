extends VoxelStream

func emerge_block(buffer:VoxelBuffer, origin:Vector3, lod:int) -> void:
	if lod != 0:
		return
	if origin.y < 0:
		buffer.fill(1, 0)
	if origin.x== origin.z and origin.y < 1:
		buffer.fill(1,0)
		print(origin)
