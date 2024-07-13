if room != global.editor_room
	exit

if global.mouse_layer != 0
	exit
//show_debug_message(export_level(global.level))
//show_debug_message("writing gba save to " + working_directory + "GBAStranger.sav");

// for reasons unknown to the gods, the working directory means nothing :)
// actually written to \AppData\Local\void_stranger_endless_void

enum EntityType {
	Entity,

	Player,

	Leech,
	Maggot,
	Eye,
	Bull,
	Chester,

	Mimic,
	WhiteMimic,
	GrayMimic,
	BlackMimic,

	Diamond,
	Shadow,

	Boulder,
	Chest,

	AddStatue,
	EusStatue,
	BeeStatue,
	MonStatue,
	TanStatue,
	GorStatue,
	LevStatue,
	CifStatue,
	JukeBox,

	Interactable,

	// i am not sure if this is the best way to do this, but I am going with it
	EmptyChest
};


enum TileType {
	Pit,
	Floor,
	Glass,
	Bomb,
	Death,
	Copy,
	Exit,
	Switch,
	WordTile,
	RodTile,
	LocustTile,
	SpriteTile,
	HalfBomb,
};

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
				output = TileType.Pit;
				break;
			case "wh":
			case "fl":
				output = TileType.Floor;
				break;
			case "gl":
				output = TileType.Glass;
				break;
			case "mn":
				output = TileType.Bomb;
				break;
			case "fs":
				output = TileType.Switch;
				break;
			case "cr":
				output = TileType.Copy;
				break;
			case "ex":
				output = TileType.Exit;
				break;
			case "df":
				output = TileType.Death;
				break;
			case "xp":
				output = TileType.HalfBomb
				break;
			
			// -----
			
			case "st":
				// this is for a chest. oh no.
				output = TileType.Floor; // put a floor under it 
				array_push(entities, [EntityType.Chest, i, j]);
				break;
			
			// -----
			
			// ill care some other time
			case "mw":
			case "dw":
			case "ew":
			case "de":
			case "wa":
			case "ed":
				collisionTiles[j * 14 + i] = 3;
				break;
				
			case "bl":
				output = TileType.Floor;
				break;
				
			
			// -----
			
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
					output = EntityType.Player;
					break;
				case "cl":
					output = EntityType.Leech;
					break;
				case "cc":
					output = EntityType.Maggot;
					break;
				case "cg":
					output = EntityType.Bull;
					break;
				case "cs":
					output = EntityType.Chester;
					break;
				case "ch":
					output = EntityType.Eye;
					break;
				case "cm":
					output = EntityType.Mimic;
					break;
				case "co":
					output = EntityType.Diamond;
					break;
					
				// -----
					
				case "eg":
					output = EntityType.Boulder;
					break;
				case "ad":
					output = EntityType.AddStatue;
					break;
				case "cf":
					output = EntityType.CifStatue;
					break;
				case "be":
					output = EntityType.BeeStatue;
					break;
				case "tn":
					output = EntityType.TanStatue;
					break;
				case "lv":
					output = EntityType.LevStatue;
					break;
				case "mo":
					output = EntityType.MonStatue;
					break;
				case "go":
					output = EntityType.GorStatue;
					break;
				case "jb":
					output = EntityType.JukeBox;
					break;
				case "eu":
					output = EntityType.EusStatue;
					break;
				
				// -----
				
				default:
					show_debug_message("unknown entity type of: " + entity + " at x=" + string(i) + " y=" + string(j));
					break;
			}
			
			if(output == 0) {
				continue;
			}
			
			if(output == 1) {
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

// burden state 
var tempBurdenState = 0;
for(var i=0; i<4; i++) {
	tempBurdenState |= global.level.burdens[i] << i;
}
writeByte(tempBurdenState);

var roomCount = 1;

// room count 
writeUnsigned(roomCount);

// end header
var headerLength = 4 + 1 + 4;

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
	
	// the +8 is because of the 4 shorts. 
	// the collision offset is defined as the one after those 4 shorts
	
	// offset of details
	writeShort(startOffset + 8 + len(compressedCollision));
	
	// offset of floor 
	writeShort(startOffset + 8+ len(compressedCollision) + len(compressedDetails));
	
	// length of entities
	writeShort(len(entities));
	
	// offset of entities
	writeShort(startOffset + 8 + len(compressedCollision) + len(compressedDetails) + len(compressedFloor));
	
	//show_debug_message(string(startOffset + 8 + len(compressedCollision)));
	
	writeArray(compressedCollision);
	writeArray(compressedDetails);
	writeArray(compressedFloor);
	
	for(var j=0; j<len(entities); j++) {
		writeByte(entities[j][0])		
		writeByte(entities[j][1])		
		writeByte(entities[j][2])		
	}
	
}

//array_push(roomOffsets, offsetStart + len(


// set actual room offsets.
global.binOffset = headerLength;
for(var i=0; i<roomCount; i++) {
	writeShort(roomOffsets[i]);
}



var binf = file_bin_open(working_directory + "GBAStranger.sav", 1);

for(var i=0; i<len(global.outputBuffer); i++) {
	file_bin_write_byte(binf, global.outputBuffer[i]);	
}

file_bin_close(binf);

show_debug_message("gba save written successfully")
