extends CharacterBody2D

# Un robot qui patrouille : demi-tour au mur ou au bord du vide.
# On le vainc en lui sautant sur la tête ; le toucher sur le côté blesse Robi.

@export var vitesse = 80.0
@export var image: Texture2D
@export var image_vers_la_droite = true

var direction = -1


func _ready():
	if image != null:
		$Sprite2D.texture = image


func _physics_process(delta):
	velocity.y += 1200 * delta
	velocity.x = direction * vitesse
	move_and_slide()
	if is_on_wall() or (is_on_floor() and not $DetecteurVide.is_colliding()):
		faire_demi_tour()


func faire_demi_tour():
	direction = -direction
	$DetecteurVide.position.x = direction * 34
	$Sprite2D.flip_h = (direction < 0) == image_vers_la_droite


func _on_tete_body_entered(body):
	if body.name == "Heros":
		body.rebondir()
		Jeu.score += 5
		Jeu.jouer_son("aie")
		queue_free()


func _on_corps_body_entered(body):
	if body.name == "Heros" and body.global_position.y > global_position.y - 20:
		body.blesser()
