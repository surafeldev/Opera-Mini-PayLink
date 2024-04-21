// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract UserSignup {
    struct User {
        uint256 id;
        string name;
        string email;
    }

    mapping(address => User) public users;
    mapping(uint256 => address) public userIdToAddress; 
    uint256 public nextUserId;

    event UserSignedUp(uint256 id, string name, string email);

    function signup(string memory name, string memory email) public {
        require(bytes(name).length > 0, "Name is required");
        require(bytes(email).length > 0, "Email is required");
        require(users[msg.sender].id == 0, "User already signed up");

        nextUserId++;
        users[msg.sender] = User(nextUserId, name, email);
        userIdToAddress[nextUserId] = msg.sender; 

        emit UserSignedUp(nextUserId, name, email);
    }

    function getUserById(uint256 id) public view returns (User memory) {
        require(id > 0 && id <= nextUserId, "Invalid user id");
        return users[userIdToAddress[id]];
    }

    function getUserByAddress(address userAddress) public view returns (User memory) {
        require(users[userAddress].id > 0, "User does not exist");
        return users[userAddress];
    }

    function getAllUsers() public view returns (User[] memory) {
        User[] memory userList = new User[](nextUserId);
        for (uint256 i = 1; i <= nextUserId; i++) {
            userList[i - 1] = users[userIdToAddress[i]];
        }
        return userList;
    }

    function registerUser(address userId, MinipayData calldata minipay) external;{
        require(users[userId].id == 0, "User already signed up");
        nextUserId++;
        
        users[userId] = User(nextUserId, minipay.name, minipay.email);
        userIdToAddress[nextUserId] = userId;
        emit UserSignedUp(nextUserId, minipay.name, minipay.email);

    }

    function isUserRegistered(string memory name, string memory email, string memory password) public view returns (bool) { 
        for (uint256 i = 1; i <= nextUserId; i++) {
            User memory user = users[userIdToAddress[i]];
            if (keccak256(bytes(user.name)) == keccak256(bytes(name)) && keccak256(bytes(user.email)) == keccak256(bytes(email)) && keccak256(bytes(user.password)) == keccak256(bytes(password))) {
                return true;
            }
        }
        return false;
    }
  

}
