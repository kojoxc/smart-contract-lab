// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console2, stdError } from "forge-std/Test.sol";
import { Error } from "../src/Error.sol";

contract ErrorTest is Test {
    Error public err;

    function setUp() public {
        err = new Error();
    }

    // intentionally made an error
    function testFail() external {
        err.throwError();
    }

    function testExpectRevert() external {
        vm.expectRevert();
        err.throwError();
    }

    function testRequireMessage() external {
        vm.expectRevert(bytes("not authorized"));
        err.throwError();
    }

    // Add label to assertions
    function testErrorLabel() external {
        assertEq(uint256(1), uint256(1), "test 1");
        assertEq(uint256(2), uint256(2), "test 2");
        assertEq(uint256(3), uint256(3), "test 3");
    }
}
