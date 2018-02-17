pragma solidity ^0.4.18;

import "./BaseStorage.sol";

contract PublicStorage is BaseStorage {

  function senderIsValid() private view returns (bool) {
    return msg.sender != 0x0;
  }

  function scopedKey(bytes32 key) internal view returns(bytes32) {
    return keccak256(msg.sender, key);
  }

}
