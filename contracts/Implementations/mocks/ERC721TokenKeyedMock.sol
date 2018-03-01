pragma solidity ^0.4.18;

import "../token/ERC721/ERC721TokenKeyed.sol";

/**
 * @title ERC721TokenKeyedMock
 * This mock just provides a public mint and burn functions for testing purposes.
 */
contract ERC721TokenKeyedMock is ERC721TokenKeyed {

  function ERC721TokenKeyedMock(BaseStorage storage_) ERC721TokenKeyed(storage_) public { }

  function mint(address _to, uint256 _tokenId) public {
    super._mint(_to, _tokenId);
  }

  function burn(uint256 _tokenId) public {
    super._burn(_tokenId);
  }
}
