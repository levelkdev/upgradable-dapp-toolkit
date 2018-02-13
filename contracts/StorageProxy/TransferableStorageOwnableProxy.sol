pragma solidity ^0.4.18;

import "../Storage/TransferableStorage.sol";
import "../Proxy/OwnableProxy.sol";

contract TransferableStorageOwnableProxy is TransferableStorage, OwnableProxy {

  function TransferableStorageOwnableProxy(address delegate)
    public
    OwnableProxy(delegate) 
  {

  }

}
