// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {

    uint public numOfFunders;
    mapping(uint256 => address) private funders;

    receive() external payable {}

    function addFunds() external payable{
        uint index = numOfFunders++;
        funders[index] = msg.sender;
    }

    function getFundersAtIndex(uint8 index) external view returns(address){
        return funders[index];
    }

    function getAllFunders() external view returns(address[] memory){
        address[] memory _funders = new address[](numOfFunders);

        for(uint i = 0; i < numOfFunders; i++) {
            _funders[i] = funders[i];
        }

        return _funders;
    }
}

//instance.addFunds({from: accounts[0], values:"2"})