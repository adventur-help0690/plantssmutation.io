"""
plants.gd
For each plant, hold their traits, genes, age, etc.
For all plants, hold the list of all possible traits
and genes they can get.
"""
extends Node
class_name PlantDatabase

const DEFAULT_GENES: Dictionary = {
	"height": ["S", "S"],
	"color": ["G", "G"],
	"yield": ["Y", "Y"]
}
const DEFAULT_TRAITS: Dictionary = {
	"height": "short",
	"color": "green",
	"yield": 1
}

class PlantData extends RefCounted:
	var id: int
	var age: float = 0.0
	var hydration: float = 1.0
	var genes: Dictionary = {}
	var traits: Dictionary = {}
	var fruit_count: int = 0

	func _init(plant_id: int, plant_genes: Dictionary = {}, plant_traits: Dictionary = {}) -> void:
		id = plant_id
		genes = plant_genes.duplicate(true)
		traits = plant_traits.duplicate(true)

	func to_dictionary() -> Dictionary:
		return {
			"id": id,
			"age": age,
			"hydration": hydration,
			"genes": genes.duplicate(true),
			"traits": traits.duplicate(true),
			"fruit_count": fruit_count
		}

var plants: Array[PlantData] = []
var _next_id: int = 1

func create_plant(plant_genes: Dictionary = DEFAULT_GENES, plant_traits: Dictionary = DEFAULT_TRAITS) -> PlantData:
	var plant := PlantData.new(_next_id, plant_genes, plant_traits)
	_next_id += 1
	plants.append(plant)
	return plant

func remove_plant(plant: PlantData) -> void:
	plants.erase(plant)

func get_plant(plant_id: int) -> PlantData:
	for plant in plants:
		if plant.id == plant_id:
			return plant
	return null

func clear() -> void:
	plants.clear()
	_next_id = 1

func _ready() -> void:
	pass
