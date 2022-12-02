const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  const SecureAccessToken = await hre.ethers.getContractFactory("SecureAccessToken");
  const secureAccessToken = await SecureAccessToken.deploy();
  await secureAccessToken.deployed();

  const Authenticator = await hre.ethers.getContractFactory("Authenticator");
  const authenticator = await Authenticator.deploy(secureAccessToken.address);
  await authenticator.deployed();

  console.log("Secure Access Token (SAT) deployed to:", secureAccessToken.address);
  console.log("Authenticator deployed to:", authenticator.address);
  console.log("Deployer address:", deployer.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
