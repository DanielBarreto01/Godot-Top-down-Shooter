extends Area2D
class_name Bullet


export (int) var speed = 10


onready var kill_timer = $KillTimer


var direction := Vector2.ZERO
var team: int = -1
var distance_traveled: float = 0.0


func _ready() -> void:
	kill_timer.start()


func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed

		global_position += velocity

		#Distancia en este frame
		distance_traveled += velocity.length()

func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_KillTimer_timeout() -> void:
	queue_free()
	
func get_damage() -> int:
	# Define una función que devuelve un daño basado en la distancia recorrida
	# Puedes ajustar la fórmula según tus necesidades
	var base_damage = 10
	var max_distance = 100.0  # La distancia máxima para el daño completo
	var damage_modifier = clamp(1.0 - (distance_traveled / max_distance), 0.0, 1.0)
	return int(base_damage * damage_modifier)



#func _on_Bullet_body_entered(body: Node) -> void:
#	if body.has_method("handle_hit"):
#		if body.has_method("get_team") and body.get_team() != team:
#			body.handle_hit()
#		queue_free()
#
#
func _on_Bullet_body_entered(body: Node) -> void:
	if body.has_method("handle_hit"):
		if body.has_method("get_team") and body.get_team() != team:
			var damage = get_damage()  # Obtiene el daño modificado basado en la distancia
			body.handle_hit(damage)  # Pasa el daño al enemigo
		queue_free()


