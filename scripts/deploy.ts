// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers } from "hardhat";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');
  const routerAddress = "0xe592427a0aece92de3edee1f18e0157c05861564"; //rinkeby swapRouter address
  // We get the contract to deploy
  const Swapper = await ethers.getContractFactory("Swapper");
  const swapper = await Swapper.deploy(routerAddress);

  await swapper.deployed();

  console.log("Swapper deployed to:", swapper.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
