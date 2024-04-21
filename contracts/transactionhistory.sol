// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransactionHistory {
    struct Transaction {
        address sender;
        address recipient;
        uint256 amount;
        uint256 timestamp;
    }

    Transaction[] public transactions;

    function addTransaction(address _sender, address _recipient, uint256 _amount) public {
        Transaction memory newTransaction = Transaction({
            sender: _sender,
            recipient: _recipient,
            amount: _amount,
            timestamp: block.timestamp
        });

        transactions.push(newTransaction);
    }

    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }

    function getTransaction(uint256 _index) public view returns (address, address, uint256, uint256) {
        require(_index < transactions.length, "Invalid transaction index");

        Transaction memory transaction = transactions[_index];
        return (transaction.sender, transaction.recipient, transaction.amount, transaction.timestamp);
    }
}
