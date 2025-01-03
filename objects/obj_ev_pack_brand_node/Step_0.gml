node_instance_step()
spin_h = dcos(global.editor_time * 1.2) / 25
spin_v = dsin(global.editor_time / 2) / 32

if (remember_brand != brand) {
	sprite_delete(brand_sprite);
	brand_sprite = create_brand_sprite(brand);
	sprite_index = brand_sprite;
	remember_brand = brand;
}