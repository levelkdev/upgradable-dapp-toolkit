pragma solidity ^0.4.18;

import "../Storage/BaseStorage.sol";

library StorageConsumerLib {
  struct Storage {
    BaseStorage store;
  }
}
