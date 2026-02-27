extends Node2D
var can_open = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$pathway/CollisionShape2D.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if can_open:
		$animation.play("open")
		$pathway/CollisionShape2D.set_deferred("disabled", false)
		can_open = false





func _on_pathway_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	Global.level += 1 
	print("if this prints idk what the problem is")
	get_tree().call_deferred(
		"change_scene_to_file",
		"res://TNCs and GDs/level_%d.tscn" % Global.level
	)


func _on_pathway_area_entered(area: Area2D) -> void:
	Global.level += 1 
	print("if this prints idk what the problem is")
	get_tree().call_deferred(
		"change_scene_to_file",
		"res://TNCs and GDs/level_%d.tscn" % Global.level
	)
