pragma solidity ^0.4.18;

import "../Storage/BaseStorage.sol";
import "./StorageConsumerState.sol";

contract StorageConsumer is StorageConsumerState {
  function StorageConsumer(BaseStorage store) public {
    _storage.store = store;
  }
}
