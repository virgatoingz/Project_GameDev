extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
var speed = 2000
var last_direction = "South" # arah awal default

func _ready():
	sprite.animation = "Idle_South"
	sprite.play()

var base_scale = Vector2(2, 2)

func _process(delta):
		var min_scale = 0.75
		var max_scale = 1.15

		var y = global_position.y
		var top_limit = 30     # SESUAIKAN
		var bottom_limit = 180 # SESUAIKAN

		var t = clamp((y - top_limit) / float(bottom_limit - top_limit), 0.0, 1.0)
		var scale_factor = lerp(min_scale, max_scale, t)

		scale = base_scale * scale_factor

		if has_node("Shadow"):
			$Shadow.scale = Vector2(scale_factor * 0.8, scale_factor * 0.5)




func _physics_process(delta):
	var input_vector = Vector2.ZERO
	var target_animation = ""

	# Input horizontal
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
		last_direction = "East"
		target_animation = "Run_East"
	elif Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
		last_direction = "West"
		target_animation = "Run_West"

	# Input vertical
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
		last_direction = "South"
		target_animation = "Run_South"
	elif Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		last_direction = "North"
		target_animation = "Run_North"

	# Kalau tidak bergerak → animasi idle sesuai arah terakhir
	if input_vector == Vector2.ZERO:
		target_animation = "Idle_%s" % last_direction

	# Hanya ubah animasi jika berbeda
	if sprite.animation != target_animation:
		sprite.animation = target_animation
		sprite.play()

	# Normalisasi dan gerak
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()
