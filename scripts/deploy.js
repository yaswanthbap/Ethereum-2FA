const hre = require("hardhat");

async function main() {


  const TwoFactorAuthentication = await hre.ethers.getContractFactory("TwoFactorAuthentication");
  const twoFactorAuthentication = await TwoFactorAuthentication.deploy();

  await twoFactorAuthentication.deployed();//deploying smart contract

  console.log("Deployed contract address:",`${twoFactorAuthentication.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

