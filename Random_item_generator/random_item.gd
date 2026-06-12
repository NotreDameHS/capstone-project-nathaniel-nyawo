 # Developed by Daniel
extends Node2D

var item_scenes := [
	preload("res://entities/collectibles/Heart buff/area_2d.tscn"),
	preload("res://entities/collectibles/speed_boost/speed.tscn")
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var random_item_scene: PackedScene = item_scenes.pick_random()
	var item_instance := random_item_scene.instantiate()
	add_child(item_instance)
	var viewport_size := get_viewport_rect().size
	var random_position := Vector2(0.0, 0.0)
	random_position.x = randf_range(0.0, viewport_size.x)
	random_position.y = randf_range(0.0, viewport_size.y)
	item_instance.position = random_position
	pass # Replace with function body.
