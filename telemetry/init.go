package telemetry

// Inspired by the example here:
// https://github.com/open-telemetry/opentelemetry-go/blob/main/example/prometheus/main.go

import (
	"context"

	"github.com/gnolang/gno/telemetry/traces"
)

var enabled bool

func IsEnabled() bool {
	return enabled
}

func Init(ctx context.Context) error {
	enabled = true
	// Tracing initialization.
	_ = traces.Init()

	return nil
}
