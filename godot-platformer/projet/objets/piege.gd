extends Area2D

# Des piques : toucher = une cellule de batterie en moins.

func _on_body_entered(body):
	if body.name == "Heros":
		body.blesser()
