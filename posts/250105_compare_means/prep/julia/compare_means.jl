# Librairies

using PalmerPenguins # dataset
using DataFrames 
using StatsPlots
using HypothesisTests
using Distributions


# Chargement des données

table = PalmerPenguins.load()

penguins = DataFrame(table)

describe(penguins)

dropmissing!(penguins) #remove rows with nas

# Graph comparaison taille

@df penguins boxplot(:sex, :bill_length_mm)

# Testing normality

## Graph

@df penguins density(:bill_length_mm, group = :sex)

## Test


OneSampleADTest(penguins.bill_length_mm, Normal())

gp_penguins = groupby(penguins, :sex, sort = true)  

res = combine(gp_penguins, :bill_length_mm => (bill_length_mm -> OneSampleADTest(bill_length_mm, Normal())) => :ADTest)

println(res[1,:])

# Compare means

EqualVarianceTTest(penguins[penguins.sex .== "male",:bill_length_mm], penguins[penguins.sex .== "female",:bill_length_mm])
