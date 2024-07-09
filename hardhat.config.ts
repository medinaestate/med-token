import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

import { env } from "./env";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    mainnet: {
      url: `https://eth-mainnet.g.alchemy.com/v2/${env.ALCHEMY_API_KEY}`,
      accounts: [
        env.OWNER,
        env.SALES,
        env.TEAM,
        env.INCENTIVES,
        env.LIQUIDITY,
        env.MARKETING,
        env.TREASURY,
      ],
    },
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${env.ALCHEMY_API_KEY}`,
      accounts: [
        env.OWNER_TEST,
        env.SALES_TEST,
        env.TEAM_TEST,
        env.INCENTIVES_TEST,
        env.LIQUIDITY_TEST,
        env.MARKETING_TEST,
        env.TREASURY_TEST,
      ],
    },
  },
  etherscan: {
    apiKey: env.ETHERSCAN_API_KEY,
  },
  sourcify: {
    enabled: true,
  },
};

export default config;
