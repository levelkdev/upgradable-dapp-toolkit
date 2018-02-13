pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./BaseProxy.sol";

contract OwnableProxy is BaseProxy, Ownable {

  event Upgraded(address indexed implementation);

  address internal _implementation;

  function OwnableProxy(address implementation) public {
    _implementation = implementation;
  }

  function implementation() public view returns (address) {
    return _implementation;
  }

  function upgradeTo(address impl) public onlyOwner {
    require(_implementation != impl);
    _implementation = impl;
    Upgraded(impl);
  }
}
