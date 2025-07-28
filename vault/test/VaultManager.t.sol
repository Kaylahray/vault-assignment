// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/VaultManager.sol";

contract VaultManagerTest is Test {
    VaultManager public vault;
    address user1 = address(1);
    address user2 = address(2);

    function setUp() public {
        vault = new VaultManager();
    }

    function testDeposit() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        vault.deposit{value: 1 ether}();
        assertEq(vault.balances(user1), 1 ether);
        vm.stopPrank();
    }

    function test_RevertWhen_DepositIsZero() public {
        vm.prank(user1);
        vm.expectRevert("Deposit amount must be greater than 0");
        vault.deposit{value: 0}();
    }

    function testWithdraw() public {
        // Setup: Give user1 some ETH and let them deposit
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        vault.deposit{value: 1 ether}();
        
        // Record balances before withdrawal
        uint256 vaultBalanceBefore = address(vault).balance;
        uint256 userBalanceBefore = address(user1).balance;
        
        // Perform withdrawal
        vault.withdraw(0.5 ether);
        
        // Verify balances after withdrawal
        assertEq(vault.balances(user1), 0.5 ether, "User vault balance should be 0.5 ether");
        assertEq(address(vault).balance, vaultBalanceBefore - 0.5 ether, "Vault balance should decrease by 0.5 ether");
        assertEq(address(user1).balance, userBalanceBefore + 0.5 ether, "User balance should increase by 0.5 ether");
        
        vm.stopPrank();
    }

    function test_RevertIf_WithdrawInsufficientBalance() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        vault.deposit{value: 1 ether}();
        vm.expectRevert("Insufficient balance");
        vault.withdraw(1.1 ether);
        vm.stopPrank();
    }

    function test_RevertIf_WithdrawIsZero() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        vault.deposit{value: 1 ether}();
        vm.expectRevert("Withdrawal amount must be greater than 0");
        vault.withdraw(0);
        vm.stopPrank();
    }
} 