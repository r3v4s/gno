package mtimestamp

import (
	"time"
	"std"
	"testing"
)


func TestSkipDuration(t *testing.T) {
	// Duration 3hr 2min 1sec
	myDur := time.Second * 1
	myDur += time.Minute * 2
	myDur += time.Hour * 3

	start := time.Now()
	std.TestSkipTimestamps(myDur)
	end := time.Now()

	if end.Sub(start) != myDur {
		t.Errorf("time diff between start and end should be equal to myDur %v), but got %v", myDur, end.Sub(start))
	}
}