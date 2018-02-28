pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "../../../StorageConsumer/StorageConsumer.sol";

/**
 * @title ERC721TokenKeyed
 * Generic implementation for the required functionality of the ERC721 standard
 */
contract ERC721TokenKeyed is StorageConsumer, ERC721 {
  using SafeMath for uint256;

  function ERC721TokenKeyed(BaseStorage storage_) StorageConsumer(storage_) public {}

  /**
  * @dev Internal function to increase totalTokens by 1
  */
  function incrementTotalTokens() private {
    _storage.setUint("totalTokens", totalSupply().add(1));
  }

  /**
  * @dev Internal function to decrease totalTokens by 1
  */
  function decrementTotalTokens() private {
    _storage.setUint("totalTokens", totalSupply().sub(1));
  }

  /**
  * @dev Internal function to get token owner by token ID
  * @param tokenId uint256 ID of the token to get the owner for
  * @return address The address that owns the token an with ID of tokenId
  */
  function getTokenOwner(uint256 tokenId) private returns (address) {
    return _storage.getAddress(keccak256("tokenOwners", tokenId));
  }

  /**
  * @dev Internal function to set token owner by token ID
  * @param tokenId uint256 ID of the token to set the owner for
  * @param tokenOwner address The address of the token owner
  */
  function setTokenOwner(uint256 tokenId, address tokenOwner) private {
    _storage.setAddress(keccak256("tokenOwners", tokenId), tokenOwner);
  }

  /**
  * @dev Internal function to get an approved address for a token
  * @param tokenId uint256 ID of the token to get the approved address for
  * @return address The approved address for the token
  */
  function getTokenApproval(uint256 tokenId) private view returns (address) {
    return _storage.getAddress(keccak256("tokenApprovals", tokenId));
  }

  /**
  * @dev Internal function to set an approved address for a token
  * @param tokenId uint256 ID of the token to set the approved address for
  * @param approvedAddress address The approved address to set for the token
  */
  function setTokenApproval(uint256 tokenId, address approvedAddress) private {
    _storage.setAddress(keccak256("tokenApprovals", tokenId), approvedAddress);
  }

  /**
  * @dev Internal function to increment an owner's token balance by 1
  * @param owner address The owner's address
  */
  function incrementOwnerBalance(address owner) private {
    _storage.setUint(keccak256("ownerBalances", owner), balanceOf(owner).add(1));
  }

  /**
  * @dev Internal function to decrement an owner's token balance by 1
  * @param owner address The owner's address
  */
  function decrementOwnerBalance(address owner) private {
    _storage.setUint(keccak256("ownerBalances", owner), balanceOf(owner).sub(1));
  }

  /**
  * @dev Internal function to set an ID value within a list of owned token ID's
  * @param owner address The owner of the token list
  * @param tokenIndex uint256 The index to set within the owned token list
  * @param tokenId uint256 The ID of the token to set
  */
  function setOwnedToken(address owner, uint256 tokenIndex, uint256 tokenId) private {
    _storage.setUint(keccak256("ownedTokens", owner, tokenIndex), tokenId);
  }

  /**
  * @dev Internal function to append an ID value to a list of owned token ID's
  * @param owner address The owner of the token list
  * @param tokenId uint256 The token ID to append
  */
  function pushOwnedToken(address owner, uint256 tokenId) private {
    _storage.setUint(keccak256("ownedTokens", owner, balanceOf(owner)), tokenId);
    incrementOwnerBalance(owner);
  }

  /**
  * @dev Internal function to get an ID value from list of owned token ID's
  * @param owner address The owner of the token list
  * @param tokenIndex uint256 The index of the token ID value within the list
  * @return uint256 The token ID for the given owner and token index
  */
  function getOwnedToken(address owner, uint256 tokenIndex) private view returns (uint256) {
    return _storage.getUint(keccak256("ownedTokens", owner, tokenIndex));
  }

  /**
  * @dev Internal function to get the index of a token ID within the owned tokens list
  * @param tokenId uint256 ID of the token to get the index for
  * @return uint256 The index of the token for the given ID
  */
  function getOwnedTokenIndex(uint256 tokenId) private view returns (uint256) {
    return _storage.getUint(keccak256("ownedTokensIndex", tokenId));
  }

  /**
  * @dev Internal function to set the index of a token ID within the owned tokens list
  * @param tokenId uint256 ID of the token to set the index for
  * @param tokenIndex uint256 The token index to set for the given token ID
  */
  function setOwnedTokenIndex(uint256 tokenId, uint256 tokenIndex) private {
    _storage.setUint(keccak256("ownedTokensIndex", tokenId), tokenIndex);
  }

  /**
  * @dev Guarantees msg.sender is owner of the given token
  * @param _tokenId uint256 ID of the token to validate its ownership belongs to msg.sender
  */
  modifier onlyOwnerOf(uint256 _tokenId) {
    require(ownerOf(_tokenId) == msg.sender);
    _;
  }

  /**
  * @dev Gets the total amount of tokens stored by the contract
  * @return uint256 representing the total amount of tokens
  */
  function totalSupply() public view returns (uint256) {
    return _storage.getUint("totalTokens");
  }

  /**
  * @dev Gets the balance of the specified address
  * @param _owner address to query the balance of
  * @return uint256 representing the amount owned by the passed address
  */
  function balanceOf(address _owner) public view returns (uint256) {
    return _storage.getUint(keccak256("ownerBalances", _owner));
  }

  /**
  * @dev Gets the list of tokens owned by a given address
  * @param _owner address to query the tokens of
  * @return uint256[] representing the list of tokens owned by the passed address
  */
  function tokensOf(address _owner) public view returns (uint256[]) {
    uint256 _ownerBalance = balanceOf(_owner);
    uint256[] memory _tokens = new uint256[](_ownerBalance);
    for (uint i = 0; i < _ownerBalance; i++) {
      _tokens[i] = getOwnedToken(_owner, i);
    }
    return _tokens;
  }

  /**
  * @dev Gets the owner of the specified token ID
  * @param _tokenId uint256 ID of the token to query the owner of
  * @return owner address currently marked as the owner of the given token ID
  */
  function ownerOf(uint256 _tokenId) public view returns (address) {
    address owner = getTokenOwner(_tokenId);
    require(owner != address(0));
    return owner;
  }

  /**
   * @dev Gets the approved address to take ownership of a given token ID
   * @param _tokenId uint256 ID of the token to query the approval of
   * @return address currently approved to take ownership of the given token ID
   */
  function approvedFor(uint256 _tokenId) public view returns (address) {
    return getTokenApproval(_tokenId);
  }

  /**
  * @dev Transfers the ownership of a given token ID to another address
  * @param _to address to receive the ownership of the given token ID
  * @param _tokenId uint256 ID of the token to be transferred
  */
  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    clearApprovalAndTransfer(msg.sender, _to, _tokenId);
  }

  /**
  * @dev Approves another address to claim for the ownership of the given token ID
  * @param _to address to be approved for the given token ID
  * @param _tokenId uint256 ID of the token to be approved
  */
  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    address owner = ownerOf(_tokenId);
    require(_to != owner);
    if (approvedFor(_tokenId) != 0 || _to != 0) {
      setTokenApproval(_tokenId, _to);
      Approval(owner, _to, _tokenId);
    }
  }

  /**
  * @dev Claims the ownership of a given token ID
  * @param _tokenId uint256 ID of the token being claimed by the msg.sender
  */
  function takeOwnership(uint256 _tokenId) public {
    require(isApprovedFor(msg.sender, _tokenId));
    clearApprovalAndTransfer(ownerOf(_tokenId), msg.sender, _tokenId);
  }

  /**
  * @dev Mint token function
  * @param _to The address that will own the minted token
  * @param _tokenId uint256 ID of the token to be minted by the msg.sender
  */
  function _mint(address _to, uint256 _tokenId) internal {
    require(_to != address(0));
    addToken(_to, _tokenId);
    Transfer(0x0, _to, _tokenId);
  }

  /**
  * @dev Burns a specific token
  * @param _tokenId uint256 ID of the token being burned by the msg.sender
  */
  function _burn(uint256 _tokenId) onlyOwnerOf(_tokenId) internal {
    if (approvedFor(_tokenId) != 0) {
      clearApproval(msg.sender, _tokenId);
    }
    removeToken(msg.sender, _tokenId);
    Transfer(msg.sender, 0x0, _tokenId);
  }

  /**
   * @dev Tells whether the msg.sender is approved for the given token ID or not
   * This function is not private so it can be extended in further implementations like the operatable ERC721
   * @param _owner address of the owner to query the approval of
   * @param _tokenId uint256 ID of the token to query the approval of
   * @return bool whether the msg.sender is approved for the given token ID or not
   */
  function isApprovedFor(address _owner, uint256 _tokenId) internal view returns (bool) {
    return approvedFor(_tokenId) == _owner;
  }

  /**
  * @dev Internal function to clear current approval and transfer the ownership of a given token ID
  * @param _from address which you want to send tokens from
  * @param _to address which you want to transfer the token to
  * @param _tokenId uint256 ID of the token to be transferred
  */
  function clearApprovalAndTransfer(address _from, address _to, uint256 _tokenId) internal {
    require(_to != address(0));
    require(_to != ownerOf(_tokenId));
    require(ownerOf(_tokenId) == _from);

    clearApproval(_from, _tokenId);
    removeToken(_from, _tokenId);
    addToken(_to, _tokenId);
    Transfer(_from, _to, _tokenId);
  }

  /**
  * @dev Internal function to clear current approval of a given token ID
  * @param _tokenId uint256 ID of the token to be transferred
  */
  function clearApproval(address _owner, uint256 _tokenId) private {
    require(ownerOf(_tokenId) == _owner);
    setTokenApproval(_tokenId, 0);
    Approval(_owner, 0, _tokenId);
  }

  /**
  * @dev Internal function to add a token ID to the list of a given address
  * @param _to address representing the new owner of the given token ID
  * @param _tokenId uint256 ID of the token to be added to the tokens list of the given address
  */
  function addToken(address _to, uint256 _tokenId) private {
    require(getTokenOwner(_tokenId) == address(0));
    setTokenOwner(_tokenId, _to);
    uint256 length = balanceOf(_to);
    pushOwnedToken(_to, _tokenId);
    setOwnedTokenIndex(_tokenId, length);
    incrementTotalTokens();
  }

  /**
  * @dev Internal function to remove a token ID from the list of a given address
  * @param _from address representing the previous owner of the given token ID
  * @param _tokenId uint256 ID of the token to be removed from the tokens list of the given address
  */
  function removeToken(address _from, uint256 _tokenId) private {
    require(ownerOf(_tokenId) == _from);

    uint256 tokenIndex = getOwnedTokenIndex(_tokenId);
    uint256 lastTokenIndex = balanceOf(_from).sub(1);
    uint256 lastToken = getOwnedToken(_from, lastTokenIndex);

    setTokenOwner(_tokenId, 0);
    setOwnedToken(_from, tokenIndex, lastToken);
    setOwnedToken(_from, lastTokenIndex, 0);
    // Note that this will handle single-element arrays. In that case, both tokenIndex and lastTokenIndex are going to
    // be zero. Then we can make sure that we will remove _tokenId from the ownedTokens list since we are first swapping
    // the lastToken to the first position, and then dropping the element placed in the last position of the list

    decrementOwnerBalance(_from);
    setOwnedTokenIndex(_tokenId, 0);
    setOwnedTokenIndex(lastToken, tokenIndex);
    decrementTotalTokens();
  }
}
