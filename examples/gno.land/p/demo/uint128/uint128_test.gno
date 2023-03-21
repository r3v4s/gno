package uint128

import (
	"errors"
	"testing"
)

var (
	_zero Uint128 = Zero()
	_one Uint128 = One()
	_two Uint128 = Uint128{2, 0}
	_three Uint128 = Uint128{3, 0}
	_four Uint128 = Uint128{4, 0}
	_five Uint128 = Uint128{5, 0}
	_six Uint128 = Uint128{6, 0}
	_seven Uint128 = Uint128{7, 0}
	_eight Uint128 = Uint128{8, 0}
	_nine Uint128 = Uint128{9, 0}
	_ten Uint128 = Uint128{10, 0}
	_max Uint128 = Max()
)

func TestAdd(t *testing.T) {
	// Unsafe
	sum, carry := _one.UnsafeAdd(_max)
	shouldEqual(t, sum, _zero)
	shouldEqual(t, carry, uint64(1))

	// Safe
	shouldEqual(t, _four.Add(_six), _ten)
	shouldPanic(t, func() {(_one.Add(_max))})
}

func TestSub(t *testing.T) {
	// Unsafe
	diff, borrow := _zero.UnsafeSub(_one)
	shouldEqual(t, diff, _max)
	shouldEqual(t, borrow, uint64(1))

	// Safe
	shouldEqual(t, _ten.Sub(_two), _eight)
	shouldPanic(t, func() {_one.Sub(_max)})
}


func TestMul(t *testing.T) {
	// Unsafe
	_s, _ := _max.UnsafeAdd(_max)	
	shouldEqual(t, _max.UnsafeMul(_two), _s)

	// Safe
	shouldEqual(t, _two.Mul(_three), _six)
	shouldPanic(t, func() {_two.Mul(_max)})
}


func TestQuoRem(t *testing.T) {
	// Just
	{
		q, r := _ten.QuoRem(_three)
		shouldEqual(t, q, _three)
		shouldEqual(t, r, _one)
	}

	{
		shouldPanic(t, func() {_one.QuoRem(_zero)})
	}

	{
		q, r := _zero.QuoRem(_max)
		shouldEqual(t, q, _zero)
		shouldEqual(t, r, _zero)
	}

	{
		q, r := _two.QuoRem(_eight)
		shouldEqual(t, q, _zero)
		shouldEqual(t, r, _two)
	}
}

func TestDivMod(t *testing.T) {
	q := _ten.Div(_three)
	shouldEqual(t, q, _three)

	r := _ten.Mod(_three)
	shouldEqual(t, r, _one)
}




////////////////////////////////////////////////////////////////////////
// Helpers
////////////////////////////////////////////////////////////////////////
func shouldEqual(t *testing.T, got, expected interface{}) {
	if got != expected {
		t.Errorf("expected %v, got %v", expected, got)
	}
}

func shouldNotEqual(t *testing.T, got, expected interface{}) {
	if got == expected {
		t.Errorf("expected %v to not equal %v", got, expected)
	}
}

func shouldPanic(t *testing.T, f func()) {
	defer func() {
		if r := recover(); r == nil {
			t.Errorf("the code did not panic")
		}
	}()
	f()
}