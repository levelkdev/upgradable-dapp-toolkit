pragma solidity ^0.4.18;

import "./KeyValueStorage.sol";

contract BaseStorage is KeyValueStorage {

  modifier isAllowed {
    require(senderIsValid());
    _;
  }

  /**** Get Methods ***********/

  function getAddress(bytes32 key) public view isAllowed returns (address) {
      return _addressStorage[scopedKey(key)];
  }

  function getUint(bytes32 key) public view isAllowed returns (uint) {
      return _uintStorage[scopedKey(key)];
  }

  function getString(bytes32 key) public view isAllowed returns (string) {
      return _stringStorage[scopedKey(key)];
  }

  function getBytes(bytes32 key) public view isAllowed returns (bytes) {
      return _bytesStorage[scopedKey(key)];
  }

  function getBytes32(bytes32 key) public view isAllowed returns (bytes32) {
      return _bytes32Storage[scopedKey(key)];
  }

  function getBool(bytes32 key) public view isAllowed returns (bool) {
      return _boolStorage[scopedKey(key)];
  }

  function getInt(bytes32 key) public view isAllowed returns (int) {
      return _intStorage[scopedKey(key)];
  }

  /**** Set Methods ***********/

  function setAddress(bytes32 key, address value) public isAllowed {
    _addressStorage[scopedKey(key)] = value;
  }

  function setUint(bytes32 key, uint value) public isAllowed {
      _uintStorage[scopedKey(key)] = value;
  }

  function setString(bytes32 key, string value) public isAllowed {
      _stringStorage[scopedKey(key)] = value;
  }

  function setBytes(bytes32 key, bytes value) public isAllowed {
      _bytesStorage[scopedKey(key)] = value;
  }

  function setBytes32(bytes32 key, bytes32 value) public isAllowed {
      _bytes32Storage[scopedKey(key)] = value;
  }

  function setBool(bytes32 key, bool value) public isAllowed {
      _boolStorage[scopedKey(key)] = value;
  }

  function setInt(bytes32 key, int value) public isAllowed {
      _intStorage[scopedKey(key)] = value;
  }

  /**** Delete Methods ***********/

  function deleteAddress(bytes32 key) public isAllowed {
      delete _addressStorage[scopedKey(key)];
  }

  function deleteUint(bytes32 key) public isAllowed {
      delete _uintStorage[scopedKey(key)];
  }

  function deleteString(bytes32 key) public isAllowed {
      delete _stringStorage[scopedKey(key)];
  }

  function deleteBytes(bytes32 key) public isAllowed {
      delete _bytesStorage[scopedKey(key)];
  }

  function deleteBytes32(bytes32 key) public isAllowed {
      delete _bytes32Storage[scopedKey(key)];
  }

  function deleteBool(bytes32 key) public isAllowed {
      delete _boolStorage[scopedKey(key)];
  }

  function deleteInt(bytes32 key) public isAllowed {
      delete _intStorage[scopedKey(key)];
  }

  /**** Private Methods ***********/

  function senderIsValid() private view returns (bool) {
    return true;
  }

  function scopedKey(bytes32 key) internal view returns(bytes32) {
    return key;
  }
}
