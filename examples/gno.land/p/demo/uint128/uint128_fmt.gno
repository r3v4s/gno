package uint128

import (
	"strconv"

	"gno.land/p/demo/ufmt"
)

func FromString(s string) (Uint128, error) {
	result := Zero()
	base := One()

	for _, ch := range s {
		num, err := strconv.Atoi(ufmt.Sprintf("%c", ch))
		if err != nil {
			return result, err
		}

		result = result.Mul(From64(10)).Add(From64(uint64(num)))
	}

	return result, nil
}

func (u Uint128) String() string {
	if u.Hi == 0 {
		if u.Lo == 0 {
			return "0"
		} else {
			return strconv.FormatUint(u.Lo, 10) // lower 64 bit
		}
	}

	buf := []byte("0000000000000000000000000000000000000000") // log10(2^128) < 40
	for i := len(buf); ; i -= 19 {
		q, r := u.QuoRem64(1e19) // largest power of 10 that fits in a uint64
		var n int
		for ; r != 0; r /= 10 {
			n++
			buf[i-n] += byte(r % 10)
		}
		if q.IsZero() {
			return string(buf[i-n:])
		}	
		u = q
	}
}