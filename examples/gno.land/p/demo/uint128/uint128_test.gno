package uint128

import (
	"testing"
)

func TestFuncs(t *testing.T) {
	_max := Max
	_zero := Zero
	_one := One
	_two := New(2, 0)

	println(_one.Add(_zero))
	// println(_max.Add(_one)) // overflow

	println(_one.Add64(uint(1)))
	// println(_max.Add64(uint(1))) // overflow

	println(_one.Sub(_zero))
	// println(_zero.Sub(_one)) // underflow

	println(_one.Sub64(uint(1)))
	// println(_zero.Sub64(uint(1))) // underflow

	println(_one.Mul(_two))
	// println(_max.Mul(_two)) // overflow

	println(_two.Mul64(uint(3)))
	// println(_max.Mul64(uint(2))) // overflow

	println(_two.Div(_one))
	println(_two.Div64(uint(2)))

	println(_two.ToString())
}