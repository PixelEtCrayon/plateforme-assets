extends CharacterBody2D

# Le Robot-Virus. Il attend, charge vers Robi, et se sonne contre le mur :
# c'est à ce moment-là seulement qu'on peut lui sauter sur la tête.

signal vaincu

enum Etat { ATTENTE, CHARGE, SONNE }

const BOULE = preload("res://objets/boule_lave.tscn")

var etat = Etat.ATTENTE
var vie = 5
var direction = -1
var chrono = 1.5


func _physics_process(delta):
	velocity.y += 1200 * delta
	chrono -= delta
	match etat:
		Etat.ATTENTE:
			velocity.x = 0
			if chrono <= 0:
				viser_robi()
				etat = Etat.CHARGE
		Etat.CHARGE:
			velocity.x = direction * (420 if vie > 2 else 600)
			if is_on_wall():
				etat = Etat.SONNE
				chrono = 2.0
		Etat.SONNE:
			velocity.x = 0
			if chrono <= 0:
				etat = Etat.ATTENTE
				chrono = 1.5
	move_and_slide()
	$Sprite2D.flip_h = direction < 0
	$Sprite2D.modulate = Color(0.6, 0.7, 1.0) if etat == Etat.SONNE else Color.WHITE
	$Indice.visible = etat == Etat.SONNE


func viser_robi():
	var heros = get_tree().get_first_node_in_group("heros")
	if heros != null:
		direction = sign(heros.global_position.x - global_position.x)
	if direction == 0:
		direction = -1


func prendre_un_coup():
	vie -= 1
	Jeu.jouer_son("aie")
	if vie <= 2:
		$Tir.wait_time = 1.0   # phase 2 : il tire deux fois plus souvent
	if vie <= 0:
		vaincu.emit()
		queue_free()


func _on_tete_body_entered(body):
	if body.name != "Heros":
		return
	body.rebondir()
	if etat == Etat.SONNE:
		prendre_un_coup()
	else:
		body.blesser()


func _on_corps_body_entered(body):
	if body.name == "Heros" and body.global_position.y > global_position.y - 40:
		body.blesser()


func _on_tir_timeout():
	if etat == Etat.SONNE:
		return
	tirer(direction)
	if vie <= 2:
		tirer(-direction)


func tirer(sens):
	var boule = BOULE.instantiate()
	boule.vitesse = Vector2(sens * 250, -450)
	boule.gravite = 900
	boule.position = position + Vector2(sens * 60, -40)
	get_parent().add_child(boule)
