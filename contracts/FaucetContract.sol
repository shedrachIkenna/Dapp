// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    uint public numOfFunders;
    address public owner;

    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    constructor () {
        owner = msg.sender;
    }

   

    modifier limitWithdraw (uint withdrawAmount) {
        require(
            withdrawAmount < 1000000000000000000, 
            "You cannot withdraw more than 0.1 eth"
        );
        _;
    }

    receive() external payable {}

    function addFunds() external payable{
        address funder = msg.sender;
        if (!funders[funder]) { 
            uint index = numOfFunders++; // You can create a variable which is initialised to zero before its incremented to acheive the same result
            funders[funder] = true;
            lutFunders[index] = funder;
            // numOfFunders++; // Incrementing numOfFunders at the bottom of this block of code means the address of a funder is stored at index[0] before the increment happens 
        }
    }

    function withdraw(uint withdrawAmount) external limitWithdraw (withdrawAmount) {
        payable(msg.sender).transfer(withdrawAmount);
    }

    function getFunderAtIndex(uint8 index) external view returns(address){
        return lutFunders[index];
    }

    function getAllFunders() external view returns(address[] memory){
        address[] memory _funders = new address[](numOfFunders);

        for(uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }

        return _funders;
    }
}

// const instance = await Faucet.deployed()
// instance.addFunds({from: accounts[0], values:"2000000000000000000"})
// instance.addFunds({from: accounts[1], values:"2000000000000000000"})
// instance.withdraw("500000000000000000", {from: account[1]})
// instance.getFunderAtIndex(0)
// instance.getAllFunders()