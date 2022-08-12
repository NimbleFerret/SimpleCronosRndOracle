// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRandomOracle {
    function generateRandomIntInRange(uint256 min, uint256 max)
        external
        returns (uint256);
}
