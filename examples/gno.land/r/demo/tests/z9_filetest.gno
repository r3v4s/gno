// PKGPATH: gno.land/r/set_prev_test
package set_prev_test

import (
	"std"

	"gno.land/r/demo/foo20"
	"gno.land/r/demo/users"
)

var caller std.Address

func init() {
	caller = std.GetOrigCaller()
	println(caller)
}

func normal_faucet() {
	foo20.Faucet()
	b := foo20.BalanceOf(a2u(caller))
	println(b)
}

func set_faucet() {
	std.TestSetPrevAddr(caller)

	foo20.Faucet()
	b := foo20.BalanceOf(a2u(caller))
	println(b)
}

func prev_realm_addr() {
	println(std.GetOrigCaller())
	println(std.PrevRealm())

	std.TestSetPrevRealm("gno.land/r/demo/set_prev_realm_to_this")
	println(std.GetOrigCaller())
	println(std.PrevRealm())

	std.TestSetPrevAddr("g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5")
	println(std.GetOrigCaller())
	println(std.PrevRealm())
}

func main() {
	normal_faucet()
	set_faucet()
	prev_realm_addr()
}

func a2u(addr std.Address) users.AddressOrName {
	return users.AddressOrName(addr)
}

// Output:
// g1wymu47drhr0kuq2098m792lytgtj2nyx77yrsm
// 0
// 10000000
// g1wymu47drhr0kuq2098m792lytgtj2nyx77yrsm
// struct{("g1wymu47drhr0kuq2098m792lytgtj2nyx77yrsm" std.Address),("" string)}
// g1wymu47drhr0kuq2098m792lytgtj2nyx77yrsm
// struct{("g1felpzysry9ac8qx2acm6ev7u94rme2uyqzjh9z" std.Address),("gno.land/r/demo/set_prev_realm_to_this" string)}
// g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5
// struct{("g1jg8mtutu9khhfwc4nxmuhcpftf0pajdhfvsqf5" std.Address),("" string)}
