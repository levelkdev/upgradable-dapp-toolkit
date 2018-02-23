pragma solidity ^0.4.18;

import "../ownership/OwnableDelegate.sol";

/**
 * @title PausableDelegate
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract PausableDelegate is OwnableDelegate {
  event Pause();
  event Unpause();

  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!isPaused());
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(isPaused());
    _;
  }

  function PausableDelegate(BaseStorage storage_) public OwnableDelegate(storage_) { }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() onlyOwner whenNotPaused public {
    setPaused(true);
    Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    setPaused(false);
    Unpause();
  }

  function isPaused() public view returns (bool) {
    return _storage.getBool("paused");
  }

  function setPaused(bool paused) internal {
    _storage.setBool("paused", paused);
  }
}