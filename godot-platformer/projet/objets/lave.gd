extends Area2D

# La lave monte sans arrêt. Si Robi la touche, il perd une cellule et repart
# du checkpoint, et la lave redescend à son point de départ.

@export var vitesse = 30.0
@export var hauteur_max = 256.0
@export var largeur = 4096.0
@export var hauteur = 1600.0

var depart = Vector2.ZERO


func _ready():
	depart = position
	add_to_group("remise_a_zero")
	$Fond.size = Vector2(largeur, hauteur)
	$Surface.size = Vector2(largeur, 20)
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = Vector2(largeur, hauteur)
	$CollisionShape2D.position = Vector2(largeur / 2, hauteur / 2)


func _physics_process(delta):
	if position.y > hauteur_max:
		position.y -= vitesse * delta


func remettre_a_zero():
	position = depart


func _on_body_entered(body):
	if body.name == "Heros":
		body.tomber()
