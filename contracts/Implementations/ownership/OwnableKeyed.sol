pragma solidity ^0.4.18;

import "../../Storage/BaseStorage.sol";
import "../../StorageConsumer/StorageConsumer.sol";

contract OwnableKeyed is StorageConsumer {

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == getOwner());
    _;
  }

  function OwnableKeyed(BaseStorage storage_) public StorageConsumer(storage_) {
    if (address(storage_) != 0x0) {
      setOwner(msg.sender);
    }
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(getOwner(), newOwner);
    setOwner(newOwner);
  }

  function getOwner() public view returns (address) {
    return _storage.getAddress("owner");
  }

  function setOwner(address owner) internal {
    _storage.setAddress("owner", owner);
  }

}
