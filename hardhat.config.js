require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.21", // or whatever you used
  networks: {
    monad: {
      url: "https://testnet-rpc.monad.xyz", // Monad Testnet RPC URL
      accounts: [ "AIN'T NO ONE GETTING THE PRIVATE KEY" ]
    }
  }
};
