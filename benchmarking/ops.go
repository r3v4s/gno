package benchmarking

const initStackSize int = 64

var (
	measurementStack []*Measurement
	stackSize        int
)

func initStack() {
	measurementStack = make([]*Measurement, initStackSize)
}

func StartMeasurement(op byte) {
	if stackSize != 0 {
		measurementStack[stackSize-1].Pause()
	}

	if stackSize == len(measurementStack) {
		newStack := make([]*Measurement, stackSize*2)
		copy(newStack, measurementStack)
		measurementStack = newStack
	}

	measurementStack[stackSize] = startNewMeasurement(op)
	stackSize++
}

// StopMeasurement ends the current measurement and resumes the previous one
// if one exists. It accepts the number of bytes that were read/written to/from
// the store. This value is zero if the operation is not a read or write.
func StopMeasurement(size uint32) {
	if stackSize == 0 {
		return
	}

	stackSize--
	measurementStack[stackSize].End(size)

	if stackSize != 0 {
		measurementStack[stackSize].Resume()
	}
}
