extends StaticBody2D

# Un mur fissuré : seul un dash le brise.

func _physics_process(_delta):
	for body in $Detecteur.get_overlapping_bodies():
		if body.name == "Heros" and body.dash_restant > 0:
			Jeu.jouer_son("aie")
			queue_free()
