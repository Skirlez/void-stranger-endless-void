{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_ev_pack_node_judgment",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":10,"eventType":7,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_ev_button","path":"objects/obj_ev_button/obj_ev_button.yy",},"propertyId":{"name":"base_scale_x","path":"objects/obj_ev_button/obj_ev_button.yy",},"value":"0",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_ev_button","path":"objects/obj_ev_button/obj_ev_button.yy",},"propertyId":{"name":"base_scale_y","path":"objects/obj_ev_button/obj_ev_button.yy",},"value":"0",},
  ],
  "parent": {
    "name": "Objects",
    "path": "folders/Objects.yy",
  },
  "parentObjectId": {
    "name": "obj_ev_button",
    "path": "objects/obj_ev_button/obj_ev_button.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"node_inst","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"noone","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"judgment_type","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"judgment_types.destroy_node","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"target_x","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"x","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"target_y","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"y","varType":0,},
  ],
  "solid": false,
  "spriteId": {
    "name": "spr_ev_delete_level",
    "path": "sprites/spr_ev_delete_level/spr_ev_delete_level.yy",
  },
  "spriteMaskId": null,
  "visible": true,
}