let provider;
let signer;
let chronoTokenContract;
let mageNFTContract;
let battleManagerContract;

// ADDRESSES (replace these with your deployed addresses)
const chronoTokenAddress = "0xBE840974AC22Dfe61BED1c2c01E78D70d9386486";
const mageNFTAddress = "0xD8dCB6a2D0C514F26bF114ECA086C61146a6CA38";
const battleManagerAddress = "0x89ec6551e89AD74289C2Db455dF615722928b9c6";

// ABIs
let chronoTokenAbi;
let mageNFTAbi;
let battleManagerAbi;

// Load ABIs
async function loadAbis() {
    chronoTokenAbi = await fetch('./abi/ChronoToken.json').then(res => res.json());
    mageNFTAbi = await fetch('./abi/MageNFT.json').then(res => res.json());
    battleManagerAbi = await fetch('./abi/BattleManager.json').then(res => res.json());
}

async function connectWallet() {
    if (typeof window.ethereum !== 'undefined') {
        try {
            // Request account access if needed
            await window.ethereum.request({ method: 'eth_requestAccounts' });

            // Now initialize ethers Web3Provider and signer
            provider = new ethers.providers.Web3Provider(window.ethereum);
            signer = provider.getSigner();

            // Get the connected wallet's address
            const address = await signer.getAddress();
            document.getElementById("status").innerText = "Wallet connected: " + address;

            // Initialize contracts with signer
            chronoTokenContract = new ethers.Contract(chronoTokenAddress, chronoTokenAbi, signer);
            mageNFTContract = new ethers.Contract(mageNFTAddress, mageNFTAbi, signer);
            battleManagerContract = new ethers.Contract(battleManagerAddress, battleManagerAbi, signer);

            // Update token balance and NFT balance
            updateBalances();
        } catch (error) {
            console.error("Error connecting to MetaMask", error);
            alert("Please make sure you have MetaMask installed and connected.");
        }
    } else {
        alert('Please install MetaMask!');
    }
}

async function updateBalances() {
    const address = await signer.getAddress();

    // Update ChronoToken balance
    const tokenBalance = await chronoTokenContract.balanceOf(address);
    document.getElementById('tokenBalance').innerText = ethers.formatEther(tokenBalance);

    // Update Mage NFT balance
    const nftBalance = await mageNFTContract.balanceOf(address);
    document.getElementById('nftBalance').innerText = nftBalance.toString();
}

async function mintToken() {
    const amount = prompt("Enter amount of ChronoTokens to mint:");
    if (amount) {
        const tx = await chronoTokenContract.mint(await signer.getAddress(), ethers.parseEther(amount));
        await tx.wait();
        updateBalances();
    }
}

async function burnToken() {
    const amount = prompt("Enter amount of ChronoTokens to burn:");
    if (amount) {
        const tx = await chronoTokenContract.burn(ethers.parseEther(amount));
        await tx.wait();
        updateBalances();
    }
}

async function mintMageNFT(element) {
    if (window.ethereum) {
        const tx = await mageNFTContract.mintMage(element);
        await tx.wait();
        alert("Mage NFT minted successfully!");
    }
}

async function startBattle(mageId, bossId, moves) {
    try {
        const movesBytes = moves.map(move => ethers.utils.formatBytes32String(move));

        const tx = await battleManagerContract.fightBoss(mageId, bossId, movesBytes);
        await tx.wait();

        console.log('Battle completed successfully');
        alert("Battle completed successfully!");
    } catch (error) {
        console.error('Error in battle:', error);
        alert("An error occurred during the battle.");
    }
}

// Event listeners for buttons
document.getElementById('connectWallet').onclick = connectWallet;
document.getElementById('mintToken').onclick = mintToken;
document.getElementById('burnToken').onclick = burnToken;
document.getElementById('startBattle').onclick = startBattle;
