// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console2, stdError } from "forge-std/Test.sol";
import { Event } from "../src/Event.sol";

contract EventTest is Test {
    Event public ev;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        ev = new Event();
    }

    function test_EmitTransferEvent() external {
        // function expectEmit(
        //     bool checkTopic1,
        //     bool checkTopic2,
        //     bool checkTopic3,
        //     bool checkData
        // ) external;

        // 1. Tell Foundry which data to check
        // Check index 1, index 2 and data

        vm.expectEmit(true, true, false, true);
        // 2. Emit the expected event
        emit Transfer(address(this), address(0x123), 456);
        ev.transfer(address(this), address(0x123), 456);

        // check only index 1
        vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(0x123), 456);
        // NOTE: index 2 and data (amount) doesn't match
        //       but the test will still pass
        ev.transfer(address(this), address(111), 222);
    }

    function test_EmitManyTransferEvent() external {
        address[] memory to = new address[](2);
        to[0] = address(0x123);
        to[1] = address(0x456);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 1234;
        amounts[1] = 5678;

        for (uint256 i; i < to.length; i++) {
            // 1. Tell Foundry which data to check
            vm.expectEmit(true, true, false, true);
            // 2. Emit the expected event
            emit Transfer(address(this), to[i], amounts[i]);
        }

        ev.transferMany(address(this), to, amounts);
    }
}
