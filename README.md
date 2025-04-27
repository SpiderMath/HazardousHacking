# ChronoToken Battle Game

This project implements a decentralized battle game using Ethereum smart contracts. Players can mint tokens, battle with mages, and interact with the blockchain through MetaMask. The game integrates various smart contracts such as `ChronoToken`, `MageNFT`, and `BattleManager` to manage in-game functionality and assets.

## Features
- **Wallet Connection**: Connects to MetaMask using `ethers.js`.
- **ChronoToken**: Mint and burn ChronoTokens for in-game actions.
- **MageNFT**: Mint Mage NFTs, which can be used in battles.
- **BattleManager**: Fight bosses with your Mage NFTs by executing predefined moves.

## Prerequisites

Before you begin, ensure you have the following installed:
- [MetaMask](https://metamask.io/) browser extension
- [Node.js](https://nodejs.org/) (for running the local development server)
- An Ethereum network (Testnet or Mainnet) and deployed smart contracts for `ChronoToken`, `MageNFT`, and `BattleManager`.

## Project Setup

### 1. Clone the repository

```bash
git clone https://github.com/your-username/chrono-battle-game.git
cd chrono-battle-game
```

### 2. Install dependencies
```bash
Copy
Edit
npm install
```

### 3. Deploy Smart Contracts
Deploy the smart contracts for:

ChronoToken (ERC-20 Token)

MageNFT (ERC-721 NFT)

BattleManager (Battle logic)

Ensure you update the app.js with the correct deployed contract addresses and ABIs.

### 4. Start the Local Development Server
Start a local development server to host the frontend:

```bash
Copy
Edit
npm start
```
This will open the app in your browser, and you will be able to interact with the smart contracts via MetaMask.

## Contract Details
The project contains the following contracts:

ChronoToken.sol: ERC-20 token for in-game currency.

MageNFT.sol: ERC-721 contract for creating Mage NFTs.

BattleManager.sol: Logic to manage battles, including interactions with Mages and bosses.

## Smart Contract ABIs
You can find the contract ABIs in the abi/ folder. These ABIs are needed to interact with the deployed contracts using ethers.js.

## How to Use the App
Connect Wallet: Click the "Connect Wallet" button to connect MetaMask.

Mint Tokens: You can mint ChronoTokens by entering the amount.

Mint Mage NFTs: Use the mint button to create new Mage NFTs.

Start Battle: Select your Mage NFT and start a battle against a boss using predefined moves.

Example:
To start a battle, follow these steps:

Mint a Mage NFT.

Select a boss.

Choose the moves you want to execute (attack, heal, etc.).

Start the battle and watch the outcome!

## Known Issues
MetaMask wallet connection may fail if not properly configured.

The BattleManager contract may fail with certain invalid inputs (ensure moves and Mage ID are valid).

## Contributing
Feel free to fork the repository and submit pull requests to improve the game functionality, fix bugs, or add new features.

## License
This project is licensed under the MIT License.
