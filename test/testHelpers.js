const { ethers } = require("hardhat");

const constants = {
    ZERO_ADDRESS: '0x0000000000000000000000000000000000000000'
}

const time = {
    advanceBlock: async () => {
        await ethers.provider.send('evm_mine');
    },

    advanceTime: async (time) => {
        await ethers.provider.send('evm_increaseTime', [time]);
    },

    advanceTimeAndBlock: async function (time) {
        await this.advanceTime(time)
        await this.advanceBlock()
    }
}

module.exports = { constants, time }