package uint128

// THIS IS UNSAFE ARITHMETIC 
// Allow Overflow, Underflow

import (
	"gno.land/p/demo/bits"
)


func (x Uint128) UnsafeAdd(y Uint128) (Uint128, uint64) {
	lo, carry := bits.Add64(x.Lo, y.Lo, 0)
	hi, carry := bits.Add64(x.Hi, y.Hi, carry)

	return Uint128{lo, hi}, carry
}

func (x Uint128) UnsafeAdd64(y uint64) Uint128 {
	lo, carry := bits.Add64(x.Lo, y, 0)
	return Uint128{
		Lo: lo,
		Hi: x.Hi + carry,
	}
}

func (x Uint128) UnsafeSub(y Uint128) (Uint128, uint64) {
	lo, borrow := bits.Sub64(x.Lo, y.Lo, 0)
	hi, borrow := bits.Sub64(x.Hi, y.Hi, borrow)

	return Uint128{lo, hi}, borrow
}

func (x Uint128) UnsafeMul(y Uint128) Uint128 {
	hi, lo := bits.Mul64(x.Lo, y.Lo)
	hi += x.Hi * y.Lo + x.Lo * y.Hi
	return Uint128{lo, hi}
}

func (x Uint128) UnsafeMul64(y uint64) Uint128 {
	hi, lo := bits.Mul64(x.Lo, y)
	return Uint128{
		Lo: lo,
		Hi: hi + x.Hi * y,
	}
}