extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movingright
var velocity = Vector2()
var walkspeed = 350
var gravityscale = 500
var jumpvelocity = 2500
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.Player = self
	movingright = true
	
func increaseScore():
	score = score + 1
	$FoodSound.play()
	
	for node in GameManager.UI.get_children():
		if node is Label:
			node.set_text(String(score))
	

func get_input():
	if Input.is_action_pressed("ui_right"):
		movingright = true
		$AnimatedSprite.play("walk")
		velocity.x = walkspeed
	elif Input.is_action_pressed("ui_left"):
			movingright = false
			$AnimatedSprite.play("walk")
			velocity.x = -walkspeed
	else:
		$AnimatedSprite.play("idle")
		velocity.x = 0
		
	if not movingright:
		$AnimatedSprite.set_flip_h(true)
	else:
		$AnimatedSprite.set_flip_h(false)
	if Input.is_action_pressed("player_jump"):
		$jumpSound.play()
		velocity.y -= jumpvelocity
	

func _physics_process(delta):
	velocity.y = gravityscale
	get_input()
	move_and_slide(velocity)
