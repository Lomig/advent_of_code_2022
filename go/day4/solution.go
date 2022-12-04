package day4

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
	content := inputReader.InputAsRawString("day4")
	groups := strings.Split(content, "\n")

	result1 := strconv.Itoa(result1(groups))
	result2 := strconv.Itoa(result2(groups))

	display.ShowDailyResult(4, result1, result2)
}
