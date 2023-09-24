// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {

    struct Voter {
        address voterId;
        bool isRegistered;
        bool hasVoted;
    }

    mapping(address => Voter) public voters;
    Voter[] votersList;

    function registerVoter() public {
        require(!voters[msg.sender].isRegistered, "You are already registered.");
        voters[msg.sender].isRegistered = true;
    }

    function vote() public {
        require(voters[msg.sender].isRegistered, "You are not registered to vote.");
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        
        voters[msg.sender].hasVoted = true;
        votersList.push(Voter(msg.sender, voters[msg.sender].isRegistered, voters[msg.sender].hasVoted));
    }

    function getVotersList() public view returns (Voter[] memory) {
        return votersList;
    }

}