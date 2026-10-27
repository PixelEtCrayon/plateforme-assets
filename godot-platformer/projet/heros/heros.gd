extends CharacterBody2D

signal batterie_changee(valeur)
signal mort

var vitesse = 300.0
var gravite = 1200.0
var force_saut = -650.0

var batterie = 3
var boost = 0.0
var sauts = 0
var regard = 1

var dans_eau = false
var sur_glace = false
var courant = Vector2.ZERO
var dash_restant = 0.0
var dash_disponible = true
var invincible = 0.0

@onready var sprite = $AnimatedSprite2D
@onready var flamme = $Flamme


func _physics_process(delta):
	var direction = Input.get_axis("gauche", "droite")
	if direction != 0:
		regard = sign(direction)
	if dans_eau:
		nager(delta)
	else:
		sauter_et_tomber(delta)
	courir(direction, delta)
	dasher(delta)
	move_and_slide()
	invincible = max(invincible - delta, 0.0)
	animer(direction)


func courir(direction, _delta):
	var cible = direction * vitesse + courant.x
	if sur_glace:
		velocity.x = lerp(velocity.x, cible, 0.04)
	else:
		velocity.x = cible


func dasher(delta):
	if is_on_floor():
		dash_disponible = true
	if Input.is_action_just_pressed("dash") and Jeu.capacites["dash"] and dash_disponible and not dans_eau:
		dash_restant = 0.25
		dash_disponible = false
		Jeu.jouer_son("selection")
	if dash_restant > 0:
		dash_restant -= delta
		velocity = Vector2(regard * 900, 0)   # tout droit, sans tomber


func sauter_et_tomber(delta):
	if is_on_floor():
		sauts = 0
	else:
		velocity.y += (gravite + courant.y) * delta
		if sauts == 0:
			sauts = 1   # on a quitté le sol en tombant : pas de saut gratuit
	var sauts_max = 2 if Jeu.capacites["double_saut"] else 1
	if Input.is_action_just_pressed("sauter") and sauts < sauts_max:
		velocity.y = force_saut
		sauts += 1
		Jeu.jouer_son("saut")
	planer(delta)


func planer(delta):
	var veut_planer = Input.is_action_pressed("sauter") and velocity.y > 0
	if veut_planer and boost > 0 and Jeu.capacites["planer"]:
		velocity.y = 80
		boost -= 30 * delta
		flamme.emitting = true
	else:
		flamme.emitting = false


func nager(delta):
	velocity.y += (300 + courant.y) * delta
	if Input.is_action_pressed("sauter"):
		velocity.y -= 900 * delta
	velocity.y = clamp(velocity.y, -260, 220)
	sauts = 0
	flamme.emitting = false


func rebondir():
	velocity.y = -700
	sauts = 1


func recharger(quantite):
	boost = min(boost + quantite, 100.0)


func blesser():
	if invincible > 0 or batterie <= 0:
		return
	batterie -= 1
	invincible = 1.5
	Jeu.jouer_son("aie")
	batterie_changee.emit(batterie)
	if batterie <= 0:
		mourir()
	else:
		velocity.y = -350


func tomber():
	if batterie <= 0:
		return
	batterie -= 1
	Jeu.jouer_son("aie")
	batterie_changee.emit(batterie)
	if batterie <= 0:
		mourir()
	else:
		invincible = 1.0
		revenir_au_checkpoint()


func mourir():
	velocity = Vector2.ZERO
	set_physics_process(false)
	Jeu.perdre()


func revenir_au_checkpoint():
	velocity = Vector2.ZERO
	global_position = Jeu.checkpoint
	$Camera2D.reset_smoothing()
	mort.emit()


func animer(direction):
	sprite.flip_h = regard < 0
	var clignote = invincible > 0 and fmod(invincible, 0.2) < 0.1
	sprite.modulate.a = 0.4 if clignote else 1.0
	if dans_eau:
		sprite.play("nage")
	elif not is_on_floor():
		sprite.play("saut")
	elif direction != 0:
		sprite.play("course")
	else:
		sprite.play("idle")
