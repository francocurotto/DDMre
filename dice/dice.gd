extends RigidBody3D

func roll_dice():
	var random_force = Vector3(randf_range(-5, 5), randf_range(5, 10), randf_range(-5, 5))
	var random_torque = Vector3(randf_range(-5, 5), randf_range(-5, 5), randf_range(-5, 5))

	apply_central_impulse(random_force)  # Push the dice
	apply_torque_impulse(random_torque)  # Add spin
