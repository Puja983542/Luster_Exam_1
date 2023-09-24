// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TODOListDApp {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do any action.");
        _;
    }

    struct TodoItem {
        uint256 id;
        string text;
        uint256 priority;
        bool isCompleted;
    }

    mapping(uint256 => TodoItem) public todoItems;
    uint256 public itemCount;
    event ItemAdded(uint256 id, string text, uint8 priority);
    event ItemCompleted(uint256 id);
    event ItemDeleted(uint256 id);

    function addItem(string memory _text, uint8 _priority) public onlyOwner {
        itemCount++;
        todoItems[itemCount] = TodoItem(itemCount, _text, _priority, false);
        emit ItemAdded(itemCount, _text, _priority);
    }

    function completeItem(uint256 _id) public onlyOwner {
        require(_id <= itemCount && _id > 0, "Invalid item ID");
        todoItems[_id].isCompleted = true;
        emit ItemCompleted(_id);
    }

    function deleteItem(uint256 _id) public onlyOwner {
        require(_id <= itemCount && _id > 0, "Invalid item ID");
        delete todoItems[_id];
        emit ItemDeleted(_id);
    }
}