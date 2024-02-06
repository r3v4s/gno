package benchmarking

import (
	"time"
)

type measurement struct {
	*timer
	opCode OpCode
}

func startNewMeasurement(opCode OpCode) *measurement {
	return &measurement{
		timer:  &timer{startTime: time.Now()},
		opCode: opCode,
	}
}

func (m *measurement) pause() {
	m.stop()
}

func (m *measurement) resume() {
	m.start()
}

func (m *measurement) end(size uint32) {
	m.stop()
	fileWriter.export(m.opCode, m.elapsedTime, size)
}
