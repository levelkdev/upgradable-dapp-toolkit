pragma solidity ^0.4.18;

import "./KeyValueStorage.sol";

contract BaseStorage is KeyValueStorage {

  /// @dev Only allow access if senderIsValid() is true
  modifier isAllowed {
    require(senderIsValid());
    _;
  }

  /**** Get Methods ***********/

  /// @dev Get the address for the key
  /// @param key The key for the address
  function getAddress(bytes32 key) public view isAllowed returns (address) {
      return _addressStorage[scopedKey(key)];
  }

  /// @dev Get the uint for the key
  /// @param key The key for the uint
  function getUint(bytes32 key) public view isAllowed returns (uint) {
      return _uintStorage[scopedKey(key)];
  }

  /// @dev Get the string for the key
  /// @param key The key for the string
  function getString(bytes32 key) public view isAllowed returns (string) {
      return _stringStorage[scopedKey(key)];
  }

  /// @dev Get the bytes for the key
  /// @param key The key for the bytes
  function getBytes(bytes32 key) public view isAllowed returns (bytes) {
      return _bytesStorage[scopedKey(key)];
  }

  /// @dev Get the bytes32 for the key
  /// @param key The key for the bytes32
  function getBytes32(bytes32 key) public view isAllowed returns (bytes32) {
      return _bytes32Storage[scopedKey(key)];
  }

  /// @dev Get the bool for the key
  /// @param key The key for the bool
  function getBool(bytes32 key) public view isAllowed returns (bool) {
      return _boolStorage[scopedKey(key)];
  }

  /// @dev Get the int for the key
  /// @param key The key for the int
  function getInt(bytes32 key) public view isAllowed returns (int) {
      return _intStorage[scopedKey(key)];
  }

  /**** Set Methods ***********/

  /// @dev Set the address for the key
  /// @param key The key for the address
  /// @param value The address to be set
  function setAddress(bytes32 key, address value) public isAllowed {
    _addressStorage[scopedKey(key)] = value;
  }

  /// @dev Set the uint for the key
  /// @param key The key for the uint
  /// @param value The uint to be set
  function setUint(bytes32 key, uint value) public isAllowed {
      _uintStorage[scopedKey(key)] = value;
  }

  /// @dev Set the string for the key
  /// @param key The key for the string
  /// @param value The string to be set
  function setString(bytes32 key, string value) public isAllowed {
      _stringStorage[scopedKey(key)] = value;
  }

  /// @dev Set the bytes for the key
  /// @param key The key for the bytes
  /// @param value The bytes to be set
  function setBytes(bytes32 key, bytes value) public isAllowed {
      _bytesStorage[scopedKey(key)] = value;
  }

  /// @dev Set the bytes32 for the key
  /// @param key The key for the bytes32
  /// @param value The bytes32 to be set
  function setBytes32(bytes32 key, bytes32 value) public isAllowed {
      _bytes32Storage[scopedKey(key)] = value;
  }

  /// @dev Set the bool for the key
  /// @param key The key for the bool
  /// @param value The bool to be set
  function setBool(bytes32 key, bool value) public isAllowed {
      _boolStorage[scopedKey(key)] = value;
  }

  /// @dev Set the int for the key
  /// @param key The key for the int
  /// @param value The int to be set
  function setInt(bytes32 key, int value) public isAllowed {
      _intStorage[scopedKey(key)] = value;
  }

  /**** Delete Methods ***********/

  /// @dev Delete the address for the key
  /// @param key The key for the address
  function deleteAddress(bytes32 key) public isAllowed {
      delete _addressStorage[scopedKey(key)];
  }

  /// @dev Delete the uint for the key
  /// @param key The key for the uint
  function deleteUint(bytes32 key) public isAllowed {
      delete _uintStorage[scopedKey(key)];
  }

  /// @dev Delete the string for the key
  /// @param key The key for the string
  function deleteString(bytes32 key) public isAllowed {
      delete _stringStorage[scopedKey(key)];
  }

  /// @dev Delete the bytes for the key
  /// @param key The key for the bytes
  function deleteBytes(bytes32 key) public isAllowed {
      delete _bytesStorage[scopedKey(key)];
  }

  /// @dev Delete the bytes32 for the key
  /// @param key The key for the bytes32
  function deleteBytes32(bytes32 key) public isAllowed {
      delete _bytes32Storage[scopedKey(key)];
  }

  /// @dev Delete the bool for the key
  /// @param key The key for the bool
  function deleteBool(bytes32 key) public isAllowed {
      delete _boolStorage[scopedKey(key)];
  }

  /// @dev Delete the int for the key
  /// @param key The key for the int
  function deleteInt(bytes32 key) public isAllowed {
      delete _intStorage[scopedKey(key)];
  }

  /**** Private Methods ***********/

  /// @return true if sender is valid
  function senderIsValid() private view returns (bool) {
    return true;
  }

  /// @return the key possibly hashed with another value such as msg.sender
  function scopedKey(bytes32 key) internal view returns(bytes32) {
    return key;
  }
}
