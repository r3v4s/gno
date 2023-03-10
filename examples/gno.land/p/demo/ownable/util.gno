package ownable

//////////////////////////////////////////////////
//
// INTERNAL
//
//////////////////////////////////////////////////

/// XXX use require in testing
func require(condition bool, message string) {
	if (!condition) {
		panic(message)
	}
}

func emit(event interface{}) {}