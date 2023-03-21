package uint256

import (
	bits "gno.land/p/demo/bits"
	uint128 "gno.land/p/demo/uint128"
)

// const MaxUint64 = 1 << 64 - 1 // 18446744073709551615

type Uint256 struct {
	Lo, Hi uint128.Uint128
}

var (
	Zero = Uint256{}
	One = Uint256{uint128.One, uint128.Zero}
	Max = Uint256{uint128.Max, uint128.Max}
)

// // IsZero returns true if the uint128 is zero.
func (u Uint256) IsZero() bool {
	return u.Lo.IsZero() && u.Hi.IsZero()
}

// // Equals returns true if the u == v
func (u Uint256) Equals(v Uint256) bool {
	return u.Lo.Equals(v.Lo) && u.Hi.Equals(v.Hi)
}

// Equals128 returns true if the u == v
func(u Uint256) Equals128(v uint128.Uint128) bool {
	return u.Lo.Equals(v) && u.Hi.IsZero()
}

// Equals64 returns true if the u == v
func(u Uint256) Equals64(v uint64) bool {
	return u.Lo.Equals64(v) && u.Hi.IsZero()
}

// Cmp compares u and v and returns:
//   -1 if u < v
//    0 if u == v
//   +1 if u > v
func (u Uint256) Cmp(v Uint256) int {
	if u == v {
		return 0
	} else if u.Hi.Cmp(v.Hi) == -1 || (u.Hi.Equals(v.Hi) && u.Lo.Cmp(v.Lo) == -1) {
		return -1
	} else {
		return 1
	}
}

// Cmp128 compares u and v and returns:
//   -1 if u < v
//    0 if u == v
//   +1 if u > v
func (u Uint256) Cmp128(v uint128.Uint128) int {
	if u.Hi.IsZero() && u.Lo.Cmp(v) == 0 {
		return 0
	} else if u.Hi.IsZero() && u.Lo.Cmp(v) == -1 {
		return -1
	} else {
		return 1
	}
}

// Cmp64 compares u and v and returns:
//   -1 if u < v
//    0 if u == v
//   +1 if u > v
func (u Uint256) Cmp64(v uint64) int {
	if u.Hi.IsZero() && u.Lo.Cmp64(v) == 0 {
		return 0
	} else if u.Hi.IsZero() && u.Lo.Cmp64(v) == -1 {
		return -1
	} else {
		return 1
	}
}

// Add with Carry
func Add(x, y Uint256, carry uint64) (sum Uint256, carryOut uint64) {
	sum.Lo, carryOut = uint128.Add()
}


// Add returns u+v
func (u Uint256) Add(v Uint256) Uint256 {
	sum, _ := Add(u, v, 0)
	return sum
}



// // Add returns u+v
// func (u Uint128) Add(v Uint128) Uint128 {
// 	lo, carry := bits.Add64(u.Lo, v.Lo, 0)
// 	hi, carry := bits.Add64(u.Hi, v.Hi, carry)
// 	if carry != 0 {
// 		panic("overflow")
// 	}
// 	return Uint128{lo, hi}
// }

// // Add64 returns u+v
// func (u Uint128) Add64(v uint64) Uint128 {
// 	lo, carry := bits.Add64(u.Lo, v, 0)
// 	hi, carry := bits.Add64(u.Hi, 0, carry)
// 	if carry != 0 {
// 		panic("overflow")
// 	}
// 	return Uint128{lo, hi}
// }

// // Sub returns u-v
// func (u Uint128) Sub(v Uint128) Uint128 {
// 	lo, borrow := bits.Sub64(u.Lo, v.Lo, 0)
// 	hi, borrow := bits.Sub64(u.Hi, v.Hi, borrow)
// 	if borrow != 0 {
// 		panic("underflow")
// 	}
// 	return Uint128{lo, hi}
// }

// // Sub64 returns u-v
// func (u Uint128) Sub64(v uint64) Uint128 {
// 	lo, borrow := bits.Sub64(u.Lo, v, 0)
// 	hi, borrow := bits.Sub64(u.Hi, 0, borrow)
// 	if borrow != 0 {
// 		panic("underflow")
// 	}
// 	return Uint128{lo, hi}
// }

