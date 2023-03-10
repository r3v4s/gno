package testutils

// UTILs
func require(condition bool, msg ...string) {
	if !condition {
		if msg == nil {
			panic("PANIC by require")
		} else {
			panic(msg)
		}
	}
}
