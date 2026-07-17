// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

contract SignTest is Test {
    // private key = 123
    // public key = vm.addr(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign(private key, message hash)
    function test_Signature() external {
        uint256 privateKey = 123;
        // address privateKey (PublicKey)
        address alice = vm.addr(privateKey);

        // Test valid signature
        bytes32 messageHash = keccak256("Signed by Alice");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);
        address signer = ecrecover(messageHash, v, r, s);

        assertEq(signer, alice);

        // Test invalid message
        bytes32 invalidHash = keccak256("Signed by Bob");
        signer = ecrecover(invalidHash, v, r, s);

        assertTrue(signer != alice);
    }
}
