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

  function senderIsValid() private view returns (bool) {
    return _ownerToKeyAddress[msg.sender] != 0x000000000000000000000000000000000000dEaD;
  }

  function scopedKey(bytes32 key) internal view returns(bytes32) {
    address keyAddress;
    if (_ownerToKeyAddress[msg.sender] == 0x0) {
      keyAddress = msg.sender;
    } else {
      keyAddress = _ownerToKeyAddress[msg.sender];
    }
    return keccak256(keyAddress, key);
  }
}
