package day3

import (
	"aoc2022/lib/arrayFunctions"
	"unicode"
)

///////////////////////////////////////////////////////////////////////////////////
// Results                                                                       //
///////////////////////////////////////////////////////////////////////////////////

func result1(rucksacks []string) int {

	result := 0

	for _, rucksack := range rucksacks {
		backCompartment, frontCompartment := divideRucksack(rucksack)

		duplicatedItems := arrayFunctions.Intersection(
			[]rune(backCompartment),
			[]rune(frontCompartment))

		result += priorityFromItem(duplicatedItems[0])
	}

	return result

}

func result2(rucksacks []string) int {

	result := 0

	for i := 0; i < len(rucksacks)-2; i += 3 {
		duplicatedItems := arrayFunctions.Intersection(
			[]rune(rucksacks[i]),
			[]rune(rucksacks[i+1]),
			[]rune(rucksacks[i+2]))

		result += priorityFromItem(duplicatedItems[0])
	}

	return result
}

///////////////////////////////////////////////////////////////////////////////////
// Helper functions                                                              //
///////////////////////////////////////////////////////////////////////////////////

func divideRucksack(rucksack string) (string, string) {
	length := len(rucksack)

	return rucksack[:length/2], rucksack[length/2:]
}

func priorityFromItem(item rune) int {
	// a = 01, b = 02, ..., z = 26
	// A = 27, B = 28, ..., Z = 52

	if unicode.IsUpper(item) {
		return int(item) - int('A') + 27
	} else {
		return int(item) - int('a') + 1
	}
}
