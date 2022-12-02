// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SecureAccessToken is ERC20, Ownable {

    constructor() ERC20("Secure Access Token", "SAT") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function mint(address user) public onlyOwner() {
        require(user != address(0), "User must not be zero address");
        _mint(user, 5 * 10 ** decimals());
    }
}