package day2

///////////////////////////////////////////////////////////////////////////////////
// Results                                                                       //
///////////////////////////////////////////////////////////////////////////////////

func result1(moves []string) int {

	possibleScores := map[string]int{
		"A X": 1 + 3, // Rock     against Rock     -> Draw
		"A Y": 2 + 6, // Paper    against Rock     -> Win
		"A Z": 3 + 0, // Scissors against Rock     -> Loss
		"B X": 1 + 0, // Rock     against Paper    -> Loss
		"B Y": 2 + 3, // Paper    against Paper    -> Draw
		"B Z": 3 + 6, // Scissors against Paper    -> Win
		"C X": 1 + 6, // Rock     against Scissors -> Win
		"C Y": 2 + 0, // Paper    against Scissors -> Loss
		"C Z": 3 + 3, // Scissors against Scissors -> Draw
	}

	return computeScore(moves, possibleScores)
}

func result2(moves []string) int {

	possibleScores := map[string]int{
		"A X": 0 + 3, // Loss against Rock     -> Scissors
		"A Y": 3 + 1, // Draw against Rock     -> Rock
		"A Z": 6 + 2, // Win  against Rock     -> Paper
		"B X": 0 + 1, // Loss against Paper    -> Rock
		"B Y": 3 + 2, // Draw against Paper    -> Paper
		"B Z": 6 + 3, // Win  against Paper    -> Scissors
		"C X": 0 + 2, // Loss against Scissors -> Paper
		"C Y": 3 + 3, // Draw against Scissors -> Scissors
		"C Z": 6 + 1, // Win  against Scissors -> Rock
	}

	return computeScore(moves, possibleScores)
}

///////////////////////////////////////////////////////////////////////////////////
// Helper functions                                                              //
///////////////////////////////////////////////////////////////////////////////////

func computeScore(moves []string, possibleScores map[string]int) int {

	totalScore := 0

	for _, move := range moves {
		totalScore += possibleScores[move]
	}

	return totalScore
}
