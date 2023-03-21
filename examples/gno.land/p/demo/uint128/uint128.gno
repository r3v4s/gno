package uint128

import (
	"errors"

	"gno.land/p/demo/bits"
)

const MaxUint64 = 1 << 64 - 1 // 18446744073709551615

// Note, Zero and Max are functions just to make read-only values.
// We cannot define constants for structures, and global variables
// are unacceptable because it will be possible to change them.

// Zero is the lowest possible Uint128 value.
func Zero() Uint128 {
	return From64(0)
}

// One is the lowest non-zero Uint128 value.
func One() Uint128 {
	return From64(1)
}

// Max is the largest possible Uint128 value.
func Max() Uint128 {
	return Uint128{
		Lo: MaxUint64,
		Hi: MaxUint64,
	}
}

// Uint128 is an unsigned 128-bit number.
// All methods are immutable, works just like standard uint64.
type Uint128 struct {
	Lo uint64 // lower 64-bit half
	Hi uint64 // upper 64-bit half
}

// Note, there in no New(lo, hi) just not to confuse
// which half goes first: lower or upper.
// Use structure initialization Uint128{Lo: ..., Hi: ...} instead.

// From64 converts 64-bit value v to a Uint128 value.
// Upper 64-bit half will be zero.
func From64(v uint64) Uint128 {
	return Uint128{Lo: v}
}

// IsZero returns true if stored 128-bit value is zero.
func (u Uint128) IsZero() bool {
	return (u.Lo == 0) && (u.Hi == 0)
}

// Equals returns true if two 128-bit values are equal.
// Uint128 values can be compared directly with == operator
// but use of the Equals method is preferred for consistency.
func (u Uint128) Equals(v Uint128) bool {
	return (u.Lo == v.Lo) && (u.Hi == v.Hi)
}

// Equals64 returns true if 128-bit value equals to a 64-bit value.
func (u Uint128) Equals64(v uint64) bool {
	return (u.Lo == v) && (u.Hi == 0)
}

// Cmp compares two 128-bit values and returns:
//
//	-1 if u <  v
//	 0 if u == v
//	+1 if u >  v
func (u Uint128) Cmp(v Uint128) int {
	switch {
	case u.Hi > v.Hi:
		return +1 // u > v
	case u.Hi < v.Hi:
		return -1 // u < v
	case u.Lo > v.Lo:
		return +1 // u > v
	case u.Lo < v.Lo:
		return -1 // u < v
	}
	return 0 // u == v
}

// Cmp64 compares 128-bit and 64-bit values and returns:
//
//	-1 if u <  v
//	 0 if u == v
//	+1 if u >  v
func (u Uint128) Cmp64(v uint64) int {
	switch {
	case u.Hi != 0:
		return +1 // u > v
	case u.Lo > v:
		return +1 // u > v
	case u.Lo < v:
		return -1 // u < v
	}
	return 0 // u == v
}

///////////////////////////////////////////////////////////////////////////////
/// logical operators /////////////////////////////////////////////////////////

// Not returns logical NOT (^u) of 128-bit value.
func (u Uint128) Not() Uint128 {
	return Uint128{
		Lo: ^u.Lo,
		Hi: ^u.Hi,
	}
}

// AndNot returns logical AND NOT (u&^v) of two 128-bit values.
func (u Uint128) AndNot(v Uint128) Uint128 {
	return Uint128{
		Lo: u.Lo & ^v.Lo,
		Hi: u.Hi & ^v.Hi,
	}
}

// AndNot64 returns logical AND NOT (u&v) of 128-bit and 64-bit values.
func (u Uint128) AndNot64(v uint64) Uint128 {
	return Uint128{
		Lo: u.Lo & ^v,
		Hi: u.Hi, // ^0 == ff..ff
	}
}

// And returns logical AND (u&v) of two 128-bit values.
func (u Uint128) And(v Uint128) Uint128 {
	return Uint128{
		Lo: u.Lo & v.Lo,
		Hi: u.Hi & v.Hi,
	}
}

// And64 returns logical AND (u&v) of 128-bit and 64-bit values.
func (u Uint128) And64(v uint64) Uint128 {
	return Uint128{
		Lo: u.Lo & v,
		Hi: 0,
	}
}

// Or returns logical OR (u|v) of two 128-bit values.
func (u Uint128) Or(v Uint128) Uint128 {
	return Uint128{
		Lo: u.Lo | v.Lo,
		Hi: u.Hi | v.Hi,
	}
}

// Or64 returns logical OR (u|v) of 128-bit and 64-bit values.
func (u Uint128) Or64(v uint64) Uint128 {
	return Uint128{
		Lo: u.Lo | v,
		Hi: u.Hi,
	}
}

// Xor returns logical XOR (u^v) of two 128-bit values.
func (u Uint128) Xor(v Uint128) Uint128 {
	return Uint128{
		Lo: u.Lo ^ v.Lo,
		Hi: u.Hi ^ v.Hi,
	}
}

// Xor64 returns logical XOR (u^v) of 128-bit and 64-bit values.
func (u Uint128) Xor64(v uint64) Uint128 {
	return Uint128{
		Lo: u.Lo ^ v,
		Hi: u.Hi,
	}
}
