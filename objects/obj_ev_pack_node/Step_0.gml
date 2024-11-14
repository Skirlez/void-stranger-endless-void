node_instance_step()
spin_time_h += 0.45 + random_range(-0.05, 0.05)
spin_time_v += 0.38 + random_range(-0.05, 0.05)
spin_h = (dsin(spin_time_h) + 1) / 2;
spin_v = (dcos(spin_time_v) + 1) / 2;