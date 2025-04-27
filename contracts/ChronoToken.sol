// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ChronoToken is ERC20, Ownable() {
    // Constructor to set the token name and symbol, and assign ownership to msg.sender
    constructor() ERC20("ChronoToken", "CHRONO") Ownable {
        // Minting an initial supply to the deployer (msg.sender)
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    // Mint new tokens (only the owner can do this)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens from the sender's balance (optional functionality)
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
