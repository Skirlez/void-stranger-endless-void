/// @description export level as a gameboy save
// You can write your code in this editor

if global.mouse_layer != 0
	exit
//show_debug_message(export_level(global.level))
//show_debug_message("writing gba save to " + working_directory + "GBAStranger.sav");

// for reasons unknown to the gods, the working directory means nothing :)
// actually written to \AppData\Local\void_stranger_endless_void


show_debug_message("writing gba save");


//file_bin_write_byte(binf, 255);


var collisionTiles = array_create(126, 0);
var floorTiles = array_create(126, 0);
var detailsTiles = array_create(126, 0);
var entities = [];


// why do x and y not work as vars here?
for(var i=0; i < 14; i++) {
	for(var j=0; j < 9; j++) {
		
		
		
		
		var tile = global.level.tiles[j][i].tile.tile_id; 
		// wtf is noone?
		var entity = global.level.objects[j][i] == noone ? "em" : global.level.objects[j][i].tile.tile_id;
		//show_debug_message(tile_state.tile.tile_id);
		
		// does gamemaker have dicts?(which arent a pain)
		var output = 0;
		
		switch(tile) {
			
			case "ur":
			case "pt":
				output = 0;
				break;
			case "fl":
				 output = 1;
				 break;
			case "gl":
				output = 2;
				break;
			case "mn":
				output = 3;
				break;
			case "fs":
				output = 7;
				break;
			case "cr":
				output = 5;
				break;
			case "ex":
				output = 6;
				break;
			case "df":
				output = 4;
				break;
			
			
			default:
				output = 0;
				show_debug_message("unknown tile type of: " + tile + " at x=" + string(i) + " y=" + string(j));
				break;
				
		}
		floorTiles[j * 14 + i] = output;
		
		if(entity != "em") {
			output = 0;
			switch(entity) {
			
				case "pl":
					output = 1;
					break;
				case "cl":
					output = 2;
					break;
				case "cc":
					output = 3;
					break;
				case "cg":
					output = 5;
					break;
				case "cs":
					output = 6;
					break;
				case "ch":
					output = 4;
					break;
				case "cm":
					output = 7;
					break;

				default:
					show_debug_message("unknown entity type of: " + entity + " at x=" + string(i) + " y=" + string(j));
					break;
			}
			
			if(output == 0) {
				array_insert(entities, 0, [output, i, j]);
			} else {
				array_push(entities, [output, i, j]);
			}
			
		}
		
		//show_debug_message(entity);
		
	}
}

// i copied my python code, and am lazy
function len(arr) {
	return array_length(arr);	
}

function compressData(arr) {
	
	
	
	var res = []
	
	var count = 1
	var val = arr[0]
	for(var i=1; i<len(arr) + 1; i++) {
		
		
		if(arr[min(i, len(arr)-1)] & 0xC0) {
			show_debug_message("a value passed into the compression func had bit 7 or bit 6 set. this is not allowed!")
			exit
		}
		
		if(i == len(arr) or arr[i] != val) {
			
			if(count == 1 or count == 2 or count == 3) {
				array_push(res, val | (count << 6))
			} else {
				array_push(res, count)
				array_push(res, val)
			}
			
			if(i == len(arr)) {
				break
			}
		
			count = 1
			val = arr[i]
		} else {
			count += 1
			
			if(count == 0x40) {
				
				count-=1
				
				array_push(res, count)
				array_push(res, val)
				
				count = 1
				val = arr[i]
			}
		}
	}
		
	return res;
}


global.binOffset = 0;


global.outputBuffer = [];


function writeByte(byte) {
	//file_bin_write_byte(global.binf, byte);	
	if(global.binOffset == len(global.outputBuffer)) {
		array_push(global.outputBuffer, byte);
	} else {
		global.outputBuffer[global.binOffset] = byte & 0xFF;
	}
	
	global.binOffset++;
}

