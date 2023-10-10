// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract fundMe{
    uint256 public minimumUsd=50;
    address[] public funders;
    mapping(address => bool) private uniqueFunders;
    mapping(address=>uint256) public addressToAmountFunded;
    address public contractOwner;
    constructor() {
        contractOwner = msg.sender;
    }
    
    function fund() public payable{
        require(getConversionRate(msg.value)>=minimumUsd,"Didn't send enough");
        //18 decimals
        require(!uniqueFunders[msg.sender], "Address is already a funder.");

        uniqueFunders[msg.sender] = true;
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+=msg.value;
    }
    modifier onlyOwner() {
        require(msg.sender == contractOwner, "You are not the contract owner.");
        _;
    }
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid new owner address.");
        contractOwner = newOwner;
    }
    function getPrice() public view returns(uint256){
        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface pricefeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=pricefeed.latestRoundData();
        return uint256(price*1e10);//typecasting to uint256
        //ETH in USD
    }
    function getVersion() public view returns(uint256){
        AggregatorV3Interface pricefeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return pricefeed.version();
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice+ethAmount)/1e18;
        return ethAmountInUsd;

    }
    function withdraw() public onlyOwner{
        for(uint256 funderIndex=0;funderIndex< funders.length; funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;

        }
        //Actually Withdraw the funds.
        funders=new address[](0);
        //reset the array.
        //send ETH.
        (bool callsuccess, )=payable(msg.sender).call{value:address(this).balance}("");
        require(callsuccess,"Call Failed");
    }

    


}
