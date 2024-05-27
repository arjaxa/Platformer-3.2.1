extends Area2D



func _on_FoodArea_body_entered(body):
	GameManager.Player.increaseScore()
	queue_free()
