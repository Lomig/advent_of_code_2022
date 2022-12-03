package day2

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
	content := inputReader.InputAsRawString("day2")
	moves := strings.Split(content, "\n")

	result1 := strconv.Itoa(result1(moves))
	result2 := strconv.Itoa(result2(moves))

	display.ShowDailyResult(2, result1, result2)
}
