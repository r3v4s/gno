package uint256

import (
	"testing"
	uint128 "gno.land/p/demo/uint128"
)

func TestFuncs(t *testing.T) {
	// println(Zero)
	// println(One)
	// println(Max)

	// println(Zero.IsZero())
	// println(One.IsZero())

	// println(Zero.Equals(Zero))
	// println(Zero.Equals128(uint128.Zero))
	// println(Zero.Equals64(0))

	// println(Zero.Cmp(Zero)) 
	// println(Zero.Cmp(One))
	// println(One.Cmp(Zero))

	// println(Zero.Cmp128(uint128.Zero)) 
	// println(Zero.Cmp128(uint128.One))
	// println(One.Cmp128(uint128.Zero))

	// println(Zero.Cmp64(uint64(0))) 
	// println(Zero.Cmp64(uint64(1)))
	// println(One.Cmp64(uint64(0)))

	println(One.Add(One))


}