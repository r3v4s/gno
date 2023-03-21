package uint128

import (
	"gno.land/p/demo/bits"
)

///////////////////////////////////////////////////////////////////////////////
/// bit counting //////////////////////////////////////////////////////////////

// BitLen returns the minimum number of bits required to represent 128-bit value.
// The result is 0 for u == 0.
func (u Uint128) BitLen() int {
	if u.Hi != 0 {
		return 64 + bits.Len64(u.Hi)
	}
	return bits.Len64(u.Lo)
}

// LeadingZeros returns the number of leading zero bits.
// The result is 128 for u == 0.
func (u Uint128) LeadingZeros() int {
	if u.Hi != 0 {
		return bits.LeadingZeros64(u.Hi)
	}
	return 64 + bits.LeadingZeros64(u.Lo)
}

// TrailingZeros returns the number of trailing zero bits.
// The result is 128 for u == 0.
func (u Uint128) TrailingZeros() int {
	if u.Lo != 0 {
		return bits.TrailingZeros64(u.Lo)
	}
	return 64 + bits.TrailingZeros64(u.Hi)
}

// OnesCount returns the number of one bits ("population count").
func (u Uint128) OnesCount() int {
	return bits.OnesCount64(u.Lo) +
		bits.OnesCount64(u.Hi)
}

// Reverse returns the value with bits in reversed order.
func (u Uint128) Reverse() Uint128 {
	return Uint128{
		Lo: bits.Reverse64(u.Hi),
		Hi: bits.Reverse64(u.Lo),
	}
}

// ReverseBytes returns the value with bytes in reversed order.
func (u Uint128) ReverseBytes() Uint128 {
	return Uint128{
		Lo: bits.ReverseBytes64(u.Hi),
		Hi: bits.ReverseBytes64(u.Lo),
	}
}