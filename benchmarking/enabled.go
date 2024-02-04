package benchmarking

var enabled bool

func Enabled() bool {
	return enabled
}

func Init(filepath string) {
	enabled = true
	initExporter(filepath)
}
