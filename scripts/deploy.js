const hre = require("hardhat");

async function main() {
  const election = await hre.ethers.deployContract("Election", [], {});

  await election.waitForDeployment();

  console.log(`Deploy success on contract election ${election.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
