pragma solidity ^0.4.18;

import "../Storage/BaseStorage.sol";
import "./StorageStateful.sol";

contract StorageConsumer is StorageStateful {
  function StorageConsumer(BaseStorage storage_) public {
    _storage = storage_;
  }
}
