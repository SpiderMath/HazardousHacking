const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy ChronoToken, PASS deployer's address to constructor
    const ChronoTokenFactory = await ethers.getContractFactory("ChronoToken");
    const chronoToken = await ChronoTokenFactory.deploy(deployer.address);
    await chronoToken.waitForDeployment();
    console.log("ChronoToken deployed to:", chronoToken.target);

    // Deploy MageNFT
    const MageNFTFactory = await ethers.getContractFactory("MageNFT");
    const mageNFT = await MageNFTFactory.deploy();
    await mageNFT.waitForDeployment();
    console.log("MageNFT deployed to:", mageNFT.target);

    // Deploy BattleManager
    const BattleManagerFactory = await ethers.getContractFactory("BattleManager");
    const battleManager = await BattleManagerFactory.deploy(mageNFT.target, chronoToken.target);
    await battleManager.waitForDeployment();
    console.log("BattleManager deployed to:", battleManager.target);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
