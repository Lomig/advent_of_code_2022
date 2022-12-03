package day1

import (
	"log"
	"sort"
	"strconv"
	"strings"
)

///////////////////////////////////////////////////////////////////////////////////
// Results                                                                       //
///////////////////////////////////////////////////////////////////////////////////

func result1(elves []string) int {
	maxCalories := 0

	for _, elf := range elves {
		snacks := strings.Split(elf, "\n")
		currentCalories := sumCaloriesOf(snacks)

		if currentCalories > maxCalories {
			maxCalories = currentCalories
		}
	}

	return maxCalories
}

func result2(elves []string) int {
	calories := make([]int, 0, len(elves))

	for _, elf := range elves {
		snacks := strings.Split(elf, "\n")
		calories = append(calories, sumCaloriesOf(snacks))
	}

	sort.Ints(calories)

	lastIndex := len(calories) - 1

	return calories[lastIndex] + calories[lastIndex-1] + calories[lastIndex-2]
}

///////////////////////////////////////////////////////////////////////////////////
// Helper functions                                                              //
///////////////////////////////////////////////////////////////////////////////////

func sumCaloriesOf(snacks []string) int {
	result := 0

	for _, calories := range snacks {
		caloriesAsInt, err := strconv.Atoi(calories)
		if err != nil {
			log.Fatal(err)
		}

		result += caloriesAsInt
	}

	return result
}
