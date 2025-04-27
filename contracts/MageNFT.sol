// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MageNFT is ERC721Enumerable, Ownable {
    uint256 public nextTokenId;

    enum Element { Fire, Water, Earth, Air }

    struct Mage {
        Element element;
        uint256 strength;
    }

    mapping(uint256 => Mage) public mages;

    constructor() ERC721("MageNFT", "MAGE") Ownable(msg.sender) {}

    function mintMage(Element element) external {
        uint256 tokenId = nextTokenId++;
        _safeMint(msg.sender, tokenId);
        mages[tokenId] = Mage(element, randomStrength());
    }

    function randomStrength() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % 100 + 1;
    }

    function getMage(uint256 tokenId) external view returns (Element, uint256) {
        Mage memory mage = mages[tokenId];
        return (mage.element, mage.strength);
    }

}
