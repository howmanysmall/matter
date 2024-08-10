--!optimize 2
--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JestGlobals = require(ReplicatedStorage.JestGlobals)

local archetype = require(script.Parent.Parent.archetype)
local component = require(script.Parent.Parent).component

local describe = JestGlobals.describe
local expect = JestGlobals.expect
local it = JestGlobals.it

describe("archetype", function()
	it("should report same sets as same archetype", function()
		local a = component()
		local b = component()
		expect(archetype.archetypeOf(a, b)).toBe(archetype.archetypeOf(b, a))
	end)
	it("should identify compatible archetypes", function()
		local a = component()
		local b = component()
		local c = component()

		local archetypeA = archetype.archetypeOf(a, b, c)
		local archetypeB = archetype.archetypeOf(a, b)
		local archetypeC = archetype.archetypeOf(b, c)

		expect(archetype.areArchetypesCompatible(archetypeA, archetypeB)).toBe(false)
		expect(archetype.areArchetypesCompatible(archetypeB, archetypeA)).toBe(true)

		expect(archetype.areArchetypesCompatible(archetypeC, archetypeA)).toBe(true)
		expect(archetype.areArchetypesCompatible(archetypeB, archetypeC)).toBe(false)
	end)
	it("should identify compatible archetypes with negations", function()
		local a = component()
		local b = component()
		local c = component()

		local archetypeAB = archetype.archetypeOf(a, b)
		local negativeArchetypeBC = archetype.negateArchetypeOf(b, c)

		expect(archetype.areArchetypesCompatible(negativeArchetypeBC, archetypeAB)).toBe(true)
	end)
end)

return false
