// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    uint public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

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
// instance.addFunds({from: accounts[0], values:"200000000"})
// instance.addFunds({from: accounts[1], values:"200000000"})
// instance.getFunderAtIndex(0)
// instance.getAllFunders()