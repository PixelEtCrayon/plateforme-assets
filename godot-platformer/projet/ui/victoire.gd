extends Control

# L'écran de fin : la station est réparée.

func _ready():
	$Boite/Etoiles.text = "Etoiles : %d / 12   Cellules : %d" % [Jeu.total_etoiles(), Jeu.score]
	Jeu.jouer_son("victoire")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://ui/menu.tscn")
