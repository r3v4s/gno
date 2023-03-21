package uint128

import (
	"errors"

	"gno.land/p/demo/bits"
)

const MaxUint64 = 1 <<64 - 1

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

// ///////////////////////////////////////////////////////////////////////////////
// /// arithmetic operators //////////////////////////////////////////////////////

// Add(x,y) returns x + y
// overflow acceptable
func Add(x, y Uint128) (Uint128) {
	lo, carry := bits.Add64(x.Lo, y.Lo, 0)
	hi, _ := bits.Add64(x.Hi, y.Hi, carry)

	return Uint128{lo, hi}
}

// x.Add(y) returns x + y
// panic on overflow
func (u Uint128) Add(v Uint128) Uint128 {
	lo, carry := bits.Add64(u.Lo, v.Lo, 0)
	hi, carry := bits.Add64(u.Hi, v.Hi, carry)
	if carry != 0 {
		panic("overflow")
	}

	return Uint128{lo, hi}
}

// x.Add64(y) returns x + y
// panic on overflow
func (u Uint128) Add64(v uint64) Uint128 {
	lo, c0 := bits.Add64(u.Lo, v, 0)
	if c0 != 0 {
		panic("overflow")
	}
	return Uint128{Lo: lo, Hi: u.Hi + c0}
}

// Sub(x,y) returns x - y
// underflow acceptable
func Sub(x, y Uint128) (Uint128) {
	lo, borrow := bits.Sub64(x.Lo, y.Lo, 0)
	hi, _ := bits.Sub64(x.Hi, y.Hi, borrow)
	
	return Uint128{lo, hi}
}

// x.Sub returns x - y
// panic on underflow
func (u Uint128) Sub(v Uint128) Uint128 {
	lo, borrow := bits.Sub64(u.Lo, v.Lo, 0)
	hi, borrow := bits.Sub64(u.Hi, v.Hi, borrow)
	if borrow != 0 {
		panic("underflow")
	}

	return Uint128{lo, hi}
}

// x.Sub64(y) returns x - y
// panic on underflow
func (u Uint128) Sub64(v uint64) Uint128 {
	lo, borrow := bits.Sub64(u.Lo, v, 0)
	hi, borrow := bits.Sub64(u.Hi, 0, borrow)
	if borrow != 0 {
		panic("underflow")
	}

	return Uint128{lo, hi}
}

// Mul(x,y) returns x * y
// overflow acceptable
func Mul(x, y Uint128) (Uint128) {
	hi, lo := bits.Mul64(x.Lo, y.Lo)
	hi += x.Hi*y.Lo + x.Lo*y.Hi
	return Uint128{lo, hi}
}

// x.Mul(y) returns x * y
// panic on overflow
func (u Uint128) Mul(v Uint128) Uint128 {
	hi, lo := bits.Mul64(u.Lo, v.Lo)
	p0, p1 := bits.Mul64(u.Hi, v.Lo)
	p2, p3 := bits.Mul64(u.Lo, v.Hi)
	hi, c0 := bits.Add64(hi, p1, 0)
	hi, c1 := bits.Add64(hi, p3, c0)
	if (u.Hi != 0 && v.Hi != 0) || p0 != 0 || p2 != 0 || c1 != 0 {
		panic("overflow")
	}
	return Uint128{lo, hi}
}

// x.Mul64(y) returns x * y
// panic on overflow
func (u Uint128) Mul64(v uint64) Uint128 {
	hi, lo := bits.Mul64(u.Lo, v)
	p0, p1 := bits.Mul64(u.Hi, v)
	hi, c0 := bits.Add64(hi, p1, 0)
	if p0 != 0 || c0 != 0 {
		panic("overflow")
	}

	return Uint128{lo, hi}
}

// Div(x,y) returns x / y
func Div(x, y Uint128) (Uint128) {
	q, _ := x.QuoRem(y)
	return q
}


// x.Div(y) returns u / v
func (u Uint128) Div(v Uint128) Uint128 {
	q, _ := u.QuoRem(v)
	return q
}

