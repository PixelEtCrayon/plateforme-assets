extends Area2D

# Le générateur du secteur : le rallumer termine le niveau.

@export var cache_au_depart = false   # vrai dans le Réacteur : il apparaît quand le boss est vaincu

var allume = false


func _ready():
	if cache_au_depart:
		visible = false
		$CollisionShape2D.disabled = true


func activer():
	visible = true
	$CollisionShape2D.set_deferred("disabled", false)


func _on_body_entered(body):
	if body.name == "Heros" and not allume:
		allume = true
		$Off.hide()
		$On.show()
		Jeu.jouer_son("victoire")
		get_tree().current_scene.terminer()
