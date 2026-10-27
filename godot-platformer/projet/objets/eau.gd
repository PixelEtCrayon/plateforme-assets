extends Area2D

# Une zone d'eau : dedans, Robi nage. En sortant vers le haut, il bondit hors de l'eau.

@export var taille = Vector2(256, 256)


func _ready():
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = taille
	$ColorRect.position = -taille / 2
	$ColorRect.size = taille

func _on_body_entered(body):
	if body.name == "Heros":
		body.dans_eau = true


func _on_body_exited(body):
	if body.name == "Heros":
		body.dans_eau = false
		if body.velocity.y < 0:
			body.velocity.y = -500
