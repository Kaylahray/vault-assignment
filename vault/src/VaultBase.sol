// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VaultBase {
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    mapping(address => uint256) public balances;

    // Allow the contract to receive ETH
    receive() external payable {}
} 