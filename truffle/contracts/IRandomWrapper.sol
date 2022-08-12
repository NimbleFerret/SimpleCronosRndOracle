// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRandomWrapper {
    function fulfillRandomNumberRequest(uint256 randomNumber, uint256 id)
        external;
}
