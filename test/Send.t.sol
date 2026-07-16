// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test, console2, stdError } from "forge-std/Test.sol";
import { ERC20 } from "../src/Send.sol";

contract SendTest is Test {
    ERC20 token = new ERC20();

    function test_SendETH() external {
        // Set ETH Balance
        deal(address(0x123), 5 ether);
        assertEq(address(0x123).balance, 5 ether);

        // Set ERC20 balance
        deal(address(token), address(0x123), 10);
        assertEq(token.balanceOf(address(0x123)), 10);
    }
}
