extends Area2D

# Une zone de glace : dedans, Robi glisse (voir courir() dans heros.gd).

@export var taille = Vector2(256, 64)


func _ready():
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = taille

func _on_body_entered(body):
	if body.name == "Heros":
		body.sur_glace = true


func _on_body_exited(body):
	if body.name == "Heros":
		body.sur_glace = false
