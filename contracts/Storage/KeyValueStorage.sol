pragma solidity ^0.4.18;

contract KeyValueStorage {
  mapping(address => mapping(bytes32 => uint256)) _uintStorage;
  mapping(address => mapping(bytes32 => string)) _stringStorage;
  mapping(address => mapping(bytes32 => address)) _addressStorage;
  mapping(address => mapping(bytes32 => bytes)) _bytesStorage;
  mapping(address => mapping(bytes32 => bytes32)) _bytes32Storage;
  mapping(address => mapping(bytes32 => bool)) _boolStorage;
  mapping(address => mapping(bytes32 => int256)) _intStorage;
}
