// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library Math {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "Math: addition overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Math: subtraction overflow");
        uint256 c = a - b;
        return c;
    }
} 