
// modified version of http://www.davetech.co.uk/gamemakercubeoutline to have a texture.
function ev_draw_cube(sprite, subimg, draw_x, draw_y, size, spin_h, spin_v) {
	spin_h %= 1;
	spin_v %= 1;
	
	spin_h *= 2;
	spin_v *= 2;
	
	var nodes = [[-1, -1, -1], [-1, -1, 1], [-1, 1, -1], [-1, 1, 1],
    [1, -1, -1], [1, -1, 1], [1, 1, -1], [1, 1, 1]];
 

	spin_h *= pi
	spin_v *= pi

	var sin_x = sin(spin_h);
	var cos_x = cos(spin_h);
 
	var sin_y = sin(spin_v);
	var cos_y = cos(spin_v);
	
	var number_of_nodes = array_length(nodes)
	for (var i = 0; i < number_of_nodes; ++i) {
	
		var node = nodes[i]

	    var _x = node[0];
	    var _y = node[1];
	    var _z = node[2];
 
	    node[0] = _x * cos_x - _z * sin_x;
	    node[2] = _z * cos_x + _x * sin_x;
 
	    _z = node[2];
 
	    node[1] = _y * cos_y - _z * sin_y;
	    node[2] = _z * cos_y + _y * sin_y;
	
	
		nodes[i] = node
	};

	var faces = [
		new ev_cube_face(nodes[0], nodes[1], nodes[2], nodes[3]),
		new ev_cube_face(nodes[5], nodes[4], nodes[7], nodes[6]),
		new ev_cube_face(nodes[0], nodes[1], nodes[4], nodes[5]),
		new ev_cube_face(nodes[2], nodes[3], nodes[6], nodes[7]),
		new ev_cube_face(nodes[4], nodes[0], nodes[6], nodes[2]),
		new ev_cube_face(nodes[1], nodes[5], nodes[3], nodes[7]),
	]
	
	array_sort(faces, function (face1, face2) {
		return (ev_get_average_face_z(face1) < ev_get_average_face_z(face2) ? 1 : -1)
	})
	for (var i = 0; i < array_length(faces); i++) {
		ev_draw_face(sprite, subimg, draw_x, draw_y, size, faces[i])
		delete faces[i];
	}
	
}


function ev_draw_face(sprite, subimg, draw_x, draw_y, size, face) {
	draw_sprite_pos(sprite, subimg, draw_x + (face.p2[0] * size), draw_y + (face.p2[1] * size), draw_x + (face.p1[0] * size), draw_y + (face.p1[1] * size),
			draw_x + (face.p3[0] * size), draw_y + (face.p3[1] * size), draw_x + (face.p4[0] * size), draw_y + (face.p4[1] * size), 1)
}

function ev_cube_face(p1, p2, p3, p4) constructor {
	self.p1 = p1;
	self.p2 = p2;
	self.p3 = p3;
	self.p4 = p4;
}

function ev_get_average_face_z(face) {
	return (face.p1[2] + face.p2[2] + face.p3[2] + face.p4[2]) / 4
}

