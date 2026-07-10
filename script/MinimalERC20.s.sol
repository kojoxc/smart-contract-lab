// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MinimalERC20} from "../src/MinimalERC20.sol";

contract MinimalERC20_Deploy is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address deployerWallet = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        // address tokenAddress = vm.envAddress("TOKEN_ADDRESS");

        MinimalERC20 token = new MinimalERC20("DOG WIF HAT", "WIF");

        // address receipt = vm.envAddress("PURPOSE_ADDRESS");

        uint256 amount = 1e9 * 1e18;

        // vm.startBroadcast(deployerPrivateKey);

        token.mint(deployerWallet, amount);

        vm.stopBroadcast();
    }
}
