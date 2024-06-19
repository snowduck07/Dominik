extends CharacterBody2D

const SPEED = 500
const JUMP_VELOCITY = -450
var attack_range = false
var damage_cooldown = true
var health = 100


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left")
	
	if is_on_floor() or abs(velocity.x) > 0.1:
		# Wenn der Charakter auf dem Boden ist oder sich horizontal bewegt, ermögliche die Steuerung
		if direction != 0:
			$AnimatedSprite2D.play("walk")
			velocity.x = direction * SPEED
			if direction < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			$AnimatedSprite2D.play("idle")
	else:
		# Wenn der Charakter in der Luft ist und sich nicht horizontal bewegt, halte die horizontale Geschwindigkeit bei 0, um die Steuerung zu blockieren
		velocity.x = 0
		
	# Apply gravity only if not on floor.
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("jump")

	move_and_slide()
	enemy_attack()
	if health <= 0:
		health = 0
		get_tree().change_scene_to_file("res://szenen/deathscreen.tscn")

func player():
	pass


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		attack_range = false

func enemy_attack():
	if attack_range and damage_cooldown == true:
		health = health - 20
		damage_cooldown = false
		$damage_cooldown.start()
		print ("health: " + str(health))


func _on_cooldown_timeout():
	damage_cooldown = true
