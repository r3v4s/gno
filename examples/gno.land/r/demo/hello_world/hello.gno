// Package hello_world demonstrates the usage of the Render() function.
// Render() can be called via the vm/qrender ABCI query off-chain to
// retrieve realm state or any other custom data defined by the realm
// developer. The vm/qrender query allows for additional data to be
// passed in with the call, which can be utilized as the path argument
// to the Render() function. This allows developers to create different
// "renders" of their realms depending on the data which is passed in,
// such as pagination, admin dashboards, and more.
package hello_world

func Render(path string) string {
	if path == "" {
		return "# Hello, 世界！"
	}

	return "# Hello, " + path + "!"
}
