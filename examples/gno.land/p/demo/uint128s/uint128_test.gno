package uint128

import (
	"std"

	"testing"
)

func TestFuncs(t *testing.T) {
	// Add overflow
	_a0 := New(1)
	_a1 := Max()
	println(_a0.Add(_a1))

	// Add64 overflow
	// _a0 := Max()
	// _a1 := uint64(1)
	// println(_a0.Add64(_a1))

	// Sub underflow
	// _a0 := New(2)
	// _a1 := New(3)
	// println(_a0.Sub(_a1))

	// Sub64 underflow
	// _a0 := New(2)
	// _a1 := uint64(3)
	// println(_a0.Sub64(_a1))
}