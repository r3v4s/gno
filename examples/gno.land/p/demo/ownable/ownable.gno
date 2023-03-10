package ownable

import (
	"std"
)

var (
	_owner = std.Address("")
	_zeroAddress = std.Address("")
)


func init() {}


/// @dev Sets caller to an owner
/// XXX should we need list of owners?
func SetOwner() std.Address {
	if (_owner != std.Address("")) {
		panic("owner already registered")
	}
	emit(OwnershipTransferredEvent{_owner, std.GetOrigCaller()})
	_owner = std.GetOrigCaller()
	return _owner
}

/// @dev Returns current owner.
func Owner() std.Address{
	return _owner;
}

/// @dev Panics if called by any account other than the owner.
func OnlyOwner() {
	require(isOwner(), "Ownable: caller is not the owner")
}

/// @dev Returns true if the caller is the currnet owner or false otherwise.
func isOwner() bool {
	return std.GetOrigCaller() == _owner
}

/// @notice Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.
/// @dev Leaves the contract without owner. It will not be possible to call `OnlyOwner` fuctions anymore.
/// Can only be called by the current owner.
func RenounceOwnership() {
	OnlyOwner()
	emit(OwnershipTransferredEvent{_owner, _zeroAddress})
	_owner = _zeroAddress
}

/// @dev Transfers ownership of the contract to a new account (`newOwner`).
/// Can only be called by the current owner.
func TransferOwnership(newOwner std.Address) {
	OnlyOwner()
	_transferOwnership(newOwner); 
}

/// @dev Transfers ownership of the contract to a new account (`newOwner`).
func _transferOwnership(newOwner std.Address) {
	require(newOwner != _zeroAddress, "Ownable: new owner is the zero address")
	emit(OwnershipTransferredEvent{_owner, newOwner})
	_owner = newOwner
}
