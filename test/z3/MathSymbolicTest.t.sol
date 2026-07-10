// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";

contract MathSymbolicTest is Test {
    function test_CheckAverage(uint256 a, uint256 b) external pure {
        // uint256 average;
        uint256 min = a <= b ? a : b;
        uint256 max = a > b ? a : b;

        //  unchecked {
        //     average = min + (min - max) / 2;
        //  }

        uint256 average = min + (max - min) / 2;

        // assertGe(average, a <= b ? a : b);
        assertGe(average, min);
    }
}
