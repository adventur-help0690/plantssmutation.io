"""
genetics.gd
Where the mutation of 2 plants happens.
Recive plants selected traits, current gene to
output the correct child plant
"""
extends Node
class_name PlantGenetics

const MUTATION_CHANCE: float = 0.05
var random := RandomNumberGenerator.new()

func _ready() -> void:
	random.randomize()

func get_alleles(genes: Dictionary, gene_name: String) -> Array:
	var alleles: Array = genes.get(gene_name, [])
	if alleles.is_empty():
		return ["", ""]
	if alleles.size() == 1:
		return [str(alleles[0]), str(alleles[0])]
	return [str(alleles[0]), str(alleles[1])]

func create_punnett_square(parent_a: PlantDatabase.PlantData, parent_b: PlantDatabase.PlantData, gene_name: String) -> Array:
	var alleles_a := get_alleles(parent_a.genes, gene_name)
	var alleles_b := get_alleles(parent_b.genes, gene_name)
	return [
		[alleles_a[0] + alleles_b[0], alleles_a[0] + alleles_b[1]],
		[alleles_a[1] + alleles_b[0], alleles_a[1] + alleles_b[1]]
	]

func breed(parent_a: PlantDatabase.PlantData, parent_b: PlantDatabase.PlantData) -> Dictionary:
	var child_genes: Dictionary = {}
	var child_traits: Dictionary = {}
	for gene_name in parent_a.genes.keys():
		var square := create_punnett_square(parent_a, parent_b, gene_name)
		var row := random.randi_range(0, square.size() - 1)
		var column := random.randi_range(0, square[row].size() - 1)
		var genotype: String = square[row][column]
		if random.randf() < MUTATION_CHANCE:
			genotype = _mutate_genotype(genotype)
		child_genes[gene_name] = [genotype.substr(0, 1), genotype.substr(1, 1)]
		child_traits[gene_name] = _express_trait(gene_name, genotype)
	return {"genes": child_genes, "traits": child_traits}

func _mutate_genotype(genotype: String) -> String:
	var allele := char(65 + random.randi_range(0, 3))
	return allele + genotype.substr(1, 1)

func _express_trait(gene_name: String, genotype: String):
	match gene_name:
		"height":
			return "tall" if genotype.contains("T") else "short"
		"color":
			return "purple" if genotype.contains("P") else "green"
		"yield":
			return 2 if genotype.contains("Y") else 1
		_:
			return genotype

func _process(delta: float) -> void:
	pass