// x.Div64(y) returns u / v
func (u Uint128) Div64(v uint64) Uint128 {
	q, _ := u.QuoRem64(v)
	return q
}

// Mod(x,y) returns x % y
func Mod(x, y Uint128) (Uint128) {
	_, r := x.QuoRem(y)
	return r
}

// x.Mod(y) returns u % v
func (u Uint128) Mod(v Uint128) Uint128 {
	_, r := u.QuoRem(v)
	return r
}

// x.Mod64(y) returns u % v
func (u Uint128) Mod64(v uint64) uint64 {
	_, r := u.QuoRem64(v)
	return r
}

// QuoRem returns quotient (u/v) and remainder (u%v) of two 128-bit values.
func (u Uint128) QuoRem(v Uint128) (Uint128, Uint128) {
	if v.Hi == 0 && v.Lo == 0 {
		panic("division by zero")
	}

	if v.Hi == 0 {
		q, r := u.QuoRem64(v.Lo)
		return q, From64(r)
	}

	// generate a "trial quotient" guaranteed to be
	// within 1 of the actual quotient, then adjust.
	n := uint(bits.LeadingZeros64(v.Hi))
	u1, v1 := u.Rsh(1), v.Lsh(n)
	tq, _ := bits.Div64(u1.Hi, u1.Lo, v1.Hi)
	tq >>= 63 - n
	if tq != 0 {
		tq--
	}

	// calculate remainder using trial quotient, then
	// adjust if remainder is greater than divisor
	q, r := From64(tq), u.Sub(v.Mul64(tq))
	if r.Cmp(v) >= 0 {
		q = q.Add64(1)
		r = r.Sub(v)
	}

	return q, r
}

// QuoRem64 returns quotient (u/v) and remainder (u%v) of 128-bit and 64-bit values.
func (u Uint128) QuoRem64(v uint64) (Uint128, uint64) {
	if u.Hi < v {
		lo, r := bits.Div64(u.Hi, u.Lo, v)
		return Uint128{Lo: lo}, r
	}

	hi, r := bits.Div64(0, u.Hi, v)
	lo, r := bits.Div64(r, u.Lo, v)
	return Uint128{Lo: lo, Hi: hi}, r
}


///////////////////////////////////////////////////////////////////////////////
/// shift operators ///////////////////////////////////////////////////////////

// Lsh returns left shift (u<<n).
func (u Uint128) Lsh(n uint) Uint128 {
	if n > 64 {
		return Uint128{
			// Lo: 0,
			Hi: u.Lo << (n - 64),
		}
	}

	return Uint128{
		Lo: u.Lo << n,
		Hi: u.Hi<<n | u.Lo>>(64-n),
	}
}

// Rsh returns right shift (u>>n).
func (u Uint128) Rsh(n uint) Uint128 {
	if n > 64 {
		return Uint128{
			Lo: u.Hi >> (n - 64),
			// Hi: 0,
		}
	}

	return Uint128{
		Lo: u.Lo>>n | u.Hi<<(64-n),
		Hi: u.Hi >> n,
	}
}

// RotateLeft returns the value of u rotated left by (k mod 128) bits.
func (u Uint128) RotateLeft(k int) Uint128 {
	n := uint(k) & 127

	if n < 64 {
		if n == 0 {
			// no shift
			return u
		}

		// shift by [1..63]
		return Uint128{
			Lo: u.Lo<<n | u.Hi>>(64-n),
			Hi: u.Hi<<n | u.Lo>>(64-n),
		}
	}

	n -= 64
	if n == 0 {
		// shift by 64
		return Uint128{
			Lo: u.Hi,
			Hi: u.Lo,
		}
	}

	// shift by [65..127]
	return Uint128{
		Lo: u.Lo>>(64-n) | u.Hi<<n,
		Hi: u.Hi>>(64-n) | u.Lo<<n,
	}
}

// RotateRight returns the value of u rotated left by (k mod 128) bits.
func (u Uint128) RotateRight(k int) Uint128 {
	return u.RotateLeft(-k)
}

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