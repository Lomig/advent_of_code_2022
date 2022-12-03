package display

import "fmt"

func ShowDailyResult(dayNumber int, result1 string, result2 string) {
	fmt.Printf("Day %d - Result 1: "+result1+"\n", dayNumber)
	fmt.Printf("Day %d - Result 2: "+result2+"\n", dayNumber)
}
