extends CanvasLayer

# L'affichage tête haute : batterie, boost, cellules et étoiles.

@onready var coeurs = $Marge/Haut/Batterie.get_children()


func _ready():
	var heros = get_tree().get_first_node_in_group("heros")
	heros.batterie_changee.connect(_on_batterie_changee)
	_on_batterie_changee(heros.batterie)


func _process(_delta):
	var heros = get_tree().get_first_node_in_group("heros")
	$Marge/Haut/Boost.value = heros.boost
	$Marge/Haut/Score.text = "Cellules : %d" % Jeu.score
	$Marge/Haut/Etoiles.text = "Etoiles : %d / 3" % Jeu.etoiles_niveau


func _on_batterie_changee(valeur):
	for i in coeurs.size():
		coeurs[i].modulate.a = 1.0 if i < valeur else 0.25
	$GameOver.visible = valeur <= 0
