// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console2, stdError } from "forge-std/Test.sol";
import { Counter } from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function testInc() external {
        counter.inc();
        assertEq(counter.count(), 1);
    }

    function testFailDec() external {
        // This will fail with underflow
        counter.dec();
    }

    function testDecUnderflow() external {
        vm.expectRevert(stdError.arithmeticError);
        counter.dec();
    }

    function testDec() external {
        counter.inc();
        counter.inc();
        counter.dec();
        assertEq(counter.count(), 1);
    }
}
