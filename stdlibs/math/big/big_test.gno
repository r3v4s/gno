package big

import (
	"fmt"
	"testing"

	"math/big"
)

func TestFunc(t *testing.T) {
	a := big.NewInt(123)
	b := big.NewInt(456)

	result := big.NewInt(0)
	result.Add(a, b)

	expected := big.NewInt(579)

	var expected2 *big.Int = big.NewInt(579)
	println(*result)
	println(*expected)
	// println(*expected2)
}

