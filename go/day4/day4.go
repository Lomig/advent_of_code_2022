package day4

import (
	"log"
	"strconv"
	"strings"
)

///////////////////////////////////////////////////////////////////////////////////
// Results                                                                       //
///////////////////////////////////////////////////////////////////////////////////

func result1(groups []string) int {

	result := 0

	for _, group := range groups {
		start1, end1, start2, end2 := splitGroupRanges(group)

		if isOneRangeIncludedInOther(start1, end1, start2, end2) {
			result++
		}
	}

	return result

}

func result2(groups []string) int {

	result := 0

	for _, group := range groups {
		start1, end1, start2, end2 := splitGroupRanges(group)

		if isOnRangeOverlappingOther(start1, end1, start2, end2) {
			result++
		}
	}

	return result
}

///////////////////////////////////////////////////////////////////////////////////
// Helper functions                                                              //
///////////////////////////////////////////////////////////////////////////////////

func splitGroupRanges(group string) (start1, end1, start2, end2 int) {

	elfRanges := strings.Split(group, ",")

	start1, end1 = splitRange(elfRanges[0])
	start2, end2 = splitRange(elfRanges[1])

	return
}

func splitRange(elfRange string) (int, int) {

	rangeBounds := strings.Split(elfRange, "-")

	leftBound, error1 := strconv.Atoi(rangeBounds[0])
	rightBound, error2 := strconv.Atoi(rangeBounds[1])

	if error1 != nil || error2 != nil {
		log.Fatal(error1, error2)
	}

	return leftBound, rightBound
}

func isOneRangeIncludedInOther(start1, end1, start2, end2 int) bool {
	return (start2-start1)*(end1-end2) >= 0
}

func isOnRangeOverlappingOther(start1, end1, start2, end2 int) bool {
	return (end2 >= end1 && start2 <= end1) || (end1 >= end2 && start1 <= end2)
}
