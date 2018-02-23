pragma solidity ^0.4.18;

import "../Storage/BaseStorage.sol";
import "../StorageConsumer/StorageConsumer.sol";
import "../Delegates/ownership/OwnableDelegate.sol";
import "./BaseProxy.sol";

contract OwnableProxy is OwnableDelegate, BaseProxy {

  event Upgraded(address indexed implementation_);

  function OwnableProxy(BaseStorage storage_, address implementation_)
    public
    OwnableDelegate(storage_)
  {
    setImplementation(implementation_);
  }

  function implementation() public view returns (address) {
    return _storage.getAddress("implementation");
  }

  function upgradeTo(address impl) public onlyOwner {
    require(implementation() != impl);
    setImplementation(impl);
    Upgraded(impl);
  }

  function setImplementation(address implementation_) internal {
    _storage.setAddress("implementation", implementation_);
  }

}
