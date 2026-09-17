"""
farm.gd
Handle plants growth, dehydration, fruits, ... connect with plants.gd
"""
extends Node
class_name Farm

const GROWTH_PER_SECOND: float = 1.0
const DEHYDRATION_PER_SECOND: float = 0.02
const MATURE_AGE: float = 10.0
const MAX_HYDRATION: float = 1.0

var plant_database: PlantDatabase
var genetics: PlantGenetics

func _ready() -> void:
	plant_database = PlantDatabase.new()
	genetics = PlantGenetics.new()
	add_child(plant_database)
	add_child(genetics)

func _process(delta: float) -> void:
	advance_time(delta)

func plant_seed(genes: Dictionary = PlantDatabase.DEFAULT_GENES, traits: Dictionary = PlantDatabase.DEFAULT_TRAITS) -> PlantDatabase.PlantData:
	return plant_database.create_plant(genes, traits)

func breed_plants(parent_a: PlantDatabase.PlantData, parent_b: PlantDatabase.PlantData) -> PlantDatabase.PlantData:
	var child_data := genetics.breed(parent_a, parent_b)
	return plant_database.create_plant(child_data.genes, child_data.traits)

func advance_time(seconds: float) -> void:
	if seconds <= 0.0:
		return
	for plant in plant_database.plants:
		plant.age += seconds * GROWTH_PER_SECOND
		plant.hydration = maxf(0.0, plant.hydration - seconds * DEHYDRATION_PER_SECOND)

func water_plant(plant: PlantDatabase.PlantData, amount: float = 1.0) -> void:
	plant.hydration = minf(MAX_HYDRATION, plant.hydration + maxf(0.0, amount))

func harvest(plant: PlantDatabase.PlantData) -> int:
	if plant.age < MATURE_AGE or plant.hydration <= 0.0:
		return 0
	var amount: int = int(plant.traits.get("yield", 1))
	plant.fruit_count += amount
	plant.age = 0.0
	return amount
