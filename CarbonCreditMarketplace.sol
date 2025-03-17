// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CarbonCreditMarketplace {
    struct CarbonCredit {
        uint256 id;
        string projectName;
        string description;
        uint256 amount;
        address owner;
    }

    uint256 public nextId;
    mapping(uint256 => CarbonCredit) public credits;

    event CreditIssued(uint256 id, string projectName, string description, uint256 amount, address owner);
    event CreditTransferred(uint256 id, address from, address to);

    function issueCredit(string memory projectName, string memory description, uint256 amount) public {
        credits[nextId] = CarbonCredit(nextId, projectName, description, amount, msg.sender);
        emit CreditIssued(nextId, projectName, description, amount, msg.sender);
        nextId++;
    }

    function transferCredit(uint256 id, address to) public {
        require(credits[id].owner == msg.sender, "Only owner can transfer");
        credits[id].owner = to;
        emit CreditTransferred(id, msg.sender, to);
    }

    function getCreditDetails(uint256 id) public view returns (CarbonCredit memory) {
        return credits[id];
    }
}
