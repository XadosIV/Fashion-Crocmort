extends Polygon2D

@export 	var poilsColor = Color.BLACK
@export var nb_poils = 200
@export var length = 10.0

@export var scriptPoils : Script

var myRand = RandomNumberGenerator.new()

func generate_poils(r=null):
	if r != null:
		myRand = r
	
	remove_poils()
	var points = polygon
	for i in range(nb_poils):
		var pos = random_point_in_polygon(points)
		var dir = Vector2(myRand.randf() - 0.5, -1).normalized()
		add_hair(pos, dir)

func remove_poils():
	for child in get_children():
		child.queue_free()

func random_point_in_polygon(_polygon: PackedVector2Array) -> Vector2:
	var aabb = Rect2()
	for p in _polygon:
		aabb = aabb.expand(p)
	var point: Vector2
	while true:
		point = Vector2(
			myRand.randf_range(aabb.position.x, aabb.end.x),
			myRand.randf_range(aabb.position.y, aabb.end.y)
		)
		if Geometry2D.is_point_in_polygon(point, _polygon):
			return point
	return Vector2(0,0)


func add_hair(pos: Vector2, dir: Vector2):
	var hair : Line2D = Line2D.new()
	hair.width = 1
	hair.default_color = poilsColor
	hair.points = [pos, pos + dir * length]
	
	hair.set_script(scriptPoils)
	
	hair.z_index = 4
	add_child.call_deferred(hair)
