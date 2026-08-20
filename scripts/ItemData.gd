extends Resource

class_name ItemData

enum Type {ITEM, FOOD, TOOL, CLOTHING}

enum Rarity {COMMON, UNCOMMON, RARE, EPIC, LEGENDARY}


@export var name: String
@export_multiline var description : String

@export_category("Item Stats")
@export var basePrice : int
@export var maxStack : int
@export var type : Type
@export var rarity : Rarity

@export_category("Display")
@export var texture : Texture2D
