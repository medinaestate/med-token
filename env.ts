import "dotenv/config";

export const env = {
  ALCHEMY_API_KEY: process.env.ALCHEMY_API_KEY as string,
  ETHERSCAN_API_KEY: process.env.ETHERSCAN_API_KEY as string,
  OWNER: process.env.OWNER as string,
  SALES: process.env.SALES as string,
  TEAM: process.env.TEAM as string,
  INCENTIVES: process.env.INCENTIVES as string,
  LIQUIDITY: process.env.LIQUIDITY as string,
  MARKETING: process.env.MARKETING as string,
  TREASURY: process.env.TREASURY as string,
  OWNER_TEST: process.env.OWNER_TEST as string,
  SALES_TEST: process.env.SALES_TEST as string,
  TEAM_TEST: process.env.TEAM_TEST as string,
  INCENTIVES_TEST: process.env.INCENTIVES_TEST as string,
  LIQUIDITY_TEST: process.env.LIQUIDITY_TEST as string,
  MARKETING_TEST: process.env.MARKETING_TEST as string,
  TREASURY_TEST: process.env.TREASURY_TEST as string,
};
