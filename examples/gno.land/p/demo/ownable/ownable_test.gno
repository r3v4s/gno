package ownable

import (
	"std"
	
	"testing"

	"gno.land/p/demo/testutils"
)

var (
	ownerUser = testutils.TestAddress("ownerUser")
	otherUser = testutils.TestAddress("otherUser")
)

func TestSetOwner(t *testing.T) {
	std.TestSetOrigCaller(ownerUser)
	owner := SetOwner()
	if owner != ownerUser {
		t.Errorf("SetOwner failed")
	}

	RenounceOwnership()
}

func TestOwner(t *testing.T) {
	std.TestSetOrigCaller(ownerUser)
	SetOwner()
	owner := Owner()
	if owner != ownerUser {
		t.Errorf("Owner failed")
	}

	RenounceOwnership()
}

func TestOnlyOwner(t *testing.T) {
	std.TestSetOrigCaller(ownerUser)
	SetOwner()
	OnlyOwner()
	
	/// @notice this should panic
	/// XXX to test panics in gnolang, we need something like 'testify/assert' 
	// std.TestSetOrigCaller(otherUser)
	// OnlyOwner()

	RenounceOwnership()
}

func TestRenounceOwnership(t *testing.T) {
	std.TestSetOrigCaller(ownerUser)
	owner := SetOwner()
	if owner != ownerUser {
		t.Errorf("SetOwner failed")
	}

	RenounceOwnership()
	owner = Owner()
	if owner != _zeroAddress {
		t.Errorf("RenounceOwnership failed")
	}
}

func TestTransferOwnership(t *testing.T) {
	std.TestSetOrigCaller(ownerUser)
	owner := SetOwner()

	TransferOwnership(otherUser)
	owner = Owner()
	if owner != otherUser {
		t.Errorf("TransferOwnership failed")
	}
}