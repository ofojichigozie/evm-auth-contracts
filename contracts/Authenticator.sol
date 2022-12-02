// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "./SecureAccessToken.sol";

contract Authenticator is Ownable {
    SecureAccessToken public secureAccessToken;

    struct User {
        string name;
        uint256 createdAt;
    }

    mapping(address => User) private users;
    mapping(address => bool) private isRegistered;

    event Registered(address indexed user);

    constructor(address _secureAccessToken) {
        secureAccessToken = SecureAccessToken(_secureAccessToken);
    }

    function register(string memory name, bytes memory signature) external {
        address signer = getSigner(msg.sender, name, signature);
        require(signer == msg.sender, "Authenticator: unauthorized signer");
        require(
            !isRegistered[msg.sender],
            "Authenticator: user already registered"
        );

        User storage gamer = users[msg.sender];
        gamer.name = name;
        gamer.createdAt = block.timestamp;

        isRegistered[msg.sender] = true;

        secureAccessToken.mint(msg.sender);
        emit Registered(msg.sender);
    }

    function login(
        address account,
        string memory name,
        bytes memory signature
    ) external view returns (bool) {
        address signer = getSigner(account, name, signature);
        require(signer == account, "Authenticator: unauthorized signer");
        require(isRegistered[account], "Authenticator: user not registered");
        User memory user = users[account];
        require(
            keccak256(abi.encodePacked(user.name)) ==
                keccak256(abi.encodePacked((name))),
            "Authenticator: wrong username"
        );
        return isRegistered[account];
    }

    function getSigner(
        address account,
        string memory name,
        bytes memory signature
    ) internal view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(account, name, address(this))
        );
        bytes32 message = ECDSA.toEthSignedMessageHash(hash);
        address signer = ECDSA.recover(message, signature);
        return signer;
    }

    function getUser(address account) external view returns (User memory) {
        User storage user = users[account];
        return user;
    }
}
