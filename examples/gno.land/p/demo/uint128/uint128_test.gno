package uint128

import (
	"testing"
)

var (
	_zero Uint128 = Zero()
	_one Uint128 = One()
	_max Uint128 = Max()
)


func TestFom64(t *testing.T) {
	shouldEqual(t, From64(0), _zero)
	shouldEqual(t, From64(1), _one)
	shouldEqual(t, From64(10), Uint128{10, 0})
}

func TestIsZero(t *testing.T) {
	shouldEqual(t, _zero.IsZero(), true)
}

func TestEquals(t *testing.T) {
	shouldEqual(t, _one.Equals(_one), true)
	shouldEqual(t, _one.Equals(_zero), false)
}

func TestEquals64(t *testing.T) {
	shouldEqual(t, _one.Equals64(1), true)
	shouldEqual(t, _one.Equals64(0), false)
}

func TestCmp(t *testing.T) {
	shouldEqual(t, _one.Cmp(_one), 0)
	shouldEqual(t, _one.Cmp(_zero), 1)
	shouldEqual(t, _zero.Cmp(_one), -1)
}

func TestCmp64(t *testing.T) {
	shouldEqual(t, _one.Cmp64(1), 0)
	shouldEqual(t, _one.Cmp64(0), 1)
	shouldEqual(t, _zero.Cmp64(1), -1)
}

func TestNot(t *testing.T) {
	shouldEqual(t, _zero.Not(), _max)
}

func TestAnd(t *testing.T) {
	shouldEqual(t, _one.And(_one), _one)
	shouldEqual(t, _one.And(_zero), _zero)
}

func TestAnd64(t *testing.T) {
	shouldEqual(t, _one.And64(1), _one)
	shouldEqual(t, _one.And64(0), _zero)
}

func TestOr(t *testing.T) {
	shouldEqual(t, _one.Or(_one), _one)
	shouldEqual(t, _one.Or(_zero), _one)
	shouldEqual(t, _zero.Or(_zero), _zero)
}

func TestOr64(t *testing.T) {
	shouldEqual(t, _one.Or64(1), _one)
	shouldEqual(t, _one.Or64(0), _one)
	shouldEqual(t, _zero.Or64(0), _zero)
}

func TestXor(t *testing.T) {
	shouldEqual(t, _one.Xor(_one), _zero)
	shouldEqual(t, _one.Xor(_zero), _one)
	shouldEqual(t, _zero.Xor(_zero), _zero)
}

func TestXor64(t *testing.T) {
	shouldEqual(t, _one.Xor64(1), _zero)
	shouldEqual(t, _one.Xor64(0), _one)
	shouldEqual(t, _zero.Xor64(0), _zero)
}

func TestAdd(t *testing.T) {
	shouldEqual(t, _one.Add(_one), Uint128{2, 0})
	shouldEqual(t, Add(_max, _one), Uint128{0, 0}) // overflow ok
	// _max.Add(_one) // overflow panic
}

func TestAdd64(t *testing.T) {
	shouldEqual(t, _one.Add64(1), Uint128{2, 0})
	// println(_max.Add64(1)) // overflow panic
}

func TestSub(t *testing.T) {
	shouldEqual(t, _one.Sub(_one), _zero)
	shouldEqual(t, Sub(_zero, _one), _max) // underflow ok
	// _zero.Sub(_one) // underflow panic
}

func TestSub64(t *testing.T) {
	shouldEqual(t, _one.Sub64(1), _zero)
	// _zero.Sub64(1) // underflow
}

func TestMul(t *testing.T) {
	shouldEqual(t, _one.Mul(_max), _max)
	shouldEqual(t, Mul(_max, _max), Uint128{1, 0}) // overflow ok
	// _max.Mul(Uint128{2, 0}) // overflow panic
}

func TestMul64(t *testing.T) {
	shouldEqual(t, _one.Mul64(1), _one)
	shouldEqual(t, _one.Mul64(2), Uint128{2, 0})
	// _max.Mul64(2) // overflow panic
}

func TestDiv(t *testing.T) {
	shouldEqual(t, _one.Div(_one), _one)
	shouldEqual(t, _max.Div(_one), _max)
	shouldEqual(t, _max.Div(_max), _one)
	// _max.Div(_zero) // panic
}

func TestToString(t *testing.T) {
	shouldEqual(t, _one.String(), "1")
	shouldEqual(t, _max.String(), "340282366920938463463374607431768211455")
}


func shouldEqual(t *testing.T, got, expected interface{}) {
	if got != expected {
		t.Errorf("expected %v, got %v", expected, got)
	}
}