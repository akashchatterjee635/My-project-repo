// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    mapping(address => bool) private uniqueFunders;

    address public contractOwner;
    uint256 public MINIMUM_USD = 50 *1843; //As per 30th June 2023.
    uint256 public constant MINIMUM_WEI = 50 * 10 ** 18;
    
    constructor() {
        contractOwner = msg.sender;
    }

    function fund() public payable {
        require(msg.value >= MINIMUM_WEI, "You need to spend more ETH!");
        require(!uniqueFunders[msg.sender], "Address is already a funder.");

        uniqueFunders[msg.sender] = true;
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    modifier onlyOwner() {
        require(msg.sender == contractOwner, "You are not the contract owner.");
        _;
    }
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid new owner address.");
        contractOwner = newOwner;
    }
    
    
    function withdraw() public onlyOwner {
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
