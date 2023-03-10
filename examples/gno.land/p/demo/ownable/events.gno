package ownable

import (
	"std"
)

type OwnershipTransferredEvent struct {
	previousOwner std.Address
	newOwner			std.Address
}