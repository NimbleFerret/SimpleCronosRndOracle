// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IRandomWrapper.sol";
import "./Ownable.sol";

contract RandomOracle is Ownable {
    address private externalServiceSecret;
    uint256 private randNonce = 0;

    struct Request {
        uint256 min;
        uint256 max;
    }

    struct Response {
        address callerAddress;
        uint256 randomNumber;
    }

    mapping(uint256 => Request) private pendingRequests;
    mapping(uint256 => Response[]) private idToResponses;

    event RandomNumberRequested(
        address callerAddress,
        uint256 id,
        uint256 min,
        uint256 max
    );
    event RandomNumberReturned(
        uint256 randomNumber,
        address callerAddress,
        uint256 id
    );

    function setExternalServiceSecret(address secret) external onlyOwner {
        externalServiceSecret = secret;
    }

    function generateRandomIntInRange(uint256 min, uint256 max)
        external
        returns (uint256)
    {
        require(
            min > 0 && max > 0,
            "Random number should be greater than zero."
        );
        require(max > min, "Max value should be more than min.");

        randNonce++;
        uint256 id = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce))
        ) % 1000;
        pendingRequests[id] = Request(min, max);

        emit RandomNumberRequested(msg.sender, id, min, max);

        return id;
    }

    function returnRandomNumber(
        address secret,
        uint256 randomNumber,
        address callerAddress,
        uint256 id
    ) external {
        require(secret == externalServiceSecret, "Unauthorized.");
        require(
            pendingRequests[id].min > 0 && pendingRequests[id].max > 0,
            "Request not found."
        );
        require(
            randomNumber >= pendingRequests[id].min &&
                randomNumber <= pendingRequests[id].max,
            "Bad data from external service."
        );

        delete pendingRequests[id];

        IRandomWrapper(callerAddress).fulfillRandomNumberRequest(
            randomNumber,
            id
        );
    }
}
