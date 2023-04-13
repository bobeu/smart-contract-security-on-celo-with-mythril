import { config as CONFIG } from "dotenv";
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";

CONFIG();

const config: HardhatUserConfig = {
  networks: {
    alfajores: {
      url: process.env.ALFAJORES,
      accounts: [`${process.env.PRIVATE_KEY}`],
      chainId: 44787,
    },
  },

  solidity: {
    version: "0.8.18",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: "byzantium"
      }
    },
};

export default config;
