extends Node2D

# Un drone volant : il vole en vague, sans gravité. Lui sauter dessus
# donne un grand rebond, pratique pour atteindre une étoile.

@export var amplitude = Vector2(160, 30)

var depart = Vector2.ZERO
var temps = 0.0


func _ready():
	depart = position


func _physics_process(delta):
	temps += delta
	position = depart + Vector2(sin(temps * 0.8) * amplitude.x, sin(temps * 2.0) * amplitude.y)
	$Sprite2D.flip_h = cos(temps * 0.8) > 0


func _on_tete_body_entered(body):
	if body.name == "Heros":
		body.rebondir()
		Jeu.score += 5
		Jeu.jouer_son("aie")
		queue_free()


func _on_corps_body_entered(body):
	if body.name == "Heros" and body.global_position.y > global_position.y - 10:
		body.blesser()
