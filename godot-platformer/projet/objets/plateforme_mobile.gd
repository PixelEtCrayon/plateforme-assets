extends AnimatableBody2D

# Une plateforme qui fait l'aller-retour. Elle transporte Robi quand il est dessus.

@export var deplacement = Vector2(192, 0)
@export var duree = 2.0


func _ready():
	var animation = create_tween().set_loops()
	animation.tween_property(self, "position", position + deplacement, duree)
	animation.tween_property(self, "position", position, duree)
