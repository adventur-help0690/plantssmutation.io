"""
test.gd
Test the breeding of plants and the genetics system.
Act as inputs before UI is implemented.
"""

extends Node

var plant_database := PlantDatabase.new()
var genetics := PlantGenetics.new()

func _ready():
	var farm = Farm.new()
	add_child(farm)
	var p = farm.plant_seed()

	farm.advance_time(10.0)

	print(p.age) # 10
	print(p.hydration) # 0.8

	farm.advance_time(50.0)
	print(p.hydration) # 0.0

	farm.water_plant(p)
	var fruits = farm.harvest(p)
	print(fruits)

	# Print the result fruit traits
	print(p.traits)
