// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { Test } from "forge-std/Test.sol";
import { MinimalERC20 } from "../src/MinimalERC20.sol";

contract MinimalERC20Test is Test {
    MinimalERC20 internal token;

    address internal alice = address(0xA11CE);
    address internal bob = address(0xB0B);
    address internal nad = address(0xC1C);

    function setUp() public {
        token = new MinimalERC20("Minimal Token", "MIN");
    }

    function testMintIncreasesBalanceAndTotalSupply() public {
        token.mint(alice, 100 ether);

        assertEq(token.balanceOf(alice), 100 ether);
        assertEq(token.totalSupply(), 100 ether);
    }

    function testBurnDecreasesBalanceAndTotalSupply() public {
        token.mint(alice, 100 ether);

        vm.prank(alice);
        token.burn(40 ether);

        assertEq(token.balanceOf(alice), 60 ether);
        assertEq(token.totalSupply(), 60 ether);
    }

    function testUnauthorizedMintingReverts() public {
        vm.prank(bob);
        vm.expectRevert(MinimalERC20.Unauthorized.selector);
        token.mint(bob, 100 ether);

        assertEq(token.balanceOf(bob), 0);
        assertEq(token.totalSupply(), 0);
    }

    function test_transferBetweenUsers() public {
        token.mint(alice, 100 ether);

        vm.prank(alice);
        // token.transfer(bob, 50 ether);
        assertTrue(token.transfer(bob, 50 ether));

        assertEq(token.balanceOf(alice), 50 ether);
        assertEq(token.balanceOf(bob), 50 ether);
    }

    function test_transferFromBetweenUsers() public {
        token.mint(alice, 100 ether);

        vm.prank(alice);
        // token.approve(bob, 80 ether);
        assertTrue(token.approve(bob, 80 ether));

        vm.prank(bob);
        // token.transferFrom(alice, nad, 80 ether);
        assertTrue(token.transferFrom(alice, nad, 80 ether));

        assertEq(token.balanceOf(alice), 20 ether);
        assertEq(token.balanceOf(nad), 80 ether);
        assertEq(token.allowance(alice, bob), 0);
    }
}
