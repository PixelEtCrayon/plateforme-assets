extends Node2D

@export var nom = "jardin"
@export var capacite_gagnee = ""   # capacité débloquée quand on rallume le générateur

@onready var heros = $Heros
@onready var sol = $Sol
@onready var camera = $Heros/Camera2D


func _ready():
	var zone = sol.get_used_rect()
	var taille = sol.tile_set.tile_size
	camera.limit_left = zone.position.x * taille.x
	camera.limit_top = zone.position.y * taille.y - 256
	camera.limit_right = zone.end.x * taille.x
	camera.limit_bottom = zone.end.y * taille.y
	Jeu.checkpoint = heros.global_position
	Jeu.score_au_depart = Jeu.score
	Jeu.etoiles_niveau = 0
	heros.mort.connect(_on_heros_mort)
	Jeu.jouer_son("depart")


func _physics_process(_delta):
	if heros.position.y > camera.limit_bottom + 200:
		heros.tomber()


func _on_heros_mort():
	get_tree().call_group("remise_a_zero", "remettre_a_zero")


func terminer():
	Jeu.terminer_niveau(nom, capacite_gagnee)
	$Bilan.afficher(Jeu.etoiles_niveau, capacite_gagnee)
