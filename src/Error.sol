// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Error {
    error notAuthorized();

    function throwError() external {
        require(false, "not authorized");
    }

    function throwCustomError() external {
        revert notAuthorized();
    }
}