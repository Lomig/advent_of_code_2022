package day3

import (
	"aoc2022/lib/display"
	"aoc2022/lib/inputReader"
	"strconv"
	"strings"
)

///////////////////////////////////////////////////////////////////////////////////
// Solution                                                                      //
///////////////////////////////////////////////////////////////////////////////////

func Solution() {
	content := inputReader.InputAsRawString("day3")
	rucksacks := strings.Split(content, "\n")

	result1 := strconv.Itoa(result1(rucksacks))
	result2 := strconv.Itoa(result2(rucksacks))

	display.ShowDailyResult(3, result1, result2)
}
