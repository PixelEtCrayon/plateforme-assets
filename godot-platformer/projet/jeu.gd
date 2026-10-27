extends Node

# Ce script est un AUTOLOAD : il est chargé une fois pour toutes et accessible
# partout sous le nom « Jeu ». Il garde ce qui doit survivre aux changements de niveau.

const NIVEAUX = [
	"res://niveaux/jardin.tscn",
	"res://niveaux/inonde.tscn",
	"res://niveaux/gele.tscn",
	"res://niveaux/reacteur.tscn",
]
const FICHIER_SAUVEGARDE = "user://sauvegarde.save"

var score = 0
var score_au_depart = 0     # score en entrant dans le niveau, repris au game over
var etoiles = {}            # nom du niveau -> étoiles trouvées (0 à 3)
var etoiles_niveau = 0      # étoiles trouvées dans le niveau en cours
var capacites = {"double_saut": false, "planer": false, "dash": false}
var checkpoint = Vector2.ZERO
var niveau_actuel = 0

# nom utilisé dans le jeu -> fichier du pack de sons
const FICHIERS_SONS = {
	"saut": "jump", "cellule": "coin", "etoile": "powerup", "aie": "hit",
	"selection": "select", "message": "message", "victoire": "victory", "depart": "start",
}

var sons = {}


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS   # les sons jouent même en pause
	for nom in FICHIERS_SONS:
		var lecteur = AudioStreamPlayer.new()
		lecteur.stream = load("res://sons/sfx_%s.wav" % FICHIERS_SONS[nom])
		add_child(lecteur)
		sons[nom] = lecteur
	charger()


func jouer_son(nom):
	sons[nom].play()


func commencer_niveau(numero):
	niveau_actuel = numero
	etoiles_niveau = 0
	get_tree().change_scene_to_file.call_deferred(NIVEAUX[numero])


func terminer_niveau(nom, capacite_gagnee):
	etoiles[nom] = max(etoiles.get(nom, 0), etoiles_niveau)
	if capacite_gagnee != "":
		capacites[capacite_gagnee] = true
	sauvegarder()


func niveau_suivant():
	if niveau_actuel + 1 < NIVEAUX.size():
		commencer_niveau(niveau_actuel + 1)
	else:
		get_tree().change_scene_to_file.call_deferred("res://ui/victoire.tscn")


func perdre():
	score = score_au_depart
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()


func total_etoiles():
	var total = 0
	for nom in etoiles:
		total += etoiles[nom]
	return total


func sauvegarder():
	var fichier = FileAccess.open(FICHIER_SAUVEGARDE, FileAccess.WRITE)
	fichier.store_var({"score": score, "etoiles": etoiles, "capacites": capacites})


func charger():
	var fichier = FileAccess.open(FICHIER_SAUVEGARDE, FileAccess.READ)
	if fichier == null:
		return
	var donnees = fichier.get_var()
	score = donnees["score"]
	etoiles = donnees["etoiles"]
	capacites = donnees["capacites"]


func effacer_sauvegarde():
	score = 0
	etoiles = {}
	for nom in capacites:
		capacites[nom] = false
	DirAccess.remove_absolute(FICHIER_SAUVEGARDE)
