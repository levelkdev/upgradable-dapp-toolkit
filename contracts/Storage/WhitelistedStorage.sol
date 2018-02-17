pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./BaseStorage.sol";

contract WhitelistedStorage is BaseStorage, Ownable {

  mapping(address => bool) public _whitelistedSenders;

  function addSender(address sender) public onlyOwner {
    _whitelistedSenders[sender] = true;
  }

  function removeSender(address sender) public onlyOwner {
    delete _whitelistedSenders[sender];
  }

  function senderIsValid() private view returns (bool) {
    return _whitelistedSenders[msg.sender];
  }
}
