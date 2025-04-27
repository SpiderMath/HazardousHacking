// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./MageNFT.sol";
import "./ChronoToken.sol";

contract BattleManager {
    MageNFT public mageNFT;
    ChronoToken public chronoToken;

    // Initialize contract addresses for MageNFT and ChronoToken
    constructor(address _mageNFT, address _chronoToken) {
        mageNFT = MageNFT(_mageNFT);
        chronoToken = ChronoToken(_chronoToken);
    }

    struct Boss {
        string name;
        uint256 health;
        string[5] pattern; // Example pattern: ["attack", "attack", "shield", "attack", "heal"]
    }

    // Store all the bosses
    Boss[] public bosses;

    // Mapping to track the battle status
    mapping(uint256 => bool) public battleInProgress;

    // Add a new boss with a pattern of moves
    function addBoss(string memory name, uint256 health, string[5] memory pattern) public {
        bosses.push(Boss(name, health, pattern));
    }

    // Start a fight with a boss
    function fightBoss(uint256 mageId, uint256 bossId, string[5] memory moves) external {
        require(mageNFT.ownerOf(mageId) == msg.sender, "Not your mage");
        require(!battleInProgress[mageId], "Battle already in progress");
        
        battleInProgress[mageId] = true;

        // Get Mage details (element and strength)
        (MageNFT.Element element, uint256 strength) = mageNFT.getMage(mageId);
        Boss memory boss = bosses[bossId];

        uint256 mageHp = strength;
        uint256 bossHp = boss.health;

        // Battle for 5 turns
        for (uint i = 0; i < 5; i++) {
            // Player's move
            if (keccak256(bytes(moves[i])) == keccak256(bytes("attack"))) {
                bossHp -= 20;
            } else if (keccak256(bytes(moves[i])) == keccak256(bytes("heal"))) {
                mageHp += 10;
            }

            // Boss's move
            if (keccak256(bytes(boss.pattern[i])) == keccak256(bytes("attack"))) {
                mageHp -= 20;
            } else if (keccak256(bytes(boss.pattern[i])) == keccak256(bytes("heal"))) {
                bossHp += 10;
            } else if (keccak256(bytes(boss.pattern[i])) == keccak256(bytes("shield"))) {
                bossHp += 5; // Shield adds 5 HP
            }
        }

        // Determine the winner
        if (mageHp > 0 && bossHp <= 0) {
            // Player wins the battle, reward with ChronoTokens
            chronoToken.transfer(msg.sender, 100 * 10 ** chronoToken.decimals());
        } else if (mageHp <= 0) {
            // Player lost, no reward
            revert("Mage has been defeated");
        }

        // Reset battle status
        battleInProgress[mageId] = false;
    }
}
