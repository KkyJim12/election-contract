// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Election {

    // Admin address
    address payable public admin;

    // Initial contract function
    constructor() {
        admin = payable(msg.sender);
    }

    // User voting right
    mapping(address => uint256) public existRight;

    // Candidate structure
    struct Candidate {
        uint256 id;
        string fullName;
        uint256 voteCount;
    }

    // Candidate count
    uint256 candidateCount = 0;
    
    // Candidate lists
    Candidate[] public candidates;

    /**
     * Add candidate to blockchain storage
     *
     * @param _fullName candidate full name
     */
    function addCandidate(string memory _fullName) public {
        require(msg.sender == admin, "Only admin");

        candidateCount += 1;
        candidates.push(Candidate(candidateCount, _fullName, 0));
    }

    /**
     * Donate to get right for voting
     *
     */

    function donate() external payable {
        require(msg.value == 0.01 ether, "Must donate 0.01 ether");
        existRight[msg.sender] += 1;
    }

    /**
     * Vote to candidate
     *
     * @param _candidateId candidate id minus one to get array index
     */
    function vote(uint256 _candidateId) external {
        require(existRight[msg.sender] > 0, "Not enought vote right");
        candidates[_candidateId - 1].voteCount += 1;
    }
}
