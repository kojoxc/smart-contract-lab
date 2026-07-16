// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Auth {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setOwner(
        address _owner
    ) external {
        require(msg.sender == owner, "not auhtorized");
        owner = _owner;
    }
}
