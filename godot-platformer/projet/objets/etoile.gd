extends Area2D

# Une des trois étoiles cachées du niveau.

func _on_body_entered(body):
	if body.name == "Heros":
		Jeu.etoiles_niveau += 1
		Jeu.score += 10
		Jeu.jouer_son("etoile")
		queue_free()
