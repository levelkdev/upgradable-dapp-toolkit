pragma solidity ^0.4.18;

import "./BaseStorage.sol";

contract TransferableStorage is BaseStorage {

  mapping(address => address) _ownerToKeyAddress;

  function transferOwnership(address newOwner) public {
    if (_ownerToKeyAddress[msg.sender] == 0x0) {
      _ownerToKeyAddress[newOwner] = msg.sender;
    } else {
      _ownerToKeyAddress[newOwner] = _ownerToKeyAddress[msg.sender];
    }
    _ownerToKeyAddress[msg.sender] = 0x000000000000000000000000000000000000dEaD;
  }

  /**** Private Methods ***********/

  function senderIsValid() private view returns (bool) {
    return _ownerToKeyAddress[msg.sender] != 0x000000000000000000000000000000000000dEaD;
  }

  function keyAddress() private view returns (address) {
    if (_ownerToKeyAddress[msg.sender] == 0x0) {
      return msg.sender;
    } else {
      return _ownerToKeyAddress[msg.sender];
    }
  }
}
