// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract MyNFT is ERC721URIStorage, Ownable {
    constructor() ERC721("Akash","Aka"){}

    function mintNFT(address recipient,string memory tokenURI,uint256 _tokenIds) external onlyOwner{
        _mint(recipient, _tokenIds);
        _setTokenURI(_tokenIds,tokenURI);
    }
}
