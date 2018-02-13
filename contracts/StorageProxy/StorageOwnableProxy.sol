pragma solidity ^0.4.18;

import "../Storage/KeyValueStorage.sol";
import "../Proxy/OwnableProxy.sol";

contract StorageOwnableProxy is KeyValueStorage, OwnableProxy {

  function StorageOwnableProxy(address delegate)
    public
    OwnableProxy(delegate) 
  {

  }

}
