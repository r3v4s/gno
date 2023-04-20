package bigint

import (
	"testing"
)

var (
	mi 		int			= 123
	mi32	int32 	= 123
	mi64	int64 	= 123

	mui		uint		= 123
	mui32	uint32	= 123
	mui64	uint64	= 123

	mbi		bigint	= 123
)

func TestDefaultBigint(t *testing.T) {
	var _zero bigint
	shouldEqual(t, _zero, bigint(0))
}

func TestIntsToBigint(t *testing.T) {
	shouldEqual(t, bigint(mi), mbi)
	shouldEqual(t, bigint(mi32), mbi)
	shouldEqual(t, bigint(mi64), mbi)

	shouldEqual(t, bigint(mui), mbi)
	shouldEqual(t, bigint(mui32), mbi)
	shouldEqual(t, bigint(mui64), mbi)
}

func TestBigintOpIncDec(t *testing.T) {
	var _one bigint = 1

	_one++
	shouldEqual(t, _one, bigint(2))

	_one--
	shouldEqual(t, _one, bigint(1))
}

func TestBasicArith(t *testing.T) {
	var _three bigint = 3
	var _twenty bigint = 20

	shouldEqual(t, _three + _twenty, bigint(23))
	shouldEqual(t, _twenty - _three, bigint(17))
	shouldEqual(t, _three * _twenty, bigint(60))
	shouldEqual(t, _twenty / _three, bigint(6))
	shouldEqual(t, _twenty % _three, bigint(2))
}

// bigint to smaller types 
// XXX panic due to possibility of precision loss
// XXX catch go panic in gno
func TestBigintToSmall(t *testing.T) {
	// shouldEqual(t, int(mbi), mi)
	// shouldEqual(t, int32(mbi), mi32)
	// shouldEqual(t, int64(mbi), mi64)

	// shouldEqual(t, uint(mbi), mui)
	// shouldEqual(t, uint32(mbi), mui32)
	// shouldEqual(t, uint64(mbi), mui64)
}
