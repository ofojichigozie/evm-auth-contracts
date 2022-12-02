const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");
const { BigNumber } = require("@ethersproject/bignumber");
const { time } = require("./testHelpers");

const utils = {
  toWei: (value) => {
    return ethers.utils.parseEther(value.toString())
  },
  fromWei: (value) => {
    value = BigNumber.from(value.toString());
    return ethers.utils.formatEther(value)
  }
}

describe("Authenticator", () => {

  beforeEach(async () => {
    provider = waffle.provider;
    [owner, alice, bob, carol] = await ethers.getSigners();
  })

  describe('Deployment', () => {
    
  });

})
