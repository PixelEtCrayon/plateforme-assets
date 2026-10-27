extends CanvasLayer

# Le menu pause : la touche Echap gèle le jeu et montre les boutons.

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		basculer()


func basculer():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
	Jeu.jouer_son("selection")


func _on_reprendre_pressed():
	basculer()


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/menu.tscn")
