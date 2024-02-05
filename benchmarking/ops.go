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

func StopMeasurement() {
	if stackSize == 0 {
		return
	}

	stackSize--
	measurementStack[stackSize].End()

	if stackSize != 0 {
		measurementStack[stackSize].Resume()
	}
}
