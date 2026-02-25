class_name Monsta extends Sprite2D

@onready var eating_zone: EatingZone = $EatingZone
@onready var marker_2d: Marker2D = $Marker2D
@onready var clap: AudioStreamPlayer = $Clap

var adaptive_music : EldritchAdaptiveMusic

func _ready() -> void:
	adaptive_music = get_tree().get_first_node_in_group("EldritchAdaptiveMusic")
	eating_zone.planet_suck.connect(suck_in_planet)

func suck_in_planet(planet : Planet):
	await adaptive_music.half_bar
	if adaptive_music.bar_index % 4 == 1:
		print("Good hit!")
	elif adaptive_music.bar_index % 4 == 2:
		print("Dragging!")
	else:
		print("Rushing!")
	
	clap.play()
	move_planet_to_marker(planet)

func move_planet_to_marker(planet : Planet) -> void:
	var tween : Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(planet, 'global_position', marker_2d.global_position, 0.2)
	await tween.finished
	planet.die()
