extends AnimatableBody2D

# Une plateforme qui s'écroule peu après qu'on a marché dessus, puis revient.

var depart = Vector2.ZERO


func _ready():
	depart = position


func _on_detecteur_body_entered(body):
	if body.name == "Heros" and $Chrono.is_stopped():
		$Chrono.start()


func _on_chrono_timeout():
	var chute = create_tween()
	chute.tween_property(self, "position:y", position.y + 700, 1.0)
	chute.tween_interval(2.0)
	chute.tween_callback(revenir)


func revenir():
	position = depart
