pragma solidity ^0.4.18;

import "./KeyValueStorage.sol";

contract BaseStorage is KeyValueStorage {

  modifier isAllowed {
    require(senderIsValid());
    _;
  }

  /**** Get Methods ***********/

  function getAddress(bytes32 key) public view isAllowed returns (address) {
      return _addressStorage[keyAddress()][key];
  }

  function getUint(bytes32 key) public view isAllowed returns (uint) {
      return _uintStorage[keyAddress()][key];
  }

  function getString(bytes32 key) public view isAllowed returns (string) {
      return _stringStorage[keyAddress()][key];
  }

  function getBytes(bytes32 key) public view isAllowed returns (bytes) {
      return _bytesStorage[keyAddress()][key];
  }

  function getBytes32(bytes32 key) public view isAllowed returns (bytes32) {
      return _bytes32Storage[keyAddress()][key];
  }

  function getBool(bytes32 key) public view isAllowed returns (bool) {
      return _boolStorage[keyAddress()][key];
  }

  function getInt(bytes32 key) public view isAllowed returns (int) {
      return _intStorage[keyAddress()][key];
  }

  /**** Set Methods ***********/

  function setAddress(bytes32 key, address value) public isAllowed {
    _addressStorage[keyAddress()][key] = value;
  }

  function setUint(bytes32 key, uint value) public isAllowed {
      _uintStorage[keyAddress()][key] = value;
  }

  function setString(bytes32 key, string value) public isAllowed {
      _stringStorage[keyAddress()][key] = value;
  }

  function setBytes(bytes32 key, bytes value) public isAllowed {
      _bytesStorage[keyAddress()][key] = value;
  }

  function setBytes32(bytes32 key, bytes32 value) public isAllowed {
      _bytes32Storage[keyAddress()][key] = value;
  }

  function setBool(bytes32 key, bool value) public isAllowed {
      _boolStorage[keyAddress()][key] = value;
  }

  function setInt(bytes32 key, int value) public isAllowed {
      _intStorage[keyAddress()][key] = value;
  }

  /**** Delete Methods ***********/

  function deleteAddress(bytes32 key) public isAllowed {
      delete _addressStorage[keyAddress()][key];
  }

  function deleteUint(bytes32 key) public isAllowed {
      delete _uintStorage[keyAddress()][key];
  }

  function deleteString(bytes32 key) public isAllowed {
      delete _stringStorage[keyAddress()][key];
  }

  function deleteBytes(bytes32 key) public isAllowed {
      delete _bytesStorage[keyAddress()][key];
  }

  function deleteBytes32(bytes32 key) public isAllowed {
      delete _bytes32Storage[keyAddress()][key];
  }

  function deleteBool(bytes32 key) public isAllowed {
      delete _boolStorage[keyAddress()][key];
  }

  function deleteInt(bytes32 key) public isAllowed {
      delete _intStorage[keyAddress()][key];
  }

  /**** Private Methods ***********/

  function senderIsValid() private view returns (bool);

  function keyAddress() private view returns (address);
}
