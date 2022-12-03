package day1

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
	content := inputReader.InputAsRawString("day1")
	elves := strings.Split(content, "\n\n")

	result1 := strconv.Itoa(result1(elves))
	result2 := strconv.Itoa(result2(elves))

	display.ShowDailyResult(1, result1, result2)
}
