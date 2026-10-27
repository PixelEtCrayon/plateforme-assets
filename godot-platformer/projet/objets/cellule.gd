extends Area2D

# Une cellule d'énergie : 1 point de score et un peu de boost pour planer.

func _on_body_entered(body):
	if body.name == "Heros":
		Jeu.score += 1
		body.recharger(25)
		Jeu.jouer_son("cellule")
		queue_free()
