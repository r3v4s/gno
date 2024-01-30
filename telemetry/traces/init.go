package traces

import (
	"context"
	"log"
	"os"
	"strings"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
	"google.golang.org/grpc/credentials"

	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
)

var (
	serviceName  = os.Getenv("SERVICE_NAME")
	collectorURL = os.Getenv("OTEL_EXPORTER_OTLP_ENDPOINT")
	insecure     = os.Getenv("INSECURE_MODE")

	// these generate lots of data and are used for gas and operation menchmark,
	// not for real time monitoring
	traceOp    = os.Getenv("TRACE_OP")    // trace vm op
	traceStore = os.Getenv("TRACE_STORE") // trace store access
	// TODO: trace mem alloc distribution, it has nothing to do with execution time though.
	// Yet to figure out the right way for allocation optimization between different data types.
)

type writer struct {
	file *os.File
}

func (w writer) Write(p []byte) (n int, err error) {
	n, err = w.file.Write(p)
	w.file.Sync()
	return
}

func Init() func(context.Context) error {
	var secureOption otlptracegrpc.Option

	if strings.ToLower(insecure) == "false" || insecure == "0" || strings.ToLower(insecure) == "f" {
		secureOption = otlptracegrpc.WithTLSCredentials(credentials.NewClientTLSFromCert(nil, ""))
	} else {
		secureOption = otlptracegrpc.WithInsecure()
	}

	exporter, err := otlptrace.New(
		context.Background(),
		otlptracegrpc.NewClient(
			secureOption,
			otlptracegrpc.WithEndpoint(collectorURL),
		),
	)
	// w, err := os.Create("trace.out")
	// if err != nil {
	// 	panic("couldn't open file")
	// }
	// ww := writer{file: w}
	// opt := stdouttrace.WithWriter(ww)
	// exporter, err := stdouttrace.New(opt)
	if err != nil {
		log.Fatalf("Failed to create exporter: %v", err)
	}
	resources, err := resource.New(
		context.Background(),
		resource.WithAttributes(
			attribute.String("service.name", serviceName),
			attribute.String("library.language", "go"),
		),
	)
	if err != nil {
		log.Fatalf("Could not set resources: %v", err)
	}

	otel.SetTracerProvider(
		sdktrace.NewTracerProvider(
			sdktrace.WithSampler(sdktrace.AlwaysSample()),
			sdktrace.WithBatcher(exporter),
			sdktrace.WithResource(resources),
		),
	)

	return exporter.Shutdown
}

func IsTraceOp() bool {
	// default is false
	if strings.ToLower(traceOp) == "true" {
		return true
	}
	return false
}

func IsTraceStore() bool {
	// default is false
	if strings.ToLower(traceStore) == "true" {
		return true
	}
	return false
}
