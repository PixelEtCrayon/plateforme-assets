extends Area2D

# Un interrupteur : quand Robi marche dessus, il envoie le signal « active ».
# La porte qui l'écoute s'ouvre.

signal active

var deja_active = false


func _on_body_entered(body):
	if body.name == "Heros" and not deja_active:
		deja_active = true
		$Off.hide()
		$On.show()
		Jeu.jouer_son("selection")
		active.emit()
