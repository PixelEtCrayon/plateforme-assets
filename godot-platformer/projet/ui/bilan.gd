extends CanvasLayer

# L'écran de fin de secteur : étoiles trouvées et capacité gagnée.

const NOMS_CAPACITES = {
	"double_saut": "le DOUBLE SAUT (appuie deux fois sur Saut)",
	"planer": "PLANER (garde Saut enfoncé en tombant)",
	"dash": "le DASH (touche Maj)",
}


func afficher(etoiles, capacite):
	$Boite/Etoiles.text = "Etoiles trouvées : %d / 3" % etoiles
	if capacite in NOMS_CAPACITES:
		$Boite/Capacite.text = "Robi apprend " + NOMS_CAPACITES[capacite] + " !"
	else:
		$Boite/Capacite.text = "La station est sauvée !"
	visible = true
	get_tree().paused = true


func _on_continuer_pressed():
	get_tree().paused = false
	Jeu.niveau_suivant()
