extends Node2D

# Un drone de lave posté : toutes les 2 secondes, il tire une boule vers Robi.

const BOULE = preload("res://objets/boule_lave.tscn")


func _on_chrono_timeout():
	var heros = get_tree().get_first_node_in_group("heros")
	if heros == null:
		return
	var sens = sign(heros.global_position.x - global_position.x)
	if sens == 0:
		sens = -1
	var boule = BOULE.instantiate()
	boule.vitesse = Vector2(sens * 250, 0)
	boule.position = position + Vector2(sens * 40, 0)
	get_parent().add_child(boule)
	$Sprite2D.flip_h = sens > 0


func _on_tete_body_entered(body):
	if body.name == "Heros":
		body.rebondir()
		Jeu.score += 5
		Jeu.jouer_son("aie")
		queue_free()


func _on_corps_body_entered(body):
	if body.name == "Heros" and body.global_position.y > global_position.y - 10:
		body.blesser()
