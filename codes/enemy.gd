extends CharacterBody2D
	
var speed = 100
var chase = false
var player = null
var health = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_in_zone = false


func _physics_process(delta):
	update_health()

	if chase:
		$AnimatedSprite2D.play("aggressive")
		
		if velocity.y < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true

		position += (player.position - position).normalized()*speed*delta
		move_and_collide(Vector2(0,0)) 
	else :
		$AnimatedSprite2D.play("passive")

	if not is_on_floor():
		velocity.y += gravity * delta


func update_health():
	var enemy_health = $enemy_health
	
	enemy_health.value = health
	

func _on_detection_area_body_entered(body):
	player = body
	chase = true


func _on_detection_area_body_exited(body):
	player = null
	chase = false
	
func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_zone = false












