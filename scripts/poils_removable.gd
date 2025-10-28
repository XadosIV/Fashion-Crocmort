extends Line2D

var s = 20
var conv

func create_collision():
	var area = Area2D.new()
	var shape = CollisionShape2D.new()
	conv = ConvexPolygonShape2D.new()
	var p = PackedVector2Array([points[0]+Vector2(-s,-s), points[1]+Vector2(s,-s), points[1]+Vector2(s,s), points[0]+Vector2(-s,s)])
	conv.set_point_cloud(p)
	shape.shape = conv
	area.add_child(shape)
	add_child(area)
	area.mouse_entered.connect(_on_mouse_entered)
	notify_property_list_changed()
	dedebug()

func dedebug():
	var poly = Polygon2D.new()
	poly.color = Color.RED
	poly.polygon = [Vector2(conv.points[0][0]+0,conv.points[0][1]+0), Vector2(conv.points[1][0]+0,conv.points[1][1]+0), Vector2(conv.points[2][0]+0,conv.points[2][1]+0), Vector2(conv.points[3][0]+50,conv.points[3][1]+50)]
	#add_child(poly)

func _ready():
	create_collision()




func _on_mouse_entered():
	queue_free()
