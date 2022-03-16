// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CampaignFactory{
    address[] public deployedCampaigns;

    function createCampaign(uint minimum) public {
        Campaign newCampaign = new Campaign(minimum, payable(msg.sender));
        deployedCampaigns.push(address(newCampaign));
    }

    function getDeployedCampaigns() public view returns (address[] memory){
        return deployedCampaigns;
    }
}
contract Campaign {
    struct Request {
        string description;
        uint value;
        address payable recipient;
        bool complete;
        mapping(address => bool) approvals;
        uint approvalCount;
    }

    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversNumber;
    Request[] public requests;

    constructor (uint _minimumContribution, address payable creator) {
        manager = creator;
        minimumContribution = _minimumContribution;
    }

    function contribute () public payable {
        require(msg.value >= minimumContribution);
        approvers[msg.sender] = true;
        approversNumber++;
    }

    function createRequest (string memory description, uint value, address payable recipient) public restricted {
        Request storage newRequest = requests.push();
        newRequest.value = value;
        newRequest.recipient = recipient;
        newRequest.description = description;
        newRequest.approvalCount = 0;
    }

    function approveRequest (uint index) public {
        Request storage request = requests[index];
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        require(!request.complete);
        require(request.approvalCount * 2 > approversNumber);

        request.recipient.transfer(request.value);
        request.complete = true;

    }

    modifier restricted {
        require(msg.sender == manager);
        _;
    }

}