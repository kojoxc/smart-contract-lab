// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console2, stdError } from "forge-std/Test.sol";
import { Auth } from "../src/Authorization.sol";

contract AuthTest is Test {
    Auth public auth;
    address private alice = address(0x123);

    function setUp() public {
        // owner = this contract
        auth = new Auth();
    }

    function testSetOwner() external {
        auth.setOwner(address(1));

        vm.prank(address(1));
        auth.setOwner(address(alice));

        vm.startPrank(alice);
        auth.setOwner(address(1));
        vm.stopPrank();
    }
}
