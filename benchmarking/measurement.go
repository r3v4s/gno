package benchmarking

import (
	"time"
)

type Measurement struct {
	*timer
	opCode OpCode
}

func startNewMeasurement(opCode OpCode) *Measurement {
	return &Measurement{
		timer:  &timer{startTime: time.Now()},
		opCode: opCode,
	}
}

func (m *Measurement) Pause() {
	m.stop()
}

func (m *Measurement) Resume() {
	m.start()
}

func (m *Measurement) End(size uint32) {
	m.stop()
	Exporter.Export(m.opCode, m.elapsedTime, size)
}
