extends Area2D

# Une méduse-drone électrique : elle flotte en vague. On ne peut pas l'écraser,
# il faut la contourner.

@export var amplitude = Vector2(120, 40)

var depart = Vector2.ZERO
var temps = 0.0


func _ready():
	depart = position


func _physics_process(delta):
	temps += delta
	position = depart + Vector2(sin(temps) * amplitude.x, sin(temps * 2.0) * amplitude.y)


func _on_body_entered(body):
	if body.name == "Heros":
		body.blesser()
