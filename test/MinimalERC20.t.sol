// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {MinimalERC20} from "../src/MinimalERC20.sol";

contract MinimalERC20Test is Test {
    MinimalERC20 internal token;

    address internal alice = address(0xA11CE);
    address internal attacker = address(0xB0B);

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
        vm.prank(attacker);
        vm.expectRevert(MinimalERC20.Unauthorized.selector);
        token.mint(attacker, 100 ether);

        assertEq(token.balanceOf(attacker), 0);
        assertEq(token.totalSupply(), 0);
    }
}
