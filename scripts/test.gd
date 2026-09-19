"""
test.gd
Test the breeding of plants and the genetics system.
Act as inputs before UI is implemented.
"""

extends Node

func _ready():
	var farm = Farm.new()
	add_child(farm)
	
	var a = farm.plant_seed(
		{"height": ["S", "s"], "color": ["G", "g"], "yield": ["Y", "y"]},
		{}
	)
	
	var b = farm.plant_seed(
		{"height": ["S", "s"], "color": ["G", "g"], "yield": ["Y", "y"]},
		{}
	)
	
	# var count = {"SS": 0, "Ss": 0, "ss": 0}
	var count = {"GG": 0, "Gg": 0, "gg": 0}
	# var count = {"YY": 0, "Yy": 0, "yy": 0}
	
	for i in range(1000):
		var child = farm.breed_plants(a, b)
		# var g = child.genes["height"]
		var g = child.genes["color"]
		# var g = child.genes["yield"]
		
		g.sort()
		var key = "".join(g)

		# Normalize the key to ensure consistent ordering of alleles
		if key == "sS":
			key = "Ss"
		if key == "gG":
			key = "Gg"
		if key == "yY":
			key = "Yy"
			
		if count.has(key):
			count[key] += 1
			
	print(count)
