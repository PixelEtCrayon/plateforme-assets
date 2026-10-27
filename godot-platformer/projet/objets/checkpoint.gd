extends Area2D

# Un drapeau : quand Robi passe, il repartira d'ici s'il vide sa batterie.

var active = false


func _on_body_entered(body):
	if body.name == "Heros" and not active:
		active = true
		Jeu.checkpoint = body.global_position
		Jeu.jouer_son("message")
		$Sprite2D.modulate = Color(0.7, 1.0, 0.7)
