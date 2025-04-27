// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BattleManager {
    // Define the ChronoToken and MageNFT contract interfaces
    IERC20 public chronoToken;
    IERC721 public mageNFT;

    struct Boss {
        string name;
        uint256 health;
        string[] moves;
    }

    struct Mage {
        string name;
        uint256 health;
        string[] moves;
    }

    // Mapping of boss IDs to Boss struct
    mapping(uint256 => Boss) public bosses;
    
    // Mapping of mage IDs to Mage struct
    mapping(uint256 => Mage) public mages;

    event BattleResult(uint256 mageId, uint256 bossId, bool win, uint256 rewards);

    constructor(address _chronoTokenAddress, address _mageNFTAddress) {
        chronoToken = IERC20(_chronoTokenAddress);
        mageNFT = IERC721(_mageNFTAddress);
    }

    // Set Boss moves (can be expanded)
    function setBoss(uint256 bossId, string memory name, uint256 health, string[] memory moves) public {
        bosses[bossId] = Boss(name, health, moves);
    }

    // Set Mage moves (can be expanded)
    function setMage(uint256 mageId, string memory name, uint256 health, string[] memory moves) public {
        mages[mageId] = Mage(name, health, moves);
    }

    // Start battle between Mage and Boss
    function fightBoss(uint256 mageId, uint256 bossId, string[] memory mageMoves) public {
        require(mageNFT.ownerOf(mageId) == msg.sender, "You do not own this Mage NFT");
        Boss storage boss = bosses[bossId];
        Mage storage mage = mages[mageId];

        require(boss.health > 0, "Boss does not exist");
        require(mage.health > 0, "Mage does not exist");

        uint256 mageScore = calculateScore(mageMoves);
        uint256 bossScore = calculateScore(boss.moves);

        bool win = mageScore >= bossScore;
        
        uint256 rewards = 0;

        if (win) {
            // Reward the user for winning
            rewards = 100 * 10**18; // 100 ChronoTokens as reward
            chronoToken.transfer(msg.sender, rewards);
        }

        emit BattleResult(mageId, bossId, win, rewards);
    }

    // Calculate score based on moves
    function calculateScore(string[] memory moves) private pure returns (uint256 score) {
        for (uint i = 0; i < moves.length; i++) {
            score += uint256(keccak256(abi.encodePacked(moves[i]))) % 10;
        }
    }
}
