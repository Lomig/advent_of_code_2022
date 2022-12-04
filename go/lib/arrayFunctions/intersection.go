package arrayFunctions

import "golang.org/x/exp/constraints"

func Intersection[T constraints.Ordered](arrays ...[]T) []T {
	elementStorage := make(map[T]*int)

	for _, array := range arrays {
		elementAlreadyPickedInArray := make(map[T]bool)

		for _, element := range array {
			if elementCount := elementStorage[element]; elementCount != nil {
				if elementAlreadyPickedInArray[element] == false {
					elementAlreadyPickedInArray[element] = true
					*elementCount++
				}
			} else {
				elementAlreadyPickedInArray[element] = true
				newElementCount := 1
				elementStorage[element] = &newElementCount
			}
		}
	}

	result := make([]T, 0)

	for element, elementCount := range elementStorage {
		if *elementCount >= len(arrays) {
			result = append(result, element)
		}
	}

	return result
}