// // Mul return u*v
// func (u Uint128) Mul(v Uint128) Uint128 {
// 	hi, lo := bits.Mul64(u.Lo, v.Lo)
// 	p0, p1 := bits.Mul64(u.Hi, v.Lo)
// 	p2, p3 := bits.Mul64(u.Lo, v.Hi)
// 	hi, c0 := bits.Add64(hi, p1, 0)
// 	hi, c1 := bits.Add64(hi, p3, c0)
// 	if (u.Hi != 0 && v.Hi != 0) || p0 != 0 || p2 != 0 || c1 != 0 {
// 		panic("overflow")
// 	}
// 	return Uint128{lo, hi}
// }

// // Mul64 return u*v
// func (u Uint128) Mul64(v uint64) Uint128 {
// 	hi, lo := bits.Mul64(u.Lo, v)
// 	p0, p1 := bits.Mul64(u.Hi, v)
// 	hi, c0 := bits.Add64(hi, p1, 0)
// 	if p0 != 0 || c0 != 0 {
// 		panic("overflow")
// 	}
// 	return Uint128{lo, hi}
// }

// // Div returns u/v
// func (u Uint128) Div(v Uint128) Uint128 {
// 	q, _ := u.QuoRem(v)
// 	return q
// }

// // Div64 returns u/v
// func (u Uint128) Div64(v uint64) Uint128 {
// 	q, _ := u.QuoRem64(v)
// 	return q
// }

// // QuoRem returns
// // q = u / v
// // r = u % v
// func (u Uint128) QuoRem(v Uint128) (Uint128, Uint128) {
// 	if v.Hi == 0 {
// 		q, r := u.QuoRem64(v.Lo)
// 		return q, From64(r)
// 	}

// 	n := uint(bits.LeadingZeros64(v.Hi))
// 	v1, u1 := v.Lsh(n), u.Rsh(n)
// 	tq, _ := bits.Div64(u1.Hi, u1.Lo, v1.Hi)
// 	tq >>= 63 - n
// 	if tq != 0 {
// 		tq--
// 	}

// 	q, r := From64(tq), u.Sub(v.Mul64(tq))
// 	if r.Cmp(v) >= 0 {
// 		q = q.Add64(1)
// 		r = r.Sub(v)
// 	}
// 	return q, r
// }

// // QuoRem64 returns
// // q = u / v
// // r = u % v
// func (u Uint128) QuoRem64(v uint64) (Uint128, uint64) {
// 	if u.Hi < v {
// 		lo, r := bits.Div64(u.Hi, u.Lo, v)
// 		return Uint128{Lo: lo}, r
// 	}

// 	hi, r := bits.Div64(0, u.Hi, v)
// 	lo, r := bits.Div64(r, u.Lo, v)
// 	return Uint128{Lo: lo, Hi: hi}, r
// }


/*
	HELPERS
*/

// From128 converts uint128 to uint256 value
func From128(v uint128.Uint128) Uint256 {
	return Uint256{Lo: v}
}

// From64 converts uint64 to Uint256 value
func From64(v uint64) Uint256 {
	return From128(uint128.From64(v))
}

// // New returns the Uint128 value with lo and hi uint64 parts
// func New(lo, hi uint64) Uint256 {
// 	return Uint256{lo, hi, 0, 0}
// }

// // String returns the string representation of the Uint128 value
// func (u Uint128) ToString() string {
// 	if u.IsZero() {
// 		return "0"
// 	}

// 	buf := []byte("0000000000000000000000000000000000000000") // log10(2^128) < 40
// 	for i := len(buf); ; i -= 19 {
// 		q, r := u.QuoRem64(1e19) // largest power of 10 that fits in a uint64
// 		var n int
// 		for ; r != 0; r /= 10 {
// 			n++
// 			buf[i-n] += byte(r % 10)
// 		}
// 		if q.IsZero() {
// 			return string(buf[i-n:])
// 		}
// 		u = q
// 	}
// }


// /*
// 	SHIFT OPERATORS
// */

// // Lsh returns left shift (u<<n).
// func (u Uint128) Lsh(n uint) Uint128 {
// 	if n > 64 {
// 		return Uint128{
// 			Lo: 0,
// 			Hi: u.Lo << (n - 64),
// 		}
// 	}

// 	return Uint128{
// 		Lo: u.Lo << n,
// 		Hi: u.Hi<<n | u.Lo>>(64-n),
// 	}
// }

// // Rsh returns right shift (u>>n).
// func (u Uint128) Rsh(n uint) Uint128 {
// 	if n > 64 {
// 		return Uint128{
// 			Lo: u.Hi >> (n - 64),
// 			// Hi: 0,
// 		}
// 	}

// 	return Uint128{
// 		Lo: u.Lo>>n | u.Hi<<(64-n),
// 		Hi: u.Hi >> n,
// 	}
// }