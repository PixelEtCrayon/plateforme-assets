extends Control

# Le menu principal : jouer, choisir un secteur déjà atteint, voir ses étoiles.

const SECTEURS = ["jardin", "inonde", "gele", "reacteur"]


func _ready():
	rafraichir()


func rafraichir():
	$Boite/Etoiles.text = "Etoiles : %d / 12" % Jeu.total_etoiles()
	var boutons = $Boite/Secteurs.get_children()
	for i in boutons.size():
		boutons[i].disabled = not secteur_atteint(i)
		boutons[i].text = "%s\n%d / 3" % [boutons[i].name, Jeu.etoiles.get(SECTEURS[i], 0)]


func secteur_atteint(i):
	return i == 0 or SECTEURS[i - 1] in Jeu.etoiles


func premier_secteur_a_faire():
	for i in SECTEURS.size():
		if not SECTEURS[i] in Jeu.etoiles:
			return i
	return 0


func _on_jouer_pressed():
	Jeu.jouer_son("depart")
	Jeu.commencer_niveau(premier_secteur_a_faire())


func _on_secteur_pressed(numero):
	Jeu.jouer_son("depart")
	Jeu.commencer_niveau(numero)


func _on_effacer_pressed():
	Jeu.effacer_sauvegarde()
	rafraichir()


func _on_quitter_pressed():
	get_tree().quit()
