// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IRandomOracle.sol";
import "./Ownable.sol";

contract RandomWrapper is Ownable {
    IRandomOracle private randomOracle;

    mapping(uint256 => bool) requests;
    mapping(uint256 => uint256) results;

    event RandomNumberRequested(uint256 id);
    event RandomNumberReceived(uint256 number, uint256 id);

    function setRandomOracleAddress(address newAddress) external onlyOwner {
        randomOracle = IRandomOracle(newAddress);
    }

    function getRandomNumber(uint256 min, uint256 max) external {
        require(
            randomOracle != IRandomOracle(address(0)),
            "Oracle not initialized."
        );

        uint256 id = randomOracle.generateRandomIntInRange(min, max);
        requests[id] = true;

        emit RandomNumberRequested(id);
    }

    function fulfillRandomNumberRequest(uint256 randomNumber, uint256 id)
        external
    {
        require(msg.sender == address(randomOracle), "Unauthorized.");
        require(requests[id], "Request is invalid or already fulfilled.");

        results[id] = randomNumber;
        delete requests[id];

        emit RandomNumberReceived(randomNumber, id);
    }
}
