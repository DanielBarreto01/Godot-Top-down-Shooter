extends KinematicBody2D
class_name Player


export (int) var speed = 100


onready var team = $Team
onready var weapon: Weapon = $Weapon
onready var health_stat = $Health


func _ready() -> void:
	weapon.initialize(team.team)


func _physics_process(delta: float) -> void:
	var movement_direction := Vector2.ZERO

	if Input.is_action_pressed("up"):
		movement_direction.y = -1
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1

	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * speed)

	look_at(get_global_mouse_position())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		weapon.shoot()
	elif event.is_action_released("reload"):
		weapon.start_reload()


func reload():
	weapon.start_reload()


func get_team() -> int:
	return team.team



	
func handle_hit(damage: int):
	# Realiza las acciones necesarias para manejar el daño al jugador
	health_stat.health -= damage
	print("Player hit! ", health_stat.health)
#    if health_stat.health <= 0:
#        # Agrega aquí la lógica para el manejo de la muerte del jugador, como reiniciar el nivel, mostrar un mensaje de game over, etc.
#        # Por ejemplo, puedes reiniciar el nivel.
#        get_tree().reload_current_scene()

