package uint128

// THIS IS SAFE ARITHMETIC
// Prevent Overflow, Underflow

import (
	bits "gno.land/p/demo/bits"
)

func (x Uint128) Add(y Uint128) Uint128 {
	sum, carry := x.UnsafeAdd(y)
	if carry != 0 {
		panic("overflow")
	}

	return sum
}

func (x Uint128) Sub(y Uint128) Uint128 {
	diff, borrow := x.UnsafeSub(y)
	if borrow != 0 {
		panic("underflow")
	}

	return diff
}

func (x Uint128) Mul(y Uint128) Uint128 {
	hi, lo := bits.Mul64(x.Lo, y.Lo)
	p0, p1 := bits.Mul64(x.Hi, y.Lo)
	p2, p3 := bits.Mul64(x.Lo, y.Hi)
	hi, c0 := bits.Add64(hi, p1, 0)
	hi, c1 := bits.Add64(hi, p3, c0)
	if (x.Hi != 0 && y.Hi != 0) || p0 != 0 || p2 != 0 || c1 != 0 {
		panic("overflow")
	}
	return Uint128{lo, hi}
}

func (x Uint128) QuoRem(y Uint128) (Uint128, Uint128) {
	if x.IsZero() {
		return Zero(), Zero()
	}

	if y.IsZero() {
		panic("division by zero")
	}

	if y.Hi == 0 {
		q, r := x.QuoRem64(y.Lo)
		return q, From64(r)
	}

	n := uint(bits.LeadingZeros64(y.Hi))
	x1, v1 := x.Rsh(1), y.Rsh(1)
	tq, _ := bits.Div64(x1.Hi, x1.Lo, v1.Hi)
	tq >>= 63 - n
	if tq != 0 {
		tq--
	}

	q, r := From64(tq), x.Sub(y.UnsafeMul64(tq))
	if r.Cmp(y) >= 0 {
		q, r = q.UnsafeAdd64(1), r.Sub(y)
	}

	return q, r
}

func (x Uint128) QuoRem64(y uint64) (Uint128, uint64) {
	if x.Hi < y {
		lo, r := bits.Div64(x.Hi, x.Lo, y)
		return Uint128{Lo: lo}, r
	}

	hi, r := bits.Div64(0, x.Hi, y)
	lo, r := bits.Div64(r, x.Lo, y)
	return Uint128{Lo: lo, Hi: hi}, r
}


func (x Uint128) Div(y Uint128) Uint128 {
	q, _ := x.QuoRem(y)
	return q
}

func (x Uint128) Mod(y Uint128) Uint128 {
	_, r := x.QuoRem(y)
	return r
}