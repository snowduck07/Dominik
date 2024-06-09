extends CharacterBody2D
	
var speed = 100
var chase = false
var player = null

func _physics_process(delta):
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


func _on_detection_area_body_entered(body):
	
	player = body
	chase = true


func _on_detection_area_body_exited(body):

	player = null
	chase = false

func enemy():
	pass
