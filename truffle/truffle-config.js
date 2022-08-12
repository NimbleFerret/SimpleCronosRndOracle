require("dotenv").config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

const getHDWallet = () => {
  for (const env of [process.env.MNEMONIC, process.env.PRIVATE_KEY]) {
    if (env && env !== "") {
      return env;
    }
  }
  throw Error("Private Key Not Set! Please set up .env");
}

module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
    },
    cronos: {
      provider: new HDWalletProvider(getHDWallet(), "https://evm-t3.cronos.org"),
      network_id: "*",
      skipDryRun: true
    },
  },
  compilers: {
    solc: {
      version: "0.8.0",
    }
  },
  db: {
    enabled: false
  }
};
