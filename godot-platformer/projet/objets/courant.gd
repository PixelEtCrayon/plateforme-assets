extends Area2D

# Un courant : tant que Robi est dedans, il est poussé dans la direction « pousse ».

@export var pousse = Vector2(0, -900)
@export var taille = Vector2(128, 256)


func _ready():
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size = taille
	$ColorRect.position = -taille / 2
	$ColorRect.size = taille
	$Bulles.emission_rect_extents = taille / 2


func _on_body_entered(body):
	if body.name == "Heros":
		body.courant = pousse


func _on_body_exited(body):
	if body.name == "Heros":
		body.courant = Vector2.ZERO
