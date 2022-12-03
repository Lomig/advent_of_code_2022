package inputReader

import (
	"log"
	"os"
)

func ReadInputFile(path string) []byte {
	content, err := os.ReadFile(path + "/input.txt")
	if err != nil {
		log.Fatal(err)
	}

	return content
}

func InputAsRawString(path string) string {
	return string(ReadInputFile(path))
}