function writeShort(short) {
	//file_bin_write_byte(global.binf, (short >> 8) & 255);
	//file_bin_write_byte(global.binf, (short & 255));
 	//array_push(global.outputBuffer, (short >> 8) & 255);
 	//array_push(global.outputBuffer, (short & 255));
	//global.binOffset+=2;
	
	writeByte( (short >> 8) & 255);
	writeByte( (short & 255));
 	
}

function writeUnsigned(int) {
	//file_bin_write_byte(global.binf, (int >> 24) & 255);
	//file_bin_write_byte(global.binf, (int >> 16) & 255);
	//file_bin_write_byte(global.binf, (int >> 8) & 255);
	//file_bin_write_byte(global.binf, (int & 255));
	//array_push(global.outputBuffer, (int >> 24) & 255);
	//array_push(global.outputBuffer, (int >> 16) & 255);
	//array_push(global.outputBuffer, (int >> 8) & 255);
	//array_push(global.outputBuffer, (int & 255));
	//global.binOffset+=4;
	
	// is the gba big or little endian??
	
	writeByte( (int >> 24) & 255);
	writeByte( (int >> 16) & 255);
	writeByte( (int >> 8) & 255);
	writeByte( (int & 255));
}

function writeString(s) {
	
	for(var i=0; i<string_length(s); i++) {
		writeByte(ord(string_char_at(s, i+1))); // indexing at 1. omfg
	}
	
	writeByte(0); // nullterm
	
}

function writeArray(arr) {
	
	for(var i=0; i<len(arr); i++) {
		writeByte(arr[i]);
	}
}

// header 
writeUnsigned(42);

var roomCount = 1;

// room count 
writeUnsigned(roomCount);

// placeholders for room offsets.
for(var i=0; i<roomCount; i++) {
	writeShort(0xFFFF);
}

// room string 
for(var i=0; i<roomCount; i++) {
	writeString("rm_001");
}

// shit, precalcing all room offsets here is going to be,,,, bad.
// at least for now, only having one room will make it pretty ok
// orrrr,,, i could store the roomdata table at the end?
// i would only have to rewind to one unsigned.
// or ill just store the whole file in an array.

var roomOffsets = [];

for(var i=0; i<roomCount; i++) {
	
	array_push(roomOffsets, global.binOffset);
	
	var compressedCollision = compressData(collisionTiles);
	var compressedFloor = compressData(floorTiles);
	var compressedDetails = compressData(detailsTiles);
	
	var startOffset = global.binOffset;
	
	// length of entities
	writeShort(len(entities));
	// offset of details
	writeShort(startOffset + 8 + len(compressedCollision));
	// offset of floor 
	writeShort(startOffset + 8 + len(compressedCollision) + len(compressedDetails));
	// offset of entities
	writeShort(startOffset + 8 + len(compressedCollision) + len(compressedDetails) + len(compressedFloor));
	
	//show_debug_message(string(startOffset + 8 + len(compressedCollision)));
	
	writeArray(compressedCollision);
	writeArray(compressedDetails);
	writeArray(compressedFloor);
	
	/*
	for(var j=0; j<floor(len(entities) / 3); j++) {
		writeUnsigned(entities[j + 0]);
		writeShort(entities[j + 1]);
		writeShort(entities[j + 2]);
	}
	*/
	for(var j=0; j<len(entities); j++) {
		writeByte(entities[j][0])		
		writeByte(entities[j][1])		
		writeByte(entities[j][2])		
	}
	
	
	
}

//array_push(roomOffsets, offsetStart + len(


// set actual room offsets.
global.binOffset = 8;
for(var i=0; i<roomCount; i++) {
	writeShort(roomOffsets[i]);
}



var binf = file_bin_open(working_directory + "GBAStranger.sav", 1);

for(var i=0; i<len(global.outputBuffer); i++) {
	file_bin_write_byte(binf, global.outputBuffer[i]);	
}

file_bin_close(binf);

