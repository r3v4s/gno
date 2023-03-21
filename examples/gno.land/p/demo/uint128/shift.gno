package uint128

///////////////////////////////////////////////////////////////////////////////
// /// shift operators ///////////////////////////////////////////////////////////

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