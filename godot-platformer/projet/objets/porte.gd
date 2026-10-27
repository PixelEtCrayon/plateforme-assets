extends StaticBody2D

# Une porte fermée. ouvrir() la fait coulisser vers le haut.

func ouvrir():
	var animation = create_tween()
	animation.tween_property(self, "position:y", position.y - 128, 0.6)
	$CollisionShape2D.set_deferred("disabled", true)
