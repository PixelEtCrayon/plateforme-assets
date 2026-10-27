extends Area2D

# Un projectile : il avance tout droit (ou en cloche si gravite > 0) et disparaît
# dès qu'il touche quelque chose.

var vitesse = Vector2(-250, 0)
var gravite = 0.0


func _physics_process(delta):
	vitesse.y += gravite * delta
	position += vitesse * delta


func _on_body_entered(body):
	if body.name == "Heros":
		body.blesser()
	queue_free()


func _on_duree_de_vie_timeout():
	queue_free()
