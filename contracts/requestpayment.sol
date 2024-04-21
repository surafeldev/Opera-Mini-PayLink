// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PaymentRequest {
    mapping(string => address) private emailToAddress;
    mapping(string => address) private phoneToAddress;
    mapping(string => address) private usernameToAddress;
    mapping(address => uint256) private balances;
    mapping(address => uint256) private transactionCount;
    mapping(address => mapping(uint256 => Transaction)) private transactions;

    struct Transaction {
        address sender;
        address recipient;
        uint256 amount;
        uint256 timestamp;
    }

    event PaymentRequested(address sender, address recipient, uint256 amount);
    event PaymentReceived(address sender, address recipient, uint256 amount);

    function requestPaymentByEmail(string memory email, address recipient, uint256 amount) external {
        require(emailToAddress[email] == address(0), "Email already mapped to an address");
        emailToAddress[email] = recipient;
        emit PaymentRequested (msg.sender, recipient, amount);
    }

    function requestPaymentByPhone(string memory phone, address recipient, uint256 amount) external {
        require(phoneToAddress[phone] == address(0), "Phone number already mapped to an address");
        phoneToAddress[phone] = recipient;
        emit PaymentRequested(msg.sender, recipient, amount);
    }

    function requestPaymentByUsername(string memory username, address recipient, uint256 amount) external {
        require(usernameToAddress[username] == address(0), "Username already mapped to an address");
        usernameToAddress[username] = recipient;
        emit PaymentRequested(msg.sender, recipient, amount);
    }

    function updateBalance(address recipient, uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        balances[recipient] += amount;
        emit PaymentReceived(msg.sender, recipient, amount);
    }

    function getBalance(address account) external view returns (uint256) {
        return balances[account];
    }

    function getTransactionCount(address account) external view returns (uint256) {
        return transactionCount[account];
    }

    function getTransaction(address account, uint256 index) external view returns (Transaction memory) {
        require(index < transactionCount[account], "Invalid transaction index");
        return transactions[account][index];
    }
}
