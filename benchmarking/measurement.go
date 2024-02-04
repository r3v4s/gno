package benchmarking

import (
	"time"
)

type Measurement struct {
	*timer
	Op byte
}

func StartNewMeasurement(op byte) *Measurement {
	return &Measurement{
		timer: &timer{startTime: time.Now()},
		Op:    op,
	}
}

func (m *Measurement) Pause() {
	m.stop()
}

func (m *Measurement) Resume() {
	m.start()
}

func (m *Measurement) End() {
	m.stop()
	Exporter.Export(m.Op, m.elapsedTime)
}
