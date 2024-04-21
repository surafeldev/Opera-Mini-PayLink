// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./UserSignup.sol";

contract UserLogin {

    UserSignup private userSignupContract;

    constructor(address userSignupAddress) {
        userSignupContract = UserSignup(userSignupAddress);
    }

    function login(string memory name, string memory password, string memory email) public view returns (bool) {        

        if (userSignupContract.isUserRegistered(name, password, email)) {
            return true;
        } else {
            return false;
        }
    }
}
