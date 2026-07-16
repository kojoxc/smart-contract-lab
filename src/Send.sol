// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
}
