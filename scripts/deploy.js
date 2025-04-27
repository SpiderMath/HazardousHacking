// Import necessary libraries
const { ethers } = require("hardhat");

async function main() {
    // Get the deployer's address (account that will deploy the contracts)
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy ChronoToken contract
    const ChronoToken = await ethers.getContractFactory("ChronoToken");
    const chronoToken = await ChronoToken.deploy();
    console.log("ChronoToken deployed to:", chronoToken.address);

    // Deploy MageNFT contract
    const MageNFT = await ethers.getContractFactory("MageNFT");
    const mageNFT = await MageNFT.deploy();
    console.log("MageNFT deployed to:", mageNFT.address);

    // Deploy BattleManager contract and link it to the deployed MageNFT and ChronoToken addresses
    const BattleManager = await ethers.getContractFactory("BattleManager");
    const battleManager = await BattleManager.deploy(mageNFT.address, chronoToken.address);
    console.log("BattleManager deployed to:", battleManager.address);

    // Optionally, transfer ownership of the contracts (if you have an Ownable contract)
    // await mageNFT.transferOwnership(deployer.address);
    // await chronoToken.transferOwnership(deployer.address);
    // await battleManager.transferOwnership(deployer.address);
}

// Run the deployment script
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
