package big

import (
	"fmt"
	"testing"

	"math/big"
)

func TestFunc(t *testing.T) {
	a := big.NewInt(123)
	b := big.NewInt(456)
	expected := big.NewInt(579)

	result := big.NewInt(0)
	result.Add(a, b)

	

	println(*result)
	println(*expected)
}
