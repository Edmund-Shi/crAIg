require("NEAT/config")

--Take a species and clear out the weak, return how many died
function survivalOfTheFittest(species, totalAdjustedFitness)
	--Sort them by fitness (maybe we should have calculated fitness beforehand?)
	table.sort(species.genomes, function(a,b)
		return (a.fitness > b.fitness)
	end)
	local theWeakCount = math.floor(species.sumAdjustedFitness / totalAdjustedFitness) - 1
	print("\tSpecies ",species.id," generates ",species.sumAdjustedFitness,"/",totalAdjustedFitness, " fitness with ",#species.genomes," genomes")

	local thoseWhoSurvived = #species.genomes - theWeakCount

	--Check for fitness over time (if it's been 20 generations without change, only keep top 2)

	--Remember how many genomes are supposed to be 
	species.populationSize = #species.genomes

	--Allow the species some children based on how successful it is
	species.populationSize = species.populationSize + math.floor((species.sumAdjustedFitness / totalAdjustedFitness)*BABIES_PER_GENERATION)


	--Remove the necessary species
	while #species.genomes > thoseWhoSurvived do
		table.remove(species.genomes)
	end

	print("\tGenomes left in species ",species.id,":",#species.genomes)
end