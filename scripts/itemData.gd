extends Resource
class_name ItemData

@export var crate_definition : CrateDefinition

@export var id : String
@export var display_name : String
@export_multiline var description : String

@export var icon : Texture2D

@export var max_stack : int = 99
@export var value : int = 0

@export var rarity : String = "common"

@export var tags : Array[String] = []

@export var metadata : Dictionary = {}
