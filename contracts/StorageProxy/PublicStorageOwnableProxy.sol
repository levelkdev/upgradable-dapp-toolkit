pragma solidity ^0.4.18;

import "../Storage/PublicStorage.sol";
import "../Proxy/OwnableProxy.sol";

contract PublicStorageOwnableProxy is PublicStorage, OwnableProxy {

  function PublicStorageOwnableProxy(address delegate)
    public
    OwnableProxy(delegate) 
  {

  }

}
